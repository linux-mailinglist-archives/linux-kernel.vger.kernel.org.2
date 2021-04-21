Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641AB36665B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbhDUHpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:45:04 -0400
Received: from mail-bn8nam12on2052.outbound.protection.outlook.com ([40.107.237.52]:4321
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235209AbhDUHpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:45:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXGsGmd1nyvyo83+M6uHOtygnp0sAT+PQmhRpIZRMm9Ciip8DOV78IqEO7UZJboMHOYPb5rIBHbfnM9hGrReS9iCUGp+ImgJgmCLUipSSL2ZaRa0NnvpHg8mM7eV8lVlr9qH0vVsKK8DZZS0jVct0SUvaqFS2gLs8xJvKPeAOfA5zvtn1YSEIuydXAoalaMae3LM+PagJQ5D5LwiJmW0YCfr9JuQDIAPBjLZPeDYv0RJykcPbZ2uxU+aD5mnf9y3JbpDr+0BI1V9EOBAhfojCUyTRs0lFEdC5gKVWdcIRlYxoF9EN3AIP27PUfw5nm8D47rHlNHt5auhkVlYq04bTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVHkG7JWktpV/M73MTVH7ekIq4x1VzLaZeV3XwLIL90=;
 b=DAS9jelFzyZtR4PYiFN9N/DY897jNF0Zzj+3czSW81YFjE4n546YswrnYKbWx0QSNH1L14OKDaK9bcytmhhcyOe0Ofuv10MBI2CCSBXZgZT5UahMQJ+UzDe6mhyUIcpbHxOgLGv8/fcrBjJy4VCZjfplBe8vS/Nf1awlwqGyl4Q3tZUu0cijK8+rXTCFWkL8AXta0NxB9MW/a2DXPke1eljYaIBBLYPczNrVAOUevULobMpmY1fUn9X7Qscj7j5pO/sEu94d3pijrvGkB86dadMTyhhmYIiv3mumP6/nMv8CYYrlpAqlHLDU8dvPIaegZ9CRjIJtSUVX7Fp0KVSSvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVHkG7JWktpV/M73MTVH7ekIq4x1VzLaZeV3XwLIL90=;
 b=oa+w6qpeVkfJaKDYUX+JvfpumugGi432ZwesKKK4ooGsKKhSv0nwwrdVD/oTfpq54pYzlT3+Gp7oEJX0E9p4YcGd6AvhT2Y8iRgRehlWlroqGmKZ8n6FcWzhAdjBw1SaMdV3P3lG+AwOBJ226f7tID5ukIBVp793Y/R+MBDKf22IvzdUm3zRranwfF7gkus4A9m3gfJpfCMgCwiu7es6pIvkvFubBBVb3i9dQcqZcfaXWdddbPgg2DM7kvaa1dyx+yTGxPGHGCC64nLV/nfsC1JcIWmdf+vgJxOvfhX7W9ZLYKKupCrslgZdd95qB+yp0JIb8zDlD5uuzhZoqp5sMA==
Received: from MWHPR1401CA0013.namprd14.prod.outlook.com
 (2603:10b6:301:4b::23) by CH0PR12MB5201.namprd12.prod.outlook.com
 (2603:10b6:610:b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Wed, 21 Apr
 2021 07:44:28 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::c0) by MWHPR1401CA0013.outlook.office365.com
 (2603:10b6:301:4b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend
 Transport; Wed, 21 Apr 2021 07:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 07:44:28 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 21 Apr 2021 07:44:26 +0000
Date:   Wed, 21 Apr 2021 10:44:22 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] virtio_pci_modern: introduce helper to map vq notify
 area
Message-ID: <20210421074422.GB97533@mtl-vdi-166.wap.labs.mlnx>
References: <20210415073147.19331-1-jasowang@redhat.com>
 <20210415073147.19331-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210415073147.19331-2-jasowang@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce51e9be-cc12-4e4d-ba55-08d904994ae5
X-MS-TrafficTypeDiagnostic: CH0PR12MB5201:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5201B3A0EEF1688428D1C67EAB479@CH0PR12MB5201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPEmcGrXwd2b+vW4C2Y+M/WT92BVlgZ65c6bXXCstBYlYsDpRmGIYnwnbLY9zHchAK2uW8/Rjouvs2YW1CSjGxkWOve5gEgePIUDE4PeTwlRslZ8WjL8qPFoq7xwC3er/1ubvP14IGEqOZQiMLCI/BKfMIzBLIA7SFicXdBaXHRCSgg/7uvQEJA1kk8FtsfVHUS++WBt3R4x9U1YZLoNkjzdU2Tv8FbHsMz/i+6AG4TM3Anvp664dnRAH3vQzU+9Q0rNL0HjkV/C8XPww8WOg5wuc11dcmWYZehicRAHSl8F3wTznmUeDn9i0Mf3aMLRi13KAGn+ops9r8nTByDXo08zqP6xXJa4qGQUgkhahU2pLtokQcappQRrGvwTstds0W6pH+zbAA7WInRYfWireL8UxytqnmFPuyNh5XAPvtxIe+PMBYid3CFx7FLIa81YfntLkSP0EKOCt48HFNj/TkH2NBHrIklZv6s3zWUX9118y9ojdB7oOi8rPhj83WTCl99mMGUOY5O3KSnkrWGIpRnwKTpqLtTthLn2e+4RyxDrP0G2mTtuGjT+6OSRGNLPwkbvraZuEwO+1/o8C0qhU0OCGtATVgRuE5huaAzW/sjJM815Wo5zpbrZV3y3Uo35r7UhWfrEEZk57quwBdnPmVp/OyT2PuckWpaC/RP/wJM=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(36840700001)(46966006)(36860700001)(6916009)(2906002)(7696005)(478600001)(316002)(4326008)(83380400001)(336012)(9686003)(356005)(7636003)(86362001)(5660300002)(70206006)(70586007)(426003)(82740400003)(54906003)(47076005)(33656002)(1076003)(55016002)(6666004)(186003)(8676002)(16526019)(36906005)(8936002)(82310400003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 07:44:28.1603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce51e9be-cc12-4e4d-ba55-08d904994ae5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5201
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 03:31:41AM -0400, Jason Wang wrote:
> This patch factors out the logic of vq notify area mapping. Following
> patches will switch to use this common helpers for both virtio_pci
> library and virtio-pci vDPA driver.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Eli Cohen <elic@nvidia.com>

> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 35 ++++++++++++++++++++++++++
>  include/linux/virtio_pci_modern.h      |  2 ++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index cbd667496bb1..28cb5847fafa 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -593,6 +593,41 @@ u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_get_queue_notify_off);
>  
> +/*
> + * vp_modern_map_vq_notify - map notification area for a
> + * specific virtqueue
> + * @mdev: the modern virtio-pci device
> + * @index: the queue index
> + *
> + * Returns the address of the notification area
> + */
> +void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
> +			      u16 index)
> +{
> +	u16 off = vp_modern_get_queue_notify_off(mdev, index);
> +
> +	if (mdev->notify_base) {
> +		/* offset should not wrap */
> +		if ((u64)off * mdev->notify_offset_multiplier + 2
> +			> mdev->notify_len) {
> +			dev_warn(&mdev->pci_dev->dev,
> +				 "bad notification offset %u (x %u) "
> +				 "for queue %u > %zd",
> +				 off, mdev->notify_offset_multiplier,
> +				 index, mdev->notify_len);
> +			return NULL;
> +		}
> +		return (void __force *)mdev->notify_base +
> +			off * mdev->notify_offset_multiplier;
> +	} else {
> +		return (void __force *)vp_modern_map_capability(mdev,
> +				       mdev->notify_map_cap, 2, 2,
> +				       off * mdev->notify_offset_multiplier, 2,
> +				       NULL);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_map_vq_notify);
> +
>  MODULE_VERSION("0.1");
>  MODULE_DESCRIPTION("Modern Virtio PCI Device");
>  MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index f26acbeec965..1b95d39b00fc 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -106,6 +106,8 @@ void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, in
>  				       u32 align,
>  				       u32 start, u32 size,
>  				       size_t *len);
> +void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
> +                              u16 index);
>  int vp_modern_probe(struct virtio_pci_modern_device *mdev);
>  void vp_modern_remove(struct virtio_pci_modern_device *mdev);
>  #endif
> -- 
> 2.18.1
> 
