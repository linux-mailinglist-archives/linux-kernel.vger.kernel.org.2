Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB25F3FE650
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbhIBAON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 20:14:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43432 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229898AbhIBAOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 20:14:12 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181M8Xw1018863;
        Thu, 2 Sep 2021 00:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fd+4XEEw5K6HhzJCnfDtjrUWcfN2UmGB67FMb1S8HkA=;
 b=kVDyjkIe/j6OpseyWtdfo407b03HFF/Smy0KBH7nqXQazd/WLj+iWcJHefF4eJub/p1T
 Ufuh8kHzHs7FnTn+rQ8ZchGqxO/1FMJx+Kni92yCoX/MDiY8t4BrNyflUFcygkTUWdoC
 caS5amkW4fOEsuz3IkiXE/QVa4Q1OiVTpmTlQ/UiLJt0kFut+jv4rFmAFZwOAVl/wsyT
 p1yXBFNGtjUH/XTK8u1Bbm86mcN3QnKWTNiiBWAQHX4IX/ElGGehnkQNYQqSMMOYdyog
 Ydghu2qiyre03hZnejxObOYMN37/KFBVuBNvz619MQI7Ki/gimV5muSTf89+eF+L2EeS kw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fd+4XEEw5K6HhzJCnfDtjrUWcfN2UmGB67FMb1S8HkA=;
 b=GX1zereBBaAuPer/QhdZjmzuzRzC3DUdOx/f2BhmL3Msmrc8YyalP2RT9V5272XRqs5n
 02xZvYSs32FL93bfxoAFrXBcUNFMXrnm2vM8egvS4I1Efzn9nHG0/ogxOsDD1PNjpFvm
 no4zJJY8ltcC3QjrojRch5toaAFttbnK2789wjAL9H+g7jehqKEy97JQiJcg3grwN8H8
 gpbZ9aZpAKKAUzAsTsvqJRio3fvyn+bGmmCkdKWt+h+ssWkQ6xbch4ztfDxkyXiJ/zn9
 hD8hdRpUhc8p0bqs5O1DLSQSa29TIi0eEYWy1swKkYKrtAa+5ulsx+vDR4P0HIkG7fIJ MQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdvygwuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 00:13:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18209nhu178454;
        Thu, 2 Sep 2021 00:13:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3030.oracle.com with ESMTP id 3atdyw5ynr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 00:13:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1YU5KovVjwluk135g7hdahtwbJuELgojWK6VB+jvpHOsSa/B38kyLnt8h1Wq6iG9Mvse/TWL3SVwPgbqHhiLDHqi3rtLoJfyHx4L+E2LeKz2F2AvU60SQfsBp844duZw0F+OadTQlRlN0wL7UrtJdbis279i+l8T3kzI2kb2r5OrMcGzJ3FeUbEv/Pfa2TgVMHAS6PpsYQIzMFeYnhpI7oEjaNKmn/JEMikunQuoEAWdpSV4O1TYo94CWmNyjElS7Mil84jXzPZJsuqCOKg6S6nITFP8eDV+6Kzy8QAur8r/YqwQuOXnt4Ik6qmkwcJPtAqDFMCejSKbJ+ROElI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fd+4XEEw5K6HhzJCnfDtjrUWcfN2UmGB67FMb1S8HkA=;
 b=TptTjVh1kRaFdlR6CS+uuIGAxnptyKnW5gqBmWw7ojv6tlRFqNWkEX/FQIvj8iM0RGrWV8YFK92AcVXGRBg3A+FEthWxRFiPnwczS4y74mf8ymLG8PNYWrc3oCp7MTgQZdSfuJBiRWOrz/32H8n0sC8n9/j/LpSuQCafTEtj9msn2GeODGj/qxaHDjNkMHjGegfeFKZ7MDPjDsm32/wQEPgB2MnxEiJho7JobuEAbcA5zfTi7cw3/OdMe/ZJfdXSLbpLyY4+3rD0rcb99z/+AQcCX0x86U8Hv5DddHImpDOQCk4SfBARUxkWg6MbdRJCVJdcCRGCf9vW3mLiH+gmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd+4XEEw5K6HhzJCnfDtjrUWcfN2UmGB67FMb1S8HkA=;
 b=EuY/jHnceww95WjkPBfWXad8M8Z3Q/M1FRHD+x3kH23HzHN7wvw4Hnuna32ZIMDFGfNNyPj5ny3omWUbI0fyWIfwOZzsJKjL1XAon0qw+ZXCCmNpZZ6s2Pi96Ejf9n5+/1U2Hclbxu9vZLY15aI3Wf6N8ucN9DSWS42YK711jW4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1374.namprd10.prod.outlook.com (2603:10b6:300:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 00:13:03 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e1f7:a0f4:46c5:3df]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e1f7:a0f4:46c5:3df%6]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 00:13:03 +0000
Subject: Re: [RFC PATCH 1/2] lib, stackdepot: check stackdepot handle before
 accessing slabs.
To:     Vlastimil Babka <vbabka@suse.cz>, geert@linux-m68k.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>
References: <20210901051914.971603-1-imran.f.khan@oracle.com>
 <20210901051914.971603-2-imran.f.khan@oracle.com>
 <78d24243-9d92-43fd-92b5-17b88cc24314@suse.cz>
From:   imran.f.khan@oracle.com
Message-ID: <b91439ae-8827-6d03-47be-4fa236cfd1ce@oracle.com>
Date:   Thu, 2 Sep 2021 10:12:58 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <78d24243-9d92-43fd-92b5-17b88cc24314@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0051.namprd08.prod.outlook.com
 (2603:10b6:a03:117::28) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
Received: from [10.191.132.27] (138.3.200.27) by BYAPR08CA0051.namprd08.prod.outlook.com (2603:10b6:a03:117::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Thu, 2 Sep 2021 00:13:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 432c3be2-feca-4300-6e52-08d96da66e69
X-MS-TrafficTypeDiagnostic: MWHPR10MB1374:
X-Microsoft-Antispam-PRVS: <MWHPR10MB13748496E2B2B5DBD25CC595B0CE9@MWHPR10MB1374.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Ykojf7DA7s3PlmQ2fFLkX2b6iKITA7UexjBXN9PlhD3bL2oAfoG12+q804cdNOUeCyFQ0iovJVhYPVchLw6yck/5wdg9hzqqDVtviSbNbGUmVG+uJqVPdaGk7klltybSjw4ZKbWe2S6DK1qBlDN6RxrlWEd3x0MiMz5ILxFTfGUr4m/sCuxLilflzaQlS1W2eRqCUdsYh4+8VHR6/n5sPMYj0K+MyAA1Cz+b6oQD/LEmtb0k9eHlKGVCNIqtEir4hTdtZ+kOMa1vwG3pfvmDiLJuhdxvx0B3rtVFhom6Q93iBzoJ3EuPCRqKRx00jQhqVKFvlcdmMUuo0CgtOvBFL8s3PZIE8aP5kWitAppGtmea6MvIS62RR2cjzjyE3zMy1+H1dBrjnVJ0ZdvG3Sp5u/mULGI46U3M/cEwh2E/ilMeiRQeaGDitlrpL0V/tlNmItIRJ6/W6oaOsadUa88BW3E+v9qMJeOKWEZJCJKGk0pk2lJRr5iIQLOBWT+PRs5gUGPXvUHkugnFmt3wG1S8qpzp3Xp4934fRPxGzUOaYmwXVPnocS74tB+lY4pOZF/lDMU3cRuhUJ5I/L9mcS51V3OGkwHAypyfn3JsZtYBn0w5KQB/bNQPrzm1BFoFFC+1rABlqYvnMZQrvUtPR4zbXxm2B91RzePIB6UtpswHlbZu//H3fnmpQq2QK9o3wfNXJ/YC3OvHGdjC0FXYf16Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(366004)(346002)(396003)(2906002)(31696002)(478600001)(83380400001)(4326008)(86362001)(38100700002)(36756003)(16576012)(316002)(53546011)(31686004)(26005)(186003)(54906003)(2616005)(956004)(6666004)(8676002)(9686003)(66946007)(8936002)(6486002)(5660300002)(66476007)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlZZVzc1NHhhU1VhOGlZN0lDUVREYWs3V0ZUUDlpY1VNRG9KS0xOdzR4c0Yr?=
 =?utf-8?B?Q3ZGNW5CcTRUbm0zeVB5Uzg2S3UzZVZnMEtPcjIzVE5UZUpDRVdWTnJTZGs3?=
 =?utf-8?B?a2NIMktlQ3h3YlJkcnNyanZWdGJWNkNEclFzeFdjRG9HMitHNFhWVUtubnlJ?=
 =?utf-8?B?TlMwOUxLUGt4T2owN3paLzJwVkd1TVE4TU1XOWwyc0xHbnhtdWZ6ZXE5cVRN?=
 =?utf-8?B?eGV3ODB2MjBaSGh4cGZnQU9zOFd4b2lEVmFPa0ZUbG8rYzVXWk9Xa25JbDcr?=
 =?utf-8?B?Wnl6SnBLMXdWY05xVERlQ2hHOW05MjUrWEtBMDhiYkEyOU1ZZWdPRGdGQmRy?=
 =?utf-8?B?eXBLUmFXVTRwenJ0OExXQnhUQUloU1V4T2xTbXZOd0R0bE5OUk5vd0RtZ2VJ?=
 =?utf-8?B?NXorYzh1aUZ3N1NWSTFxYTZVZThjUmlJbTRFaG5oaG5vOWtEaWcxbGlSYlQr?=
 =?utf-8?B?bDU0dkxvaWRGSDVPeTVtSk9YNlY4OFRzeWVkVDVaRVlrSDFpemhRQ2h3Y1J5?=
 =?utf-8?B?eVVoNTFOUVdLYUUzaXliYVR3VEV6aU9BNE1XalVJWi9QVVdURmFEbnd6OUVi?=
 =?utf-8?B?djBENkcwdzRTTzRNZGxMbFk1SEppZjdFbDE5MURXc3p3SlZuZGNIUGNTT244?=
 =?utf-8?B?OStPME9zRGQyU003UG5Ra2pSdjlTV1d6aVdwN2pKcGVYblZaR3VsUm9ER1Bo?=
 =?utf-8?B?RWxwZ0hPUkhDVjFCU0U0L0VhaFlIMEZFS0xrSmMxd2U0dlhpOFovaDZBOXN3?=
 =?utf-8?B?MWpScHpzbFdPK1E1L3VRWno0QnRDZ2FJdEtwWGdWcnZ5MUZrUUVXR2cvREo0?=
 =?utf-8?B?dDlka3JsZ3c5VVgxL1hGTjBrSU95OHhnSDY3cUtZTW9WeTJJNkN0U2JrQTdG?=
 =?utf-8?B?SWhmVnl2ZVp6elhNaEMwanBrejMrMXBqZmpjTEpTa21MMExIVUEzdGMvbkdl?=
 =?utf-8?B?VlJwMlZxMlEycXFDRis2dEZ4VXFBNTgvVVpIcWpqSjVkUU5zTGtvMkpTeDJx?=
 =?utf-8?B?TTU5UkhpcU1GbXZaRXpORERJZU1BSTJiMlAybVlvbG5CWHg4a01uQ0w0WGIy?=
 =?utf-8?B?K3VZQjB4VDBISkFGZ1Q4WmpxOU9xTDZ5QWMxVWtnTkEvUVRhT3JEdm9EODRZ?=
 =?utf-8?B?eHV0eHE3a3I3enVVcjdIVHFZaXFPMWJvUTAvRVU3d1g5aVV2SW9xRzhNR2tL?=
 =?utf-8?B?QnhnazJaUnA3aHNvTlovdEVBcjJSeFdqMGQ2S2VzR09YamlCV1VhdFRUc1NM?=
 =?utf-8?B?MUtOa1NMZjdoNVBFaGtHYktuYnE0WXBnb2VXV21ZbnU0L2lNRWptYUs2SGU1?=
 =?utf-8?B?akZSMGVwS2hmWlRET2UyTFlPaC9GMlZxdGplVzkvUmdVRjNiTnpEcXl6QkNX?=
 =?utf-8?B?VjdaMmkyeUdPbVBkQTk1Y0MzdEIwWDYwbXF5T3ZzOXplZlpUdVR1ZHhBU3ds?=
 =?utf-8?B?dzhYblBXYTFXOUNzTVJydzVVZWwwcFhBL1M4bGFNQVhpcTA3d29qZXJmS3Jm?=
 =?utf-8?B?WWpBWUpHdXQvdGxHYlpjUFRtMkVQTDF6ZEpOYkNBK3RoeENmQnRZUTN6LzZB?=
 =?utf-8?B?elR4WDUwUlJ6Q0k2M2hmM3RWbk41cU9kQTNTOGEwT0EwUHArTllONHMrRE01?=
 =?utf-8?B?Vk5TVzcwZ2dVeUZQMFliYlZyRkQva1EyTlNCNW5yZ2p6dkRwK0dPYmphNXVN?=
 =?utf-8?B?M1VId2Q3T1Z1SlZnaDREY1kxRmxCVmt2NTVpbnZaZjRUeXRLR3FQc0dSeU1x?=
 =?utf-8?Q?L9sK/QeUyyCZOSKFa4688/vMJsMrvopAngiMTg2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432c3be2-feca-4300-6e52-08d96da66e69
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 00:13:03.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRwr8hSpvT6KGY1lPxPxV198WSF3UInf1BcRV35lEyJFoDImPhXjkJm7oRx2JcTK0FbNzEKLWiuFWBjhCZZnfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1374
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109010143
X-Proofpoint-GUID: LavQeh8784QsrLz32PuCZG2G-w6WseIv
X-Proofpoint-ORIG-GUID: LavQeh8784QsrLz32PuCZG2G-w6WseIv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/21 6:58 pm, Vlastimil Babka wrote:
> +CC linux-mm, Alex
> 
> On 9/1/21 07:19, Imran Khan wrote:
>> stack_depot_save allocates slabs that will be used for storing
>> objects in future.If this slab allocation fails we may get to
>> a situation where space allocation for a new stack_record fails,
>> causing stack_depot_save to return 0 as handle.
>> If user of this handle ends up invoking stack_depot_fetch with
>> this handle value, current implementation of stack_depot_fetch
>> will end up using slab from wrong index.
>> To avoid this check handle value at the beginning.
>> Also issue a warning for nil handle values and when slab allocation
>> for stackdepot fails for the first time.
>>
>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Agree but without the warnings please, especially the "stack depot handle is
> absent" one. It's just something that can happen e.g. in GFP_NOWAIT contexts
> and no need to spam dmesg.
> 

Okay. I have removed warnings in v2 of patch set.

>> ---
>>   lib/stackdepot.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
>> index 0a2e417f83cb..1d42ef9ef766 100644
>> --- a/lib/stackdepot.c
>> +++ b/lib/stackdepot.c
>> @@ -232,6 +232,10 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>>   	struct stack_record *stack;
>>   
>>   	*entries = NULL;
>> +	if (!handle) {
>> +		WARN(1, "stack depot handle is absent.\n");
>> +		return 0;
>> +	}
>>   	if (parts.slabindex > depot_index) {
>>   		WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
>>   			parts.slabindex, depot_index, handle);
>> @@ -303,6 +307,8 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
>>   		page = alloc_pages(alloc_flags, STACK_ALLOC_ORDER);
>>   		if (page)
>>   			prealloc = page_address(page);
>> +		else
>> +			WARN_ONCE(1, "slab allocation for stack depot failed.\n");
>>   	}
>>   
>>   	raw_spin_lock_irqsave(&depot_lock, flags);
>>
> 
Thanks for reviewing this.

--Imran
