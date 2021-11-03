Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495B3443BF0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 04:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhKCDmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 23:42:02 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:4768 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229899AbhKCDly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 23:41:54 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A33d3xu000397;
        Wed, 3 Nov 2021 03:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=Dy6nRXlNiNzo1EpbXAOfeTk8aPp/LSZ0dxrTc8lnSb8=;
 b=DL+Trd9s3XVF0CTUOzD6Kg9Yj0bhDRfgS2DXpAenX+xkHI6MtLMTeptwqseB7ZgkXcwB
 Jwxwqedrr7J6Z4VxbVmWZVsKqvmH2nJaBOAZBUHOFI19bgovzfhz2xAShul/a6DwmQht
 F55gRBeqEaDx+nvSdx+QsNy+RSfM3pkcBp/4R6AAQ9wUqwrPYI7hbEfSUMqjXwq8DEy6
 6x8GYwJ91b7RuN4oXEqFnFv4fHWAO2n+H+quGeAPvVmBX1Oz+LeSPAg/J5EuVBlpc45r
 nm/vx4f8N6MCdHkwmE+R26SadOf2cm8SiG1D9Amg/Qst8ZeUkBfLZ7XzUZ119WmjHQ31 wA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3c3dde86tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 03:39:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVuudvvHU8gf8Uya0BaxlWYMZ/K5KSAxjaGZ9zcEXY4NocdzLQAx4ZCEgOmSMPMtcs+pvOrZ9e6Mqa9RyNqqFWKrdb6CoTgbJaxgbiH6kVExUn/7tu6fnmnpnPZOvJlgP9Xj3P0Ny+tsOoCXrlwzxKP8wiw/qhJfD9JSpGWghBnGwgHAZTPqj44lNSTl3jkYWddHBUso6uJpJcwOJlfUbDlqNZcp1P1tqINw1xCpjZ60hiAMwjKkW3hpHDAxP+sr9TO7e6GH7GwEFopAFjAVLHcWvlbEXwmBzB95WEhgFOFuH4Ba3+whKqdHE5Yp0mZ6m5JMcfzR0H36mmbI87Ov5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dy6nRXlNiNzo1EpbXAOfeTk8aPp/LSZ0dxrTc8lnSb8=;
 b=OeX2QUr58/jy+iy5wCjDQcv4ECQP2FYzLMF/ZgoThx/EfHL21eRn8HCXw7zcqRi4l71LNTukvoPW4+9a9g2OEEpjmaR+h3uQiZH+LYF0UaDWG5QIgCch/SYsnRuP+TYZl/EYJCu+wfokkuYbCT2gJ+PAAEG7K5yFFABZeZt8sAKRDuBX8zrKqyH7ZyvpjJU8D1S4Rb2L8XP7GMnqATXjkIt4OT9jmnQG7WSuFks6XknwTg4pZqGeXPhaghCAkl8ANvOt9yyeJL/KBngLg/jwHd2hEdhfcSBIlF83MUxzdiouerhAJZMa3WQznmnn36nPk5QN4ceNCdfUa9Wug+Czzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB5879.namprd11.prod.outlook.com (2603:10b6:510:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 3 Nov
 2021 03:38:59 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a%9]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 03:38:59 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, meng.li@windriver.com
Subject: [PATCH] arch: arm64: dts: add delay between CS and CLK signal for flash device
Date:   Wed,  3 Nov 2021 11:38:38 +0800
Message-Id: <20211103033838.16015-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0014.apcprd03.prod.outlook.com
 (2603:1096:202::24) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
Received: from pek-mli1-d2.wrs.com (60.247.85.82) by HK2PR0302CA0014.apcprd03.prod.outlook.com (2603:1096:202::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.5 via Frontend Transport; Wed, 3 Nov 2021 03:38:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23d54d40-cac9-4323-cd90-08d99e7b787d
X-MS-TrafficTypeDiagnostic: PH0PR11MB5879:
X-Microsoft-Antispam-PRVS: <PH0PR11MB5879241371FCE9863343A6D3F18C9@PH0PR11MB5879.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtbXWfIKt+h6XifVQZ/icn6QyefrCn1ub72dJOuwu6u2eoi6LrToy8UoEy9HFqjXvJ/VX2D8sLrgRHCJCiMifxJ6PUP7dNdqc7t4shlurgL5hbiB+eOIy4S8XS32ObzM6okFXXo3KRnnUeD3QYGTYgO1X5XlwhPmKowlFfU5K7KjPvNLxbobmKdZK49Ny2tJXNX6Jn0gDV7lx4D/7rcR5ioX7iX/OW2iGeeabXAwSBJCOloRuoAJ+MsvRCmw9DTxtypRu1zLnbEvk1HbbxmPqdUhXG0a7KW7Qx8WmsiMY6X1/OQS5Y744xFOqg3KMVJCY5QRIES+tGZd0viGoi4kC/uSj2OiYi1HS9C61Q4aNxZaK+6w9NzE0rwoqVbzfjw+OKL7iedLoPD/hbG2cUNMti9cA2cygwC9Ll+tWN2ZdXXUh4U24SVvK1mdAUD2ivUD2h50OuiVcD2puwOLC55GhhEgKTeFcqCyPzaoDSgJDS+AqbV6BE7QlpbcO3QMMNAhJnswFiIAmOXOYVa/F/wp2pqa9ORqXud/m1rQyxIjpKj6hbHEvXCQo8vSDUQURLdCu7Y1LqBV7WmQ3kj/G2Uv2HaKl0qgcdcrHNufka9yimpD2Q42dQ8/wZWfnGt4fFg4zrs6of5NMelssaR8wGqWZM4UXrM8BKAUik5hEKk14NjfR7jCFZ0PXqPsEpeLdxM1DdabETwinhwToxjJzMpFwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(36756003)(52116002)(38350700002)(186003)(956004)(6512007)(83380400001)(66556008)(66946007)(66476007)(8676002)(38100700002)(26005)(2616005)(508600001)(8936002)(6506007)(86362001)(4326008)(6666004)(1076003)(316002)(6486002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SYE8NoakTnXMAYYgjom5pxJucEsO41WZX1AEpnG18wC31drqgXd3kHnuihHm?=
 =?us-ascii?Q?zfsDpYJNkkKtE6hep+zn2OtZboNkmtAuDEbqLghpk2uAnqbyzjBcsBQWTC6n?=
 =?us-ascii?Q?vPwO7Gzvo3EVVYG8SgDWXiWfykz4zkDnVEFzqYaDU7Q48J6r7OSs0ajf2UPk?=
 =?us-ascii?Q?5N2x1U29e39g+brws57CFfL7bhqgZuyJ0aFC96CjLj1BLQnUAI9hCRCCwuBl?=
 =?us-ascii?Q?0s845CLx6k15IzLAPXlU8oLYjQWWuXPD31Gwcw8gm9HpxmkC6dNOByBkthsg?=
 =?us-ascii?Q?ht/iIxkAQ0HDvUt5BsDG17D5WklFIrwZ+oKN0XsYeiF/ly2+6eXASqwb1hU6?=
 =?us-ascii?Q?lrQHNaovYXouVhQ3A044bDpARQDUmmhFKI3eXqJ+VNysyFV3CmdtMLDq3Qgq?=
 =?us-ascii?Q?i5gUwGgCA6XKMouddayjHExSXE3geuRgiACfz0SIPmhSbEw9J87ufZxh+A+s?=
 =?us-ascii?Q?jUoHW0T7uVRP9HGvT4yi5We0QIwkevTlDlBJS6G001hpcNtxw6lPy526aJBd?=
 =?us-ascii?Q?b+4Oxvuu/AZd/6vYXyek2b32mwVMkzzte8oAlEfX/ds8VFM4ql1OUXYno52q?=
 =?us-ascii?Q?b+H0AoVhvQrv66db3IrBeuxuPuRYC7bCdt4DsYLYIsezWO9B1cnjWRRDOId7?=
 =?us-ascii?Q?XO8BuxiF76qBlWle8GgoS1cmZLyQoKdJ9uvtfnoPMfwhO6h7HKfiMvYruyPJ?=
 =?us-ascii?Q?Vm6A0lAd5928DBx5KsGx2Q+zm6/pKs4SWZxmAcMlKr4+lHHpSI0hh1W8+54V?=
 =?us-ascii?Q?70Z5HD209jwdK6DvmUyWsYgOfiHYNH06jwy3NbeQoD3moncS4AcWTmt2e7lJ?=
 =?us-ascii?Q?Jdfa0Bqb/SkPg7DW9kuzfhl4yxRQjWpUQrampCSOTXJbR+9SWr1p7mwUFm28?=
 =?us-ascii?Q?5P/wiXRFc8nxo4ApQ8E/1MTpv5GLTnOqYfU+9S/uyeyVvciTf/lpxcUl4/tQ?=
 =?us-ascii?Q?+JDq7jOEi4BgiW5yYLkYVEAkLLoAGHVor9FDac0xu/bWZddPdr5yZWQ0E5vj?=
 =?us-ascii?Q?yi3mAKTB38kwxlLpEvuWaSf83i9aiDCDY0Y3KSswGJET6pRA30HENLQWOb2t?=
 =?us-ascii?Q?uXeXMSponABNqMH/dzYLoNwMlVKZPqFpEQqUp7jJz04Z/SjXE4Lhdd2AwNSc?=
 =?us-ascii?Q?38FYcSZWYie58yydfpWoDgwnReVocptZF4KnDnr9ZH4PnDxfZQ5sXPiA6MKH?=
 =?us-ascii?Q?juVeYhkrqt4+Npp4qFBUTneUD8tl31Bk88+6UCOXbpbCpikScpxSd/W6QLfS?=
 =?us-ascii?Q?rG1pisbiQOi+Re0ExUZI8hBexPe+IZXtjBPMyE+cCT2nOYxpUDMBuOSDwimS?=
 =?us-ascii?Q?JLoq6y7W+N0Ft61XoV9cYn0J95CvUHJNefPp6tOs2HL+LUV1+qDEqBBNdxT1?=
 =?us-ascii?Q?TXYr+82Dz8rF88CsxI0U9dqWL0WVdUzA0a6Lx/pcizKXUA7pS9ZPBlLODox8?=
 =?us-ascii?Q?PfW9xnoOh80y8o96ubN/HJMn9921NIre9fCqteGDOktpEqj7leZvNnLvK5hf?=
 =?us-ascii?Q?HOCL5MbYs4+PQYoUXUWuxTt5c919wDfREIKnYmMEC616GkFVC3+Cq3NQUu0l?=
 =?us-ascii?Q?QSw8RAn8RhqVuw7GJfxZJuQaHX9O2oDjJVDmAg2YJ8YSb/vPN7Tot1Q3WHy6?=
 =?us-ascii?Q?W+3dZgpe5ijQ/odV2xx0zoI=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d54d40-cac9-4323-cd90-08d99e7b787d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 03:38:59.2926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWnY0BU8Gx7i3UgTtp9lHnp2FZm4pKIOwshMBk8OeLHRMzrm2Lsm23yhlH5b9mX4yFxjKkJouXGP/tQo/XI9TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5879
X-Proofpoint-GUID: X1ZhX__MB63SWaVoEEiMM5Sn8_i0qK1J
X-Proofpoint-ORIG-GUID: X1ZhX__MB63SWaVoEEiMM5Sn8_i0qK1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_01,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1011
 malwarescore=0 spamscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=809
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on commit d59c90a2400f("spi: spi-fsl-dspi: Convert
TCFQ users to XSPI FIFO mode ") and 6c1c26ecd9a3("spi:
spi-fsl-dspi: Accelerate transfers using larger word size if possible"),
on ls1043a-rdb platform, the spi work mode is changed from TCFQ
mode to XSPI mode. In order to keep the transmission sequence matches
with flash device, it is need to add delay between CS and CLK signal.
The strategy of generating delay value refers to QorIQ LS1043A
Reference Manual.

Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index 3a669238a0b8..3b1a31a063c6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -98,6 +98,8 @@
 		compatible = "n25q128a13", "jedec,spi-nor";  /* 16MB */
 		reg = <0>;
 		spi-max-frequency = <1000000>; /* input clock */
+		fsl,spi-cs-sck-delay = <100>;
+		fsl,spi-sck-cs-delay = <100>;
 	};
 
 	slic@2 {
-- 
2.17.1

