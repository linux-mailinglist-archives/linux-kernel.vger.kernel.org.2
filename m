Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6D143FE3F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 16:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhJ2OQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 10:16:58 -0400
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:28121
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229603AbhJ2OQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aImYsxQdvR555r1pgbpDPb+v62OodbeidaIlzqhlu98=;
 b=i829vny7IMiE8SX/g7ry7/ImXUV8myr31/5H1uxK01DEWnfsmPSi3GV1E59pAqeviSYE/656smegUo0PX0Oz0g6xqoeldjyeQ2lhDyX8BsRQglvgocLcuxuKgvkINAW+QdVNY4FRKXqUFePu44NNLEFaV4aI4xXq33XGTj1RCdw=
Received: from DB8PR03CA0027.eurprd03.prod.outlook.com (2603:10a6:10:be::40)
 by PAXPR08MB6848.eurprd08.prod.outlook.com (2603:10a6:102:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 14:14:14 +0000
Received: from DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:be:cafe::24) by DB8PR03CA0027.outlook.office365.com
 (2603:10a6:10:be::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 14:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT064.mail.protection.outlook.com (10.152.21.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 14:14:14 +0000
Received: ("Tessian outbound e7ce0d853b63:v108"); Fri, 29 Oct 2021 14:14:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: af39d61463f16451
X-CR-MTA-TID: 64aa7808
Received: from 125557e2caf0.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DA005191-9E45-4D83-94EB-E5B823DC855A.1;
        Fri, 29 Oct 2021 14:14:04 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 125557e2caf0.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 29 Oct 2021 14:14:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T21R2iJIQBC13201TM+OAX/5+AAHTwYgLKezKl/tsDFGGkcnzUQVsIYAMB14djr5s5PcQMbLAyjXn/QmvPo06a8cLBA/L1jbTwt/iowgQFt9ennZeUzTQtGn82RAXh9iM6CxTt+QYCB6gaCOu9oaWJ/uo0lD4FMAuhAm4F0MhMCFDP6/nvi4xxv2VwDwvcvrR9Ir6m46u4DbFTynOPVVIwffxvl/RvzAjI5d/xIboKTE5dsZk6vOLSIWS73MYZ/2ezLp47KK3SoA1kklUq/plAUK8atcvQDi6mXCT9mSeutIx3H4M4thL8DIKBrM9ryowTrE1RH0ObqXqRiptVjZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aImYsxQdvR555r1pgbpDPb+v62OodbeidaIlzqhlu98=;
 b=Fg1oL0vAnVDdsT/Cmroh2cPZ/Uo4S5kGL6Wsl5BUOWKUL4GOzkbjQEPzIu9uTxR0nX9g4GcfI/myPrFoLkI8gADa95qXiek0kg+1LBs3U6ZoKSE8k3wNQHbuPMtyAsb9wF2l2qbME0/4jiWxV7NQlbWp0ZhO9XwpjlRhUzN5XqVUzIXzrW9rYoRUaPGOXB0fVTmq616ykV3xePzI3AT556XtgciFOLlK9WLFJxYyfw7N6qnmCcKX4/n71uGzIIuM1jsjQJanrfleIO6E1H15ElYkC+2+rxVUMAKU9GCEVIN3YlFs6owCKjGOtGquWJrH04hNzCdDCDi31wG7eF5UaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aImYsxQdvR555r1pgbpDPb+v62OodbeidaIlzqhlu98=;
 b=i829vny7IMiE8SX/g7ry7/ImXUV8myr31/5H1uxK01DEWnfsmPSi3GV1E59pAqeviSYE/656smegUo0PX0Oz0g6xqoeldjyeQ2lhDyX8BsRQglvgocLcuxuKgvkINAW+QdVNY4FRKXqUFePu44NNLEFaV4aI4xXq33XGTj1RCdw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB6812.eurprd08.prod.outlook.com (2603:10a6:10:2a2::15)
 by DBBPR08MB6028.eurprd08.prod.outlook.com (2603:10a6:10:208::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 14:14:01 +0000
Received: from DB9PR08MB6812.eurprd08.prod.outlook.com
 ([fe80::8da0:3380:60cf:9849]) by DB9PR08MB6812.eurprd08.prod.outlook.com
 ([fe80::8da0:3380:60cf:9849%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 14:14:01 +0000
Date:   Fri, 29 Oct 2021 15:14:00 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        gregkh@linuxfoundation.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ben.davis@arm.com,
        Liviu.Dudau@arm.com, Dan Carpenter <dan.carpenter@oracle.com>,
        nd@arm.com
Subject: Re: [PATCH] drm: check drm_format_info hsub and vsub to avoid divide
 by zero
Message-ID: <20211029141400.vcswmabtk5i3cvv7@000377403353>
References: <1635429437-21718-1-git-send-email-george.kennedy@oracle.com>
 <YXqt46TPL9tUZCL1@intel.com>
 <26fdb955-10c8-a5d6-07b6-85a4374e7754@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26fdb955-10c8-a5d6-07b6-85a4374e7754@oracle.com>
X-ClientProxiedBy: LO2P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::11) To DB9PR08MB6812.eurprd08.prod.outlook.com
 (2603:10a6:10:2a2::15)
MIME-Version: 1.0
Received: from 000377403353 (217.140.106.53) by LO2P123CA0096.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:139::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 14:14:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c8feac0-9f3e-4678-3b80-08d99ae6630a
X-MS-TrafficTypeDiagnostic: DBBPR08MB6028:|PAXPR08MB6848:
X-Microsoft-Antispam-PRVS: <PAXPR08MB684855BD537AAF8B6D695630F0879@PAXPR08MB6848.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4DzY2JilctBzOTbg8fIGjZSJH3aXval3bHvEXU61o3hX6dR+HMcgF974EWjiqcaB7tXFPcGOoefNFk5+pyRHm1mvmUFIHFBwsL3sLlmC8nM/zXW4RvAp71dR9997QKkXsd9dtBUyMEJM/NWERVikOifjeCzYHOMUW6zjakeeMd704TmX3x7WsaxqF3w7v8gJM47n9IyeGRNqIzSZVO+IF0h1iuL8xOD4vLlcNIpUrdBmyj96GVLSZj4vIBD+mJNDxf5MesIQZJGtEoHspKvIdXUgvoR40bUaAcPHSWRSuxuq26HmANCPrxliEdZcmpFpHVigDjGSh7ojGeWY9Lybfm0/fCYCX25AqplkbrIRTnXJVC0PAP3FF8qOPdyxF7Rv8WvH/gsLcqKhIzAUG0llJE66mad3FiK3Yh5EEi0KVfR6QvlT4ZlocwVN3ihm1LmCCDc/2eJPchYykLLIELSuHRAKyK2leGWQpdcLTc6zTy/AYV2p4bswclVqLtY8tDr39/evFPH1ZKTjuMESliYHAUcdNf9gmJdW10Fdn5XjkaerRn9BIXhCvfTtga0ZweBLux2bxT9DLRjTXSKmqUqmMYnhBHqkGLZCBN6RmYdbrzmptGkTVMWQGC3NYRvY3cdlrwFoUNlcTI3ScAAGVy7Q/E7yIvXdxR4z3Gh3uBByJtiIsYBTc5va5fGitQid/E/zQwacT08HOaBcaP4c7pw0KQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6812.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(55016002)(6496006)(9576002)(1076003)(33716001)(86362001)(66556008)(83380400001)(66946007)(9686003)(66476007)(956004)(44832011)(8676002)(5660300002)(38100700002)(4326008)(38350700002)(7416002)(26005)(6916009)(54906003)(316002)(2906002)(186003)(52116002)(8936002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6028
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1733aec8-509b-4cc2-4760-08d99ae65b70
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qoprvb1SEwUcYajgl4roUlXf/QHaK54N64KhhSf+v22DNedUjqeS17yvkrfRHeUFhCASOrR4rh9zZI+vi/at+34lawRgCqFE/jL5l4r9KqYcNHx7tI5bF5r5+SiFCYA4ib+YlGtZsX0j8OvMJFHlwowiCCo+T8haFjs/KfH+MBgVMXUvsfwxhf3E1Qr/RNwtMkF2HlTY+18+Xw4vOOFPcek9Nfhy//ayp5nGkJWi9nwKjs8xJwESuS0ifqS3NZNQe+K8qfbAzhh/uvZJUp6nI4oqurww9VaXUXeYZyzpFtJz84o/e1H7poTCOOvQiiR5jk04LmPnpJqO1ScP9cZOZB4E+BmKaKnScw/4pUh06JyGLkdU8bmIuLDBlfyNCof5JFeAXsOaZ8j2bATtOC3+GXLfJ4dOIXCv5Nb4m3g0VKjXBRIgThW1juzeNFYMY7qZ0+7bCNq4uKsXWLosOBkMLK4sPoKQRNtRZD9+iN6DkAgmL+ed1Quill77YrPaS4NgHo+oGw/9B0ztFVyYDkQQLomvmX6PbfZlVffyqNkF+l1QEgBCPmk658Imw/wB3C3AxKhiolcvNKTHzdeQvD0YiUtNwf68BczCbmRX6T+FBiNL4j+Oo0GJLkdfjRAc+HuWDnllnHxkMkkuNnHyOvtmXAuhY2wmcWAc+SeQnR1jSeoYnwiSalR4y9ovx0waRQAssOsqcizt57IbJ9ucT0JFCQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(86362001)(5660300002)(33716001)(47076005)(44832011)(8936002)(26005)(316002)(956004)(82310400003)(508600001)(4744005)(8676002)(4326008)(36860700001)(9686003)(6862004)(1076003)(9576002)(54906003)(81166007)(55016002)(70206006)(83380400001)(70586007)(336012)(186003)(6496006)(2906002)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 14:14:14.4336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8feac0-9f3e-4678-3b80-08d99ae6630a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6848
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 29, 2021 at 09:15:28AM -0400, George Kennedy wrote:
> 
> Asking if you have any input on how to deal with hsub and vsub = zero?

That's just a straight mistake on those formats - they should
be 1. My bad for not spotting it in review.

On the one hand, having formats in this table is a nice
machine-readable way to describe them. On the other, as drm_fourcc is
being used as the canonical repository for formats, including ones
not used in DRM, we can end up with situations like this.
(R10/R12 being another example of formats not used in DRM:
20211027233140.12268-1-laurent.pinchart@ideasonboard.com)

Thanks,
-Brian
