Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1131643E77B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhJ1RrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:47:07 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:10542 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230466AbhJ1RrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:47:00 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SDKtEu024303;
        Thu, 28 Oct 2021 17:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=PPS06212021;
 bh=tUKiAJhV2+LQlJY+31C4yIWoC1XBAYS0rGx0gBzDDM8=;
 b=EhnR4vmPugviYN+u+uZhJBjxyrShNKtyf4Ru0yyRAHeynRZTj8tkGTwVIQpN3aHCQ6iT
 ZMw1hNCEWSkYfTFJhaxnUK19C5fK0ttZWt0nhpJMlof+ezf2mdPRG7RqRez6qN5ti/+j
 hJkmESbnXb+pGq2pofEAbT1x+6jJvS9ndXpmdl29ijxOV1NBaU3AvsqEuHXL6H6QuSis
 pFsb4MEkA3LGfHcZxM9UQN7J2FRNfz1aiMUVd6y3AodFAChAZiXQl5dhzGlTzlg4DISV
 emQdLxHypa8V8rlOGzXNbmLsh721nVDCVpuizG2aJHQ/C9WcvSbxP8PaGX2hcRFv2+MW kg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-0064b401.pphosted.com with ESMTP id 3by93x15aj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 17:44:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVTCFQHNHT6No39F2fyUzOQHvZibZwXfCIbjP+CCeHvAAGEItFDsOHcpY9Vg6N6nZZoAqWPV80+JYT8aEzOFjdyNUq1s4dl8OQnpSFX4T5w7dmtxvrxS+MUHP9+fDlMv7zCIv7UNY/bvTW+65nO0Rz48+lhHFM/n5yAxs3Ew/JFWXOINC8Ps69Y3Lbk1sOgWF8vDf6Jq6NJd9bpgtanYPb81VK21/Ogsird/Cgn4drOayBq6EV63K9Mz9BLQ1EHijVvK1SzdrrX2Fx43pKst7HodvCTv4dku7PzElJ76r/izXhMMQK3cUfS/HvCr6HSASrPlXSNPZsQUKRnIWqZHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUKiAJhV2+LQlJY+31C4yIWoC1XBAYS0rGx0gBzDDM8=;
 b=NcqcpIbytVmSBtEv2ekQUpIEry/tst9/XgL6/9hNAGK4AzelqDeWBfZGz7rgTE+qxo7dozBDw4KD+Vj44MJJDAGG2l0V5VAkV5x0UsRXMdJzrK8YX/ogcEA7af3FdOPxAQO+ja+/oY1uKVRKFpHlTwvcO0HDJqD2I/MELRRRo+j8koRGXiqPUDuTRiqgy/Y2xpST+GzdydaQLyWQHuBX/VzGuNQopJ/YRE5Ecx/G5d0g1/P9fmk80qHa40B9kCS/hRZSmymepdZH1K+9r2jbsuRaTcbaEp+IvLQ5jK7r00GNkuvUjLhR+rinDsQIABmAYlZlubpj2ONIlPAmc4TjsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by DM6PR11MB3449.namprd11.prod.outlook.com (2603:10b6:5:d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.20; Thu, 28 Oct 2021 17:44:23 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3d20:a9f3:70c4:f286]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3d20:a9f3:70c4:f286%6]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 17:44:23 +0000
From:   Ovidiu Panait <ovidiu.panait@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     edumazet@google.com, davem@davemloft.net, kman001@ucr.edu,
        weiwan@google.com
Subject: [PATCH 5.4 1/2] ipv6: use siphash in rt6_exception_hash()
Date:   Thu, 28 Oct 2021 20:42:29 +0300
Message-Id: <20211028174230.1800007-2-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028174230.1800007-1-ovidiu.panait@windriver.com>
References: <20211028174230.1800007-1-ovidiu.panait@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0134.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::32) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
Received: from otp-linux03.wrs.com (46.97.150.20) by VI1PR04CA0134.eurprd04.prod.outlook.com (2603:10a6:803:f0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:44:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77563db4-8e3c-4ede-c511-08d99a3a93ea
X-MS-TrafficTypeDiagnostic: DM6PR11MB3449:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3449A442F6DC77C9DE5AFF55FE869@DM6PR11MB3449.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +aMb42Qef+oM057adUmDFviaLQHugaZzo2aJTUmJv0DvVfi5o82jDaQH/m1zOjPQZTC4sL7QE9JMjkcfLrIBRI/XgH4jDQYyJZ4fFNJEIaqCZ6BZjDH5SlzLcO0YSSGTUMU3KRXCKkBWPTVX7M3SC8pL17nLyOAyCpmaqtCP93fGx5PXaUpktZhq5UlCxEhF7/+lVEXK43AQa0YcFU8dkUBZgBlMwrxvSK9Q8rMSZ+IyagxFAQzCpwZRlnaXGtmkE5RYX61QmwibjO/+AQ50sXx8CWKMLl+ki/GxcM0BR0IZ8OLaRxdUYQJLU1MWvdHCX70waZYFUhewvwwJmFnIw3QPYF++AkNYIRWC03LTODjGlLbAnXgUUZbozW1Nq3pv2WAu/x9BzY8QiDctLiL3IrqLHos7pdW/iuvBpxR/i+I9PT7OkRXMTirfmgSbW5Gt6uELk+0tkYet3D4VwuF8xao1/LiTLLcTVAKDgZ5hob6wLSVOyHrsU2JUpHz0ZeFVRKc/FGj/uI/uFO4ZUARqrBfY4a9VMZOQmJHSvntTmnhS9wbMYgsM/+7ZnIzZdKXW2PnmiLki/4MAs3HruUUzOfDXZUcr0NpxphSCWXD2RDf6Bz3AEKZSU3FSMVPwkDvZyhY4wrwcI8/X4ixUrWBsrQ896exGO81cykcGNvKUf3AyrYTc68yqJyRmH6AXmc1AyUG5NG+cNw5PmHeW3Iid2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6512007)(6486002)(86362001)(2906002)(2616005)(6506007)(83380400001)(316002)(5660300002)(36756003)(956004)(66476007)(38100700002)(44832011)(66556008)(6916009)(66946007)(508600001)(186003)(4326008)(8676002)(38350700002)(1076003)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cpe5EME9/cqmQ/L2deYtF0Yencq+2jf1QVlHEAO5hAOK6KSnuIdLRGo2AM/r?=
 =?us-ascii?Q?gE/d9BOVNn20ArqF8zMBr0oPb1/QouwDJlSH4Oa7JnHlnDm/oUfRWjJA3gkA?=
 =?us-ascii?Q?HzzwAsKyIOA5NEaEaaB8oEiFkKvOF98iMv9YWeVBJ0ptLeQ7PowPBbLmyXyP?=
 =?us-ascii?Q?SaTCaChCo2ZoH5ftb0RycuWr9FX2cCCv5DvN+BvEO3GdyiHoBASrtIWS0fvq?=
 =?us-ascii?Q?LODAHOqwl/rEJeVN4PtY8OZCr4GDVbOX0YqQKgi154CKT31EL7l/nJIsIcnG?=
 =?us-ascii?Q?s5R7+mlXdra4OKaSE/61fXvR8/HzsviKQ7W6+N1qNfgZJxEEsFLatRFT7j5O?=
 =?us-ascii?Q?xZRPAp1zN5Dd5ZIiBkal6s1WXGPZeRVd4t5qVGzBKbNOFq/wJql8XYRxHb8Q?=
 =?us-ascii?Q?0DOP6rIJ6ugM3OGxNVBZye+s0cl3oAAKjYKtXi+TPV1XrjuxaffXTf1UcpZV?=
 =?us-ascii?Q?Kk3vRXYYEznuzUbwWF32N7XtVL4FYcCcoA1eKOFTqT+yUx6/16B6UrnC7n0U?=
 =?us-ascii?Q?1470xL3s62dF5dhyqBjyVdWdTd7qw0GuHVIga2zQruROgiYaB07rPb4eVhug?=
 =?us-ascii?Q?xLrgH3oIzKG8PW/NKqXtuhvDn14OvcEZ7CcaRuaokYRb/LtdjJfqoOZorBqN?=
 =?us-ascii?Q?QCpiT9bl4UiW3t34Q7nmizEk44iYIyG33zNxsXfMZasaEycObqTHpWsgTA0A?=
 =?us-ascii?Q?yTbqmnWmiMzR9XBLxxTeoo4g7cfkpEqAqTRnNkPMdXvEUEy4E03X/Xn2W06c?=
 =?us-ascii?Q?h8NoKX7galIuUfVVEOQMc99t7vMfN8fXP9EUqVoAPvyp53HofZpjOPOP6wYj?=
 =?us-ascii?Q?lBR7xesTPhO6mhnhiKG43kI+zvlDsO7y/Hzsfddf0qL/eOY1dFqz/37FuIoi?=
 =?us-ascii?Q?6CgMhm35Zt6hCh0KJMdBbNzrP6zN+sNhHBpZ1jVTwcCZ7ZzkJO+L7AzMjWoS?=
 =?us-ascii?Q?Py8Hz/i+KCMpixvo6zxl1C9G88P+vgEc7HAMrKSJ4BHEOqIAK21v7eiMb+rc?=
 =?us-ascii?Q?X9l/nF7MhSuYqPBEde1Cu9Vk8Fz6sFyTJi432yxBK4J3BEEBDWGZZN/nBLK/?=
 =?us-ascii?Q?V0m1icCoG2k9ZGAAVZz0qicZ1ClyhHRDL4LJ7HG4RvBMyash2Ln01FP5LqOH?=
 =?us-ascii?Q?/nUms1tHoTpSiaUTAEDWTtos3Yt6Estvg1b72alwHyHOCwOVL4N6daL0IzWQ?=
 =?us-ascii?Q?lA6nMI1bWJR8tWxjDbiVwaII6NU/dm5hHTqMZevjkrtM8NlMMHBZFKl9W9u5?=
 =?us-ascii?Q?eKEHmI+G+4l1xw1JeFyt94QhEWlyuZLhRafxTX8C6sPU86e8/7xsnodCLCHw?=
 =?us-ascii?Q?gAFjITZ/6qQea9SPHPzpIw9ZFNLKbbVCa+s4A1V7cfP/+Dua14kETdk3Y3UJ?=
 =?us-ascii?Q?Oj2NgzKj7KTh8NRDISbYf5pXSnB8iXK2uSyQCHaiU8ZFL2f87aYJZK3alt3w?=
 =?us-ascii?Q?QJ+m3vVM3imEDZzNOIPREIz+/pNXc97VmhZ0hRFg5mHS3cWuXNdVRSnioONj?=
 =?us-ascii?Q?flg0nrJqtUq80qTb6kQhqmdScqrGuCZBTpjhIQ/J1kmJE7yTWzdKIZ8NOPTw?=
 =?us-ascii?Q?QIRCkGXwxgI2go6Ixlsxj9487UbHmbdOI9yT3lqx0iaW+mKRZS3OzvbiOeDO?=
 =?us-ascii?Q?EWjw4JTNhaskTUDTgF4vigEGflYmtbYJCsrZCS7ZtK++7jOGoF7ezat1I15e?=
 =?us-ascii?Q?beFOJQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77563db4-8e3c-4ede-c511-08d99a3a93ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:44:23.1327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbQCaqarl2s0T0mbbk777oRXf4LU9dHxPQOhs/J//4uizf4S0mXX4nffB9r+i5DzblFUWh296H8W8GaZkOct5OguFgb7fM4FAmmLMZzPJQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3449
X-Proofpoint-GUID: RiX3Go1dG55UhAtn2mDAjE7oCbPUMzlR
X-Proofpoint-ORIG-GUID: RiX3Go1dG55UhAtn2mDAjE7oCbPUMzlR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_04,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=894 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110280093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

commit 4785305c05b25a242e5314cc821f54ade4c18810 upstream.

A group of security researchers brought to our attention
the weakness of hash function used in rt6_exception_hash()

Lets use siphash instead of Jenkins Hash, to considerably
reduce security risks.

Following patch deals with IPv4.

Fixes: 35732d01fe31 ("ipv6: introduce a hash table to store dst cache")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Keyu Man <kman001@ucr.edu>
Cc: Wei Wang <weiwan@google.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Acked-by: Wei Wang <weiwan@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[OP: adjusted context for 5.4 stable]
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
 net/ipv6/route.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 3fb259c20546..daa876c6ae8d 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -41,6 +41,7 @@
 #include <linux/nsproxy.h>
 #include <linux/slab.h>
 #include <linux/jhash.h>
+#include <linux/siphash.h>
 #include <net/net_namespace.h>
 #include <net/snmp.h>
 #include <net/ipv6.h>
@@ -1502,17 +1503,24 @@ static void rt6_exception_remove_oldest(struct rt6_exception_bucket *bucket)
 static u32 rt6_exception_hash(const struct in6_addr *dst,
 			      const struct in6_addr *src)
 {
-	static u32 seed __read_mostly;
-	u32 val;
+	static siphash_key_t rt6_exception_key __read_mostly;
+	struct {
+		struct in6_addr dst;
+		struct in6_addr src;
+	} __aligned(SIPHASH_ALIGNMENT) combined = {
+		.dst = *dst,
+	};
+	u64 val;
 
-	net_get_random_once(&seed, sizeof(seed));
-	val = jhash(dst, sizeof(*dst), seed);
+	net_get_random_once(&rt6_exception_key, sizeof(rt6_exception_key));
 
 #ifdef CONFIG_IPV6_SUBTREES
 	if (src)
-		val = jhash(src, sizeof(*src), val);
+		combined.src = *src;
 #endif
-	return hash_32(val, FIB6_EXCEPTION_BUCKET_SIZE_SHIFT);
+	val = siphash(&combined, sizeof(combined), &rt6_exception_key);
+
+	return hash_64(val, FIB6_EXCEPTION_BUCKET_SIZE_SHIFT);
 }
 
 /* Helper function to find the cached rt in the hash table
-- 
2.25.1

