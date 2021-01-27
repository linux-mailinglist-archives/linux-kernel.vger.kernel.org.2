Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE8B305094
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343512AbhA0EOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:14:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53520 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbhA0ELg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:11:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10R28qJU142925;
        Wed, 27 Jan 2021 02:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/pTB1uFN6f3CVpD/Yq5hB8AKAW0AQlfldgIaQB6seGk=;
 b=s1gAiFrVl+j5BgmNypxG6ZF8MeHbfuDm7cQ0Tx5VMASuBUWcflzsYruEqPQrGsnZ2Aoq
 cuQl5omdvmqCFimm4KZiHKEqRajHPVwyQf+azxxizvodc9vLYyYCJisXv2LM2b+9FBoo
 7iE7XLk2kUds2A95qOO/0RVFmOp5eVFyS5P24nyY0Zccw4jdlypGEVf17NIi3R6V1v7Q
 c4Poa42HXSlH8n7rO4RjBHwjip7bc7Hc8GxO+jgoe0FRSFwT6ILaTHITngxD0h4hXCK2
 zk8tUguxsr5PyA/QW2lWFSvdVxh8KgvaoxqaeekJfisGxmR75POY8VSrHQOZ2RIHnhtV Yg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 368brkmrtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 02:09:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10R215qw136668;
        Wed, 27 Jan 2021 02:09:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3030.oracle.com with ESMTP id 368wcnntbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 02:09:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgfcgbOqnuuUx0N4fmhwoIb77lth4XVi04+ql+ooTh81bCOCCIrOVjZ+rU41eZf+TPFndKAxCJFmMY8ad1Rk02jB+heAXcpW/J6DPb8lftrOnjGtRGMTqFTOM2b5ueoqimGBkgU2NIZ207HGNZrrset2jjIfPjoa1cBd3bCkrGUAFfYwoMUgdr0v/DQPs80pW5g8Zqsvhcufk/9kxaaKJkZnRrkT/sa+8fDJDAUdauc5vROlJ2zbR5DNscbJZqNY7Fz7AnKgFC53l3VjrLD1T6sOtaQQdi6S/HkcoFbmK0UP0x5df/MFHoRAh3dJyIX05pSl9KnOnf9dMnDdWgdDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pTB1uFN6f3CVpD/Yq5hB8AKAW0AQlfldgIaQB6seGk=;
 b=ky1PXm0MST6qFB95JDMEe5l3NOsOoJ269WyE9QYW3+uUr6YV/91L1wTMXNYRelW3m9k1OaK726NUNkruGKDGgc+0pAso4HuKXraTSNR3pkRH+IbRCiSDJ3axZIovhO9uAZ1wGz3zMbfuLYQu40SrqWCmazLVJ9oa1rpVVwuSzDlY2Rtb8ENLhXxrGQtKsObZBc68wFW8eyL8kyLk0uXcth2HF0TAQqO8CP2fTiBR5gNjMByZ5GgSm2Hj7E6SWWPyQfk2GlUg4XCtRTIK/1tjmJdfp6DY7mgekHib0CUYD9nFtoEcyvaXZ944QM4y74QxfmJs4WtLCRGsYBRqxLZx/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pTB1uFN6f3CVpD/Yq5hB8AKAW0AQlfldgIaQB6seGk=;
 b=MZySCjeDAZrheb2o7jNcxpN90Vlv5HRcL5kxFcwyQ+YW6nO2+JGhHvSgqTg4gyu/QDrJ2QgcJRDlJIV/GvoG483g/Zou2Z41fLoD+vrzMKbDp0zG3DklxA+ni0WaJK9QetUNXhOgNY9UayfPrH4Bpw42F3RY9fKrl0ugF8BYOTs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1341.namprd10.prod.outlook.com (2603:10b6:300:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 27 Jan
 2021 02:09:45 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 02:09:45 +0000
Subject: Re: [PATCH] mm/hugetlb: Simplify the calculation of variables
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1611643468-52233-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <351e1075-0074-005a-dd70-cebc78257639@oracle.com>
Date:   Tue, 26 Jan 2021 18:09:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <1611643468-52233-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR07CA0073.namprd07.prod.outlook.com (2603:10b6:100::41)
 To MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR07CA0073.namprd07.prod.outlook.com (2603:10b6:100::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Wed, 27 Jan 2021 02:09:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e67234e-6657-47b0-78a5-08d8c2689ddd
X-MS-TrafficTypeDiagnostic: MWHPR10MB1341:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1341EBECA3230F1237FC3C82E2BB9@MWHPR10MB1341.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3snKYuKq3Pe/OvaDFaqepIayWWsxnayxQaFxzTgfz4AV5uDXXT9DabYqV7Y0P74/EmZzgGGe3vq7W6SY+bV6012e6G25MYyeMi3qxmcuocFUfMZ0d/pG9vm6oTjYjuDwbcS769TLr2uI6mPG7cuvzSBny2QlqWbFCyxzd/UYnUm9K8UjhSLQ+48cHrgxLOLVul1ACwKYtzVLQqs5rdcpfetueRrotmvW23J2OyPsG9mtz7sOzdYqkFUMzjNOg5npIbXZD7Xy1TmkOudl3pWpiAbbdFJVFjSHgTnm+J4bZ3IvUEx1wBq+lvveohpUbEGqMLJHEfT6GQzwgWeC2iZN0JVGDd5oKLhl1YQ0ehjXJKC4sieSOFFz03DiDdqlCWtNaOTMdS6QV7XK4v4z9VO0yOTgHRAtewHX3A9RlDuPc9iWebJshBZ/OCdc+vPmVzPCsgn9YidH/HoK1fiecXlviC9YMZlmhJIF5ih7R6MGhpEls64oZB+lYBxjMkoP3cGpK2yp6lmMZXEGzdxGjrjY/9wHndTYJsmSuq/bS/KAI8+eMZdAqrST3TilJw2AZUJeDO9O7AAvz/66DAj4IklyExeyajpBujoLWKUuyUEjehs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(396003)(39860400002)(366004)(186003)(52116002)(83380400001)(4326008)(16526019)(956004)(36756003)(44832011)(2616005)(16576012)(31686004)(316002)(66946007)(478600001)(66476007)(26005)(8676002)(6916009)(31696002)(66556008)(4744005)(8936002)(2906002)(5660300002)(6486002)(53546011)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RHJ0NHczY1Npcm5WclVPYVltZlZLVWlZQVNZRThacGFNZHB2M0FuQnFpd09m?=
 =?utf-8?B?UUFDSjZSaVVJSVc4V3krWjhvVy9IamVGV3MrNXlwekJuSE1UVEkxVEJzTDRx?=
 =?utf-8?B?VTgwN1JSYW55YTB5RWhvR2pxcXJxT1Q5dExRTmhlNVRlUmdERE1LeitoeFps?=
 =?utf-8?B?UE1TREIzL2N6eXcrMTc3NUtFZ2VtVTNDbVRZQ2l6QXUwQ1k0TlJwdTYyQUJm?=
 =?utf-8?B?Qjg4cGpZb0p3aGh6TjBtdGpTYzdHbmFRZWIwQUNUbDN1aG9oNU12b3Rmckk1?=
 =?utf-8?B?V1RscnNIM2hJV2ZCNlNpRXJDRWtqNnhaUlNzei90Qm8rVkc2Q2d5K1NuVjM0?=
 =?utf-8?B?cUR3aVM1T1A4c0hLaFhzNUhrNkJHOXZacDA1dmJocmd1eDZRNGN0QkpvWGI3?=
 =?utf-8?B?SlY4ZTRKUm5qb2tBL1hudGg3S3oxRnZrR0hudEJMMEpMNXFzdzllSmlFOVJ3?=
 =?utf-8?B?RkZYdnZJUWpaL1JLQ1JndXgrTHd2ejNHZ3AvaUlUSTlqVU45Y2dFZW5QU0Rx?=
 =?utf-8?B?R1F0YkcyWW4wb2lBRk5GT3pyUGRQUENjV0hsNDVjZnVuWmVha0ZhTFhZK2hQ?=
 =?utf-8?B?clpYZHFsVXE2T2hkUGNHbStpTHdXZ3FmdFdSRG1ONWF6a1VYV3JzN1RFMldK?=
 =?utf-8?B?cWpVQ0czeTJudmxxcXk4RzF3UzhkbzZRdjdOOUdzRnc0SVFQeGpBdTExMkNl?=
 =?utf-8?B?Y2sxMTZtRno4RW5VY3B6UHJlNkFjOThqYldvSUdiUlNLaWU3NGlmS1ZnUUNo?=
 =?utf-8?B?ajRXYTQ3VFFPV0JoNVN3VGkyUGpMWlV3MHkxdFNHUWROMys0QzY1R1l0Zzh6?=
 =?utf-8?B?c0NQRXU5UnZpa1N2TGRYZDZDQk5UUlZRSno0M3ZvMzMyWEdVQkF0Ny9CLytj?=
 =?utf-8?B?RGwyMm81M3g0eEsvS2I1VG1mYTVxZ2szMUszUHR3TzNJbGhYWTBVNktmTlVn?=
 =?utf-8?B?SzkvbEpZZlJEOTdubU5NTVZXdmRDL2o4V3RQUWtvMXZZbU1PT1NSd1dHYlRQ?=
 =?utf-8?B?dm9MdG5TcXRUV0ZrWVVtcGFWUkoxVmdOSVl1NU5oYTg4cnZFUXl4WEZRZDFR?=
 =?utf-8?B?aFJlUzEzSnhUK09zRlVsQTNVclhlcnpuVzBkNzk0THVIdnkra2Vjbm51eEhR?=
 =?utf-8?B?SU0yUGRhKytEK0tQU2RJdXp4YTFCTVZNRUNUNGt5VzVaYmJBckxQVGE4cVFT?=
 =?utf-8?B?dTl2WGtBM0RYTG92djhHaWkxZWZrTGkwckg0VzV5eTBMT2UzQVhSRk9VMEVG?=
 =?utf-8?B?ZzUvNXhDV3hVTi9xbTRwQzB4U0kxelU0aHU1QmpkQ2UzTDgxdTd2cy82Nmxk?=
 =?utf-8?B?NHBzTUtoNVJ4Tis3c1pLb0VTQ2xqMjEwclhYMVZYcEE0SUUwNG9PVTlMYUI0?=
 =?utf-8?B?eTFzM3ljNGJvM0pFSjFlTlpBbzhIMVBIOC9UbVhrVWZhRkN0SS9DRCszUzJj?=
 =?utf-8?Q?Sn5R3Ee3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e67234e-6657-47b0-78a5-08d8c2689ddd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 02:09:45.5429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+b+rkuV+FHcp9PlFUc66LplIR1XaDx42KMp7bq3wux9od/SDX+DBZEcAz607X9SoXjCKXYtT5Jt3vvK86pfqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1341
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270009
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101270010
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 10:44 PM, Jiapeng Zhong wrote:
> Fix the following coccicheck warnings:
> 
> ./mm/hugetlb.c:3372:20-22: WARNING !A || A && B is equivalent to
> !A || B.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index cbf32d2..5e6a6e7 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3367,8 +3367,7 @@ static unsigned int allowed_mems_nr(struct hstate *h)
>  	mpol_allowed = policy_nodemask_current(gfp_mask);
>  
>  	for_each_node_mask(node, cpuset_current_mems_allowed) {
> -		if (!mpol_allowed ||
> -		    (mpol_allowed && node_isset(node, *mpol_allowed)))
> +		if (!mpol_allowed || node_isset(node, *mpol_allowed))
>  			nr += array[node];
>  	}
>  
> 
