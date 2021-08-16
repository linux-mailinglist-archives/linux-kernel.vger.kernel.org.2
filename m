Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46A3EE020
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 00:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhHPWvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 18:51:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48524 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234310AbhHPWvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 18:51:14 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GMlZKG030789;
        Mon, 16 Aug 2021 22:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=OXjOjDBb4PYJyOxgsU6x+jt+sMCOoNtKWtWK4nozLmU=;
 b=rNKOhnjNDlDBrwLQXJ468eWZIX2RRQDicrZsU6lQt9vizYAGTNT9p7bqXEH/bEIySUru
 0G5xg9S+tgYJhfuBlyBwK75o9ZFrdNLPofXdVLKJLj/HNB/GBIdCrLhU6ktjH/OOdLII
 e+v+3EhCUVwmOYF8I0WRg2jws1O5Z7b+W1txh8kPMFebMPw/7jDcI2nZEC35nPsSTio6
 cK/GDJOZiabCW50q58B5/M7Q9hoOZ8PVpHl11jDm5D3vtBR002+xG6opBzgfDRYN1dbs
 fdfqU1Ajzk1EfbajvvgJvFX+gdgCKjuTW+rZBe12irIK3CtGZwGmK2dKANHdPcHefwj0 tA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=OXjOjDBb4PYJyOxgsU6x+jt+sMCOoNtKWtWK4nozLmU=;
 b=WTtAyH9iwkgTp7jNpQ4jYL01ySM2trr6T72fkTYjbE7NM8VaToLdu6iIlMcxsQFpv7Z4
 ffjHJ/EZHbMzcMczHHoyrmeje34NYbt5mnJgBjGITTatlhEXTI3vFBkZQpSx+evzBL1S
 2lRAT07zagIDQ5cLA4zMRSzESYhx5B2XIuaUxbMbpyiWbSuNZoqEarRvOSQaEudbzm3x
 uTmORAx8elgkQMDn/ugY0xew2aVbvswFuLl3E0u2ijDer36b4ZSWteNPnBYzr8WUG2+b
 DrB3pVoGb4v5Q1e7Xj4lB6O/Tph5rBNi/ChTLozP+0T6W9cDygXu5X0ehIGLYZmNTfF1 Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3af3kxu6vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GMiu5w040103;
        Mon, 16 Aug 2021 22:50:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3030.oracle.com with ESMTP id 3ae2xy1427-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz048eLHeMhQgUdiIEf5G2TzGa8TOU5elFeiIIQwTjWAOFd9KfpNRxfYzvRtMTmohjrXxCI+UZhscdnPWNu6XvPdmQkQEqCwHE6UUdvg2ylOCaWa5z3MOk2+0yJsXCITyhsq9CtV8sQ4ZsNjUGgwjNbIg+zADu0WGMn9+9cSfGFDKEwlGBGFa8gPgpIN1GDgKgW03gk0EH5fsFO7L4HO0fI5IKXe/Kc86vePLEgpiGCNTwuwGRQxMMyTKWbB6LyGdnlMcjzGvdXHujKp6CI5tUrF/92YFxXqDqOaqEhGSEU9jpMLDtppOSWLTOFTM7DUrcH4ejHlY/P3b0B11+4Exg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXjOjDBb4PYJyOxgsU6x+jt+sMCOoNtKWtWK4nozLmU=;
 b=hu8JMwbv0/JKYUCITQChNNjF0bpa841QKJythCijGiXaFQT0x1UhG6F5GNkp7miiLRCRzdqrGkhOyW4bqsa65NikDy7uS1Klzz1dOdwF9tWPBPoJycRIMoDoJKtPv4eBecHcVVVFJl2eiF9G+5sFkQdM6wcYrBPJWz8RdfmgJ4+/zRmW9GjjY2TIq9lbfFYvjKOcW1EdzWtmgIpJyHVw2/ofQi+tUJmFc4IPeAjZheFBtfK3uURdixXlJ0pXcoxlZx9/9vxJEZp/WbZ0o3/Wag+kEsq01RhsFEdVf/VbGHGmC19wQZoorR5Gx3dNM2Mnx+omVWDExO1OWzzJunkEDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXjOjDBb4PYJyOxgsU6x+jt+sMCOoNtKWtWK4nozLmU=;
 b=bBJSKgBm0Gf0pBwaSaPhFxsfXm18LqJkzlsq7DBujeK6TQDbw6rsLzMwbHju/Z2s/M84FaMwwmxr8fobhOar8Babo79DWFhiuK+z0fW7WdfVllN+nCwf6xcJ4jU48O292WCKsAearEw/yUGJdnhp6YLg0EARcickwjPIuh9hI5s=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3397.namprd10.prod.outlook.com (2603:10b6:a03:154::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 22:50:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 22:50:19 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 7/8] hugetlb: prepare destroy and prep routines for vmemmap optimized pages
Date:   Mon, 16 Aug 2021 15:49:52 -0700
Message-Id: <20210816224953.157796-8-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816224953.157796-1-mike.kravetz@oracle.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:303:2a::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 22:50:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bc5d216-7c56-402e-4f19-08d9610838d8
X-MS-TrafficTypeDiagnostic: BYAPR10MB3397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3397F19190FB5B08BBA1C0F6E2FD9@BYAPR10MB3397.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fGfopAN/0KUaFb+JL7A7mx2TkJ5eyvVq0iaU4mf5QwKmYwVBhvq17QyqjFF/yoZLbXP4mH6+5IeljVj9j1y+g4fP4xqjxo2rlV8Czp7yRWmQ0Y3Kk0LfSdznCPobLI1WBK+gi3LVzsHT3GnuAsaLRSE1uTmu1adyWwEjaTv1P9Clh08ivSHUNbQfjmVaqJDv3tfRfjLivd5e4Bo0l52Ph4+xAM5ZX0/tOhSgz+NXSBZgtf0u44plinMPFG7XKV4+wZdH6UpISFo4w8cNhMRB+BCepQr+MjgH+xC1/TYKneIRf6V3bIsSUcnySFDl3Hc67vJfydfW5T1BQX1s1/+7lTISgTBKOEiGaLLWBs38LEko75376zz6Pp+WCJU/HM22v/juSM2FxzvJHcgB8RpW3SXBiPaOFiWnfYqYybSjbhL7RSKLMZU6MTM7F3Sb7kkiXLtEb+6o1szP0DMTRT/VaOhxJEEbt1l+Y2XxD1EtYzebK1JR6cmupPrX+1wkltmISrrWrLgPJPmXpaGggA9jjAf9kJ3cRFRoCTdTXv5b0HxI6HBnrq11AujZTXzqIYT3PP/w1TLZyJAFqZoPriV8aEazz324aFAILXpSshBNXWB7YGte8/+r4DuTGXfjGKDwNz2YusaKRJH3Y5pPlXwnQNLB8jiVI/50hDRqlC8cXzenCqO3GhbPRWfqMaMhYVJxywV1B49AIiP5fP2bSgcHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(376002)(39860400002)(4326008)(54906003)(6486002)(956004)(2616005)(107886003)(44832011)(316002)(7696005)(8936002)(8676002)(52116002)(1076003)(83380400001)(38350700002)(38100700002)(2906002)(6666004)(86362001)(26005)(66556008)(66476007)(478600001)(186003)(36756003)(5660300002)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cATY3WoJU8cmkh1Urghq0u46z0ORuaomntxo/+/fL8faEWchM1gTHVIqRUrf?=
 =?us-ascii?Q?/86U9uP7IxQ41Op4OavNTqvM/ZdxaIt22SDu+KuuIdwohVBxDWP0pu2RxiQv?=
 =?us-ascii?Q?OBh1LGbghtDinXxUn7G7yxtcCmw/iFNH5zQM+blW5q6eQr7OknUG8i4zfF0R?=
 =?us-ascii?Q?3yfsk1l1CoXeFpD5WeL3SAIccqSOJo34698NsilZzgiPjsKNY3Z7C2sCukji?=
 =?us-ascii?Q?S4QZ879X3r19+8iHwdWv2DW58ZDrtcVeFqBrjo3O+7eCL1k6PJjd6wQUt6g4?=
 =?us-ascii?Q?hVQkz2rr5MSXYwli/TgSAWmiDd9r3ogOgAycU1f7+dknZzxxgqggndERiIE2?=
 =?us-ascii?Q?TjkgBD5sYzXLpNYWgGcea/LY2w6s3YrUbzNCwG0Jox9qjxHGpJqq7jT0hRBW?=
 =?us-ascii?Q?L81TEKKqk/ErNeqWGV/9G9w6WabexuZx3/q1PJBB3v5WQYRz23Ye9ANN+Ghz?=
 =?us-ascii?Q?pH1S7l+k9d3lRAdhKm7Q0+R151ob/WVD4AFv7pk7T1FiGpAOMScktvKWoXuw?=
 =?us-ascii?Q?KMQZ/M7lp1vPykTTH1+tslkpmheJvWHDD77XhyZMKq7TRxfN6bFp6jEW0lAJ?=
 =?us-ascii?Q?ZyZR9foEzPo44OiFcCI1iVdSNeD93xxtH7Syc0krFpiEScte07t+rgk45SwJ?=
 =?us-ascii?Q?3XHQODjuPMsCQGQ+6y27A3BVaMKbxxhAprnWKI7JlwKWVulNzyDST+QiuZOu?=
 =?us-ascii?Q?QPzBUBeVGX2g/ZJcdhgccTWgOOx4jTtOt/FfRUDEvDxTaIHYn57B5gjLh+0f?=
 =?us-ascii?Q?zRctDzceCrTqnGJSuWKxeiME8wLV9VJe62xm78Smh9Kwl4ja/bOb55SZ3VIs?=
 =?us-ascii?Q?wQcYqUOOX3e+L4FLXwjprsFk6B6T1il5RWtejTSUrBrEsyY9ypQwNPzRf9AY?=
 =?us-ascii?Q?XqCxHAhXMhidURQJ+O2eUb8S9RmHX2WyQOuwOOhBGy7Hu60c688D6zMjW0dq?=
 =?us-ascii?Q?SPpjLi9vQdSkuFzorecj8E0yVWipbL4K/gvmTgCJ5fSHYpNZWRy+Aj+Rnvsv?=
 =?us-ascii?Q?HrdbCBmPnbWU/qW/cJUaDCf2iMY/N5vOPn5eS7XOeWTgWm5bKY667q9Wh4I8?=
 =?us-ascii?Q?Aw3IILv1ebjNtzfuNvJg8eXQBMiiIA5eSpZ1sSiRh384A8cwtXiVXIBbfKOM?=
 =?us-ascii?Q?uOXDzIOo7NxDt9G5pv6AGASD+owEccjnLe6xZHV/xLclKlrCdrhvulWZBt2N?=
 =?us-ascii?Q?cmUmC0Id0c3VdvuF7nyW+FtEluO1eKoWNy8Xq0mpyFD1icqzZvlLU7caqn0N?=
 =?us-ascii?Q?/JzKhGb0Pt3cgxvHD9Sfko0TjynLKMb38CZWMG2RBr/FzHaYUI99S6csYtMl?=
 =?us-ascii?Q?9AgP7Dr5Sj7CLiJUilpmqByR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc5d216-7c56-402e-4f19-08d9610838d8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 22:50:19.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2n8cIDgU7S6dpjMtaG8QR7Dx2x991oFBe54qeWvim1847zWOfmV3yoHE3kz1cvMSjOkaUZQ2Snq4RAjIbr4nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3397
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160142
X-Proofpoint-GUID: 19BOXqtOCKFp4HB3XFBG71uDl4-g7Mw_
X-Proofpoint-ORIG-GUID: 19BOXqtOCKFp4HB3XFBG71uDl4-g7Mw_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When optimally demoting huge pages with vmemmap optimizations, the
routines which destroy and prep hugetlb pages need to be modified.
Currently, these routines expect all vmemmap pages to be present as
they will write to all page structs for tail pages.  To optimallly
handle demotion of huge pages not all vmemmap pages will be present.
Only those pages required for the demoted pages will be present.
Therefore, the destroy and prep routines must only write to struct pages
for which vmammap pages are present.

Modify destroy_compound_gigantic_page_for_demote and
prep_compound_gigantic_page_for_demote to take vmemmap optimized pages
into account.  Use the hugetlb specific flag HPageVmemmapOptimized to
determine if this special processing is needed.

These modifications will be used in subsequent patches where vmemmap
optimizations for demote are fully enabled.

Also modify the routine free_huge_page_vmemmap to immediately return if
the passed page is already optimized.  With demotion, prep_new_huge_page
can be called for vmemmap optimized pages.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         | 17 +++++++++++++++--
 mm/hugetlb_vmemmap.c | 12 ++----------
 mm/hugetlb_vmemmap.h | 10 ++++++++++
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6d43523a1a4d..259b840718f1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1265,12 +1265,18 @@ static void __destroy_compound_gigantic_page(struct page *page,
 					unsigned int order, bool demote)
 {
 	int i;
-	int nr_pages = 1 << order;
+	int nr_pages;
 	struct page *p = page + 1;
 
 	atomic_set(compound_mapcount_ptr(page), 0);
 	atomic_set(compound_pincount_ptr(page), 0);
 
+	if (demote && HPageVmemmapOptimized(page)) {
+		clear_compound_head(page);
+		nr_pages = RESERVE_VMEMMAP_SIZE / sizeof(struct page);
+	} else
+		nr_pages = 1 << order;
+
 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
 		p->mapping = NULL;
 		clear_compound_head(p);
@@ -1527,6 +1533,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 			return;
 		}
 #endif
+		prep_compound_page(page, huge_page_order(h));
 		__free_pages(page, huge_page_order(h));
 	}
 }
@@ -1715,9 +1722,14 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 								bool demote)
 {
 	int i, j;
-	int nr_pages = 1 << order;
+	int nr_pages;
 	struct page *p = page + 1;
 
+	if (demote && HPageVmemmapOptimized(page))
+		nr_pages = RESERVE_VMEMMAP_SIZE / sizeof(struct page);
+	else
+		nr_pages = 1 << order;
+
 	/* we rely on prep_new_huge_page to set the destructor */
 	set_compound_order(page, order);
 	__ClearPageReserved(page);
@@ -1761,6 +1773,7 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 		} else {
 			VM_BUG_ON_PAGE(page_count(p), p);
 		}
+		p->mapping = TAIL_MAPPING;
 		set_page_count(p, 0);
 		set_compound_head(p, page);
 	}
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c82d60398c16..01c2cc959824 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -172,16 +172,6 @@
 
 #include "hugetlb_vmemmap.h"
 
-/*
- * There are a lot of struct page structures associated with each HugeTLB page.
- * For tail pages, the value of compound_head is the same. So we can reuse first
- * page of tail page structures. We map the virtual addresses of the remaining
- * pages of tail page structures to the first tail page struct, and then free
- * these page frames. Therefore, we need to reserve two pages as vmemmap areas.
- */
-#define RESERVE_VMEMMAP_NR		2U
-#define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
-
 bool hugetlb_free_vmemmap_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
 
 static int __init early_hugetlb_free_vmemmap_param(char *buf)
@@ -250,6 +240,8 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 
 	if (!free_vmemmap_pages_per_hpage(h))
 		return;
+	if (HPageVmemmapOptimized(head))	/* possible for demote */
+		return;
 
 	vmemmap_addr += RESERVE_VMEMMAP_SIZE;
 	vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 44382504efc3..36274bf0256c 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -10,6 +10,16 @@
 #define _LINUX_HUGETLB_VMEMMAP_H
 #include <linux/hugetlb.h>
 
+/*
+ * There are a lot of struct page structures associated with each HugeTLB page.
+ * For tail pages, the value of compound_head is the same. So we can reuse first
+ * page of tail page structures. We map the virtual addresses of the remaining
+ * pages of tail page structures to the first tail page struct, and then free
+ * these page frames. Therefore, we need to reserve two pages as vmemmap areas.
+ */
+#define RESERVE_VMEMMAP_NR		2U
+#define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
+
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
-- 
2.31.1

