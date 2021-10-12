Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FA8429D72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhJLGFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 02:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbhJLGFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:05:25 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEA1C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 23:03:13 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n7so13565657iod.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 23:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+7aPzNJtII1336x9PZ93O1J12OEBlr516bC0jjHtfA=;
        b=evRelUUN+ob8U7+qNCBffGX/v+NPxEOvvw/qBAkEoohKZ8Tvcr8W1uNowd6wEeAJn9
         LIEIMWPe7wM12PlnkRGeDrh+FglVJzfXqAVHscsF+By4fhkTRYL7hChN9ctQUPr9KZ35
         mfFL9L0HAr69nrpHyg50XfZv1hxRia5d3ahJ/IQ5qTB0l4jNRnV60gOafT8liiPeA6YE
         HS8Y1/kkxlfgxfCDfZHN48883zbC9Yz4KZoMDHLUCFC5ONxspVtAliuEibQHApia1eHl
         QJ+McoXSldP/PzL56NoXIl+qpv077uNNqcKpcCYIBZ2xLGragDCOLBOOBueltL9OXPfn
         +6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+7aPzNJtII1336x9PZ93O1J12OEBlr516bC0jjHtfA=;
        b=kPB9uZjKqUt94ilnaYWSKcvlanJZUo0yGQNxQVICjLxpmqbXgn1owVPKbX5POqubqY
         JNQuqpi6qs65EdA7FcV45aB24E6airc/Tkj+HfWwO+Et2e6VxB4MFt7AuHzH0FbWBfh8
         YMQ55hvp1JOFIDjIb7529bZnRcXadUWW4/wPpJRSGEL7PYZ/ePNx22iP4Kq/T3diMK+0
         c2svxf1TV2Uh/oFn0KtQ+xX1r+li8zblnOP78EKYNN3juioEjiqdJWZeVilS4ApUbVv2
         JAvVac9ws1mYWilf7DLHeSYOzWu9132gBp6oWDNhMeoaARGswkR+Q6QpNWKwavl8HEKg
         HTGA==
X-Gm-Message-State: AOAM530gm1ZKR4RMJQ+GzrAvCINIg0uHHi8OlzctRD5C5IEMuNHaLL6S
        6u9RL6qCyyIXmmLjN3kpoMbMyUXNy84Vx5Wio6Q=
X-Google-Smtp-Source: ABdhPJxn6Fo5mvRxLgjOoz8tCevc84MTHudNBLPA9klwXomm8fBwrEQ3ddhHkhPK27GV3H7OUOzFp8uUV9llz0ITlKE=
X-Received: by 2002:a05:6602:140d:: with SMTP id t13mr9598815iov.120.1634018592437;
 Mon, 11 Oct 2021 23:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211012032333.184581-1-davidcomponentone@gmail.com> <bcf19290a2ed959fdf8d80a3668a19e79c87ca7f.camel@perches.com>
In-Reply-To: <bcf19290a2ed959fdf8d80a3668a19e79c87ca7f.camel@perches.com>
From:   David Yang <davidcomponentone@gmail.com>
Date:   Tue, 12 Oct 2021 14:03:00 +0800
Message-ID: <CA+E=9oto+8PptNNSzwkwrRd+_Ty4GpeyxE=xAggTa140pJxk9A@mail.gmail.com>
Subject: Re: [PATCH virt-pci] Fix application of sizeof to pointer
To:     Joe Perches <joe@perches.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm agree with you. Using the "buf->data" instead is better.


On Mon, Oct 11, 2021 at 08:48:27PM -0700, Joe Perches wrote:
> On Tue, 2021-10-12 at 11:23 +0800, davidcomponentone@gmail.com wrote:
> > From: David Yang <davidcomponentone@gmail.com>
> >
> > The coccinelle check report:
> > "./arch/um/drivers/virt-pci.c:192:20-26:
> > ERROR: application of sizeof to pointer"
> > Using the "sizeof(buf->data)" to fix it.
> []
> > diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> []
> > @@ -189,7 +189,7 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
> >     buf = get_cpu_var(um_pci_msg_bufs);
> >     data = buf->data;
> >
> > -   memset(data, 0xff, sizeof(data));
> > +   memset(data, 0xff, sizeof(buf->data));
>
> Perhaps change this to:
>
>       memset(buf->data, 0xff, sizeof(buf->data));
>       data = buf->data;
>
> but honestly, the indirection to data doesn't make the code
> much more readable so maybe just remove data altogether.
> ---
>  arch/um/drivers/virt-pci.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> index c080666330234..75e05ead97b9a 100644
> --- a/arch/um/drivers/virt-pci.c
> +++ b/arch/um/drivers/virt-pci.c
> @@ -180,7 +180,6 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
>       };
>       /* buf->data is maximum size - we may only use parts of it */
>       struct um_pci_message_buffer *buf;
> -     u8 *data;
>       unsigned long ret = ~0ULL;
>
>       if (!dev)
> @@ -189,7 +188,7 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
>       buf = get_cpu_var(um_pci_msg_bufs);
>       data = buf->data;
>
> -     memset(data, 0xff, sizeof(data));
> +     memset(buf->data, 0xff, sizeof(buf->data));
>
>       switch (size) {
>       case 1:
> @@ -204,22 +203,22 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
>               goto out;
>       }
>
> -     if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, 8))
> +     if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, buf->data, 8))
>               goto out;
>
>       switch (size) {
>       case 1:
> -             ret = data[0];
> +             ret = buf->data[0];
>               break;
>       case 2:
> -             ret = le16_to_cpup((void *)data);
> +             ret = le16_to_cpup((void *)buf->data);
>               break;
>       case 4:
> -             ret = le32_to_cpup((void *)data);
> +             ret = le32_to_cpup((void *)buf->data);
>               break;
>  #ifdef CONFIG_64BIT
>       case 8:
> -             ret = le64_to_cpup((void *)data);
> +             ret = le64_to_cpup((void *)buf->data);
>               break;
>  #endif
>       default:
>
>
