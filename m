Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42643E144D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241210AbhHEMBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:01:40 -0400
Received: from mail-db8eur05on2079.outbound.protection.outlook.com ([40.107.20.79]:56513
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241200AbhHEMBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:01:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ix8h682hkkGkgyck08tqDBXCsOMf+8tdNFT7fvFf5S2wWjHa8nryNlxW1cxgsWDFr4HsYgrmkd0iADxBK7uF54aWLwR4wcQJLoARSyx3xsze9PGFDOVSXwoi/jB8Amuz55651HEDVF1/4QKHNmKSySadfllwXGl3+H8uDrhSERG4TnNzc+HgqBCs1Nn8+F0pAhVbGnNqz266lUBmb5MrOUgmuKapojCpATYBh9tA/heIXQ/mN4yOvFtk5PnLUsQKPYHFqFcK5JzVJdnv7VeAd/+XmP8UY2oKF+Yfp/2BY9KH9uH5w2nOIrdCF2w/2QJ2BcnUswG+9uBM0cB7NR5NrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbNmv1dKQqenT4/z6Pyz+XBdCfte2laK0vwKb1RibiU=;
 b=NkOMx8YGoNTze5/VA4W9CDe7ZCiCm/18CiDSLD4e+UYA6k3ugd10u/z32btsF5e3hvF0eLHJcoD42OENJUd96MLbq9JG8tApPkSBPGEa1NiKdXq+w1u9mXOTYrOhLj7DecLGA1rUtD955THOSjTba6ipA0aM8I/UkowqB1Oedztof+0qVmXi3lz+V4fppfPo76pLNuYsYris7va2Ca4oSZkhSF8pBG3eLYdQ9RmqVtvbf08ia8CuXyRSC3crdQgiig2uX/XRA7RQvP5N60dM5fKMX4mkpUcSCslQk0IiLzY0s9wCCn+l00kLv0/rR/9458aQHMMgJd0RvR5wORpjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbNmv1dKQqenT4/z6Pyz+XBdCfte2laK0vwKb1RibiU=;
 b=hAroyF9GEe6ARPTrMxGKTJCUwIs4lDsJULRBp6Vjd70g8XQUdWwz7MUblUT25UA3xAT2x8B1L5QAIO+KfWWHhEiUyHSi/jRHOXe7wU1PEmKerdsp22DRZ4v9vVatlhOWpfoLKIAKaq8Q8Bk6Ia2EptxP16oaJ/XOP0YiF0iA9gQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB8PR08MB5419.eurprd08.prod.outlook.com (2603:10a6:10:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Thu, 5 Aug
 2021 12:01:21 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Thu, 5 Aug 2021
 12:01:21 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Simon Xue <xxm@rock-chips.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 0/7] arm64: dts: rockchip: rk3568-evb1-v10: add sd card support
Date:   Thu,  5 Aug 2021 14:01:00 +0200
Message-Id: <20210805120107.27007-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0099.eurprd04.prod.outlook.com
 (2603:10a6:803:64::34) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by VI1PR04CA0099.eurprd04.prod.outlook.com (2603:10a6:803:64::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Thu, 5 Aug 2021 12:01:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e943e8a2-f453-4f46-8e38-08d95808bd90
X-MS-TrafficTypeDiagnostic: DB8PR08MB5419:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB5419DA066FD52A26C48F750FF2F29@DB8PR08MB5419.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4MagEKqcTraJ4p1q6NauMlPLiOVOPKDiZLS0UH1pbVIMeJPelINdTsToBygxSsueehgYpaG/OxTzbC3W9gmyRH4Xs5V2O4+rA4dIJNxYwK0IUKsUOCrgxXTTdnWEqQFhpbqnERZII/brO5TUvZ5WSD53wBQ+ei92EeEdlVFTYYGVLKOqwFrQZW/ZAzoQgd99IIr0D5wBgteyKPbCmF/Hn7FCA2wXwjY/l0M8cUIPYCpOKcLfr44UJYTiP0homyFpcsyA7XwUX3e0IgM1gi9DJ0rYenzvs7ATWDfdaNKXnDlHf0lv5twb5eCYpjeAVrFS9LbzGXgA3rIpWhKgY1h7uCU0BHqX5m6OzJ0W8b10MSc+q6+rbBJ/OGB5b6soS25lLRFV0U1qiXInWcy+ZOa6nM2NPktEs9VPE0MX5G6yvR0LuT8nWxQcDG4ri8GqmHh1i8W2bg8JjZC0S5sXshjDnsCtzjjdPeDuA9ZR5rfet6Redk+il/Lms3Je+61ZurUGPIdxrM3mygc3nfVX9f6MkRbnWEcUNLqy0Ze9ZBVSI9ZP6JaUvM4Q9YMVe4gGn1jk88D4wnC/JkmWZT8q04kHkGk5jKeyUVDb9YeE7G+6gsa04LzjEKJOoBNMVbkFKzVHXAbfBJE97uOBtbc45jaaJCxspVzgm6IczH0iftNlzpOTH9XWEwfCilQ544OmLKOgYXOgq4Xh5B2RjLhdjE+9alLb//NVJ2SCXYAVikk81J+RKD7XaH6BP/T6WDBwcQCG2VeSbd/eXAgaMzpwdc+Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39840400004)(396003)(376002)(346002)(6512007)(8936002)(66946007)(38100700002)(7416002)(66476007)(6486002)(66556008)(52116002)(1076003)(2906002)(8676002)(4326008)(54906003)(478600001)(44832011)(316002)(36756003)(38350700002)(83380400001)(2616005)(6666004)(186003)(966005)(6506007)(956004)(86362001)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UXfNlArduJNYkdSl3XHGPPkwJ1HJYDBPueyRrP44sycgVxrtbPm4nUw7jnFt?=
 =?us-ascii?Q?zehLy77IimKeznxreKctI8h2UzTpUiqdwTE/SAp2K6AYh+AGvy2pgjJdTnjn?=
 =?us-ascii?Q?yblicJAwVNmp065O1YQqriu7xq7XsmumaIvnUzNNFnVLnD0umrQNZFY0N+Y8?=
 =?us-ascii?Q?b9grvzLZ0DP5pFOtOMCGmUfagd1WnUO/qw3ykjgygrlix8/ZEgnAue5QSymS?=
 =?us-ascii?Q?pbv7DDfQsFayX+PJ8dtpg7WAsHEq5VS/EV9AFUl6AyJMui8AKLpUm/FBc5hM?=
 =?us-ascii?Q?HwA/sSc8tH8Kt9SgyhnkORAnoJiMGKJvSJLeagBC48+Mcb1ST+DzVBHIxw6e?=
 =?us-ascii?Q?pzMzOc7zvDEV1cjCU4DGZrPaEx3Oiy9c1nJVBhSjUPDmcSA6ijnCc1DFeHz5?=
 =?us-ascii?Q?Pv6qyjQLAC01DZ6cPTK6Bkw/M8G/kag+FW78lhmJIFALPYQ8G2d9FaZ+9mIa?=
 =?us-ascii?Q?Yo2G+fvFOOtKD9snw35JJCkcdfql+eiDGRnufet916Wp3j0puvxnU80b9aJj?=
 =?us-ascii?Q?aaS6Bf4y4KKJsA9gkvCer1Av3SHdCs/kZGEKPP58612RgQj+cUa+JK3wvGqy?=
 =?us-ascii?Q?w6mTH7+Pkw/0ANwjIPN9jAJIo0y5ywUZehz9NvpS9AaP/7V/SWgpIVNcKgBv?=
 =?us-ascii?Q?3w+WCqabdUQK1HroidXROq/HILGdTnZr3dBo8sOwraqtyI0e/H74CxovO9EU?=
 =?us-ascii?Q?RlM8ja0G7v2frUVJJL7G+gXz/8qj+7Aj1vRJOKViUGMxkdb5k6PNxbxKBDUv?=
 =?us-ascii?Q?jiW68TYyVcGcLcqWvJEtGiNoOnbgyfBvqZOP2eTSDp8daUx2bE0U6AxfJa/5?=
 =?us-ascii?Q?fA1C3A5TS046dnWBhuW0B3n//t3HoAonzZQTEnYaxWdLT0bafh5bsMPR5AT6?=
 =?us-ascii?Q?K/hjeFinKwdl593fwHY0m/V8hZMc0mrvl/WdUL7I6vw4dGcBo5OKse9Afb82?=
 =?us-ascii?Q?Z1LS0QTERGj7eQAL0txKin7b3cM+c8baziVJJuqPJNy2YtwdaAs+vHpgeeZq?=
 =?us-ascii?Q?N8s2SgXouyvslFkd3ItZfUPzfuH2arCWzzm3qXQ+cDtJ8eslk3pw5Uty8Ab5?=
 =?us-ascii?Q?Zi46MN7Wo8TQ1ntC24dZMdLR6ZETWRdpZPfY1HSKjWFKwIArMIXKeeZDJ7Zs?=
 =?us-ascii?Q?rYSY7+wAelz9YYBH6TVVJPoFGxgm14JxIecPo7BSArELH8YaP109Xsf7xBHQ?=
 =?us-ascii?Q?DjYLuOds69Rf9CrNqyb+wdMYf97Zi6vqmTuv71Zko6See8HlUaUuRuhiiejT?=
 =?us-ascii?Q?WY9uyl6HdJBrRW5nro93iMxq+VMEt+qEvNXsddbJXHh2ikC/E3ohpzznYmVR?=
 =?us-ascii?Q?2T0K3v9EN+pzMhkfmumFhA01?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e943e8a2-f453-4f46-8e38-08d95808bd90
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 12:01:21.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMKVDyed+xLUaClfCiU+kQSUTpqw/uyhfo3EQHv442AZyZhJCc2gCekbneP6r3icGvyIz4NWINUU5Tfn8EnSQISnZbUVt9TkuGjHdCjGRi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5419
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series enables the SD card reader on the RK3568 EVB1
and completes the support for the on-board eMMC.

As the PMU IO domains are required, the patch series that
introduces support for the RK3568 PMU IO domains [1] has been
revised and integrated in this series.
Additionally, the required voltage regulators of the RK809
PMIC are enabled.

Best regards,
Michael

[1] https://patchwork.kernel.org/project/linux-rockchip/list/?series=489383

v3:
- clean up device tree properties and sort alphabetically

v2:
- rename alias to match convention
- add support for rk3568 io domains

Jianqun Xu (1):
  soc: rockchip: io-domain: add rk3568 support

Michael Riesch (6):
  dt-bindings: power: add rk3568-pmu-io-domain support
  arm64: dts: rockchip: enable io domains for rk356x
  arm64: dts: rockchip: rk3568-evb1-v10: enable io domains
  arm64: dts: rockchip: rk3568-evb1-v10: add regulators of rk809 pmic
  arm64: dts: rockchip: rk3568-evb1-v10: add node for sd card
  arm64: dts: rockchip: rk3568-evb1-v10: add pinctrl and alias to emmc
    node

 .../bindings/power/rockchip-io-domain.yaml    |  30 +++
 .../devicetree/bindings/soc/rockchip/grf.yaml |   1 +
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 251 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |   5 +
 drivers/soc/rockchip/io-domain.c              |  88 +++++-
 5 files changed, 367 insertions(+), 8 deletions(-)

-- 
2.17.1

