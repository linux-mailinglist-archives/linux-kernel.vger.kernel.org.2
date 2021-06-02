Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500B439859B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhFBJuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:50:12 -0400
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:23975
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229878AbhFBJuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:50:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aec8GtCuo//xJHJOMGWE0Y75WgXDi6E2EpPy3NZFAY3sVP5FjnzoxwkNvKtyWpq1ryjV1kpWJq78RVBhvQADunHKnG4qf0EOCj08Qy48JmhWP9HiFnav3xZHNn1Y0eD3UtEy8KfZWpMr4PLeIw+cBG/QSepqWgLOWln3COhh/fNsmWMm6UsfsxYiuagXGNoSlcYKnJTt4AHGq2FoCzXxF86xN/LAqgoNT26ih+yf8zZwsQHpmAksEpFVsU/pDG7iQPB5leDyoziIcNrXkBJuxtEznmDfB/gVcLssiFpbEpvRWvQ80YDZt95IM0ccXbnSOkFjm0cCJXzOPKSu1zI1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bL7T53PvVpvO3UpXXucZvVBX+swtQyFeUTe/p4Vpco=;
 b=AyCs/ek0J3Ni07Uaa7cn62wkUquZp7jhBtX0m0vT4xNPP8QdYR40GxigmA7THvAmEW93x6+Qr78NfwMFVYAOQK3uAbV90p1QZd/jkxjQZvScUo2f86yfP3Qz+naQ6rrwgDZAM1TLFodwUrWv1vPkutNKiEYHL4lt/AoB4scZ7NIbxemqaBm0zvwavfy7mRkU8lwx7Y79zu1R+k9e9n+o+O6v7S/ZRez5UzoXnqIixZHM9BXPahiplfvlox2kG5NumgNLHNKKjqLMtBeQ8lXE9A7lINeiosLp13bc23gZ4b0ZOl+9bvsZyud1C5xPyDBgcI2n6S8OBrsuO/H7iIS32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bL7T53PvVpvO3UpXXucZvVBX+swtQyFeUTe/p4Vpco=;
 b=AvzlRLArsRr4oi/+0PD0CVso8SBbECuCgRYSqvRkuGc5IW4u3nbcdSZBa0Zh6uHUWZjr/uKHcMDlHXhwZZ3bJsv93svoXl202Zlb7En3qgyZsDHiSXna7AXylvhaEf7vMo9uhJ4zpz4wecLPC19h/zntDOwltjMRXkFUEs8bOWw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com (2603:10a6:800:57::8)
 by VI1PR04MB4000.eurprd04.prod.outlook.com (2603:10a6:803:4c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 09:48:19 +0000
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::49a5:9:d201:2382]) by VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::49a5:9:d201:2382%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 09:48:19 +0000
Date:   Wed, 2 Jun 2021 12:48:17 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/7] arm64: dts: imx8-ss-lsio: Add mu5a mailbox
Message-ID: <YLdT4efsABJlXwpt@ryzen.lan>
References: <20210517171205.1581938-1-abelvesa@kernel.org>
 <20210517171205.1581938-3-abelvesa@kernel.org>
 <CAA+hA=RhJ56aQdndPxopXCeQf9UK1AMrLy0QXAmY8Fs7UJucrg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+hA=RhJ56aQdndPxopXCeQf9UK1AMrLy0QXAmY8Fs7UJucrg@mail.gmail.com>
X-Originating-IP: [188.27.175.31]
X-ClientProxiedBy: VI1PR0902CA0054.eurprd09.prod.outlook.com
 (2603:10a6:802:1::43) To VI1PR0401MB2559.eurprd04.prod.outlook.com
 (2603:10a6:800:57::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ryzen.lan (188.27.175.31) by VI1PR0902CA0054.eurprd09.prod.outlook.com (2603:10a6:802:1::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Wed, 2 Jun 2021 09:48:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7187c229-b7ed-49df-ccfc-08d925ab8d23
X-MS-TrafficTypeDiagnostic: VI1PR04MB4000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4000F7B6CA2AC5E0E9845C76F63D9@VI1PR04MB4000.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tw9xzUXFcVi6gmyJcjPunDg4D/CqQDgEBZgL/8LFWjiY/KmiGAtTkZIUQf6hqHDs0htlZEIZS3i1Lu2iD12XPzdFAuOWbw3uJsvHQCI+zQax0pLNt0leM8rQ3ip0dbiuK9I/smB16LOJnZ0PTfd5zd/i1hZQVOyCVmy8rLa3w8GMlQX9RCj42HsVYznGmhkl6CTq42FYWvd+KffltM2u1FDQJbjddoJ7I0guWPTVeXs1jTYoc/leCiUYAfhms11UQI9X8mJuM8w0OGwIbs8Sy9zpBSoCmuU/hF58n/+UBMrwdmWV+4ixPcryrm1cJbiT0nQ6T5eTGMYUxPqtc7Zzzs8eM8n4Cwm9f0acC8Qn/g7FYREAg/VdqCp7YPasPSuz4G1m4vzEWju+9A69Rl2xrxHJGRVUZwsSBT2TKVIG/559RrVQjo/UMxejhGG+pP8C/Ll0oYtyaqPSSMD2Z3sjolpR4I2ddeuEiaqTvCsq1RjlqneKyEw2pXTJZ266Mi2XaP6Gi3NkBC4tYx2GWwGW+8cZ1q2JzKDxTTdGAy9QqnYp26CN/yQTBraH5NXNvDQeRPgya0XWF3rs+n3qcUnO74+62x/iRkTJXLbQxCT1DyZSaErs8Yd9at2lzXf33HPNFORCcCMK0XGnuglCKWQ6GNwuq+AhlvRA7PqRzp2jV0KiNjCrIbBjvKA/BTVPLSHwN2q1o22i3N5XfXDdEaupun/GO3QcvFaml8+tGgSy4W1takhzpfntRmuk60BUwarXR4M1afsKuhHCNvU/LM1b4+TvtfHWVZsXhJ/hefF2WM/l6+31fV85ydXOok9Fl0ZWFSuuR9x3zKErnFGn8FCLd7JsiKoWob2WJBb6WSbdiwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(498600001)(966005)(66476007)(8886007)(45080400002)(53546011)(4326008)(6916009)(8936002)(66556008)(83380400001)(36756003)(38100700002)(15650500001)(8676002)(38350700002)(9686003)(186003)(16526019)(54906003)(26005)(2906002)(5660300002)(55016002)(44832011)(956004)(66946007)(6506007)(52116002)(86362001)(42413003)(32563001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?C2v1jmewZgw/Rl4xZjUbpRQcongU2pC/TDnAFC+4HcCbG9gttTTSh2UmvjNT?=
 =?us-ascii?Q?fJbeQfAHBluRZ1yK0r4TWoX4HDyreW82yDfuIYb0kfbmzmNWyU3tJb/3JCz9?=
 =?us-ascii?Q?jsm2GG5ZMQrojpfJWF7PmEebux6nJ6Ufz2Jz/sWgQ3OO1rLScR4DWeB32Fh7?=
 =?us-ascii?Q?gzU2IIMtSf0nCwcZRlG2DeH+kkQtIUxF8fwdQxAsx5494cbHpCGE8EDSKP0M?=
 =?us-ascii?Q?OP2Y9YEYZurlRyXwmNFXxDgwa+oGFhbkMyVxy42UidSDg9yr9fjqgA1ZWYkh?=
 =?us-ascii?Q?PMRpZyeh6VL2vMgNpPYQrormvtz+TV90fWeNrHVUaxhnLOOMk+jXVlT5Cdkm?=
 =?us-ascii?Q?do6XBUJ+ghiHwjpQzt+nRjqJLiLeYvmJsn651Y0QK/XxpchV+LdkD+naRsqV?=
 =?us-ascii?Q?QaZd5T8huIh0GbFXQL0J7Ooxwy6Byrn8GQeR+/xOTRio6JLtvYkfexeJOfVO?=
 =?us-ascii?Q?phN4MV7eTwRznODVQbqa7u/dB4ozQJyODlUfmDVw0MDUoZh5V+XcbUfk8U5i?=
 =?us-ascii?Q?9n8z7yeDcGnKrYf1COw9WOzbuYdqp4PxSLcKQGL9VBGXguZaCkXCoJhjicvu?=
 =?us-ascii?Q?iwSnSzEL4gvgh/keVxZga1jIjiFMVPz9Zj/2H8y40G6UVK0s30RVSgvZQ5DY?=
 =?us-ascii?Q?pTbXw/4sKmXAWcR/JzPgSToHuFXWN4A7gwJl+YIZE9nBimmyE3ztMehBzVJg?=
 =?us-ascii?Q?FWux9CjhGFnZNZ6XxRcwsHfKhNswSIZ/CcJQCP7QdjLZu3H1QvBP8l/+9i8q?=
 =?us-ascii?Q?zNNhRcxXldg009tF4HpEwGKcNLAaFJoBV8GUFsYh0tk+qDkIJDBI19m+sFCc?=
 =?us-ascii?Q?iSaHtKTXgmNaIVQ8aG0RDfLqQI66ORfd5/skr+SwWsVu7R23da6C8Yjvb+HO?=
 =?us-ascii?Q?vZK/DuhutIqBVI8GzYXxZ3JUeLE7EcC8Kn4ot7mHom8IWu5d/oMTGNeLpP+d?=
 =?us-ascii?Q?WbPsdJ0Vsmy0RcbLi0KwCx4PFtOziEieBXDM/0sBOe8GkX9Jtntaqy2LHkS2?=
 =?us-ascii?Q?Ys2PTT1LoW3neUMDFuk34dgQ4DsUBDuTMaV2iu5ycYts8ZIQnyCXJqVZGlEm?=
 =?us-ascii?Q?MBsxHQNMxQsa+ZHcVF8qDUTf0G7d6RSAQvj8GeAO4jmxCiWhAMeumdadEhXw?=
 =?us-ascii?Q?di0QfXJ1zvozG6zqwiE/ETmjdD9m78zq7wGRUOMiUNXOeI4yAUd7ral2Ci9k?=
 =?us-ascii?Q?tF1rMai0/j05Cp3plsWpCWiudSk/hButn3kZ4xzsQX2KovMAacsJdCHBA30H?=
 =?us-ascii?Q?c1FWo8zyEieqriqZiSBPf1/v8cJFTkQ9aQK+L3SVyxIysr9iKfZevOcTcYXf?=
 =?us-ascii?Q?0vk6AShg0STwJWQ51JTO1x2A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7187c229-b7ed-49df-ccfc-08d925ab8d23
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 09:48:18.9124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yy8cyXykaDOgQt5zCd5ZYeQOKX/A7dL38JquqwvEEO7NzBpptCmsOAQDLRABcL0dm9lqkoOTtR39Y4CtD+A7qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-18 15:50:51, Dong Aisheng wrote:
> On Tue, May 18, 2021 at 1:14 AM <abelvesa@kernel.org> wrote:
> >
> > From: Abel Vesa <abel.vesa@nxp.com>
> >
> > The mailbox of the lsio mu5a is used by rpmsg on imx8qxp and
> > imx8dxl platforms.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
> > index ee4e585a9c39..8e3c92c82fac 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
> > @@ -141,6 +141,15 @@ lsio_mu4: mailbox@5d1f0000 {
> >                 status = "disabled";
> >         };
> >
> > +       lsio_mu5: mailbox@5d200000 {
> > +               compatible = "fsl,imx6sx-mu";
> 
> For normal devices node, the compatible string are prefered to be
> defined in soc-ss-xxx.dtsi
> in case to handle HW minus difference. e.g. mu13
> 

Moved it to imx8dxl-ss-lsio.dtsi.

> 
> > +               reg = <0x5d200000 0x10000>;
> > +               interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> > +               #mbox-cells = <2>;
> > +               power-domains = <&pd IMX_SC_R_MU_5A>;
> > +       };
> > +
> > +
> >         lsio_mu13: mailbox@5d280000 {
> >                 reg = <0x5d280000 0x10000>;
> >                 interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
> > --
> > 2.31.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C868b5c19cea64f7f3e4008d919d1ce23%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637569211161280172%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=z2cyzPRkkbHM8LgNIW97x5iPn%2BOjHlqSUvAaJ6%2BAOck%3D&amp;reserved=0
