Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2B1397153
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhFAKXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:23:22 -0400
Received: from mail-dm6nam12on2084.outbound.protection.outlook.com ([40.107.243.84]:49888
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230170AbhFAKXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:23:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeFVlAUUzlOKkHQM6BXBDMfJGCVwU7zgEWpf38EbKShitZ5V0hK7F/OoQk2jhqjYm2SWhtonyJI21r+oI8B8I8Sksa4hdtqy+9JzK9iKKx01Bl6MS80ptnO2W1ISz8uYM2J09ci/9DwjnPhg+r6tSvaD2E4pRHRY+EbOnZ28s/4ibyBUksa1xN0alMlm/OTRmiLhMAL0sWtfRl2ZOTzlfFBChYUoUhrx77jBumgbuGY5Zexwp7ZvAjtei7xbgc5gKfUNDhPdDKcm9xfPp/Kh3oIzTPWD7+wP7rIR89IKwDDsVul3k4bXhDjt595KDrWxtzx3km1NkqM6rnXbOatzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtJ6K5MTq8N12gop2blVegK5gZGFw937x1l0QsfTdQo=;
 b=YHv1cV/nTJuJCJXKQNKNNmD/CFCm4R4Gsk/OxDCbQSPc/uTryoOI+NfxylG6LMGIYdA7MLpgsgb4pjg7AhuxZZfu31GpaVpF2wnGaUu7fHXPv/uS3CIC6iWbB4WaofoAhVQskjzeXt6e1JalUjzNhGNvQ7TVuNlDA1Sc1i6C2GELh17nu46+krGVin0hXJzN4QmoNdhmRL6VI1RJLTaCs1TM8BjIyWJDdpI27whozF1D635HZLVN798oA2eEv/zPiMArzDYn589cDazJ9lqcBRrWHy1izgBO/sxEjAMH5k0Ddgk8TERM7sEv4BCnno6GL53Sw6cZ0GvjyFVc+Wc6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtJ6K5MTq8N12gop2blVegK5gZGFw937x1l0QsfTdQo=;
 b=rZltYs9iPrlNLxjy2U07fjm8VQbVDkb4UP3Tx6BFalUynDavaAQcll949T/gm9WrtCobCFyF4AvyTgMslUuGXe4eoaA6HAyrFNqlfhgXWt5ZPYVI7dpgPReGbQC/giBJreOLHbCwQkcUMGYilwhlDkWpDLvGj3q3ueHBipWKFfoXU04vE/Ov5p4W+wPmieqLfWAEvgANLHTAF08DGzq5amkg6wlEMM94rNzmmvLwkvmCeLR2BIjGbRU5wD23z7MfiIgWatlOO2orDMdVuWcx0pJYDvtN0ycBvRnI+Z1QkPMhYZbzjXQUqHqDdA2l1PkurKFEHq4R3Jc2Rh0oQD5+XQ==
Received: from BN6PR14CA0029.namprd14.prod.outlook.com (2603:10b6:404:13f::15)
 by DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Tue, 1 Jun
 2021 10:21:38 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::a7) by BN6PR14CA0029.outlook.office365.com
 (2603:10b6:404:13f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 10:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 10:21:38 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Jun 2021 10:21:34 +0000
Date:   Tue, 1 Jun 2021 13:21:29 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] vdpa/mlx5: Only return vq ready if vq is initialized
Message-ID: <20210601102129.GB215954@mtl-vdi-166.wap.labs.mlnx>
References: <20210531160448.31537-1-elic@nvidia.com>
 <0fbd8484-9e8b-d7cc-4996-74306e6e2867@redhat.com>
 <20210601041351.GC203469@mtl-vdi-166.wap.labs.mlnx>
 <67b26a20-b418-4893-a42f-f03852c2123e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67b26a20-b418-4893-a42f-f03852c2123e@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edae354b-55d5-406c-36c3-08d924e70aa2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3993:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3993E461DB5DE894FE754CD3AB3E9@DM6PR12MB3993.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rm9zbuwOjQpMJgKA4F8sfbudYjiXC68yV3G/iSvQ3FPukW83wK1Y252XwGOc6uEvW1MZK0K5aNKJG5pYqFSAKTeGzWXupW3gRcM1N24rEmA8yJ9UOOH1+KDVYhh/vWLZ2m1uOB0ksDi6pP5ewotucBUsJLKcgW3a8DoUUX2ReNHICND6HMcp3nvSfZCGL0dQNmfNVHAIXx9MsZr72mgHHyFUeke+H3abjhpb/UABRFySveyVSF+h+M0xuniMzqEc5othq2mDQxrmNCCgRx0Il7aKg6UnaFBw7xiCFmR1P8KZ3eQHGIP9brLO35rD9cs0IM9XcMc4Dk484iSdcCaLHlew8c+dvkLqFkuUTT1h8LExTc0JFQkpSl8Fgv8Y0Jrou9KCS2Sra/jjlVPS7sRcgwEeKPE2X4UNJvDCx/XHdPLvT3JmPKwYVnzdQGd6PWngNJJQEAcs8eQklt0HDMOS6HyF1vEwCuXiEX2mb71SMbpmRp3cFVsSofQ/ia9xzzgA+0OhjLG7yvTVIP5VVhLXWNa7YScKQyN1gaYA9bgsZiniiGvFy7tLAP7MW2HGt/YHCAnqL13HBFetiHzkxG6SJMwLvKYeGVS32npJSb/GhLnAn4N7JZwxB/0mmvxL8g+YpMlUhq3T4Wafk/pGKG4/UlHwiPL5uKw9HA8tAG+nOR8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(36840700001)(5660300002)(47076005)(4326008)(478600001)(54906003)(70206006)(70586007)(82310400003)(9686003)(86362001)(55016002)(6666004)(16526019)(1076003)(186003)(83380400001)(356005)(82740400003)(426003)(336012)(33656002)(7636003)(26005)(2906002)(8676002)(36906005)(36860700001)(7696005)(6916009)(316002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 10:21:38.2305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edae354b-55d5-406c-36c3-08d924e70aa2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3993
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 01:03:36PM +0800, Jason Wang wrote:
> 
> 在 2021/6/1 下午12:13, Eli Cohen 写道:
> > On Tue, Jun 01, 2021 at 10:18:04AM +0800, Jason Wang wrote:
> > > 在 2021/6/1 上午12:04, Eli Cohen 写道:
> > > > Only return the value of the ready field if the VQ is initialized in
> > > > which case the value of the field is valid.
> > > > 
> > > > Failing to do so can result in virtio_vdpa failing to load if the device
> > > > was previously used by vhost_vdpa and the old values are ready.
> > > > virtio_vdpa expects to find VQs in "not ready" state.
> > > > 
> > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > ---
> > > >    drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > index 02a05492204c..f6b680d2ab1c 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -1407,7 +1407,7 @@ static bool mlx5_vdpa_get_vq_ready(struct vdpa_device *vdev, u16 idx)
> > > >    	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > >    	struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[idx];
> > > > -	return mvq->ready;
> > > > +	return mvq->initialized && mvq->ready;
> > > 
> > > I think the more suitable fix is to reset mvq->ready during reset. The
> > > vq_ready should follow the queue_enable semantic in virtio-pci:
> > > 
> > > "
> > > The device MUST present a 0 in queue_enable on reset.
> > > "
> > Thinking again, I think we should call set_vq_ready() from
> > qemu/virtio_vdpa etc. after reset to explicitly set ready to false.
> 
> 
> This is not what I read from the spec and how the current driver behave.
> 
> And I don't see why we need to stick to 1 after the reset.

Like you said below, this must be clarified by the spec. Because my
understanding of the text is that the ready flag is a means for the
driver to tell the device whether it may or may not execute requests. So
following this reasoning, the driver should tell the device when ready
should be zero. As you suggest, after reset.

Meanwhile I am going to change the code to reset ready after device
reset.

> 
> 
> > 
> > The ready indication is not necessairily a reflection of the hardware
> > queue:
> > 
> > "Virtual queue ready bit
> > Writing one (0x1) to this register notifies the device that it can
> > execute requests from this virtual queue. Reading from this register
> > returns the last value written to it. Both read and write accesses apply
> > to the queue selected by writing to QueueSel."
> 
> 
> My understanding that this applies if not reset in the middle. We can
> clarify this in the spec if needed.
> 
> Thanks
> 
> 
> > 
> > 
> > > Thanks
> > > 
> > > 
> > > >    }
> > > >    static int mlx5_vdpa_set_vq_state(struct vdpa_device *vdev, u16 idx,
> 
