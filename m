Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E483CF527
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 09:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbhGTGe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 02:34:28 -0400
Received: from mail-dm6nam08on2083.outbound.protection.outlook.com ([40.107.102.83]:45505
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240085AbhGTGeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:34:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyU9K0AuH+zoPhyMDLi6+QIfX6ScRLeBaDW+6WeawwVVSoigwPqFZHOK7/B1z6DkMtNmA3FlSik6dJWGcQAFHtbtZ+NFp3owA4If7pannIX5mkgYKLpuGH0VkwYHaafUzTU9oU67usLoNFGYaglcVBD1/ySjvvAXLyvt6+D26JJ/I+kc/dE+Gm6TNszzk4mCo6X0ojgKdGgw5xnx4ppJKbyqHxuEXMMlK91fORdpPh7DyldlC6m2xXcEcEhVqYxTFbvRWM75KRvTaikAqIFv1b/fpfUWLt0851KHInNGoSnvHf5l3yZyhCpB/hhJ0ky8LKWyQ/rKK9ujF8CnJIaztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS5mzRANpfNVWVhYIaL401HcxB6S6QLOhErwNSp9yDM=;
 b=YDHKkpOvXrFm063CUTsYionRO/y+AxwTnYfPOkJ37Hb0xSwDDGp9YGMOH5APzCDUscisLkYxIx7q0C/wF1WN5cCbsDBwCdWpKZ0DqD0LOnX2Dq7J/7ADdxPBHrrX311yl2TLb7q+hbR/ZPtS3EvODtQZRp2UpAMxWLtAJF3fTJzt+VuOss3QapZNNHAHCPj9PVJYNmjx4tlYJXJN+yNfsglz3yd+BuSyJA4r4BiggIK/LhQh0Mg9qD//6s+dZ0d8tKDMxmYgO/EMK5YKxGaG9ey+dBrijHhTLMHXiU4U4L87wekJP6OYSBy4kYd4TVh2ybmlx9wM+lVC067nGD7s8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS5mzRANpfNVWVhYIaL401HcxB6S6QLOhErwNSp9yDM=;
 b=iZ7VNUGlD3tDNri0xDnwyLIY3Dg78ENbeL6HNGfSjEWs9G4hwkCLy6d89jU27NR0UM8uU6Sx+NKDsmO+FC7wMYQEvqoRah9ZgL1aBaCwBw4ljL938h+N/UXY3MNMvAemsUyWokzkNGe+9KFHSRivTwnrUKY2CANiJYeaLZU0BN5qXQvs9N6wMB78Q1DoL06ADyj5dN8IEQZlYQLpjzsEzkzqkBod0NMOTYJqAUUj+06m8PdM+nTv0bvhzF9L33Ng1M3nwploRzhzkfHjQVzZyuWbySAnWGwPLM3MQ/oH4W0P5mcNqUl7P0Sy+uXsWer/HkJkmXShorM/yjXdBGYgoQ==
Received: from DM5PR06CA0063.namprd06.prod.outlook.com (2603:10b6:3:37::25) by
 MN2PR12MB3920.namprd12.prod.outlook.com (2603:10b6:208:168::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Tue, 20 Jul
 2021 07:14:40 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::8) by DM5PR06CA0063.outlook.office365.com
 (2603:10b6:3:37::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 07:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 07:14:40 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.187.5) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 20 Jul 2021 07:14:38 +0000
Date:   Tue, 20 Jul 2021 10:14:35 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
CC:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] vdpa/vdpa_sim: Use the negotiated features when
 calling vringh_init_iotlb
Message-ID: <20210720071435.GA4647@mtl-vdi-166.wap.labs.mlnx>
References: <20210720052533.415991-1-elic@nvidia.com>
 <20210720065740.56udn3ndebzvu26o@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210720065740.56udn3ndebzvu26o@steredhat>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba0c638e-f697-4b45-5b54-08d94b4e0a7f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3920:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3920895B13488E50DB502001ABE29@MN2PR12MB3920.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rEAp5w4WIGhWl311VR1bzE2Wtwlv9BoTbMS08pbtpOgTx1iHWsWDHu7sTWEC0+a/410Y5QSe/GbtNeFBWAuwiAyVuxpxBfkzwMhFS37P9Fk6w6VmbJkHRv2mcbzvy+ubwez4ujUFeU7OZOW2+oMWSgenUSjHGb/lRVAjJHFRnvMn7MnkBuhFCMcjtIw03DONAxVEQdImz3dPUI+nGqxYAI2RRxtTkHHgoQC57qaZDb0YCgwTbkoGAa+JahZeqJvTW048DIkNtQPTiN5x5FXUe0+ptWIj6jW6L299MwCbp/JcwyBGT7JYd5LnaGURirITQNRmUF30jE8DimsV6sw3D4SUTXD5DOedI6weyDpUa+kT8jSbdNvWuoW/p0qcDuT8mbv6NVTu3Qf2quQ/t0zOD9ORhGs0AEdh9hVRBRhTTkgLlGMd6WtdZDtTp1k2FeZ82sW48alg3k+LPOhOOZICbCpt2tOAmwogjIKajQUFLd/w/YiJGptoxCT/9bhtJqdETpK+7Hsgyqk85TPTA+gX51h1CW6/FXFXW5ESG/6U9YxsQm378QOpGrDQO2oXHlWGG31mBF9ljSOJmbFmCPySX3XRZa6VjpIamdTu6iVFDSJ0mt6gLJDKNsRDEd07qSPjNhuqt4GoTY6wE2C0KWI0lTJD6Ke3tPDZRdMswQjqrnbyzdInilUYvzisociDrKJ4jnn6tNrPOGtalOzzrYrqQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(36840700001)(6666004)(8936002)(36906005)(26005)(82740400003)(356005)(7696005)(2906002)(316002)(5660300002)(54906003)(33656002)(55016002)(70206006)(70586007)(4326008)(1076003)(83380400001)(36860700001)(8676002)(47076005)(6916009)(9686003)(16526019)(86362001)(336012)(186003)(478600001)(426003)(82310400003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 07:14:40.4077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0c638e-f697-4b45-5b54-08d94b4e0a7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3920
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 08:57:40AM +0200, Stefano Garzarella wrote:
> On Tue, Jul 20, 2021 at 08:25:33AM +0300, Eli Cohen wrote:
> > When calling vringh_init_iotlb(), use the negotiated features which
> > might be different than the supported features.
> > 
> > Fixes: 2c53d0f64c06f ("vdpasim: vDPA device simulator")
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> > v0 --> v1:
> > Update "Fixes" line
> > 
> > drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > index 14e024de5cbf..89a474c7a096 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > @@ -66,7 +66,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
> > {
> > 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
> > 
> > -	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
> > +	vringh_init_iotlb(&vq->vring, vdpasim->features,
> > 			  VDPASIM_QUEUE_MAX, false,
> > 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
> > 			  (struct vring_avail *)
> > @@ -86,7 +86,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
> > 	vq->device_addr = 0;
> > 	vq->cb = NULL;
> > 	vq->private = NULL;
> > -	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
> > +	vringh_init_iotlb(&vq->vring, vdpasim->features,
> 
> vdpasim_vq_reset() is called while resetting the device in vdpasim_reset()
> where we also set `vdpasim->features = 0` after resetting the vqs, so maybe
> it's better to use the supported features here, since the negotiated ones
> are related to the previous instance.
> 

I don't think using supported features is valid. Better to make sure
vringh_init_iotlb() is called after the features have been negotiated.

> Thanks,
> Stefano
> 
