Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845E63BBEDB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 17:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhGEP2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 11:28:24 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:4012 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231535AbhGEP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:28:23 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165FEBnj008699;
        Mon, 5 Jul 2021 15:25:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by mx0a-0064b401.pphosted.com with ESMTP id 39kyka861v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 15:25:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUgG7vAiNfKrf1lx2NXBG4rRFiL/bNtmNGWIFkHpx3VYGfS8CH8BIscBaJmI3dvxvKTQeldQsb52ONt4J4afPw/T7x7UlWqGOZBUEw/+VGiYVwLhnJJFpmnFEFyW4j301tCaFrOx9Ai4gBC66Nx13DEIgBpVZiv9wann32T4Sxj0RkgITNLnyjtv9jLVRjVQFF4dl2ayBe7x3WoA29kp2tBc0+7PnacBwKDZHBOBiVCMbt27Aplm06XHkui6wA/GZLSfuLAtzqlY9WbQ5DTAhubvY5HG5ZuBU2JUU/UcShcqe71c6wSjWUAV8Thpm6pL1J4GEo9INWmbniXeZwWuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIv4NG4zg8XYq4zR+3h8qQHZmNretqnSI9bPTxdOGwE=;
 b=V3/lHLSK2EPgsF9meli8INlN5wrgt7qYhCr1xNqkV+uLptTfv3gw4YXbb6TPpgYupZ1PzubzVdZ11pKRYYSQhaus3lgbtGsxuPvTlXGhb5nyJFO7nZ8+ouuQjPFH09xL9Z2zjO6xDhwyeDLfCdppBFmeU372Oa/usx/q6lv8QLDbneokWqql5iKXIXoLQdXqYlda2KqtP3aL1XqNR0cJ+7K1ew9RrTqN5L3aPGvFssXNjxvqpnaGKNZckgLWyXjouCUGPtir+9CJWxh3Nt2gpYhFI0UgIWJzBpBTcklocYMjFJ39D4cOmadmMe4zCq/ZcXSRsz8b1Ji3iwkI45walA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIv4NG4zg8XYq4zR+3h8qQHZmNretqnSI9bPTxdOGwE=;
 b=bfsC6dwiStRP1Phi41SArETLP41A7eovuIzh5R5Z2pXfy3ACvE6JpHqqxMiyU+Mm8XZyq4SGv5MRTtCE1Rd6s3CTL1nbf8zucNdcqUoZ6AI5egpy7b+Cbxer1IPp9EDxuCz7Ewb5oOpw00Zk1AjVpsRHq2SeFM0ydhOfwMF+ZgU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM5PR11MB2009.namprd11.prod.outlook.com (2603:10b6:3:15::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22; Mon, 5 Jul 2021 15:25:37 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::bce8:81f7:f5a1:af19]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::bce8:81f7:f5a1:af19%6]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 15:25:37 +0000
Subject: Re: [PATCH] Documentation/atomic_t: Document cmpxchg() vs
 try_cmpxchg()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        will@kernel.org, linux-kernel@vger.kernel.org
References: <20210630153516.832731403@infradead.org>
 <20210630154114.834438545@infradead.org>
 <cac55711-585a-4e08-3b5e-a6890e2f548d@windriver.com>
 <YOMQYQr1loxIuZbU@hirez.programming.kicks-ass.net>
 <YOMgPeMOmmiK3tXO@hirez.programming.kicks-ass.net>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <137696c1-7782-18f0-f005-a2416edbeac0@windriver.com>
Date:   Mon, 5 Jul 2021 23:25:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YOMgPeMOmmiK3tXO@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0035.apcprd03.prod.outlook.com
 (2603:1096:203:c9::22) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HKAPR03CA0035.apcprd03.prod.outlook.com (2603:1096:203:c9::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.11 via Frontend Transport; Mon, 5 Jul 2021 15:25:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fe3014c-b710-4f2b-b235-08d93fc923d6
X-MS-TrafficTypeDiagnostic: DM5PR11MB2009:
X-Microsoft-Antispam-PRVS: <DM5PR11MB2009486C5334EE17823C8D43E41C9@DM5PR11MB2009.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJvWE+gRBksxnyAK01ZP/YqKM8eZxuiGJM14AGlrArGKJa6Bi67geYU18X9DvncO5h6nYmJ0VhAeZmLQZc+sRVoleQhCEAPIg1hrG0OHQy3YfAPiYMnokKTDP8HlrndVJuk7tidhR0iEtS4sFAhKn6RuEAThgFoaIvwG5anrb11lxXLfNavOkAzXx7ya5/fGCk/fX1d1juNbUk8ZTtFrR75vz9FpnL3myfdPHJOGxXK7SqxPlYdbyFBA2M3+wLpp2dnmUpMZHFkqRGrERDDHpk4QkH33CWyutY9I8Cx5PysjLw3RqzH9qtzR0gHqIHkKQhOhZkJvmryrm+w9RenVYzBiZAeNMOEgmBVWO0mLxBHMYBMOHw3DDHWiuvtfnPTzl2na0H6PNcOj8Q4/UcEmV44HUKpdeaaSnhxlfjc1uJDkPanQy3S3ObSQ3LnUc+t4d+dtNwuEukjNRO3z+Qug777DYx4g7LxAaqOKtbQHwxL2YtpAlYy0zTrtqgGFgJVFTAxgC4TJZFB6l7lSsi+l++rOgDUpjNKUCTiY+C1Mt75breT1QrQn5TXBaZ1xClH6xzgyl6b2nebDfHD8HBpq7KCZ5cFRrRB7drj+i/Oxn6ehqwuDdrEc9+QmyjkoA2ZQVuxVH5A5H7mfLRVOzxguhlmU/vLpZEEcEHDcCFf6f3Mr+P0b3xfowkHmI+74eDbfAKiEMGQ7Os8RgLO2xjN9ZrJ3cpfF5fbeq0SSk9BseS84I2Vlq+5C1qN22kcdd2IuSZVEvC+iApQ0olWTv18K5ej+m/MKDx/kcmFpMk/UXhxzrPA8Ro/GIEnda5EFOhic
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(396003)(376002)(366004)(346002)(316002)(52116002)(2906002)(16576012)(6666004)(4326008)(38350700002)(38100700002)(6486002)(6706004)(5660300002)(86362001)(31686004)(31696002)(8676002)(956004)(478600001)(66476007)(36756003)(16526019)(6916009)(26005)(186003)(83380400001)(2616005)(66946007)(8936002)(53546011)(66556008)(133343001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTNwQ3JudzJNSmJKaFRWbzRqMmR2M0I3a3RSZ3NUK3VkWmFVNTI5cWx2K1lt?=
 =?utf-8?B?K2xYaTBUYmN4eURJa3p6UmpUU29QLzJ4SlhNV1VUQkJBYytlZ2VjT3E4NTh1?=
 =?utf-8?B?WFhkU3ppMVdzd0J1czBkd09BYU5OS1R2QWYrcnhOajh6eHQ4QWo3K2dYVzJy?=
 =?utf-8?B?Skk4bThvV2grNkpoMm5GVXF6b09OMDI5Z0plem9kaGtveE5hZHppWlpsaDRN?=
 =?utf-8?B?cVlTMkxoU1I1S2pGZUlDa3I3NkFzdW1udkhqOXUwWHp3aGtralJ0b1YzTmNa?=
 =?utf-8?B?VlFiRTlZRXltZkd3aEhLbHliU0I4cVErNHZxaWRoNEg0OXZNQmUxQ0VYQ0dY?=
 =?utf-8?B?SlBPOHlidFFzYnM1TDJZU2gwMHM1bVJzb1didVpUY2lNZmFySzkwMWMrN2Qz?=
 =?utf-8?B?cDlLbmZaSFhiU3AyWExBaHpHNUFPVSsva2hBTUNWVnUzdlBJU3g4SHllVEFh?=
 =?utf-8?B?R0s3c1NubithbkdJMXljNVhmOFE1TExLYUhRbVY4TkpVd2pHS1ZBNUk3RG9t?=
 =?utf-8?B?SitRaVdmTXBoNFVoeXV0UHR5MnI4ZmpmMGxzdGZKQXg4YzdXVUZ0NkNHN1pB?=
 =?utf-8?B?cXg2TUhKWDFhajhIcEtEUnNLeTZ1eEo5RHhnNm1ncklKTFp3K3k0ZG1WZGUy?=
 =?utf-8?B?dlBMSTNTRE8yU0l0WTZzWDJUQzZLQnJxemNtSnAwKzhueWkyWFZGcytUZmU4?=
 =?utf-8?B?SGQ2SkRuQ1k1THJxZ0RrSVdyTkZzUkZQMnA3ZWVLSklrRVNCeFdmZzhkMGk5?=
 =?utf-8?B?U1hDREtmTm1SU3FaN0QyWUNZWkljcW95SEpjUzFBSHJSejNlMVJvTGs1YjlD?=
 =?utf-8?B?eW43QTJtTmVCVkQ2VThSaS91clg5b1d6SEluMjBrb3duZHJ6cFlWUXR1MS9E?=
 =?utf-8?B?amhvRzFJR20yMmFZUU41R2pHcW5zNnB2eGpMeWsyR1gyYXczTDFMYmppZTJm?=
 =?utf-8?B?bndWN3Ixb29ibGVlYWI2bVNhUzFLM2VadmhlQjlNSVJWajB4OTFwZmNDdlJo?=
 =?utf-8?B?RzAveTd6WEJkOTJIKzhRMVZ3Zjk5cm1MTElxQ2FpajlsRyt3ZTZqR0xVQXRO?=
 =?utf-8?B?bEZXcDlUV0VEem9kWithYmlJY09BYm0xTVZNcE14bUIweHlKYzNxcmphRlRF?=
 =?utf-8?B?NFJEZDlhemJVbzZFanpjZ2tTZWdWV3JWMTJXRHlrbmszR1RtVmpnT2l3c2Uy?=
 =?utf-8?B?andHV2htREZIZlRMSWZraHRWY2J6Yno5dFM1WElJZXljMHVlVnNZTnM4TzFD?=
 =?utf-8?B?NElHVTdNeUxjeGxyUFdETVQxc294NDQrTjJZa3FOMWRaNEswc29lUzg0dkJI?=
 =?utf-8?B?MHEwQXp5ejlDMHZKc3FzZ1NSNzgwaWYyeENOdkt6ZVZ5dm1mY2ptd04wekpP?=
 =?utf-8?B?dDkrOWVRTEZRWUJtRnhSaXZZZUFYdk12RVJoMEI0SitqaTR2aU82WWV4d0NE?=
 =?utf-8?B?RHNHc1IwMjJMTVdIdDN6NndXbEVncnowUFJNV0VEWnlkbGc4MVdLUm1EbEZX?=
 =?utf-8?B?TW1ZQS8vQXArYzh1QzRhZVlhWVRVREl0VXZCY3pnMnlhckdva0hGeGtVUkVY?=
 =?utf-8?B?ckZmMVBua3g5RmtYeCttcEJNWnY3TzVQYmNpUXRCamh0Y2dNRmlWSDRoN2VM?=
 =?utf-8?B?eStQVmlMKzlNL0F5QWNhK0V4Mk9OWXZ1VGFmQWo5bjBlMUhlcTM0ZDJWRXlS?=
 =?utf-8?B?K1drc2ZVZmZKOGl0SWR3ZXVpaG85R28xeE9kbHk4SHY4LzJCSWtwZnpVeThF?=
 =?utf-8?Q?oGzH8XILjbh9jFMyc9V8OS2ReHQ4OmjAdbtpsto?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe3014c-b710-4f2b-b235-08d93fc923d6
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 15:25:37.4623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDVq/brbDSEFl92HdMU1n2PSy+cLWPDCNu0Y69NeSF7F0aidSUu2AQJOWnM6qtM6BMn4rmAqB1qd2Wq6awPHMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2009
X-Proofpoint-GUID: awsRa6dkLA-oErO1rHqFV32S2yzj8KY2
X-Proofpoint-ORIG-GUID: awsRa6dkLA-oErO1rHqFV32S2yzj8KY2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-05_08:2021-07-02,2021-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107050081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/21 11:07 PM, Peter Zijlstra wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Mon, Jul 05, 2021 at 04:00:01PM +0200, Peter Zijlstra wrote:
> 
>> No, when try_cmpxchg() fails it will update oldp. This is the reason old
>> is now a pointer too.
> 
> Since you're not the first person confused by this, does the below
> clarify?
> 
> ---
> Subject: Documentation/atomic_t: Document cmpxchg() vs try_cmpxchg()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Jul  5 17:00:24 CEST 2021
> 
> There seems to be a significant amount of confusion around the 'new'
> try_cmpxchg(), despite this being more like the C11
> atomic_compare_exchange_*() family. Add a few words of clarification
> on how cmpxchg() and try_cmpxchg() relate to one another.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   Documentation/atomic_t.txt |   41 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -271,3 +271,44 @@ because it would not order the W part of
>                          SC *y, t;
> 
>   is allowed.
> +
> +
> +CMPXHG vs TRY_CMPXCHG

CMPXHG -> CMPXCHG

> +---------------------
> +
> +  int atomic_cmpxchg(atomic_t *ptr, int old, int new);
> +  bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new);
> +
> +Both provide the same functionality, but try_cmpxchg() can lead to more
> +compact code. The functions relate like:
> +
> +  bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new)
> +  {
> +    int ret, old = *oldp;
> +    ret = atomic_cmpxchg(ptr, old, new);
> +    if (ret != old)
> +      *oldp = ret;
> +    return ret == old;
> +  }

I tried to search some comments about atomic_try_cmpxchg(), but failed. 
Maybe I missed it. With your this document, it is more clear now.

> +
> +and:
> +
> +  int atomic_cmpxchg(atomic_t *ptr, int old, int new)
> +  {
> +    (void)atomic_try_cmpxchg(ptr, &old, new);
> +    return old;
> +  }
> +
> +Usage:
> +
> +  old = atomic_read(&v);                       old = atomic_read(&v);
> +  for (;;) {                                   do {
> +    new = func(old);                             new = func(old);
> +    tmp = atomic_cmpxchg(&v, old, new);                } while (!atomic_try_cmpxchg(&v, &old, new));

Some unnecessary spaces before "while".

Thanks,
Yanfei

> +    if (tmp == old)
> +      break;
> +    old = tmp;
> +  }
> +
> +NB. try_cmpxchg() also generates better code on some platforms (notably x86)
> +where the function more closely matches the hardware instruction.
> 
