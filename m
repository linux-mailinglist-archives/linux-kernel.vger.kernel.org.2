Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49192366661
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhDUHqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:46:08 -0400
Received: from mail-dm3nam07on2074.outbound.protection.outlook.com ([40.107.95.74]:30688
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236352AbhDUHqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:46:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1xQ+PP8kZWVMuhbV1RhevYG3vpnJWe2vzQdaGMiJTZwcLP6lNCKMZiAl0OBCCdoNUe4uW+jcrhWMzz6VeOj2V55X3gbVk7xRD7dBpXrFIoXDaZ80ppKhFfh4tIsf4L08yzIWRznCNrTh1I3JnfFP+Jtwuk5ne0Jcz4dQz2R/M5imLVkFbzbZuyptz82T00rKx/DFl6BqmWVc121r6bKgcMy1rQ9hpj34lCjmgkAM5eSowH8SaC4hkUnvVTgbQLxoHXlrFFFc1dWZiKkQM6WaBKMw5qJJfLZODSOz1WuQeQaK9D90HOQ1Uk01J0V8QnmnUTzKZGv8Qz7TMrGK3mYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBpTQaIC1Dw9fkiCh8Bgil8VqsO4MzyUzmmr6HdL+Gw=;
 b=bqsGfKW+ANg3Y4VU8O0DtFSpnXMWo/lf+umWkxhc4dCl7Zk60WiJ0N+c4yY1HzbVWs6vyeXfr7IK8+5UDEg1HdEwaKmQGubYI9qktxDrTt3OQ6PuF5Hqnzk26Be2gogl1AdOLpGKb8mb+moVXiEttQFRapasNV9iOnhNhuXWCTRyQawPCTkfUj1UYXjJP0SGUALYqeHytTrbLLHKbtGZDyb0FF1JQpgvubsaLRv8k0GEyBriGL17noCYiown2k6zYFYf4JLcjhZsAAKJsmBRPUluTx0JNIMVUXQmAUpZ3afo+ZTgkTeBZ8c8Eee3QkM73JL3g/ObZXTlz3CB0Y6pOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBpTQaIC1Dw9fkiCh8Bgil8VqsO4MzyUzmmr6HdL+Gw=;
 b=dFy5aEvrKZ393nzecwISSTTgqfca81QCZoKW5vrATu9S3EC63XEpigASwo4xf3uQsItwHEwIOxsa4sh2TXIVoKwkmwa/U/wMYOgFnMJxeqoGupvFhoxtjvXSH/TWUWg39fu0i9/HM4odMt2kHRSgoPFYscvO/pmY8Qp2d8gdqWYyh+JefHnY2OqHQmtFZQgKnmhco2noCKAnDrmeGRvaRMdSeesMX+txjqpfiACGsjFcbgAKklUzDSa/61IgaW1q7Zer3i1n2sRGBi1la1IlXECiu4HHivSyzW3jTTaOo4bpEQc3AGRdtgTzZW+NpszrrGvSZ3X30RlQ23zDD5ffpw==
Received: from CO2PR04CA0169.namprd04.prod.outlook.com (2603:10b6:104:4::23)
 by DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 07:45:24 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::f2) by CO2PR04CA0169.outlook.office365.com
 (2603:10b6:104:4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Wed, 21 Apr 2021 07:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 07:45:23 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 21 Apr 2021 07:45:20 +0000
Date:   Wed, 21 Apr 2021 10:45:17 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] vp_vdpa: switch to use vp_modern_map_vq_notify()
Message-ID: <20210421074517.GD97533@mtl-vdi-166.wap.labs.mlnx>
References: <20210415073147.19331-1-jasowang@redhat.com>
 <20210415073147.19331-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210415073147.19331-4-jasowang@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a31a601f-c4a8-4b26-fb74-08d904996bac
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-Microsoft-Antispam-PRVS: <DM5PR12MB236007172C426F1C634FFED0AB479@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:27;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ts8j10IfC8aC/Zp2VdiyBUIVrNdH0o9ADOyZ261YMHQeQI8i4jIgHmJduZKZJ2uYr5lRaCLY6igo03Nb949iCTNlLUBDrt8fLII9R1UckEbV4mKysdvhUgVuscnLhGRSvTlPTEfX91EuQLt5MOVb18E4sFH2Fawv0qIH6plzInYBDntuJFgC3+nOLGRwTSJ5nbDuM44IUVetT6DxEVhNVfGBuG9XS7e3jc9wxJtH3fmWh8mDnIpEutYNw0lP0ieMMfbrjYCdkWdFuNN3bD6IZbgrobVwhnks/fHPeIa0Axn5oGFpNiL3Sw7nKWXST4hXkFIJpTPmTrwhY6qkkNOyddS6tqaLTFQzIZA/5gsk9+KojM0jxlv0IGyYPDFEFrqvljwNz1Un7Hm6b3BhCbdvYlyLscQRhQQEhFfNQs3ZQra4pdy6v13bPvdirOKP5WFrAl1wvi22MqsIfhjrW0T04oZtGm1GLSaL7Aiwji6JOYtjXxa9csUHH2JgE+cEJ1wlIPJJZms6ndoHfqkiTle4QExJAAj2wXWf71SCZ3T9BGL1R/tcuaG4aCbIpc+bSNo26/Cbw2zYT2jxm7F4jQmemPfxHqOIpqTQpdIHoCBNBP64P410hHo4rkEXV1GQGNhfMS5q1UtIUpWJDpZeynFFz1ffMSPMasEdqI6QRTQbqdQ=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(2906002)(36860700001)(33656002)(6916009)(70586007)(6666004)(55016002)(82310400003)(186003)(54906003)(36906005)(86362001)(83380400001)(1076003)(316002)(16526019)(26005)(47076005)(336012)(356005)(4326008)(7636003)(426003)(7696005)(8936002)(478600001)(8676002)(82740400003)(5660300002)(9686003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 07:45:23.1382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a31a601f-c4a8-4b26-fb74-08d904996bac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 03:31:43AM -0400, Jason Wang wrote:
> This patch switches to use vp_vdpa to use vp_modern_map_notify().
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Eli Cohen <elic@nvidia.com>

> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 1321a2fcd088..2afc90645660 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -369,7 +369,6 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct virtio_pci_modern_device *mdev;
>  	struct device *dev = &pdev->dev;
>  	struct vp_vdpa *vp_vdpa;
> -	u16 notify_off;
>  	int ret, i;
>  
>  	ret = pcim_enable_device(pdev);
> @@ -415,10 +414,12 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	}
>  
>  	for (i = 0; i < vp_vdpa->queues; i++) {
> -		notify_off = vp_modern_get_queue_notify_off(mdev, i);
>  		vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
> -		vp_vdpa->vring[i].notify = mdev->notify_base +
> -			notify_off * mdev->notify_offset_multiplier;
> +		vp_vdpa->vring[i].notify = vp_modern_map_vq_notify(mdev, i);
> +		if (!vp_vdpa->vring[i].notify) {
> +			dev_warn(&pdev->dev, "Fail to map vq notify %d\n", i);
> +			goto err;
> +		}
>  	}
>  	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
>  
> -- 
> 2.18.1
> 
