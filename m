Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AE64294DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 18:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhJKQ6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 12:58:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29420 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232695AbhJKQ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 12:58:28 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BFqQV3004394;
        Mon, 11 Oct 2021 16:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=z9lpEwcxl8iP6dhkotpwzmWw260eeMJLo9XGJPeFtrk=;
 b=d1oth7xDcs7fIryIFmH0fnJypRgT9ycQVOkc05hCENNwpwqXm7ulPS0GQp9tJwAU2RpL
 ASHkiQa5FM7nQh1TvLn5DQCFKngddqZq4IDYCtKt5NRptAnXu6lZ/jlWqDoK8P+oT3Wj
 pRjc9rLroP1wNYZ9ZJR+wXwgV7kL6zYe4+Xx6+1OrEQ3jIrmyifl4Plobot6o+KHJUU0
 /YHRZ6TSZT2TniIULqMfaUt8ph9nYNcvAcK0562Yje6I2GnF4IgW3qznJb5TRyCaXBpR
 IlZG+56Ns9Ohvl7VoFmvxKbWomLK0CjeW+VjxL1RN8M3EFGyw9QQFJR3hU1Rb1ELFQjf LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bmq3b8yqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 16:56:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19BGoMq1145017;
        Mon, 11 Oct 2021 16:55:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by aserp3030.oracle.com with ESMTP id 3bkyxq7uw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 16:55:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTBfPurqQhIleEiTtYAbXWXXYIFtATY8KIHWVxfF9p1pTX30Md826GbZK+eIuKmldsy2xOduUt5aGd6RO9yV83Fjqp7E8vIsV4S6beSVz4A6IZCSjDjSfkIBZRT07be/TcklRsisdpYUxetNhTRUxML1adturSsj+6ElCI5jKDX/BGiqt1uX/Ob2MaoB3ze7SxMvGWJvxc/zG+fsH+fXBCuCkxyp9K5BTUQ8yXrBhN0vWHc3XhzP8NjVPZPBjNvoqy/2Bt+GYcNQsD+IKVNKGPJTev+ovfVlPrKnIUSxXOTAipbGmsnr07VKqt5LwIxzdPEmOzWKoVu99H8y0T9a+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9lpEwcxl8iP6dhkotpwzmWw260eeMJLo9XGJPeFtrk=;
 b=Smf9Qi9prWE8vgh440qCE0ZqUY/4BE/XdYFUL8zfNwqvcGz92IdjrmgUmOStPQ9+VPk9AjIV3jIHOtWmlRhBc1dnzrUwsQFQ+8hAMv1QCFtxua8OIIiIegxFg7YAGZs8R028zhtkwTUTr+aekydXor3/2p5G+br9sdOUIHrEMFC1diT8MO3eM1RgzRBJkxVTmj9Y7m/dL6PkIg/AUJLq+6I+ULmCQU9bGWghWxkQ7LXDccvUHwzbnv71Q6U6PwsuJosZkiuhqV0vvOCJum7s5Q3gCLlb7GAyLBiAGRvvkQ3tGKv2xKdr1u6bRlSapD0jB0xLeD91Mm01T1iS0cRXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9lpEwcxl8iP6dhkotpwzmWw260eeMJLo9XGJPeFtrk=;
 b=OsVnSrAhXkmPnrZ72XJSo09ZXuzZOPPpJQXjAcWccR+aPWoCzFSHl9zIm9cPZZVs+/26f9yT2zsuwIRShejqMUrmLhhDjG74sg0YK8HTK0Jq7y/2Rq4y+85R7J/ESZpAhsNc6qGYwfHhCnW+OJkv6m6HfekM+76G1wXO8kwyyI4=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH0PR10MB4694.namprd10.prod.outlook.com (2603:10b6:510:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 16:55:55 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::958c:1aaa:ad5:40c6]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::958c:1aaa:ad5:40c6%8]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 16:55:55 +0000
Subject: Re: [PATCH] staging: ks7010: select CRYPTO_HASH/CRYPTO_MICHAEL_MIC
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        YueHaibing <yuehaibing@huawei.com>
References: <20211011152941.12847-1-vegard.nossum@oracle.com>
 <YWRaJfSqKsTqsRdr@kroah.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <df17fd33-c6be-bd4f-e000-4d39a72ba733@oracle.com>
Date:   Mon, 11 Oct 2021 18:55:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YWRaJfSqKsTqsRdr@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0285.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::33) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
Received: from [192.168.1.13] (86.217.161.200) by PR0P264CA0285.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Mon, 11 Oct 2021 16:55:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d92914d-4546-4936-acae-08d98cd7fdc6
X-MS-TrafficTypeDiagnostic: PH0PR10MB4694:
X-Microsoft-Antispam-PRVS: <PH0PR10MB46946C3CD939E6426550722F97B59@PH0PR10MB4694.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: snxsiHL3bmBveG+iQxjX5dcnOL2MnFHSM4qQNyRJtZ0cFk/ag9DKhFlJ+gAcxUuJwtSkgZwhWt0cq1+sv+TZhYph0p+OX5/clm+hdDI6/3fdgSlOZrqIcoEA59kx73oM1viCIqWpEFB1iOiOj0UxT8BvISQgTMoOWm3oDc5IK5SsvnPdD+UsmW8e7UNfRujPj6mPtKVmMEHSK0gAxf9zJzPCqnfRqLnCvodtzduDnTf9P1MHGimStAV+yGJkh4aFWBYKpgVob3iIQva1EVkmVSRDK4MeJc0uEJkXvEMIknjDt7neQeya/gkQ2qtn3L72zyO/RQepBQiJRPFS0yLWnNGTdw1YZjoiPGmG16Vca4h/58PtU+xl/Hhwqm6Wl0cgjFwSLks9s2zwmsa2HuoyGtfo4FP6u+GpzE7n8DPBRukqIOy2uIFzwDi1MP+GQj7+Dyw9vTfjqwuDa2WC34hjzBSmLIz8xg5IBpVhE4TgURG3g8zT49LmYkzmcE+/L2iAVOXV2nG3hFx6hyYBLhQLQZH2AqT8D9rn61+WhsYLO/JqeB1M3oGyr2qrB50EcR5aatZb51hnJk+Bhd3WpLKBVTA4L/QskNcBS57SUbvZ2UJnsXHhaTXOUOs38cbXtM98dz5ag83RMTDUfOcqZNxhHKlil/eHy9tx68McxRru86091LbNklBb6JjHSMcQNSXvo8rQI5EI1srXrN7TsRrfhCNIqzoYVADtxtaR7CnNGDQbN0zkmdusJ4CxzfPuLespDn8RwhyhOwJWEOMiYliOV3AHgfsX290I7hZMsagy1KI3pMOt8TEZjnh9dRTkGdkQCHdrjTOcNzb3KJ2bw54PJiRXcGehCDtghxVXrq6cm3EAO27Nkhigo2vBglW5sVPdOxy6a8lAH26gX12qUXSHQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6486002)(86362001)(4326008)(956004)(186003)(26005)(8936002)(966005)(83380400001)(54906003)(8676002)(36756003)(31686004)(6666004)(53546011)(52116002)(508600001)(66556008)(38100700002)(31696002)(66946007)(6916009)(38350700002)(66476007)(2906002)(16576012)(44832011)(316002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXRDT2J5VS9aaSs4aENhWmF4M0FENVRuMVBWTkJrMVY2bUNYL2ZLTjJKajc1?=
 =?utf-8?B?SEtSdDhJbTJxeXRCNURxdUJrTDhWRTc5VjJFTEttSjl4SDZ4akV5NTVGcVZF?=
 =?utf-8?B?RklENzFJeHpjWVdITzVvS2crZU92NUM0bC9lOC9IVW1yTnI3ZzZOYUd1bEE1?=
 =?utf-8?B?Wk1ESVZJaEgvbmxlcW9VM0s4OFFKTXBUbWxLbWl4VUgzbG93RW5IOElUT3dk?=
 =?utf-8?B?OTRDd0hXbWRMamZ6ekVucFdvaVE2ZXY3dlBWOVZQTWR0Q000Y2xzbVlTZU9Q?=
 =?utf-8?B?UHhOdE1wUGVQUDY4eTcrckdpMi9obUNTRis4c3A3NkZKQlpkQlBWMXo0Y285?=
 =?utf-8?B?OU4xMlRuYmNaQ01oMTUzMmdEekYwcERBbkM5RVdQdHB6ZU9GMTd6NVVaemVC?=
 =?utf-8?B?QklQR2lLWlo1TmRyb29DWVBJVmpwWHJFZ2hhdXYyK2t2OVVFUm1GeDA4Um9U?=
 =?utf-8?B?SW5nUWJBL2wwc3pvUkVtaDRIVldWdTNva3N4MjhlOVNUYjBnUGxIVmtXU3J5?=
 =?utf-8?B?VHZJQ1ovU0hxZXpxQktnUDFoSGIydVF5NGg5bDNxRWkwVG5wRXBTbDlDdFNT?=
 =?utf-8?B?R1V1SnJkTTQzekJQWG1DeEZrb3FMTitmVktqSUwyVTl6aStxaWllSWFRaGRz?=
 =?utf-8?B?WVVQWkR3QUhZYmhOY2V4RjFyODZESW9vcTRuSTdGSHpCdUJEVVYwWmg0Q0Fz?=
 =?utf-8?B?eDVUdEhsdm5SaHdTcFRaMVJJdy9OWVRBa2g3aDZZMmlud0dDeHFPQTZuZ3dT?=
 =?utf-8?B?OEJaNWJQUnA1cjFGcnR1b1IrcVAzTEN5dlhObGRVdTB2RTdtUnZKQTJ2bWRK?=
 =?utf-8?B?Ykl6STRRSzNCUmc4Vzd2ZWJhcjFsQXcrWGlvck1RSEhQVHBUYUYwVmxVREE3?=
 =?utf-8?B?NXBxS3Jib0NIakNIYU1Ea1pPLzU4ak9DQzJpVjRiU2tsdTloNk5EVUowRDVD?=
 =?utf-8?B?Qm9BNlozV0pHODlTRkxLK05GbjdsVERQZnN0R1ZKWDEzdnFHdHNwQzJPL1k4?=
 =?utf-8?B?NCtISTk1QXlaQWEraHlrRFV1WTBqQ1ZXUXBPcER3YnRQcjVGWlNIc2ZPZVBh?=
 =?utf-8?B?Y1FaNXdUdFJFZVd6WkcyQ0JsV0R3VDY5Qmw4alZjNnRnT2ZhQ054WnlyVCt6?=
 =?utf-8?B?UWR1K0NiK1ZiZnpZY0RSNjRUM1dmT3prMVZPWktJaFhPN1RpcVgyRlRlMkhH?=
 =?utf-8?B?cnV3alpldFVOSmIwV3BBNFVGU0NSZUR0eVVKcWdvekhORTFlRWNOcDVWNzdr?=
 =?utf-8?B?b3RjNmJ3aENkMEtraEl2UkhsaTBjbThDajFlQ01QNWZLaEJTZDdBV2lBQkd0?=
 =?utf-8?B?YmhGS09qeUozeWJzUGlYMmZISThlaVlReHFkY2owVWd2N1U2dE1JQ2FaS0Vv?=
 =?utf-8?B?Ly80VnVjZUlkRDJ3YmZPTnlwNkNGaTdVT09rb2ZQOE1nSEpiaU4ya0JBdFhl?=
 =?utf-8?B?TWdCamkyOTVhL2dDc3U3SlhOY3cwc2NGbzlCQUZjZ0o5WVZBMnRQaWhXQXIx?=
 =?utf-8?B?MnJJbWw0NjkrRHFTRzNGcWJwa3dNemZsQ3pMMU1CTEQzc2hjZlVURlpHVmk1?=
 =?utf-8?B?ZG1EZXZBSzdkZDJHOHRoOGpFT0VRNW56d0ljOURjSVM4UnNsSUhOV05weGZR?=
 =?utf-8?B?T0tXNzRlRjJ2ZjBWT2VrSDYyRnhHWUFWclZ0Vm0ycmFHNTZSVWZIcUZZRm1V?=
 =?utf-8?B?VG0raFBBWFVDSmVFSldoZ3k5WlF4S2R2eDk5OE4vZ094TkdLcnBqYWdoeWY5?=
 =?utf-8?Q?Dr3F14XxJIer+rsl5TAQMNS2RxNHWwqjkvNI9r9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d92914d-4546-4936-acae-08d98cd7fdc6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 16:55:55.5439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdOP0YfBEyGLjve7oU2W3L25g70sKNmF1B8HXEjOsyzXyi1S3p0qZsNYORmxL9Ll35iN120gWCJKVAqhUVqNc9ygMVDngLQ3MzYGVGVAUYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4694
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10134 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110110099
X-Proofpoint-GUID: xxPfC-REG_BVoCdiDbzHOyHqvcfLuiKn
X-Proofpoint-ORIG-GUID: xxPfC-REG_BVoCdiDbzHOyHqvcfLuiKn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/21 5:37 PM, Greg Kroah-Hartman wrote:
> On Mon, Oct 11, 2021 at 05:29:41PM +0200, Vegard Nossum wrote:
>> Fix the following build/link errors:
>>
>>   ld: drivers/staging/ks7010/ks_hostif.o: in function `michael_mic.constprop.0':
>>   ks_hostif.c:(.text+0x95b): undefined reference to `crypto_alloc_shash'
>>   ld: ks_hostif.c:(.text+0x97a): undefined reference to `crypto_shash_setkey'
>>   ld: ks_hostif.c:(.text+0xa13): undefined reference to `crypto_shash_update'
>>   ld: ks_hostif.c:(.text+0xa28): undefined reference to `crypto_shash_update'
>>   ld: ks_hostif.c:(.text+0xa48): undefined reference to `crypto_shash_finup'
>>   ld: ks_hostif.c:(.text+0xa6d): undefined reference to `crypto_destroy_tfm'
>>
>> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
>> ---
>>  drivers/staging/ks7010/Kconfig | 3 +++
>>  1 file changed, 3 insertions(+)
> 
> What commit caused these issues?
> 
> thanks,
> 
> greg k-h
> 

So I found this commit that appears to (attempt to) fix this issue already:

commit 3e5bc68fa596874500e8c718605aa44d5e42a34c
Author: YueHaibing <yuehaibing@huawei.com>
Date:   Fri Jun 21 15:24:55 2019 +0800

    staging: ks7010: Fix build error

    when CRYPTO is m and KS7010 is y, building fails:

    drivers/staging/ks7010/ks_hostif.o: In function
`michael_mic.constprop.13':
    ks_hostif.c:(.text+0x560): undefined reference to `crypto_alloc_shash'
    ks_hostif.c:(.text+0x580): undefined reference to `crypto_shash_setkey'
    ks_hostif.c:(.text+0x5e0): undefined reference to `crypto_destroy_tfm'
    ks_hostif.c:(.text+0x614): undefined reference to `crypto_shash_update'
    ks_hostif.c:(.text+0x62c): undefined reference to `crypto_shash_update'
    ks_hostif.c:(.text+0x648): undefined reference to `crypto_shash_finup'

    Add CRYPTO and CRYPTO_HASH dependencies to fix this.

    Reported-by: Hulk Robot <hulkci@huawei.com>
    Fixes: 8b523f20417d ("staging: ks7010: removed custom Michael MIC
implementation.")
    Signed-off-by: YueHaibing <yuehaibing@huawei.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Notes (mainline):
    Fixes: 8b523f20417d ("staging: ks7010: removed custom Michael MIC
implementation.") # v5.1-rc1
    Lore:
https://lore.kernel.org/r/20190621034221.36708-1-yuehaibing@huawei.com #
driverdev-devel, lkml

However, it was reverted in v5.2-rc6:

commit a4961427e74948ced9ddd40f3efb2a206b87e4c8
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon Jun 24 16:45:34 2019 +0800

    Revert "staging: ks7010: Fix build error"

    This reverts commit 3e5bc68fa596874500e8c718605aa44d5e42a34c as it
    causes build errors in linux-next.

    Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Cc: YueHaibing <yuehaibing@huawei.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Looks like this was the build error in question:

https://lore.kernel.org/all/20190624173855.3c188955@canb.auug.org.au/

To be honest I don't really see what the full recursive dependency cycle
is, but I think "select" should work instead -- Arnd?

Maybe we can add this:

Fixes: 8b523f20417d ("staging: ks7010: removed custom Michael MIC
implementation.")
Fixes: 3e5bc68fa5968 ("staging: ks7010: Fix build error")
Fixes: a4961427e7494 ("Revert "staging: ks7010: Fix build error"")


Vegard
