Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491433ACF63
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhFRPsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:48:09 -0400
Received: from mail-bn8nam11on2056.outbound.protection.outlook.com ([40.107.236.56]:9057
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230334AbhFRPsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:48:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U661ilosKkVdIfzwToxXUG6d+oe85NemVfkhUzkZtGxjvevDAfl4Ts1vG8Qk108kq/wsHxUIeLp3mZZZmoKyW8zG9eXrBMsipxeCv2+lmbMV2r67gnzpyI/3Z/rl5GkhH5Tnb/wNFQNBGt1WH3Fc4ccCVRiPGFEAN0SOTDuNrr0LyfTmnqvwx3Ns5igU0q7HukFIn9RORZvPFlGq0jCYRYJ+cxan72QxBdFQEK5OVzDLwJxWG7upTcI3y6Sqw4Bxv7uMmSriJekfSAzzd2pMXnQ0tZ/JqmbWLk77uluYu/98/3l5ztjEHtt7sDkD188yw78EgJiO1FkrGu1gEXLkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0doiD487LOgpgS3FyNF6xkUSsozZVY+lsjkQ1T93TM=;
 b=fxLm8YAzJVaCqxKZHUNSXvUKzP13MYCI8+mPp7n2itNq/t/61ZJ8BzFM5JcFUcDog4TTQBB5BScGXhIpQo2UeRBAjS0xYZfUocyvl18Imw3tEPSEimgeI2CrY459Uzdr4KaJDW/qIbFcEdAq++ZrnnuRMGo2/OWlmxMmPKh9EyveHN6za/rM/ofYwkqljFtKEZzCYgnegUXOz6/jSSFwu8ej7FDwyUGgM62IBWIEFgls86929UosBgFCTMu09Dgp81prNflvJQmZS9FToNaUbMD7KdBEo0Hz3D7OGRuUDDu5JWTSmYYhD2c0dgGBcH0Ynhx6D2nKwEw+xq69nArbvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0doiD487LOgpgS3FyNF6xkUSsozZVY+lsjkQ1T93TM=;
 b=meQ1ypQyKIcRXDYJHAS6Fn6UZXTCiRWSbP3RvaiMNhUXzRfMaEELuXWAvK8v+/WVY2mw1noaqIyfiFLwVC8i9aBZCjbl4DKG4uWkfL5hZhKKuBJJKx2Sbd8Vd9gU11kXvkHZNjxFyUBdPPflHow079dgKM5YejoWWPh3MecCzIGhw/neQ1ctaxmAe1mmRkETtaAMezNnLAqzLAd7z7RJBNIAHAPukaB3UdvTbS2Jj7BQb/ng0sO8r7z9ST2uiHlaygGMQcjPE1IYiDWjHP94hCCUSS5TEXjDZC/28YRSV59p7zWJPeIrCpYuVr1xO3QqBJKGoqJN/0mhpt0xm7E4Dw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4519.namprd12.prod.outlook.com (2603:10b6:208:262::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Fri, 18 Jun
 2021 15:45:56 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 15:45:56 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        osalvador <osalvador@suse.de>
Subject: Re: [PATCH -V8 07/10] mm/vmscan: add helper for querying ability to age anonymous pages
Date:   Fri, 18 Jun 2021 11:45:50 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <9E787EAE-BED4-4902-B34D-F08FD8F21D76@nvidia.com>
In-Reply-To: <20210618061537.434999-8-ying.huang@intel.com>
References: <20210618061537.434999-1-ying.huang@intel.com>
 <20210618061537.434999-8-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2F5A0EF5-4EEE-4795-96FF-BA8CCBFFD215_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: BLAPR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:208:32a::33) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.58.56] (216.228.112.21) by BLAPR03CA0118.namprd03.prod.outlook.com (2603:10b6:208:32a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Fri, 18 Jun 2021 15:45:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e9e2066-e451-4301-0e2d-08d932702949
X-MS-TrafficTypeDiagnostic: MN2PR12MB4519:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4519A39A3BE030ABECF90D02C20D9@MN2PR12MB4519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o39fTsxU/qady4L8PAaopGxa9wrofBUqZLDqQgidkf08VNy2gAxhIgBAIjDQGZUSmG+y498YQQk/mYwc5etD9fAEHfA03szkkcBCa+DheP504c2S1G7cBnoYKbPkVSmDzYYF+eGAvpacGfhItmnVAZ9qg/d1RG8dZ8eDZWB2B+djvDEXmuZM1r/7WgOsMUKAbjUOs7T0/zxvxTZp8NnUt8VD7feqT6j7E0IIFSfG2hC1RzBIKolEiEWn2Q7eefBHZz5Z0givoxk9QAw8kOzdqxdNgrBejFZTl8TYX0vWNDbH/IGy6lOemb6uoyU9VxL+jvcCmOJEH86gnxMRuDwxuA/+61KB5dNKmiyMUIL+F6OxP7OgLidNHZIgHfDRiYZ6ITnQo7Jh2oP85ZgohSYdULZyo+Qvn+qIyFlhYDRSrFWxKdgVTOuG+4D3d0U2e3AZqWi8tdlIe9No0vJQYxSY4UaLYm+/+TyxbD5ZRCL7CGBE7N1meHCJ5RhkByaWFBFxlvfYkwXr6M2RILylW96eGCCe03LHqKqiOYEN87eZxBqBwNBrLvHeIotTtwSdnPvf/9o1YeL9Q9/zvRnkdt38IiKDm//mKLnFQQfAteSWJPw7HQGs0wbqe+eg55+uuCeHyCkXKxpgbX7TVJ6iACXRzeYA6rM9I0B1ePcXIcSOCcIVquuatHb06zyviG0mDq/g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(186003)(16526019)(6916009)(66556008)(66946007)(66476007)(7416002)(33964004)(2616005)(956004)(21480400003)(235185007)(26005)(5660300002)(8936002)(33656002)(54906003)(478600001)(53546011)(86362001)(316002)(83380400001)(36756003)(6486002)(4326008)(2906002)(16576012)(8676002)(38100700002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWcrZG1UWHVmOUZPQ3pUdGZTL3NxVkNydnpZSEdSYnBTZDV2MjFpVEZHcEEz?=
 =?utf-8?B?cHBleWJZV1pweS92WGY3cE1CRU0rYkNZWStpL0JQWUFLL0tmN2RYQTlaS2Fp?=
 =?utf-8?B?UDJyNXB4OEVBbzVOVDlxMTNKRnJMZFFPQjFMbkM3V1ByMHlYajZaNDg1SzM3?=
 =?utf-8?B?MDI4Yy9uUzFORXhaMG5KWmo3NlVhaktsbk8yTEwvN25mS05tSHYyeklyeitR?=
 =?utf-8?B?RlJIY01VRWJqelJKcVhvaW1ZRHJEamhSbkp1clVCTFl5MDdPWk5jM0ozWnBj?=
 =?utf-8?B?QzJLWmZCUEFvUWl3UjRuUkIvWXJuODl1Sk9ZbUd1eTREbEUzTHJhWVUrODh6?=
 =?utf-8?B?NCs0bU1vaUI2elFCSVdIN2FJY0Vnd0JLUGFVTG4rQk5DT2R2R1lrMXIyMGI0?=
 =?utf-8?B?ODdWa3YvYisveVp3UFVjaWlkYTdCZXVhTms2SGZZNUY2VmZ4MkJrVVJhR1V5?=
 =?utf-8?B?OXhTQXlrd3B2NTgyYmJHQ0lrTSswMmduMWVpVGMyUlZ6aWEyL01WUTI1cllI?=
 =?utf-8?B?TGp5V05NZkwxN1E3Um82YnBnbTBYb0FVWlNPWjhJSmNIOVRmeWdvNGgrZ29S?=
 =?utf-8?B?TDJzVnhlUGxXbFduSkNGcGVJZGN6Z3dqWC9TSmVEWVlsb0UyTFpNMS9qTkNR?=
 =?utf-8?B?SzlLS1pkVXF2WnBGRnhoekpNSFIzY3dJcm1tNllINEFia3B5aVhVTTV3dFdt?=
 =?utf-8?B?NndVNE43K21nWlRpVnh6YjFhZ3ZtNUJGQ1U5czRWc05xeEJndFh6TytIWWlU?=
 =?utf-8?B?L2llalJpWDR0N2VLeTAxaVBjWDJSaHZzK003ZjRUS1VYQlFHSjJoWlZ1QVA4?=
 =?utf-8?B?NG1uVXdyYWRwbGRJcHJQWVF6ZUYyeWVLVnNyOUNIZkFhNDFkaXNIRjh6U0RE?=
 =?utf-8?B?N09wczZtMmI2NlFCMHVuenRjWWt2dERiTHEvK2VvM00xQ0dhUDZqMHFwQktO?=
 =?utf-8?B?dlYrcDZEaUR0aCt2akFodDFBcUZ6aEhFSjdjeStLYzVxNHdvQnlqNnZBa2pH?=
 =?utf-8?B?dUszMTBQVDJFRzdEV3pPWWlVNlA5S1BmbTN6a2IwSEs4UXRBbjkxcUNaUGlR?=
 =?utf-8?B?YTE2ZmlqU0hTU2w4SWtuNDZrK2c1Ry9GZmNZWU9MdS9FYnFSZklhZTlvTVR1?=
 =?utf-8?B?QmlHUzhBMnNLb0pONy83blZBUUQ2M1dreHdSZUE1TnpkZytRc2NDZFlyYWxL?=
 =?utf-8?B?bVBZUDY1Vk1rTjR6QVhjWnFVVXJYTzJ5OHR2eDN2Qm4zdEI4WmZYeVVQU25y?=
 =?utf-8?B?QzRXKzhGWGxDbFNhVE9tNGxXdUZFVit6Y0xCV2VsQzJqUS9JQ3dKWDBXaUJL?=
 =?utf-8?B?aU9CRE1zbzk4MzR0bTlNUHpJUTU3bTEzV1RGdjdWOWYvL1BlWURTdkcwckt2?=
 =?utf-8?B?dGtQN0dObEdtc0xyOEJWekNIRVFTWkZIK0lWTkdMMmt3bGI1Wi9rQytPNkdq?=
 =?utf-8?B?TElmbFJISDJnKzdtMTFGUTVZcXhTcStqMjJXY0RBa1ZzclUxbXJCeU53aVM5?=
 =?utf-8?B?WURUWW5MTDVyb0FKMXYvRWRMb2FPWVJHQlpWazNXZS9LbGhZL21xVk1kZUF4?=
 =?utf-8?B?ZTNEaHZzeWRTT3NzRTd1ZGUwU1gwZG5uTFF2MHdUSjVWanIrNGpCRVo5UE1Q?=
 =?utf-8?B?UFlWK0Q2WjZhTnB4cnA4aHZQeFY4c0hwWmMwYjVEMjNkQmU1b2ZCWW96QVh2?=
 =?utf-8?B?N25TK29BREZyRFAzdThpMVJCWHNOc05vcW5RU0VkK2xSL09aK0RaOFFQTVJI?=
 =?utf-8?Q?Ly8N7F2lSTZwhxTC8Lcj54cdvzGM95ZEm9eHWwC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9e2066-e451-4301-0e2d-08d932702949
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 15:45:56.3233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2nahmdzlz2+V5koF195HfUe+F4zBnC2FOORHLFt/gHkU4DxFeF42ZWrvXD/xad2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4519
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_2F5A0EF5-4EEE-4795-96FF-BA8CCBFFD215_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 18 Jun 2021, at 2:15, Huang Ying wrote:

> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Anonymous pages are kept on their own LRU(s).  These lists could
> theoretically always be scanned and maintained.  But, without swap,
> there is currently nothing the kernel can *do* with the results of a
> scanned, sorted LRU for anonymous pages.
>
> A check for '!total_swap_pages' currently serves as a valid check as
> to whether anonymous LRUs should be maintained.  However, another
> method will be added shortly: page demotion.
>
> Abstract out the 'total_swap_pages' checks into a helper, give it a
> logically significant name, and check for the possibility of page
> demotion.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Reviewed-by: Greg Thelen <gthelen@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
> ---
>  mm/vmscan.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7d5c7216a4b7..8654cec65522 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2706,6 +2706,26 @@ static void get_scan_count(struct lruvec *lruvec=
, struct scan_control *sc,
>  	}
>  }
>
> +/*
> + * Anonymous LRU management is a waste if there is
> + * ultimately no way to reclaim the memory.
> + */
> +bool anon_should_be_aged(struct lruvec *lruvec)
> +{
> +	struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
> +
> +	/* Aging the anon LRU is valuable if swap is present: */
> +	if (total_swap_pages > 0)
> +		return true;
> +
> +	/* Also valuable if anon pages can be demoted: */
> +	if (next_demotion_node(pgdat->node_id) >=3D 0)

!=3D NUMA_NO_NODE might be better, even though we know NUMA_NO_NODE
is currently set to -1.

> +		return true;
> +
> +	/* No way to reclaim anon pages.  Should not age anon LRUs: */
> +	return false;
> +}
> +
>  static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *=
sc)
>  {
>  	unsigned long nr[NR_LRU_LISTS];
> @@ -2815,7 +2835,8 @@ static void shrink_lruvec(struct lruvec *lruvec, =
struct scan_control *sc)
>  	 * Even if we did not try to evict anon pages at all, we want to
>  	 * rebalance the anon lru active/inactive ratio.
>  	 */
> -	if (total_swap_pages && inactive_is_low(lruvec, LRU_INACTIVE_ANON))
> +	if (anon_should_be_aged(lruvec) &&
> +	    inactive_is_low(lruvec, LRU_INACTIVE_ANON))
>  		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
>  				   sc, LRU_ACTIVE_ANON);
>  }
> @@ -3644,10 +3665,11 @@ static void age_active_anon(struct pglist_data =
*pgdat,
>  	struct mem_cgroup *memcg;
>  	struct lruvec *lruvec;
>
> -	if (!total_swap_pages)
> +	lruvec =3D mem_cgroup_lruvec(NULL, pgdat);
> +
> +	if (!anon_should_be_aged(lruvec))
>  		return;
>
> -	lruvec =3D mem_cgroup_lruvec(NULL, pgdat);
>  	if (!inactive_is_low(lruvec, LRU_INACTIVE_ANON))
>  		return;
>
> -- =

> 2.30.2


=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_2F5A0EF5-4EEE-4795-96FF-BA8CCBFFD215_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmDMv64PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKxUsQAJCEupEI6JWOfGuC1Jymjm8WZ6nJcxLRi3zU
pTKdJcus6ldcKg0dot3yyBKh2yLi3n/TNlFNxAPwU8dJ8Fg0sQdBZ4SQbJWNzSCo
GwIO63kGeeIZhTeGyxke8LIUIgh2g9bnLQzdyZbczUVMSHp4rEHtLz0OomvG8ncm
bExGSaoEzkvR1AqANIoe7g+sHw1IcL34bk0P+Qgzd8GKpnkEqz/HE8cnFojn0AKW
SmiRHwxTowkbUFfPsxjjt7a07kZaCitaN/ZmvxtDE3fx/RlkDTM/ekECf0f8B3Hu
6Lr6qMMCYk5bEb/ZJd1sQ4Q4Vm28Oq/yGsltWMSJrh1kXsiv0zfj3kwjVbUMhurW
MuHKUMYtQktg4GQRJFHCS84jjt+u/aQzvqlXlHzXQqDdtMwLUCDUOiSMNnWgLsPr
ZO0P01Sptb+P7YJyf/qGhBdLFhTtUPtL+Ewdlrz7RA5CqAq0a4YQlqLrnxX662Nv
bKBuiDL/b6rCjmUjtSgkYY8mP1uOekm9r3s34kpywyT0Ko1oIIsunZNB79yWNnq1
9Oa7ShU8DxWMQ3sG3UesSzPP83MRuyggKiFo9mLBRMgOmv2MDAmk5cmtv3MgvxeC
BoYpMoZyBixsfduHKCuEZ2wzMub9YkQGMqKYPfEjspc7ez1889OZ4eKPu+g4GJa/
yNrFPS7r
=qFWm
-----END PGP SIGNATURE-----

--=_MailMate_2F5A0EF5-4EEE-4795-96FF-BA8CCBFFD215_=--
