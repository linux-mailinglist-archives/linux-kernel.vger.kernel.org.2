Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557153A4122
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 13:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhFKLUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 07:20:08 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:35516 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231605AbhFKLUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 07:20:03 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15BBHwRs003500;
        Fri, 11 Jun 2021 11:17:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-0064b401.pphosted.com with ESMTP id 393vxfrbt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 11:17:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGidIszITwU5oIZvPCc23QufZ6kR/YY/DxQF1haLd+UUV+7rIH1WK03x9ApA98IFIkwvBw4LZk6y1QRIKxfQDVhPkx0tzSj0zuNL/lDwLgfRV/3DUmc/U8ONM72D+/LF8v7lR0TS1UfPGQU06OTGxvfjaUgG8zbhuCEyCOq0sD8Imz6MspKVMh23rbGPvHSLCBVMvQf3MLuXEqbYeCADQEh3a0kh1BkdhZerOY0uytiRayqizLowTLBcIkOPX0k9ZMh2lvqUcqCILjCpwG85jVUwHSnRBigitNXNZ78yO0q2BfzdSPnPtFonSVNEkUT9KLrIQqUAjdLnJTwCpkdwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwOY2TyupepXHwotaPuJwRzW33XouVU5TFlbBIECMkI=;
 b=Pfm7HKJ9tfUGh9h5re6WRyMVzefYKcMAhDfpto9ma+X0doK8A0OwFSMxkqgbCoKOIw9exVS94LFIH+jN+i6DKurdODpFgbCa80LXsMddPzkLrMQz/RC5PPpaSolPGINkqc/0VAq69SLyZNEPNY6PHHq1OziTQLXzfa+mNorYwI+TYpe3zt9U1Y+Rl6UbXHQee/qf/nI0dSu9DqJ6M0IXn9S3uu2vJacXtRatecrc6sHgotvbvg6Z9pOCaOk6sk9WFcVwRQx9I5S+A5n7GsqxIi1eTRe/PARk9Kv47xIsTdO/2DJGgBagoxqlxDGVQE8JqUo98fU3omd23kneeRbJlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwOY2TyupepXHwotaPuJwRzW33XouVU5TFlbBIECMkI=;
 b=lXnLHGs/oaJ47H/Bo62Aw7++WO+F4C5wdXIHxMUGROfb0D2PXipkp6/LqNe+unVGm+mPzb9vosBy/rlsRWfn7FvysieVPhFRiuaJLp/NOE6Oei7mmRs4gWuMjKCr9H+HBb8f2N9LieH3VGEAylF2wSQyvlkXFFnr6FqOogUk2RA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4401.namprd11.prod.outlook.com (2603:10b6:a03:1be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Fri, 11 Jun
 2021 11:17:55 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4195.031; Fri, 11 Jun 2021
 11:17:54 +0000
Subject: Re: [PATCH] mm/kmemleak: use READ_ONCE() for accessing
 jiffies_scan_wait
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210609155657.26972-1-yanfei.xu@windriver.com>
 <20210611085913.GA8132@arm.com>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <833a5523-3e49-2554-178d-cba7cbe71b7a@windriver.com>
Date:   Fri, 11 Jun 2021 19:17:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210611085913.GA8132@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR06CA0020.apcprd06.prod.outlook.com
 (2603:1096:202:2e::32) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR06CA0020.apcprd06.prod.outlook.com (2603:1096:202:2e::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 11:17:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d91cbac2-3e7f-4858-d9c9-08d92cca8f1f
X-MS-TrafficTypeDiagnostic: BY5PR11MB4401:
X-Microsoft-Antispam-PRVS: <BY5PR11MB44015DF60214DC9383835058E4349@BY5PR11MB4401.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6lbQIJoMn48RCsLO6M1k4KU2L0hkyr1GnLoUWKl9JY4CbQdx0N8PtM70+uUI9Qcj+1k+JlEuVSyAPnTxtn/DEJ5yRGWZ/UzTQGZeWVPG01bUoazQi9Uju6DNDX7SE14L/MgSuhWSa7izHrd8Q0nWQhznFJnHXg3pxmOkIIgDtCZphYEM5M9uqa/ktJxs9Dio2Ss2MXmvWuiBWhuWSM/jvFwa3KQQWDBMK7lpOm2+ZlTi2H3943krhzwu0x/t5X+uc8Wd80FligVqDH/lJs+nkZ7T9lEj3eJ3p4Q1JLunuyYKkyYZf3Rn6H4LlG5kLRHfX/sNUIun3e7hovy6COimIIB/KEX0+fk9JP8FoknPR1eLy3n500Jx06yKmMfLpgFV2lAl9hFbLYpXJ5un/iHjPkrvp/Nz9gXz5x1vUr0p9q0SGIWvQGYbUM1fpXJ2tSeGIyhEOgA3Tp/yzlAYg1fRNvVMVHRx186SiAy4OQZju8HGd1tqiQsCwytMZqioznWQkVPjRCcbzTRtXuG+OkOrEJASUE3NJRzMRplzI9hH0lPHFJylZk3lHCxwcQQ4xeP0WZ2w0FGvPbgkFAf2d7lAW/fqN41vVCZIrp8f5TT1O+p+xe6Je5CcZD2F/ywunDJhnbOyoZ8U1lRXEdIvr1ufmUJGNWhOGUWW49D5730SnyKTTC6LI+RKX0u/B1Bmt7rrs6CISooscHnB6K2onxDh3BYcAH7x34uf6hzftcqo1to+l6dVhAHOvNb1nNY7w2GRJSipc51bk6/sr/kScnbCBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39850400004)(366004)(396003)(136003)(6666004)(31696002)(316002)(16576012)(26005)(8936002)(8676002)(52116002)(53546011)(86362001)(36756003)(6706004)(16526019)(6916009)(956004)(31686004)(66476007)(5660300002)(38350700002)(4326008)(83380400001)(38100700002)(2906002)(2616005)(6486002)(478600001)(66946007)(186003)(66556008)(21314003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlNKdmY5ekpVMlhsS2YxSG9JOEJ3WEM3QmU0VFA4Q3JEa2NzdFpKUEpITkU5?=
 =?utf-8?B?L2gwc1dYSlRKUnYvS2JmOFNWa1BJQ2FlTWR3QnpCbXZ4dW5wODAvNXNzeGt5?=
 =?utf-8?B?THROY0NLZzVMYm1HcTA5N2JOTWh0RStneVZyUG5sUkJ6N1UwOU5ETUVuSEVX?=
 =?utf-8?B?ZjNPRHpHSlI3cmlPUnRRRHczZUNvWWRVc3MyNXBQNTdBSkdCaHZmT0hJUXRC?=
 =?utf-8?B?TndXb01rTUFKNDdsT0s3VVFzWHROMkJRMG14MGtleVdqbENmZzBvTTU5OFA2?=
 =?utf-8?B?L0gwQ0FtcUhXcFdQZWZMOXBtTERhUHpHUlFSL3RZckpZWFZJUkw4WjNIZ0FD?=
 =?utf-8?B?RUREL3hkakRhc05DUFVIV2VoV011ZE5vZ1krSm1HMXNFU0xNcDR0MFNyMFlT?=
 =?utf-8?B?Y1NNc2J0aXE4VktOejdOMDgyV2JOSTZlYWZhci9FU0JqZk9HQXJhc1VCUHJD?=
 =?utf-8?B?L2Z1aXIyei9EbFpiaTl1OWlRUEJaeksrMHNmYUhQQjUrWXlhZStvVTNScjRp?=
 =?utf-8?B?LzJpM0swa2lvWUVpcEZnZzRsSWtJMm9ZbDBsZHA0Mk4xckY2RWdBQXdtUkFi?=
 =?utf-8?B?Y1BXVU1UNUdta0dQbTNnZUtVVXAyYS9VeDdleW43M013ZFhSS0tCU1VseFN0?=
 =?utf-8?B?SkQ0b0V1M3N2RHdUM3hTeDFudHNUVzRQaWxQcVljZHFPR3FwSWVHR1RlSWZ5?=
 =?utf-8?B?bUpnTnFTS1FJMWtESDJlalAyZE1WVEVUWUFhZUhBcTY3YVpKa3hvSUorOUNt?=
 =?utf-8?B?dnBrd2tFRGF5bTN3OGUwSlR6elEzcjM1U1h1WEtKeUdHbzk2bTlSRXhiaUQr?=
 =?utf-8?B?UWtycDFqbWVTNy8vWHJydG1sY1liK1c2VjJIdWFIckdnMXJRNE9CZVJrTFlE?=
 =?utf-8?B?M0FDSEdIV09HYUVzNk1EaGwvY3RRb1RDSzlPYUtUUzUrYnBxQlZVaHFaSEVq?=
 =?utf-8?B?UE1GTlZtNnRid2tXQ1JXRDFzRmFFVGgwbGdyckpRcEF5R1hjOEdKTXUrZEIy?=
 =?utf-8?B?eHd6QzdobTYwVXNlMDljcmZsbFpSTXpYTEc1bTVYQUZ3QWh3cytCVzJnSFUx?=
 =?utf-8?B?RVE4TnQ5THRrYWRWbmtwUEthNERPcnYyelo3TVF2ZmVpN09tRG1pSnZ6dWo5?=
 =?utf-8?B?UjB2aVpsMXF0UVNPa3pyUncyelc0b3R6aWdrc1ZCRDdmaG03a3hRbFFGUXZy?=
 =?utf-8?B?Ty9Lb1ZHR2x3bVB5U3dnMUNZS0xTbWpKWndONXJ3dUFqcVBFMUZtWkpOUDNr?=
 =?utf-8?B?SVNzdjk0UE1MUEJNQmtiYnRRVEpNNHpoYjhsM3BnTEV6ZGNCWFRLR0N5eFVm?=
 =?utf-8?B?WmttalJBbWhXMkNKZDBQVkpVU2dVYVlmSjdpYUozbWYxVkJ3dllsZ01aSmhC?=
 =?utf-8?B?VTRiaElTZ2RLbkNoNnIrR2FzR3pZVWw2eEZnSVlPdkZGWVBXRUZNNGlEVE1h?=
 =?utf-8?B?Q0xEM04zVWlTSk85eWZkeWFRbjhJd0ZDWGxBNkJxY0sraThlcDQzd3RWdzc3?=
 =?utf-8?B?N0UxL2Q5TWg5eEcyelFsR2dXQjFaTmtObk5HOHU5OXZ4M2R2RVJ5VkNlbldS?=
 =?utf-8?B?bURmbUMyZ21MMnB6UUNrcWRVT1VUblUySVFjWEh3MjR5RmZhenN1dUlxSnpL?=
 =?utf-8?B?ZWk1dzJrNVBtZnhOWDNtMG43QjlzamJJUDE3cmxuT0NUU2krV1U2M0J6WW5p?=
 =?utf-8?B?bXdUOCsvWEJ4d2srZFZCYzlJRERNRVNJTTdjbXI1Vm5NVEJwME5NdlBPRnJ1?=
 =?utf-8?Q?uqIG3ZVsOQQZ+XCxTR8XIftnwEah1Q4jNd93r9T?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91cbac2-3e7f-4858-d9c9-08d92cca8f1f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 11:17:54.8759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cXykcvFbp2N6IPS23tUq/POrB5rq0hdnCwZpXeatYiLWNzSIBHXadU9Bb4BFAY7QA1q2y/shz/eSmI9nlxZeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4401
X-Proofpoint-GUID: QobS4ZJpHfptR70Y3BjjoK8UVtFioa_-
X-Proofpoint-ORIG-GUID: QobS4ZJpHfptR70Y3BjjoK8UVtFioa_-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-11_05:2021-06-11,2021-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106110072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/21 4:59 PM, Catalin Marinas wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Wed, Jun 09, 2021 at 11:56:57PM +0800, Yanfei Xu wrote:
>> The stop_scan_thread() and start_scan_thread() cannot really solve
>> the problem of concurrent accessing the global jiffies_scan_wait.
>>
>> kmemleak_write              kmemleak_scan_thread
>>                                while (!kthread_should_stop())
>>    stop_scan_thread
>>    jiffies_scan_wait = xxx       timeout = jiffies_scan_wait
>>    start_scan_thread
>>
>> We could replace these with a READ_ONCE() when reading
>> jiffies_scan_wait. It also can prevent compiler from reordering the
>> jiffies_scan_wait which is in while loop.
> 
> I'm ok with READ_ONCE but your patch introduces functional changes.
> 
>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index 92a2d4885808..5ccf3969b7fe 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -1567,7 +1567,7 @@ static int kmemleak_scan_thread(void *arg)
>>        }
>>
>>        while (!kthread_should_stop()) {
>> -             signed long timeout = jiffies_scan_wait;
>> +             signed long timeout = READ_ONCE(jiffies_scan_wait);
>>
>>                mutex_lock(&scan_mutex);
>>                kmemleak_scan();
>> @@ -1812,11 +1812,8 @@ static ssize_t kmemleak_write(struct file *file, const char __user *user_buf,
>>                ret = kstrtoul(buf + 5, 0, &secs);
>>                if (ret < 0)
>>                        goto out;
>> -             stop_scan_thread();
>> -             if (secs) {
>> +             if (secs)
>>                        jiffies_scan_wait = msecs_to_jiffies(secs * 1000);
> 
> For symmetry, I'd add a WRITE_ONCE here as well.
> 
>> -                     start_scan_thread();
>> -             }
> 
> The reason for stop/start_scan_thread() wasn't to protect against
> jiffies_scan_wait access but rather to force a new delay. Let's say you
> start by default with a 10min delay between scans (default) but you want
> to lower it to 1min. With the above removal of stop/start, you'd still
> have to wait for 10min until the scanning thread will notice the change.
> Also, with secs=0, the expectations is that the thread won't be
> restarted but this is removed by your patch.
> 

I see.
Thanks for your explain and sorry for my bad introduction. Will send a v2.

Thanks,
Yanfei

> --
> Catalin
> 
