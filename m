Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D408A3204F0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 12:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhBTLBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 06:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhBTLBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 06:01:02 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92395C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 03:00:22 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id v206so8156630qkb.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 03:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+MmfP0UEIaM34M083O5vR1KagrZ87TZKkla5El07xno=;
        b=bZJbxzekqWW3/HUlJ99gHdFwErx6Lu19YWJhwgLGZ7Mnd/iAv0gkcfJ97UsWwgYHIf
         EtmUb0sCqMUEKWsvAjxhME2JW4ytnSoox4UrqVSFTuwik4w7vrYn+AfmP/0GDFE+q8Ho
         A9t4zsqQvd3lwaZaN5XfBBPI5ON89C8he330NcBoyOUcB4VfsDKUcMi3oqRER4IeDbg8
         gsSYSuv2kwMLqa3prxxLTpJ6C28XUbg4uWAxHEeOzV5MKSQlELkyEXWUhJZaOBQe14Zx
         eT01XBOgMTb7lwQTi2SQBwSNSFchv0nGPudga1iBU0azDnj6vV0yS62wjCfP3sdmU3v7
         WKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+MmfP0UEIaM34M083O5vR1KagrZ87TZKkla5El07xno=;
        b=KLt3aG0k6BcTMI8macfXx00wlxA2k3Cs0qIHe0PIbDsYkNeLIFR202Osf6WedzhdMz
         59CmpdsE7DQ1gHAv9kYY8pRtdyvZNd620BWxSLQZthCfEy5jYMpVyoNQjqAoW56XFSHf
         uj8gQ3nXD8Mf4Q5ZKpb01dimRUFBouEPvCeh9iVzkeFW1iZcaY1VBCzULXXjtDUaSvYD
         0Al49V9VQntBrfmJcIOGT5dUgqj6V1/ywmzZd2SNGSQMvIGQv43F0HGII2i2eZCVPtDZ
         UmVDuhBvEfFL48LSYl4u3jvC7ryI1E60P+/OMYKpBrBSulL3OLAPo50TLWk4mlTrqxYk
         b7SA==
X-Gm-Message-State: AOAM530lAkuOoC38qT1o7rZBo/4wnlqiWOl8jphKh1xNcqPJukXo5T5I
        fz0HJCt5xr8NFCWP+uoACwAV0z9Y26a3Vno7NRM=
X-Google-Smtp-Source: ABdhPJyjmi3yOphbKMo3iCPzqekNRAa0kxAP/bFBYdZXMACyqmFV6xWNyc062iLd8bzzMHu6cWV/gIlQ98Jf5Dt8YZI=
X-Received: by 2002:a37:6116:: with SMTP id v22mr13531736qkb.38.1613818821493;
 Sat, 20 Feb 2021 03:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20210219092612.7533-1-yejune.deng@gmail.com> <20210220094842.GB30008@shuo-intel.sh.intel.com>
In-Reply-To: <20210220094842.GB30008@shuo-intel.sh.intel.com>
From:   Yejune Deng <yejune.deng@gmail.com>
Date:   Sat, 20 Feb 2021 19:00:10 +0800
Message-ID: <CABWKuGXT25bZQT3Ct7eEHsQYrWcfq3kuB6stWh5-MDgDRWNFTw@mail.gmail.com>
Subject: Re: [PATCH] virt: acrn: Use vfs_poll() instead of f_op->poll()
To:     Shuo A Liu <shuo.a.liu@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK=EF=BC=8CI will adopt it and resubmit.


On Sat, Feb 20, 2021 at 5:48 PM Shuo A Liu <shuo.a.liu@intel.com> wrote:
>
> Thanks for the patch.
>
> On Fri 19.Feb'21 at 17:26:12 +0800, Yejune Deng wrote:
> >In acrn_irqfd_assign(), use vfs_poll() is a more advanced function,
> >as the same time, modify the definition of events.
> >
> >Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> >---
> > drivers/virt/acrn/irqfd.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
> >index a8766d528e29..19890396e174 100644
> >--- a/drivers/virt/acrn/irqfd.c
> >+++ b/drivers/virt/acrn/irqfd.c
> >@@ -112,9 +112,9 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, str=
uct acrn_irqfd *args)
> > {
> >       struct eventfd_ctx *eventfd =3D NULL;
> >       struct hsm_irqfd *irqfd, *tmp;
> >-      unsigned int events;
> >       struct fd f;
> >       int ret =3D 0;
> >+      __poll_t events;
>
> Can you keep variable declarations is reverse fir tree order which this
> driver follows?
>
> >
> >       irqfd =3D kzalloc(sizeof(*irqfd), GFP_KERNEL);
> >       if (!irqfd)
> >@@ -158,7 +158,7 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, str=
uct acrn_irqfd *args)
> >       mutex_unlock(&vm->irqfds_lock);
> >
> >       /* Check the pending event in this stage */
> >-      events =3D f.file->f_op->poll(f.file, &irqfd->pt);
> >+      events =3D vfs_poll(f.file, &irqfd->pt);
> >
> >       if (events & POLLIN)
> >               acrn_irqfd_inject(irqfd);
> >--
> >2.29.0
> >
