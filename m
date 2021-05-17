Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DE3382AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbhEQLXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:23:13 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:4657
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236707AbhEQLXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:23:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdJX8B8NswK80fqPOEM4VUe72Ik5qytgmAgkWAhAjGZOaY1UibBDnVNd13JHIUmprv6yltAQKeINk+fkoghFT/npN7GBZkmTwB9tHO2s/g+Quy9XSV50Ful9MtC0LrIwb6uSGCQI6DtG2+AP29KEobHPpQ78Lq+r0yhmzcKtV0mMbk4s6nyjyoJj3KjZBLCmHQA69s8NJxAagr0e3Cq8ZB4d9tlR5mLYoEf3t3Y0RnMAh2VodRUGmTwRJ+9DIu1zDRUuP4zRZU0lJeN3jklAt0pys/Q+vlnPGJQbo9EYv00msaMd7V70+cR0ePDNlg2NEWXr2QUyVWA/bfOPOIJ7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwTo37MKmumsaPZd8TpE7gyYg35cqVRnokGbVfuznbo=;
 b=eGvTaM5CODleNXr8nWV+MXnrpnG1q6dgUoONJdMzlMxIZMBcbuQqMn2k9c00KaQgRWAjxnO07Re9wgDnoLObeUysXoKwGfx53r2dUZqWjUsPKcmWJNO4hGVDlqLwPQnOVw2z+pbQg3woMPWCVyvrrXDO6tUrOEDhfFpgnMgwVo/9TaGdCaWfwqqFYnA7ttFVRc07UOkycmBv5TxHSR1Mc9SlCpJOVQdNW3i1hiyZjptoHoW7Yep2OR5hJ5L3sJJPqJOq257HIc7BHQnVOjj4ebu4/QAiMhK+9W+FbrV174n94NpCJOvAuaEtOfhoPZJO5MuLtXxoOehsc6JbHDve4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwTo37MKmumsaPZd8TpE7gyYg35cqVRnokGbVfuznbo=;
 b=Bo9pkB+m00uKcGqEuLuiEXMm00oHg75x7FmfJOTy+VI2J8VyVioOep9S0mR8rsn/6dLi1uykpB9ei+yzolnE2RREdMODf35GRxAg5GPV+DZM535Sgz3rSUeL3k8aYDb+FBB0gKAdu2SK4RbT7WPwsl5s+Udbplwe7/LwkMAzl4g=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6776.eurprd04.prod.outlook.com (2603:10a6:20b:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 11:21:49 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b%2]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 11:21:49 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/5] mm/sparse: free section usage memory in case populate_section_memmap failed
Date:   Mon, 17 May 2021 19:20:41 +0800
Message-Id: <20210517112044.233138-3-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517112044.233138-1-aisheng.dong@nxp.com>
References: <20210517112044.233138-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0132.apcprd01.prod.exchangelabs.com (2603:1096:4:40::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 11:21:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: beaa3da1-ad0a-424f-b483-08d91925f68d
X-MS-TrafficTypeDiagnostic: AM7PR04MB6776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB677627872E11A9091E174A72802D9@AM7PR04MB6776.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3neWdpCRsfayWkGgqY7W+f4Pn+hS+R2qIIHn4XrNzQ1SX4leOs+Mf3EBhpqLUyJ8PJMqEEFWwieuL5vLhwkjEdlyP7eJqhkeYPi2Ht/hd8VtcX3Ml1TvaDg4FY9vamtiDHyE8zqr7BxaP3Y5lFTy0kgatnIfNJtPdckKsdVAy2zTvBAImyg1GtFTvvvCiOwDUnYQjpTQ82HrMikcO/Zl0xQgTdl5vHPFeH/7a0mKUEnDDXcbxVSho7SZ1BYCeC4tTYww8gVBdFUL3tl4ibY/H/1O/lOC1v8BOkDIArgN7vPaTF8/vVK+rk4eWhGkw9LDiCRKp8Rxn84svys/ZE0ZYEJkn9tHUJZiRb7KnV5qJGo9T7vcyDlTkKFbRP3M+Jn5LaHB9bZP8pyfJIdxOZDv0nWwgoKfIQWRGNA1kg+VNbQy50l5VNP8rUCf77u3CNExQLD7Ptr+v9WXe4hJW141iUG/cgQcR+RbgZ51eeGmmhyfUrebQ4xcaUGihUmJdaDyk+564VuHtkhEGI1uKCIWFl6AxdSrdiB0CClpgXkmjOmFXVi3+1EG5fAP7OpjI1NjnA240D3F/5UcjWFkW1HfGHD075Xy7jW4W4U18kzKrsLJ2w1obhmvW/fY5nUWUJ9KIci56IIV0xWXbBN3hwFA7x3kt+9KhORKBwncvFrhXrb7k/BU6pwM1zjzr3Z9oGV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(6486002)(52116002)(54906003)(16526019)(66556008)(66476007)(2616005)(956004)(36756003)(8676002)(2906002)(5660300002)(186003)(6916009)(478600001)(8936002)(4326008)(26005)(1076003)(6506007)(83380400001)(38100700002)(38350700002)(66946007)(6512007)(4744005)(6666004)(316002)(86362001)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xXXM0cOMRrL9+xi5veKW2g6XOmQ1HvZSp5DLFsSbW0IEUrEQNaCu7MPlh0bw?=
 =?us-ascii?Q?vDWVhq+FRS11D8E8WKma9kJrAeV0zPbjtVcBMWJbzFygd978PAs7uxn52fCM?=
 =?us-ascii?Q?AA2JFATVZHit0lG032gG/f+f0G9sFLAdMCEeDKxVCFvNb67oaTJiq7LRnTCk?=
 =?us-ascii?Q?CEZSqXK6HgU3dEJEix7OIi07E9K/8odv4ukzhawvihariMTZLHK+TdfVVCxv?=
 =?us-ascii?Q?oBuEXbkWl1iCcX5uh/xvR5ye94xGayrBpid1efhmhk8dkGa7+wNMfg3JbkIr?=
 =?us-ascii?Q?Kmq2DqJ3WRcBl5cGyzTcoZmQFD4Hh9U4hC53lgBDdUzbqXKTp5PPS5atgoaZ?=
 =?us-ascii?Q?EhVOh+KbdvhGhjLdoPhBaZ/Hze9Q8zvZhdPdH+ZtwWhUsC2FoepP//fAUYV+?=
 =?us-ascii?Q?JRWB5UWJeYn9nXnxJm3u2jvvlrJiW5mVjyPniGYvcvxsv8JvFtIgtSsGwDdt?=
 =?us-ascii?Q?2PGrf00r48RORNVy1zUV6f11M0ISk1bUtFG+W83Y2y7HVzaE/oBQ8N1lmmmA?=
 =?us-ascii?Q?tpmUvPUM7Q/78GXLtOWEtQQA9qOL7ZzxIluYmbiTVpsw9PY4EP6Fblxza19V?=
 =?us-ascii?Q?YPjS+cCyIMV/K1TWzDzP0iVwjWQDbyqSFjdTaMtupmMVODW79JRlRzdPXqJh?=
 =?us-ascii?Q?O4jBvSA/gNc+CP9iTC12XdixQqL6qrZwnHt53XITV1ak4iemTlvlocrQD9pg?=
 =?us-ascii?Q?6LEL+1gGh9sq8c7JGd7EzzPviNqyLxd/MX/7qe5jfQAHcGLOn+XntLzdw+As?=
 =?us-ascii?Q?iZwsDrDeuPKk8GNghMOSDS+v/np+vrMbz15HfsCR+8akIuk0g9DgRIVu+7nM?=
 =?us-ascii?Q?3Ki5FBH006EZdiYGL1yshVNWsA3cPXHmYB6cPmdveGjlZDJqZzxfZf7UsgDd?=
 =?us-ascii?Q?j4YUu1XFqhlVMkFP+X4GeZJFpjlppFezaksj0jw0QIUMz9zFwEYfz10oL00g?=
 =?us-ascii?Q?6SpHGay5Gxcv7WnnUYB/FnZrHp1mftZ0R2EpELnBd7PTOC68jYm8WUgKD1wZ?=
 =?us-ascii?Q?SyR4OBjB+mH9/VcX2PlrAeuLUk7Iwo/YEOIx8HrUM9hKB7memjSnEOseVZ4B?=
 =?us-ascii?Q?YRvZvM3X9SYzTQamuPSXvWL4w6+gecstnFcz3CQLgtVzTS3Kcjxi4rSN1d1I?=
 =?us-ascii?Q?X9Bypm/3Fp2uNTULB8zvojBdB51AHunx9wrEonW5dZsDeDU6k7LWFC2d6fFY?=
 =?us-ascii?Q?TlvDpgBHG/6A2W/tZ6LgjbRE4El7tsh/3GeG1fo7AhpkBMYPM4NbaJF9vLHa?=
 =?us-ascii?Q?+xzKYFEYNk8aWJNTpf1d+qyXi+rQbuEIPRB5ccdnMJEXEBWgycnm71D6Bks+?=
 =?us-ascii?Q?87PKvsvTd+u/DA0v8bscrZUJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beaa3da1-ad0a-424f-b483-08d91925f68d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 11:21:49.3540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOzftBDfICmQtQk67bvL9DSc+rnrVLA43PJUAj+dYcPbxtmWk/8uDMk+pM+P0uO8MtT+989TCRaqDfE7i4WZSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6776
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free section usage memory in case populate_section_memmap failed.
We use map_count to track the remain unused memory to be freed.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 mm/sparse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/sparse.c b/mm/sparse.c
index 7ac481353b6b..98bfacc763da 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -549,12 +549,14 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 			       __func__, nid);
 			pnum_begin = pnum;
 			sparse_buffer_fini();
+			memblock_free_early(__pa(usage), map_count * mem_section_usage_size());
 			goto failed;
 		}
 		check_usemap_section_nr(nid, usage);
 		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
 				SECTION_IS_EARLY);
 		usage = (void *) usage + mem_section_usage_size();
+		map_count--;
 	}
 	sparse_buffer_fini();
 	return;
-- 
2.25.1

