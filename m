Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99192438F98
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhJYGlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:41:00 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:37686 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229987AbhJYGk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:40:59 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19P63HuC022063;
        Sun, 24 Oct 2021 23:38:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=x0g9GhbfdvDcO8y+/paARaY9B1p5l/1k4n4z97KMJFA=;
 b=htGY0U/xQS7ZUVfUTvrs2EZvThQsKNo6W+7GuRY9txsi3Pq8GHpJmhzA4Mwp+ZhEfrsq
 HPRr0CTkjgOT2leeuLpNyZSYTRr0c6g8vnZZvfKmEiKL+8Qw96dYfv3yva7kIFyu18gp
 Pr9rvt30MWXzkDSOk1XX4oj5NpBcgeElkdFuCwuS2h1tNX25BMhV9McRoAr9XdCebhL9
 yP7rCVXeEa2lb/fir3ql0HpLgK+F/sMmrKJyvXcQZiny2pUjimbEvz5szot6KAyqFbck
 ABOhDOJQNlYv+o8zft6GyKS4i/N80xyxaj6PmwQ7CrvK/y2aRF3My0ws9ZrCh/E8YKgu dQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bwccqra25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Oct 2021 23:38:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekZiI80F6zUadmSxLGkowuH1SmOiX8SCKvv0j94bSueN2evGV7RSOJrBpuEjZiG6XnB0O6sUX3+ltmFBznLDQFbCsflzFBQNqjp00izMzPDKX6rAT/0wwe6reByTBuBWGjRDv36742dX/UAV/ULuP2Fr28mhwzr2btjq6LrBqoC/pEanL07dKvmeJ6xQ0w/SI+J9AYDAmF9cdTP1xZjQHpFAQOw+iP8XWYdMrBIqQdt9me5eiB6er1qTAcdfeRkFVzD1gH5XS74ocLah8YA7SgQdkobYchN5GexkmmBTtl2Uolo7vgPsPjCPF7JSmJb9IZfPQH7x0lFpQINgQ+n+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0g9GhbfdvDcO8y+/paARaY9B1p5l/1k4n4z97KMJFA=;
 b=OQNlUe/hXshEcOm3qfr/mSa5xmfTHkz5SNhJt5EFixTC0ePQx0n5KOlzwwB+yduSGZHK/K52OHKpy8w8nmzmWVd00eftZXf26Iv9FVH+4HmwlpqdsTllkYiUX+xEGh54U/97ABHCR72f6HbXKrWi/d8aVuqSMl4pYLTqeV7gFc45cBXVrImVSgD7zz9XLUtDEry4HBnSJyzUQzdWPmRtnVy6T85d/FHz06bYJWoy/fGhxk7WW/yNh9d3SlEo1ObVS4ti589/QYMtp/MllSWq5Ca8mDWa5f7El9u038qzzqxzZsZ6LkL6Ta2qPXQRxdVzE4qP3byatWY1Y8lKhk+eeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9)
 by PH0PR11MB4808.namprd11.prod.outlook.com (2603:10b6:510:39::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 06:38:09 +0000
Received: from PH7PR11MB5819.namprd11.prod.outlook.com
 ([fe80::3508:ff4c:362d:579c]) by PH7PR11MB5819.namprd11.prod.outlook.com
 ([fe80::3508:ff4c:362d:579c%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 06:38:09 +0000
Subject: Re: [PATCH] ARM: add BUILD_BUG_ON to check if fixmap range spans
 multiple pmds
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211020054942.1608637-1-quanyang.wang@windriver.com>
 <CACRpkdYxMDp4FRGP=EOt8oTMxs_YuskbvMx5wXBDjUWz6hD=gQ@mail.gmail.com>
From:   Quanyang Wang <quanyang.wang@windriver.com>
Message-ID: <c1ffbda7-812a-cfbc-8cea-225a5c8570c4@windriver.com>
Date:   Mon, 25 Oct 2021 14:38:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CACRpkdYxMDp4FRGP=EOt8oTMxs_YuskbvMx5wXBDjUWz6hD=gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:202:16::15) To PH7PR11MB5819.namprd11.prod.outlook.com
 (2603:10b6:510:13b::9)
MIME-Version: 1.0
Received: from [128.224.162.199] (60.247.85.82) by HK2PR02CA0131.apcprd02.prod.outlook.com (2603:1096:202:16::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 06:38:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2e6196e-96d1-4e38-238b-08d99782022f
X-MS-TrafficTypeDiagnostic: PH0PR11MB4808:
X-Microsoft-Antispam-PRVS: <PH0PR11MB4808EDADFA0AF97665CCA8A2F0839@PH0PR11MB4808.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: inH6fNAKTS3B7Zw4lTzu4cR3EB4V1EfMqDxNo365Zd2Np3M4Xz97ElJ+Tv7cVKJKpwO/Yz1jOu/7vodT3XWOnZVcBsfrtS9ds6RI1KGYpjTEIWuYgUUxiyO7dJYrRz2hWSF3tEXyFZSOWDaa8gd0KSTeixYkmVj2BS0w1m/4bGjdwcnkyQQ1KhBexgvqCc3kscFx/6T4BtMpSxqJfjXHrUwM2AlOjMcl19MuySVw4Yuv3i3JsJPJZ1qFQy8eHCPV3D6CMOz44uqNIuMoJvv5BhOHkm968jyuVVg0NUFtdqPALKdxqHoctbbeA/VGOOcPzM6aNCAQbfEBq/8GbmZdjeowximn6e1Nk4yWyfujI65Fnn/39Mff0wUytjUbh+JDW7PVYRCjIMEWxgvWaQVplF5H1Q852duVvw30xB66mB7nTiH/O9Po6zAy/4+iOP4u1SozyXUIulXGKaQ1mCulEKhU+VUHcWE54d6kK8+qUcIeG/grFgHFTU5+8N4JGKebzYqJHQaWldfHlSOn3h747hFvR6EdBt+sOsDKrGPgzs4381oC73esGmWVAuid2BEuqRazEyojKJQaeXNt7jzLrk/COJUcwdqqB+k9ZdiwSs1MXTU8ibzFN4wtFZKEXgx+jBiPj8huaoCu9pFVSybfSZ2h0tjK/7DojfgWdrxw+Zl+cydZQzRHHsFciWvqT70e3De/aBA7wBbu2q4mOQkXf1kSIpCrUZxinxnYoe5yOXUxqgRiYDrpni9ehpM/n+/AmNJqMQD5Ys6BX9Cr0+w5sSwXB1CiCXxy5OqCxlQ1ZOCKkpEZheJLqk0HwpzDkd+UpSLcax9Fs4Vf1DY5dQvIRTJJ9sTOAMRsGLblaCm3ePwM/AoXvTcmqU/QRyKh5bNL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(36756003)(2906002)(26005)(54906003)(508600001)(16576012)(8936002)(5660300002)(86362001)(52116002)(38100700002)(38350700002)(44832011)(16799955002)(186003)(66946007)(6706004)(31686004)(66476007)(966005)(66556008)(6916009)(53546011)(2616005)(4744005)(956004)(316002)(6486002)(8676002)(6666004)(31696002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3hjUmMzUGQvMWpvV016VUlvTVZIeWtJdnBXU3pXRFIrbFZPZ1VPaG5UR0gv?=
 =?utf-8?B?R0s2MFhhZ2ZRR1QvRXFwZEdETDBEYTlEaWwyczRDekkyb2tBL0tzanpOSnJ6?=
 =?utf-8?B?RDRRSE5LcmVYM1ZieVkwUVIzcXFLS0lJbjJsdXpQVTR4SmpRNXhVUlluSy80?=
 =?utf-8?B?d3NHcjRjcHVQUVUrQzcvKzVwZFUwdkVyaVZ1a3p0U3o5akJlaE5YTWlPcjI1?=
 =?utf-8?B?VzRFSUpaeFA1ZFVxeENEcFhrV0ZicHZTUTQwaUZUdmVERkY0V0FiNWJscEI2?=
 =?utf-8?B?SmNkNHVjOEx2TUFadXVGMTZDbkUydENhcytuVjU0QjVZcmRGbmhpWnpveW5h?=
 =?utf-8?B?eG9zdWd6ZnhKS1Z2TDVxTnYvY3JwRm8yNy9yR1AwcU00RExkS1RIdWdldTBx?=
 =?utf-8?B?QTgrejFrZVRKRWkrckQ5M0Vwd1NqczdvMjAwU2FUN2phSkpyODBRQy94eFBU?=
 =?utf-8?B?Wk1hNVlwNEVVVXVCazlBMVBId1ZQMWVKdlBGVFowcFI2cVdMUldXSmRLb3JR?=
 =?utf-8?B?bit2UlMvRmtDaVpiYzFNcDhKRTIrcVMxR0dwdk1OYVNsSmZjMThySEFhMmNI?=
 =?utf-8?B?SzQ5V1pTTnFiYUVVTGphZGp3Y3l4QWV5c1RzOVZCcjNsV0tEYXlJamJQTnNQ?=
 =?utf-8?B?Zi9XeDh6bDRjd2VqbEJ1OUg0b2lUZjJmQ3FHUU5iNmp3WHVjS3kvRHJzUGZx?=
 =?utf-8?B?cTVkZzRUaFU3VVhqdTdUY2lYbFovWnA5TmFJQmhqcEhLUHAzWEozdmFhV3V3?=
 =?utf-8?B?eXdJUnZaMTJUNFZoREZYRkFySTNCVjZhNDJhNXpONGNOS1poOXk2RGYvODFL?=
 =?utf-8?B?K0NOZUtRWUFibHBiK3RxVldCenN5YVdRNk4wOURPOXRlci9aQmJadmVJYnZB?=
 =?utf-8?B?d1phcWNWVHF6WnBBTkh5YXdTMW84eW01K3hVR0NpOWNxNmF6K2tWYSsyMGFR?=
 =?utf-8?B?ZU0vM1BYb3FMSFYzS3ZIMjFpNU1SaHBxQW9PZnphVzBYRDJlSmlSOEQ1Y1FE?=
 =?utf-8?B?c2txNnJvRmpGVStFUkRSdGJHRTJ2UWQrTkx3eWJrcnBiNnZRRUNUa0ZBS1kr?=
 =?utf-8?B?YktMcGVwL082YmNoa0RzU3hUQVQyaE93Nk13aml6Y0VlUXdJaTgwRlNjQzg1?=
 =?utf-8?B?aEhkb0ExY0VuZktZTmZMcWJCMlJWc1MzU0JoOWh6aUtGakdaeUZTL1AvQ1Er?=
 =?utf-8?B?S0hrVHMyNXlMVVlIWmNIVzQ4YzVQUmFTZUF4ak9GSUZMZEVYcmpjNmlqbis2?=
 =?utf-8?B?T2pKTWNQTUdUQXIzTy9YeGZjdktCUktZTjYxb3BKOFplSzlzVHJsQzNmZ0pR?=
 =?utf-8?B?bkxPWWJzTTUxeFJVK2NWaHNSUWhpTit4ZDlkUmxwN3ZjcGJLcWhybkd0aUFS?=
 =?utf-8?B?NGc1bjUzcWlzc0ZNMnRVZ3c5UDVOME1lQmI1VE5nZHRFNHd3b2didnNQUWxi?=
 =?utf-8?B?Q0toWkpzOGJIZXhkYjdwUHVmU3duNGdqcDRmd09oZWFOWjVuMjlLVUk5YnlT?=
 =?utf-8?B?YnlwUGZTMWJYamZ6cVNRZ0lpYkk0TlpoQ0NwMlpYTS9aWGZUMHVZVlpVcllY?=
 =?utf-8?B?VTNEOFljay82RlFnZ2JxNjhOMFJrLzdwV3NOZ21BbmxnSnpJY1hTQTJxTC9l?=
 =?utf-8?B?Y3MrTlpkVVpIbGkyOGo0M0w1KzhDZ05yZWFGWDIyd2R3OHhBVm50QXJOTkhU?=
 =?utf-8?B?UXBZdk1rYUdBZmlKbHhZczg2aG1NZHBGd0RHdGpvdVNZWHgvSFpmbW1RaEJE?=
 =?utf-8?B?VkFHTnVmdE8reFdaR2ZtenU3YkJNOTdJTHExajcvYzZLQUdTYXUyVUgrZVU3?=
 =?utf-8?B?MG0rTkw4Z2VHdlcyRlNTT0k5TmxrZFczNlp0Qllkenk3c3lVZkRrRzgzaWFy?=
 =?utf-8?B?b0JDaWpmL2Z0U1B6T29uYzUwSi8veGNYdmxzS1pIQ25JVXplN3p1U0JkNTZ4?=
 =?utf-8?B?TG8vaWY3YU5lYjMrWCtZdFRCRlgwbFc4L1FTaFlsQUNTcUhJSUxrZmtQS1Zl?=
 =?utf-8?B?WXYzOFRNS0xOMzMxdFZ5bzk2WXoyWklHVDd6RUpnVy9zaUNIYVZzZ3Z2dnJF?=
 =?utf-8?B?S3g0ejRXWlAvOENRcXpzdk1jcERKSklIRFRvNG4wcHBibGc2MXFVV1FmM0Rh?=
 =?utf-8?B?T0J2clBidEl6d2lTUUhEV2JDaEx2TnNGYjFQa3FDMm5xbE9abFJJd1pKUDJY?=
 =?utf-8?B?YnNMR3FvYWVia3BERFdJNjA5QWRmY3MxY1lJNnFtaFg2TVJkbzRqQWhCdXcw?=
 =?utf-8?B?dWt0Y0x4ZHJiQmRlelo2dlJhYmd3PT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e6196e-96d1-4e38-238b-08d99782022f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 06:38:08.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WasA7INy23rh3s872cQNMhVMpq2JDlLEoFxWWek8Meb9VXC+0WgClSA+71Torvki/zJf3euyqy+FElGLVf8ygIfeCJIk47c1U0p/Zl4PSBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4808
X-Proofpoint-GUID: Z2SizulSgaVcMX5q2FwK_aCEVhdsyj-X
X-Proofpoint-ORIG-GUID: Z2SizulSgaVcMX5q2FwK_aCEVhdsyj-X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_02,2021-10-25_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=818
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110250037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/25/21 5:44 AM, Linus Walleij wrote:
> On Wed, Oct 20, 2021 at 7:50 AM <quanyang.wang@windriver.com> wrote:
> 
>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>
>> Not only the early fixmap range, but also the fixmap range should be
>> checked if it spans multiple pmds. When enabling CONFIG_DEBUG_HIGHMEM,
>> some systems which contain up to 16 CPUs will crash.
>>
>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> 
> Looks reasonable to me.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please submit this patch into Russell's patch tracker.
Done.
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9149/1
Thanks for the review.

> 
> Yours,
> Linus Walleij
> 
