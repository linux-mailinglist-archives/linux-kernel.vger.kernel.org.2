Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D510B31073C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBEI5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:57:44 -0500
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:39794
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230055AbhBEI52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oku3qG3Bqyx7cgh1kTOL2Ef9d6hi+s/SncvWyRMjV2U=;
 b=97626zbsiQ09kkxAK73/XDyIiPe+HkeeWX5aIOIzNRgNw2LOvEPgot2x3XYRcA6ilXr/JsMmMjEz3FOntw24nKpvUqucJ/6YNEB+BAbgGtlAZyXNLjSkH1Xkpqss1zdV3mBoesPZOkRAGl3P9OhNqXSyUHR5efVXa55nnC8qkbM=
Received: from AM5PR0201CA0012.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::22) by VI1PR0801MB2016.eurprd08.prod.outlook.com
 (2603:10a6:800:82::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Fri, 5 Feb
 2021 08:56:27 +0000
Received: from VE1EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:3d:cafe::ae) by AM5PR0201CA0012.outlook.office365.com
 (2603:10a6:203:3d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend
 Transport; Fri, 5 Feb 2021 08:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT038.mail.protection.outlook.com (10.152.19.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Fri, 5 Feb 2021 08:56:26 +0000
Received: ("Tessian outbound 28c96a6c9d2e:v71"); Fri, 05 Feb 2021 08:56:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8a87e63f27edb816
X-CR-MTA-TID: 64aa7808
Received: from f699cae6931c.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 78728D3E-42CE-4D9C-A5D0-BF66747DB1A7.1;
        Fri, 05 Feb 2021 08:56:25 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f699cae6931c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 05 Feb 2021 08:56:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lv2HkUnxABG2YCGUxbFGNkQkt2EJGmpQfoSDPuqPD3+eDQuJwETYhEzq9IeZc/fiHYELErhFN1Zmz1Jp5pup9ox4yuVKuwdPR1rKKx1M9FrVm/ya6u2Iy5Pa334dk0jOt/b1yiXsmKT7I8mQWZrNDCrhdGxd48PIbZ4XWG8Fpmu2sr7usFQ9i5bVZxQIjAdfvYBTYBDSwQ8txI57OYIodjzl6h4OZ5cp7CK4ai+fPoT/BWPnOT7hEHmZINrHDMnOm096A51pItQu4Dc8N7d9Dbw0qrWdQpCrtqHpDaIqil9xre5xgwkyP/no4TtFuVdkdoQuDw9pz4ugqASLAds6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oku3qG3Bqyx7cgh1kTOL2Ef9d6hi+s/SncvWyRMjV2U=;
 b=NvqhWw8fXlQ3Q9XUS6Cd1B9bRVuwnGX1yx+rjWy9oJpHTS0eEWTStdyo7+EcwfzuMnh8WVTfbFsNsvevGc0PNeC6tt/A69h19P7TurH8AiVjXGyeUwH4HlEdExJPp+gTVxOPIL1clMjwnBZWjaQiPPSehR6YmWo+L3T+vxpX+a2CA/FO1LBxeWlyNcZ40foDU8y1VlvbFw04HaHUJRr4TVVgofDzBqfngpPeGkEswtQaQEh60Q+zcK45TuisglEJpN5tgswj0Q+Ojeef7Midpq+nh2nHqsDZw6z6tVlYzxeJdT5B4EKP6qb2I0n4TizR8amb8+OeS5O29JI57bIWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oku3qG3Bqyx7cgh1kTOL2Ef9d6hi+s/SncvWyRMjV2U=;
 b=97626zbsiQ09kkxAK73/XDyIiPe+HkeeWX5aIOIzNRgNw2LOvEPgot2x3XYRcA6ilXr/JsMmMjEz3FOntw24nKpvUqucJ/6YNEB+BAbgGtlAZyXNLjSkH1Xkpqss1zdV3mBoesPZOkRAGl3P9OhNqXSyUHR5efVXa55nnC8qkbM=
Authentication-Results-Original: linux.alibaba.com; dkim=none (message not
 signed) header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=arm.com;
Received: from VI1PR0802MB2527.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::13) by VE1PR08MB5759.eurprd08.prod.outlook.com
 (2603:10a6:800:1b3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Fri, 5 Feb
 2021 08:56:15 +0000
Received: from VI1PR0802MB2527.eurprd08.prod.outlook.com
 ([fe80::c58a:f891:1edf:b0ce]) by VI1PR0802MB2527.eurprd08.prod.outlook.com
 ([fe80::c58a:f891:1edf:b0ce%7]) with mapi id 15.20.3825.020; Fri, 5 Feb 2021
 08:56:15 +0000
Date:   Fri, 5 Feb 2021 16:56:09 +0800
From:   James Qian Wang <james.qian.wang@arm.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     liviu.dudau@arm.com, mihail.atanassov@arm.com,
        brian.starkey@arm.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH] drm/komeda: convert sysfs sprintf/snprintf family to
 sysfs_emit
Message-ID: <20210205085609.GA1531584@jamwan02-TSP300>
References: <1612420708-25297-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612420708-25297-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Originating-IP: [203.126.0.113]
X-ClientProxiedBy: SG2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:3:18::21) To VI1PR0802MB2527.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (203.126.0.113) by SG2PR02CA0033.apcprd02.prod.outlook.com (2603:1096:3:18::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Fri, 5 Feb 2021 08:56:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc6570f6-d70e-4baa-3819-08d8c9b3ebac
X-MS-TrafficTypeDiagnostic: VE1PR08MB5759:|VI1PR0801MB2016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB20161A81D4B697B0C446BEC5B3B29@VI1PR0801MB2016.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Qw6l6c++tBVyHueW5EMudrDpQ2ZidXDLG9/WAofidD6d15LUdHSMRAtLLkFrZc27pbcVzZ9MPsRBNiEOeJkSXFIVEe3UX3OE311q+nKcdRMG1Uo/KsE5pfMaezGlLnloUIVrx6YxPhDgHovJWqdl/WTNN/ZZ01zgQziD6Lg+PLanPNs6aD1Ss/3zWP5gRnpewvDqdjShQFh2Xx4M+QeSX2th/5jf9Zt++cC6L5WbYd3u9nAs1DPD4BN7LxHcfbBl14+LvVyAZqdEReFX3EUamlySLk02IUBhYYi8qtyfWM8kEcv7eUquhfxYZjBX6FvZJ0bA3Lw9U07QvLrbXy0JxvdBK9O9Hds8BgU1kFEeAn1/fdF3lI95Zmj8j+sX9tnC9luLN8hksc90d1BQFELOn+Kh0B94p5ZkTrLrFOyo2Ac5VOjzsae6cdtXMKlfFIZrcmEMPv2UCLAaWHwEQ/aI0sjCs9flUOIryOrks4oVnk0Pq2/gvZmDDHauDXEqasU9j3Rqdd+pS1sSSlyE307L+g==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2527.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(376002)(396003)(346002)(136003)(39840400004)(33656002)(186003)(8936002)(478600001)(16526019)(2906002)(6666004)(33716001)(86362001)(5660300002)(83380400001)(956004)(9686003)(6496006)(52116002)(6486002)(8676002)(66556008)(66476007)(66946007)(1076003)(316002)(4326008)(26005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?J+g4MEI/8D16uXrRCMLn7ajZGesQRySNZnDr2l3YoSg7uIGMrd+mnJhO2pCE?=
 =?us-ascii?Q?287fWzWhsSgRcUsPyw6BYX6jDB2+sUgZkk+HLhS714s5FekXiJJG1pgoGfdv?=
 =?us-ascii?Q?2p4B9sgzJjllXhCq1UYixMjOd6CENWPGtOpW2waoCqDx7Hklw3/ehtWZXf8c?=
 =?us-ascii?Q?wthYtckncIOmLUncFHrWZdJbunjogtR1xqwMFkUKHPcOqW6+s4erU1DQXQxg?=
 =?us-ascii?Q?+i3tz++6LbhAArCc6omNkbPyKhG9q+fTxBpxcTGzQ1Qb107XdzY7OPDhYrjO?=
 =?us-ascii?Q?bREKzF7CDoobAWNII72J8xMM55QEZRE2zMlS0YbUW70EIoBIzdVOlc1KieDP?=
 =?us-ascii?Q?dPZoEjDtvt9fW74I1LVboWx6H0y6/kJ+igc4juPmtxfa8zpuJTsGlrO3UYGS?=
 =?us-ascii?Q?l8WZu56Jn1fb2V31mrwfwWpvmaF4r4FvJ35fqF2LbDrQVLQyzKP42qFHLcL/?=
 =?us-ascii?Q?DOWRJ8oL3bavvR7NmkA321ClKNUdOti8CofsedcZvl2k8wqK0jNaKMpzpJvN?=
 =?us-ascii?Q?qK4o1rMUtRLSl8gE45VE6i484p9uiAR7/njmUmK0SAAt21kCiEyuvt1naFUV?=
 =?us-ascii?Q?ZK1xlw8hhuXWaskDf4eus8nAOJkZnSFl316a6vudol/DzbVEDBTY27v23q9a?=
 =?us-ascii?Q?t5OXSQeC5Y/YtkLybJAJk9xMoQhzpMXFmxKN719ZB7KQZ7dAFE0rYWGsd2SU?=
 =?us-ascii?Q?7L4CuqdNbrdIxrJt2oraWT9avxdxtdRv996BVD9RH30wccChBn1jEmn3oy9t?=
 =?us-ascii?Q?dHONgtYrntV9zW2MyImxZINa7p+PqtP8k3a0vFcNwAW4AXVrhQoxkXgN48Mj?=
 =?us-ascii?Q?1lICLytVG5h/pUnYrgXFHSEvHcqOI7o/bHhcq+9cJIME2ApKoKkNNrGtfvPp?=
 =?us-ascii?Q?7sSeV9L4SRCNJbJE2jnH23Evtb2iKbf0JM7QLIMrVbL22kn/7btER6JhqYk+?=
 =?us-ascii?Q?Ds7+71ni2Lny0Ao6QLY95BPspGS0/QsT4mFOvXaTdazYOEMbmd7LCca0hVDy?=
 =?us-ascii?Q?f3ViOxsfXI4+57xTmwDxFiNLVC8lJLzpQpyCpv/rYq4wH0c2Z7g8eLmUwvRT?=
 =?us-ascii?Q?8zZz1ckR6syX/7jL4gvn9lYGkl1aHtD1RE0qCqF86kPfTeRbjncvG9OTy1x1?=
 =?us-ascii?Q?rdnmCoGtCoto0uNjVhhYlqaQInci0F2osBkA1Y+45QBGNsHaPcGOFJTPNu5h?=
 =?us-ascii?Q?Kf6Iev0LGuPlOUVVWaUsgCS6KWaTgoBBcZWrRz2rMT3vdHIF6ux+qeiL83+f?=
 =?us-ascii?Q?aJyB+hGnPZMumHFEn1swJ2TPbUl9By/7oOe5slIRhUXyJD7XjPoVdB/iQQTs?=
 =?us-ascii?Q?MAi9W4IPd6gHpc5LSU7hGU0j?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5759
Original-Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3de347d3-15be-48c0-1cca-08d8c9b3e525
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cAXIzcTMKRkE8ZkhhnODBAnloAlYoSU05um1OZ2qpq4fPuDZDYNJKdA/phTnqiKCcMWDJkIxKx4/xiGQR2GDg9Mf3vmd16zi6boYRCnnm9et7OLNFzw23n4C2w3sYoyrnui8o4bnLK8o4nLVKcTETbeSE7H9P7nWjaQeon254tUlNG5RhRPE1jRTeq6T9t5RCn1s4B0pTWh8VeAEWDSKziKxbZj0q5S3X9oLW0zc0cWwyWCrjcyXVbb5N1TL/ZvlNNdhidtiD+m8Z0f6S4sj7uUA2/0djKntSI1uU1yWTxFoW4/rKa1ah3iCbAUgYoZLNLQAfa+v6Jpid8cGHSyVerKJYUiNVNThhsjpSNdZqZpCeuWt4J0hnPNzk2u/d/42jQKum++Ytrdt4edYuhdfcjhJ+S0yBATwfhcy8VPzj+SILFkKj/jj+V8pu3rDFOXE3DdnaYT4ngKyiFI0tQhiDS5+GGhVxhTujdeF8ywLftjOLIXJg5JKieB+sYxypuvAL1Unj3ia4IYs3VrBTOxLwI74qve40uB4qZ7f9sz+OMGI7NeGiMlfzTJUyfeHhkWIAmBVeKprgjXs2+/9gjoZgDA/T/iqT2WX2Pu/cvP6VH1vZb61dXozNCGIMP0IQawERr+1wFjWrgogJw2s6ogpY4zlASXL7TLeM1VENbyFtI=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(7916004)(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966006)(36840700001)(6666004)(70206006)(47076005)(33716001)(16526019)(86362001)(83380400001)(26005)(5660300002)(2906002)(478600001)(33656002)(82310400003)(1076003)(81166007)(36860700001)(186003)(70586007)(9686003)(6862004)(356005)(8676002)(6486002)(956004)(6496006)(4326008)(316002)(8936002)(336012)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 08:56:26.1907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6570f6-d70e-4baa-3819-08d8c9b3ebac
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2016
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 02:38:28PM +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warning:
> 
> ./drivers/gpu/drm/arm/display/komeda/komeda_dev.c:97:8-16: WARNING: use
> scnprintf or sprintf.
> 
> ./drivers/gpu/drm/arm/display/komeda/komeda_dev.c:88:8-16: WARNING: use
> scnprintf or sprintf.
> 
> ./drivers/gpu/drm/arm/display/komeda/komeda_dev.c:65:8-16: WARNING: use
> scnprintf or sprintf.
> 
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---

Looks good to me, thank you for the patch.

Reviewed-by: James Qian Wang <james.qian.wang@arm.com>

>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index ca891ae..cc7664c 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -62,7 +62,7 @@ static void komeda_debugfs_init(struct komeda_dev *mdev)
>  {
>  	struct komeda_dev *mdev = dev_to_mdev(dev);
>  
> -	return snprintf(buf, PAGE_SIZE, "0x%08x\n", mdev->chip.core_id);
> +	return sysfs_emit(buf, "0x%08x\n", mdev->chip.core_id);
>  }
>  static DEVICE_ATTR_RO(core_id);
>  
> @@ -85,7 +85,7 @@ static void komeda_debugfs_init(struct komeda_dev *mdev)
>  		if (pipe->layers[i]->layer_type == KOMEDA_FMT_RICH_LAYER)
>  			config_id.n_richs++;
>  	}
> -	return snprintf(buf, PAGE_SIZE, "0x%08x\n", config_id.value);
> +	return sysfs_emit(buf, "0x%08x\n", config_id.value);
>  }
>  static DEVICE_ATTR_RO(config_id);
>  
> @@ -94,7 +94,7 @@ static void komeda_debugfs_init(struct komeda_dev *mdev)
>  {
>  	struct komeda_dev *mdev = dev_to_mdev(dev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%lu\n", clk_get_rate(mdev->aclk));
> +	return sysfs_emit(buf, "%lu\n", clk_get_rate(mdev->aclk));
>  }
>  static DEVICE_ATTR_RO(aclk_hz);
>  
> -- 
> 1.8.3.1
