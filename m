Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D824C3984BD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhFBI74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:59:56 -0400
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:24448
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231346AbhFBI7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:59:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kws26D3Bml2JkgPdUZbFcvdnHJXVxQ78Zuc1w9XLrAR9F6juBGSmlmTZyl4llIKMeFBWFoONx1gi+zhTrkBH0sZuqjbDr4ZTY2p7frsT9BsHxJFCKvituC2RXPCf+j1kA1XzjYmnH5b+Ye2iVFYy/la6k9gV21uavUCqqiWTCKHZgNFlm1WsvLzpA6xlrxizT7/JdTaA6TJWyLHnKhlzB6xnOrBogh5NjSvBGvWrgHuiah6HUXc5nyKhTtOHDOqoMMDdDM9Vy15M0JVBgOD9Qgp2bIl93F5zIpxCdVLIjoSSyVjhH13rjg0PkoBxJjeN8wsBARGTOBLh7RRhnGgsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHtkiUfl8F8mFfrYtPC8VRGNsyPfl1chxceNUHylPjQ=;
 b=CpflM1A9IOYiY0WuZG6I0wqK1PKZJwvqfabTNzKPPoBhD2JaRmDwfNPUUTuk18aweBbGGUeND1pYwxS8ff9c6OLjadMShIK7b7JrFOJ9GNXRANBGxiaf/iA6JFrmWMnc08UI8/bw0PkJJyfR48RCeoR3yLezlmifFiG6YiEjaA4XETX+EYVsncWCav9GN4GIVeX/tnEbEjqQEj095uHLfqBjgUAJ4D5G5gK/NMfTcrw+OkHcBkWc44QgBXZRIoLLPyi8+9t5o2TuMkrJW8lAMWbC5YaepPjMA2dMyUMSYXXncmmn0fP8CCm+Affd0eHeQ68PBpvZTqHeuONtbO2g7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHtkiUfl8F8mFfrYtPC8VRGNsyPfl1chxceNUHylPjQ=;
 b=T7y0YmsajBvuwaeEs96FZoJq2zutX94PjqMd4ti8pl/36A9lXii9hTdDh0WBVdhom7seGhtIaq67RJrh9uibEfTqaUAJzp/vvEKAAB7k77mpfixErJavFX4WZr68/ft/zpo7JGFi+UJLrioae2wiIPHGJCPzQUGVMKGG6kUbuN0zC5HmITM0pgS6s3qmQHmY5+kfhG0bpcI815glH09cfg9FtzsF6a3/t5cILCYr6Vgtv5y5Ls0l6x3ZN92KkP7Q7O8A9lYZaFEdLzc7qLA2500C1ZewqJte1PYQqZfGiHo4Pk+OxU8eLdsRZPY/GgHoCsl5qGthluBs2328g9q4mQ==
Received: from MWHPR14CA0063.namprd14.prod.outlook.com (2603:10b6:300:81::25)
 by DM6PR12MB4811.namprd12.prod.outlook.com (2603:10b6:5:1fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 08:58:06 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::b7) by MWHPR14CA0063.outlook.office365.com
 (2603:10b6:300:81::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Wed, 2 Jun 2021 08:58:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 08:58:05 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.187.5) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Jun 2021 08:58:02 +0000
Date:   Wed, 2 Jun 2021 11:57:57 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] vdpa/mlx5: Only return vq ready if vq is initialized
Message-ID: <20210602085757.GA14807@mtl-vdi-166.wap.labs.mlnx>
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
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd6724c0-e60d-43f6-20c2-08d925a48931
X-MS-TrafficTypeDiagnostic: DM6PR12MB4811:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4811C146D82AD0A2CD2E8F25AB3D9@DM6PR12MB4811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewmTMlwnvpzmtJ4us4HNcR8KMdaDLS7osNSB1hGqKAReYgosyRBtsBEh1QdJeKSWtLYzDNCk0Rf5QtWFGDohCkmKYGWPbiK4sraWZIjDGRdUSs9QN18vcjFJrFRdDrtfU276/rONJsuoTwk2yN0KJYpOw5pznAO0TgbCx03laun4a1XFcseBjRrBxPdSVtv6BVIuRFhPbpWRwkTH5OtMVOt7gKmIvS2zkqNZkqEx/BCFQYi5nsrohcGxjmmlumbbxo7MmxrTufe4sU3jlwr+1MvHBxGcNCaeb9LacStXxqC0+pC0dfPcyrtS+2onbdUAnb+1tw0X1er3zuTJiYaxnl6RU6G036dB+raHvy6YBKz5QctwkI+jQwfjFxjZ29CDnPgAmPADgj24OGHWzm33Y6So5dPsVM4eUifkwQxFd7l3BdCcMDI88SVHuAcNRu+X0lKrGMgbpWXHtONE7djydohvus7t9O+QpKaYe6aqmjBRljnpLa27ZfR/TYZDV+LuV3Sp+qyiDxV2S/zmMKFvD63Mv5t5f1c5JmbMnBtJ9mwuFX+BsbGRe4io1yjPx68zRgDYX2hyi0tXDzE8Q+CzlMp/PpQSSLY7UE5eCyI7qv3H5B1iVuoSjdwrjkVIT67UFEJAqDyoYypuR0mQ/xGO4G6i0wDJvKRjyX3WbBfrmo8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(36840700001)(46966006)(82310400003)(82740400003)(5660300002)(478600001)(336012)(4326008)(55016002)(47076005)(7696005)(70586007)(2906002)(36906005)(8676002)(426003)(356005)(7636003)(54906003)(1076003)(186003)(36860700001)(86362001)(16526019)(6916009)(9686003)(83380400001)(316002)(6666004)(8936002)(26005)(33656002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 08:58:05.5158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6724c0-e60d-43f6-20c2-08d925a48931
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4811
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please abandon this patch. I am sending instead a patch that resets
ready after reset.

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
