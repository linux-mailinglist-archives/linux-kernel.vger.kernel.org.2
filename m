Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACA53710B1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 05:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhECDf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 23:35:59 -0400
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com ([40.107.223.64]:49728
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232190AbhECDf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 23:35:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGx621CkC718QrrSH7KzXdWFvVbrJGQ0UEWeIAnPT2nRTgUEBiYutEzO9abJ0/AtmT8WoYVhVH8AlXxnur1hJ3BurityytEIc9sYu0F9yIBF/xTUGgyq93ZpNQxdtF9sIZMzQlr1pfhFu5LuYPcUPPQIS54yZOcLM1qWLQaFLpVAAH19BR4h5rIrwkQKZqvxmOh8sRilLW80Cfjn3l61AbZbnKVYyb5cSvefGzlw8FtHebjT7/yI+2GU45/xIDDxPwBVnEqb6bTtIu+1+exv9nuXqHdLlmElvW6E0Pd7RTsfqWRgkSbhPbvuHN63+v+S/Rz0S3e6a0GITBcx6o+5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jyQktunGoJfE5hkYnfuVRSRrttyMnwcPxmI94KOhY8=;
 b=B3+rdONkFyxXPv1RrqRpK1+sIk9V3P7UXIhad7mmn20OReEXzCHd/CvT3sm7ViENCeG+XrbHPJVd1gbxoFwfJ7nrOFvb9PhWfH70xUOIFfj56lWx4FEMFE5tK8kZcM2BbZ3tX8Y0CoXDgloIMKHACarLKVNbSao17oPvkjdIcSIhoQIWyF+yT90wqANNUhO5Ckc0gwfJ1kj2OdJXxrtUzhiDVdCnvbT4w2i2vxF89AD2wUH34eq0/K8yXOzddv0zyeh1ENVnFL8q2bxIng11KTvYmmyRz33us2bbg6hsadQW/SdVkWE5/wj5GtP5eJwhYyqS6fQRfRbrDZ5gOlSbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jyQktunGoJfE5hkYnfuVRSRrttyMnwcPxmI94KOhY8=;
 b=mg3W1LuWZ8HeZmNBjJpAHciPyS6dW2JaJWZdDMLbPnKZQub/sKl+e9PBxe8MFQmiLn2fAZT4lFKh6E1tUW/Bi012tHlkAhkElEyHsTVVRxnopu+VH3Gn3fEEXcBli5COMI3UMLL2ujxOyZdFJ5bd3h8SJ1OTuoaChLWHxKiLmUs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.26; Mon, 3 May
 2021 03:35:03 +0000
Received: from SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::6999:4ad6:8648:9c8b]) by SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::6999:4ad6:8648:9c8b%4]) with mapi id 15.20.4065.038; Mon, 3 May 2021
 03:35:02 +0000
Subject: Re: [PATCH v3] tee: amdtee: unload TA only when its refcount becomes
 0
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Mythri Pandeshwara krishna <mythri.pandeshwarakrishna@amd.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <5057c53afb568fa70234de2f23b0ffeff75af426.1618421014.git.Rijo-john.Thomas@amd.com>
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
Message-ID: <5072c20c-7912-4307-6e04-caa1fe54bf1a@amd.com>
Date:   Mon, 3 May 2021 09:04:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <5057c53afb568fa70234de2f23b0ffeff75af426.1618421014.git.Rijo-john.Thomas@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::36) To SN6PR12MB4719.namprd12.prod.outlook.com
 (2603:10b6:805:e9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.138.129.146] (165.204.156.251) by MAXPR01CA0118.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26 via Frontend Transport; Mon, 3 May 2021 03:35:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a6eb3f6-a1a2-44d1-0ddb-08d90de46f9c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2493AC712D4EF38D04A73671CF5B9@SN1PR12MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzzWWDNRxqA+zRrVqsVIspv7cfpAokpMlEOYf52sSdDYUAHuf73CL6m4SZGx3XJAZ9ujW+VneHOcKBBXcpTZWe/R8PoyzC5KvysHsQcRF3Tz/Z2PF7THSXRLMp1l5XeMl3upZKBs8J6beJGhlvUUnX94sTo1sVPeuxT5ThANj4mufdsQpSbaiyH1M6JjjvfeY8k4JlTA7CmM/ZD8Li/DUq875iEeOzQmCO2WP+eIgatG81tJPEAgHn14GBXHgFdYgrxy2hyz5M+lF1zs/SPn/+oLZ1QEkQwOIOZxPsajjHEPHNC9cldvFJ3bBHr1/bpY2OteFWFzGVhBrpzgnTw5vD4S7QTKDsf9mzmb4NSecegg/wNeaZthUP8BamW2Q586shM+mF3PjRtjEPTKuDeYG3zHF3Y0xVbXHMWAh6lUgRPuoMMtZ8ItNGW4+3N1ut8zP2WUXEZR7zlTZ+UM5w8i4kbLvxDMKyR7rt9wOI8PS8buIElk21C3ZwFhO5hcGIh7aWa8qOfOrns4M/xx5T7mSAN8ujtAtbAPcbEnqFIuc36GPaeEjWK+Av/a7QY0uNdDvIDoVAgEZhtxM3x52HWMHQh5MNO5Gi+szfDYGvRJsiBBcshQ2a1aj3cdmQzsibJgchGjsvHcCjdkQnWlOxHwLxtUJyoNO1JHhOVezCkVPWvseIBesg0Ks1WGhaSsdzW/SWfITs+fuc+Xmg/dlIrXEBHpAdQF5G5ybEWktEdpiQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(53546011)(36756003)(6666004)(6486002)(31696002)(2906002)(31686004)(316002)(110136005)(38350700002)(8936002)(54906003)(66946007)(66476007)(8676002)(38100700002)(52116002)(16526019)(186003)(5660300002)(478600001)(2616005)(83380400001)(16576012)(26005)(4326008)(86362001)(956004)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NmJYZWFydG5tMVVFeHNvM0NweHlVWE1EYk1JQ1kxNW8zU3I2QnlIZ3BaU2JZ?=
 =?utf-8?B?M0ttcGU1K3hnaENqVGs0bXJVZlhtRWRrbjdhRVYrTUlvTitLU3VIR2pzckFm?=
 =?utf-8?B?YWFGZk5vY2NkczJjVE1TWXdCczBaRjRzajVNRXZvdyt3NG5JTTZXRE1wRjZ0?=
 =?utf-8?B?cjFMalNxajYzVnRORXhwOUlXbm5HcEYvNTFGcFQ4QjlXVElqdmFyc1pOczZV?=
 =?utf-8?B?VUlmR0FtUGhPdzMxRGRTSStTR1lzSUdtYS90aFVxUXlqV0JqSGFUWWdIYk5P?=
 =?utf-8?B?YTl5cGVEOElhQ1ZkdHBNanR4RitXbzgwRGdsS2JQZk12OXZ0SzBhdXgvWnRj?=
 =?utf-8?B?Tml4SHF1ci9xM0tPOFE5bFowYlZiUU95V3Nzc1BtdmwySFhWUzFLeUc4Y1Ey?=
 =?utf-8?B?UkVYVGw5c05WNkVuVTErN0xTcGNBZU5QYS9lRGZaU0xsdmN6a1phMVlwV3dy?=
 =?utf-8?B?ZU9KZlVNcjREQ2kycVNHVGtMb2lnd1huTWJSYXlEV2xSdnZCK2tHN1pTdkMw?=
 =?utf-8?B?ZFhPcjl6UU1nMEVGQXoySUk3VERzbDNValgvYTJkV09UcHI3Yjd2Q1pzRVVp?=
 =?utf-8?B?MnI1SlBkbGh4SndiNDBuMWx6aXJKU2RiTFgwaWVEeGtESmNwRUlramdDV3A3?=
 =?utf-8?B?UWtnT05wcE14VXRCSXEwRzNJTEgveW0rS2YzQWpBdk5aU1ltbTl2aTdNTUJQ?=
 =?utf-8?B?aW1iWkxNengxZFBVbVNac1BOKzZCTHdWVDNyOTZpMDNpV3JCSWtacmwraFJo?=
 =?utf-8?B?RHExNXMzYTlyd0ZSVFowYk5lYUtMREtxMXZEem5PenFxeGJaVzcwR01rSmVT?=
 =?utf-8?B?NkU3SUtJc3l4clE5WlY5SzZDVjlxZ0xUM1YzNG02SURVbDB3Zkk0Qnh6dDY2?=
 =?utf-8?B?NEVwc1Zvb3RzejhtYzZxSHgyc2FBMitHNUx6SFlFL1c0WnI1RWgwdzJ5Rmx1?=
 =?utf-8?B?NmtsUGlvdG0yNzlPTDZtdzg3dWYzd1pjeGw1SDRwZEZtQzdlYllnQXgwSWdp?=
 =?utf-8?B?LzZhaTNWRUs4Q01idzNqbnZVUVJHQnBVY0QwVmNmaDN6cnpwSFNyNzNDbUIy?=
 =?utf-8?B?TG05UDlzM2J3eVpZbUlqdmMzeWlQNWFOOXMzdjVjZjJnRTVMeDNTWGpXbzN2?=
 =?utf-8?B?U2xrOVk0Zk80RU1mK1lmNjJiOFhuVzRHTCtGbzdoTzM1Rmd4SHRsSDVJQW1a?=
 =?utf-8?B?N1JzNjl6Y2dhNWhKSnA4QTN1eTRVQWxaWHN0TnRoS21WWmRCMXE2UTBqRzhW?=
 =?utf-8?B?dmppRmIwM3g0NHNhdk1SYS9iLzYyUThaTUpkc3BCQy8yd3JERVdScDdCTTRo?=
 =?utf-8?B?a1dwanlmaE9xWlAzZkhTWk11aTdQbXFoQjJibWx2S3k4RDE1T2kyd0dYWUh5?=
 =?utf-8?B?RG9LWXo2ZHgzSFdjT3lyWW90alhEeENCL1N0Y25TVHYvMHl2QkZJYSs4cjVy?=
 =?utf-8?B?dFJjSXNpOC9ESkhUQ2NUMTRwZEFzbWdOQ0U0Ly9jU3NLaXBteDlwcE5wb1pQ?=
 =?utf-8?B?cXZSdk81TUtGNDdGNEV0bitnMkovRDY4dUxGUnpJTkh1bWcvOU5jK0Y3OENW?=
 =?utf-8?B?YVM0R1dEUE5QRDIvMVhNVGNZZmlTNjNQMjhSTjFOZEI2bDV4TTJnQjY5aEMw?=
 =?utf-8?B?M0JFejl2SVVLMFNvenFNTmpGT0N1eTVmN2t3TUlTTUU1UWZFeTFOdzJNd1hq?=
 =?utf-8?B?KzN2dFVseUZQUHZQaWJveXpnSzVLVFRGWVNFeENXOVJDaVMwbFRVVGhrY0hp?=
 =?utf-8?Q?zqHaZhxlAR3eR9HdulDAc55panbGuf8em/qIOx5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6eb3f6-a1a2-44d1-0ddb-08d90de46f9c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 03:35:02.8337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5l8mnyoVbA84DlpPVs6/KpwCrb63P6zbGiAhAc2LNeTCJ9JhKOzpLVgXZRDGsTWv1C0rjRCJm/J3ix5niv7Vyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/04/21 11:08 pm, Rijo Thomas wrote:
> Same Trusted Application (TA) can be loaded in multiple TEE contexts.
> 
> If it is a single instance TA, the TA should not get unloaded from AMD
> Secure Processor, while it is still in use in another TEE context.
> 
> Therefore reference count TA and unload it when the count becomes zero.
> 
> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

Hi Dan,

Can you please give an Ack if you are okay with this patch.
I have incorporated your review comments for v2.

Thanks,
Rijo

> ---
> v3:
>  * Updated structure initialization list from {0} to preferred
>    style {}
> 
> v2:
>  * Unload TA if get_ta_refcount() fails
> 
>  drivers/tee/amdtee/amdtee_private.h | 13 ++++
>  drivers/tee/amdtee/call.c           | 94 ++++++++++++++++++++++++++---
>  drivers/tee/amdtee/core.c           | 15 +++--
>  3 files changed, 106 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdtee_private.h
> index 337c8d82f74e..6d0f7062bb87 100644
> --- a/drivers/tee/amdtee/amdtee_private.h
> +++ b/drivers/tee/amdtee/amdtee_private.h
> @@ -21,6 +21,7 @@
>  #define TEEC_SUCCESS			0x00000000
>  #define TEEC_ERROR_GENERIC		0xFFFF0000
>  #define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
> +#define TEEC_ERROR_OUT_OF_MEMORY	0xFFFF000C
>  #define TEEC_ERROR_COMMUNICATION	0xFFFF000E
> 
>  #define TEEC_ORIGIN_COMMS		0x00000002
> @@ -93,6 +94,18 @@ struct amdtee_shm_data {
>  	u32     buf_id;
>  };
> 
> +/**
> + * struct amdtee_ta_data - Keeps track of all TAs loaded in AMD Secure
> + *			   Processor
> + * @ta_handle:	Handle to TA loaded in TEE
> + * @refcount:	Reference count for the loaded TA
> + */
> +struct amdtee_ta_data {
> +	struct list_head list_node;
> +	u32 ta_handle;
> +	u32 refcount;
> +};
> +
>  #define LOWER_TWO_BYTE_MASK	0x0000FFFF
> 
>  /**
> diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
> index 096dd4d92d39..07f36ac834c8 100644
> --- a/drivers/tee/amdtee/call.c
> +++ b/drivers/tee/amdtee/call.c
> @@ -121,15 +121,69 @@ static int amd_params_to_tee_params(struct tee_param *tee, u32 count,
>  	return ret;
>  }
> 
> +static DEFINE_MUTEX(ta_refcount_mutex);
> +static struct list_head ta_list = LIST_HEAD_INIT(ta_list);
> +
> +static u32 get_ta_refcount(u32 ta_handle)
> +{
> +	struct amdtee_ta_data *ta_data;
> +	u32 count = 0;
> +
> +	/* Caller must hold a mutex */
> +	list_for_each_entry(ta_data, &ta_list, list_node)
> +		if (ta_data->ta_handle == ta_handle)
> +			return ++ta_data->refcount;
> +
> +	ta_data = kzalloc(sizeof(*ta_data), GFP_KERNEL);
> +	if (ta_data) {
> +		ta_data->ta_handle = ta_handle;
> +		ta_data->refcount = 1;
> +		count = ta_data->refcount;
> +		list_add(&ta_data->list_node, &ta_list);
> +	}
> +
> +	return count;
> +}
> +
> +static u32 put_ta_refcount(u32 ta_handle)
> +{
> +	struct amdtee_ta_data *ta_data;
> +	u32 count = 0;
> +
> +	/* Caller must hold a mutex */
> +	list_for_each_entry(ta_data, &ta_list, list_node)
> +		if (ta_data->ta_handle == ta_handle) {
> +			count = --ta_data->refcount;
> +			if (count == 0) {
> +				list_del(&ta_data->list_node);
> +				kfree(ta_data);
> +				break;
> +			}
> +		}
> +
> +	return count;
> +}
> +
>  int handle_unload_ta(u32 ta_handle)
>  {
>  	struct tee_cmd_unload_ta cmd = {0};
> -	u32 status;
> +	u32 status, count;
>  	int ret;
> 
>  	if (!ta_handle)
>  		return -EINVAL;
> 
> +	mutex_lock(&ta_refcount_mutex);
> +
> +	count = put_ta_refcount(ta_handle);
> +
> +	if (count) {
> +		pr_debug("unload ta: not unloading %u count %u\n",
> +			 ta_handle, count);
> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +
>  	cmd.ta_handle = ta_handle;
> 
>  	ret = psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA, (void *)&cmd,
> @@ -137,8 +191,12 @@ int handle_unload_ta(u32 ta_handle)
>  	if (!ret && status != 0) {
>  		pr_err("unload ta: status = 0x%x\n", status);
>  		ret = -EBUSY;
> +	} else {
> +		pr_debug("unloaded ta handle %u\n", ta_handle);
>  	}
> 
> +unlock:
> +	mutex_unlock(&ta_refcount_mutex);
>  	return ret;
>  }
> 
> @@ -340,7 +398,8 @@ int handle_open_session(struct tee_ioctl_open_session_arg *arg, u32 *info,
> 
>  int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
>  {
> -	struct tee_cmd_load_ta cmd = {0};
> +	struct tee_cmd_unload_ta unload_cmd = {};
> +	struct tee_cmd_load_ta load_cmd = {};
>  	phys_addr_t blob;
>  	int ret;
> 
> @@ -353,21 +412,36 @@ int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
>  		return -EINVAL;
>  	}
> 
> -	cmd.hi_addr = upper_32_bits(blob);
> -	cmd.low_addr = lower_32_bits(blob);
> -	cmd.size = size;
> +	load_cmd.hi_addr = upper_32_bits(blob);
> +	load_cmd.low_addr = lower_32_bits(blob);
> +	load_cmd.size = size;
> 
> -	ret = psp_tee_process_cmd(TEE_CMD_ID_LOAD_TA, (void *)&cmd,
> -				  sizeof(cmd), &arg->ret);
> +	mutex_lock(&ta_refcount_mutex);
> +
> +	ret = psp_tee_process_cmd(TEE_CMD_ID_LOAD_TA, (void *)&load_cmd,
> +				  sizeof(load_cmd), &arg->ret);
>  	if (ret) {
>  		arg->ret_origin = TEEC_ORIGIN_COMMS;
>  		arg->ret = TEEC_ERROR_COMMUNICATION;
> -	} else {
> -		set_session_id(cmd.ta_handle, 0, &arg->session);
> +	} else if (arg->ret == TEEC_SUCCESS) {
> +		ret = get_ta_refcount(load_cmd.ta_handle);
> +		if (!ret) {
> +			arg->ret_origin = TEEC_ORIGIN_COMMS;
> +			arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
> +
> +			/* Unload the TA on error */
> +			unload_cmd.ta_handle = load_cmd.ta_handle;
> +			psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
> +					    (void *)&unload_cmd,
> +					    sizeof(unload_cmd), &ret);
> +		} else {
> +			set_session_id(load_cmd.ta_handle, 0, &arg->session);
> +		}
>  	}
> +	mutex_unlock(&ta_refcount_mutex);
> 
>  	pr_debug("load TA: TA handle = 0x%x, RO = 0x%x, ret = 0x%x\n",
> -		 cmd.ta_handle, arg->ret_origin, arg->ret);
> +		 load_cmd.ta_handle, arg->ret_origin, arg->ret);
> 
>  	return 0;
>  }
> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> index 8a6a8f30bb42..da6b88e80dc0 100644
> --- a/drivers/tee/amdtee/core.c
> +++ b/drivers/tee/amdtee/core.c
> @@ -59,10 +59,9 @@ static void release_session(struct amdtee_session *sess)
>  			continue;
> 
>  		handle_close_session(sess->ta_handle, sess->session_info[i]);
> +		handle_unload_ta(sess->ta_handle);
>  	}
> 
> -	/* Unload Trusted Application once all sessions are closed */
> -	handle_unload_ta(sess->ta_handle);
>  	kfree(sess);
>  }
> 
> @@ -224,8 +223,6 @@ static void destroy_session(struct kref *ref)
>  	struct amdtee_session *sess = container_of(ref, struct amdtee_session,
>  						   refcount);
> 
> -	/* Unload the TA from TEE */
> -	handle_unload_ta(sess->ta_handle);
>  	mutex_lock(&session_list_mutex);
>  	list_del(&sess->list_node);
>  	mutex_unlock(&session_list_mutex);
> @@ -238,7 +235,7 @@ int amdtee_open_session(struct tee_context *ctx,
>  {
>  	struct amdtee_context_data *ctxdata = ctx->data;
>  	struct amdtee_session *sess = NULL;
> -	u32 session_info;
> +	u32 session_info, ta_handle;
>  	size_t ta_size;
>  	int rc, i;
>  	void *ta;
> @@ -259,11 +256,14 @@ int amdtee_open_session(struct tee_context *ctx,
>  	if (arg->ret != TEEC_SUCCESS)
>  		goto out;
> 
> +	ta_handle = get_ta_handle(arg->session);
> +
>  	mutex_lock(&session_list_mutex);
>  	sess = alloc_session(ctxdata, arg->session);
>  	mutex_unlock(&session_list_mutex);
> 
>  	if (!sess) {
> +		handle_unload_ta(ta_handle);
>  		rc = -ENOMEM;
>  		goto out;
>  	}
> @@ -277,6 +277,7 @@ int amdtee_open_session(struct tee_context *ctx,
> 
>  	if (i >= TEE_NUM_SESSIONS) {
>  		pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
> +		handle_unload_ta(ta_handle);
>  		kref_put(&sess->refcount, destroy_session);
>  		rc = -ENOMEM;
>  		goto out;
> @@ -289,12 +290,13 @@ int amdtee_open_session(struct tee_context *ctx,
>  		spin_lock(&sess->lock);
>  		clear_bit(i, sess->sess_mask);
>  		spin_unlock(&sess->lock);
> +		handle_unload_ta(ta_handle);
>  		kref_put(&sess->refcount, destroy_session);
>  		goto out;
>  	}
> 
>  	sess->session_info[i] = session_info;
> -	set_session_id(sess->ta_handle, i, &arg->session);
> +	set_session_id(ta_handle, i, &arg->session);
>  out:
>  	free_pages((u64)ta, get_order(ta_size));
>  	return rc;
> @@ -329,6 +331,7 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
> 
>  	/* Close the session */
>  	handle_close_session(ta_handle, session_info);
> +	handle_unload_ta(ta_handle);
> 
>  	kref_put(&sess->refcount, destroy_session);
> 
> --
> 2.17.1
> 
