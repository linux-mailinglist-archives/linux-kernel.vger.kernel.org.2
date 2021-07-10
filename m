Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A14A3C2C09
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 02:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhGJA2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 20:28:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30018 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231441AbhGJA2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 20:28:11 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16A06d8L022576;
        Sat, 10 Jul 2021 00:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=x4j+E1KMXH3Y+DvR6HKd8eoVUuq5iSCV+mgTRf/qcyA=;
 b=CZhPJUnsCGrQd34CoH7SYfOr8HD8rmB2UuGTbg6sbB+bJx9iNfUf0Vy19zFfT/wd7M+P
 /23KEXSpMkWLkqU96XDqN8vcPYPi58qwQrfRhVfwzIEcjFyoIBbC7Px5Z6z3yleu4ZZR
 mY4VCPmpv/650uaa1/Pg0Av1qfO9ZghBYhVj7Qwf889LpXBkbkjqRn6T5bzNnq7Ehgof
 5E6pul4I46sxumiQmHQkPkDRYDLG96J4gz4L1eCtOUEIR8vE8JHpahlsO7KDkcNYlok+
 xkEK1OYNPW69IFP1GuWtmF0h5i/ABwIsZa4GNcQubZkGfndltBCMNlvV+l3aLeLbi9HU vQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39pte5gjt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jul 2021 00:24:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16A04e7u177862;
        Sat, 10 Jul 2021 00:24:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3030.oracle.com with ESMTP id 39nbgawumw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jul 2021 00:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vzpu7d+uTn/rmUbCE9Qie94MD56vtOJGLxfstX8fFumm8kJJS+04A74O6pKAmcS8pBaVbqQC7i0wZtMLkNwzaUOnZdVBBlfKsbPfgaVkcG0F1ecjhJptB22Q2WfKqnQM18YhVWXwOZFEsqgWhAohQrgUErgt/XN/5XJjKLD1qix+smA/clJrZDn3wh8nxMZ0a1YqRTTrxupLyPg/LbWOlGGWP+rIGzHp4pDxKKsMjqGUZL4QfSj77pVUlbwAmHmOXtM3CwKGvDfwFry8xHRDOq21JbyzD6s2Cadanc+6cbgSWcdjTikX2j4fwuZLFF5H3ugUrvpPCGN5nSqnwBZYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4j+E1KMXH3Y+DvR6HKd8eoVUuq5iSCV+mgTRf/qcyA=;
 b=UZPl37C++HARTC+bc+gn1fCjEJ6gLDd3pLlJ6AHQVSi+c4IbNaPJyQMwZYFZRyp7Ne4LLjvLtKB9U5/1FkX/bidzl7CgMYVeDQQYYhBftGEoAAKUbh7aT8FSagUVzcsHyCkAbfo51OfdB5JPWlZj2XWkHG4WqgX2/3z9I/Z97Fkyty5anfSnmdFW1t0qWrWIxRbyOhYckSnK5kNRhGZpCtGn+WzhaxMshOmS9BJA0cIAS8xdEm0BaIqehWtS/emlxOYmWiGCQInNdpsBuMMoSftuRImJIuq3BR965IUWXhKvYFv82k8NOTHo5MRRIeuEe8/iUmojax6zN3TxOStVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4j+E1KMXH3Y+DvR6HKd8eoVUuq5iSCV+mgTRf/qcyA=;
 b=KBfQRJ2iq/IOx31NO3Fgxvxq+ODUu5UzN/qxks8YkOdT5F/6NqQCUHKKDJkNGicBZfTbLJCxJVsStPxZ+ZC7QJmqV0zPor0t5iKEDMM+Amk0DpD5kR2/gxP4oasS+tLurD0Q2HtQcFxl72LkikBUOLHGoJmpw/njFhzYWedmksQ=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5439.namprd10.prod.outlook.com (2603:10b6:a03:303::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Sat, 10 Jul
 2021 00:24:55 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%5]) with mapi id 15.20.4308.023; Sat, 10 Jul 2021
 00:24:55 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 1/3] hugetlb: simplify prep_compound_gigantic_page ref count racing code
Date:   Fri,  9 Jul 2021 17:24:39 -0700
Message-Id: <20210710002441.167759-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210710002441.167759-1-mike.kravetz@oracle.com>
References: <20210710002441.167759-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR14CA0041.namprd14.prod.outlook.com
 (2603:10b6:300:12b::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR14CA0041.namprd14.prod.outlook.com (2603:10b6:300:12b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Sat, 10 Jul 2021 00:24:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d6d61c3-57c7-4532-fb49-08d943392476
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5439:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54399F1B94D9A7A663A29B87E2179@SJ0PR10MB5439.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgBuUmxsdVOwouriDYvKXMX3R41V35CZZ3vbKLJLj1BFpK2tkO2cyqnRaKENzfwFRAO/ct9eqQzosBbU8y/OFeequ7HeJ0tKHPvDR5GIyV8zcweMbnbifUx1luXyWZQSICJQlTSoguVPbOC4gOVOKs++CaxSSWUwErg9OzlYoRXmW6qSdL7C5Fw4msJzzT8y/hZ1HuFt0LChjF98zYct/jbHcNIdf86pVDVCKc+Jaq37Xh7meLfclZ9rBEPsbGGaWPIGKjBpslA6+ZJs1WbAW+aSDGBzn3SdbmqwEWzshP6/9e9CFw5RWMogStme8J46K8CuxmfDq3FKfWBybKBwqdnvrPNw8c5pvBBxTXrOmWncZOErYNWlrfeK53IBKqovXhPBWO674ZTfdb7TFR+5zJV3Qgk0qmCgA+kT+WeeCa5nnABVD/A8Y+YDuRkmo63U/Xolb/Llkww144asIgDroQVdrrVvb2k/WPLjLJKmVinDfjlMeGzYXiO2lj/OSn3Mg2VkkghkVgj1WVxSuLgb1BQ+v1U6u9rSTUVRIOQeDT3TPpo7dWG9WTDwwkkHhFm/gtIJ8JyKDBSQA3NI047u+C07YftEQCWc7Gw1KBPi4znS8cxAQNr/XffKIylAJEalmAUjaoo97YPY2OvFRetUfQnEnc9Z0UTOGLWqQbVhXDfPEbdtrfwtkzFs8MJp+Jz2PY4xTVdzsNyU0Wys6fdLdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(396003)(366004)(346002)(2906002)(1076003)(52116002)(38100700002)(66946007)(38350700002)(186003)(86362001)(7696005)(83380400001)(36756003)(107886003)(8936002)(26005)(66556008)(66476007)(6666004)(54906003)(478600001)(8676002)(5660300002)(7416002)(6486002)(316002)(44832011)(956004)(2616005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rWCyU1gGk9jszRCj0q5C3pitJK7+aXUFW4CVbaxkPtGKabDIoB+JaxTxKtIh?=
 =?us-ascii?Q?GNdiIiTfd5nh7vov0I9QJIj+Iab8VyQEG0Vr5BaXfzxoE8NblY/8Yi9m+c5c?=
 =?us-ascii?Q?fOyZnQjUX+cZkMAClz7u7XWjjP5B4Rp0F38PKBwJoB9jerjLf8GgW2AHLa8D?=
 =?us-ascii?Q?m3dLNQoP9m0L7iM3msw9pMkk7LmlAhlAFv/sxK4O9ZrlYQQ4Rzvc0xVvDXz7?=
 =?us-ascii?Q?nKWbCMi5hCO5eFzilepWKI7GAwA/Pir49VHRkt4BlPycg8FU4a5G6QL2VnOh?=
 =?us-ascii?Q?jv/3voww5jPrex3zodJAyT4IgmtcYiXHOVRmr/yFE+XeUbACfxXXYjxR0dp+?=
 =?us-ascii?Q?XjriAFJzuFfHRNMW1BygXQt7eLG4l97EZvMi7r7IFS67HKtlL49oJQl/FoXB?=
 =?us-ascii?Q?D/A1CzzC269sAvBDnTd1YHBCVgWfoUfkhR0dRA/CHowlVmE9ZFqSF1S7j0xc?=
 =?us-ascii?Q?rZvr+LZp+tWmJPR9Fh1OEBvn2CZrbYRfl7wZDA2h/c4W4cBKHDQIUli6vUcH?=
 =?us-ascii?Q?PM+M5d3VQYKeYBcwjVgfCvj1RX0lBNlr29q/jTUejoAEH5U941kTw370xAu6?=
 =?us-ascii?Q?niSOHnjzec+NDNvjioU5+FreUqb+BfWD7Y/xgIcYiepGAtfoL3tOuN0Ij5ar?=
 =?us-ascii?Q?Q/WyPZm1tsWK1KyGihLpPdK6vnLdHzbClyEYgwOXso+7Me++fAQXcMYBhCe7?=
 =?us-ascii?Q?RZMC1RF9mo77CVL/eg8T/E7KnprvNs864pDbCktd8ziYMuB2M188UP630Jrx?=
 =?us-ascii?Q?w2mJ0lMxIwtmLqWTgynkMypJ1SQWXVYb/+fkSz7UZKKYFw6HcRPL4oZKM8vE?=
 =?us-ascii?Q?olyLO/J21ZqTpc6KjCrL3f1feOP7jtHqojk7z+GY4iRP2aKtjHqSHsU5A+ld?=
 =?us-ascii?Q?IlVTvo8epPT3CbHS4mZHeefMW7TWmW3RDxfq0D65G94TuRsSrQZ4nFXSrX/x?=
 =?us-ascii?Q?XjGgqt8oTxpUptEDPn1vZLIt9t9sEgbd3JSoYZF7GkBvglPk8bdFmflvB+ZX?=
 =?us-ascii?Q?b3dVAKXsuXArRkP22CyJ64mx6oJw0XqBM0xVO8sYcSNrmFcLbzocv587m7PD?=
 =?us-ascii?Q?7xE4DJ/LoCdwQeoI0x3ZUyEDPcZ5or6eG1WyiELvnYjCBcA2nmw6MRIRdCpv?=
 =?us-ascii?Q?MmTBTG/1VJ48mkoE1YJD7gyEq+gUfqHK96hSDVoiCD76wFeKi+HxfXepIvaH?=
 =?us-ascii?Q?+paoOFCgiGf5wtxDDlEu+pw/R7RWhFxEO7GESok0Cf+OIPhBWdzTR5UBr4K5?=
 =?us-ascii?Q?D64XzpBAgxyLEkR3mSPV2iE3Sl+5bBb+ytJKNMH4JR2y/De5oky74D5/8FXD?=
 =?us-ascii?Q?/3bsM3SoTvBtMp+CWq2/mUXL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6d61c3-57c7-4532-fb49-08d943392476
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2021 00:24:55.5740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQHwZUb/IYYiSbffB0nQ2A+z8+OXVtBguMN2C0B7qGovfaY6ftWV2FvfZyGm+sifJ05vXBXqSUlBG2TGr/5ORg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5439
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10040 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090126
X-Proofpoint-GUID: iThV51OF7WzHEMe3UbAYaxWLlxEoALJa
X-Proofpoint-ORIG-GUID: iThV51OF7WzHEMe3UbAYaxWLlxEoALJa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code in prep_compound_gigantic_page waits for a rcu grace period if it
notices a temporarily inflated ref count on a tail page.  This was due
to the identified potential race with speculative page cache references
which could only last for a rcu grace period.  This is overly complicated
as this situation is VERY unlikely to ever happen.  Instead, just quickly
return an error.

Also, only print a warning in prep_compound_gigantic_page instead of
multiple callers.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 924553aa8f78..e59ebba63da7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1657,16 +1657,12 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 		 * cache adding could take a ref on a 'to be' tail page.
 		 * We need to respect any increased ref count, and only set
 		 * the ref count to zero if count is currently 1.  If count
-		 * is not 1, we call synchronize_rcu in the hope that a rcu
-		 * grace period will cause ref count to drop and then retry.
-		 * If count is still inflated on retry we return an error and
-		 * must discard the pages.
+		 * is not 1, we return an error and caller must discard the
+		 * pages.
 		 */
 		if (!page_ref_freeze(p, 1)) {
-			pr_info("HugeTLB unexpected inflated ref count on freshly allocated page\n");
-			synchronize_rcu();
-			if (!page_ref_freeze(p, 1))
-				goto out_error;
+			pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
+			goto out_error;
 		}
 		set_page_count(p, 0);
 		set_compound_head(p, page);
@@ -1830,7 +1826,6 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 				retry = true;
 				goto retry;
 			}
-			pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
 			return NULL;
 		}
 	}
@@ -2828,8 +2823,8 @@ static void __init gather_bootmem_prealloc(void)
 			prep_new_huge_page(h, page, page_to_nid(page));
 			put_page(page); /* add to the hugepage allocator */
 		} else {
+			/* VERY unlikely inflated ref count on a tail page */
 			free_gigantic_page(page, huge_page_order(h));
-			pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
 		}
 
 		/*
-- 
2.31.1

