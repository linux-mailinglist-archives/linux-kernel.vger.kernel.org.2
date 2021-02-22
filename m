Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6CE32200B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhBVTXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:23:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233016AbhBVTQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:16:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9596D64E31;
        Mon, 22 Feb 2021 19:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614020887;
        bh=0iXDwSFE0l7X7i5uwg4J4i7IsMti3m0+Zo64C0wFYWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DCjRqWbnZJdBgK6c57YUhZ+RhW6pzrW5IE5MBD+uC+8gRvoSiUSDNvWBPIlzZtUFF
         cIy7FodUflGNCBs8STHoHU7gLn0BG4tzE2all7fRfSeYdBgwnsJpreOYBGR4ER2shr
         ShTglOoHyVx66KMMz6eI5TQmOZ85cCjkJYM4Qj51IdIMcoDirs/RbV6tPvgDrm0TKj
         2XAS3NiTK7Dh7HyooE5t17bYnKZrSZqui2yK+auejSUE2xAVE0IqBwadaa4yPFxEI/
         yihbqDs/wRLYrm+iG7QG4Y9rl0OBMkB4Il8BYEM+/b3wNDYtL/78gZlPOmWqZik/Gn
         I6CdqWnegeTHQ==
Date:   Mon, 22 Feb 2021 12:08:06 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>, qemu-devel@nongnu.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
Message-ID: <20210222190806.GA41637@24bbad8f3778>
References: <20210211194258.4137998-1-nathan@kernel.org>
 <CAKwvOdkJfJ+LDspz04tsjd=55LxF5rgTOAXt0cPxTyCCUBqgBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkJfJ+LDspz04tsjd=55LxF5rgTOAXt0cPxTyCCUBqgBw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 11:02:34AM -0800, Nick Desaulniers wrote:
> Did this happen to get picked up already? EOM

I have not gotten an email saying it has been picked up nor does it
appear to be in -next.

Cheers,
Nathan

> On Thu, Feb 11, 2021 at 11:43 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > fw_cfg_showrev() is called by an indirect call in kobj_attr_show(),
> > which violates clang's CFI checking because fw_cfg_showrev()'s second
> > parameter is 'struct attribute', whereas the ->show() member of 'struct
> > kobj_structure' expects the second parameter to be of type 'struct
> > kobj_attribute'.
> >
> > $ cat /sys/firmware/qemu_fw_cfg/rev
> > 3
> >
> > $ dmesg | grep "CFI failure"
> > [   26.016832] CFI failure (target: fw_cfg_showrev+0x0/0x8):
> >
> > Fix this by converting fw_cfg_rev_attr to 'struct kobj_attribute' where
> > this would have been caught automatically by the incompatible pointer
> > types compiler warning. Update fw_cfg_showrev() accordingly.
> >
> > Fixes: 75f3e8e47f38 ("firmware: introduce sysfs driver for QEMU's fw_cfg device")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1299
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  drivers/firmware/qemu_fw_cfg.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> > index 0078260fbabe..172c751a4f6c 100644
> > --- a/drivers/firmware/qemu_fw_cfg.c
> > +++ b/drivers/firmware/qemu_fw_cfg.c
> > @@ -299,15 +299,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > -static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
> > +static ssize_t fw_cfg_showrev(struct kobject *k, struct kobj_attribute *a,
> > +                             char *buf)
> >  {
> >         return sprintf(buf, "%u\n", fw_cfg_rev);
> >  }
> >
> > -static const struct {
> > -       struct attribute attr;
> > -       ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
> > -} fw_cfg_rev_attr = {
> > +static const struct kobj_attribute fw_cfg_rev_attr = {
> >         .attr = { .name = "rev", .mode = S_IRUSR },
> >         .show = fw_cfg_showrev,
> >  };
> >
> > base-commit: 92bf22614b21a2706f4993b278017e437f7785b3
> > --
> > 2.30.1
> >
