Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9C9404906
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 13:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhIILOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 07:14:03 -0400
Received: from mail-vi1eur05on2080.outbound.protection.outlook.com ([40.107.21.80]:29280
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234953AbhIILOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:14:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyTzRhz710sYqMGfYtNoTyW4Ferlc32LzPlT9PlitRKTogIXAMSsw07W2z1rihhq4cJe2YUdCd4DqSESmgmsMs0mMRb1ruosUrP1lgsD1rfj6OErN2lLdoKx8m0KD4jKBYCNsepU7y8BHkKI1otMC1Jw07f1jZAL1VvTsVSMYiLkJ/SlHINiz8IETQxtLbSpw6I51ItVLu7A5QRbAp3IcqoZgWQlFr/Rfwcji2hzB+qFkgI2WpDnOBU/QApDpooaovBJTzXRViVYjhgSi85xBgJUGA1mmQcBJa4Fch2k4Se/UzIIGLRFy/t7xaBS+5OwzogiA9dLnhpm7TrM+G7eFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wjfNttf9jRAgIYFPA4VnxGHOZlXsjHNOe33kPGGIxXs=;
 b=A/gjuQQmMJ8NqUbchjcnCwRmBity2xE8qqrG4Le8W8JFjjrnA9FQjoefss5rutHsKSmIp+hicVTU4FhDN/pyxWWZ2VwqMwL7qXL+Yk0bof8aLamD+EQ86MeBhvdGJQ7M3dNrXA3LgkbpcsK37tWRyXHsfBeTMYWCxHJHDpKDRUbcFouXEREegD6n8LXFECRLbSeENaWv5GxLqZ1l5i7cEQ/lUQ8qjQubKoMVcufwj61OLvw5kTRRmFbaI0inZRNaBGArOOsO2heuhrA4eJhYyHXBzGrlj25SHGoWfOKVJCkTSWTUR+2TdzI5qD6IuK2+2r+uKBWSrW+9uVcdmpb8Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjfNttf9jRAgIYFPA4VnxGHOZlXsjHNOe33kPGGIxXs=;
 b=rU7FE8BsHJUilDmnXnSHIvrxtzEJO5ToMcrXwmrnxyjurpyVYfod2JylxqElFn/TQdSWPUCBy6v/Fklxeff0E+E7nnCIm/IyCo7mk2tVbnvKhSg522G2aya/hzwXqTLgKOUSEE9NguHZCUWbOWguub86ChpUiH9/SDWBauYO6JM=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7)
 by AS8PR04MB9009.eurprd04.prod.outlook.com (2603:10a6:20b:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 11:12:51 +0000
Received: from AS8PR04MB8466.eurprd04.prod.outlook.com
 ([fe80::414f:6546:f3d9:2651]) by AS8PR04MB8466.eurprd04.prod.outlook.com
 ([fe80::414f:6546:f3d9:2651%5]) with mapi id 15.20.4500.015; Thu, 9 Sep 2021
 11:12:51 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH] arm64: dts: ls1012a: Add serial alias for ls1012a-rdb
Date:   Thu,  9 Sep 2021 16:42:29 +0530
Message-Id: <20210909111229.2444950-1-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Thu, 9 Sep 2021 11:12:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66c7d51d-d075-4133-0b23-08d97382c374
X-MS-TrafficTypeDiagnostic: AS8PR04MB9009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB9009C4D4C00E9D846FAB1E2AE0D59@AS8PR04MB9009.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FANcZnzIY4fGeZd9I32HCjxY1lpSa/0QszCIXuVqof08q1va7anIBh6JiFxYd5Lpe+26Cj2wSbiJl1T1gLbhh7b+EtHJPjXzPnYTNQ1boYSz8IJovcU7e/fElfzx+siJtUJ8xmSYPY+twJSECra2sSvn61yky4coy+8d0aFk0IKhlFlDQmm+PHemFn+hvRLEeiprwhlSnKzdr8ROV/T2sNyLoW2q1QZ1MTiRIdCHQRa4fI0+BWIaUDSVrQxsuejw1dhMVLNvnn2nEmy/G5zqmLguJ7LPB8Sd19+JesueNqFlaBfsT7wf2wKqjYRpXSPSwSDAk/ysQtuyBWAFzbsIRTMSXcG8eTogQQYoLtgtFz10zUc0OPlj1sNTt9CqCeGUeYSH+wT2baDFBQJ5aO8tXvyCdZM7JMzRuS1zF7WIta5PkxPHzBr0baKrR9AMr2xjspueDA1fnm7jwLIzdRGVPCJ5ZrVvlJeR8fxDhyPpzvHN/Jhgy2fodunGbv9oSndDLwVBDCCRWcH0qwkEHTc3Fepx3DW/SkBPK6/Nz4tpVd7sNBi2snB0iVamq479atmDbLkGGhWemN7NNGLF1UGnvpNZ6dldGOfHiUwhOvLlet3vmolO5T5nIyAU+A2ynO1sW58+UQmZPqzjh2qD94m3vjenedh06EVsiRh2D8NHCWShWqbo0xifKL0FrfwNjiNYLZA9XEIFKzpYDDNL70xiZTL13VuzaDnJTW22TdthnJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8466.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(8936002)(55236004)(2616005)(66946007)(1076003)(6486002)(478600001)(4326008)(2906002)(956004)(7696005)(8676002)(186003)(26005)(5660300002)(6666004)(66556008)(66476007)(1006002)(36756003)(316002)(44832011)(83380400001)(54906003)(52116002)(86362001)(38100700002)(38350700002)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uu2NkV74EFWxjxD4Ru5McjQlc46+il419fyx78nDgxBlkpAqtO+GO1vi+RC4?=
 =?us-ascii?Q?jBgRIclmncCmWvWpGQSJTCRz5berAS6lBRGf3Jwrkk2V4cHcQipe3C4LAwm8?=
 =?us-ascii?Q?mbxv6uYv097FoIU2BpwKy1fIRPJ/X+Bpl3/7YgntnRWN4ys6ddboYcMaxhJL?=
 =?us-ascii?Q?itWoHXir16BAwUV2+3zaFlrJST6r98SWCKbDfJSUdvorhXgic7/p+UgXrU6i?=
 =?us-ascii?Q?owERw/pHvX3PZLMU5swPPtwS3xGL3yFjuUtHLdnP3PAWrNpoaB0+s6pj4qXv?=
 =?us-ascii?Q?MzPHlXoK1p5pRfs8QpybS90ZZvbwpy8TwEppbxbqbCDUs1/T361aZOT0496x?=
 =?us-ascii?Q?Jd6s2WsFIqoHFkw8F/c5QGzMSQkg4vzOMOi/5tafxk42n7ipbD5TFFuJrsVY?=
 =?us-ascii?Q?rJjPPezJWgWsYHopswNgOvUdph+7tyIkZs+YvNVMpNIrEf/IRXgI4wvyDzv4?=
 =?us-ascii?Q?Egcx6WVbnvVyFX84RbEiVxcLxix0glNmS3YqYErMCiqTph+wQRWPd+MIp0Mj?=
 =?us-ascii?Q?ITVu0EJ1Jn/TW9R1QrNgOY7KaoHsTjg5mTIn0FSKuzGRK8C2teu/9MTRqsvV?=
 =?us-ascii?Q?rc8M9MzE7HLuC9Qs8nBIS0dSamPwO2fvQY8Da4RjbQV2cak2ThoH0UfwBwUq?=
 =?us-ascii?Q?5vsvIWMNj9Hgr+d6qZtvrdck3h7GomiltsaBtptU8vrc4DzQ+vfUAJxR7fCj?=
 =?us-ascii?Q?hL7KhAZYohyjCitw2VkekmF28roVdW0OgrkmW4+/sNz1tbhffDHrIPECZWXz?=
 =?us-ascii?Q?vY8xo+kpiSD1xaQjgb4OgOlL9ftsnv77Mud4TgGSvjQyRLcieW0DUqpozLcQ?=
 =?us-ascii?Q?VJDMFMB0dyySLWiPID1VapS4b9JrBPMnu9dv/7VwiNMDqCtm8ciYJT6co2kQ?=
 =?us-ascii?Q?2KCdkT8lIEbM2STeqkpaFGtpVaX+ZnObG+tm0B19djBsFoWN1BeFtgV1s8t9?=
 =?us-ascii?Q?dS0+MBOtSkY12U/yaxmNU6UczrJzHLdcNcjZyRziam107Q8QIVthbsyYMLZr?=
 =?us-ascii?Q?jaQkQsrgKFfGW575H9YAMJxJez/d91f6j8Hp07yLPTzGYrvfZI1rZCeUkU3T?=
 =?us-ascii?Q?5YvNJepAoVbhKoTMYpH0IjEUMShClwc6z6ZpzI35V7E/BHQuON1LC5t5ZFTw?=
 =?us-ascii?Q?v+cq06ZM5n4y0vI9iXVRLiLkyTeIIwI4STjad0SmTQWjUd8WrbqVEgW3UkgX?=
 =?us-ascii?Q?dypwC2VxSfPiAxs3Cdl/nhGtZddDKoOFwtHefKOyESiIh2VsK8VQeAWbDWxs?=
 =?us-ascii?Q?EwRFY+2B+5u3TL5lMkVP8ySVR4Y4Id8mcc4SoYcj5W0ObYDsbYRVFWINc1C9?=
 =?us-ascii?Q?uQR0IcHdiaXmAODvxgx3c6gr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c7d51d-d075-4133-0b23-08d97382c374
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8466.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 11:12:51.4876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rT23YzqHiP2P4rhw2F306+rnrL5J1aN2NixePnYjG5uW4ViZZ0zhzLcPNdKf4MKBsMIyBz0flAOIJksZFbYug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9009
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U-boot atempts to read serial alias value for ls1012a-rdb but couldn't
do so as it is not initialised and thus, FDT_ERR_NOTFOUND error is
reported while booting linux.

Loading fdt from FIT Image at a0000000 ...
   Description:  ls1012ardb-dtb
     Type:         Flat Device Tree
     Data Start:   0xab111474
     Data Size:    11285 Bytes = 11 KiB
     Architecture: AArch64
     Load Address: 0x90000000
   Loading fdt from 0xab111474 to 0x90000000
   Booting using the fdt blob at 0x90000000
   Uncompressing Kernel Image
   Loading Device Tree to 000000008fffa000, end 000000008ffffc14 ... OK
WARNING: fdt_fixup_stdout: could not read serial0 alias: FDT_ERR_NOTFOUND
NOTICE:  RNG: INSTANTIATED

Starting kernel ...

Fix the above error by specifying serial value to duart.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
index 79f155dedb2d..e662677a6e28 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
@@ -15,6 +15,7 @@ / {
 	compatible = "fsl,ls1012a-rdb", "fsl,ls1012a";
 
 	aliases {
+		serial0 = &duart0;
 		mmc0 = &esdhc0;
 		mmc1 = &esdhc1;
 	};
-- 
2.25.1

