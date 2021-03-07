Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FFE3304B4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 21:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhCGUyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 15:54:09 -0500
Received: from mail-db8eur05on2065.outbound.protection.outlook.com ([40.107.20.65]:51808
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232819AbhCGUxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 15:53:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnFCUwuDsxF+kHSPRwxMhRUVZP2BkBCBxTH3aMq3cG1m4CeOWc0bgZewY42OZOQcdB+CMi6MLVAfsyQnpaAkeT2JV3dRh1Qeu06Z1OvEh1b9rA3jOEZ6goUXWibKXm8y3KDxOAvvHBxYX7HqI0YPKApH50sSCmmHvcrdIFdPLTqbIHh0ilivGTFS31GwP5HnS9p50XNGNJnEN7sXwkm2O8eOIYsrf3JsQJWbZr/u51IO9jcLwkI1SS4vMSJEBV+CHfGS2hvidIyLT2QruZGMLdo2M2X8Wsiwbj5mjqr83ELWU/Wc53T/gO8YpqigDUIlfgmyoDvn/k6FWMvb2uxsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC//N2p8nzDSiOG5L3j5cvhm5Wpne0dGgqN2DwlVBUo=;
 b=Qg4bkQqdotG++IEwjaJsajUHz2iDKOLTqJt3yjUaGgAGx0v9hLnkZQyD7pm0N9W5VyAhpufLJP8/Z3kxtqX8AH2uYZHoPt7Jb8fYAAI3O2kHKRsmMXEx+1oKaIyHjNby0tP3+8Pky9TQ0rVvLIAAHychrDBhKrkeAd4yYmtarbs40Dy06+7Vws2CDU/s0hGK7obrRNVr0QcB93zlYCtT3mVIyiwq41+EHBgKyQ+yStYjg/caUEhFn5OW2XzjkRJGWtx0yO5HDm1iAXJC47lS4DEj11l5QpnGG+FUcdLDQOs3zPSKYAeOzoLx0pPRTi87prrmpmbC3iT5xKdT6Yw5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC//N2p8nzDSiOG5L3j5cvhm5Wpne0dGgqN2DwlVBUo=;
 b=UCXH71YbzMxLYWmVsA8qASr16Gie6zETEZ9cXwYLK1xKwmer+dPiOjs/W4ocLaGqnJOG0KCxwB+LPRk61QOClAUdlupmRFw9duG5pIzvWDQe8MAK78pE4vG7M5TF87zxQKDeFlJ79PB8vqDM4xlRFwkMoNIweQDi9h6lgFoZL+M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com (2603:10a6:803:4d::29)
 by VI1PR0402MB3792.eurprd04.prod.outlook.com (2603:10a6:803:20::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Sun, 7 Mar
 2021 20:53:37 +0000
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::29a6:a7ec:c1d:47ba]) by VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::29a6:a7ec:c1d:47ba%5]) with mapi id 15.20.3912.026; Sun, 7 Mar 2021
 20:53:37 +0000
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Greg Ungerer <gerg@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: ls1043a: mark crypto engine dma coherent
Date:   Sun,  7 Mar 2021 22:47:36 +0200
Message-Id: <20210307204737.12063-3-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210307204737.12063-1-horia.geanta@nxp.com>
References: <20210307204737.12063-1-horia.geanta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [83.217.231.2]
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To VI1PR04MB4046.eurprd04.prod.outlook.com
 (2603:10a6:803:4d::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv15138.swis.ro-buh01.nxp.com (83.217.231.2) by FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16 via Frontend Transport; Sun, 7 Mar 2021 20:53:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a61c280-3c08-4958-5fdc-08d8e1ab1485
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB37927F35525D6BEF59D07A4D98949@VI1PR0402MB3792.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJ9iy1dX6ltiYz/ekWhOOnjmAtM7C+jBsJ8LpR4yksr05Dud/fUPAElUQK1rCY5u/R21ynUL3jBPitFJg7zgTuB+EIFKLSPriSO1H/7C3AX2MUV4WC5Jwg8B9w6CS3Cp4ewgW7xyoIotET+9wYXjyofMvelSZeSqsGN//CFK64Q8VnNUEA9kJw1Q91/vAl20Ktg7KeQexQUEoTcXIK4QJV0FHaXouGxvXR2SUKJfPsPZyUwerjMBsln/0R6N3mAtyqK2j+f0yi8WqvQNrItbTzvdPRUqwWUa9ktRMbS3LH3FX6fnUlVfG/UUpwtZjMKC2/mcW6DED2KlmwG6Humf+Qsdp/1I5WdXV8+4tOzHewbP30e9YCcWenN6Ud93WtQDPw/ZstJKj+0sOsoYZcox3D9PbYCkjFdlaQF11wFWVUXOBZEbI2aIhwMINj3TiLWl+r0/YI/TNKSpxTHCvGC8sZpcl6npKDOwZgzYzA7x5AP+Z3k3xV8i5UspT6erfrOxui17k8mFj8eV/sgpTH+RSo5+yiKfCOwDUVBrsH5A6LKZQ7Qh8q5gKQt/neJq015raFb9tia26Zn6nFMXOUPWCIfTFGzgsR8dZ8v35u1VjmU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(2906002)(8676002)(5660300002)(66556008)(956004)(54906003)(16526019)(66946007)(86362001)(1076003)(110136005)(2616005)(26005)(36756003)(66476007)(316002)(8936002)(186003)(7696005)(478600001)(6486002)(4326008)(966005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aHVnS3lkRzR1YmJyeWJualFVY0JhZ001REJ1cUcyUng3cFZQVldJR0NKOFZG?=
 =?utf-8?B?MUdaWGFTL0pqZUxpWThzQkxBWFhBZ3k0RFJwZis2U2c2cUJyaTFjZElTNGJ2?=
 =?utf-8?B?TCtUWkdQR2lDamhJdUdHTVBud3NEV2x2bHJqUStlZkNlem5SbFBEVkdsbVN0?=
 =?utf-8?B?MlRERjM0WmNLRmYvV00yMGdhM3dpMHBaWm1YR2l5VnJ1d0YxUHlWQk9jMDFw?=
 =?utf-8?B?dW9qcXZ0cW5yb0hOdEE4c0k4S2dKbGpaMkhuZit3OTBIWldlVXFGZGJ6NXVV?=
 =?utf-8?B?TDVpWVUzdVd4aWNlcjllMkFnUzNYdDJsNnBMa1BWUzMwWWRGUFMzbzV2Zlpy?=
 =?utf-8?B?V0RjT1psd0k0cGlVWFZIbGt6OU1lak8rME9kYWJHZjlsUG5FMFhUdmJ0Z0Iz?=
 =?utf-8?B?U3g0KzAraHRiUkxQbENLWVplTTVFZFJSaGN5UmluaUtRM1BCMktoWWo2QmFM?=
 =?utf-8?B?Z2tZbS9ZZHpQd0JWTDYvWXBPcFV1UEF5Uk9XbDdXWDZVbGoxUEptaUJtNy90?=
 =?utf-8?B?WkFiTVRHaUdnRWI3ZDE4UElVK1ovdE5yQ3lJQjFQdGtzZEJkVDI0dFNISmZ6?=
 =?utf-8?B?Q3VOYS9IMkI4YmlXSU5KQWdmMzBZb01DeHg2WE4vN2VyOU5PWVFkRlQ4L3hq?=
 =?utf-8?B?YmlXbXNOb0I3dkpSWkFYV1RCM0tNUzVKNXVMTy9YZjg0UXFkdlcxSWt4dzJR?=
 =?utf-8?B?RFdVN21sWkxjUEpWcmhnV3dzNjhLZEZEekFhZFNWTXczL1FnOUdiQnFoOGxT?=
 =?utf-8?B?aWhjSERoYWVyUDhjT3FmRDhyeDhZdU9rZ1d3c0pqR0F0bXFwUEF5WGdMR2Z5?=
 =?utf-8?B?cEwrRE52TXRxSGN0eG1Hc3prbkpCKytIc0Y5R0lNSVNOWWZuSU03MkJ2aERa?=
 =?utf-8?B?MEJpcjZjN3pMVW5KbU56V3BmWnRSdUNnenhUN1h3S2tOZnhRYlJvTkMwYTV4?=
 =?utf-8?B?OTJRazl2WUpqaVh6MlQySDdpUGozZ05FWEJSU21LNk4vR05YK0lXSTErR01p?=
 =?utf-8?B?YWk5N015OC9BTFZKcFpKbHVzdUtvcDJIRzFRZXkwU0hpY0JaNTlEWFhrZTJh?=
 =?utf-8?B?RFFBZUZ6akJjUDd5R2F6dHozQW9ldWpsQXRkTFNYVzR2M0dCRjBxcityakFC?=
 =?utf-8?B?NmhmN2tRbkEvby9JRmtBMUhGeFhUREpJZUhNNFRCenRBTC9zTGlnNHcrWTJh?=
 =?utf-8?B?MWZwSXBvZ1puQnFOSWJic0JIY1hHMHpiOHZLNDZVMXQ2UVZwZDQ2bWlvU21j?=
 =?utf-8?B?S2ZESWNyVW00WDl4YVFQR3VQbDB6cStPZjFTUUhsZnhzTkt5UE4zckljSklN?=
 =?utf-8?B?YXZlZ3V4cmIyWlRDdlpRR0pJUmhhV0svYU5GekxVeDI2NFh0aVFFWmYrNXNS?=
 =?utf-8?B?ZGROTDR5eFNWNFQwWXhlUExJMElxVnptRlRCZFN4M1F6ZGRhaTcwa0xMaWpx?=
 =?utf-8?B?US9EN3krRXVzWG5tSU9OcXRVNWJrdmNLK01adHJ6ZEY5WjFjRm5Ma3pBNFNq?=
 =?utf-8?B?WGFlYUUxNHFOdFNPQmRzb01ubFVGRTFmUXFzMUkwZytMTTkxS2RlOUNISlZw?=
 =?utf-8?B?bkNwamlNSlVNYk9EWXlFbmd5S0srMzB1cWQwNXN6K2J4clR2bjJxWTlSZDRs?=
 =?utf-8?B?eUU2SThHaDZkeURmOE1wMkV3RzV6c1U3aWhkUG1Sc3pPbytZU1RYSGt0ZURy?=
 =?utf-8?B?SEVnaW95WEF0QVBKaS9tbjVmb2lhUWlTM3ZFU1o3VVdvT2V2ZktCRndDV01B?=
 =?utf-8?Q?JbRX4fI7xK7W3wg3ROhoFAL5oWxsP3ZDQlFT0cN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a61c280-3c08-4958-5fdc-08d8e1ab1485
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2021 20:53:37.6695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjIKWsWqzJaAEEx5L8rFBu01RLfqKfh3eCC3AjM6BnknsVtkx8wScQOcYvnNXKtbTNXhBxKGPAq6kGPEl3qObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crypto engine (CAAM) on LS1043A platform is configured HW-coherent,
mark accordingly the DT node.

Lack of "dma-coherent" property for an IP that is configured HW-coherent
can lead to problems, similar to what has been reported for LS1046A.

Cc: <stable@vger.kernel.org> # v4.8+
Fixes: 63dac35b58f4 ("arm64: dts: ls1043a: add crypto node")
Link: https://lore.kernel.org/linux-crypto/fe6faa24-d8f7-d18f-adfa-44fa0caa1598@arm.com
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 5a8a1dc4262d..28c51e521cb2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -348,6 +348,7 @@
 			ranges = <0x0 0x00 0x1700000 0x100000>;
 			reg = <0x00 0x1700000 0x0 0x100000>;
 			interrupts = <0 75 0x4>;
+			dma-coherent;
 
 			sec_jr0: jr@10000 {
 				compatible = "fsl,sec-v5.4-job-ring",
-- 
2.17.1

