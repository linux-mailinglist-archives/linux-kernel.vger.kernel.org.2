Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FE7396C5F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 06:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFAEhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 00:37:19 -0400
Received: from mail-sn1anam02on2061.outbound.protection.outlook.com ([40.107.96.61]:10254
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229460AbhFAEhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 00:37:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5hin0anMPMeqQMmnG4X/0iXE44IARMv36MZV6EpQPXQ90eXtdnFY99xxy+44tXzkB1CUd39iQioHW+qxaTEA5wPFhFU3hF4Psi+sXSBR1gNTgzkCoydFMpMEIB54+fhkI0V9nbjc5s5UTAsb5US3HWCwMKSLZ658NcK2HfIpsT12u5478F/sySRjunHHx8v4A7UaslIZXkv/dIP14JGM1TZUKHzHnryU9ZlP3LC+3sQuBstTyuktYBBAdklp5nrQOqRZd9zzAqyaGnIt+0u8l4Y9Q4anLHlkAerKdIdigD1LkJmhDldC2nYv5F2BcwHaqvoyoTwerFjDw9zTnOO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVE+JswhNb9yMLpUu74hLcMxvTzt/4+dB4w6D4W8tEk=;
 b=IFFI+u4BgUb4KDYT/xT4Lo7S0TDnTYBhegiQvFt9Mp4DRm1Q5E0CSrIK9gFTcBKF20CHVrs7n6wlgc1Yq82LK57eXZTGcBz0G2UO9wLMiidlk/0b49julebbJNJ/HRliTNrzl5C+qFH1tNZ7AE1uXChq7ZXFRPQzOpi9icdomc7VaUu0h3VcNYPQy20L2zb6qfV0/lUp0Peet9/CV0o+Uv7ag284JHnmBJ/6tWewyoDZfCW+oDMkKEojx13uXW3xm4jauuYefSHNU+WGYAwxq2PNlrbHUrzM1hRkrw7PL/E2QgoRIEX30d2odn/kSiIube5egZnnJuJbpCJ3iERbkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVE+JswhNb9yMLpUu74hLcMxvTzt/4+dB4w6D4W8tEk=;
 b=Of0MCjYMu90Zvvr/nIeT8MiEobbnbhLs/8ZAh5iAswUFMZN5YzSEEj8VYTfIPfvmDkcH+t3cXv/5lnqQJgQIcpq+C6bHXPmNIJnBaXwIsa4xLGEipvPNv90oaRHsuxxsrpraPr6dPBrJ4Dgzt83G9aj/8SPSGTqHvUizwXtrs1+I6Izug7zsnHx68DTOx8OHjwoFmybElC2BfechzcDMfFTNcqNSOWQ0fl8TJGHqUkDYAKdDwT5GZrmNQhDGjCo3S3qOYSAweLPUJbRrNUR8DdzjaIeSq284E4bqhex7amII3yIcA/bwy8ytI+XUyN9Me7QvZR18gTgUCvRVcttnBA==
Received: from MWHPR15CA0037.namprd15.prod.outlook.com (2603:10b6:300:ad::23)
 by MW2PR12MB2361.namprd12.prod.outlook.com (2603:10b6:907:7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 04:35:36 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::f1) by MWHPR15CA0037.outlook.office365.com
 (2603:10b6:300:ad::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 04:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 04:35:35 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Jun 2021 04:35:33 +0000
Date:   Tue, 1 Jun 2021 07:35:29 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] vdpa/mlx5: Support creating resources with uid ==
 0
Message-ID: <20210601043529.GA205415@mtl-vdi-166.wap.labs.mlnx>
References: <20210531160404.31368-1-elic@nvidia.com>
 <20210531181704-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210531181704-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 102b0303-4ecd-48e3-ff87-08d924b6b2f9
X-MS-TrafficTypeDiagnostic: MW2PR12MB2361:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2361C4F8782185244920746DAB3E9@MW2PR12MB2361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkoCMhhuSB73WpHzcCHiWZQ13SexvaqkIgzbmmzqwmNggilhPXDGPOFVNHONZlqO2nwLSr9SAY9jUCP7at4sl6pq+VpS1JAephCvdjVIDWBVgZcovjPRY5ecMlU0YbnL+MSmo4+Npfx4IO6QvV86j7ddfZA/g5j8xpeMg48HQPUuTviuqD2ndbrcY+aavZ+wJnM+Vn9hD1TCzw+RFFWm6zn/lGERw16MOZs0KezcKkRbbtO3Y6DTeZbspkircZgGQabtCXnBJlhIMScXwtFyRRKw5l+GL38ULjJxq0bVCi09cj/pTqhI0ABEYQkcxnUnmYDfluMFzLG8fj/bKrXvgOikNSbUpx2k2yRcijFpAn2n9Tt/cU7Cn40l2dm2XGr5Bm3dW8MXFCnzf2rrL9fIixz8OIUqwAhHR3m4ApqxUuTot2dCqjwpYRf9CoqUvUSoxhwgBoYgNE/4Z8XT87gXCTpINYziG/O/Gge24011EVHbc/K9mnf7vyUotjt4S0MtPw4pvndUz+MTV04QBtCpgeiUhe9gHgSIZFPfIg+rHazo7s0QsoA/nME3Z/25rjSbwHWU+cBw3JmRxMvlX3Ahi6IXb8wFQo5e+l5ovd4HwSuD6DgZfRDvo4igpNJ/jlcFzTtz7mHeGBqT1mpo8tq91DfgZ9Jfd3204j/nKKFkiM8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(36840700001)(4326008)(426003)(8676002)(2906002)(16526019)(36860700001)(70586007)(8936002)(47076005)(83380400001)(82310400003)(5660300002)(336012)(6666004)(26005)(86362001)(70206006)(186003)(33656002)(478600001)(316002)(36906005)(9686003)(54906003)(55016002)(7696005)(356005)(7636003)(1076003)(82740400003)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 04:35:35.3872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 102b0303-4ecd-48e3-ff87-08d924b6b2f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2361
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 06:17:12PM -0400, Michael S. Tsirkin wrote:
> On Mon, May 31, 2021 at 07:04:04PM +0300, Eli Cohen wrote:
> > Currently all resources must be created with uid != 0 which is essential
> > when userspace processes are allocating virtquueue resources. Since this
> > is a kernel implementation, it is perfectly legal to open resources with
> > uid == 0.
> > 
> > In case firmware supports, avoid allocating user context.
> > 
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> > v0 --> v1:
> >   Fix typo and modify phrasing
> 
> threading's broken now

Sorry about this, will repost again.
> 
> >  drivers/vdpa/mlx5/core/resources.c | 6 ++++++
> >  include/linux/mlx5/mlx5_ifc.h      | 4 +++-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> > index 6521cbd0f5c2..836ab9ef0fa6 100644
> > --- a/drivers/vdpa/mlx5/core/resources.c
> > +++ b/drivers/vdpa/mlx5/core/resources.c
> > @@ -54,6 +54,9 @@ static int create_uctx(struct mlx5_vdpa_dev *mvdev, u16 *uid)
> >  	void *in;
> >  	int err;
> >  
> > +	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0))
> > +		return 0;
> > +
> >  	/* 0 means not supported */
> >  	if (!MLX5_CAP_GEN(mvdev->mdev, log_max_uctx))
> >  		return -EOPNOTSUPP;
> > @@ -79,6 +82,9 @@ static void destroy_uctx(struct mlx5_vdpa_dev *mvdev, u32 uid)
> >  	u32 out[MLX5_ST_SZ_DW(destroy_uctx_out)] = {};
> >  	u32 in[MLX5_ST_SZ_DW(destroy_uctx_in)] = {};
> >  
> > +	if (!uid)
> > +		return;
> > +
> >  	MLX5_SET(destroy_uctx_in, in, opcode, MLX5_CMD_OP_DESTROY_UCTX);
> >  	MLX5_SET(destroy_uctx_in, in, uid, uid);
> >  
> > diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> > index 9c68b2da14c6..606d2aeacad4 100644
> > --- a/include/linux/mlx5/mlx5_ifc.h
> > +++ b/include/linux/mlx5/mlx5_ifc.h
> > @@ -1487,7 +1487,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
> >  	u8         uar_4k[0x1];
> >  	u8         reserved_at_241[0x9];
> >  	u8         uar_sz[0x6];
> > -	u8         reserved_at_250[0x8];
> > +	u8         reserved_at_248[0x2];
> > +	u8         umem_uid_0[0x1];
> > +	u8         reserved_at_250[0x5];
> >  	u8         log_pg_sz[0x8];
> >  
> >  	u8         bf[0x1];
> > -- 
> > 2.31.1
> 
