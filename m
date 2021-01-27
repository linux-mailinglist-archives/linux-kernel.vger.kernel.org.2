Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61152305AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbhA0MKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:10:10 -0500
Received: from mail-dm6nam08on2085.outbound.protection.outlook.com ([40.107.102.85]:19040
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236846AbhA0MBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:01:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiUpZWjx0inb+Lmd13Q0ZnWOj19yPoxmh4dZeBhp/O3CDvNC+0/wJ4h1jB8LJqrlR/PuoYDXFWDRHu2oPiduWhAwEnGJ9pbRmpw5bs6fZ8aRi/t6HcJEDcRZKeWP8NVGDMigt3yioOlWiD56PXH3ndu+3eqkThVV+RY6u0lpcaicPXWMRTDN8nzVvz1MJvoIJlchuojiI1Giawgk+HdE62WxcRChZEptiP5oNUNRxoOFGx2GDyjD0XFVaagNngI/vBrB+9BqEdTWqs/OAgu1kiVGHUxUSEi6uXWlvG6KUOcvsS4is1Za0rQ0JuKtugG5J+eUvzFAbMFJFljXULAy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpDDfcx2BHVJ4IkvfUyPBGIuerPuJWcQ1tyGp6P3aDY=;
 b=F/TWgxF4Brf/jrgM2mfeSIeSNY1HeQnmPueYFkCm6UUwOryFJW5+o2JrvhzVWVzZzUTHfFazBCqtdRK2UMCAsD00TXrcuMB+AhAC61Y+JCxaFhi7lom6z4VJiqReFOWBTy2PzOzrDQfPzGXD0Dv/y0s68522q4wF6MbCBVXD8lo2CHZuvKdt/5+7dzLNqm5x/HkOL4ipEk99pDqfopo7k8KPElJWK6hwRU2yODNY6HBzIZni+f/k6IZ06EHgpsbEWlewhCzL9K/IEZzFurePlFh5XgV28xlBYLVmTfuOs7maH2Jbq26JFwNqkj3uB3gGlpLVI9fLbiU9OUjDRtsgJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpDDfcx2BHVJ4IkvfUyPBGIuerPuJWcQ1tyGp6P3aDY=;
 b=M4EkDBQT/iT+qhj144uB+vN5RtrwHyJ/zAEvBorUzbBSIVcGgUS97nOeG97Ef9iJbQbH/bw7SKnGsuj4jspmei0rw4PF/ry/RYvptneKs5K+EzWHhO/96C9iWyfx+2KWDoQWTZSmvaGJwhcKl/FyySTlTmJDQ9z0iByRMkvB0R0=
Received: from BL1PR13CA0368.namprd13.prod.outlook.com (2603:10b6:208:2c0::13)
 by BYAPR02MB5495.namprd02.prod.outlook.com (2603:10b6:a03:95::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 27 Jan
 2021 12:00:14 +0000
Received: from BL2NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2c0:cafe::d7) by BL1PR13CA0368.outlook.office365.com
 (2603:10b6:208:2c0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.7 via Frontend
 Transport; Wed, 27 Jan 2021 12:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT014.mail.protection.outlook.com (10.152.76.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Wed, 27 Jan 2021 12:00:13 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 27 Jan 2021 04:00:04 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 27 Jan 2021 04:00:04 -0800
Envelope-to: michal.simek@xilinx.com,
 hyun.kwon@xilinx.com,
 laurent.pinchart@ideasonboard.com,
 linux-kernel@vger.kernel.org
Received: from [172.30.17.109] (port=41418)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l4jUQ-0001VV-UZ; Wed, 27 Jan 2021 04:00:04 -0800
Subject: Re: [PATCH 1/1] MAINTAINERS: remove myself from the list
To:     Hyun Kwon <hyun.kwon@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <20210127011312.697159-1-hyun.kwon@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a1c43eae-9046-a37a-921c-dcf49157596f@xilinx.com>
Date:   Wed, 27 Jan 2021 13:00:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127011312.697159-1-hyun.kwon@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c5d33c1-d65c-472b-aaf4-08d8c2bb1aef
X-MS-TrafficTypeDiagnostic: BYAPR02MB5495:
X-Microsoft-Antispam-PRVS: <BYAPR02MB54955A1F6F67BF21593BD163C6BB9@BYAPR02MB5495.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:277;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USTqrfKRvPuzxACmOC7a4YMKY7rK62hC1UqXsFMX1Z+pPP1cYSmGEYqPFOY/wvCLStvFVFY9vHs2YaANE+GmUUHwpPAKNJpxL/k5xb3LwKjVe7y6Fh0qWjLdsvfGfaYAMcrjBNynoQPYS6K4pcWdFW1otbNeEY8g6W4sh0zOru6/jBurs5GuQ7f07/B02mcpPEa/TdxL6G1uvGhZ14KPJmOgNi3yV/T9Lb2z4VECyBbO9vRAUbU8Spt2Jx7TtQ7bUTFEqaaMdBKb3pCdDcOed0OmhKx++sLQQWf4ZCmeg5lJ2LuvfDI+2tpbRS5k1G7UN03HxCnUHXVctEFOgmPu/QhZp8WY1/ni8AWazOmwcgtD3u2jTqO1n8yA0iBVdwV3M0oi4uymWnqVBWdP4/jISv4Vk2VKgYrcx0T1cwcpSBlTq81AFUxmOP2G+ZVIVzqPZznpb0LK1o9T4JdFRaCLN6itSM1ewMLg8vCd4oxNVeFw6HHANyygsywtqoVeHSgLV2fktRElLAGsbv2i7M89gQMGr+0yZ2mVOlaACedKbA7fxqIul1SDD3z3UUHu3QE8N7OkX9ELVTc/6cGL7/uH6yffwEzNN+0kfRTN4+YecvACUhGZBHamyybUQHNwY6Oi1QpOMb5cPeDoTygo0abyAQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966006)(356005)(9786002)(8936002)(53546011)(186003)(26005)(31686004)(36756003)(83380400001)(5660300002)(4326008)(82310400003)(2616005)(7636003)(44832011)(31696002)(82740400003)(47076005)(6666004)(478600001)(110136005)(107886003)(36906005)(54906003)(316002)(70206006)(70586007)(8676002)(336012)(2906002)(426003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 12:00:13.8093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5d33c1-d65c-472b-aaf4-08d8c2bb1aef
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5495
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/21 2:13 AM, Hyun Kwon wrote:
> The email will become invalid soon.
> 
> Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---
>  MAINTAINERS | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 992fe3b0900a..4fc00c2da56d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6048,7 +6048,6 @@ F:	Documentation/gpu/xen-front.rst
>  F:	drivers/gpu/drm/xen/
>  
>  DRM DRIVERS FOR XILINX
> -M:	Hyun Kwon <hyun.kwon@xilinx.com>
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
> @@ -19577,7 +19576,6 @@ S:	Maintained
>  F:	drivers/tty/serial/uartlite.c
>  
>  XILINX VIDEO IP CORES
> -M:	Hyun Kwon <hyun.kwon@xilinx.com>
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:	linux-media@vger.kernel.org
>  S:	Supported
> @@ -19587,7 +19585,6 @@ F:	drivers/media/platform/xilinx/
>  F:	include/uapi/linux/xilinx-v4l2-controls.h
>  
>  XILINX ZYNQMP DPDMA DRIVER
> -M:	Hyun Kwon <hyun.kwon@xilinx.com>
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:	dmaengine@vger.kernel.org
>  S:	Supported
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Laurent: Can you ask media maintainer to pick it up?

Thanks,
Michal
