Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A8C32D021
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbhCDJwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbhCDJw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:52:29 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72666C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 01:51:49 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id r17so48086447ejy.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 01:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyZ9u+4CQFaTUGpxZ7Y1chiIzjBwSjejYpZ2cWT/U0c=;
        b=ieIJHxpqiINZmN5DPPQ3ti1xHrBJVvclj2lSDcenYycjgPoKiNg++ktFWoUjpJMwD9
         vMD7CVyJm5gZiA1EO9sSBFuboVk/aCx+xT3VuxVSOyald2aStmcxRKL6q6U8Ku0+gMvR
         xRtGLYWz9rRzdcOBPEQkZ3KdXL4OVsU1gYTSNlysmyblPTZXqK3A3u2/Auf0cf3da68L
         07dulkSEx+2XqLxpNk51ZGJUvx/yicHkKJUbPQguIkEQbWuYNwRRKEt6xTjaPSBMd8oZ
         cupHl2+ztWeSWrIbrsdtJF47cHUkUxQsrhCqcFMOAtYnoH0vTZh+1QLQsAuBQvx/y05B
         P4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyZ9u+4CQFaTUGpxZ7Y1chiIzjBwSjejYpZ2cWT/U0c=;
        b=XdbmlhMztOWRnVLA0xgluf9EQ0PydwKJ/LzLRMggqLARVKZ+h1DYuqqoLw0mMO5P/b
         UnC74eczPGhGDmQAYzpnNl8ieBgEgkvBhcX8iVwZ38WjXlUw7h5EIkisxE5lTnBHiL4o
         vmnZuFK6JoJRCOxheCS1xD7AJH/9BlRGi6i+OsTbS8rWCH7CatmufKbrnXes3nVXuGmf
         gfcTFs1BffBb1qeSCvFL7PJ4DSU5miOsqhe1xpmgFH5mU9HTdNKXlcJOtI7IqUjvsuG3
         cr0Cnh1U1t0aQ7cFqbbI9XUoKuJl5WhgiwyTntjr/3z4aXGdf3PNdyEWBCekG8MQL++/
         +F5Q==
X-Gm-Message-State: AOAM532NmVIchLFAOBaqy4iL6wjd+26/WNg/Yr/1rOH05lhAx1nyUu8K
        qdQp+EipSVeBfLcDYnepUdyEGN79TLeENMVCeVxv9w==
X-Google-Smtp-Source: ABdhPJxVXr0PLxMt5u2JDX1pQ6tBL7LfITuN2AKJDU/ek2sC14xWyumHqMqPxE9rBbsNWnHEJ+c86rMypPNk+PPv8j0=
X-Received: by 2002:a17:906:d18e:: with SMTP id c14mr3192873ejz.62.1614851508128;
 Thu, 04 Mar 2021 01:51:48 -0800 (PST)
MIME-Version: 1.0
References: <20210303144631.3175331-1-lee.jones@linaro.org> <20210303144631.3175331-9-lee.jones@linaro.org>
In-Reply-To: <20210303144631.3175331-9-lee.jones@linaro.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 4 Mar 2021 10:51:37 +0100
Message-ID: <CAMGffEmcyspgsigH3Ek-O=VR+t3Hpx2aBtw04domWQ1Snm7xpg@mail.gmail.com>
Subject: Re: [PATCH 08/30] scsi: pm8001: pm8001_init: Provide function name
 and fix a misspelling
To:     Lee Jones <lee.jones@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kumar Santhanam <AnandKumar.Santhanam@pmcs.com>,
        Sangeetha Gnanasekaran <Sangeetha.Gnanasekaran@pmcs.com>,
        Nikith Ganigarakoppal <Nikith.Ganigarakoppal@pmcs.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 3:46 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/scsi/pm8001/pm8001_init.c:192: warning: expecting prototype for tasklet for 64 msi(). Prototype was for pm8001_tasklet() instead
>  drivers/scsi/pm8001/pm8001_init.c:872: warning: expecting prototype for pm8001_set_phy_settings_ven_117c_12Gb(). Prototype was for pm8001_set_phy_settings_ven_117c_12G() instead
>
> Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Kumar Santhanam <AnandKumar.Santhanam@pmcs.com>
> Cc: Sangeetha Gnanasekaran <Sangeetha.Gnanasekaran@pmcs.com>
> Cc: Nikith Ganigarakoppal <Nikith.Ganigarakoppal@pmcs.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Thanks
> ---
>  drivers/scsi/pm8001/pm8001_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index bd626ef876dac..bbb6b23aa6b1c 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -184,7 +184,7 @@ static void pm8001_free(struct pm8001_hba_info *pm8001_ha)
>  #ifdef PM8001_USE_TASKLET
>
>  /**
> - * tasklet for 64 msi-x interrupt handler
> + * pm8001_tasklet() - tasklet for 64 msi-x interrupt handler
>   * @opaque: the passed general host adapter struct
>   * Note: pm8001_tasklet is common for pm8001 & pm80xx
>   */
> @@ -864,7 +864,7 @@ void pm8001_get_phy_mask(struct pm8001_hba_info *pm8001_ha, int *phymask)
>  }
>
>  /**
> - * pm8001_set_phy_settings_ven_117c_12Gb : Configure ATTO 12Gb PHY settings
> + * pm8001_set_phy_settings_ven_117c_12G() : Configure ATTO 12Gb PHY settings
>   * @pm8001_ha : our adapter
>   */
>  static
> --
> 2.27.0
>
