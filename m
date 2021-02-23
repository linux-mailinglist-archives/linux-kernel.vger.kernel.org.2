Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DE632244F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 03:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhBWC5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 21:57:08 -0500
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:62192
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229852AbhBWC5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 21:57:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eevh7tQdYY2HO3VXgQi11WblJim1JOjH9py/kwRPA+xHOYw999OUqd+9eEd343HE4G9N2SvDYGcWUP7jQYvih5iNztGDc2QTvEVMTnKz14EipTAe2ZrrzCRfYsYVlHVlSItKUVbP/hI14r6rDigJEjq/ur7sgRa1vwslMuRFtrjj/CFM7e+oP9AaRq+oIun8tVdC9QrunyLUwry7U0e8iXAaIC5fl83upVWwJKtWMGkdIMVQdzoTqI9y4AOj00vTjZ63iCHBL9sLF7nhrC4B/Ol9eI6G6dyKUk+HCEtCj02JPpaObEr5uScRqKzWDlHaP173zmRjg3pounr6DWeeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPiPwoC3DbqF4vxowice0Y/gPhKb+OKSZm4PqoHzRAM=;
 b=FZxUNUeHV85j0N4ilIWBRa+7ORhY1bfNe3FT+8P0Z4P5mP57yCVgoHkCjL43b9f120vIlRCt099UUwjlIse037YQKHtfrDkBXxzA8UES0Tu/iKbQIli6px9e8XqqtKyybjPC0HfcR3C1Rf8DNcNMW84YO0NZPLNi9Q8E6jsIAe6ii4A0+PDvjQ9RMZv/rVu+MtAPLMK5+zK5q/CNeY8fnjoosNJdkZEOAoKKvnKIK38y2Nt4/bZwIOq0O3XQLTT/R9HbaqE+dnwg26XKpvfm4iPfInYE1+c1OAw0BOEKlbD6EHW96PZUlvIextL2pKDv4Byb0Jaz80C96IZ2UoBsBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPiPwoC3DbqF4vxowice0Y/gPhKb+OKSZm4PqoHzRAM=;
 b=ioYV+lx/wOzGvaG9x7hmWvFz1nKiolX0+GxD3ZJ6uvlRw5SOsX4Yth0dSx72XP0sorbcnC9qX8r8ncSjzCcaq8Sv6tqS1po/BB6NYDhhu4YV6kx1ao4s9yJEp98Pi4x56USyPZwkkxX0YsVmCEqE3d/zf9ovNw4AFMUn5UxwHyk=
Authentication-Results: sigxcpu.org; dkim=none (message not signed)
 header.d=none;sigxcpu.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB5584.eurprd04.prod.outlook.com (2603:10a6:803:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 02:56:17 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 02:56:16 +0000
Message-ID: <8a37a8e8a9d6a958bceacee6f28f5776c91ebd68.camel@nxp.com>
Subject: Re: [PATCH v4 1/1] phy: fsl-imx8-mipi-dphy: Hook into runtime pm
From:   Liu Ying <victor.liu@nxp.com>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 23 Feb 2021 10:54:42 +0800
In-Reply-To: <daef1299e43f0372a95c149b979441f8083f4b15.camel@nxp.com>
References: <cover.1614019053.git.agx@sigxcpu.org>
         <fa1ce8cdb448ed81e0dc6e49e3c7f8fd6b19ecae.1614019053.git.agx@sigxcpu.org>
         <daef1299e43f0372a95c149b979441f8083f4b15.camel@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry.ap.freescale.net (119.31.174.66) by SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.2 via Frontend Transport; Tue, 23 Feb 2021 02:56:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a2dd4e0c-4df3-470e-3cb3-08d8d7a696b1
X-MS-TrafficTypeDiagnostic: VI1PR04MB5584:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB55846D2AC2FD951ECB481FC498809@VI1PR04MB5584.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ulsTG1EZOLWqfO7d48sR/YKW8kI8AochWYJtaVc5EfRM/4Be0gq/FRwlVG2G5jQLb+4+9HNmrOuQki5TablCmJs3eHfWIosTA0PbGOsw897hMR19/2xPPpJxbHlSqXeOh3whjafyEQIwVcehxXXutovgviY6k8MGBTjlvflirA9YXno5intar+AM7D5h1ko/8m0k0CuBKlz3jlbqen+KKPN9tE3yOoUxCUwkLqPhdujpbdq/R4L6YRRShZ6Ejsowd6AcJHrYEpd/eHqQ70oZyb3jrxx83cK7vcWISJLarQiIEAbkw5OZDSB/LGQihSZEzpWDWfT/9n4412lVjOU0MBdQWJUtoetkLWdac3KuDvJRx42R30PxftJ52SPq4kU+kUBJpwYAx2fhGstFU6FZQ39pP6GGdnmLdbrPOnFCDfLSMM4jdWNPvcqD9jwjVOOS56qGHtPp9aHKF0MfdnT/MOunFhIl3LHqnMal1I7Nbh+pzpiqSJf7L787NTukWzjy8apoMw6vCn6k3neq6aj1JBePN1tMXxBLi5YdeALBF6U7xOu/qTyDKtvFhIKaxODh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(5660300002)(6512007)(921005)(66476007)(66556008)(478600001)(8676002)(2906002)(36756003)(26005)(8936002)(6486002)(6666004)(186003)(66946007)(86362001)(956004)(2616005)(110136005)(66574015)(83380400001)(316002)(6506007)(52116002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TDd6L0R3U3VOanRyOXFUWkg5bDNHTGpZb3plVzc5U21tdm5XREtESjVMVVda?=
 =?utf-8?B?ckc4OFFZS0N0TzQyT0NxZEh0RWhRQ25OZkprQXlzRWNhUyswOTVyQlFoeFBH?=
 =?utf-8?B?dDlpelNZaStQZkt3aEtod1I1UXU0T0FlcEdrcGxadTBSVURqdEkveHA5c1Ez?=
 =?utf-8?B?akhrTHRuakM2Nk9jSDZFS0hIeXVWbVRLTVdiQkluUnhZdHVwVHcxczQ4UnlG?=
 =?utf-8?B?MHRiOVdsTllkVWFVd1lHZFRXUGtZWDJmWkh2WFU2OVBqekd4MnJCSm95YWZo?=
 =?utf-8?B?YVRwbUVNSnhjVktMYXNNTGZ5MkxHMlpjMEo0aTZta0NQaGJiNjdJZi92YzRZ?=
 =?utf-8?B?WjVwZkVORDM2N2hGeWViWFJnOVVyTzgyeTNPY2pSdDM4amxNR0l2QmI2bms3?=
 =?utf-8?B?TEVKQ3BLZzFxcGw1NWxzMlJQM2N0VHN1ZnpOd3N0TnJwdzJBTEYwd1hJK0l1?=
 =?utf-8?B?S1NZNmhmNWFUdzVDL1NsNXNSQ0tTOTdKd1hvUUpSSUFrcHpxcnlDZkJMdld4?=
 =?utf-8?B?WlJSeEM0bWVqcDdtMmd5bmtKNTN0ZzMzUmppVVQxd0VQUTFmbEY0aFA5RkxM?=
 =?utf-8?B?OW02ZUsxZSsrMmNuaW5oa0dCaS9YUS9Wdi8zTGROT1c1L2FSdVhWZ0l0V2Rs?=
 =?utf-8?B?M2dNWjBKZ3pkTnFOSnN2V0pkT0ZZeTgrblU2ejNQTU5WYWpGTktEWWE4NGh4?=
 =?utf-8?B?WFl4azJRZUtva1diOHUwTGF6YUl1U3hJRFV5WERXcTJ1Rk16cGFoUFBEZFFL?=
 =?utf-8?B?Vkk4NWlBNnlTU1Y3STFmNHluc2FqcXdGTWpGNEp5S3lNUDhDL1N2ZHFPRmgr?=
 =?utf-8?B?aytDUElFekt6TktsZEM3TmM2S24ybi9sUzNCUFphM1VyR3lKem4zMThPaEFG?=
 =?utf-8?B?MUZpSXRxWXNMeE9sMEsySGtYY0FRRVB5RVdxSnl4WjNwWWYxbE5LM1ozNjZR?=
 =?utf-8?B?SVVIZ3dxTUpSTVNmTG5wNzdCSFpBV1duNW8xR1Y4SThUK0EzWkpRT0dpZVFs?=
 =?utf-8?B?dENiSGc2Q1lGYWNUV2J4elFWbGtwSXNuY0tKeThxNnRTa2YxS1BOU0diZHYy?=
 =?utf-8?B?T1JmeXhXQTVvNGp3czcxMXRrNzN2QWFzQ3ROOE9VVWN0TmlzMDZ3VVNPM1Br?=
 =?utf-8?B?VGZiVlo4aWhVSGxmQ2NJNjlkQUorcTExelZKSytZMUpwMmpsQmVCbmlaS2lu?=
 =?utf-8?B?TVlsbW9LTEF3M1N2UjhRTDhnWER5QTRDcWlvbm1xeFdIVzZDWGd1QWVpd0NH?=
 =?utf-8?B?am5CRHZ4WUlzSktraGV5dU5Kb25mSGdFajNBYXRtc2xaRnB2RkVVaGpEcmdT?=
 =?utf-8?B?U1FNU3FyalQrdzFwRXd0Uy91eHk3TWI0MkZ3dk1Ka0o0SzV4STl4TzVNdlNE?=
 =?utf-8?B?VGlUWGQvS0VZZnRXdUxDcVJPUVN4Q00wSm56djhiVXRGS0t3aHVPT1Y4cDZJ?=
 =?utf-8?B?ZzYrNHdBQnQ2SHJjK01ISUVSblFYcGRvRWtBLzRzSzA4NWRNaTBuYzFPQ2I5?=
 =?utf-8?B?d1p0WHd1LzFzcjZrZm8zM09tV0hnN1Q5ZkpaUXREb2kwZ1Z5UExGazl2NVgv?=
 =?utf-8?B?QjdRODh5L3hJWWw1VjdzV3JRWnNzc2FUaXZxV3Q3UVVITi9xanlUTWtUK2tS?=
 =?utf-8?B?cWp2eDhGWExEMjRNTjdsS2dzcVdMbTFxL2E4STBzUzNHeEY2WDN6WjcxaEdB?=
 =?utf-8?B?RTRaNkEzWWZ3RlUrMVBkSktSNHcxR21lOXVZUURIRmZkNzRoRWFEV3RjSWZC?=
 =?utf-8?Q?KU89DVq6MR/c49zRtNZAlMl3xCAJJ1YvMfmEMSu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dd4e0c-4df3-470e-3cb3-08d8d7a696b1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 02:56:16.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLr/vOZRDRLelMyrE4UGdUoVnHHZp28fLDZSi7IrpJ6QjgAT14Hd20eSnCQyavL0FVMaIQ3sBIvxupbyl1uoZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5584
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-23 at 10:36 +0800, Liu Ying wrote:
> Hi Guido,
> 
> On Mon, 2021-02-22 at 19:38 +0100, Guido Günther wrote:
> > This allows us to shut down the mipi power domain on the imx8. The
> > alternative would be to drop the dphy from the mipi power domain in the
> > SOCs device tree and only have the DSI host controller visible there but
> > since the PD is mostly about the PHY that would defeat it's purpose.
> > 
> > This allows to shut off the power domain hen blanking the LCD panel:
> 
> s/hen/when/
> 
> > pm_genpd_summary before:
> > 
> > domain                          status          slaves
> >     /device                                             runtime status
> > ----------------------------------------------------------------------
> > mipi                            on
> >     /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  unsupported
> >     /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended
> > 
> > after:
> > 
> > mipi                            off-0
> >     /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  suspended
> >     /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> > index a95572b397ca..5de175695834 100644
> > --- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> > +++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> >  
> >  /* DPHY registers */
> > @@ -469,6 +470,8 @@ static int mixel_dphy_probe(struct platform_device *pdev)
> >  
> >  	dev_set_drvdata(dev, priv);
> >  
> > +	pm_runtime_enable(dev);
> > +
> 
> The runtime PM should be disabled if devm_phy_create()
> or devm_of_phy_provider_register() fail.
> 
> Also, I'm just realizing that mixel_dphy_configure() accesses some PHY
> registers, which likely needs the power domain on. However, the
> phy-core doesn't manage the runtime PM for phy_configure(). It looks
> that the NWL DSI bridge driver, which uses the PHY, enables the same
> power domain prior to the PHY configuration. That's probably why
> mixel_dphy_configure() gets power for accessing registers(if really
> needed). So, perhaps, either make phy_configure() manage runtime PM or

Just to be clear, if phy_configure() is touched, be very carefully on
relevant in-tree PHYs.

Liu Ying

>  
> get/put runtime PM in mixel_dphy_configure().
> 
> Regards,
> Liu Ying
> 
> >  	phy = devm_phy_create(dev, np, &mixel_dphy_phy_ops);
> >  	if (IS_ERR(phy)) {
> >  		dev_err(dev, "Failed to create phy %ld\n", PTR_ERR(phy));
> > @@ -481,8 +484,15 @@ static int mixel_dphy_probe(struct platform_device *pdev)
> >  	return PTR_ERR_OR_ZERO(phy_provider);
> >  }
> >  
> > +static int mixel_dphy_remove(struct platform_device *pdev)
> > +{
> > +	pm_runtime_disable(&pdev->dev);
> > +	return 0;
> > +}
> > +
> >  static struct platform_driver mixel_dphy_driver = {
> >  	.probe	= mixel_dphy_probe,
> > +	.remove = mixel_dphy_remove,
> >  	.driver = {
> >  		.name = "mixel-mipi-dphy",
> >  		.of_match_table	= mixel_dphy_of_match,

