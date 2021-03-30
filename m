Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D7534EF30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 19:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhC3RRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 13:17:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:48516 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232265AbhC3RQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:16:51 -0400
IronPort-SDR: g4DYjAZoAHD7ySBVs0JKYQtTKwUxp4QSdMfr9j9kuBSRVJ+psjruJ0S/dwgOUazODQLdokm/u1
 xYJxAVw7sd7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="276991736"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="276991736"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 10:16:51 -0700
IronPort-SDR: 9w6/7yH7gcgtSN4GQ2dkKSGGjuCPN6S8sg7WqVKFMElqtlecX6G1CH4yicdHxVbNAXaq4z1n9b
 c8J3OyDOp8/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="445236910"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2021 10:16:50 -0700
Subject: Re: [PATCH] firmware: stratix10-svc: extend SVC driver to get the
 firmware version
To:     Moritz Fischer <mdf@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
References: <1617114785-22211-1-git-send-email-richard.gong@linux.intel.com>
 <1617114785-22211-2-git-send-email-richard.gong@linux.intel.com>
 <YGNOruQFFvD0fgBb@epycbox.lan>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <5431015b-4b04-c95e-c5d5-6b28c38dc123@linux.intel.com>
Date:   Tue, 30 Mar 2021 12:36:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YGNOruQFFvD0fgBb@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Moritz,

On 3/30/21 11:15 AM, Moritz Fischer wrote:
> Hi Richard,
> 
> On Tue, Mar 30, 2021 at 09:33:05AM -0500, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Extend Intel service layer driver to get the firmware version running at
>> FPGA device. Therefore FPGA manager driver, one of Intel service layer
>> driver's client, can decide whether to handle the newly added bitstream
>> authentication function based on the retrieved firmware version.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> Acked-by: Moritz Fischr <mdf@kernel.org>
>> ---
>>   drivers/firmware/stratix10-svc.c                    | 12 ++++++++++--
>>   include/linux/firmware/intel/stratix10-smc.h        | 21 +++++++++++++++++++--
>>   include/linux/firmware/intel/stratix10-svc-client.h |  4 ++++
>>   3 files changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
>> index 3aa489d..1443bbd 100644
>> --- a/drivers/firmware/stratix10-svc.c
>> +++ b/drivers/firmware/stratix10-svc.c
>> @@ -306,6 +306,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
>>   		break;
>>   	case COMMAND_RSU_RETRY:
>>   	case COMMAND_RSU_MAX_RETRY:
>> +	case COMMAND_FIRMWARE_VERSION:
>>   		cb_data->status = BIT(SVC_STATUS_OK);
>>   		cb_data->kaddr1 = &res.a1;
>>   		break;
>> @@ -422,6 +423,11 @@ static int svc_normal_to_secure_thread(void *data)
>>   			a1 = 0;
>>   			a2 = 0;
>>   			break;
>> +		case COMMAND_FIRMWARE_VERSION:
>> +			a0 = INTEL_SIP_SMC_FIRMWARE_VERSION;
>> +			a1 = 0;
>> +			a2 = 0;
>> +			break;
>>   		default:
>>   			pr_warn("it shouldn't happen\n");
>>   			break;
>> @@ -487,11 +493,13 @@ static int svc_normal_to_secure_thread(void *data)
>>   
>>   			/*
>>   			 * be compatible with older version firmware which
>> -			 * doesn't support RSU notify or retry
>> +			 * doesn't support RSU notify, retry or bitstream
>> +			 * authentication.
>>   			 */
>>   			if ((pdata->command == COMMAND_RSU_RETRY) ||
>>   			    (pdata->command == COMMAND_RSU_MAX_RETRY) ||
>> -				(pdata->command == COMMAND_RSU_NOTIFY)) {
>> +			    (pdata->command == COMMAND_RSU_NOTIFY) ||
>> +			    (pdata->command == COMMAND_FIRMWARE_VERSION)) {
>>   				cbdata->status =
>>   					BIT(SVC_STATUS_NO_SUPPORT);
>>   				cbdata->kaddr1 = NULL;
>> diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
>> index c3e5ab0..505fcca 100644
>> --- a/include/linux/firmware/intel/stratix10-smc.h
>> +++ b/include/linux/firmware/intel/stratix10-smc.h
>> @@ -321,8 +321,6 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
>>   #define INTEL_SIP_SMC_ECC_DBE \
>>   	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_ECC_DBE)
>>   
>> -#endif
>> -
>>   /**
>>    * Request INTEL_SIP_SMC_RSU_NOTIFY
>>    *
>> @@ -404,3 +402,22 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
>>   #define INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY 18
>>   #define INTEL_SIP_SMC_RSU_MAX_RETRY \
>>   	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY)
>> +
>> +/**
>> + * Request INTEL_SIP_SMC_FIRMWARE_VERSION
>> + *
>> + * Sync call used to query the version of running firmware
>> + *
>> + * Call register usage:
>> + * a0 INTEL_SIP_SMC_FIRMWARE_VERSION
>> + * a1-a7 not used
>> + *
>> + * Return status:
>> + * a0 INTEL_SIP_SMC_STATUS_OK or INTEL_SIP_SMC_STATUS_ERROR
>> + * a1 running firmware version
>> + */
>> +#define INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION 31
>> +#define INTEL_SIP_SMC_FIRMWARE_VERSION \
>> +	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION)
>> +
>> +#endif
>> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
>> index 19781b0f..18c1841 100644
>> --- a/include/linux/firmware/intel/stratix10-svc-client.h
>> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
>> @@ -104,6 +104,9 @@ struct stratix10_svc_chan;
>>    *
>>    * @COMMAND_RSU_DCMF_VERSION: query firmware for the DCMF version, return status
>>    * is SVC_STATUS_OK or SVC_STATUS_ERROR
>> + *
>> + * @COMMAND_FIRMWARE_VERSION: query running firmware version, return status
>> + * is SVC_STATUS_OK or SVC_STATUS_ERROR
>>    */
>>   enum stratix10_svc_command_code {
>>   	COMMAND_NOOP = 0,
>> @@ -117,6 +120,7 @@ enum stratix10_svc_command_code {
>>   	COMMAND_RSU_RETRY,
>>   	COMMAND_RSU_MAX_RETRY,
>>   	COMMAND_RSU_DCMF_VERSION,
>> +	COMMAND_FIRMWARE_VERSION,
>>   };
>>   
>>   /**
>> -- 
>> 2.7.4
>>
> 
> Let's hold off on this patch until we have sorted the rest of this patch
> series out. As it stands it doesn't have a in-tree user.
> OK,

Regards,
Richard

> Thanks,
> Moritz
> 
