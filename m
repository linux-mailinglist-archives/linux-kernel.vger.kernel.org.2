Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A1C40EDE2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 01:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239276AbhIPXjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 19:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhIPXjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 19:39:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C27AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:38:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l6so177297plh.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dsmpAEysummCR+0sKJW94drPPG6N4lgMtRNGAbPoMYM=;
        b=R3QcpmAxoydu8UEqTsgiQDtldifUVex8DLdhfjcCkkDN4tESQTG+gPUZoh5PkTumk1
         tdsNh405J1V5USAYKCG6IA5TShauMTwlqvkXD1Lah/K80tgCzPfH7LYtT781FT/eF7hK
         roC8CSoyOjdrguPNtwyDlCUsxud4mo4eftpPsB3JVKfzergQmBuCHTW4wTsxEDundsKP
         5AGJuq9QONvsF0IOZURgW/gTBWvu3cKCvzYa3wY8HflZj/GHg87H8NAprWyRGjCcHBTJ
         dP/D+Nypft3eyemyk2jgjwwYybSu1KE6QGaaRSBTbWPpwB3ozTcIC/mQPEvrQ88Fil9P
         Qccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=dsmpAEysummCR+0sKJW94drPPG6N4lgMtRNGAbPoMYM=;
        b=wpyg91iFqjydQ1sRoTYc5Bjp/uMMwl7kZ+Ta6Ayn71KeYy5noM6+XXp89cAJVRF/hI
         42jPN6Bh3XiZ2vOgSFw0q+auRzdoJF3Co6n3YIZOdBF8zwBh33ovLHMXyioL+Ax0SQfc
         vPCtw9AUpQhyh5qF4mUBt+sEZx4jX1aZHgXACt0Q9Jpo8eX0U5z9wukEXcKUHbo2MW/s
         JLj/DFDMZcfANaCgddvrTuThS/PlXCXL7FSMTK+xXNBW9YyMMzoROrB+oTJitsMdANiJ
         xL0m4oEoQ3Ct0Ujj1Et4lCQ1Q/NzBLRJu25226pMxgVSRpQHGTrLI/kjXWL1F4z+FP2y
         qkUw==
X-Gm-Message-State: AOAM530y6YIqlbxv68r8zut0XXf/YtrIng36Glv/J+layZ1bk+b1EFJy
        MlOB4H21OKnOncOOe8EDfV8=
X-Google-Smtp-Source: ABdhPJyCDk5ItHOE340GhRmuFVtp+aFArK4dQXh9Ewz/os6s+Gx9QFrxJMIkc5x/fx5wvwRY4yee1A==
X-Received: by 2002:a17:902:b694:b0:138:a031:610d with SMTP id c20-20020a170902b69400b00138a031610dmr7127076pls.36.1631835482195;
        Thu, 16 Sep 2021 16:38:02 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id h24sm4182036pfn.180.2021.09.16.16.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 16:38:01 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Ronak Jain <ronak.jain@xilinx.com>
Cc:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: Re: [PATCH v2 2/3] firmware: zynqmp: Add sysfs entry for runtime
 features
References: <20210913083955.27146-1-ronak.jain@xilinx.com>
        <20210913083955.27146-3-ronak.jain@xilinx.com>
Date:   Fri, 17 Sep 2021 08:37:58 +0900
In-Reply-To: <20210913083955.27146-3-ronak.jain@xilinx.com> (Ronak Jain's
        message of "Mon, 13 Sep 2021 01:39:54 -0700")
Message-ID: <87ee9o6qi1.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ronak,

Ronak Jain <ronak.jain@xilinx.com> writes:

> Create sysfs entry for runtime feature configuration. The support
>  is added for an over temperature and external watchdog feature.
>
> The below listed files are used for runtime features configuration:
> /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
>
> In order to configure an over temperature or external watchdog
>  features, first the user need to select the valid config id and then
>  the user can configure the value for selected feature config id.
>
> Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> ---
> Changes in v2:
> - Update commit message
> ---
>  .../ABI/stable/sysfs-driver-firmware-zynqmp   | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> index f5724bb5b462..2fde354715a5 100644
> --- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> +++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> @@ -113,3 +113,87 @@ Description:
>  		    # echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
>  
>  Users:		Xilinx
> +
> +What:		/sys/devices/platform/firmware\:zynqmp-firmware/feature_config_*
> +Date:		Aug 2021
> +KernelVersion:	5.14
> +Contact:	"Ronak Jain" <ronak.jain@xilinx.com>
> +Description:
> +		This sysfs interface allows to configure features at runtime.
> +		The user can enable or disable features running at firmware.
> +		Also, the user can configure the parameters of the features
> +		at runtime. The supported features are over temperature and
> +		external watchdog. Here, the external watchdog is completely
> +		different than the /dev/watchdog as the external watchdog is
> +		running on the firmware and it is used to monitor the health
> +		of firmware not APU(Linux). Also, the external watchdog is
> +		interfaced outside of the zynqmp soc.
> +
> +		By default the features are disabled in the firmware. The user
> +		can enable features by querying appropriate config id of the
> +		features.
> +
> +		The default limit for the over temperature is 90 Degree Celsius.
> +		The default timer interval for the external watchdog is 570ms.
> +
> +		The supported config ids are for the feature configuration is,
> +		1. PM_FEATURE_OVERTEMP_STATUS = 1, the user can enable or
> +		disable the over temperature feature.
> +		2. PM_FEATURE_OVERTEMP_VALUE = 2, the user can configure the
> +		over temperature limit in Degree Celsius.
> +		3. PM_FEATURE_EXTWDT_STATUS = 3, the user can enable or disable
> +		the external watchdog feature.
> +		4. PM_FEATURE_EXTWDT_VALUE = 4, the user can configure the
> +		external watchdog feature.
> +
> +		Usage:
> +
> +		Enable over temperature feature
> +		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +
> +		Check whether the over temperature feature is enabled or not
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +		The expected result is 1.
> +
> +		Disable over temperature feature
> +		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +		# echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +
> +		Check whether the over temperature feature is disabled or not
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +		The expected result is 0.
> +
> +		Configure over temperature limit to 50 Degree Celsius
> +		# echo 2 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +		# echo 50 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +
> +		Check whether the over temperature limit is configured or not
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +		The expected result is 50.

Maybe I am missing something but I was wondering why these features are
being exposed via custom sysfs nodes - can they be integrated into the
respective subsystems?

e.g., Over temperature protection would fit in nicely with the thermal
sub-system. Did you explore integrating the feature there?

> +
> +		Enable external watchdog feature
> +		# echo 3 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +
> +		Check whether the external watchdog feature is enabled or not
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +		The expected result is 1.
> +
> +		Disable external watchdog feature
> +		# echo 3 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +		# echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +
> +		Check whether the external watchdog feature is disabled or not
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +		The expected result is 0.
> +
> +		Configure external watchdog timer interval to 500ms
> +		# echo 4 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +		# echo 500 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +
> +		Check whether the external watchdog timer interval is configured or not
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
> +		The expected result is 500.

Similarly, this would make sense to go into the watchdog subsystem.

Using sub-system interfaces would allow existing tools to just work
without having to make zynqmp specific tools or find yet another way to
interact with these features. 

Thanks,
Punit
