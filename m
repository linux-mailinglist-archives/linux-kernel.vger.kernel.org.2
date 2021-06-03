Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A5639A27E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFCNvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:51:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14948 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230099AbhFCNve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:51:34 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 153DiBiv018769;
        Thu, 3 Jun 2021 13:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=O7mwBXpW/qchQHopHE2q5tb5KtnRT0zlc6Hq8U4lG/w=;
 b=ZFPBQmlH9QfXupsgMWvn+3ALd9LC06FsBiX0PM6LCM5AcR3n/Ixja69XXP8PbG3V9q4A
 XsywZdr54Sl/nR3cdVzE3vAZc/lRbhl7gAGdALarkck+Rjt1+bjxdMvu0TKnYtLNUrNB
 ErbL/AMs1GFYiM3XhCabadP5Zke3vtyhAZcgs9uMqw3HkjUFwmgp28zeZMVRaz+Liond
 jptOXCNx0yNjqKBphFpUiroFaKkNnVdRunpyVbpJOPfQwso7TZYQO1vqt3KDquPsEBjl
 xGQuSLuuDlBM7Mnp0NAQR+GdWwfxUR6CrhByO7AsPct25MZnRUt2KRqf0JpA9Xk9fHZR fg== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38wu57rse3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 13:49:10 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 153Dn9IO177944;
        Thu, 3 Jun 2021 13:49:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3020.oracle.com with ESMTP id 38x1bdwb1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 13:49:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/bHl9BW5nmiQ70z6HBx2HsmtlnLH8UZUi3ILimJpTZM7IrzuJ+69cWKsLPNNSAxuHOf6+ILALUd2UfMryqVD0HqZvUcJSX3ga4+1220k0maxOPgInMk6BSnz4Kw+eCliN/H5O8pMjLGtrxhGB7yQxM0TV5SJoQUfNU7fl5Uv2HMM0xG38t1/rfgk7+MqFzYMF47TretvkePBvfSlmMsmU7KkD00n+//l3cf9cjhegMKrVZqP0sI++FM66nGfSdslklnhn6kxydYo2buTUHdiHb7m6kCam+UzHl6c4HzQ+C2Nk42KzajTPBR5SMnmWCi+K7fL+V+M8XBtjxKrHoGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7mwBXpW/qchQHopHE2q5tb5KtnRT0zlc6Hq8U4lG/w=;
 b=F25dDoQpAwAdRl8oW2BqYocNSiqKFKVMuadA7LANsRLsfKFG8Kav3+fdjZvB/z6DaPHptkTW2qUBnaUKRCybvHkre7NmpzG7HnHZ69dQxuKnx/ERFeldc7Ab4idj8PixikPL6LWp5DMnH1pmMvxhPJfgmc8MqT1Twvz17gjJSWO5+Zlmayz6MLxsC/sH0C7D2Mpb9DuZwzT/I7KVkKv+++TPsRChgPBWD62fQtoYjIDCPvSlHRx2UM/h0c0ub9OnKlJ4dTEYoe+HJJIFdq8ZlKAR3kZVnwJxadsU2ua87gJZC7+R81TEZ0Ny8z2SyT6feFmBVk+v6ioA6Ubpy+Tljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7mwBXpW/qchQHopHE2q5tb5KtnRT0zlc6Hq8U4lG/w=;
 b=V3woexmICbTowoq7entjGGOX3xbEoo0FcytC2BPRzqHB4GJzC37TU3YHVvFzf4vrfA/zDqf7vLAyN0Kq1JGirQTQibNB1xAg44Q0uK6kUhAFEX0T57sjg4GHoaiKBLvXHFq83CFrebN6mRMRUKI0FUiws8J8zCAbPoHWxaKix0k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BLAPR10MB5170.namprd10.prod.outlook.com (2603:10b6:208:321::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 3 Jun
 2021 13:49:07 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::78a3:67d:a8ca:93cf]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::78a3:67d:a8ca:93cf%7]) with mapi id 15.20.4195.023; Thu, 3 Jun 2021
 13:49:07 +0000
Subject: Re: [PATCH 2/6] ARM: xen: Register with kernel restart handler
To:     Lee Jones <lee.jones@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Russell King <linux@armlinux.org.uk>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Stefan Agner <stefan@agner.ch>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20191015145147.1106247-1-thierry.reding@gmail.com>
 <20191015145147.1106247-3-thierry.reding@gmail.com>
 <CAF2Aj3hbW7+pNp+_jnMVL8zeSxAvSbV1ZFZ_4PAUj6J0TxMk7g@mail.gmail.com>
 <20210603131124.GA1040254@roeck-us.net> <20210603133840.GB2435141@dell>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <7a1cf301-ba99-1e01-c43e-53b53f4d3e04@oracle.com>
Date:   Thu, 3 Jun 2021 09:48:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <20210603133840.GB2435141@dell>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [160.34.88.237]
X-ClientProxiedBy: SJ0PR05CA0115.namprd05.prod.outlook.com
 (2603:10b6:a03:334::30) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.74.96.237] (160.34.88.237) by SJ0PR05CA0115.namprd05.prod.outlook.com (2603:10b6:a03:334::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend Transport; Thu, 3 Jun 2021 13:49:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 655ac849-8134-4ecf-d1c1-08d926965b53
X-MS-TrafficTypeDiagnostic: BLAPR10MB5170:
X-Microsoft-Antispam-PRVS: <BLAPR10MB51701E482B811905CDD4639C8A3C9@BLAPR10MB5170.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcy+0KjsnIhIORYy1KRMCVKDoyvQ842cg+vqijlmARWOt4fDfaKlcLqMRlcx+wXs3/zrGJtYSV1LAAgO1LJwV/y30dNL+IrqDBxSAYTRubdlGKVt1fxgca1pKwj7OcXOLSIyeaJgb1JBoeYZ3v2bLvPh2bA/hfFdnCU105vT+9ojZagANG861QYXpUVCrOMJlB4q/QiLz7k6jMXD9PbgMqCDh0kA88GZrOgPKSZSUMgMNqgBsLU1wSdK/oqJzMJsgG+PRDy9PUb/Gn4oVHnIpC89TjW5e8J4IF+dwVnI90hJXu/k5RSCwTAPoXdFKreMBbdcyLK14sDY5Jqcif8WEjHKJF0B0NA9wjxbrYy2Nxq0ETSRGXmytwa6R0sPmZHqwlKaCQewrFRnOEa/1PU2kYqrUiY8FnK3ml9YDMwvD9lLLcysxu2/4qeCzNsk2l4Qkm1wCOLlofls8LiORcJIGtskjKgeaMUWqFZ6nvoqf37zhl57W7p2IDevn95BBEka7lalxyL8D5bNSOpSIkVXnRt/UfaKpatRgz+YREhWc0l0p5TodjgYp8X7GhEt/a/F1bfSk0ZTqAdpsK4ndk1+kbSv0IIwJgEiQ4d+dyAgnB/wj/eQnA2Y1Hy0KFMpc4NdmaLFxTCzYHrhfbuCIz/INJdK2HssQoOTp3bl1kK4eGA76VRw8/PK8iDxik/NKeFd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(39860400002)(396003)(6486002)(66476007)(66556008)(66946007)(5660300002)(2616005)(7416002)(31696002)(110136005)(478600001)(36756003)(16576012)(316002)(83380400001)(53546011)(26005)(956004)(38100700002)(2906002)(6666004)(44832011)(186003)(8676002)(16526019)(86362001)(4326008)(31686004)(8936002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VlNNY1YwK2xlWlQvSHI5eW8yNitiQktRaEdPbVY5dFJSNmt4VnY2cmNoS09s?=
 =?utf-8?B?aC9SOHZkYURaY3NkaUpWNU1BcEpYdnlwcURqNDZFait2d2NGT3lUZUpaQWpS?=
 =?utf-8?B?bUZuTFozeDJIYi84Ti9NYWgxeGE1V0ordkRYUWVqdEp4bEVzc05TNkhKeDhR?=
 =?utf-8?B?R0NpM2MwK1JPeCt4YjN4bGRmeXdDRS9QbHBaYnZjQ25Pa0V1dVR5ZzBlZnhs?=
 =?utf-8?B?djhIa1Fmbm5aZWxqcGFjcUdNRTgxdFlObHdURmdtOFpPM3FxWmU5dlNOdVho?=
 =?utf-8?B?NExEemQ1a3FJbHJRUUllK0w3Y0lrQktBN2hHNFBOVWhHeGw5djI1WDRiZ3Q4?=
 =?utf-8?B?bTdKRE5CSU8vcTlIWThkd0NTc1lBYVZTZUJOQUZ3SFNGWXMrRmFxSWpoSHhC?=
 =?utf-8?B?Z1ZpWDlrZ1RaRGdqRktUZDJpQ25DZGFYZExBeXdRU0JTeDNjdlNuKzNQSis2?=
 =?utf-8?B?L0tNQnh0YjBVMVFZU0s5NmFOZmxzVHU4RmVmd241dkNDZDdmd1YveXBudjRk?=
 =?utf-8?B?dHlzQjhLcnJhNzBMWFcwdDQ1RWlCK244NjFkR1RBTzFkQTdJcGxBVi9lcFdy?=
 =?utf-8?B?d2t3WFcvRnB4anpvMmRCV0ZiU3VmRjlIeW44d3FVQzgyY21yZTRxdnpkMkww?=
 =?utf-8?B?NTU2d1R3bWp0cFF0NHFtU29qSStHOGVpZFNMNXcvMmhVMkVEYzRId2dTbGZo?=
 =?utf-8?B?UjJaelNlbDVYT0RKdk1UbnFUbzlENEFzaDQ3OEM4VERFNG01QmZoeUV1ckNz?=
 =?utf-8?B?WUgxMU9LRHB3MHZlV1JJcFd0bHZMUnRUOHVUcXBLYXNHWC8zenhMaGpDT1lz?=
 =?utf-8?B?MDlDSkY0c21qZTF2ZkNKa2grYjJFWTBldzM0ZEtuVVpVRnZvRGRWQ1lQVzNI?=
 =?utf-8?B?NkwvSEg5dXR4UStLSjV1WTZXbkdzK1VCY3ZCWElKRkhuSkpGT2lMNG9kR0Jl?=
 =?utf-8?B?MDY3bi94TFZLcmt2ODViWGpzbFpEREVWZVBCZi9qSHVNL3c1UjF6djNGVXoy?=
 =?utf-8?B?bWxUUnpFdC9uQ2pmTU9vZGxPMUh1eENHNUhKTUczaVF4TlF0bi9ieW81Q2dN?=
 =?utf-8?B?c1ovZXFCd0orRHdsUzQrVWgvU21Uc1RDMGRuMXJlR01MSlE1akhsQjJuRlhx?=
 =?utf-8?B?dXNONWNJR1BadCtWcncrenBaVDlzbFNWVzl0NHI1U2xpb2Q5bVNYWktWTEpK?=
 =?utf-8?B?bFVxVmlwTEE0OGZoUmJPUlpudUxIV3Y3ZmtHcDhuNFhnZ3Jlemlrbld2bStR?=
 =?utf-8?B?eWplT2NNSno1S2IxM0Fad2FoeEtHRW1rTlFjNlZCYU1lM2FubktnT1BlbHZh?=
 =?utf-8?B?U1JCd0djakVlb2wxdWxDRFlFNHNHcExLMy9abU1DUDNpcFNuQ0RoYjFWa0FR?=
 =?utf-8?B?Q0JxSkdxNGJkWis2SVlVeUppVzlvR3pYYVVuN2wxZUVORi9idUUydlFvL3NY?=
 =?utf-8?B?Qm1icWVSUWROS3RCdUlsaTFPY0xsZjNZaE4xOStheHJCUVQwUTlMTTlQVUdX?=
 =?utf-8?B?bDZCaTdtblZQWnBoNXdCQjd0S29wS0RZc3ZlT3FXUkk5eUlrU2VOd2txQ0tH?=
 =?utf-8?B?cFZOQnFSNitrWk5UWWdHK0dGaUtHcndVYXgxMXJQM05qVFp2Wkw2bGxla0VC?=
 =?utf-8?B?bzBiNzRZblZyandNekRXV1VaSVZkcjRpTDFwekRWQjRUN1J2ZkFqQlRoYnBp?=
 =?utf-8?B?Nk1ZbDBFYnhzTVhiQlM1MUlpY2ZCNHE3bWtzU1VUS0lScmtvRUNMa1kwYS9y?=
 =?utf-8?Q?O7VFv0E+4WI2rTGJy26FMK3khzzCSXAooYVKqXB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655ac849-8134-4ecf-d1c1-08d926965b53
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 13:49:07.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zm01geiGf5qDkQYP3u3jAWFL9Mr9D/sT6nTUQhOhBrTZr2rBJAC9Ddq3wEXZUYxIhgdfwgSBVqkt0r9ejtZQMtXfDX8P0T5ywyJfwB0SuFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5170
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030094
X-Proofpoint-GUID: 7g5lAECkPdUHHMt33Jja8J8szDs3oj5j
X-Proofpoint-ORIG-GUID: 7g5lAECkPdUHHMt33Jja8J8szDs3oj5j
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/3/21 9:38 AM, Lee Jones wrote:
> On Thu, 03 Jun 2021, Guenter Roeck wrote:
>
>> On Thu, Jun 03, 2021 at 01:43:36PM +0100, Lee Jones wrote:
>>> On Tue, 15 Oct 2019 at 15:52, Thierry Reding <thierry.reding@gmail.com>
>>> wrote:
>>>
>>>> From: Guenter Roeck <linux@roeck-us.net>
>>>>
>>>> Register with kernel restart handler instead of setting arm_pm_restart
>>>> directly.
>>>>
>>>> Select a high priority of 192 to ensure that default restart handlers
>>>> are replaced if Xen is running.
>>>>
>>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>>> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>>> ---
>>>>  arch/arm/xen/enlighten.c | 12 ++++++++++--
>>>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>>>
>>> This patch does appear to be useful.
>>>
>>> Is this just being solved in downstream trees at the moment?
>>>
>>> It would be nice if we could relinquish people of this burden and get it
>>> into Mainline finally.
>>>
>> There must have been half a dozen attempts to send this patch series
>> upstream. I have tried, and others have tried. Each attempt failed with
>> someone else objecting for non-technical reasons (such as "we need more
>> reviews") or no reaction at all, and maintainers just don't pick it up.
> Looking at the *-by tag list above, I think we have enough quality
> reviews to take this forward.
>
>> So, yes, this patch series can only be found in downstream trees,
>> and it seems pointless to submit it yet again.
> IMHO, it's unfair to burden multiple downstream trees with this purely
> due to poor or nervy maintainership.  Functionality as broadly useful
> as this should be merged and maintained in Mainline.
>
> OOI, who is blocking?  As I see it, we have 2 of the key maintainers
> in the *-by list.  With those on-board, it's difficult to envisage
> what the problem is.


Stefano (who is ARM Xen maintainer) left Citrix a while ago. He is at sstabellini@kernel.org (which I added to the CC line).


-boris

