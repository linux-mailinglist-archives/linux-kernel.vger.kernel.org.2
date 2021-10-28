Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDE943F23B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 00:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhJ1WEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 18:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhJ1WEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 18:04:41 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D54C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:02:14 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id g8so8774828iob.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cAUfcAe3Jj+ZgiUsUMXUNLPYmOEvfHfG17Tv93fVfCk=;
        b=I5p9ChNAuXMXxTmFen8/Vg9dIWijeLn43L+Xq5yryCRDSlkpwmGeMZ5B9kL/ndQt1g
         1OFkUdtoRkPcAJW2cO7H8Kw5xKWD4dyxT4UAerGHIZzCJWRj+HPTr+oTx16WBeaJHY7C
         MqtnY32DCNs7s3gUfFjsU20XNqiSj9AJeZNvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cAUfcAe3Jj+ZgiUsUMXUNLPYmOEvfHfG17Tv93fVfCk=;
        b=vgAF16TJeN+MQ2Rl4vhjxcN9glWZAHAtpF+x4y1InLamBqGsltgun4GIJCB2st+h9u
         Omf1+fePz5YBmQ6vQGpOE9EFICVZmqWK4oS327Lu/w7sHDye5pkAnPbinuiKd8pgYkHB
         zhMJeNo7K0D4PWK5mmGZ4zhZgakDXBkYwWMpxWLNb7EargRFYsGj7w+VoygD4yKxpfE9
         sAiW0CdV4B7ioyU6Cgc6bUziwwLnLBNjEV5g6pTUNZ2o9cP9kFllRkfos+o7e0YHKq7v
         jqicMpFdqwEN5PnaqSoxCMppGEBmHLcmWwlV83tv3+NH7rkoG7Ged1D9SFUt0ERyK20s
         tj8Q==
X-Gm-Message-State: AOAM531yp13bbdf5KIz4wKUXKGGjEpBEc3DmuKiKe2ofohoXlBDOWowA
        3KjwZj8LhLvL9Jo5DwPawr6zAfu8WfcZvQ==
X-Google-Smtp-Source: ABdhPJyRT3HtNq5+UvrOEE8Wb19e3lmihjTNPWZuioN/h2rqaRHHfKrSpROFyzGDtjKpKlcvnIs/ew==
X-Received: by 2002:a6b:e212:: with SMTP id z18mr5007571ioc.180.1635458532705;
        Thu, 28 Oct 2021 15:02:12 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id f15sm1384827iob.8.2021.10.28.15.02.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 15:02:12 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id h2so8506913ili.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:02:11 -0700 (PDT)
X-Received: by 2002:a05:6e02:2169:: with SMTP id s9mr5115924ilv.27.1635458531194;
 Thu, 28 Oct 2021 15:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211028140833.1.Ie6bd5a232f770acd8c9ffae487a02170bad3e963@changeid>
 <CAE-0n521q5uLms+qWO=ibQVRyTwsCRwPSPRvpncq_mgTVd0Bpg@mail.gmail.com>
In-Reply-To: <CAE-0n521q5uLms+qWO=ibQVRyTwsCRwPSPRvpncq_mgTVd0Bpg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Oct 2021 15:01:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UCu-GaS3q9SgvxV-=qOgBXsDHDOEwMb8k1A-4i-YS9HQ@mail.gmail.com>
Message-ID: <CAD=FV=UCu-GaS3q9SgvxV-=qOgBXsDHDOEwMb8k1A-4i-YS9HQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/gdb: Handle split debug for vmlinux
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes.berg@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 28, 2021 at 3:00 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2021-10-28 14:08:49)
> > This is related to two previous changes. Commit dfe4529ee4d3
> > ("scripts/gdb: find vmlinux where it was before") and commit
> > da036ae14762 ("scripts/gdb: handle split debug").
> >
> > Although Chrome OS has been using the debug suffix for modules for a
> > while, it has just recently started using it for vmlinux as well. That
> > means we've now got to improve the detection of "vmlinux" to also
> > handle that it might end with ".debug".
> >
> > Cc: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  scripts/gdb/linux/symbols.py | 3 ++-
> >  scripts/gdb/vmlinux-gdb.py   | 0
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >  mode change 100644 => 100755 scripts/gdb/vmlinux-gdb.py
> >
> > diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> > index 08d264ac328b..46f7542db08c 100644
> > --- a/scripts/gdb/linux/symbols.py
> > +++ b/scripts/gdb/linux/symbols.py
> > @@ -148,7 +148,8 @@ lx-symbols command."""
> >          # drop all current symbols and reload vmlinux
> >          orig_vmlinux = 'vmlinux'
> >          for obj in gdb.objfiles():
> > -            if obj.filename.endswith('vmlinux'):
> > +            if (obj.filename.endswith('vmlinux') or
> > +                obj.filename.endswith('vmlinux.debug')):
>
> Looks good.
>
> >                  orig_vmlinux = obj.filename
> >          gdb.execute("symbol-file", to_string=True)
> >          gdb.execute("symbol-file {0}".format(orig_vmlinux))
> > diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
> > old mode 100644
> > new mode 100755
>
> Is this mode change important?

Ah, shoot. While I was debugging what could have gone wrong, I changed
it and I didn't notice that it had made it into the commit. Let me do
a quick v2. Thanks for catching!

-Doug
