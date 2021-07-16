Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BE53CB34C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 09:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbhGPHjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 03:39:12 -0400
Received: from mail-db8eur05on2058.outbound.protection.outlook.com ([40.107.20.58]:64384
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231888AbhGPHjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 03:39:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aC3VQHkpYPr933zrbLBUJ7vUG97UsSSjKNaruxJWpCcDMXCLCA6jPam+rvnCAATLVUegIXxSsaY3gzjEisQiB47EOokHGmrv5rfqqoQqCBIHvvDLgHagUT/RNCbvsL7+RMTaj7Hfmh/O5oxUksC0eTw3WlF6pl3xX3sdSm0p6tOpSOm2vDBHfGCCZNOIrCtryR5M/uYEbbnmxTT69HTZbhMJliB8WiYGgwxgE2H7C7rvjo1bE76ET4iQns5PkiriBYWVBCo2UQHRSlSYIrqDkRjiEWKSmLxN3LLxzJZnnuRLtGfqN2YOJcaUdPTWaUrtpTzQ/0wCnYNkGgiPmztskQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nfp2ucUKwxihvULdCQzF2US2Pc8sT8RjC3woTC5gqAs=;
 b=LUIBtwqzy6QFR+HVPW5WO5YIOS0qsEGvzEDvNIkkU00dNH3exe/vNTXmBF3oX/5CSqKA1K1kVTZAY1g3BsYIHc0EOuDa4i1tgmgk+4V1N7GCGPzesRUT8xQH68MRiTv2KVf5LAflDa60cm1GnWzxq3PWd7kIshMEPTCSETKNvFk4lMb0n2ypzZJaCw78V1bNxKY0ch+q4kCEDczpmiDp8xA+HPTNYcqKsnnm9s3VJ+umijoU7PV+GnxVk8/5ZtB9BACARtAKN3rVQquHz2U6hZVNEbIXQDet8CJT5gpIbIfhj7JB/cDjT0iLtIC0f/aEWsBl65YD6PG45/SdpL3J5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nfp2ucUKwxihvULdCQzF2US2Pc8sT8RjC3woTC5gqAs=;
 b=qO6hO7HSpDigs6iYHCj+723MbD3zTlVzpOokridZQT78u2mfYvKqrSek6S56kBZUjLSZ/BqPOlDNqWMW1UKcYZNOMDP1D14HEbcsXTVxzlbuskjF1Ue1uWFYphFERK1/i7EZTIKtGKDJFC2W7KJjup5SSHSHNaoIeVucDeCwVPY=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM7PR04MB6997.eurprd04.prod.outlook.com (2603:10a6:20b:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 07:36:11 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4308.027; Fri, 16 Jul 2021
 07:36:11 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        xiaoning.wang@nxp.com
Subject: [PATCH V2 0/5] i3c: master: svc: some bug fixes and add runtime pm support
Date:   Fri, 16 Jul 2021 15:37:18 +0800
Message-Id: <20210716073723.3490180-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0005.apcprd02.prod.outlook.com (2603:1096:3:17::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 07:36:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8f18a1b-4a95-4a89-87c4-08d9482c623d
X-MS-TrafficTypeDiagnostic: AM7PR04MB6997:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB69978FAED3CF9FEC43769032F3119@AM7PR04MB6997.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bzk+I+oc+BEbTnItQHcilKadyKSYNUXyUOjlC5s5c5U8OVEm1VwRAZzbdx/5KyuMknh3uy/dD5bisnln4XT6ZXxwgCMu/XVRYjeW2Ec2/6cvLw03GXHiFXf8baBMkkqJ+T1CTwSSdHaGPcT879Pu3cZRRtFz3vzJbbQOBhQsJPxxtE5tHWD/CV4eHxs456DkmFP4wevegxjIwnrp2D5qtmUSGyKodLicLavvFLCI0YKtls6ctc3QJNKlTmqczi0byTWxv4JWUKWsuF9nz/cD5i6T+57msYyfH7HTgmW81YuFn+Avc77OW+GNFXGsE+2nujlWnzG9Hj3FjT1ytLvwMrNisMvFI8x7/xznUukgSVNo9lxQtrbZyqzfLyLYUflnVeBmilM2CA4H2ioZhehmOqppRuqzsZbM16o5kNhZKAgP838rw0tO4laZT8A1G0R64C0/P35sexXTKfmmqiBsQf1ZKxXnnrjrCpCoO8ZyS+HultAkCPMTMzavwQtYKCOZgnYDexCOD/wIbUvexhB93tQH0pQhLJFor8lQTnI9hRnn7QAAGhcmWzAdEbjp8YkgMrEQY66cT+vQxN/ui9l3MaqhSJRL9h2XkQftNt/Yab70lRZS90tnBfmYGkFeoDEN/WdjxMgiUJV46N8cD6hd2JcvKJr0LYhGXu4CY6DFak27JuxRIo8WeHM06PXjy12G6sO7BEOj5jIZy5jN+t/n1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39850400004)(316002)(83380400001)(2616005)(26005)(956004)(38100700002)(2906002)(6666004)(6506007)(38350700002)(52116002)(5660300002)(4744005)(86362001)(66946007)(66476007)(66556008)(6486002)(4326008)(36756003)(8936002)(186003)(8676002)(1076003)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dTvUGuFgxHmqwTztdaJNWYx3QkCwYJQ4c5Jvj45nmO7IAt2xsh1kT+yw6zS/?=
 =?us-ascii?Q?v414Js6Uy1Eh9F5cO5JupISHrLqrAizYTQE41uvM5fQUK2pe2aKkkoMIhP8U?=
 =?us-ascii?Q?Bp9zZBSfpJy4zdx4xC8j1obqG+2Q2v5MeDHZ2TtBuLviDFi+4h0amc7NuqQB?=
 =?us-ascii?Q?lbzemsSVru+rVjPUHqX+YmUCzmfrhZ6TnYachbqsaRoUm1myWyXB8jRBj81W?=
 =?us-ascii?Q?7qH8hylbWFKHAGWS6RRsGuf8Su9w2D0vZrxDWmtbF52/aB3nEtAJy9BrMK2v?=
 =?us-ascii?Q?+0pVF/wXKyg8gIQbp56W2muCl9oTq/kpkJXldKooTM82vpQNhQzyxa/EDMTU?=
 =?us-ascii?Q?bkUZYne7i08RNzNo+5E7yyWgp2k+BkP16Uo9MsUwJ3RFsWhPmCIFTSr63vUD?=
 =?us-ascii?Q?Nl4/XHqkEv3cgpaeIrtlpbbogOXiSRBk6DffbSSPywu6bFlNkuf7C9gdq9YN?=
 =?us-ascii?Q?6gIsd0LOglSbDuj6HBxxJhHc2/R1by75GxdaADrGCLKwXUV+h6il+rwBNgHN?=
 =?us-ascii?Q?Ba/gFYyPrs0kVs0xa2RMF0Te0B/4tPJRkcqwOmL939jwB5d17HMmYHlHE3e9?=
 =?us-ascii?Q?V7K4USG2YAWKro8A70pqmO/7tssyAN9AkCLa3wtA+yLcH+tk2uaxSFvTohIy?=
 =?us-ascii?Q?k0euU11VCoUbEqjHwk5KlAbnXAOuc0D+grGTJtYnm7Mt5Bm9gSFBJbyQwWeB?=
 =?us-ascii?Q?y9LpOn8WBkanaQ+HD8nnGHOIqlqQ98SkaDX94ZGr0Fe1/MiYiWC3gkU5E9Kt?=
 =?us-ascii?Q?WCvJeHcDXSWXfjj0eLpkM31KwfiugYp35X4NnyTIP8J67qW2V4TiBTCZLzZZ?=
 =?us-ascii?Q?3AHrkOzAO+79bvp8ktQeGFz/uKEpyZURJsJwAp5eCRJxl8FwZuXEURjhs0l8?=
 =?us-ascii?Q?cgApHeC2mwPmy5c684FMVpZfsJj47jaQ/5RTVobfERl2kpa7s83+VCL/gwAg?=
 =?us-ascii?Q?NjxrKzJJVwa+N2/EPgIujlv/gRhpeERgwttnfJz57nc51uLMPyjgZNIRzbGj?=
 =?us-ascii?Q?7BSDN1IRctNoDneV0Jvh2vd4KGD6+B5mSLR3p/LQcmzPGnv69i+DBTiL4xRM?=
 =?us-ascii?Q?Qhyz7WZTm5Kf3WdiUSIZ1nq/JYzOG7MbatOIp45Wa7X2nsHb/QBCyGJJFbX3?=
 =?us-ascii?Q?lJ/Fh6OJOTHaUXGC/cA2ifJAV2Xp+oujySsAV91L6nYXuwGjmITjWnLwNSZa?=
 =?us-ascii?Q?VreRQTMtPkjBDAEXnuu7sSjX1rzNvAyQqOBx78xejAyckF//Uc8ICswCnft1?=
 =?us-ascii?Q?XoflXvSTWgnUrXCE7s6JyWNgVjcdwxLtzVqQRpw3ZrU2jY/y2cZwF1QZyKUR?=
 =?us-ascii?Q?3Cx/9x2sK8949bYB+JTNJz+g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f18a1b-4a95-4a89-87c4-08d9482c623d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 07:36:11.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMIbQxEvxZ3c6OUn7C8qSjfTQEstMb+/S2Sm7V/cwtmLW7HSXBGrwadGj0VakQbuLXD0+rg7pwuCVYMCtAJnuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6997
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

V2 changes:
 - align the parameters of the function in the second patch
 - add a new patch to support runtime PM.

Clark Wang (5):
  i3c: master: svc: move module reset behind clk enable
  i3c: master: svc: fix atomic issue
  i3c: master: svc: add support for slave to stop returning data
  i3c: master: svc: set ODSTOP to let I2C device see the STOP signal
  i3c: master: svc: add runtime pm support

 drivers/i3c/master/svc-i3c-master.c | 234 ++++++++++++++++++++++------
 1 file changed, 184 insertions(+), 50 deletions(-)

-- 
2.25.1

