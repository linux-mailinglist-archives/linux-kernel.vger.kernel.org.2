Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C395532D030
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbhCDJyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbhCDJyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:54:06 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D12C061763
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 01:53:25 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b13so24751500edx.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 01:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OTcQ8HgK4xyfwhINSgp1y1iTr9PgQDJ2c/607cyGHGo=;
        b=IsM7FCFoOX7Ne2WFWvbKg3XJeuCz6uhuQFOyWd7YtBYuo33lgKCxql1VghtgcyVFNA
         XU+jKyjednPG8tBJl/lJCnxgtAGQamTleQ/CqD4pcrqfhyhaz2t1zo2tW8XR3Z3Blh/U
         WbTiYo1+yMyCndKQWvw3+gpdX8+JbQQS5WAwqVB16b81gock5Ktq1OfvsPnOB53+MsCa
         qSSRna6d+Ukz8LDZWSsEi4vTabbWQHjV185FbVgoP75cw2hoOXiP9M7p4nJ2b0tf8LaK
         qReCWTuAgZUkH3lKGMzZzTYiDwxpA1bWMDBYZI5q2QbKG7ZJoKKWpyuNMg3tI9ehfKn4
         DDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OTcQ8HgK4xyfwhINSgp1y1iTr9PgQDJ2c/607cyGHGo=;
        b=rvJN5EJA3Z5/ySugLHQKd+T0N7B1pA+e8hmDt8TpN0ya8rVOjjF2Fv0XiLRHw6pMIm
         Yb5lvE8ETYx9ckHm0al9ub4KtatFApnZo981E65KMQtx3OIVnyGC9ga1pEIALNBPWMHm
         OYKVzWlV28u2VocvEx/eqACaYIC4dBvh3L3XDyvS8K0lI44MBKsz0XLY/N3Zbr+DnIPL
         49mO+BWFcsza8qiA4AGUY0Sc3/p36TqFo36dxRs7SVwmnX5llwwXr4f/KkDrGN+Tj/X4
         nOV75BZeOcVktBUcN9EwVgvwasRIOqwxJNuap2J9AomP/qUUkc2eCheNYKsG/zjxxTzW
         k56Q==
X-Gm-Message-State: AOAM532mfBNtet5BMBD4tR9BAKk+b7xaO9pdiq6tT8tMLaBNPKrwuS9B
        w5B5cp+31QaN4Oh4CufMqkhF4o39OZHJdkCsoTzGtg==
X-Google-Smtp-Source: ABdhPJz6Dj0a0IikbpQXchtVdO8tIE2nsniGPcwwE+9AaiI73lLIy5D97wzFfkMITMwrpAcRZtd/LijwTg43rmnqzWE=
X-Received: by 2002:a05:6402:ce:: with SMTP id i14mr3439724edu.42.1614851604560;
 Thu, 04 Mar 2021 01:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20210303144631.3175331-1-lee.jones@linaro.org> <20210303144631.3175331-19-lee.jones@linaro.org>
In-Reply-To: <20210303144631.3175331-19-lee.jones@linaro.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 4 Mar 2021 10:53:13 +0100
Message-ID: <CAMGffEkGT0tRSM51pikNc3d+w1mYJCN-oWzRxFA_wPRXE+d=Ow@mail.gmail.com>
Subject: Re: [PATCH 18/30] scsi: pm8001: pm8001_hwi: Fix some misnamed
 function descriptions
To:     Lee Jones <lee.jones@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 3:47 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/scsi/pm8001/pm8001_hwi.c:1183: warning: expecting prototype for pm8001_chip_interrupt_enable(). Prototype was for pm8001_chip_intx_interrupt_enable() instead
>  drivers/scsi/pm8001/pm8001_hwi.c:1257: warning: expecting prototype for pm8001_chip_intx_interrupt_disable(). Prototype was for pm8001_chip_interrupt_disable() instead
>  drivers/scsi/pm8001/pm8001_hwi.c:3235: warning: expecting prototype for asd_get_attached_sas_addr(). Prototype was for pm8001_get_attached_sas_addr() instead
>  drivers/scsi/pm8001/pm8001_hwi.c:3555: warning: expecting prototype for fw_flash_update_resp(). Prototype was for pm8001_mpi_fw_flash_update_resp() instead
>
> Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Thanks
> ---
>  drivers/scsi/pm8001/pm8001_hwi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
> index 49bf2f70a470e..6b600e33e9e8d 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -1175,7 +1175,7 @@ void pm8001_chip_iounmap(struct pm8001_hba_info *pm8001_ha)
>
>  #ifndef PM8001_USE_MSIX
>  /**
> - * pm8001_chip_interrupt_enable - enable PM8001 chip interrupt
> + * pm8001_chip_intx_interrupt_enable - enable PM8001 chip interrupt
>   * @pm8001_ha: our hba card information
>   */
>  static void
> @@ -1248,7 +1248,7 @@ pm8001_chip_interrupt_enable(struct pm8001_hba_info *pm8001_ha, u8 vec)
>  }
>
>  /**
> - * pm8001_chip_intx_interrupt_disable- disable PM8001 chip interrupt
> + * pm8001_chip_interrupt_disable - disable PM8001 chip interrupt
>   * @pm8001_ha: our hba card information
>   * @vec: unused
>   */
> @@ -3219,7 +3219,7 @@ void pm8001_get_lrate_mode(struct pm8001_phy *phy, u8 link_rate)
>  }
>
>  /**
> - * asd_get_attached_sas_addr -- extract/generate attached SAS address
> + * pm8001_get_attached_sas_addr - extract/generate attached SAS address
>   * @phy: pointer to asd_phy
>   * @sas_addr: pointer to buffer where the SAS address is to be written
>   *
> @@ -3546,7 +3546,7 @@ int pm8001_mpi_dereg_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
>  }
>
>  /**
> - * fw_flash_update_resp - Response from FW for flash update command.
> + * pm8001_mpi_fw_flash_update_resp - Response from FW for flash update command.
>   * @pm8001_ha: our hba card information
>   * @piomb: IO message buffer
>   */
> --
> 2.27.0
>
