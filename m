Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEDA3A73AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhFOCZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:25:37 -0400
Received: from mail-bn8nam11on2110.outbound.protection.outlook.com ([40.107.236.110]:4513
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231499AbhFOCZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:25:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYI+FrgG1Mu7JBAIdgtvT56Viq8y4P7nUaZccTJDBAjQVFQUZcoz3TarfriU3zIryqO2hoyg8+LR1c1JxEl2S7B4omAn65Ryq8m8r1+LVgxQSNYn02pL8FV1082jiU1foO1rJA9Q01r4rIzz6nejGZ0fGwDFj1sCZaqiYfSROKTI5t7FpiE8P5TQwFZgf+GJL3AlsyxzPBn8+3tQ44llhkdZQbS4muFmBSK2fbA2EyT9/X1+hzmuNBcMSk3x3eoKUqYc/V7u/uuRmctg+scr47za67E8ScJH+4N/qrWyaqhJ1b6Z1KvfdmvL7awuceRKdS7plNsLYzpTVbp2UFM33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+tZq9DGXbQEH/AHTYLfDnxKg365cdAXQVTs9657I8c=;
 b=ifa4qn+RBc5QyAkE/sU99fd309sJ0/sLTguSca5GRrGeJyY50QlArGFguiZnqHtFT6sj2j2rWl3NbxgNJkYTa3mHG8JQi8a/JNbsGWLB0LP1KrRZLszDIdkIJ7iu8qV2D5NU3A5rw4tPCgPb49gD8cg/0+ly/0Ta2BCI8KPfwUy0A4w84kO6IQ1fOtfJCNJJhoVGsW66RZriNlr2vQvNpe4JA5uWrOatW/nYpyiFuZw6vBgpp9oYqD8gW5nDeTUHk3kk0ZWG4oPjLsA6KwYkNl1vNxYCDiByKP9xoITI/K7Jml/LtFZKZANuG4xpZqcYHSRLF4qDL85162UDUXZaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+tZq9DGXbQEH/AHTYLfDnxKg365cdAXQVTs9657I8c=;
 b=joUROWSDIRiUaBaIT86ukpNQDCZned2ohJZzXc5GpkY5BsqHXRs2GEJjpw5OnbHUh4dYLH9vI5GlvWe7KH8aeDJ3GrpP02gWCo9wQ6vzlKNeuZCQj0B+6ATNep7unWUyV8HPtXa9JODw+xWAXlaqhZevr1fnWqcwFf7nYvrB36o=
Authentication-Results: driverdev.osuosl.org; dkim=none (message not signed)
 header.d=none;driverdev.osuosl.org; dmarc=none action=none
 header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BYAPR04MB5750.namprd04.prod.outlook.com (2603:10b6:a03:10a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Tue, 15 Jun
 2021 02:21:52 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::5c0e:fbe5:2bd6:ec6]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::5c0e:fbe5:2bd6:ec6%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 02:21:52 +0000
Date:   Tue, 15 Jun 2021 10:21:44 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, Torsten Duwe <duwe@lst.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sheng Pan <span@analogixsemi.com>,
        Bernie Liang <bliang@analogixsemi.com>,
        Zhen Li <zhenli@analogixsemi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH v7 3/4] drm/bridge: anx7625: add MIPI DPI input feature
Message-ID: <20210615022144.GA3857658@anxtwsw-Precision-3640-Tower>
References: <cover.1623402115.git.xji@analogixsemi.com>
 <19c0d381ed2911c04878f83ae40dad4d3a086d74.1623402115.git.xji@analogixsemi.com>
 <YMcrqIpHTa8ghObz@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMcrqIpHTa8ghObz@pendragon.ideasonboard.com>
X-Originating-IP: [60.251.58.79]
X-ClientProxiedBy: HK0PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:203:b0::35) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from anxtwsw-Precision-3640-Tower (60.251.58.79) by HK0PR03CA0119.apcprd03.prod.outlook.com (2603:1096:203:b0::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 02:21:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af556031-ce13-4a15-dbb5-08d92fa45625
X-MS-TrafficTypeDiagnostic: BYAPR04MB5750:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR04MB57505334FF26FD7DA2CBA69AC7309@BYAPR04MB5750.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ha3ulB7VNj2DZ81Vw0li2X9hYKLuF//s6RPPjj4Up0teiWY1yA4Js5U4AUrLfkx51/HNwAEA25fHRdWm/j/d8TnhftN8xDdBKJn5Z32W8CgQg+pcRii/hd7eHWGPhYQTGFYbRWgYlJ7+tqAXaE5ZSg9q2GIxx37SJmy8dOasB1ko2ETPecsYJiF1MwJqvmvKwk5WxTgEc3dq5+61ydc69iUwLAD78n3trsKPSCL33y7G9WmD3jBWbHHoM5CKmETK3RSiguQawmGoDqXAOYMfddAOQ6Meia53/2mSOQtUWSY8ewlh8HFXkQxFxPoqiB0QXl2YqySHSyFs4GA9YMiVWRG2x3r1HAvlOHsxp77CqPw+8Dy08wVLfxDP9Vm+aXsCW1esojGu1+c0bxsVPjF50KEUKqrn5QUPW5HSon5M4ckubw+oohpKqPyCWYbgYg63v9jT+RiEMqhdB8PmSyuBKVi3qUJAeeKvLwdZBA78ByhOTLWPxGBG7uiO7z3W4sFdJQmFUP4jMGugiviNWbTaR4Akt6bubsByDmyBwmO08OoFqnsTUJulG0R5MgYYiu3x5WOj51ExbDL3O/PUTXSOZjqY20mE/UXKbg0Kzfh7c203nmzNIETc7rwMaCtd21SpvBczJXuoys6pn3p4sKysNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39830400003)(396003)(136003)(366004)(55236004)(186003)(6496006)(16526019)(9686003)(6666004)(6916009)(7416002)(83380400001)(5660300002)(8676002)(2906002)(478600001)(1076003)(4744005)(54906003)(8936002)(66946007)(4326008)(38350700002)(38100700002)(956004)(55016002)(66556008)(52116002)(66476007)(33716001)(316002)(86362001)(26005)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dM08g8lBu/KMxQPCbWfkdEdilJtotgZVcHNAcL82vs8MTPQTRUnkywHKq6DN?=
 =?us-ascii?Q?e/oQnRP4vwrserLsyyThHcxT2kJb3Cl9uP0kzrRZQr0plF5ZyKe5T+e8m/wb?=
 =?us-ascii?Q?UGcV/vqvJRRwd2zspTNCrK9Cns0Na3NqycQWADxevCf2EEAbI8OlTB2zs/N2?=
 =?us-ascii?Q?hIQ3KSfNTt1ite10HFSyYv7Dk+KzwSz8fXbeOxm27c8Z4K3WnQaB7WXAIqbs?=
 =?us-ascii?Q?am7rDv60o8tCWFBqd+lAuCiSQsPmgY5/6BBTD2GhF/yOO44naCdNjPr4Fy1Z?=
 =?us-ascii?Q?c5koze33h0cSZJP6rdNlDqUkTc1qpbSvRYAmlgwUqSRERSgFHN94OkGd887H?=
 =?us-ascii?Q?P5c16G1lAfBcrdL/9mNCH6PzNL4e4av9ZG/HSapNEpJuA2XnRUEzH9hu9a9U?=
 =?us-ascii?Q?UuRXKMRnbOZiuwTOk2S8d78Va3b/wGCAZzxs8Gb6xTJrrHcFaqyK9bryw5UL?=
 =?us-ascii?Q?jz/UEAEmq9KZ19k8lfj7V7fR+3t/XIHoD5lD7SPjwgKvLeDXkVMg+eX9AgQw?=
 =?us-ascii?Q?/IBlS/vUZSgCINHNxX+vXAp+MNzZOsftlggcx4vT12/TvuCbWyUj2b33RBlp?=
 =?us-ascii?Q?Qjlzl6aDjJvR1DJwEnvV+8ZZrLkjYoorAM22k1LzpIBkrtcJe4KnuHs16ssn?=
 =?us-ascii?Q?5qDXKHIIQQCC8aZtMYxzeOMo5d2dnIUkBdye139039ez+H9xKOkRQQ7Wwz5g?=
 =?us-ascii?Q?fjXfPnmEQ2ppO8WOIFIDDBhL49EiQuS8u8r33yC3Ul4xOnDi2lR1p9K1Akij?=
 =?us-ascii?Q?uEKLoYnkK2RrHR3cmjvfHDDtnHiT1o7dyr2MOAqP4k7SfZ13NhGxYTapP59R?=
 =?us-ascii?Q?lPDPGADdM7rcg19fz+OYIyUTplayqNF17cJeEx/oqThyr/WLyWrtGEwvw1p2?=
 =?us-ascii?Q?rQ7SDT9NM5R9gjez9dA39feKQd2BRaGUBIWKq3wqjQ0q/5o2CDPLF8KpLp5H?=
 =?us-ascii?Q?rYh6lF/Pyczqw19WzXDpWkL8yxC0TzVWivYo5QZeyD7P4EjOOOtxaJIdz9o4?=
 =?us-ascii?Q?tEOI/nf3wlEG+vtWcXHbkFtSmdksNh05X4nAEMtWPvMpICZn4CYm0ni+QiRt?=
 =?us-ascii?Q?lGS8cZD+oBsz3KRBhxvrIYoAYchU8qjX/kCJ8xDbfwu45IADasojxRQSQjBy?=
 =?us-ascii?Q?O/gGe17KoFlsxajG5tMM1xK4DthzMm8l2dbN1ahQ2GgQzAoB9VKVFO2LMfSF?=
 =?us-ascii?Q?Q8GFmb6oME3/ctLrJ57xtEK1lwTH9Emm51zS11Gg1mZXesPmec/VbGUAHC/D?=
 =?us-ascii?Q?imiaR3ex1TpXd0gSXHAcUuAgxUEMnSwFD/EMVe/Zd+HREnIzKW22AZviJWHV?=
 =?us-ascii?Q?d22qZS1E6b4U9zcYSFMhVOpN?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af556031-ce13-4a15-dbb5-08d92fa45625
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 02:21:52.2640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09xC5me8X4YS2Nt9QSiVaVJNydL6juwKtUDbIyXBLCZDLI6ZbN7R1qfOd5Ho14IkSKHI+v0kmbb1+bWBd7hnRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5750
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 01:12:56PM +0300, Laurent Pinchart wrote:
> Hi Xin,
> 
> Thank you for the patch.
> 
> On Fri, Jun 11, 2021 at 05:13:33PM +0800, Xin Ji wrote:
> > Add MIPI rx DPI input feature support.
> 
> Could you expand the commit message to explain what this feature is ?
Hi Laurent Pinchart, OK, I'll expand the commit message.
Thanks,
Xin
> 
> > Reviewed-by: Robert Foss <robert.foss@linaro.org>
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 245 ++++++++++++++++------
> >  drivers/gpu/drm/bridge/analogix/anx7625.h |  18 +-
> >  2 files changed, 203 insertions(+), 60 deletions(-)
> 
> [snip]
> 
> -- 
> Regards,
> 
> Laurent Pinchart
