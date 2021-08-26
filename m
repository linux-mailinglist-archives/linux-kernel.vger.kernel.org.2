Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF973F83E4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 10:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240545AbhHZIqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 04:46:20 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:41341 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233195AbhHZIqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 04:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1629967531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mw/qlqPxR11qm56BADaph1/hCm/QluY0SuK8W2nnbY=;
        b=Pq8lqpvThNuQePWp9MMzpFNqFx+eMJy3K5/OnfRa0hGFAxWPGhUqanrIG7Yd/huzM86MBh
        2I+wMrlZrLoDNuvJGUyh9knYqiJ59WWyOZkVlKIgLMAMjLCeVTqRydpUInhoxuZWusjPoG
        cP86Wf36yH8lkEr9W7Dl5XOJEO1Ccro=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2053.outbound.protection.outlook.com [104.47.12.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-16-RFMyQnA1Ny6CIXUxTFmynw-1; Thu, 26 Aug 2021 10:45:30 +0200
X-MC-Unique: RFMyQnA1Ny6CIXUxTFmynw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1uOCYHA1OjmksGoPDWKXcamf1RgJnO/a/m0RtQ1tjhY/tXq5ZUJ5xzQdmiprMdpbdObRL6JWLKigU8uAjyT0AXKa8DKk17hgBLGB4SiC3SiPVnpX/UUkY/NsWdpuQ01OHr8j6le5jNTYCE9b9Sl15IYIsOl80Ay9Wm/0yC0IifPGfvj1oAuCMay2z4pe07vLca03DnxZJcO+8xVgJQ/+pNI7n2KUqCgsgQc0tABU/Skpe/eq/kUYVogkkUqgzafn7g6o30WgTWCXbHAqBAbVAHPk/FC7GnlwAGa3i7uISlDR1t1vvnfkgUqwU/x5JcVMdQuL1+gfZFdaCBkFS9Xqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mw/qlqPxR11qm56BADaph1/hCm/QluY0SuK8W2nnbY=;
 b=mejzMiHTpJt6ZB2Yyogb2idPMHpHJDinC6xO1u6lXE0D61aNX6FyjdZWP1oVkRhgUnq8YKJg0rOoKR541nCS3/ZOF00WAocioWbYijhd0nH7lf2Stthj/GuE9nMPJKeTRu7LHNLj5WFKzLC+Gl0SX4sZDHigs+WrzEos4EEAxUpLrRQ51phSTLa4o7hWrWX8w8LYzVgDCxytKHl8aGiiSa30vhxaEhi0pJPsUlATvRZVAC7+GsCbHD+Ode2obYPimh7bkeIGXVnN8sor5UNCjBmpo72zqgB7p4z48tKOhZI3dF1V43QozShLKs/y6bdLNu5KxzC7bbDI4RjPlgk4Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=suse.com;
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com (2603:10a6:20b:f8::21)
 by AM5PR0402MB2705.eurprd04.prod.outlook.com (2603:10a6:203:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Thu, 26 Aug
 2021 08:45:28 +0000
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71]) by AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71%4]) with mapi id 15.20.4457.017; Thu, 26 Aug 2021
 08:45:28 +0000
Subject: Re: [PATCH] ocfs2: ocfs2_downconvert_lock failure results in deadlock
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, mark@fasheh.com,
        jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
References: <20210826061038.22295-1-ghe@suse.com>
 <b3f498eb-7de5-8a7f-0f52-01c1e2caa5d8@linux.alibaba.com>
From:   Gang He <ghe@suse.com>
Message-ID: <7795ed72-8b77-14ea-cf18-78870e58f429@suse.com>
Date:   Thu, 26 Aug 2021 16:45:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <b3f498eb-7de5-8a7f-0f52-01c1e2caa5d8@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0205.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::25) To AM6PR04MB6488.eurprd04.prod.outlook.com
 (2603:10a6:20b:f8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.67.20.87] (60.251.47.115) by PR0P264CA0205.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 08:45:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9e0f425-80d8-4538-4785-08d9686ddaf6
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2705:
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2705D4EEB5504BF6868B0245CFC79@AM5PR0402MB2705.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d80XCBDgoFNBV+U1vAzAW6Zm9YvdWI4hEogb3nYA/pD3hU44n0hobNsYyPHtsJWNWA3imEb38zIXoKRlGWeI4kNbEtohnACocUTQFEC7b+yPIuCI75U2REJk7dwZE9/FVyGBBS2JJ5QBumaLqINRnJec7i77V2JyP2a/WlWASSeCGJRVGtXDrrTrZGQxMqG0w+CuKe+V8HMTedQ4enJaxF1ZY4HIXx0Efl69B/i2dkD53piUzCJXqaTWUQf6PTn/oY8CTpWDwhiSz+uhf+8k2/qW6YaEfdZjdRLZ4VQ3y2qyx0f2rx9mQWJ0r8Rx4Wno32k9Ff3ka8HDSeXypvifui7FEqV4YRsw4QxArts+MyzQKll0phtjC1fDvSrK3JhjUjeEIe521fsEZQd2yxuuv7Ua2zlVGPnFayrfFpwWRfJ/7F+QF752xsJZE4ftMZNNNvbUAltdRUcvXVx/fRfTrHkAQDfEEkubZFQaSAsglZT/9quK4DLOhP02kYT2qVofCHD87T2x5b0wULxpSC+VqB61XAipUTmIy5PEu0vUiShx6m97VCDSOtUe84GoI9uC+KtnlbJwP/p8m61Jp9Tw3EmbgKVXLnXszTUukwh1/UBqtK/PzSHrHUfcFv3AWGmFgi8A8VRj5mAvvlQGXRdM7ELvzdENiMNlgaBxJEVjHfR2nkyrYau90qjDXU+XQLdRo+ZBXLDjkMdhggDyVwDl9JC8rESTUHvtlnVi8PSzCLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6488.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(366004)(39850400004)(36756003)(8676002)(6486002)(6666004)(31686004)(8936002)(2616005)(31696002)(53546011)(16576012)(5660300002)(83380400001)(316002)(4326008)(956004)(38100700002)(186003)(26005)(66556008)(66476007)(478600001)(86362001)(55236004)(66946007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjNLTTdnNEZsS0ZUZ2lIbTExVjh0ZEJYekZPKzVXdjAwT2hFT1lxeVpRckZh?=
 =?utf-8?B?ZEhXNU1udDMyZ29mM1RBelFmLzAxNlNSd1EzSjB6MnQxWW9yQzlVS3pFcDZE?=
 =?utf-8?B?WS9seVdXUDBOVllXVGR1T0RvcE5tZlJOWTYzVEFGL21sN3RRQXNaUDFLV01m?=
 =?utf-8?B?SWc5LzRic2kxdHBPMzlMdTIxMU1GK1BFUzErVnNJWTQ1NWFyN1p4dGhUYThJ?=
 =?utf-8?B?NGxBc21zVXdETFgrdnl0cWt3K2NqU210dFpJMXFhRHhxOWhmTHZVVDNTRysy?=
 =?utf-8?B?dmlmSGk4dGxyZURReGFXZXptcXcxakVwRlZaRVl0cnJXR3oxNEU0c01BVXBU?=
 =?utf-8?B?bHhFZVoxdmJUWGdjbmR1WUNoQWVrbmc0aVlob1NBQmI1QU5rdFJQN1duOExl?=
 =?utf-8?B?Rk43cXdJbzJGaGlxWEZpZlFXOG81K1R0S3Z1S3FzRWdMMHFuVDNPMHJOc1VL?=
 =?utf-8?B?SzBoZTV1YWR2clovcm84VjVRY3IrMG4rZDJQWmROZHlFVDlKTHduT1hPSS8w?=
 =?utf-8?B?K0h3NTRmMUhqbStjMkh5UHlrT3dUQUlQRFZoQlFEN0NuT05BOGk0Ny8xY0NL?=
 =?utf-8?B?MlRFV3ZHcjR3ZU9Fb1pqbTA1TXlxdHRhN29hbTRkOWt5Sk45ZXpCa2R2YytQ?=
 =?utf-8?B?T2RVa0p3WkJjZjJhMEpWZzZLUVovbnlEQTZHZW5JK1p4RWNzR2VJOHBGRVY5?=
 =?utf-8?B?VENPQmd6SjM3M3dtR213aUgraElKNUkwb0RNNEdzUW1CNU96YlZlOHNUMlh0?=
 =?utf-8?B?WjB2LzNaWmlFbzdnUXR0MXJrNXR3a3ZvZDlwWjVnemlNTUJtWG1NVW5zNXQy?=
 =?utf-8?B?Wkt3WmN4S041YnVPeDV2N2JETU5kQlJaTmp5aVV4elFRVTFFOVZhVmtOa2JW?=
 =?utf-8?B?NDJZcmR2WUxWTTFUNDdSa3hwWklQZ2ZKd0FpSFBKWUplMHU0MWdzU3lVajc5?=
 =?utf-8?B?aTc2WENJZnY3Y2dmdUtiTXo2TWtWMisxNGc5OUhZT3hRRjZVVGJWOG85QUdG?=
 =?utf-8?B?ZTN4S0NUUVl4NU4vaS9ReGRXeTI5NnBra25CeFlLNS9rd0paSHlGUFQxR2Jh?=
 =?utf-8?B?THBwQ1czWHpmeVE2b09ZQzZ5cWR0bWVmVDJPS3J5S2UxdVFyOG5MWGR5YTB3?=
 =?utf-8?B?Nm5Mc1VIZDNYTDhRQnRTb0J5UlI3M3NWcVVLa25FNzJ6aEhCVExCUXNUNUNG?=
 =?utf-8?B?cCt6Q1NyR2xBNFpLZjNUU01iNE9UL2lKdXVwR09UbGdYY1p0emtKSlIrcTFI?=
 =?utf-8?B?UzZlblc2UHBqK1BtMFFIaXhUTlhBOTc2dTNNb0EzOGFQb1RGMjVMd3U1Ky9i?=
 =?utf-8?B?ZkpiSXZzMW5DbURnY2ZvTFhMY05YL1V1Ylh3OVhjY3M3eEFiN0FQSXVUQ0dz?=
 =?utf-8?B?Unc4SGZIbDkwNEU2a0MyU0gzWGZ0NlBNRlI2TnRHNzFDYVZNUDk5RXhZdHg1?=
 =?utf-8?B?UE02YTVEem9kcXlRejY5SE9DOEFRQmVHVDFaNXFIam13RVJxTHgvR3V5N2tV?=
 =?utf-8?B?bG1UaSs5RnZYTTFpazN3VW5MNXo3K3JIemVGWENCRG43SUxZaEo0bmEzVVhp?=
 =?utf-8?B?OGxVcHE5TElXa0pBamRtclVoMFRpbzRJdXpEYVlsRzEzb2M3TDZtV0hsbW1m?=
 =?utf-8?B?UVNkYTE0eUhwem1NTDF5Z1N5U1lYUkx2aVdpOHErck96bm8zNU1LTHFFQjlD?=
 =?utf-8?B?ZEdOMFR1MVc4VjRCYWwycURQYWZGUTBkUko5TmNteHVLOWdNcEdnZDZ5dGpB?=
 =?utf-8?Q?4EbQinLIpuHzdQADi+9+wav31E9vdAvLNwlePhu?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e0f425-80d8-4538-4785-08d9686ddaf6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6488.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 08:45:28.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIvhK439rbP0tOgPR072qt9swFWcG4MQxQYcYRi7jgGgpJ+IS9tZgKiSaSfGXzou
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2705
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joseph,

On 2021/8/26 16:23, Joseph Qi wrote:
> 
> 
> On 8/26/21 2:10 PM, Gang He wrote:
>> Usually, ocfs2_downconvert_lock() function always downconverts
>> dlm lock to the expected level for satisfy dlm bast requests
> 
> s/for/to
> 
>> from the other nodes.
>> But there is a rare situation. When dlm lock conversion is being
>> canceled, ocfs2_downconvert_lock() function will return -EBUSY.
>> You need to be aware that ocfs2_cancel_convert() function is
>> asynchronous in fsdlm implementation.
>> If we does not requeue this lockres entry, ocfs2 downconvert
>> thread no longer handles this dlm lock bast request. Then, the
>> other nodes will not get the dlm lock again, the current node's
>> process will be blocked when acquire this dlm lock again.
>>
>> Signed-off-by: Gang He <ghe@suse.com>
>> ---
>>   fs/ocfs2/dlmglue.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
>> index 48fd369c29a4..c454c218fbfe 100644
>> --- a/fs/ocfs2/dlmglue.c
>> +++ b/fs/ocfs2/dlmglue.c
>> @@ -3671,13 +3671,11 @@ static int ocfs2_downconvert_lock(struct ocfs2_super *osb,
>>   			     OCFS2_LOCK_ID_MAX_LEN - 1);
>>   	lockres_clear_pending(lockres, generation, osb);
>>   	if (ret) {
>> -		ocfs2_log_dlm_error("ocfs2_dlm_lock", ret, lockres);
>> +		if (ret != -EBUSY)
>> +			ocfs2_log_dlm_error("ocfs2_dlm_lock", ret, lockres);
> 
> Do we have to treat EBUSY as a normal case?
Yes, this return code is expected when call dlm_lock() to convert a dlm 
lock to another level, but this dlm lock is being cancelled.
As I said in another mail, for fsdlm implementation,ocfs2_cancel_convert
will return immediately, but the related dlm lock will(is) be cancelled 
in background. For o2dlm implementation,ocfs2_cancel_convert will return 
after the dlm lock is cancelled and it's ast is invoked, that is why 
o2cb based ocfs2 does not encounter -EBUSY return code in my test 
script, of course, this kind of implementation will block other lockres 
entries to be handled for a little time in down-convert thread.

> 
>>   		ocfs2_recover_from_dlm_error(lockres, 1);
>> -		goto bail;
>>   	}
>>   
>> -	ret = 0;
>> -bail:
>>   	return ret;
>>   }
>>   
>> @@ -3912,6 +3910,13 @@ static int ocfs2_unblock_lock(struct ocfs2_super *osb,
>>   	spin_unlock_irqrestore(&lockres->l_lock, flags);
>>   	ret = ocfs2_downconvert_lock(osb, lockres, new_level, set_lvb,
>>   				     gen);
>> +	/* ocfs2_cancel_convert() is in progress, try again later */
>> +	if (ret == -EBUSY) {
>> +		ctl->requeue = 1;
>> +		mlog(ML_BASTS, "lockres %s, ReQ: Downconvert busy\n",
>> +		     lockres->l_name);
>> +		ret = 0;
> 
> Ditto. If EBUSY is not a normal case, I'd like just requeue it but not
> change it to normal return code.
> You know ML_BASTS is always switched off in production environment.
Since this case should be considered as a normal case, although it's rare.
We should not print any error message to kernel journal, but if the user
turn on the BASTS trace, he should watch this trace for debugging.

Thanks
Gang

> 
> Thanks,
> Joseph
> 
>> +	}
>>   
>>   leave:
>>   	if (ret)
>>
> 

