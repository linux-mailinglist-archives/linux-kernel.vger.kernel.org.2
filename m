Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52B6406774
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhIJHE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231223AbhIJHE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631257427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gDVGtpvW/ghS2zGTS9bvhHhRAu6NzdeeEgdxhrWzBTI=;
        b=byh8awp59zFar/NRKE2givuNuVGMlajpaQ6ZSBBMGmBhgahn2hej4iFOzuDbsC2hduVcKA
        FryylS7nSieLscdTj9kraU111gosyKy3+MqMNqzS3R7KabPinjvOc8s48/mYgICVOAwAKL
        8dreVNxLpQuNYBxrSt+5OR1JLXXj0Fk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-joLZF3UrOLOwsGIA1s_QiA-1; Fri, 10 Sep 2021 03:03:46 -0400
X-MC-Unique: joLZF3UrOLOwsGIA1s_QiA-1
Received: by mail-ed1-f71.google.com with SMTP id n5-20020a05640206c500b003cf53f7cef2so405550edy.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 00:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gDVGtpvW/ghS2zGTS9bvhHhRAu6NzdeeEgdxhrWzBTI=;
        b=lRkA0noqBCZ8Qx8GUJZg4Jw4uqH/EoZf8k7adpgaffrBjxXBdR8NrXv5NUXdSRDGd2
         z1KLUJTUjFkRfSRXFS6g5/1HrA4oKgdlKe1DZG7bdZiQt7BiiLj4NOKwo6eRqYPkzsaD
         eyq6UDrW0e9ya5aX7MIO4539CQoF4MlxXGX0E67CLAzYtSnvA5i2ebuW9StwWWE8JWLb
         QnZsLi9WrsuGju+OIDPIdbVpvZM9BfumHf/kzePktrU+ENwtVnS0fN27mLlcZpb+M13n
         JEwuQubdhcq4N61E35g2HDtvRNehmElIC6Tlvj1p7NZbpn5xSIRrUS5EaHJ5An/Rbd/8
         mOwg==
X-Gm-Message-State: AOAM531BbWEGrrsktA76LOy4mt6d9+WsnxpMO8h2dOpRAzjRPIDHCFFm
        xZ/j3/ntxepa04Y8jsoRJl7d2uSXUemehe8T4sv2qVzjPFkbH9SM/60CyHzEvDIH+SPXbxuqe/T
        YfjuFztaMSz0MlnI6WZtQ94FZonL2W1Yj7oFw9sXCGtydQIAtmd/O6s8w/CDh15qulQeXX6THo5
        zw
X-Received: by 2002:a05:6402:1779:: with SMTP id da25mr7393919edb.200.1631257423831;
        Fri, 10 Sep 2021 00:03:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6+o3pQR9tBoqGbS/0pcFbjx57bNj3W+61+7AsOI5uFXIBV52lh2IzBEb26262bZQ92xgY4Q==
X-Received: by 2002:a05:6402:1779:: with SMTP id da25mr7393893edb.200.1631257423556;
        Fri, 10 Sep 2021 00:03:43 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id e21sm1904551ejj.4.2021.09.10.00.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 00:03:43 -0700 (PDT)
Subject: Re: [PATCH] extcon: extcon-axp288: use low level P-Unit semaphore
 lock for axp288 register accesses
To:     kernel test robot <lkp@intel.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
References: <20210909151820.5303-1-fabioaiuto83@gmail.com>
 <202109100823.X6Isdxi1-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3ecef801-7484-95ed-3e76-e7770146e626@redhat.com>
Date:   Fri, 10 Sep 2021 09:03:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202109100823.X6Isdxi1-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/10/21 2:26 AM, kernel test robot wrote:
> Hi Fabio,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on chanwoo-extcon/extcon-next]
> [also build test ERROR on v5.14 next-20210909]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Fabio-Aiuto/extcon-extcon-axp288-use-low-level-P-Unit-semaphore-lock-for-axp288-register-accesses/20210909-232054
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git extcon-next
> config: x86_64-randconfig-a011-20210908 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 261cbe98c38f8c1ee1a482fe76511110e790f58a)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/ecccd5dd3a8acfd5085a5cf9f9c97ed3d4b42a1f
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Fabio-Aiuto/extcon-extcon-axp288-use-low-level-P-Unit-semaphore-lock-for-axp288-register-accesses/20210909-232054
>         git checkout ecccd5dd3a8acfd5085a5cf9f9c97ed3d4b42a1f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/extcon/extcon-axp288.c:219:2: error: implicit declaration of function 'iosf_mbi_block_punit_i2c_access' [-Werror,-Wimplicit-function-declaration]
>            iosf_mbi_block_punit_i2c_access();
>            ^
>>> drivers/extcon/extcon-axp288.c:259:2: error: implicit declaration of function 'iosf_mbi_unblock_punit_i2c_access' [-Werror,-Wimplicit-function-declaration]
>            iosf_mbi_unblock_punit_i2c_access();
>            ^
>    drivers/extcon/extcon-axp288.c:259:2: note: did you mean 'iosf_mbi_block_punit_i2c_access'?
>    drivers/extcon/extcon-axp288.c:219:2: note: 'iosf_mbi_block_punit_i2c_access' declared here
>            iosf_mbi_block_punit_i2c_access();
>            ^
>    drivers/extcon/extcon-axp288.c:317:2: error: implicit declaration of function 'iosf_mbi_block_punit_i2c_access' [-Werror,-Wimplicit-function-declaration]
>            iosf_mbi_block_punit_i2c_access();
>            ^
>    drivers/extcon/extcon-axp288.c:324:2: error: implicit declaration of function 'iosf_mbi_unblock_punit_i2c_access' [-Werror,-Wimplicit-function-declaration]
>            iosf_mbi_unblock_punit_i2c_access();
>            ^
>    drivers/extcon/extcon-axp288.c:397:2: error: implicit declaration of function 'iosf_mbi_block_punit_i2c_access' [-Werror,-Wimplicit-function-declaration]
>            iosf_mbi_block_punit_i2c_access();
>            ^
>    drivers/extcon/extcon-axp288.c:403:2: error: implicit declaration of function 'iosf_mbi_unblock_punit_i2c_access' [-Werror,-Wimplicit-function-declaration]
>            iosf_mbi_unblock_punit_i2c_access();
>            ^
>    6 errors generated.

Ah yes, I should have caught this, we had the same issue with a similar patch to
the axp288-fuel-gauge driver.

The fix is this:

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index c69d40ae5619..aab87c9b35c8 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -23,7 +23,7 @@ config EXTCON_ADC_JACK
 
 config EXTCON_AXP288
 	tristate "X-Power AXP288 EXTCON support"
-	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI
+	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI && IOSF_MBI
 	select USB_ROLE_SWITCH
 	help
 	  Say Y here to enable support for USB peripheral detection

The new depends on is fine since all boards which use the AXP288 should
always have IOSF_MBI enabled anyways.

Fabio, can you send a v2 with this Kconfig change added please ?

(and please also add my earlier Reviewed-by and Tested-by to the v2)


> 
> 
> vim +/iosf_mbi_block_punit_i2c_access +219 drivers/extcon/extcon-axp288.c
> 
>    211	
>    212	static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>    213	{
>    214		int ret, stat, cfg;
>    215		u8 chrg_type;
>    216		unsigned int cable = info->previous_cable;
>    217		bool vbus_attach = false;
>    218	
>  > 219		iosf_mbi_block_punit_i2c_access();
>    220	
>    221		vbus_attach = axp288_get_vbus_attach(info);
>    222		if (!vbus_attach)
>    223			goto no_vbus;
>    224	
>    225		/* Check charger detection completion status */
>    226		ret = regmap_read(info->regmap, AXP288_BC_GLOBAL_REG, &cfg);
>    227		if (ret < 0)
>    228			goto dev_det_ret;
>    229		if (cfg & BC_GLOBAL_DET_STAT) {
>    230			dev_dbg(info->dev, "can't complete the charger detection\n");
>    231			goto dev_det_ret;
>    232		}
>    233	
>    234		ret = regmap_read(info->regmap, AXP288_BC_DET_STAT_REG, &stat);
>    235		if (ret < 0)
>    236			goto dev_det_ret;
>    237	
>    238		chrg_type = (stat & DET_STAT_MASK) >> DET_STAT_SHIFT;
>    239	
>    240		switch (chrg_type) {
>    241		case DET_STAT_SDP:
>    242			dev_dbg(info->dev, "sdp cable is connected\n");
>    243			cable = EXTCON_CHG_USB_SDP;
>    244			break;
>    245		case DET_STAT_CDP:
>    246			dev_dbg(info->dev, "cdp cable is connected\n");
>    247			cable = EXTCON_CHG_USB_CDP;
>    248			break;
>    249		case DET_STAT_DCP:
>    250			dev_dbg(info->dev, "dcp cable is connected\n");
>    251			cable = EXTCON_CHG_USB_DCP;
>    252			break;
>    253		default:
>    254			dev_warn(info->dev, "unknown (reserved) bc detect result\n");
>    255			cable = EXTCON_CHG_USB_SDP;
>    256		}
>    257	
>    258	no_vbus:
>  > 259		iosf_mbi_unblock_punit_i2c_access();
>    260	
>    261		extcon_set_state_sync(info->edev, info->previous_cable, false);
>    262		if (info->previous_cable == EXTCON_CHG_USB_SDP)
>    263			extcon_set_state_sync(info->edev, EXTCON_USB, false);
>    264	
>    265		if (vbus_attach) {
>    266			extcon_set_state_sync(info->edev, cable, vbus_attach);
>    267			if (cable == EXTCON_CHG_USB_SDP)
>    268				extcon_set_state_sync(info->edev, EXTCON_USB,
>    269							vbus_attach);
>    270	
>    271			info->previous_cable = cable;
>    272		}
>    273	
>    274		if (info->role_sw && info->vbus_attach != vbus_attach) {
>    275			info->vbus_attach = vbus_attach;
>    276			/* Setting the role can take a while */
>    277			queue_work(system_long_wq, &info->role_work);
>    278		}
>    279	
>    280		return 0;
>    281	
>    282	dev_det_ret:
>    283		iosf_mbi_unblock_punit_i2c_access();
>    284	
>    285		if (ret < 0)
>    286			dev_err(info->dev, "failed to detect BC Mod\n");
>    287	
>    288		return ret;
>    289	}
>    290	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

