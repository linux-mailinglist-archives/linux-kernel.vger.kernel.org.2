Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4C038D503
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhEVKIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhEVKIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:08:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE5BC061574;
        Sat, 22 May 2021 03:06:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso8506949pji.0;
        Sat, 22 May 2021 03:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvDIbtN9K/GXWA2yy/iHLYNnz9SQ94SbF46Utkb5PLE=;
        b=mvblMSaOebG8oKYK+nUMKMiRdKIKdqQapjXT25TgLYBHpIKl50Q2SddqMdbZTGzte6
         gccJzaqEnZ7NMbCiEF8Kj8xe5QaotnXZuT69DUEO2Ft6dFgLwi4/JxYvSTmMRfLJv2Py
         iOU36EnjtZDy+L9H54wOfPcdP7j0x3gFqAJbgurzIEAGoscbqhHB9Tl3XGaEbYVlmd43
         B25SQh9HozWi2rB9GM9ZcL1A8nv5TyBfjupI6+66D0LUKal8x3b4wm5TuiQhJSsOWeOA
         UeK8neO1Ex9awSpEet3oOBsJP2L3LWTfKi2YHwXlgUQC2FNSojpy47XTU/pT/s6znbvQ
         o0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvDIbtN9K/GXWA2yy/iHLYNnz9SQ94SbF46Utkb5PLE=;
        b=P8DsiWP1WAT/LMWm8/la8klqanrYchz53/uxkavjkCvvb5r7EkZvqYWCv1yNHZYTlW
         5HvjNUbmaixaYBMaHmNUXR22F2wGFVIJXd2o6t/BZUwX7X2BrRJtYbLkmUqkW+CzfwWo
         /dgsw4NEiLjQ7g4R84tNdOexU9QRRSYVkNe1HbWRIWZ2eWo1AQCHX6V2BT1YTN9+jJVC
         JCSB05nqK++nqpYb2u2YkLVhAZC/m/ejbjV4Ber3aWEzYmcxDguQ8SA637wJ28i4UbHq
         qyD482vMCMkiSzLgJ2xcffVd0QbzZrykIywyhen1Nnr56vSrisitfQ+spGK+VsnlcC70
         OGLA==
X-Gm-Message-State: AOAM533n7WW48HvPj37cBonz1tx4RFV3lmUgaBw8LxWC0gmgFPoQH71y
        LDwIOaGO33Iq6AdepD5A07LzOtbImMuTBO8Cg34=
X-Google-Smtp-Source: ABdhPJy9ITgEGc8I2geiKSGcnyElXuICyPXzoOwutqsK36I1ZzNow8CFQTr0ZWneNneEdZl3VAeQ0nbO5ngNu1PIqHM=
X-Received: by 2002:a17:902:b18c:b029:f4:67e6:67af with SMTP id
 s12-20020a170902b18cb02900f467e667afmr16565027plr.17.1621678014049; Sat, 22
 May 2021 03:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621665058.git.christophe.jaillet@wanadoo.fr> <9212cdc8c1e5c187a2f1129a6190085c2a10d28a.1621665058.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <9212cdc8c1e5c187a2f1129a6190085c2a10d28a.1621665058.git.christophe.jaillet@wanadoo.fr>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 22 May 2021 13:06:37 +0300
Message-ID: <CAHp75VdhgEEeOoJZNXu9RMR0QppDv7HZ-_Lmy4PC=ptXHaz_Lw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] misc/pvpanic: Make 'pvpanic_probe()' resource managed
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        pizhenwei@bytedance.com, Paolo Bonzini <pbonzini@redhat.com>,
        bobo.shaobowang@huawei.com, linqiheng@huawei.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 9:56 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Simplify code and turn 'pvpanic_probe()' into a managed resource version.
> This simplify callers that don't need to do some clean-up on error in the
> probe and on remove.
>
> Update pvpanic-mmio.c and pvpanic-pci.c accordingly.
>
> 'pvpanic_remove()' don't need to be exported anymore.

LGTM, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> Compile tested only
> ---
>  drivers/misc/pvpanic/pvpanic-mmio.c | 14 +-------------
>  drivers/misc/pvpanic/pvpanic-pci.c  | 13 +------------
>  drivers/misc/pvpanic/pvpanic.c      | 30 ++++++++++++++---------------
>  drivers/misc/pvpanic/pvpanic.h      |  3 +--
>  4 files changed, 18 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
> index d4a407956c07..be4016084979 100644
> --- a/drivers/misc/pvpanic/pvpanic-mmio.c
> +++ b/drivers/misc/pvpanic/pvpanic-mmio.c
> @@ -104,18 +104,7 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
>         pi->capability &= ioread8(base);
>         pi->events = pi->capability;
>
> -       dev_set_drvdata(dev, pi);
> -
> -       return pvpanic_probe(pi);
> -}
> -
> -static int pvpanic_mmio_remove(struct platform_device *pdev)
> -{
> -       struct pvpanic_instance *pi = dev_get_drvdata(&pdev->dev);
> -
> -       pvpanic_remove(pi);
> -
> -       return 0;
> +       return devm_pvpanic_probe(dev, pi);
>  }
>
>  static const struct of_device_id pvpanic_mmio_match[] = {
> @@ -138,6 +127,5 @@ static struct platform_driver pvpanic_mmio_driver = {
>                 .dev_groups = pvpanic_mmio_dev_groups,
>         },
>         .probe = pvpanic_mmio_probe,
> -       .remove = pvpanic_mmio_remove,
>  };
>  module_platform_driver(pvpanic_mmio_driver);
> diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
> index 3d7f9efb3dd4..a43c401017ae 100644
> --- a/drivers/misc/pvpanic/pvpanic-pci.c
> +++ b/drivers/misc/pvpanic/pvpanic-pci.c
> @@ -73,7 +73,6 @@ ATTRIBUTE_GROUPS(pvpanic_pci_dev);
>  static int pvpanic_pci_probe(struct pci_dev *pdev,
>                              const struct pci_device_id *ent)
>  {
> -       struct device *dev = &pdev->dev;
>         struct pvpanic_instance *pi;
>         void __iomem *base;
>         int ret;
> @@ -97,23 +96,13 @@ static int pvpanic_pci_probe(struct pci_dev *pdev,
>         pi->capability &= ioread8(base);
>         pi->events = pi->capability;
>
> -       dev_set_drvdata(dev, pi);
> -
> -       return pvpanic_probe(pi);
> -}
> -
> -static void pvpanic_pci_remove(struct pci_dev *pdev)
> -{
> -       struct pvpanic_instance *pi = dev_get_drvdata(&pdev->dev);
> -
> -       pvpanic_remove(pi);
> +       return devm_pvpanic_probe(&pdev->dev, pi);
>  }
>
>  static struct pci_driver pvpanic_pci_driver = {
>         .name =         "pvpanic-pci",
>         .id_table =     pvpanic_pci_id_tbl,
>         .probe =        pvpanic_pci_probe,
> -       .remove =       pvpanic_pci_remove,
>         .driver = {
>                 .dev_groups = pvpanic_pci_dev_groups,
>         },
> diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
> index 793ea0c01193..82770a088d62 100644
> --- a/drivers/misc/pvpanic/pvpanic.c
> +++ b/drivers/misc/pvpanic/pvpanic.c
> @@ -61,22 +61,10 @@ static struct notifier_block pvpanic_panic_nb = {
>         .priority = 1, /* let this called before broken drm_fb_helper */
>  };
>
> -int pvpanic_probe(struct pvpanic_instance *pi)
> -{
> -       if (!pi || !pi->base)
> -               return -EINVAL;
> -
> -       spin_lock(&pvpanic_lock);
> -       list_add(&pi->list, &pvpanic_list);
> -       spin_unlock(&pvpanic_lock);
> -
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(pvpanic_probe);
> -
> -void pvpanic_remove(struct pvpanic_instance *pi)
> +static void pvpanic_remove(void *param)
>  {
>         struct pvpanic_instance *pi_cur, *pi_next;
> +       struct pvpanic_instance *pi = param;
>
>         if (!pi)
>                 return;
> @@ -90,7 +78,19 @@ void pvpanic_remove(struct pvpanic_instance *pi)
>         }
>         spin_unlock(&pvpanic_lock);
>  }
> -EXPORT_SYMBOL_GPL(pvpanic_remove);
> +
> +int devm_pvpanic_probe(struct device *dev, struct pvpanic_instance *pi)
> +{
> +       if (!pi || !pi->base)
> +               return -EINVAL;
> +
> +       spin_lock(&pvpanic_lock);
> +       list_add(&pi->list, &pvpanic_list);
> +       spin_unlock(&pvpanic_lock);
> +
> +       return devm_add_action_or_reset(dev, pvpanic_remove, pi);
> +}
> +EXPORT_SYMBOL_GPL(devm_pvpanic_probe);
>
>  static int pvpanic_init(void)
>  {
> diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
> index 1afccc2e9fec..493545951754 100644
> --- a/drivers/misc/pvpanic/pvpanic.h
> +++ b/drivers/misc/pvpanic/pvpanic.h
> @@ -15,7 +15,6 @@ struct pvpanic_instance {
>         struct list_head list;
>  };
>
> -int pvpanic_probe(struct pvpanic_instance *pi);
> -void pvpanic_remove(struct pvpanic_instance *pi);
> +int devm_pvpanic_probe(struct device *dev, struct pvpanic_instance *pi);
>
>  #endif /* PVPANIC_H_ */
> --
> 2.30.2
>


-- 
With Best Regards,
Andy Shevchenko
