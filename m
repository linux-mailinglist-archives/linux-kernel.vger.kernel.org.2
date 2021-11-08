Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DA4447A41
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 06:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhKHF6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 00:58:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235773AbhKHF62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 00:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636350943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fzvPwnGXA3h5EZi2ibTfew9w6/2FA8/r0v3M/EP4Gh0=;
        b=KERFeUo0r5/LJzXJs4qDvsbtKNsc8JQ9F2kTeLULWY3LEq2y5NUiLO5MiazojHo8ssch+Y
        GUK5NQx+b4i/R+Y7QS9nEmwjj6V0BDthy8+lXuaPyG/5FgcKBcGB97y1BFuJV5Nm6fjYMy
        n8QUwmCcw50fZuKU5VLkmXluXzjODl4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-HyxtcSOkPLSOLC8Ctau9IA-1; Mon, 08 Nov 2021 00:55:42 -0500
X-MC-Unique: HyxtcSOkPLSOLC8Ctau9IA-1
Received: by mail-lj1-f200.google.com with SMTP id n17-20020a2e8791000000b0021896c29706so4362304lji.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 21:55:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzvPwnGXA3h5EZi2ibTfew9w6/2FA8/r0v3M/EP4Gh0=;
        b=j007xPwOvQ2ew2lNr7ksOELT0hE5L+sL5yPXbOKantIUUmn5Kh1PrGan2O2KUkxZTR
         TZurJU9gWHUq4m594lIAaJDa6BWhlebgbqUKo+5gwlHqR8vXvWP7tus2UVfkm+l4Z1TJ
         4x8e/ewnQjiSKSwZ5/8dPqNr+dQfT3FDq/3dFsAN6OJmbBVs6PMCXkrVSTa2eLgVR1OT
         UvMl6a8OyypNPlLRtACbJhf5ZX+lLL0i4Ir0s5TW0wKwJsCg+2b2O/HM8KqAmiqGKG5v
         3G0JZWkEeZck9xbk+Mch9YHlPT3h9cNIP79fgrLi/1ieO/IkRN1o/6TGufskWzEBCJcF
         fxrg==
X-Gm-Message-State: AOAM530KfX0XFIjKak3sewPUe/LE6pg3yKoNQEPm4WX7oN7n9IaEZH41
        ctbpPKv/8a4oN6Z7m4P55VK04eeYBHX6yLPyfnR6ypwaBd88Xk1ZV88nJhivdBTmfi6m3T6cvSO
        I5c1eUSHlBBuv0HWl+qkGMGi8iaQoo3pc1Dto6+Ut
X-Received: by 2002:a2e:3012:: with SMTP id w18mr6836787ljw.217.1636350941015;
        Sun, 07 Nov 2021 21:55:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3lSpSSMCv7dMxS5lq0/3OAj+jWYK7U1ch54eUhXxUZl6MgULvuouLWNTS6gkZZ90PPE2R4k32ct3AcZUdXTU=
X-Received: by 2002:a2e:3012:: with SMTP id w18mr6836770ljw.217.1636350940870;
 Sun, 07 Nov 2021 21:55:40 -0800 (PST)
MIME-Version: 1.0
References: <f6b2d087ca3840604b4e711a208d35b5d6285cb4.1636301587.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <f6b2d087ca3840604b4e711a208d35b5d6285cb4.1636301587.git.christophe.jaillet@wanadoo.fr>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 8 Nov 2021 13:55:30 +0800
Message-ID: <CACGkMEvN0cgFQhJmLF3xDXHt_EyZ-TnfBM8CnpNwA9sKcwpzBg@mail.gmail.com>
Subject: Re: [PATCH 1/2] eni_vdpa: Fix an error handling path in 'eni_vdpa_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mst <mst@redhat.com>, Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 12:15 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> In the error handling path, a successful 'vp_legacy_probe()' should be
> balanced by a corresponding 'vp_legacy_remove()' call, as already done in
> the remove function.
>
> Add the missing call and update gotos accordingly.
>
> Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> index 3f788794571a..12b3db6b4517 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -501,7 +501,7 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>         if (!eni_vdpa->vring) {
>                 ret = -ENOMEM;
>                 ENI_ERR(pdev, "failed to allocate virtqueues\n");
> -               goto err;
> +               goto err_remove_vp_legacy;
>         }
>
>         for (i = 0; i < eni_vdpa->queues; i++) {
> @@ -513,11 +513,13 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>         ret = vdpa_register_device(&eni_vdpa->vdpa, eni_vdpa->queues);
>         if (ret) {
>                 ENI_ERR(pdev, "failed to register to vdpa bus\n");
> -               goto err;
> +               goto err_remove_vp_legacy;
>         }
>
>         return 0;
>
> +err_remove_vp_legacy:
> +       vp_legacy_remove(&eni_vdpa->ldev);

Won't vp_legacy_remove() be triggered by the put_devic() below?

Thanks

>  err:
>         put_device(&eni_vdpa->vdpa.dev);
>         return ret;
> --
> 2.30.2
>

