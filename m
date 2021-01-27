Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC81305055
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbhA0EAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbhA0CzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 21:55:13 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B20BC06178C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 18:18:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bI+KxOYWIG0hlyuFZ+X2K8YIHBBTzn+ylEXz2hSCn5NaYDEU8rAzL/GABMGMTdti5NrV/gFQ/icEmgefne6SZeB8K8/GSpqpwp3S1zGt19edXF1wbv4l4pT6JawoLVUUekYFYbZcaiUkUPHpFu9srcWnOWl5JCZntJygZL3/h1kPiDiODx3vKm3cQmGj495M1oExeJkYFcy6XpWJOqmYWELjTGkiE+X4ZA9bZkMSeGJLlxmnzF/RjfDnpalV7U4xfTspqkLR1Dfzba6js78BN+tcJw+OqINsZZSFooDL+4mM79b/MiMPkxCVKs4MT5ePylifMfuWvTB+r6eVY/3oGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+yyoOcw0OkgWeyk92137qjlgfOZqH8BaEQbCsQrh+s=;
 b=HD7hqKgHQ9dut1zNDRS/b2dypwKOBgxUKYOe6uqDlGJi22WkCz/6EKOHqQadOHULR14adwTBKu7UIpsz2fA7NEdkNjvwzvjibh2AvG2I/rdZy31pu2zIBXwtoTb4SaMA2Qpaas7nVxiKfcE03cHbXIBaKWVgnn2vjXPm8Yk8lgGtPEZ/M+uQBXmVcuGPEgiMssiKa/OIRpulGU29WTJFnqKmQo33Bk1kb0TPo5SBCYT6JdzDK4KiecUnuYTHD+0nJpnXAGaWfnId5KUk70BjuyxJw+M1QfIllY1FX7dLL+nnDu/DXKb+forg9MI0CM/m9eCkHvMi6M0mkvmJhsS/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+yyoOcw0OkgWeyk92137qjlgfOZqH8BaEQbCsQrh+s=;
 b=OcEE0ocDvMrJ0zhPIBMC8Huw5F3fFk9Y8PUTYPhE4JEKAVUUDVnGu9qcLITeJQN9DobfQCXDOLbox8W7XaL8Z0GL0T2Z4K5T4xntHYV9sqhWvHyu8m3NADoOc8YtcrOhjqNmIPkO3S7YUjriVTHOcID0NqiRTkgtOv2LJJmdLTI=
Received: from BLAPR03CA0158.namprd03.prod.outlook.com (2603:10b6:208:32c::13)
 by MW2PR02MB3737.namprd02.prod.outlook.com (2603:10b6:907:3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 27 Jan
 2021 02:18:20 +0000
Received: from BL2NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:32c:cafe::d0) by BLAPR03CA0158.outlook.office365.com
 (2603:10b6:208:32c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Wed, 27 Jan 2021 02:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT057.mail.protection.outlook.com (10.152.77.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Wed, 27 Jan 2021 02:18:19 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 26 Jan 2021 18:18:18 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 26 Jan 2021 18:18:18 -0800
Envelope-to: hyunk@xilinx.com,
 hyun.kwon@xilinx.com,
 michals@xilinx.com,
 laurent.pinchart@ideasonboard.com,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.244] (port=42462 helo=xsjhyunkubuntu)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1l4aPS-00088K-I4; Tue, 26 Jan 2021 18:18:18 -0800
Received: by xsjhyunkubuntu (Postfix, from userid 13638)
        id 895452C7AA5; Tue, 26 Jan 2021 18:18:55 -0800 (PST)
Date:   Tue, 26 Jan 2021 18:18:55 -0800
From:   Hyun Kwon <hyun.kwon@xilinx.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Hyun Kwon <hyunk@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: remove myself from the list
Message-ID: <20210127021855.GA706721@xilinx.com>
References: <20210127011312.697159-1-hyun.kwon@xilinx.com>
 <YBDDvmLHrYpuTBkn@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YBDDvmLHrYpuTBkn@pendragon.ideasonboard.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f99fa10a-b64a-4894-3f2a-08d8c269d07a
X-MS-TrafficTypeDiagnostic: MW2PR02MB3737:
X-Microsoft-Antispam-PRVS: <MW2PR02MB3737BBEFED82205C8596A2A6D6BB9@MW2PR02MB3737.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5Gba+9NPzsD7XxxGytsIKfFG0yIKLuiHQZoeYNnqT0E4BYRoQLeBdiUHbN0AtOp+c6OFj+c6iTaR/BfRP181Ol8wLcnf+5NoD6DunCp6AxO3ZSREEwJzoNRfSGP4p+yffsKuvz9KWOC4D/9FGVhi8cufci+EYrObCDnraBeDll3XH+6YU5XhukMDgWmVbRunMgYI/DA40KYRqUc5ObKusWdmWlGseeo7qYlUFjwFwPe9ak8n1H4MjJcM5jIQ1ztMYF1K1PXRpQdk3v57Y44HZLdBbuwYfP1W85nwLPEZG5hWxiK2HOIENGfFrfDs+YEuXCan74dYOXi26F8VstLRaDkcIfUkuTKNicHnJK8yuX7m+5B0FSbbNoshHTXrPlyD6Y/Jv40wawRud5wNjDYFzUQVxoKUrD5UC5whsQoivAP7YRxao99M1ERPiN99G2QZiUJn1NxnRc7+sp1iJOvbi83soQzWzKp1VWSrn9GsQ8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(6266002)(107886003)(2906002)(2616005)(186003)(70586007)(8676002)(5660300002)(4326008)(70206006)(8936002)(33656002)(336012)(478600001)(82310400003)(36906005)(426003)(44832011)(83380400001)(54906003)(42186006)(316002)(26005)(82740400003)(7636003)(356005)(47076005)(1076003)(6916009)(36756003)(27376004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 02:18:19.6542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f99fa10a-b64a-4894-3f2a-08d8c269d07a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3737
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Tue, Jan 26, 2021 at 05:37:02PM -0800, Laurent Pinchart wrote:
> Hi Hyun,
> 
> Thank you for the patch.
> 
> On Tue, Jan 26, 2021 at 05:13:12PM -0800, Hyun Kwon wrote:
> > The email will become invalid soon.
> 
> Is there, by any chance, anyone at Xilinx would could help maintaining
> these drivers ?
> 

Yes, there will be. I gave my recommendations, but it's still under discussion.
I'll ensure it's decided sooner than later.

Thank you!

-hyun

> > Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Michal Simek <michal.simek@xilinx.com>
> > ---
> >  MAINTAINERS | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 992fe3b0900a..4fc00c2da56d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6048,7 +6048,6 @@ F:	Documentation/gpu/xen-front.rst
> >  F:	drivers/gpu/drm/xen/
> >  
> >  DRM DRIVERS FOR XILINX
> > -M:	Hyun Kwon <hyun.kwon@xilinx.com>
> >  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >  L:	dri-devel@lists.freedesktop.org
> >  S:	Maintained
> > @@ -19577,7 +19576,6 @@ S:	Maintained
> >  F:	drivers/tty/serial/uartlite.c
> >  
> >  XILINX VIDEO IP CORES
> > -M:	Hyun Kwon <hyun.kwon@xilinx.com>
> >  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >  L:	linux-media@vger.kernel.org
> >  S:	Supported
> > @@ -19587,7 +19585,6 @@ F:	drivers/media/platform/xilinx/
> >  F:	include/uapi/linux/xilinx-v4l2-controls.h
> >  
> >  XILINX ZYNQMP DPDMA DRIVER
> > -M:	Hyun Kwon <hyun.kwon@xilinx.com>
> >  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >  L:	dmaengine@vger.kernel.org
> >  S:	Supported
> 
> -- 
> Regards,
> 
> Laurent Pinchart
