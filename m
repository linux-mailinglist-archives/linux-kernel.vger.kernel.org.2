Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEAB32A0C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576525AbhCBEap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:30:45 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14826 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442080AbhCBCA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:00:56 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d9c270001>; Mon, 01 Mar 2021 18:00:07 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 02:00:05 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 01:59:58 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 2 Mar 2021 01:59:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WE15skY9bAQTWcPbyovrHZmOTrWnxMRZQd5tVcTqP++FEsJ9wksszoN9xzofXv2Pom7VGeZTQKnkoFCIfqIz35e0Y1K6zv4+K7+JgsG6zhKSrUq+4Tc6KaoM1IFYJxROMHr4MierYKdWxVJV+1zLrd/sQ6Jt4C10b3QchmUaYz2BFyRuTClTi8NA/qjpUVY0q2bFHi+Ro84d7s0YK1D+gHNRxS/ZM43CK72gYAOho70/YNl32MvggZfQFj8WiJ63Lnv7XDvVYAWmvg6tScDaGgCdN652dTddI2CFjL7cqkPXqWtywXkJfRp6Jes9Lk0PfdNUIHeQb8xZtPkc/1HUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Qd3aGkCHdsKeULerVJM1/FG0+ord/WAJnUWB1SM8vU=;
 b=d02kjDjpmFTTDg+fiFtdL8wilXClnDnS4Bd/k4LvKKaUItfMHv2FK/QQT63IBi3dHX4jbKhQKDEM3LSBVj2CGJoju8Pf99V5bZctpQHvyxQofsPy6fDHp4wm3GeoEhUWzO3+jQhaaUSOLNmCdxl/CQdPcVek0vYm7JhE1BQGGVkRzEt4Z4p83UDW4ZGvN8euA1M/ZnkdeSBfEtWfrBfa4VHNMqeVilSJGMWvA8P+SYSeSlYhj3jpFed5u4EI4JCEhTCsfNKXG1547REBOvH5bE7pOXIcwAvs9n5VUN0CHC954ua7X+Xg8aSsEBxQoNO+4R8eSm/MMWixTgVoivlEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB4611.namprd12.prod.outlook.com (2603:10b6:208:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 2 Mar
 2021 01:59:54 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 01:59:54 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <npiggin@suse.de>,
        <wangkefeng.wang@huawei.com>, <guohanjun@huawei.com>,
        <dingtianhong@huawei.com>, <chenweilong@huawei.com>,
        <rui.xiang@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm/memcg: set memcg when split pages
Date:   Mon, 1 Mar 2021 20:59:47 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <733264DE-1845-4615-8573-481E63895397@nvidia.com>
In-Reply-To: <20210302013451.118701-1-zhouguanghui1@huawei.com>
References: <20210302013451.118701-1-zhouguanghui1@huawei.com>
Content-Type: multipart/signed;
        boundary="=_MailMate_93A1199D-4B4E-4956-B412-74E004F8D08D_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BLAPR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:208:329::10) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.62.13] (216.228.112.22) by BLAPR03CA0065.namprd03.prod.outlook.com (2603:10b6:208:329::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 01:59:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f137b788-7f9a-41a4-63f5-08d8dd1edf43
X-MS-TrafficTypeDiagnostic: BL0PR12MB4611:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB46113B048B8DFA260B6CB906C2999@BL0PR12MB4611.namprd12.prod.outlook.com>
X-Header: ProcessedBy-CMR-outbound
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NEzeO6baTIBvqv3YxTfWdFinwjrp4nEASx1GwlDRXLy7yt2yUB12tU0JGGl6jkTtcNgBJ2nqoIAD2FFhUZWdU+UkDh3EoMKy0HzIkvFxb6YhEk/A7tThyC1tyu7/5l6bi/ynXwnA4oZSAIkiXswLqSMlz+I5WoiTBP8CB96QLF78Tc81fASXJa2Qj4W826ZDGkeL/uToxAj8tcL00ls5mdgRbgvw978FesLIKhBwR6foO7LW0YV1vqfQBvlwbJ1JxxAKT60IlwugQzSDM+dPARTcLBwKDb9puHblSIhrVEU758yiB40Uq7D9vudTC4scDtritxwRztN9BJvWhpKq9pu5yV7ILTCxTkL6z9uo5btYj6LNz3EKWTcxllge4O3+4++F0t75D3g2zIksXq/ECSFp3+f6HDwLvKC2DEswLUPS3ZzoLl9vf8LqAWqjSBL6Qli6XPRR92iwX4DNU2rlGU6EBP8IpNATwulNXtZo/CqQIbVUWliFMh9I1SZkSliHvuTh1sac2F3oKvnU5hiIfdozli8Y3NQ4IdcoLE61vM09YG505BGJZGPPtWIIAZv8ceibiIIpBfQvNSwONIRu0jPj1vPRpD2CDY0u/YNXpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(16576012)(2906002)(4326008)(2616005)(16526019)(316002)(83380400001)(33964004)(86362001)(36756003)(956004)(7416002)(478600001)(53546011)(66556008)(8936002)(33656002)(66946007)(54906003)(5660300002)(6486002)(26005)(66476007)(186003)(6916009)(235185007)(8676002)(6666004)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UE5HbzE3TE43bEExcFlwd0tHTmphS2VpVS9Dait0OTdwU0REekFkeGprQXFE?=
 =?utf-8?B?UWJBb1UySytCczJUbVlSUm9XeG5OQUEvM0Y1SDkrcENHOHE0VzR3K0dUYkRn?=
 =?utf-8?B?QXZVL1hLdUVUODduaWUvZlZ1UmM2bEtJaTkzQnlpbWVQRlN4QUs0TVM3c2Jq?=
 =?utf-8?B?VzA3NDNnTCsrbWNPdFc0ZEp2d3lYTTJ6Vk16ajA5VlpoYkpQS2hndVFOMTBG?=
 =?utf-8?B?S0FRSjA2dWZ6TXozUzcycUdmWUJKL1RHU0ZsMXhPUndSZjBVbEZ6SlJkVGJx?=
 =?utf-8?B?azFob2thdkt6YVlsVG8xa0Y5VXJ5SUlIT1BxYzVsMWk4TFczVWpBczFqc0Qr?=
 =?utf-8?B?MlU2YWZtSjNkc0pjT1dvOU54cTVPOFg4RlI5R1h0WGptVXVhVUh0UStPVjNS?=
 =?utf-8?B?cGhhRi85Tk9Yc1VyNStyRnNFcFdIRlNhUEozeElqa05zeU8yRzBDRC83UjJX?=
 =?utf-8?B?UzE3aDdYc0N6Sk41WjMwMHlDR2xwQ1ovY1hNQjZTemw5bGt5amF0VEVVcXQ5?=
 =?utf-8?B?a0daUWtTZXBKZjRSdTZac20wL3pPd1lQWXdHZWJEeDgzNkdXMGtmQjJPYlNL?=
 =?utf-8?B?UDJRTndnWGh1aFA0ZGF2Q0kvY1ZUYUx4RksxMEwvMXVuaEVFOE9LZ2t5STJN?=
 =?utf-8?B?ckQwSFFLcnJidFFxTy9EUVMzSEIvKzhRQ1BNNHhld2JsZTRaYjJRUm91VGhz?=
 =?utf-8?B?a2tMZDB3dGJjUXpNYlFXQ0kwelNvTG1WQkNlU3h4TTFpejJZTytqbjNxVnBH?=
 =?utf-8?B?QUs4VmNqWVlxcE9uak1RTkhDd1dxVVZxaWhUdVdGVThLN3FDUVNPeUxicDla?=
 =?utf-8?B?Z2tNaHFHbUQxSk02eDBqeHBubjRRMVc0WlZSQnJQQ3BNS1VuNGRWa21sYUpT?=
 =?utf-8?B?VGl3TWVXSGIyWDdyMHh3Z1RwQXNDVnIrQ0RqOE1ITkFhYzRFcjZuT0xOK2Vn?=
 =?utf-8?B?ak1WWEtWSDhDU0FkNVdQN2xBK0FRbmV3UytWeGd5YmUvdkpyc1BtOGZhNWdV?=
 =?utf-8?B?UFkzelpBRkxnS0d3elNlcWtTSkRvbnBSUjJzcDdmd0d5MUI2NXNTalJsK3h3?=
 =?utf-8?B?ZW10WWpRMlV6VmhrSHVwT2llT3BvcmlmTTF6cUE3dlF2SVEzOHo1eVZJbkg4?=
 =?utf-8?B?dzd5S3RMa09FYmJodzlqS3N1d0l6ZjlvRVhaN2k4azg5NDlubjZQa2Q4cVZU?=
 =?utf-8?B?ZWFzaEJoT2NWNEMzSFpCTU94d0x0NjdjdUtHR0Fadk1XYU04TnhLMHYveVVY?=
 =?utf-8?B?dHFYdGpBUGVCcHhBZ3VEVjJ1czVTUDJGb1YxZXF6dE1UOS93eUJqeHV0eDJq?=
 =?utf-8?B?QmRMRExYa1pweEI0U21pTFBlMXN5YVpwRHVWelFqQkdMTE14L3VTMkVSTnpX?=
 =?utf-8?B?OVpvV1VtYTlMNnlzUGF2Z2VKaUhTVXVzellPMzdabHNCZDBKb0ExZVVEM1Nh?=
 =?utf-8?B?NXV1NlAwSXpkcDN4WnFCbGxRZlh4UmVxclhTNmlyc0VaNkthcnErQmhqeUNq?=
 =?utf-8?B?NUx0ZVEwTWo1OHFkTlVsUEFkVExoYThsaVBmTm1qUE5vSWphNGxjNFpMOFZM?=
 =?utf-8?B?eXBwWStvck9kRG9xUHNFSWg4TGoxVjBTWEUraHp2c0lsenQxNGNFbVNEQjh6?=
 =?utf-8?B?b3RlaU1QK3V3SnBBRUtTYVA0cVlMd0p2Qk5WL3FKL1lIQlZGdkE1K0QxM09K?=
 =?utf-8?B?THY0K2pTSkdIdDNnVXR2RW83TjE3TFlFSlBnYUlCd3FrdEVFN0hiZnJzK3NJ?=
 =?utf-8?Q?DWevf+8j12t1HmUoMX7nnTvYleYF6MWX015Fiic?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f137b788-7f9a-41a4-63f5-08d8dd1edf43
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 01:59:54.5443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dww/zUZhqA1HkHJW5gFbhoLv4PwhElS66KR0VJ3/wWAPFiFm/Fp5E8Oq0Eh43Rb0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4611
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614650407; bh=Xp4EAEA5Ow4ELYQ8WW02x++/E2I3VnhiyewSQD2PpGg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:Content-Type:X-Originating-IP:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:X-Header:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=GZfO5fCYR6XgPUDlfR9pAxxvAo91b8HoQL41lcDgrVaBxY1qFnkcbjEI7afubV79E
         7D1nT1/545+yDZnfVl2Nc2lV72+OeeWITUEealb2r8L1pnao0doKhexxVrlpV4Wa/W
         xHR2s46G66CadO2TWfdNB5s2P3VxYKCVq4Bt2VEe9v4Fg/uRbCBuKQ/kWeSxGBi40Q
         cOpNBLLgFRGSaXYtW9qxAeHakN6X39R/q7Fq10CtZT35mffLcIqLx7XV5LCHNx4GdW
         PAwrgRheZfAl5ETSd4okZxeH0Vdv9z6mj+q/XPPxubmaDXAjr8lu9KBKf8QN5o1wEf
         KDM7MfItV/fhQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_93A1199D-4B4E-4956-B412-74E004F8D08D_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 1 Mar 2021, at 20:34, Zhou Guanghui wrote:

> When split page, the memory cgroup info recorded in first page is
> not copied to tail pages. In this case, when the tail pages are
> freed, the uncharge operation is not performed. As a result, the
> usage of this memcg keeps increasing, and the OOM may occur.
>
> So, the copying of first page's memory cgroup info to tail pages
> is needed when split page.
>
> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
> ---
>  include/linux/memcontrol.h | 10 ++++++++++
>  mm/page_alloc.c            |  4 +++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e6dc793d587d..c7e2b4421dc1 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -867,6 +867,12 @@ void mem_cgroup_print_oom_group(struct mem_cgroup =
*memcg);
>  extern bool cgroup_memory_noswap;
>  #endif
>
> +static inline void copy_page_memcg(struct page *dst, struct page *src)=

> +{
> +	if (src->memcg_data)
> +		dst->memcg_data =3D src->memcg_data;
> +}
> +
>  struct mem_cgroup *lock_page_memcg(struct page *page);
>  void __unlock_page_memcg(struct mem_cgroup *memcg);
>  void unlock_page_memcg(struct page *page);
> @@ -1291,6 +1297,10 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *=
memcg)
>  {
>  }
>
> +static inline void copy_page_memcg(struct page *dst, struct page *src)=

> +{
> +}
> +
>  static inline struct mem_cgroup *lock_page_memcg(struct page *page)
>  {
>  	return NULL;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3e4b29ee2b1e..ee0a63dc1c9b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3307,8 +3307,10 @@ void split_page(struct page *page, unsigned int =
order)
>  	VM_BUG_ON_PAGE(PageCompound(page), page);
>  	VM_BUG_ON_PAGE(!page_count(page), page);
>
> -	for (i =3D 1; i < (1 << order); i++)
> +	for (i =3D 1; i < (1 << order); i++) {
>  		set_page_refcounted(page + i);
> +		copy_page_memcg(page + i, page);
> +	}
>  	split_page_owner(page, 1 << order);
>  }
>  EXPORT_SYMBOL_GPL(split_page);
> -- =

> 2.25.0

+memcg maintainers

split_page() is used for non-compound higher-order pages. I am not sure
if there is any such pages monitored by memcg. Please let me know
if I miss anything.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_93A1199D-4B4E-4956-B412-74E004F8D08D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmA9nBQPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKEgQP/3NiPPTc424m9s47KY0k0ggSLTfYns83rLJp
UVUamKhFdE66jHq8yo1sVMMHGf78d7HDaBLSChcYxbVd43kWrWNPJkNErHbGDgK7
UuTNnWFzSIZ+8wKHZHmuSd13Q8o/ScVkJ3S9Xf1rY6HFDjj37o68nygOM3dbG4Il
oC4as66GknA18ZtIJWWNSJbN4NvyUqm8OeXOibmtOXl+OdxCwGlClZvwXhF+lOLw
xdjuELh0DGJTD0JJMVxaWxUec2BP8WOPeWv4E/0I5DyUbXvs8vOADOKH5zuYbvgm
kInQzqQU+XMi1faUjNpr3Kf/G5k4bvamuTya0ZOjYEd3tZe9LQBvTh7teyMIuouW
8dSCnpiavSNoskUGANxSn6A5IyJQeUYRyAz4TWP8G7lUGSgbDOaHCcl1+P6BOKLP
k8mhiwtEOTNTX22mVZgSKLBGeBM2R3fjRdYSCFafS1FY0dd3T95ZQJ9kaSiGhphm
BuM/r+5b8b/+HOy5tAmPsbh/ziheSBZU2HQlve2reOMnsmoYMUkU8DAaIsarr+pJ
4gf5Z7FlCvxPrgSTlv7KFz+JZiqNFQMdz3UaPy3P3aDCnbLQeinAYTU8QDms2iBG
6gQPnV7LHJtHUWmDxXZZWMVwxi9GZpVYIOsCH4SazPRhAqsGDesFyHrx1iJSeH11
vQyKn/fL
=55gy
-----END PGP SIGNATURE-----

--=_MailMate_93A1199D-4B4E-4956-B412-74E004F8D08D_=--
