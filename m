Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2633933F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbhE0Qap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:30:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27732 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233656AbhE0Qao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:30:44 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14RGGto5002478;
        Thu, 27 May 2021 16:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=YZu6xZGxprQYGjo2X/zvePNr9XbwJpm9ag/qGMRZJ1A=;
 b=Fkg/koIof7bZ+UiKegqUiM7/9wD8RYabHWrl10d7bd0xcqUkfRPj9QRkxCy6hvyF6bJQ
 hokdpmqj08ru3Tcq1D/O9JR3GhV61CyL4RsRYQvQNXUBB+/OH2fwKH9CB2iwpf3WKv0i
 HW1Yv1S2hhSXzHByjPe5hC0RyYUFwwge4vhUCCTSLD2DxqsRBqXGTRVlgMk9k8qf+7wz
 igattNmOdLcFSo4Gdl126VtNoyhkZxKcvtemBXRGCMDTQLonLnQEvRNIfa7mm1MiF28k
 l8aNkFPDWlS/zWJJI/NZ49rLt5ZYfKkXBj5pVXCZoQ+KDJ/dwh2iSrBJfdPnR7BxzUcl Vw== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38sr118fss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 16:28:57 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14RGSukV162080;
        Thu, 27 May 2021 16:28:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 38qbqug758-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 16:28:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=API+1KoU+jHXMUX/cn/bdKbsAaail0dTFCbB+GBBMbU8pMPwitX2Lvoxm2xatFeMda3FDvfhHMsmwjGUKG16Zr9sJ4/mqYSRPCGnSmqDMs9KezvZYyrupyI2AKfq4w6+0ufIx9LAdNnNeF12Le/c9eeWBi+obS+uNI7WfHTVdhSzKC+nXFDvRk/noF8ukD6WGdpV+1ThiHW4x1ct3v9/qPWeeGLu7t41gqQIjrincdcUdIDFnSaGjpI0pfhCwP1W3fR5gSQ/Ta18kTTwJ20914Dfs0lSLU5NaRtWoqiVZAC/9+Sr6q3zrcdiiItHfffrM/eprrr5gPCxt7XnMUBfRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZu6xZGxprQYGjo2X/zvePNr9XbwJpm9ag/qGMRZJ1A=;
 b=VGGfGDDhmCnBEp5cW/e/XDhJBnW1F6/zl79Pwp+gFkoXNJN0vJuPcfjqn5MRamnVB63Q7zxqEPnAv660iFV9RD7wuVIJ4wikrk42DwhGR0wLVOudjjtozdhj1IbIlobliJ5nG3PMte/fWtOVEIoMrjFPgnoB4Jz38mV7DR5z4KKo/7e4z5Gla2sai5zOLsOZv6uRy9QuL1iDmHTBdmLZYRjeR32cvlKu+YsHa4CAqLlL86a9JG9olmtKKgHLVHyc1NMtNqedVlaCflE87VHYmHAgLjrFKif+/FGx+t4izQ1BbpHDqfjG4ok6nk43+8CQVxIWbMWujjeAqCcUgs1UXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZu6xZGxprQYGjo2X/zvePNr9XbwJpm9ag/qGMRZJ1A=;
 b=TOKPL9WRi1iy1HZbaw4oE/+W1YG26fLnzWQeyjZLMBaKDIUMxZCNspk+DFkRYGt97aEDvlazPBc8OLd3bXiVVfhjxRv6LV947x4h2QW+teo+23CAgnq6V6SNraZ84DzWVMiiJnlaca9Wt9t67+rNR38ucMKPLZg+o3eANVqwOQc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3000.namprd10.prod.outlook.com (2603:10b6:a03:92::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 16:28:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4173.021; Thu, 27 May 2021
 16:28:53 +0000
Subject: Re: [PATCH v1] hugetlb: pass head page to remove_hugetlb_page()
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20210526235257.2769473-1-nao.horiguchi@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2097f731-0b72-a5bc-1011-09447089a81b@oracle.com>
Date:   Thu, 27 May 2021 09:28:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210526235257.2769473-1-nao.horiguchi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR17CA0068.namprd17.prod.outlook.com
 (2603:10b6:300:93::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR17CA0068.namprd17.prod.outlook.com (2603:10b6:300:93::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 16:28:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fe77e04-327c-4bb3-c536-08d9212c84a6
X-MS-TrafficTypeDiagnostic: BYAPR10MB3000:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3000D540F26FFEB380C9D67EE2239@BYAPR10MB3000.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hkRSUwsXw164v6Fvp6mwl1TQJXy6QazTIvlDEQ31o0fhHyWYpoe53MqBqZmvl668891jYtuMMvX30eK48+eR7W01zIPfv8vMWt4D65aroKXK4iX97fri3WCWl2dlXKwJguE1BII4ssq54asZttdVd5SgEZbsyU0Mjps1p2Jtux95mi5A+jcy9i26tmD8Uz/OpNd+49KTzQVyOlK+Ky6oyOCx/dDE5yL6xcsSJu1Ok2DOHVi3TEj3GBUujw++kxZb50YTnfCdDGZpWFot4jagmWrxDwDkvyNSVH4Gtg+0Ra+/9sg4a46igNzr/CEMkykXTpngyGtoGPyWJ8azd6hXJ1d5lE/atC5DdkrbZ2ZgNMUvzuwMYoBn1UaItgDQoBxHXkncB0fF+B100YaPe709ob4PVbuOjxm5g8jz7Qxx7VyLwbQ8EFdsbcI8TIlzqVPDqaKXWhRjjcOCmxD2eE5yX2yyun6mDMx4EtvDohakSQAnt0IzWkLTvIDqIBtEIbEy88UlHbvwuuooipa6SJaydz5ZQG/rRz52PSxzgdfb6pH1urOx1ihgex1mfgvymhX7t7xEAlfAJBWsjHjsO7GXi2sznlY18TUiV83+yY5cG4pq7bd9m1nAHuujD1w45I6Rb4zbk/E0sHwr2yFpX1rUzlTRuR4fHdwUEjK0Z6mejwQtj+bnnPGMQNd67fKCutYKZD6vt+FQdDDQzM7nQyCgwMIefg4l9oFW+vH+4p1blJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(39860400002)(366004)(52116002)(186003)(53546011)(2616005)(83380400001)(16526019)(956004)(478600001)(5660300002)(38100700002)(38350700002)(26005)(2906002)(8936002)(8676002)(16576012)(86362001)(4326008)(31696002)(31686004)(6486002)(36756003)(66556008)(66476007)(66946007)(44832011)(316002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RUtQZi9RUDFoZFVaNXJpQitScHpKd0RhZU00Z0hoY2hQMmxLR25VbFNITUMr?=
 =?utf-8?B?Qm9yalc0c1JBWUEydVdYZDNvQmJwMXJheElTWjBocXFhYjBPQjRnbzBsZlIx?=
 =?utf-8?B?TE56S3pvRDNPRHJOR2Zwem9qSTZoY1BZbWE2K1ZnMmFMYS9hVmFDeXIwZllu?=
 =?utf-8?B?WWxaL0JVWjJrYW1iaUIvS3pOOEIyY1lxSE5NdDQ3RFVXb042dlNwWDB4dkgz?=
 =?utf-8?B?cnNLMTVjaFMzWEVoUlE2QW1RVU1ZZ2dyd0tuUkFzWEJLWDNQZFZYWDFXaTkv?=
 =?utf-8?B?K3N6M0dsTVA3eTJ3ZGNEby84OWlsc01FR2NWRjJ5dVVJdEJ6SUNvNXVPcVVp?=
 =?utf-8?B?dU1pRms2OGU4eTNRdzRpYVkzS0Y3RVZZVzNPSVJIUjJoR2ZnakhXekN6ZkNs?=
 =?utf-8?B?QzBFM3dhcjlVWGY5RlR2a3dCdFAzZzcrYTRodUQ1RmkwT1NiclNWL3pWcVNz?=
 =?utf-8?B?MEQxVmlTNWtJVEZHd0hJcjBVVTlpbDhpV09HSHp2a0JRclRXTWU5NzkzcDRz?=
 =?utf-8?B?MjEwdEpZdnZRTWdiVzRzeThyUVNReENpVHRpL3VJOFF1RmdHZHpKazJSbXV2?=
 =?utf-8?B?VzRPc2wwZkNGa3BkQStoNjZLYTFyQmRVakdxRzI3eXJUNkhjOUFKaEFaendv?=
 =?utf-8?B?dm5ta01kNnNVSmVmeE1BbE55a3MxVzRUOUU1MksxTkFzVmNNcDI2aEV5U2hT?=
 =?utf-8?B?TGVlNUdQNXltcEJHUUl1R1IyMmUwWjJxZ3VQc0xicmFzUEFVWUNnSHVsemFH?=
 =?utf-8?B?R24rdnkxVzNlb3hZaFVpdzNZR2pRYVJEVTZOQXNON1JIdlRKRnNIVzdMbEpy?=
 =?utf-8?B?eEpXVXdmYmpVeHZkQ1prSFFFWFArTFpFeUoxZlR5NWQwcUJQckpDcDV3bmVN?=
 =?utf-8?B?cXYvWFp3bGFtMnAyK05WS2VibmdsK0FlSTdDTDJXZy95S3ZhK2R6NVNjb1d3?=
 =?utf-8?B?cUppT0Yvcmx4cEdlek51QkxoRGd2OTdlOUJmeXZQc25FKzNZbnF2MUlnUUto?=
 =?utf-8?B?L3JCaSt1ekZRbThzYzg0RTI5WVh0TUZMUnp6b0Jta2d0WXg0Nm1PWWxjSVF5?=
 =?utf-8?B?OGdTbS9KMS9zTlR2NU9aSFZiREU1djBsYWtuTS82RHVFU3FsVmE5ZDZ0Q2tS?=
 =?utf-8?B?ejVSM3ZyOEJDc1RUSWMrd0VMMnBBdndmVDB2MVJ3cm1Qd1BwU3VDSHl2ZkN5?=
 =?utf-8?B?cGZYWWdPOFZ5U0szMDlyTTR5TXJBUTJjc3R3V1ZMaWtWUWFtK3VsdkN6VWxU?=
 =?utf-8?B?ckN2bUFiQ2RDRTRkZmZHRkJ4WEk4bS83a09EMHpEWGJQTHFoc1hJTFZiVmtI?=
 =?utf-8?B?WndGdEd3MXdvTnVpY0lZblpFZ2xSNXRCb1BvTHkySUFYVHFrcXFIcFBMdVZR?=
 =?utf-8?B?elF0RnpuQm5aQ2NPSW1oWURVNWxnYk5ncW0rRUtYb0dvOUNyWU9nZTBvRWhs?=
 =?utf-8?B?QVBjc1pYWHNFK3JFdE45bDl4UjZqdmEvUDJ6Q1l3UVZ4cWxCV0NERnhTNkdk?=
 =?utf-8?B?Z0tkK20rb3c3M1ljKzlHNzhiTGhEdDZ0dDNkUFZRNzNmVGJ5emVlRThmRERX?=
 =?utf-8?B?T2daVG1kS3JQWlVGekQvWDBmN1NCNi95czl5SzY5aXFBVFdxOUtaNEtOMEda?=
 =?utf-8?B?dDBENHVEWjhYZFFoWUpXMU4wMTRmbG5iTVpvYjNBZDBCOStyazFKbGE0dlBL?=
 =?utf-8?B?aFlxM0ltQ1JJVmxBeU4xSUFYcm45V0JML2JOc0tFUC84NGlHQUdaeE9QTE9v?=
 =?utf-8?Q?tGOW8j84mWyf/3vP87kFc5y0au878qGdDZXfTx8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe77e04-327c-4bb3-c536-08d9212c84a6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 16:28:53.8918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRyK4Fjz/xTpZjHogH+LUtb5w0uK5tRegukLHO9012QM+x5diw/+BFwnqFXDmslyYgbgxkjuqc9vVZoQ/J/Hqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9997 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270105
X-Proofpoint-GUID: Emuz53lVSfc0Vl5AyOC0E9CkPkkPmPW6
X-Proofpoint-ORIG-GUID: Emuz53lVSfc0Vl5AyOC0E9CkPkkPmPW6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 4:52 PM, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When memory_failure() or soft_offline_page() is called on a tail page of
> some hugetlb page, "BUG: unable to handle page fault" error can be
> triggered.
> 
> remove_hugetlb_page() dereferences page->lru, so it's assumed that the
> page points to a head page, but one of the caller,
> dissolve_free_huge_page(), provides remove_hugetlb_page() with 'page'
> which could be a tail page.  So pass 'head' to it, instead.
> 
> Fixes: 6eb4e88a6d27 ("hugetlb: create remove_hugetlb_page() to separate functionality")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git v5.13-rc3/mm/hugetlb.c v5.13-rc3_patched/mm/hugetlb.c
> index 95918f410c0f..470f7b5b437e 100644
> --- v5.13-rc3/mm/hugetlb.c
> +++ v5.13-rc3_patched/mm/hugetlb.c
> @@ -1793,7 +1793,7 @@ int dissolve_free_huge_page(struct page *page)
>  			SetPageHWPoison(page);
>  			ClearPageHWPoison(head);
>  		}
> -		remove_hugetlb_page(h, page, false);
> +		remove_hugetlb_page(h, head, false);
>  		h->max_huge_pages--;
>  		spin_unlock_irq(&hugetlb_lock);
>  		update_and_free_page(h, head);
> 

I believe we have the same problem later in the routine when calling
add_hugetlb_page()?

If so, should we combine the changes?  Or, do we need two patches as
the bugs were introduced with different commits?
-- 
Mike Kravetz
