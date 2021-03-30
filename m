Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8243434ED4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhC3QP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:15:58 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:45851 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhC3QPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:15:44 -0400
Received: by mail-pj1-f42.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso7909856pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2fI4VhHe8aki99no36i/27lg7qBg6asALWaTkAeQI+o=;
        b=uV1tdn79yEPTx28E+UV/o024wXISvScqEYUzX0Cp244B5AW9yJ6D3rQs5by79KyDPG
         jURDhdSLMj4sozKu2fqidmy32mFcj1ge6BtiEqc1VArFTGBxXEI8eolQXiZDZTf/Hkbi
         +tUr3OX7FUATh+arrEzsIC1liFzB4brubvGJaR3nladnJse3aREPEG513xycDW3ZOb+s
         omCuXminPLDU07e5/+mloUVuGdn38FmMO7AVHM//hBiElyEAWK9NfTxcAK6rekHCrsQK
         WPqslq0vX+zB6s4fAU5nV57QRDWf+EqvfheXYwha/Q8dG3YTW8oA4pRdQLJDCGEzsqjK
         BBGg==
X-Gm-Message-State: AOAM531ngJbKYEq9hwp8w/9Rbr5lvR7hqX6/8bIkM25OPslQQWWIk2cz
        jTVGLfYFpSuMEECTbMAARgU=
X-Google-Smtp-Source: ABdhPJws1NvhGFKhFqZn4FZNjQsO+CBACwj1ql+2wSmLO0fRvCP6oJVKbgvcaChc5BPquNDvt9JYag==
X-Received: by 2002:a17:90b:4910:: with SMTP id kr16mr4970022pjb.26.1617120944403;
        Tue, 30 Mar 2021 09:15:44 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id v9sm22059294pfc.108.2021.03.30.09.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:15:43 -0700 (PDT)
Date:   Tue, 30 Mar 2021 09:15:42 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCH] firmware: stratix10-svc: extend SVC driver to get the
 firmware version
Message-ID: <YGNOruQFFvD0fgBb@epycbox.lan>
References: <1617114785-22211-1-git-send-email-richard.gong@linux.intel.com>
 <1617114785-22211-2-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617114785-22211-2-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Tue, Mar 30, 2021 at 09:33:05AM -0500, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Extend Intel service layer driver to get the firmware version running at
> FPGA device. Therefore FPGA manager driver, one of Intel service layer
> driver's client, can decide whether to handle the newly added bitstream
> authentication function based on the retrieved firmware version.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Acked-by: Moritz Fischr <mdf@kernel.org>
> ---
>  drivers/firmware/stratix10-svc.c                    | 12 ++++++++++--
>  include/linux/firmware/intel/stratix10-smc.h        | 21 +++++++++++++++++++--
>  include/linux/firmware/intel/stratix10-svc-client.h |  4 ++++
>  3 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index 3aa489d..1443bbd 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -306,6 +306,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
>  		break;
>  	case COMMAND_RSU_RETRY:
>  	case COMMAND_RSU_MAX_RETRY:
> +	case COMMAND_FIRMWARE_VERSION:
>  		cb_data->status = BIT(SVC_STATUS_OK);
>  		cb_data->kaddr1 = &res.a1;
>  		break;
> @@ -422,6 +423,11 @@ static int svc_normal_to_secure_thread(void *data)
>  			a1 = 0;
>  			a2 = 0;
>  			break;
> +		case COMMAND_FIRMWARE_VERSION:
> +			a0 = INTEL_SIP_SMC_FIRMWARE_VERSION;
> +			a1 = 0;
> +			a2 = 0;
> +			break;
>  		default:
>  			pr_warn("it shouldn't happen\n");
>  			break;
> @@ -487,11 +493,13 @@ static int svc_normal_to_secure_thread(void *data)
>  
>  			/*
>  			 * be compatible with older version firmware which
> -			 * doesn't support RSU notify or retry
> +			 * doesn't support RSU notify, retry or bitstream
> +			 * authentication.
>  			 */
>  			if ((pdata->command == COMMAND_RSU_RETRY) ||
>  			    (pdata->command == COMMAND_RSU_MAX_RETRY) ||
> -				(pdata->command == COMMAND_RSU_NOTIFY)) {
> +			    (pdata->command == COMMAND_RSU_NOTIFY) ||
> +			    (pdata->command == COMMAND_FIRMWARE_VERSION)) {
>  				cbdata->status =
>  					BIT(SVC_STATUS_NO_SUPPORT);
>  				cbdata->kaddr1 = NULL;
> diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
> index c3e5ab0..505fcca 100644
> --- a/include/linux/firmware/intel/stratix10-smc.h
> +++ b/include/linux/firmware/intel/stratix10-smc.h
> @@ -321,8 +321,6 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
>  #define INTEL_SIP_SMC_ECC_DBE \
>  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_ECC_DBE)
>  
> -#endif
> -
>  /**
>   * Request INTEL_SIP_SMC_RSU_NOTIFY
>   *
> @@ -404,3 +402,22 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
>  #define INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY 18
>  #define INTEL_SIP_SMC_RSU_MAX_RETRY \
>  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY)
> +
> +/**
> + * Request INTEL_SIP_SMC_FIRMWARE_VERSION
> + *
> + * Sync call used to query the version of running firmware
> + *
> + * Call register usage:
> + * a0 INTEL_SIP_SMC_FIRMWARE_VERSION
> + * a1-a7 not used
> + *
> + * Return status:
> + * a0 INTEL_SIP_SMC_STATUS_OK or INTEL_SIP_SMC_STATUS_ERROR
> + * a1 running firmware version
> + */
> +#define INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION 31
> +#define INTEL_SIP_SMC_FIRMWARE_VERSION \
> +	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION)
> +
> +#endif
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index 19781b0f..18c1841 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -104,6 +104,9 @@ struct stratix10_svc_chan;
>   *
>   * @COMMAND_RSU_DCMF_VERSION: query firmware for the DCMF version, return status
>   * is SVC_STATUS_OK or SVC_STATUS_ERROR
> + *
> + * @COMMAND_FIRMWARE_VERSION: query running firmware version, return status
> + * is SVC_STATUS_OK or SVC_STATUS_ERROR
>   */
>  enum stratix10_svc_command_code {
>  	COMMAND_NOOP = 0,
> @@ -117,6 +120,7 @@ enum stratix10_svc_command_code {
>  	COMMAND_RSU_RETRY,
>  	COMMAND_RSU_MAX_RETRY,
>  	COMMAND_RSU_DCMF_VERSION,
> +	COMMAND_FIRMWARE_VERSION,
>  };
>  
>  /**
> -- 
> 2.7.4
> 

Let's hold off on this patch until we have sorted the rest of this patch
series out. As it stands it doesn't have a in-tree user.

Thanks,
Moritz
