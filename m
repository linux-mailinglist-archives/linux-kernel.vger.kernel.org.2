Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F35735F874
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352519AbhDNPxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352484AbhDNPwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618415521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfm3wy1jq3U50AiZa7Q8t8IEm7Fi+OwQ96j4zrxkOx4=;
        b=NbPky4LBcvFjRWOHD5U0faoBk74Drd4N3e9Z769oSTC0sytZPJ0qd8b9JYXB2nOpI6UTBV
        XEeBEVOP5mVzwARb9JvkS9d2+c8dZIOqhiwq1qGClnw7I8E6dUEu/yvSt3a78FOWIjwIFn
        arwiNlZqlzrWuH0piKh6VlSF9lYlJuY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-O_nkkwzCMoOVP5fD6Ps3Zg-1; Wed, 14 Apr 2021 11:51:59 -0400
X-MC-Unique: O_nkkwzCMoOVP5fD6Ps3Zg-1
Received: by mail-qt1-f198.google.com with SMTP id x7-20020a05622a0007b029019d73c63053so2204306qtw.16
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hfm3wy1jq3U50AiZa7Q8t8IEm7Fi+OwQ96j4zrxkOx4=;
        b=XafyAcKbkGgxN7x/A7AQnuB5oWr0F8SSWb7brZhz/YkzIjKW9nb5ur3qhBkvQwyhtA
         kUWtJ64g73/q5h8Ge/JVQMbR2c4FjkXHdndfCzeHdSlGXhagRL1o8N+iTEKSycFN43z6
         1hYahAEeAa8jP17v3ykL1bdhwi8qLoSMy0hIqr+Vu4y/kBeZPDWdXYT12WVsaux9JHCP
         R5TOPT1BsLB2X7amL1sHpzuW+Bki4aoAfGoFMrb+oUZ1Vh7iOQBZ87Ui6WN4vvWKiLjN
         +Tb/k4ghrzliHrt9yltgrNUfYNiZJrmKuN1KGvfJuZ1Ky28g9AX0eNVGzxlvWBtCxKwf
         RmYg==
X-Gm-Message-State: AOAM531rYMVESA3UztylHTcBiq9vBy+4X62QQrd+WAUCBVjp7RDr1wix
        c4V+ZRhElEG+oUFY10NoPK3LUjEjoLqtQbSRfD8GcHwI+63HPH7G93f9xxiNPUilb4kHbdMarKw
        DT+BNESy6tuCADhVqGJ4tICIJ
X-Received: by 2002:ad4:4c4a:: with SMTP id cs10mr16081172qvb.14.1618415518871;
        Wed, 14 Apr 2021 08:51:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWLlRURfepXcFayRR3qQmsWGXW2DmjDQ3NM/QqnRD/YifMHQ9yIH9C4E3i5AII7T5eo7WZgg==
X-Received: by 2002:ad4:4c4a:: with SMTP id cs10mr16081158qvb.14.1618415518699;
        Wed, 14 Apr 2021 08:51:58 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l124sm5551340qkf.31.2021.04.14.08.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 08:51:58 -0700 (PDT)
Subject: Re: [PATCH v9 1/1] mfd: intel-m10-bmc: support for MAX10 BMC Secure
 Updates
To:     Russ Weight <russell.h.weight@intel.com>, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20210412195329.241357-1-russell.h.weight@intel.com>
 <20210412195329.241357-2-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c7044c0a-b3fb-837d-137f-fdb9b1d42847@redhat.com>
Date:   Wed, 14 Apr 2021 08:51:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210412195329.241357-2-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/12/21 12:53 PM, Russ Weight wrote:
> Add macros and definitions required by the MAX10 BMC
> Secure Update driver.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> v9:
>    - Rebased on next-20210412
> v8:
>    - Previously patch 1/6 in "Intel MAX10 BMC Secure Update Driver"
>    - Rebased on next-20210121
> v7:
>    - No change
> v6:
>    - No change
> v5:
>    - Renamed USER_FLASH_COUNT to STAGING_FLASH_COUNT
> v4:
>    - No change
> v3:
>    - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
>      Update driver"
>    - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>      underlying functions will be called directly.
> v2:
>    - These functions and macros were previously distributed among
>      the patches that needed them. They are now grouped together
>      in a single patch containing changes to the Intel MAX10 BMC
>      driver.
>    - Added DRBL_ prefix to some definitions
>    - Some address definitions were moved here from the .c files that
>      use them.
> ---
>   include/linux/mfd/intel-m10-bmc.h | 85 +++++++++++++++++++++++++++++++
>   1 file changed, 85 insertions(+)
>
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index c4eb38c13eda..f0044b14136e 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -16,6 +16,9 @@
>   #define M10BMC_FLASH_END		0x1fffffff
>   #define M10BMC_MEM_END			M10BMC_FLASH_END
>   
> +#define M10BMC_STAGING_BASE		0x18000000
> +#define M10BMC_STAGING_SIZE		0x3800000
> +
>   /* Register offset of system registers */
>   #define NIOS2_FW_VERSION		0x0
>   #define M10BMC_MAC_LOW			0x10
> @@ -33,6 +36,88 @@
>   #define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
>   #define M10BMC_VER_LEGACY_INVALID	0xffffffff
>   
> +/* Secure update doorbell register, in system register region */
> +#define M10BMC_DOORBELL			0x400

To be consistent with the existing register #defines,

The bit values for the register should follow the register and have a 
M10BMC_ prefix

Tom

> +
> +/* Authorization Result register, in system register region */
> +#define M10BMC_AUTH_RESULT		0x404
> +
> +/* Doorbell register fields */
> +#define DRBL_RSU_REQUEST		BIT(0)
> +#define DRBL_RSU_PROGRESS		GENMASK(7, 4)
> +#define DRBL_HOST_STATUS		GENMASK(11, 8)
> +#define DRBL_RSU_STATUS			GENMASK(23, 16)
> +#define DRBL_PKVL_EEPROM_LOAD_SEC	BIT(24)
> +#define DRBL_PKVL1_POLL_EN		BIT(25)
> +#define DRBL_PKVL2_POLL_EN		BIT(26)
> +#define DRBL_CONFIG_SEL			BIT(28)
> +#define DRBL_REBOOT_REQ			BIT(29)
> +#define DRBL_REBOOT_DISABLED		BIT(30)
> +
> +/* Progress states */
> +#define RSU_PROG_IDLE			0x0
> +#define RSU_PROG_PREPARE		0x1
> +#define RSU_PROG_READY			0x3
> +#define RSU_PROG_AUTHENTICATING		0x4
> +#define RSU_PROG_COPYING		0x5
> +#define RSU_PROG_UPDATE_CANCEL		0x6
> +#define RSU_PROG_PROGRAM_KEY_HASH	0x7
> +#define RSU_PROG_RSU_DONE		0x8
> +#define RSU_PROG_PKVL_PROM_DONE		0x9
> +
> +/* Device and error states */
> +#define RSU_STAT_NORMAL			0x0
> +#define RSU_STAT_TIMEOUT		0x1
> +#define RSU_STAT_AUTH_FAIL		0x2
> +#define RSU_STAT_COPY_FAIL		0x3
> +#define RSU_STAT_FATAL			0x4
> +#define RSU_STAT_PKVL_REJECT		0x5
> +#define RSU_STAT_NON_INC		0x6
> +#define RSU_STAT_ERASE_FAIL		0x7
> +#define RSU_STAT_WEAROUT		0x8
> +#define RSU_STAT_NIOS_OK		0x80
> +#define RSU_STAT_USER_OK		0x81
> +#define RSU_STAT_FACTORY_OK		0x82
> +#define RSU_STAT_USER_FAIL		0x83
> +#define RSU_STAT_FACTORY_FAIL		0x84
> +#define RSU_STAT_NIOS_FLASH_ERR		0x85
> +#define RSU_STAT_FPGA_FLASH_ERR		0x86
> +
> +#define HOST_STATUS_IDLE		0x0
> +#define HOST_STATUS_WRITE_DONE		0x1
> +#define HOST_STATUS_ABORT_RSU		0x2
> +
> +#define rsu_prog(doorbell)	FIELD_GET(DRBL_RSU_PROGRESS, doorbell)
> +#define rsu_stat(doorbell)	FIELD_GET(DRBL_RSU_STATUS, doorbell)
> +
> +/* interval 100ms and timeout 5s */
> +#define NIOS_HANDSHAKE_INTERVAL_US	(100 * 1000)
> +#define NIOS_HANDSHAKE_TIMEOUT_US	(5 * 1000 * 1000)
> +
> +/* RSU PREP Timeout (2 minutes) to erase flash staging area */
> +#define RSU_PREP_INTERVAL_MS		100
> +#define RSU_PREP_TIMEOUT_MS		(2 * 60 * 1000)
> +
> +/* RSU Complete Timeout (40 minutes) for full flash update */
> +#define RSU_COMPLETE_INTERVAL_MS	1000
> +#define RSU_COMPLETE_TIMEOUT_MS		(40 * 60 * 1000)
> +
> +/* Addresses for security related data in FLASH */
> +#define BMC_REH_ADDR	0x17ffc004
> +#define BMC_PROG_ADDR	0x17ffc000
> +#define BMC_PROG_MAGIC	0x5746
> +
> +#define SR_REH_ADDR	0x17ffd004
> +#define SR_PROG_ADDR	0x17ffd000
> +#define SR_PROG_MAGIC	0x5253
> +
> +#define PR_REH_ADDR	0x17ffe004
> +#define PR_PROG_ADDR	0x17ffe000
> +#define PR_PROG_MAGIC	0x5250
> +
> +/* Address of 4KB inverted bit vector containing staging area FLASH count */
> +#define STAGING_FLASH_COUNT	0x17ffb000
> +
>   /**
>    * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
>    * @dev: this device

