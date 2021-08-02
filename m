Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFBE3DDFCB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 21:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhHBTFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 15:05:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55146 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhHBTFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 15:05:03 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 172IuLnq012350;
        Mon, 2 Aug 2021 19:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GrX1I0UaYj6csKpfds8dJ1CwJmyyRDcyno9wRxlKS40=;
 b=ZU2rMfDOnsY3r7RIsJvUdqiTI6QCZmjoRaUYVgIrkA4U26IdAXUBV+sdkMSzv8qnbSz4
 xEOU1tVTcwFTd+GjdjnOI/Dg0LhCM1TAWptm/Ss4pNUYVaZ60VyEws1yPHxE4c/EJfdg
 /i32IcUn35Rvo/JbjgfGqa8JawkmyOspEEsSOMLWKwUaTffLkg781y/mYyOYXxX55/r2
 loGYbKOPstY0lAzfBhIvKRxMHKvWcwXP6OdgxvEz/OkcSQ7k+FVSiVLn/3HoetU1SMl8
 GaCdpuS4zEGlhUhBjFRd4IE4IlwoE+yl4R5AMpe3v/lShawKOWB7lMksEwSuQ8Kok5g1 GQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=GrX1I0UaYj6csKpfds8dJ1CwJmyyRDcyno9wRxlKS40=;
 b=i/PeUTQSJGyf4cKLquCGT0spu8+hvsuLcLIzTaoo98x6MIdufvu3hWKzCeFIXiQMJAYK
 EBnM/wO/Jco+YGI4UTSTBlPet3Ei4KGaT3AjfJQQh5WzJcss81i4moI6nS0Eb9zK+qnj
 EstyJdcYVys1Vve/gp69j652yzI3RLzvuFlVIXboRspdHm/ReOwJaOn11uPOFKGtAQeF
 IejuCEvbMBXSrFnJXlFG7nv4XCf5ntR8dR2ilE0QIejvmdbMRpC+hOrmJyEWvoF0h3iP
 gL7t8W+2RWbq4Xrzh6CynmbQzLCcVkgHUPW4366NnxWK+jdlEhxTvVKTfOWkC0rMZDZn zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6gqd91fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Aug 2021 19:04:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 172Iu4Yw046579;
        Mon, 2 Aug 2021 19:04:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3030.oracle.com with ESMTP id 3a4vjch5xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Aug 2021 19:04:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfV8Edxt2EEy98wB/1GQz9XalBovZRUDJdloEjSIrTHjJxeSjxG9pxPx6CCCHK1446wbLRqq9hopdHYBrb869ed8OQt6D2X7/nza5M3bsTZ7GpNrokIIQclYmUGWissED57YWA5JeGZ9Gp0x0m8PdiTzCmt1qfzofJgE0KeLf9zXmjjYuwFG5M4h/YcCN80FAhpHUQtWALqJzDunTncut9FO2qq4dgFhrLL6Ad8KtNFcYpPic3JHMFhyZP3KkRnQ65/MPp+3X+aPQRphh3jw3aVVkxUQBItpzriqiwgq/9OyMvqbHZ6WuJU/C2Kz8fVT9UgtNexoaeqqXE4rD9QQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrX1I0UaYj6csKpfds8dJ1CwJmyyRDcyno9wRxlKS40=;
 b=UjKd64Fa7ha5lV9xBCbdOkab9d9+or0B9cfqEv/qKMrdIKFBFc4sYZyia4KkHlIxComEZ/Qzle+FPx5QKAvclm4j/cAOtNFICbFXYTDy+05C7OCSmo9Mqru2XJO1mfzv6mGBHUpjRoB8Q7Uj2j+ueEnAdbS5NeYwyDIvMwIlyEbzdLOWgSdrKgScWcvlk3zggG6dFUUi9qiwaZWXFqXy+uSCnLCqzw2V7Qdmo51MgINjPQjMFttm/VA3t7SObg/Nm8GQambkCpyIS17wZuYWtGBUzM5HSJBjV74ZmCAKOEN5IfNoU1jyPVibitb0C+JWXDe+svEQ/0XeOYz/361Kvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrX1I0UaYj6csKpfds8dJ1CwJmyyRDcyno9wRxlKS40=;
 b=bROyrtUHHBKf33jhzxs8yAF8Ei9KPHs+h+Ti0a6vENk7lh7WMJQ2SN7ituytDEnU/N8A6lJ1F5byEkZs2baaka1be3kKOjePtjof2j/RFuwP4NIs4TYcx6iAjT/65d/TFsW52uxLsTFR9g4nw2LafNYx9E+Uf/XMWearo2RJpZA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17)
 by SA2PR10MB4683.namprd10.prod.outlook.com (2603:10b6:806:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Mon, 2 Aug
 2021 19:04:42 +0000
Received: from SA2PR10MB4665.namprd10.prod.outlook.com
 ([fe80::29ac:b1ee:9812:f6d5]) by SA2PR10MB4665.namprd10.prod.outlook.com
 ([fe80::29ac:b1ee:9812:f6d5%6]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 19:04:42 +0000
Subject: Re: [BUG] jfs: possible uninitialized-variable access in xtSplitUp()
To:     Li Tuo <islituo@gmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com
References: <6b3b3a56-b77c-aff7-c9f1-94a99d4929d2@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Message-ID: <a01909f1-19d9-8b3e-f772-3aa03b9b139c@oracle.com>
Date:   Mon, 2 Aug 2021 14:04:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <6b3b3a56-b77c-aff7-c9f1-94a99d4929d2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0018.namprd12.prod.outlook.com
 (2603:10b6:806:6f::23) To SA2PR10MB4665.namprd10.prod.outlook.com
 (2603:10b6:806:fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.190] (68.201.65.98) by SA0PR12CA0018.namprd12.prod.outlook.com (2603:10b6:806:6f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend Transport; Mon, 2 Aug 2021 19:04:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9367eb00-09cc-4fa7-3610-08d955e8628a
X-MS-TrafficTypeDiagnostic: SA2PR10MB4683:
X-Microsoft-Antispam-PRVS: <SA2PR10MB4683E5294CE61FE78614C94087EF9@SA2PR10MB4683.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dirolVT8VYBM0Uf6wb7Z5nUYqlDk5/f5/BTuBtLDifhCXzgBxq101cowLJkCAdgsvpOrDrEuZ7vcF1OYo1Vk2vSjnoaDOkrCNFBJEqgeKFoI7qtboMlIl+E0rea2nBYiIdtpm/+i/JDKj8VLKklnul2OWPItCDCEIEhXb+OcsCt/mJAN371NR17Oja9Gb1J3cRQ+fetzawzM3ziL7j/eoRhMsINvZLhNo7kgmUuHxTyRSWjas5DDBwPGVL8Bcs6KBzXfbRnJ0HuxSvRopgB5tljEZ2qPejx+A19Omvu6+xXNFKQvwtermkeE/ZaV7aJsXJn3oIEzBZXjsTJE+4lF89oWF+aFLeCMxuBmiVhWZ4sL1LjlJyXRCCP972ySnwJxsuH6ZxBb7p1BnFx61bLAqdnlRx4DiStJdMulwKairP5ULk5qf1LIAO7+FXQpCUosbPm1roiSlmYFPDk4nptPy6EpM2sRcF4W4A4ngTHndrjWoeJvk9/EyEr0PWw8xiufyz6kNVXmztyjjCBss4UQBkieufnLUaIPOX6BB2MNN8bPZdK3EE8+pYVYtwIGPjnQQlkhRPpE+Fuh0jLgUmID7AWxHlhcPFvXflBK39NguPfXtKZ5VZkyCi0HCjdP2PuODFMy2656dqf9C0EYNmJ2CI0evYCyDSLBmfQMIdFEQT8cWRGmiTjvB75ownUgUDLxaaWxqZ7P6my/OntxF7FI8g0r+LiewcfenfsSLdYehpk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4665.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(39860400002)(366004)(346002)(38100700002)(8936002)(83380400001)(2906002)(36756003)(44832011)(4326008)(26005)(5660300002)(8676002)(16576012)(31696002)(6916009)(66556008)(53546011)(186003)(2616005)(316002)(66946007)(6486002)(66476007)(478600001)(31686004)(956004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emlrYTZaUGdZSEtFcUloRlplNVpiM0pKb0xHUjMxakRBcHZEanN1dTlicEhT?=
 =?utf-8?B?Y0lCK3c3a3FSMVFUZEd6SWFRcDI0S092eDRpakNwSDhUZzJ1T2wyZHFXYjAx?=
 =?utf-8?B?V3ZVa2M2aDZJb01CRW5DTjRSNUJBRmN1SWJ4aGsweElrak1NQW9yaCsxL2NB?=
 =?utf-8?B?YUVJMDVwWHZoL1ZjMFlJTDAyYlo0TndLOGZIZHZmOEJjZzd1cjZleC9RV1F1?=
 =?utf-8?B?RjlpOXJOdklLUGEvdWhNL3hoRVRZUFIyc1hBRXoxM3NxaEdsTDZ4cTRib3hR?=
 =?utf-8?B?V1NYMWR0NHozaU01RDk2K25uN0U1cDY2U2UvWkNFK3hySmQ0cW9ibk0rMkhF?=
 =?utf-8?B?ckxTbm5SQ1FYTzBjU1ZxdXNiVVdUT3kwb1JXNzNzRnprVHlLQlpMM0RnSzFt?=
 =?utf-8?B?bVpGc1c5Rnd2aHpGVW1mcUhuWkZnR2xVanZnMWpLU1BSVWtuZWNXdCtVY3FP?=
 =?utf-8?B?QkRPUloxLysxRWhuNGRoaXVWY0d2RGhFOEwwL2hnM21XdXF6ellmc1NsRnBG?=
 =?utf-8?B?eE5veVdjOFVPekNQd1dOVmRsaTZ3MGM1SFFkL05WbnpZeG5zdlBucXFiZGVZ?=
 =?utf-8?B?Y3QyelBkLzhxSE5Mb3l5Q2x3V1RZOHZHTjczTVNCUnlMa3pjd3NOb1FQZWhW?=
 =?utf-8?B?cVVMbjlLKzJpcnV4clAxZ3p3Q0htQ2JKb2lyOW1WU0Q2RURFTk1pYzFmV3px?=
 =?utf-8?B?aml5T3N2ZFR2NTVHblVyV3ljRTFNTWQwclRHaC84L3dvVHZjeS9HMnpyWTdP?=
 =?utf-8?B?TlBocUFqYTRSMHJXL3hmckdoN1NyeG5qbVdMcHo2eXZ3S1NDSk1yMGdIY3hB?=
 =?utf-8?B?STJFaFJERTJyT3BybG00VElDUUNqUEh1TTBldTJIM3p6a2dTV0FobUF3WGFY?=
 =?utf-8?B?a01zazhlS3J1Q3NyUVF6N1BSeCttZkthaTRGbkNTNVAvOEZBWGxPQ1YyWGR3?=
 =?utf-8?B?dlpTNHNENFpOVGZ4ZG9TVG9jN1U2Z0ViMUcvekJ1NHEwamo4UUEyTnNxc2Rk?=
 =?utf-8?B?RFdPQ1NWUEdIQzVXVDRHN0Jhc29BcUpoek05NW43YUltOGJPODRWczAzY3cx?=
 =?utf-8?B?UmJOeUpNQzFVeURYOW5yM2VwaGNUcTJqUlV5My81WXpJSzZVYWpvL1dOWm1m?=
 =?utf-8?B?V3JvVVBveU1qN1FGWDc1WVBXL3lFVndNaE9lYWVhMy82VEtxZFVpVzdodXd4?=
 =?utf-8?B?VFhURTdZMmFxRXVXYWFQbitHOXFLUFBBaCtPSTFiZDh6N2ZqbGVTVUhoNms1?=
 =?utf-8?B?R1hlbFF3T045aUJqdnAzd2FQemFoYldJL3c1M1VsQzRQTWdSdDRGMUdjZS9Q?=
 =?utf-8?B?WmcxUG1MOTJmQ1A3ZEZTMDhQeHd0Z3A2T1JhT1djSGs3ZVFCcHhKMVNPSzlM?=
 =?utf-8?B?MldoaURFVTFVZHZaanc1L2pxdWlNcURsaUlpalBGV1VPdzk0bnBKUVVpZmV5?=
 =?utf-8?B?d0IxcWNQQm4zL1JlY050aFQzbkdMakU3SDF0eDAyV3RCVVRUNmpKMlhITjlH?=
 =?utf-8?B?eGluY2JLYjFYdXdCYWNhNEdld3VkVXhqTTdBVjZRQTN2OWFUT2gvdDhJL21x?=
 =?utf-8?B?ZjJDTEl3NXVDSDVCaDkraFZFc1RlRkRJdmRuTHRRb0xiajZQN095d1lnY2dU?=
 =?utf-8?B?czBEYjRxTUR1aDhGcS9EdWtZUitWZVhOREFGZEJ6OHppSE1VQnpjS1B6ZTU2?=
 =?utf-8?B?V2xIMGJEY2NxcllORjRObldOeWxzdi9pbmYyeWhGTno2bk5BYzMxMDVTQzVV?=
 =?utf-8?Q?EXG6fx+J8E/fzOf5qMYokgK0nbTSFn2czHfYjXP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9367eb00-09cc-4fa7-3610-08d955e8628a
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4665.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 19:04:42.5267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZmOEMCp1rR/ZWyW2+rG5+A20/eW0YKWrcUv7jecR57PNQ0Fpr7O1E7LE0LTAaeKqHREPeJ7fvJk/KC5SDUvimeKGiZoF1tsfVcivPCm8tE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4683
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10064 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108020122
X-Proofpoint-ORIG-GUID: _o1kAOlbeTcqb0LsCW8MKqcLUlIf_TqX
X-Proofpoint-GUID: _o1kAOlbeTcqb0LsCW8MKqcLUlIf_TqX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/21 1:31 AM, Li Tuo wrote:
> Hello,
> 
> Our static analysis tool finds a possible uninitialized-variable access 
> in the jfs driver in Linux 5.14.0-rc3:
> 
> At the beginning of the function xtSplitUp(), the variable rbn is not 
> initialized.
> If sp->header.flag & BT_ROOT is true,
> 780:    rc = (sp->header.flag & BT_ROOT) ? xtSplitRoot(tid, ip, split, 
> &rmp) : xtSplitPage(tid, ip, split, &rmp, &rbn);
> 
> the varialbe rbn will remain uninitialized.
> However, it is accessed through:
> 814:    rcbn = rbn;
> 
> I am not quite sure whether this possible uninitialized-variable access 
> is real and how to fix it if it is real.
> Any feedback would be appreciated, thanks!

I think the logic that protects us is that in the case where rbn is 
uninitialized, sp->header.flag & BT_ROOT, which means it SHOULD BE the 
last entry in btstack, so we shouldn't enter the loop:
	while ((parent = BT_POP(btstack)) != NULL) {

It does seem that some type of sanity check is warranted. I'll take a 
closer look and see if I can add some kind of error path if things are 
out of sync.

> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> 
> Best wishes,
> Tuo Li
