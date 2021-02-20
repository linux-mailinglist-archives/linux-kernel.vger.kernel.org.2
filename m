Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454FC320409
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 06:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhBTFcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 00:32:32 -0500
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:1603
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229633AbhBTFcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 00:32:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoDsvYtcS7r489ScPFBvZq057OQ5qxSVnUHWnM44eTMTJms1CP+fr58ReUaT43ZV+K7v+Il35hPZNp3conZbRYJadNlPF7YjDWKg6tf0ZR4hhcwfYW/rM9JNa8dEP0mLsABEvWSQuXE4nGX/xK6uuxyCrvgMYAUAkhaVn72rrgwvi2Yxa4OQNnfI5/EiIlP4hEgtu6Vki3fa+/BuKsvAqblpYHEq3vEsftBFA97bN+seuZIixGVqa0pq1t78oBqfqyWjydDFhkw2I3xZ9sBoEfzuXghwjuuSfsZBZ2umrUEgOIxnwRmjo28k7ezvBq4GRFp1wpBK4QAzyqjxdMutbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POiZH+pd1lVdc9MXAs3sfdCCaHQy+OgkqqDqTOhRFyQ=;
 b=RGNvUEIxDC7hEIvxpg6B9d1ZWU48SL6tW2/BjPS0/jeWRof/2dgYKRCPzp4YlvFwGnX/K17hAesqKbjaHxt86E/MqzrULGbz90F6jXOET6/7JCaaLizP7b87TyDpmBavRaC7mGPIxN23iwdBy+t/qUvUHzRYMb8HnW5YVT5HRqRcsB39SDeeYRnhW2AexNRVT+a1VjxSTBg6FWvFi4SnW8IlmtVUa27YDxmio3l6z7oMmSc/QWrMqn4EWtE6PUfYk+UBxQFyJswa8CcHSZI7nsBHbpd6LkPd1us+XdW5tAk7dao1ZkIwIh8fuvXTXgVX2a1PJGLuUZgJJpFBGrl5TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POiZH+pd1lVdc9MXAs3sfdCCaHQy+OgkqqDqTOhRFyQ=;
 b=PbYnYQWhy/rFqU7xItvjVDGkhKZC4eUgcpJ03LkkiFCQbfHibz/TCr8z3lhkqbtWnsmAFnIc70bfDC0D3NhQJM0wUHglfCnUMMmklD60aSAqHWW5bOZfsNElLoxwV6wG9it8IicsvVgEvwoV9Tg+NIQ+ZUX6FQ/bAfIBtvwm+KQ=
Authentication-Results: sigxcpu.org; dkim=none (message not signed)
 header.d=none;sigxcpu.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VE1PR04MB7231.eurprd04.prod.outlook.com (2603:10a6:800:1a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Sat, 20 Feb
 2021 05:31:22 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0%5]) with mapi id 15.20.3868.027; Sat, 20 Feb 2021
 05:31:22 +0000
Message-ID: <9e4ac0b88190312c19709b6253aad7eca203580c.camel@nxp.com>
Subject: Re: [PATCH v3 0/1] phy: fsl-imx8-mipi-dphy: Hook into runtime pm
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
Date:   Sat, 20 Feb 2021 13:29:46 +0800
In-Reply-To: <YC+HLW9pw7hFbFrD@bogon.m.sigxcpu.org>
References: <cover.1608142884.git.agx@sigxcpu.org>
         <YC+HLW9pw7hFbFrD@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::12)
 To VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry.ap.freescale.net (119.31.174.66) by SG2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.2 via Frontend Transport; Sat, 20 Feb 2021 05:31:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: becc6b8a-3139-4911-71bb-08d8d560c1fe
X-MS-TrafficTypeDiagnostic: VE1PR04MB7231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB72311C4323CAC3A8A46E025598839@VE1PR04MB7231.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89VHJ6J+2yAZ6ghfMHb7nvoOicBLODotne/+ijWrMP1bEaRl8TxHNIobLWYEzAPuYAWkcbeoeI7/NTxiuGax4cuq+qEQrj0Z74Gc8kflFMBAB2RL3yymlSy7pDE5q26MUVY4OtS8Yd2AS9xdM6hKKBHgpa2D4tfXVfwfQ9Z7WwBO2CFNq3pHdjxFAFFwgXyAmUFVk7HtxbkvhmXu7nrHCQXnIVQoVNXsj4wC89cbDii0A6la7xJm2Ih7QuJTUpWDr1L15AkQFkjC6SBZpUF2FvNILTVXQYyYIJfBLnuxjaw5rgBLuLHUiewoSsgeNh8qNeoUmLJwpp1HhppbOvOkhctKEKSZLAhMVb/ISBEXCZnmmzQYXQBwIS1+4hMRhdkMZ9MyQOGHCqIB4gITVnilsARjM8d5SrfMKHBirURTLb2M7DHu8+HReqruBMVVUqweLWtksM6+HZPoqBqRcRYlT/ijJwoK8BgmMQS8Ga3LTwfNMeO/V6gw6HAb2/EbabWjqVfIN9arx/x0mYH7G9DQqKpugLqogmrUzksojs/qTOwXDOYwJBH12U6LJBRTCkG/SF2AHuS6ITA22tG/ek3d9Tnh7v6PYYd9WEePa97o9Yts/GMg0U0A1OACWzAVq/J0kKb97HiJN7/yuWH874mnUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(921005)(6506007)(966005)(6512007)(45080400002)(8676002)(66946007)(66476007)(478600001)(66556008)(66574015)(36756003)(6486002)(110136005)(52116002)(16526019)(316002)(186003)(956004)(2616005)(8936002)(86362001)(2906002)(26005)(5660300002)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VitZcW53LzRuRjk4d1ozdlJKeEZrU0NGc2c0MVlBMVlCOEVqNjM3cTFLR2Ra?=
 =?utf-8?B?ZGs2U1k3VlZWZmNtUVBpY2VsNWhLWjlJakErTy9hUU94bCtkRFBXRHpyUEUz?=
 =?utf-8?B?QS9EQnUvc05XMmo5UnNBcnR5bE9TekRDR1paSU9HdUk3MFlDOHlnSkg0RUNP?=
 =?utf-8?B?d3daMzEzU25Ccm5JdXZVQjBQYm1ERlRvaEpHVno0WElNWFlNZVFCOUNwYlZR?=
 =?utf-8?B?T0RLcmJDNFZtekVtYTkycEJmVGNPbVA3WWlUeU4rcm94UWQ4dXRzZWJ3b0Jv?=
 =?utf-8?B?eCtnZlZVRDNUV0hGSzU1K3dqcjEvVXZVV3lBY2FvcTFRL29IZm81NWxiTS96?=
 =?utf-8?B?VHlpTlJVMSt4S3AzakliSENSdmUwa29rYXlQVE12NmRGSGgwQmhVVU15YlhF?=
 =?utf-8?B?V0RYV3VYUGNjZ084NjJwL2gxOGtaVjVRZzdUL085WHYwYlkwVmhINWF0ZDJt?=
 =?utf-8?B?L2hMTzFLVUtjVEZtbzdacHdQZWc0NU5qMGRzTVVnRUQrSlQxdVYrTXJPR3la?=
 =?utf-8?B?M0lnYUlTSmxGUzFUU21TWEIrQm5pK2ZScFZ4YjRabHhRTzZZQ2FzMmswWVBW?=
 =?utf-8?B?MjJoOG14WnNFTGFwa2FqdjhmaW96blk5VzZQTjcxc1RvbHJaU3QyM2JUVlg1?=
 =?utf-8?B?S0RLSmZ5VEdYbGJPbElGbTNubjN6KzJ1R2pKbWp3K1JyaFRaYVZxRTdhUEp2?=
 =?utf-8?B?ckRlMUtaaWQ0UDN3RzZqNVg5Z1RudW1NalE4ZEV0T3h3THdsa1A4eW56MXBJ?=
 =?utf-8?B?T05EUUpQQktoS0ZtL0E5ckNnT1hnWVQ1WlRoWXZ0NFNvTFZYaHl2SVlpaFRu?=
 =?utf-8?B?NDFDMit1YmxvdjBMaEJsNEZsVW1DU01Jai9WYTNUaktBaXRXVFBBMkVqbUpv?=
 =?utf-8?B?TWFHSUVWZTNiWnE3T3E1bkhnMEh0V0UwTzBhSGpFSzluL3FiZWZ1V3pCQ240?=
 =?utf-8?B?ZjJDM3hVVFBiNit4aFJuSjhWcUVxTm1zZVpZNEVHUUZIYkJabmxHOEo5dEcv?=
 =?utf-8?B?eXlldERFaEF5UmVMa3BuOTNTTS9hcW03QzZMZm5ZbXk1VzlzQ3FXQjFUNmxT?=
 =?utf-8?B?cnozeWZIaDN4N01kaVlqZlVGaGRWNXVBSzZic0UzV1gvd05SUDExQVdXb2pt?=
 =?utf-8?B?U1JDcXJacjN1K3pBRUlweDczOXJHQjQ5WHc1bXBEUlVvQlZzT3Q1UUFnU0VJ?=
 =?utf-8?B?bEFvcmRkMVRvVjE4cmxwTGNqMHpYenBJUm1mLzZMTFI3NFk2Rk1FOEdycHg0?=
 =?utf-8?B?ekowTURqVEw1V0kvQTUzaFY2Z2JUWU5Od3lvdVpyN1pKWTBkaEFmeVhQemhR?=
 =?utf-8?B?UE44V1JUb2gzaFhnYkN1M1JrM0g5TThKZFd1WEVNRGQvaklLMlA4aWxOWWFH?=
 =?utf-8?B?akJEOG4xMUtURVlOVys2VWNIOENJSzRFUXFuYklEVEZ1RWs3OEREaTRGRDhV?=
 =?utf-8?B?ZmM4enlLRmVYU2pzUUptRmt0T3VDZXpmWUgybzhrUEpPeTE5dHJ3S2xRM1p4?=
 =?utf-8?B?emUvbnhQcmd1UFRQTWVLbWJxZHJFOFhUZTJqZ2NXWTRndXJHYXFtQnRoZldl?=
 =?utf-8?B?QkdVMlRkSittZ28zRE9ieGp6N3IrNTFuakJQZXZhVy9ma3hQUGMrRUIrMnl5?=
 =?utf-8?B?dmhNeDJZVTBubUVCclRMWTJBWUZlbThKdzBoZ3c0L0NWNkVQUUFJQ0Z5RDFQ?=
 =?utf-8?B?UVpwMnVsWERHVy93NVZxMVF0cWJTTEJ2SGs5VThWRzFoTExaUndyanNBZUpa?=
 =?utf-8?Q?QItziDC256SVK9AaBxW4VmWZdrKDUemfFFGO7BQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becc6b8a-3139-4911-71bb-08d8d560c1fe
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2021 05:31:22.6406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+R56CZL7GMy7t0+y03rRLMZ12lfkQ7coblk6Hf3/Vv0RyNiF/FPNC0HPmX25viWZGXeWkV0eC3TI1k4PBKhrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7231
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Fri, 2021-02-19 at 10:38 +0100, Guido Günther wrote:
> Hi,
> On Wed, Dec 16, 2020 at 07:22:32PM +0100, Guido Günther wrote:
> > This allows us to shut down the mipi power domain on the imx8. The alternative
> > would be to drop the dphy from the mipi power domain in the SOCs device tree
> > and only have the DSI host controller visible there but since the PD is mostly
> > about the PHY that would defeat it's purpose.
> 
> Is there anything I can do to move that forward. I assume this needs to
> go via the phy/ subsystem not drm?

I cannot find patch 1/1 of v3 in my mailbox, so I'll provide comment on
v2.

Regards,
Liu Ying

> Cheers,
>  -- Guido
> 
> > This is basically a resend from February 2020 which went without feedback.
> > 
> > This allows to shut off the power domain hen blanking the LCD panel:
> > 
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
> > Changes from v1:
> >  - Tweak commit message slightly
> > 
> > Changes from v2:
> >   - As pre review comment by Lucas Stach
> >     https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-arm-kernel%2Fee22b072e0abe07559a3e6a63ccf6ece064a46cb.camel%40pengutronix.de%2F&amp;data=04%7C01%7Cvictor.liu%40nxp.com%7Ccac0b14c892c4a35340508d8d4ba2e16%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637493243396909710%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=PU5kegolJwKK%2BQ7nD7V9qjrKJ2fJ9eKoySoFihnFoD8%3D&amp;reserved=0
> >     Check for pm_runtime_get_sync failure
> > 
> > Guido Günther (1):
> >   phy: fsl-imx8-mipi-dphy: Hook into runtime pm
> > 
> >  .../phy/freescale/phy-fsl-imx8-mipi-dphy.c    | 25 ++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> > 
> > -- 
> > 2.29.2
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=04%7C01%7Cvictor.liu%40nxp.com%7Ccac0b14c892c4a35340508d8d4ba2e16%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637493243396909710%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=kkC3Go0wvHemjxaKVHwU%2F6gWRsgVOFoVz7QEHB7Zqx0%3D&amp;reserved=0

