Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E407F361292
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbhDOSz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:55:29 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39076 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbhDOSz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:55:28 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FIrq2k126677;
        Thu, 15 Apr 2021 18:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=WdHmdctosQiWgshCTOKIsO8rfML+1PqqBcTkZN9ABwc=;
 b=BSsp4N04v1YJyGajQUgxG64iYSZlzi5I5hQC/+AvECRIn2/Ywmqu0FIE6Ru61VuZubL+
 sTpvKhHJrJ2/GXXeJhcfvzVXBLtm056PUahZH8BmHPwR6cCsaaSvSM5LOL+Q02yyGwXD
 hwK2jqw9UfO7AMtmLPIbR5gp4wINEoAmqqgaKtUUDyVRYTnDebUAmuaC/XlXxlaoQTMO
 Wz6C4Ozotxm/T9+ZtJZU14GQudu2aenlgjVeinmPrq/lM4QJCPUiWWs7pqFJAGtg0P2p
 rVbOvh+UDV3XeeCY+qeNFvsvOwyfzpnfT+CKQ+IsX4T09GNfrl68WBFooK0Fw+Vts4ey fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37u1hbq23g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 18:54:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FIacSw115056;
        Thu, 15 Apr 2021 18:54:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3030.oracle.com with ESMTP id 37unkt240u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 18:54:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIjKbrek4/uoH54IiTQAXtZT16J9cZI+emu+ZZv1eCzdUEjlbJKewiTOM4uUQPhVsaGIE+OrmH05eX+atHsQ/bs/hvidpqMelOD/4z6hYvYbigWAlTM2NZjpNU01hpvgbg1PpGC+tL+PuNhy9kitUxIIt4ewGrN4Zts4M3pg5i26BDoKuYX6YVxq1J8FjRqagJFeiRqX4iBtYzOlI7+crEdpaoSM+4ETxETvh7oYgpZAybiX3BjsyW1ZmXe+8bZ8DdP4l+t60G3gljMokiS2KkSS/erAK7a9gUo3Q6/Pp4Fipk+b3WP9ZV7GyFwvnpNEKwoD8wFWbnaIVZVieMwuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdHmdctosQiWgshCTOKIsO8rfML+1PqqBcTkZN9ABwc=;
 b=YNXQr7Vx15aP9DAG0HUfLegDp7XeJcuKtGXge6nGVnExya08EutMu7K1VJMxjPFvOgg1gvDu0TEog57RmdT1yjqgndM16758qepChehCo/zvd6PNagk27+garOq0vQvDMYDxgJHjm0fZE3nL9YjQqqcKjvG/nqy90caYsIRm8IxGVCZP0lRWAdar+vvnRCcgg0q4+z5wSLeB8qdP68+7NIaIp5W9kvgRckGamtp09PoJTXOJNXaLyWn+Q71K+HMvKnDLqZ9NbR+N+AQeDeDZuKoOUddajybd1d5D4wN30RoJKo6IHxfCe4Y3VcDWrQmwi2qVsY3/TYuMK+tYgYeAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdHmdctosQiWgshCTOKIsO8rfML+1PqqBcTkZN9ABwc=;
 b=IVUrkGw5CAivXEBfyojxGZNeQnTBTMYxwoHnPGBiqUF/zCuketHCgBcJ7UhT2CorsJ550K38sw3Uisz1Eq3oHBCbRzt4tiVNA5BSRsJZBOErsaE1zlpbozVwKdXKWN7zuoJ/DyNv1TWz7jbms/cb/tmnwJ1DjTG4XXprXRKb8tc=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 18:54:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.016; Thu, 15 Apr 2021
 18:54:50 +0000
Subject: Re: [PATCH v8 5/7] mm: Make alloc_contig_range handle free hugetlb
 pages
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
References: <20210415103544.6791-1-osalvador@suse.de>
 <20210415103544.6791-6-osalvador@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4437d5ff-42d1-ac00-a479-1c8aa908878b@oracle.com>
Date:   Thu, 15 Apr 2021 11:54:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210415103544.6791-6-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW2PR2101CA0002.namprd21.prod.outlook.com
 (2603:10b6:302:1::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW2PR2101CA0002.namprd21.prod.outlook.com (2603:10b6:302:1::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.1 via Frontend Transport; Thu, 15 Apr 2021 18:54:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce77f747-c7d0-4621-f7cf-08d9003ff2bc
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4654:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB465472BD860D3586AF3FD24EE24D9@SJ0PR10MB4654.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDjPF5s1ClqDFEGlfzxNLgejrP1prNA4J+3nnpsttEGQHubtYw1xz9vsd+oofBTVAYB6HupBLzCEAhz/5M2CEhSYFhBWaf2HMgIZaVcSeIkLN0XPVwn1mGmCA+Iq8DW82vV6VDoqtSdGUy1jb6I/evgrcht7kz9q4eI1XzMz6Njkx1OP+pu5xpX9s8dQWZ6btFsiKP3oMh3SThyz0wBs1kzbhfM7JLiXNxVBLeOqNjRHSCPvXk/HfLaoQ6VG+R11CrT7yzups/IeyZL9qG3DGYRHtn08kPLaXvcCyt7gpSYCrZYxUjslJL9jkS+vYtAlSVoZAbbMkTV42BPhkmduEPrNhWovUGBtFP5YzJhfRR4ANSRtoq710l/z2DS7mPYB2IGcKvMrfhrOnyjqe2mgJECBFiO8tp9r4RY1ith7cMirPaqLeNzufI86Z5EMgkTTNYhL0ZAmKhTI+9joGyfx63fBA3yL93Umcx7Ac0eu1uYImBbgMBZ8M8eFtJ/Wqnz8HgRxVUKR1FrBSuZS38ChfC8YaQedMTm2y9Qw48mCcVjztHcmcw0+NJrad0KbjJ5h+9oNTZgYe/19EsCPl5w9mfNBjoJVfWq30o6n9EJ6sSpv1Y/Ghztn7s8Se67J5puGUXlSxwHzhjHv4krtcc7jgu3H4cs33RxweVTeXBDGilWHHHDMYsCtnvhwRgvXCCWZDPrjCjL26NRjzTGHzhqneQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(396003)(136003)(346002)(5660300002)(31686004)(956004)(508600001)(16526019)(186003)(2906002)(38100700002)(31696002)(53546011)(44832011)(2616005)(4326008)(26005)(38350700002)(52116002)(86362001)(36756003)(8936002)(8676002)(316002)(66946007)(16576012)(6486002)(83380400001)(66476007)(110136005)(66556008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NUcraHlmZ29seXRCTlo5dVJBTUlkemF2WFpYZ283aHQ2RS9TQ2h6RExid2Fq?=
 =?utf-8?B?U3k0THRnUUZ1RHVPNjFyS0wxZ0x2Mjh5THl0aEFZTFdGOXhaelpvUzVGdW0v?=
 =?utf-8?B?YU41QXBCQWFCcVJXYWV0dGZxOWJCTFlKTjlOeVphSVJCc2NIY0ZXcVEwUEhq?=
 =?utf-8?B?czBHby9JUE1sSEt2UXhxV0t6alI1SGE5dGpOZWVnbStFaVQxUElMMTljdDZE?=
 =?utf-8?B?ZklaWlRYbFNBWkNqck5Sc0JnRlM2VFpLeUZWZTNpM2R5WktlZE1oQUkvYnE0?=
 =?utf-8?B?NUlIUkI5SHAwSllscWVMeElkUncxaExrdWJGQ1lxZHpZaENybzk2WFI4MnNp?=
 =?utf-8?B?Z2pLbHZEL2V4Y0IzR0NyV29hazFtbWFMeGNoendWd2ZIQkthOUpmY3IvaDR5?=
 =?utf-8?B?Y2wveHZWMi9qUkJYcm8zK1lDaURoS212YzBWa24xc250cU02MWRUdGxpV2k4?=
 =?utf-8?B?aC9XdGpMbjNmRm92bktxMnlTd3RrNGY5QW1hQmlkZzlsOHRXZW5nWVV6MkIx?=
 =?utf-8?B?NEs5SllKSFF4QmtzbGN0SkFzTFFmWitKQWhYcTJSMzhOTURGL0ZHbHJNQTlN?=
 =?utf-8?B?WVRWSUs0NjBmN3ZJVmlxWEpNdmNpeWl1ZjE2NWhMWVdrMnc4YUZZbEk1MVZo?=
 =?utf-8?B?MVBwSk1HSnQ2WDFPSDJqR1Y1dERYRkdnSnNRM0lSUHhoTzZwUUVjc2NWdHhN?=
 =?utf-8?B?MXU1RUJ1b3AxaWZ0TDV1M0E1STltZEN4OCtvWDBTRGplYzdZZ004aGl4RWtP?=
 =?utf-8?B?MWE4RGxEajdmS2lHSk1USWVXV3VFUzRHb3lKdWhBMXQ5WUdTNDlaQ1UxZ2RI?=
 =?utf-8?B?Q1NSam82ZXVlMWVaSHNENTRaTjJXU2NIRW9jNUNydFR0bFhJUEY5NjFuc1pm?=
 =?utf-8?B?ZnBDb0xtcEdyOG1ycDlHV3d1QzFQemZpY21DOXlCWXBtMTBEd0swRWhnaWtD?=
 =?utf-8?B?QmYyc0g3RStxVGxYS1Z4S3JCbi9QLzhsSmd5bWRyU1ZXZjlNcGljTTJQRzVh?=
 =?utf-8?B?QXdVMGlmdDJ3ZEtSQUttOUlJYUpGL2dFVEJXYXVmMzVlV3NINGdyOU1kd0Jw?=
 =?utf-8?B?bmpDUVpaUWJ5NU5Xa1AxMjhTeE9EWnRrSCtiT2Z0dldvYXpqOEdFZllMUWVR?=
 =?utf-8?B?amt6OE5FbnpaQjBDd3d0bGc0RUoyZ09KZjhhR1Q4dDd1Zy8waGNxMTVham9B?=
 =?utf-8?B?a3lPK3FzV0YyTVVVRzVwejV1czI2RmpWNlFQcjFCOGUrbHN5WCtHS1pNNWEw?=
 =?utf-8?B?Mk5kbXFXY2lXWGRNdGhHWTFsc0hwbHMvenVFSm8rRU9GWVB3dFZxREREWi9N?=
 =?utf-8?B?eXl4MFdXK0xnbUgwRjM2MFJ4SnNMTGtwalBxUEgvUnp2U2pwMkd1U1R1TVky?=
 =?utf-8?B?NGJHZGxQa1Flc01mUmM4UHBXM3FNKzRadWZGeHFKY25RMmZ2WiszOXdsR1Zh?=
 =?utf-8?B?dEk4UXdYdmNJeWtvaW8yaGp6d1VEMm5WZ1J5UC9GaDZxWTVVMGhodjBZYTQr?=
 =?utf-8?B?YUNnb21hUzVQeDBUSit5OUVBWm1MOENYay9QZnJmaStNU1JRMVZaMVpVenJy?=
 =?utf-8?B?djd0dGRqcGxkRURnOElSclNaSU5vamFpZGpBSmk1T0ZkVkJWeTNkNEZUYlBS?=
 =?utf-8?B?bkdyR3hsL25XbGtpZ2wwSDYrVEM3ZENJRXpWT1hOc3B1enJTN1l6YzJHMXZO?=
 =?utf-8?B?MGpwQ1FyNm1OaDlia0lxUC9qdTl4VHhlenkxSkVJN1FGUmVjMTRnbFYyWUlV?=
 =?utf-8?Q?tVDUK/vVTXGdbc7OQvRNx6s8vj7ehk+iGfbDU1/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce77f747-c7d0-4621-f7cf-08d9003ff2bc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 18:54:50.6609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3TPk9tCN5yTDFup9OtgvoRfi6jN8nNPyzYHTSqv5O+0Kbwf3dIotibdif6H5eEI1MLROyVeDihMss5sQN5mbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150115
X-Proofpoint-GUID: VlC6IS4cGmOC5lI4zg5kATNsH-ZxiAiO
X-Proofpoint-ORIG-GUID: VlC6IS4cGmOC5lI4zg5kATNsH-ZxiAiO
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104150116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 3:35 AM, Oscar Salvador wrote:
> alloc_contig_range will fail if it ever sees a HugeTLB page within the
> range we are trying to allocate, even when that page is free and can be
> easily reallocated.
> This has proved to be problematic for some users of alloc_contic_range,
> e.g: CMA and virtio-mem, where those would fail the call even when those
> pages lay in ZONE_MOVABLE and are free.
> 
> We can do better by trying to replace such page.
> 
> Free hugepages are tricky to handle so as to no userspace application
> notices disruption, we need to replace the current free hugepage with
> a new one.
> 
> In order to do that, a new function called alloc_and_dissolve_huge_page
> is introduced.
> This function will first try to get a new fresh hugepage, and if it
> succeeds, it will replace the old one in the free hugepage pool.
> 
> The free page replacement is done under hugetlb_lock, so no external
> users of hugetlb will notice the change.
> To allocate the new huge page, we use alloc_buddy_huge_page(), so we
> do not have to deal with any counters, and prep_new_huge_page() is not
> called. This is valulable because in case we need to free the new page,
> we only need to call __free_pages().
> 
> Once we know that the page to be replaced is a genuine 0-refcounted
> huge page, we remove the old page from the freelist by remove_hugetlb_page().
> Then, we can call __prep_new_huge_page() and __prep_account_new_huge_page()
> for the new huge page to properly initialize it and increment the
> hstate->nr_huge_pages counter (previously decremented by
> remove_hugetlb_page()).
> Once done, the page is enqueued by enqueue_huge_page() and it is ready
> to be used.
> 
> There is one tricky case when
> page's refcount is 0 because it is in the process of being released.
> A missing PageHugeFreed bit will tell us that freeing is in flight so
> we retry after dropping the hugetlb_lock. The race window should be
> small and the next retry should make a forward progress.
> 
> E.g:
> 
> CPU0				CPU1
> free_huge_page()		isolate_or_dissolve_huge_page
> 				  PageHuge() == T
> 				  alloc_and_dissolve_huge_page
> 				    alloc_buddy_huge_page()
> 				    spin_lock_irq(hugetlb_lock)
> 				    // PageHuge() && !PageHugeFreed &&
> 				    // !PageCount()
> 				    spin_unlock_irq(hugetlb_lock)
>   spin_lock_irq(hugetlb_lock)
>   1) update_and_free_page
>        PageHuge() == F
>        __free_pages()
>   2) enqueue_huge_page
>        SetPageHugeFreed()
>   spin_unlock_irq(&hugetlb_lock)
> 				  spin_lock_irq(hugetlb_lock)
>                                    1) PageHuge() == F (freed by case#1 from CPU0)
> 				   2) PageHuge() == T
>                                        PageHugeFreed() == T
>                                        - proceed with replacing the page
> 
> In the case above we retry as the window race is quite small and we have high
> chances to succeed next time.
> 
> With regard to the allocation, we restrict it to the node the page belongs
> to with __GFP_THISNODE, meaning we do not fallback on other node's zones.
> 
> Note that gigantic hugetlb pages are fenced off since there is a cyclic
> dependency between them and alloc_contig_range.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
