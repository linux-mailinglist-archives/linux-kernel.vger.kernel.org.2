Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66194366667
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbhDUHrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:47:32 -0400
Received: from mail-dm6nam11on2088.outbound.protection.outlook.com ([40.107.223.88]:4825
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236352AbhDUHrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:47:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTA1/PdvjnAXhW5nYAAybqmWUi7u5wL5SEPBdXehtasABVe5mOzGD91zQt8CpHhLMlFSCwhvK0fdVh/mCoSQY2Iq6+QjeTDMx9tzFkGY5GW/pHZiJ9nju3jDTufPa7p+lUsRvWYPMY6EwAHLrNIdf77fzIUMWmbykvX/51JuOsWobItraWm+YuoAvC1FR9W8nOeK6q/JHJqeNzZqsVlpRnsTtS5jG9jKA8c+sQp+8ZXEQ15zQ9mDtIkyYK3xA5xX3Jp41llHJxJW586ld6atkOpoHO9951dlGeigbPiMX23orH1ff6tdPLilkhXKAPYKaxOtCWXagX5Q16QRuA4Gfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDPDwAYYMzwwPZDpqQKsKwBfkjy6tzNRxE7e5x3K718=;
 b=JQhHK8bwrFvtyZMSkiD/BQjRt2qcuhDateiJUnJeHQ2VjrEYct8b+IVca17SClNi+wCLWe0YXagdaRRuO2yfxX69etgPxnPaMB9LWWRSh3qzRXAPfFhLOKQ3qUWNZTGcEjgGid5ZdOE+r+/b33KYU/4rzT9c453jSTJCF4Sy83ZzaBByZY2VjiIw9FkcsYsiT4RiEItwPsCGc3CXXEwSLkcFNbryXZq6DS/kvJNGkuR9AeQeFze7hdKuD60z9wYKAWv/DUX4yTT60jolv3R4yaKGUzpWv82jPhLlmMsxrQX97gFkbvwnzb5JNvFofiGBQ4je/q7kQBgylEMnBdwlXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDPDwAYYMzwwPZDpqQKsKwBfkjy6tzNRxE7e5x3K718=;
 b=o2yK0ZmNuX1yrjLAq6n/EhS2EnltSzRF80BZ0G/x9ghMDdB1N2DERqzPdMsHqoqq7xGMXTSOY4BVYfPVvaN1b+BIzNRQXUZL7q+3ipfVeaIhLQqxz3L56xFn2HWEg6ZoV3tmj4BWn2SJRyv+sWddPoqjZT1umAChEmjxeaDfjs1qfL+lTIQD3trVx5SgfRUoWZRA71OP1J+6RxeV2tqOU8sLRld/ZmCBlgiBS5uROd1DIi0XBFNPXYn5Y7kAvRBi0F67y0CAyhGn55kWa6de6ORV1pE1QKTf+no8RJnAEwVCVFvIJIOWImJ/Dx6iVWqDaIWz0fxfAXpxazpDZBurIA==
Received: from MW4PR04CA0054.namprd04.prod.outlook.com (2603:10b6:303:6a::29)
 by BN7PR12MB2771.namprd12.prod.outlook.com (2603:10b6:408:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Wed, 21 Apr
 2021 07:46:57 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::8c) by MW4PR04CA0054.outlook.office365.com
 (2603:10b6:303:6a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Wed, 21 Apr 2021 07:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 07:46:56 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 21 Apr 2021 07:46:55 +0000
Date:   Wed, 21 Apr 2021 10:46:51 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] vp_vdpa: report doorbell address
Message-ID: <20210421074651.GG97533@mtl-vdi-166.wap.labs.mlnx>
References: <20210415073147.19331-1-jasowang@redhat.com>
 <20210415073147.19331-8-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210415073147.19331-8-jasowang@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37c51a74-4a0c-4120-aaac-08d90499a36f
X-MS-TrafficTypeDiagnostic: BN7PR12MB2771:
X-Microsoft-Antispam-PRVS: <BN7PR12MB277156C9FBE70068B489A422AB479@BN7PR12MB2771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:57;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mvy4bWjpPARNgP4J829dsAzMQOaRTGRwbmJZHEwOEOEjo6k0YRR7P4dmfb/vLYTbJEPsXcP9RvKys48Ijh+MKsdRhTa/ZpAIQUylS4lcx/iIOK3fVrAlpFjnVMx2MKCFKGW/stVY5JX5Fkv1BukL+v2/K7ImWxPsJqdPazC/VASI4VXXS9U5kw6fyNYX8Q8lW4h7LHVO+vadC00okdKndXGv0EUbWJD6xJpxzH87PxjHOJUubd3lNG8/N8gH9fmCUpqbMNtqYvnNLwK6oU1PovX+voZW15+TYSWs/LO8dZ2XIZTSRxAVvla3ncnBA99ETP0qgpKyz6E5OnUUxPLlxAdwlM3q/zaQb9dI/G+J/kCqoY2W7dtyprzHaVeDjnHY14HC43lXHUWnPLlcXLa1IGxEjM+Sh8joLLjFASOndSV/4/awRDdI/Fdd66qz4nXOX/t5w/CSxKkYghJSqz8PuWf0grS3wtXuB91nlEnwdqQtid3nVj9Js7PBhf4fT+RfEJLgVOWrfZ2pgDNkFVtBHkJzyb7k68+cf0eBhPWsRB4Ne45+cf6Upr2hICpl3unVQFbzH2IFSOuG9En2uUqpnLcnqElhIm92XQF90HdmzvFTWLiDN/fISYubi4Rt3SatcVNfug/C9c37IRz7D0iWfQNo+6nqoe7mZqDtGGiDeHA=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(46966006)(54906003)(8936002)(33656002)(55016002)(186003)(26005)(16526019)(6666004)(36860700001)(2906002)(70206006)(4326008)(9686003)(36906005)(6916009)(478600001)(8676002)(1076003)(316002)(336012)(5660300002)(47076005)(70586007)(86362001)(82740400003)(82310400003)(7696005)(426003)(83380400001)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 07:46:56.6968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c51a74-4a0c-4120-aaac-08d90499a36f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2771
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 03:31:47AM -0400, Jason Wang wrote:
> This patch reports the per vq doorbell location and size to vDPA
> bus. Userspace can then map the doorbell via mmap() via vhost-vDPA bus
> driver.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Eli Cohen <elic@nvidia.com>

> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 98205e54d089..002b928d0ca1 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -26,6 +26,7 @@ struct vp_vring {
>  	void __iomem *notify;
>  	char msix_name[VP_VDPA_NAME_SIZE];
>  	struct vdpa_callback cb;
> +	resource_size_t notify_pa;
>  	int irq;
>  };
>  
> @@ -336,6 +337,19 @@ static void vp_vdpa_set_config_cb(struct vdpa_device *vdpa,
>  	vp_vdpa->config_cb = *cb;
>  }
>  
> +static struct vdpa_notification_area
> +vp_vdpa_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> +	struct vdpa_notification_area notify;
> +
> +	notify.addr = vp_vdpa->vring[qid].notify_pa;
> +	notify.size = mdev->notify_offset_multiplier;
> +
> +	return notify;
> +}
> +
>  static const struct vdpa_config_ops vp_vdpa_ops = {
>  	.get_features	= vp_vdpa_get_features,
>  	.set_features	= vp_vdpa_set_features,
> @@ -343,6 +357,7 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
>  	.set_status	= vp_vdpa_set_status,
>  	.get_vq_num_max	= vp_vdpa_get_vq_num_max,
>  	.get_vq_state	= vp_vdpa_get_vq_state,
> +	.get_vq_notification = vp_vdpa_get_vq_notification,
>  	.set_vq_state	= vp_vdpa_set_vq_state,
>  	.set_vq_cb	= vp_vdpa_set_vq_cb,
>  	.set_vq_ready	= vp_vdpa_set_vq_ready,
> @@ -416,7 +431,8 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	for (i = 0; i < vp_vdpa->queues; i++) {
>  		vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
>  		vp_vdpa->vring[i].notify =
> -			vp_modern_map_vq_notify(mdev, i, NULL);
> +			vp_modern_map_vq_notify(mdev, i,
> +						&vp_vdpa->vring[i].notify_pa);
>  		if (!vp_vdpa->vring[i].notify) {
>  			dev_warn(&pdev->dev, "Fail to map vq notify %d\n", i);
>  			goto err;
> -- 
> 2.18.1
> 
