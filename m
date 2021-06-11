Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8563A42D1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhFKNO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:14:56 -0400
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:17472
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230382AbhFKNOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:14:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkcN02KbVYgWapS6jw3MJZu6YgHwxRu1K0lBtzcQSsXFFm6klzNoy1sWdzmRWkhEN8dWEqtLU0eiirpu8bfCp1re063RGyV9Z5f6qkd37eaHshDXE7d2VT+41pNXuXWBXl1FEsL7Qcmf878QcVYzjBwF5FT8s+uxhKFnczD+O6q+A6Tbw/y4pNwwElaVk7R0iDa7tr93PY6kK01hf7g2ddJ5XTLHKqXWsxGFNHwymheDDf9RO15cOZX6OvfDU1TDEHmrVbrzw9YybQJqXQp1WDKLqLUakbl/cxYxKXHhnu37hyOGsX4vCTehX3s8KcqfkHpUQ+qsM75XM6AqQ+nPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2XwapsonnYDvMtrSQFqNohq8Gt+SUQPy/DuLED+/NI=;
 b=gCAIW26cjBscqSw7BoDKjqB5rch0wpPj2wjpllWhxRke0eNUYg5p2ZPmUEIJnQMXD0mFE+0wXpppqLHV3hCgZ0r24pyX+l7Xsj6Q2kT1PfoouXdmCrpxEq/yd8E5buCCv3Hz44UDlHYX9XaoqzDP7sQjNvaPUeTVFreoak9QJsAToz11SykjgW61HoQEXMt6FbtGAEflOZ75aKcrZ7+1xet8p9t08vXcjYUIfdBdIT0CZY8Ir1Ny5mTg/PDOlcTbN5390kCA1MHgjBKemaD92SVDMtTSEbFEB2tsY8v2cmwBR9/dLI6FkKByvwpDwVzT2eBFGdLsnZPAqvanLlPiEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2XwapsonnYDvMtrSQFqNohq8Gt+SUQPy/DuLED+/NI=;
 b=d/6qYsZn5TPxi0wEH7dY6x9la/a2VJI2HoNmKoMrFFzi+mGIWDejGvRR/HkwhNXlNnD1j1IwiZeQd7nFdkZgyHeA7dpixbrMa1zibBegSoID0Z3hZS2lSproRkm8j6qeWZwndsAIAjY5oHlW/TKZjPAxo74A80ze+XR0rOlIJf0=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DU2PR04MB8710.eurprd04.prod.outlook.com (2603:10a6:10:2dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 13:12:55 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2%7]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 13:12:55 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/2] of: of_reserved_mem: only call memblock_free for normal reserved memory
Date:   Fri, 11 Jun 2021 21:11:52 +0800
Message-Id: <20210611131153.3731147-1-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 13:12:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 658f50a3-ba07-4f64-b4a4-08d92cdaa04e
X-MS-TrafficTypeDiagnostic: DU2PR04MB8710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB87106D993B3D6A5AB3F4EE6E80349@DU2PR04MB8710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMCtaXzLHhVjtx3G+HoPU71QkLqrizFhaSzYQjlcVYa/tTd6Jldo1Np2ftj8ANzUm2eV15avo/47zHhNCHEI3RbsDaD9k2I5+XB6dCXJa3eei83wiIv1zJELHrn7rJV68Hykkxzj6+AKjSrazBkClN0FNoz/HWGGQ2Zv5VMpxqI4Q3AcJDlYAQ+/BaMIijoQSQyHd3x1YlOgMOjP7jrIc/IYuyXnvsRLDVtMiCJKTG8UrAlbTm/enOO0tOyneNKnCLXRGY/QpAHG3IAnokN+uW5Mto83rZU6T+EiFA4EyGwlIQhtFaFiV2FTiXctqcefETUKostAqtbRfyYbxtSc/F8uJm9qdazh5xbKByFBeUbWxirQn6WbLvCdHjgFnAjOR7R1tlw9P7Vh6mQbhVWCfTMs0hGLW6BDWNcmjqbEy7eIhcAk3DMaPDzjn0FOV3K78wATmZDRBDlar/ZIK9j21CPvl4M8aLXuLLAI5mkndBvXgVGiuFOL4asDQfAhz2A5A+BmOqQhb+uBqDEVYrzsrbc0gvp2m70YAAc0yCUOcuvLKN88L9DZGG5dnO+HiAIZZHASO+WcUDX7mWk0scvkGVCzB35+P4+3DH5/2Sste/b8G1/j5RQK3vMWL2ubMTLtOeHzfHnPX1zWrJ7KIJC95pYgVHtP7+8yBXkPGfHW5XTabhFOeru73iy/U3gYu/vC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(6506007)(52116002)(478600001)(186003)(26005)(36756003)(66946007)(66476007)(16526019)(66556008)(6512007)(1076003)(5660300002)(4326008)(956004)(54906003)(2616005)(4744005)(8936002)(2906002)(83380400001)(6486002)(316002)(38100700002)(6916009)(86362001)(8676002)(38350700002)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RANvs0jRt85TAQ0YlAVRwHRMxN9gkoO6mHavQr6H/q0tMWfp2g+n80Sy4Y9j?=
 =?us-ascii?Q?ljedQ2SbFZZZECBdn36IbFOT7JYtcZKG5ErES6SEy4myl9mcMza/kAzoKBO2?=
 =?us-ascii?Q?WjVwRhr4UzRZxx1zI/qqNtj67xtd4u7ZeZDhqf05n+LNPGe5fvq0DCiu5vWh?=
 =?us-ascii?Q?3w6KR3OtpBE/WXE+nUzOV7p1H/WfHW2kwS7Q8vx55vD07t91Uw0h8nmFPFm0?=
 =?us-ascii?Q?FmyotsfshcfqxVwXsquQkvhAKvD+cx/dse3hxxsHOIK5eeFNBh3MgoIidltq?=
 =?us-ascii?Q?zM1FBCubn7OeBZy6ZUk1+aWTuFfqukhDFKwLzAtx0X0bwmkbEpMYVsthRlOn?=
 =?us-ascii?Q?SOjqqJJJtfVQ+kyRhHjQkt4uEugja6pmDamaIDd50IZNuC3NcYCI7AA+Wha8?=
 =?us-ascii?Q?JYGIPF3Caj5+AZy52ZwXRqeASZ7fOAiZbc2bB+G7tvJ48VtDAA26EILLZUn6?=
 =?us-ascii?Q?IKWsK6A6gl0SH9sMv5HZGaO3JE+eBQluLOjCtgro6yWzZcohV+qHvAHNSBsg?=
 =?us-ascii?Q?N5BTgLk9i/nKPybEU1H0edXlVx8gCH5qkzsp3y2nXe79LLL53UHmclMqN+gU?=
 =?us-ascii?Q?0bYTogSE7tHF1cVZcgEJT7aXgXbEqNOUJEw1JgJiTsVm7Q7jmgJaafQubjWj?=
 =?us-ascii?Q?M5t9FQ8wKxBsdZ7yNW84fjHME8wbd4UNMXRCtJvgXUjHdbp93qlIuhyoyEC9?=
 =?us-ascii?Q?EXuBdNfSYezpUVUePeDVkOJTeNz3i1gf1crUPDvbTpSXOSAiIcWf2bgj5eGr?=
 =?us-ascii?Q?huNctO1OKFSepxOI3ylTrlCHZw05LRpip77sYdut9OHH7tmvjrvPtjKIp3KG?=
 =?us-ascii?Q?A3gU9c4RV0LNuK4oMuCZxFYWnCoaGN51u0peevgTdNAaOwcqz9qcX5I68eqs?=
 =?us-ascii?Q?WhuqZIcUrVq0Ygk+ze2CuhAbD5vxzGHTeo5uUxoOJsNyy/bT1cEAqGie7AEs?=
 =?us-ascii?Q?ORZSqBVqTH6BvlaYn+BAbkt9aE9HPQRWO1JETMFhX0JsVb/ZIJP41vplcqHF?=
 =?us-ascii?Q?PdSzvWYigFS5DEegA5YQmrhqovpQKuzPV8OeJfiTuIeIGrYhbwRQc0C7wlpx?=
 =?us-ascii?Q?UbBIXX+QKi43yvuY5MBgSND2QdLFXMfoeps+/eWsVDCT/jgRwvjV5i+cruXA?=
 =?us-ascii?Q?VSNXVqvsv+brp2kXp4LN85tIGVBIU5FI3M1eM4sFDCrjCTeQuH6wog83qUj7?=
 =?us-ascii?Q?14CrPcWXNAGenizmU3SENiYvhbB++ohgSOfR5S7jfN7RIlvx1IafjCzyvtu7?=
 =?us-ascii?Q?aOjs1EBLP0/t0DZ2rDiY5xgnHC+kOdYm1O9E9l0bp3EEDkKJgKIEbYOcxLhU?=
 =?us-ascii?Q?SjPpb//ufc2sq94FFyz4M3bp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658f50a3-ba07-4f64-b4a4-08d92cdaa04e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 13:12:55.7245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kRN4n5C6anEMEZD/CHuTUgW8FicYXqUo6u18RUE9HkMCWGNL/GOXv0nxHj/o22iMzOcfeDqkGN/s01747NLvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8710
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For nomap case, the memory block will be removed by memblock_remove()
in early_init_dt_alloc_reserved_memory_arch(). So it's meaningless to
call memblock_free() on error path.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/of/of_reserved_mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 4592b71aba5c..367f298a83b2 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -275,9 +275,10 @@ void __init fdt_init_reserved_mem(void)
 			if (err != 0 && err != -ENOENT) {
 				pr_info("node %s compatible matching fail\n",
 					rmem->name);
-				memblock_free(rmem->base, rmem->size);
 				if (nomap)
 					memblock_add(rmem->base, rmem->size);
+				else
+					memblock_free(rmem->base, rmem->size);
 			}
 		}
 	}
-- 
2.25.1

