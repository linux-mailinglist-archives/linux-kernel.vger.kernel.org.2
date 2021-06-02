Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E13398363
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhFBHpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 03:45:52 -0400
Received: from mail-bn8nam12on2061.outbound.protection.outlook.com ([40.107.237.61]:48993
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231950AbhFBHpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 03:45:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/+/v1A7XuOEdC0G+QL6tNGAyQ9l4Pp+HdLm429rABpGYFwG8Yofb3ulaldDiVme2nqXU8+B/dWTOR0UtCIM7kHzRwNRIiuR+BUIrYc/OuHHe1Yaoz9x/akXIKk43trUlGQjlBnEs0p8+mjRy8tINqcYNS6QHVXlknA5tC/smblNr2dUASDc6Sb+3GfgLzvTHIg1ePkhyYfCs19AuEuV72wRbuFuNXrfWxr+P1Cdaad2f7tF01rqgTDKPembWKjpXEzgvV9oubDM8KpR9EyXdgvqrvqMletI2G41UyRXoVCTYW7dgZ+kCm7LAkX72T5xybqk647omyswujcIHO+oBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMcVPJdmrjoxe1tGn059TGb67HRH8Kb2lP5GTv42xsg=;
 b=g4DfKV7LGPkECOKcK+w40/5HdvLxSjvY3cR/19XvQkGo9zF5XeQMxXCKlkiYa4K1JtSk0ylRAlhzygYD4hHsyEBp6ofFdwe+4sFVxaQC2W5T97yR6MYDdy1eoWcXRK3ZErS1KZmeZuO1vJ40tE/VerQGNwgaDhPh6GHIjPP0XLvQVW7xceifnURwBsDHa581MHHuZTfGnIv1vqyHnKtitS+1CmX9Q724w3xaABGnbwNSTEJ1lzST8aOplCkRljIXnV0MrJZzOOOGOl6W6ZbItZpHXM8OG+d40M/a+Mx6XyofI7P8C2uf4f6G+O1NGJ+32daDYz0v2y5yTDHAsQUVqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMcVPJdmrjoxe1tGn059TGb67HRH8Kb2lP5GTv42xsg=;
 b=nR6hfqwL8TCZdr6CdvDSvwXZ3bOEW6+88Uwl87bN2bkLE1sA8nKlKAsql6kZTWXBRaD1EWK5H8c1gCTjY5T55peCG5l1CddAQ+sRhG983/EnZk+BnBQnCqGgVfk2wEY4u9Hqsgxttt49zTGG65jENXvyI7xp2g6kGxba+0UDdAMJe55j1xe8Anf1aAEJ+wz2MhrWG6Nk/4mtV9aU6HHK6iDggeRaNSg0e6qizHlwr0HMDUDjfGHbMA4u9uLEGKdM4th4UB4cKn9EdE8bVuUF4b2Jw+cRbqns9ZTAuuA1K0AA+nPGUGDGG5ju4+uy5SDrN/w+Fmr0vb6/LCcTBHuwEg==
Received: from BN9PR03CA0644.namprd03.prod.outlook.com (2603:10b6:408:13b::19)
 by MN2PR12MB3166.namprd12.prod.outlook.com (2603:10b6:208:106::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 07:44:05 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::df) by BN9PR03CA0644.outlook.office365.com
 (2603:10b6:408:13b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Wed, 2 Jun 2021 07:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 07:44:04 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Jun 2021 07:44:01 +0000
Date:   Wed, 2 Jun 2021 10:43:56 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] vdpa/mlx5: Only return vq ready if vq is initialized
Message-ID: <20210602074356.GC12498@mtl-vdi-166.wap.labs.mlnx>
References: <20210531160448.31537-1-elic@nvidia.com>
 <0fbd8484-9e8b-d7cc-4996-74306e6e2867@redhat.com>
 <20210601041351.GC203469@mtl-vdi-166.wap.labs.mlnx>
 <67b26a20-b418-4893-a42f-f03852c2123e@redhat.com>
 <20210601102129.GB215954@mtl-vdi-166.wap.labs.mlnx>
 <76a44f0b-91c7-595b-f3a8-1d07e2f1bc78@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76a44f0b-91c7-595b-f3a8-1d07e2f1bc78@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa92e251-e5d4-4287-ab65-08d9259a3255
X-MS-TrafficTypeDiagnostic: MN2PR12MB3166:
X-Microsoft-Antispam-PRVS: <MN2PR12MB316619EFD67988BB1070AFD4AB3D9@MN2PR12MB3166.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: siUwtFQmQC1uQFN6deKcTqMAQ2hak0GFCJZXL7Fg8cBY4c8tvyM3e/Tzb3MY9dDZZGMPjEIRuqWizXaUZY0Hv6G2nmg8kRU7l7cydIrwAd5y9VCAOz8/eWN7awHUOBu4qn6sLm9YnpuhYtAJBq7KP7ID0mbKoFY5C/5+1ktCFL0PPp7ecqqP3iQfOE0YIH2ZgCggOfwiIKPO8zkYd3VojmphNJL2EXpD3Pwxl7dFGNUjk0ZvcYKtBhkUYQRuU6/2UE8Tkn1ihlOFYhZQjNQSqnf75wTFCZ7CewmGiApDMqENhT09fOP0r08mJ4PqvRGNVs6kedhh+/5c+Cn85dnqc5K8iq7xi4toCJLvHS6LFTeUiXjXSGLhiVfTzGA8h014naE6UqWYrXasXCsmTh29UbI0dURZ8UbttrrvnNFEdylQjVgNNq1StkZADcFePcM+f6vxtMRFUU4m3xHoRYJ6aeKZXpLWz0Nw1NuUNxHqpkRN7v3TlaO18OWsVrVkk6lRDve9q2/8+D7gvA4HK/vhj6SNGADKCL59GeCE1tyMMDqNxxRl6GuKOx+aAaQ8ki4n8hYzNIa7KO7Ro308+Tb75g/RDuzCv8qys6jqxtVBUF4VDymHUW7XAC+OSYBeOKmuBXWhdNcgJgSjANryXvjaValsea6gOjvWOtwq/qH5iCk=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966006)(36840700001)(55016002)(426003)(70586007)(7636003)(356005)(54906003)(36860700001)(478600001)(5660300002)(1076003)(8936002)(336012)(47076005)(7696005)(316002)(36906005)(33656002)(9686003)(82310400003)(82740400003)(8676002)(26005)(86362001)(83380400001)(186003)(16526019)(4326008)(6666004)(70206006)(6916009)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 07:44:04.7103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa92e251-e5d4-4287-ab65-08d9259a3255
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 03:29:52PM +0800, Jason Wang wrote:
> 
> 在 2021/6/1 下午6:21, Eli Cohen 写道:
> > On Tue, Jun 01, 2021 at 01:03:36PM +0800, Jason Wang wrote:
> > > 在 2021/6/1 下午12:13, Eli Cohen 写道:
> > > > On Tue, Jun 01, 2021 at 10:18:04AM +0800, Jason Wang wrote:
> > > > > 在 2021/6/1 上午12:04, Eli Cohen 写道:
> > > > > > Only return the value of the ready field if the VQ is initialized in
> > > > > > which case the value of the field is valid.
> > > > > > 
> > > > > > Failing to do so can result in virtio_vdpa failing to load if the device
> > > > > > was previously used by vhost_vdpa and the old values are ready.
> > > > > > virtio_vdpa expects to find VQs in "not ready" state.
> > > > > > 
> > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > ---
> > > > > >     drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
> > > > > >     1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > index 02a05492204c..f6b680d2ab1c 100644
> > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > @@ -1407,7 +1407,7 @@ static bool mlx5_vdpa_get_vq_ready(struct vdpa_device *vdev, u16 idx)
> > > > > >     	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > > >     	struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[idx];
> > > > > > -	return mvq->ready;
> > > > > > +	return mvq->initialized && mvq->ready;
> > > > > I think the more suitable fix is to reset mvq->ready during reset. The
> > > > > vq_ready should follow the queue_enable semantic in virtio-pci:
> > > > > 
> > > > > "
> > > > > The device MUST present a 0 in queue_enable on reset.
> > > > > "
> > > > Thinking again, I think we should call set_vq_ready() from
> > > > qemu/virtio_vdpa etc. after reset to explicitly set ready to false.
> > > 
> > > This is not what I read from the spec and how the current driver behave.
> > > 
> > > And I don't see why we need to stick to 1 after the reset.
> > Like you said below, this must be clarified by the spec.
> 
> 
> I will add this to my todo list.

Thanks.

> 
> 
> > Because my
> > understanding of the text is that the ready flag is a means for the
> > driver to tell the device whether it may or may not execute requests. So
> > following this reasoning, the driver should tell the device when ready
> > should be zero. As you suggest, after reset.
> 
> 
> Another thought, reset should prevent the device from executing requests on
> each queue. In this case, presenting vq_ready to zero make sense. Otherwise
> there would be a conflict.
> 

Right.

> Thanks
> 
> 
> > 
> > Meanwhile I am going to change the code to reset ready after device
> > reset.
> > 
> > > 
> > > > The ready indication is not necessairily a reflection of the hardware
> > > > queue:
> > > > 
> > > > "Virtual queue ready bit
> > > > Writing one (0x1) to this register notifies the device that it can
> > > > execute requests from this virtual queue. Reading from this register
> > > > returns the last value written to it. Both read and write accesses apply
> > > > to the queue selected by writing to QueueSel."
> > > 
> > > My understanding that this applies if not reset in the middle. We can
> > > clarify this in the spec if needed.
> > > 
> > > Thanks
> > > 
> > > 
> > > > 
> > > > > Thanks
> > > > > 
> > > > > 
> > > > > >     }
> > > > > >     static int mlx5_vdpa_set_vq_state(struct vdpa_device *vdev, u16 idx,
> 
