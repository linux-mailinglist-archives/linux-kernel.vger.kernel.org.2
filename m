Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731D0353C1F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 08:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhDEGwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 02:52:37 -0400
Received: from mail-bn8nam11on2083.outbound.protection.outlook.com ([40.107.236.83]:17089
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232282AbhDEGwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 02:52:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGjIqJBOZszdEfSjNzDeBDLlEvrPeDW1TQIlCQOq/UA/dI1YWT9kuKnPGgURrVmTRmhhV4mDtsbDzz4jfgIxAFfmaC318+Z5EzhtoQeAn013wUCwoSv/jyoYoUZTPeqzKp+YX0MVqAGMv38to8SB6WIJYicp0b75oqxe75FgKRlxxX0iNJF0Uqk58cF6tp09bgXPmKfT3975krHzZnOCzq/ZJbgydRJCtegNcDVbRKDBtgla/36Ciy84HIMQw96IYp0ycclCWbjS8i8mKC2oP2Rz3QWqpk9rHASaK6+QYSaSZmJuBl1AURJpeTvbYs+GUNKJhnjeOCUmBupLhvRZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UgyrSaNxSS8sDmLGva3gcQAynYWMob2p1uksu3o298=;
 b=EZTXirLt10PhDOso6nzjfYyC0Q1imX4FO8DnLb7KEB+Yw1ePdcZwkenMSfVXlHG/Nez//4rWr4Je0SRLBQjZe6rivsyQuuvEjGet0BlIG4ZrLpvhYvEJIYPSyPnH5C100BKZXgrx14dGyqJE+yXQTeKOMsaRXubUMTBz4tHRUwb31kxTIHDHrc2JPLGu3EcxZmVAbTzN4CTJ9t+bD8gzOz3PQLnn6S3oPu0eMtkiaHYJ6/wAOvIyZYf32bF3tfbMX6V7BwCq6sjWkyPw4g3Ovef+JzLJR7m6Hyz9kIj2dXREvY9TYk125AeOlha7AzJY5HPbO8MWt1tqzgCVVYoB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UgyrSaNxSS8sDmLGva3gcQAynYWMob2p1uksu3o298=;
 b=kDctCVq+dzgZ40DYB2fFkyKvII4epOdkuhoJCCDbtWN7XelfjciKZqvTc6zvp3ljYzMZpVL3eBNDA9GEUFrzEuvZn95ouTvzt/aCqE5cqKlXd3mW44DtkU1oQl5tnT+vlRGzEhnnV1P2LKoMHDN05YzAAaB4L4od5e9fAbatc8c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25)
 by SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Mon, 5 Apr
 2021 06:52:25 +0000
Received: from SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::6999:4ad6:8648:9c8b]) by SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::6999:4ad6:8648:9c8b%4]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 06:52:25 +0000
Subject: Re: [PATCH] tee: amdtee: unload TA only when its refcount becomes 0
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <4fafc43b8b6bb779fea87ecc5579afaab8a5f3ad.1615097779.git.Rijo-john.Thomas@amd.com>
 <20210315092910.GA1707987@jade>
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
Message-ID: <43565cf5-176b-c356-929b-61d59874aba0@amd.com>
Date:   Mon, 5 Apr 2021 12:22:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210315092910.GA1707987@jade>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR0101CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::14) To SN6PR12MB4719.namprd12.prod.outlook.com
 (2603:10b6:805:e9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.138.129.146] (165.204.156.251) by MAXPR0101CA0004.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Mon, 5 Apr 2021 06:52:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba5115d6-a101-4250-0e44-08d8f7ff5ef4
X-MS-TrafficTypeDiagnostic: SN6PR12MB4720:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4720CDD3337F54FE8E725331CF779@SN6PR12MB4720.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5/vGxeEulB9Rc6LTnoH0Ccz1Ro5Vf0nwnNRDHyBFt/ZTmapaW4yNEXhXAIyweFnMawqWtfAPWLYPYc53NIVCEFgysCEMh2vdt7voVKngJK5pAFOCfRfxtcpUSDeFRDfVYUr0Loyb8H+JdXzFPenUnzxsl0i1cMyAj2a+AhU9NKT+DRfOmlAnuqHfsJbzZKGsHG635T3+vAAz24/xtoubx9nEDYBXhyMvzts5jyBewb6AIK7iTOVPASUCeuF5Zf9gMzEZxacUPXsyq+eO3k4B7mKHrpRwhGrNn3sZnvWmEzybMjN9UuI4RnoULWFHdq1JzE+a1QQYCDRHaLdSpAuPYS1laH+BsByZBaAO1d8Pg8JmEL0sOa4ph4RnCvsgfmbohTO/KEDuQkZr4AynZPdWUuqX9luaWdU5gMSBaxkpS1P6NRpLX0AD5ZqMdtrNuEYPayQpbjKjLnQjGHl8SkeCrK9XWbLRQ6kBP5ClGhyzIpb5Pqtbp9YcNIAgceXknPA+z6woJLmZa4kPLi2U83QweUe9jtHmnGlxTITXQsZq6oAXBk3lNtdg7O+wboI2ulE/S+/KGgCKOzRiImNRN8+k21vEzB8nT7hUpNp0iDtZEP0g6EqxUXW6QRLzSEOrNDSCEl17bG1pyx0a3opweEW0d5U6dDOwZTZJtjLSXa3cpg21/S4FymqM2dFglhbBb8kJGZ+/WmLlqZ/X1RJZ9TvDKhISlYNsHwsw1ZyFyFtn5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(956004)(2616005)(478600001)(8936002)(8676002)(6486002)(31686004)(6666004)(316002)(54906003)(16576012)(52116002)(38100700001)(4326008)(5660300002)(86362001)(2906002)(186003)(16526019)(66476007)(66556008)(83380400001)(26005)(36756003)(66946007)(53546011)(31696002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MnNLUWpKd2laM2dKdXVjblQrTVlCWHUrV2ZGUnF5bU1jR1QydHhiRWFia2Q0?=
 =?utf-8?B?R1ErUXgrYmdUYzVLaDJFSXNvU2pRckZyL0xBUlNIeTFmZ0hheU9JQm5vQ0wz?=
 =?utf-8?B?bi92b1NHUjA3dlg4VnNxdkZaRER4aEJNV1JBelhVbTRYenp5TUJuakxmWHhk?=
 =?utf-8?B?ZG94dnVYbk5DRUFwaDJ0RHZwWmxqYU1ZZUhHcGRmbGlWWXF6akF4T2h2Wndq?=
 =?utf-8?B?eHFDV2RacndCeWRZc3d0RmJqa0ZIMkZEcVR5UWdYay9pRVovdWdQY21OcFpn?=
 =?utf-8?B?UnJIVEtXd0kxOWlQRHlVMkthZENtQXBFS1lKQy9yaXNXMUZzS1pQcVl2VHFD?=
 =?utf-8?B?ckxWY2tGZC9DVUtxVHhsZUpjRU5HMmhmN3grT1VoV1JNL09IZzZveVJRUjYr?=
 =?utf-8?B?N1ErYVZsaXl6RS9mb3h3UkFIVGkvM28xZlkrSUUwZjFUQXowMnluMU9IY2RK?=
 =?utf-8?B?Z2FWREw5aDV6ZXlMRGlQOHVieFgxa1JWR1hzcVRuTWRtL2VqNCsvSFJvTGlq?=
 =?utf-8?B?UW54WmJ4L0VicmRjTUNHeTVOanBxYXp4K0RudXRick1QbTRRRW9iNWNsRlVy?=
 =?utf-8?B?d0tEZjZVNjhIdCtLSldab2RtV2VzcUd3T3FrZ1o2ZDc0eWszN3J0ckZYTnUr?=
 =?utf-8?B?dTJ4bGZLckNqTlVvVGtUc2FkTDY3MDloRWxSZ2xzUEkyUWswVnhJS3kvNDB4?=
 =?utf-8?B?T3M3TTBXY1RzVFdlYUtTLzBmSFdvb3grMDRKR0lnS0NaeEI5bk5QZE84YTBh?=
 =?utf-8?B?bXBaU09RQmxMZERtTTNSTVhqL2JHQ0dIblJQajFydWxFbXAwdWQwY01lblBL?=
 =?utf-8?B?QktoY0RwSll0VDlYYmdNZEVYWHI3anFUMXhCcXA4OGdna3Z2YzVrK0lNNnVq?=
 =?utf-8?B?Z2JmUmNCWUZmYXVjdlp4Zk50OFpHdzhuclQ0eVIzYTYrSWREUU5oZG43WDNv?=
 =?utf-8?B?a2FhbkVMckZPdFhyWC9TWnFCcmNLbU8zb0IyZHRTV1JOSC9ScGJvbW83Tlcr?=
 =?utf-8?B?NTRlV1FTQ2hBT1dSQjhPc3dvVzY4cERUcyt5dUhmdEpuWncxbnRNSG1BblBi?=
 =?utf-8?B?Zjd6OWVGUkRpRWlHdjJHVlM4KytBNm1hV1BxOVRJWitieEw3RlpqaUtvWHE1?=
 =?utf-8?B?NnFCazc2UTVFQnZpWXlsUzg0Rk0ya3Ztb05qdGpXYjk2ZjZzWHA1bTRsbDk4?=
 =?utf-8?B?L2tGODNIQUxLVGh0bVA0S3ZSdFNSUmF1ZmlHaEVlalp0c05JTWJEdWNraTRC?=
 =?utf-8?B?YzB4dVMwMjJTQzhZQlBibVYycDVQd3lWeU5CM0FqMDIzN1F4MjIyanJFVmVo?=
 =?utf-8?B?aUR3eEdKZmUyM2ZucEdOM1N5VHdjOE53YnU3dEtuUTMvVkdMS0RsY3AvRldJ?=
 =?utf-8?B?VmFQc2UvcFhHZEhDTGdkaEY0cmQzK1JEODJVTXhjQlBGNTJRaUVwRkRITmxP?=
 =?utf-8?B?cmpHMzA1VDNYQ2pNUURJMThHYlpMcUgvSmNVVEpSZzQ4OHBmb1lnSnp5VHdD?=
 =?utf-8?B?SjBoVFljOHpqNGFHTElWK2hQeG9VaHRCY0o3Tzl3Wk9hbVRPYUVnUGlpd0pV?=
 =?utf-8?B?U2VqbmRLN0Ivdk9wQndTemxMWXUwdkJiVWVPZVdsZHl2YjZUUjJCbUxJQi9C?=
 =?utf-8?B?MGN4UVd2bVBwbjExb3NlOHl1aWxVMnRpQWF5eDUwZmxQSHgyWkxEYnpMcnlV?=
 =?utf-8?B?eFBiWng4ZTJ2Yk9vbFFpRkZzMWlndFA5QVp3dlhrL1BiampLdEkwamlHZ3pv?=
 =?utf-8?Q?wydCCCuAkXP7cw0cJmhIgP3St84JUPiAwStRTIc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5115d6-a101-4250-0e44-08d8f7ff5ef4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 06:52:25.8197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ewkNdCy7uYFaqA9bVY/oHJ/AlWhx7jbnE3fyuY10RGgEF6QJEC35sBGYTu/GMb50+6tOPb/FIyxhMUlc/FhWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4720
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/03/21 2:59 pm, Jens Wiklander wrote:
> On Sun, Mar 07, 2021 at 12:05:01PM +0530, Rijo Thomas wrote:
>> Same Trusted Application (TA) can be loaded in multiple TEE contexts.
>>
>> If it is a single instance TA, the TA should not get unloaded from AMD
>> Secure Processor, while it is still in use in another TEE context.
>>
>> Therefore reference count TA and unload it when the count becomes zero.
>>
>> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
>> Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
>> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
>> ---
>>  drivers/tee/amdtee/amdtee_private.h | 13 +++++
>>  drivers/tee/amdtee/call.c           | 73 +++++++++++++++++++++++++++--
>>  drivers/tee/amdtee/core.c           | 15 +++---
>>  3 files changed, 92 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdtee_private.h
>> index 337c8d82f74e..6d0f7062bb87 100644
>> --- a/drivers/tee/amdtee/amdtee_private.h
>> +++ b/drivers/tee/amdtee/amdtee_private.h
>> @@ -21,6 +21,7 @@
>>  #define TEEC_SUCCESS			0x00000000
>>  #define TEEC_ERROR_GENERIC		0xFFFF0000
>>  #define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
>> +#define TEEC_ERROR_OUT_OF_MEMORY	0xFFFF000C
>>  #define TEEC_ERROR_COMMUNICATION	0xFFFF000E
>>  
>>  #define TEEC_ORIGIN_COMMS		0x00000002
>> @@ -93,6 +94,18 @@ struct amdtee_shm_data {
>>  	u32     buf_id;
>>  };
>>  
>> +/**
>> + * struct amdtee_ta_data - Keeps track of all TAs loaded in AMD Secure
>> + *			   Processor
>> + * @ta_handle:	Handle to TA loaded in TEE
>> + * @refcount:	Reference count for the loaded TA
>> + */
>> +struct amdtee_ta_data {
>> +	struct list_head list_node;
>> +	u32 ta_handle;
>> +	u32 refcount;
>> +};
>> +
>>  #define LOWER_TWO_BYTE_MASK	0x0000FFFF
>>  
>>  /**
>> diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
>> index 096dd4d92d39..e10601417ea3 100644
>> --- a/drivers/tee/amdtee/call.c
>> +++ b/drivers/tee/amdtee/call.c
>> @@ -121,15 +121,69 @@ static int amd_params_to_tee_params(struct tee_param *tee, u32 count,
>>  	return ret;
>>  }
>>  
>> +static DEFINE_MUTEX(ta_refcount_mutex);
>> +static struct list_head ta_list = LIST_HEAD_INIT(ta_list);
>> +
>> +static u32 get_ta_refcount(u32 ta_handle)
>> +{
>> +	struct amdtee_ta_data *ta_data;
>> +	u32 count = 0;
>> +
>> +	/* Caller must hold a mutex */
>> +	list_for_each_entry(ta_data, &ta_list, list_node)
>> +		if (ta_data->ta_handle == ta_handle)
>> +			return ++ta_data->refcount;
>> +
>> +	ta_data = kzalloc(sizeof(*ta_data), GFP_KERNEL);
>> +	if (ta_data) {
>> +		ta_data->ta_handle = ta_handle;
>> +		ta_data->refcount = 1;
>> +		count = ta_data->refcount;
>> +		list_add(&ta_data->list_node, &ta_list);
>> +	}
>> +
>> +	return count;
>> +}
>> +
>> +static u32 put_ta_refcount(u32 ta_handle)
>> +{
>> +	struct amdtee_ta_data *ta_data;
>> +	u32 count = 0;
>> +
>> +	/* Caller must hold a mutex */
>> +	list_for_each_entry(ta_data, &ta_list, list_node)
>> +		if (ta_data->ta_handle == ta_handle) {
>> +			count = --ta_data->refcount;
>> +			if (count == 0) {
>> +				list_del(&ta_data->list_node);
>> +				kfree(ta_data);
>> +				break;
>> +			}
>> +		}
>> +
>> +	return count;
>> +}
>> +
>>  int handle_unload_ta(u32 ta_handle)
>>  {
>>  	struct tee_cmd_unload_ta cmd = {0};
>> -	u32 status;
>> +	u32 status, count;
>>  	int ret;
>>  
>>  	if (!ta_handle)
>>  		return -EINVAL;
>>  
>> +	mutex_lock(&ta_refcount_mutex);
>> +
>> +	count = put_ta_refcount(ta_handle);
>> +
>> +	if (count) {
>> +		pr_debug("unload ta: not unloading %u count %u\n",
>> +			 ta_handle, count);
>> +		ret = -EBUSY;
>> +		goto unlock;
>> +	}
>> +
>>  	cmd.ta_handle = ta_handle;
>>  
>>  	ret = psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA, (void *)&cmd,
>> @@ -137,8 +191,12 @@ int handle_unload_ta(u32 ta_handle)
>>  	if (!ret && status != 0) {
>>  		pr_err("unload ta: status = 0x%x\n", status);
>>  		ret = -EBUSY;
>> +	} else {
>> +		pr_debug("unloaded ta handle %u\n", ta_handle);
>>  	}
>>  
>> +unlock:
>> +	mutex_unlock(&ta_refcount_mutex);
>>  	return ret;
>>  }
>>  
>> @@ -357,14 +415,23 @@ int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
>>  	cmd.low_addr = lower_32_bits(blob);
>>  	cmd.size = size;
>>  
>> +	mutex_lock(&ta_refcount_mutex);
>> +
>>  	ret = psp_tee_process_cmd(TEE_CMD_ID_LOAD_TA, (void *)&cmd,
>>  				  sizeof(cmd), &arg->ret);
>>  	if (ret) {
>>  		arg->ret_origin = TEEC_ORIGIN_COMMS;
>>  		arg->ret = TEEC_ERROR_COMMUNICATION;
>> -	} else {
>> -		set_session_id(cmd.ta_handle, 0, &arg->session);
>> +	} else if (arg->ret == TEEC_SUCCESS) {
>> +		ret = get_ta_refcount(cmd.ta_handle);
>> +		if (!ret) {
> 
> If this occurs, how is the TA unloaded from secure world?
> 

Ack. Shall re-post update in next version.

Thanks,
Rijo

> Thanks, 
> Jens
> 
>> +			arg->ret_origin = TEEC_ORIGIN_COMMS;
>> +			arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
>> +		} else {
>> +			set_session_id(cmd.ta_handle, 0, &arg->session);
>> +		}
>>  	}
>> +	mutex_unlock(&ta_refcount_mutex);
>>  
>>  	pr_debug("load TA: TA handle = 0x%x, RO = 0x%x, ret = 0x%x\n",
>>  		 cmd.ta_handle, arg->ret_origin, arg->ret);
>> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
>> index 8a6a8f30bb42..da6b88e80dc0 100644
>> --- a/drivers/tee/amdtee/core.c
>> +++ b/drivers/tee/amdtee/core.c
>> @@ -59,10 +59,9 @@ static void release_session(struct amdtee_session *sess)
>>  			continue;
>>  
>>  		handle_close_session(sess->ta_handle, sess->session_info[i]);
>> +		handle_unload_ta(sess->ta_handle);
>>  	}
>>  
>> -	/* Unload Trusted Application once all sessions are closed */
>> -	handle_unload_ta(sess->ta_handle);
>>  	kfree(sess);
>>  }
>>  
>> @@ -224,8 +223,6 @@ static void destroy_session(struct kref *ref)
>>  	struct amdtee_session *sess = container_of(ref, struct amdtee_session,
>>  						   refcount);
>>  
>> -	/* Unload the TA from TEE */
>> -	handle_unload_ta(sess->ta_handle);
>>  	mutex_lock(&session_list_mutex);
>>  	list_del(&sess->list_node);
>>  	mutex_unlock(&session_list_mutex);
>> @@ -238,7 +235,7 @@ int amdtee_open_session(struct tee_context *ctx,
>>  {
>>  	struct amdtee_context_data *ctxdata = ctx->data;
>>  	struct amdtee_session *sess = NULL;
>> -	u32 session_info;
>> +	u32 session_info, ta_handle;
>>  	size_t ta_size;
>>  	int rc, i;
>>  	void *ta;
>> @@ -259,11 +256,14 @@ int amdtee_open_session(struct tee_context *ctx,
>>  	if (arg->ret != TEEC_SUCCESS)
>>  		goto out;
>>  
>> +	ta_handle = get_ta_handle(arg->session);
>> +
>>  	mutex_lock(&session_list_mutex);
>>  	sess = alloc_session(ctxdata, arg->session);
>>  	mutex_unlock(&session_list_mutex);
>>  
>>  	if (!sess) {
>> +		handle_unload_ta(ta_handle);
>>  		rc = -ENOMEM;
>>  		goto out;
>>  	}
>> @@ -277,6 +277,7 @@ int amdtee_open_session(struct tee_context *ctx,
>>  
>>  	if (i >= TEE_NUM_SESSIONS) {
>>  		pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
>> +		handle_unload_ta(ta_handle);
>>  		kref_put(&sess->refcount, destroy_session);
>>  		rc = -ENOMEM;
>>  		goto out;
>> @@ -289,12 +290,13 @@ int amdtee_open_session(struct tee_context *ctx,
>>  		spin_lock(&sess->lock);
>>  		clear_bit(i, sess->sess_mask);
>>  		spin_unlock(&sess->lock);
>> +		handle_unload_ta(ta_handle);
>>  		kref_put(&sess->refcount, destroy_session);
>>  		goto out;
>>  	}
>>  
>>  	sess->session_info[i] = session_info;
>> -	set_session_id(sess->ta_handle, i, &arg->session);
>> +	set_session_id(ta_handle, i, &arg->session);
>>  out:
>>  	free_pages((u64)ta, get_order(ta_size));
>>  	return rc;
>> @@ -329,6 +331,7 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
>>  
>>  	/* Close the session */
>>  	handle_close_session(ta_handle, session_info);
>> +	handle_unload_ta(ta_handle);
>>  
>>  	kref_put(&sess->refcount, destroy_session);
>>  
>> -- 
>> 2.17.1
>>
