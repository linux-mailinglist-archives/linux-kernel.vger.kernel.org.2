Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F7C366665
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbhDUHqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:46:34 -0400
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com ([40.107.94.76]:54849
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236352AbhDUHqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:46:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjG5NEKMnJGuzEu3yV4/bzqV//Ue/9PN32dFDuH8AN9onH4c6epEm/QM3mSH/ZVKA34bEmd0CjWuePxVCVZfM/HZpM4Zg88Jk44jlH2UNBhbhr0e6bY24CQcaCcOM47exW5Eq9DDpKszr6dvIaNGdgY8MDv4hwUVnAdivLlerj3Z8ppcgP29QQGbsnMHtZLc52qgYjfV0spMEE594fAL7TE6H5SEi3lXhBrpoXKlcawj/MfaLOWfEfbcBjzJAWhG7hJjG2L5gJSuaII/vxOuNoI/pMbC0b0YtxeUNE0aU+O7wMgk8NORaepERn1QwkGHdDQTQC788nKmi6/ypkpt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoUQFV0hFFxuCb1FI3M/yZXjJvg7nFdfbEN0WFGdpAM=;
 b=EprmnU03F41E2fCpGGouu2tQTfPn5nVZpoIY0O+MoifgF0+5t7GZ7hkAMJ9oeNKdqdGnlxCpSRDTaPGKdXrqDRrL5GoG8wspX2wXYazBPJhz+PsGiWb0UDGO5DOBhOR8NEmZkwXKtAUUSuuqKz1KWWiLdiW6Ie3IZsjbAwk4suIPZK3n+JVpQSWgBpbprB53NUoOnPVQ/lakaRa+djLetg3Gie3V3/+vEPZ7O67j7U12gKfj64+5x8/3PGVY1aazds1RytE0q9kJVxEQi48fPi317ROz1DpZbpHPDG/Vj2omcCDWI52l1vNmTih1G0gfWbA+FkL7j5MiULupAGTbfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoUQFV0hFFxuCb1FI3M/yZXjJvg7nFdfbEN0WFGdpAM=;
 b=SVUPVSxF/CtLbD/8sUiIGZaGnRK+GIazqibaIK46zBtswHVD7zbRtAwGklxsdPHh6/0wbjOJ5XDYMnKmVdLQsnBo1pGIGbGv/lUJvAnjOdGTcpjfmPBnTYPk54YU9wNeQ1PvBd9GnQKe0iHlztTm0mEIvaRnOyx12UZulu55SfEC6yzatJXNYHS49YBfrxSVS0yNd/7wLKOJMJZvfUNJIWYb8s+Bqxxh54nVytiuYKiWrQvbCmo1dKxdt19eY1heRFGrO4atm0rswIfLXHKOIV6M4Swz3vfLUY5KErQUl+SOQO4Vnpch9mysq2HWgNlHIz4Hr1boHtpzByHtU4+CsA==
Received: from MW4PR02CA0018.namprd02.prod.outlook.com (2603:10b6:303:80::16)
 by BN6PR1201MB0196.namprd12.prod.outlook.com (2603:10b6:405:4d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Wed, 21 Apr
 2021 07:45:57 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::e0) by MW4PR02CA0018.outlook.office365.com
 (2603:10b6:303:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Wed, 21 Apr 2021 07:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 07:45:52 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 21 Apr 2021 07:45:50 +0000
Date:   Wed, 21 Apr 2021 10:45:47 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] virtio_pci_modern: hide
 vp_modern_get_queue_notify_off()
Message-ID: <20210421074547.GE97533@mtl-vdi-166.wap.labs.mlnx>
References: <20210415073147.19331-1-jasowang@redhat.com>
 <20210415073147.19331-5-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210415073147.19331-5-jasowang@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8f6c898-0266-49ea-eced-08d904997d56
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0196:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0196CD20D2024CD0B49BC215AB479@BN6PR1201MB0196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XWPcjdw5OJPHUxloE+zpXPk2aPxiWrP28rFbaoKjG8CGF5ZHGKi7Rega45Ipn9ASJBoXEWNnk0A+ZjxaxNhkRDwEwQG51fAtqeWQw/e1t+mlJSYodMGSL7hbz0QabdH38+sPmZJa3oAzBCbUcvlvdTcU57BWhI65HkcX5pk96g3+Og+jY7dyUZmLI+rlQElQUJv8Lbo0v+wXRBEH05ZsCqNnossgZHKbs/3G02lb1eUdTNvAAYUSSS4xHbUvbloNJQEB7kAU0zK+tWS47FB1ZPs0DL6xfY83tSodsfXaZWGDzhEE+jTDJOBdgZqzn/jN/ne0zxn1oWhWK7yE5dbSP34l914tgzvyZJz9PWojssXWAOwBjPla28scG7flq/tZBeBnaphBS1A9YU4JSMPPKuevaeJZjB/Zjq9rSQUydszACB4MSLMTvQzwH0VopmnanqHA6Obp77jot48kcLzJUPLNgR9AqMlclRGQEJa4Mz3kUdg0nkmnd2YgufPPb4rfF3zSCw0gucK/0PXL2ma7I0s7ZdCGCde0gZG7Ia3aD57Ltieln8gsT/a3SkTinMmxeu19IL+KAi03ivi8nNG6GzOOK1wq+4Po2vhUW/cY9UdM8eSo1ICT/NRiYpuYHMgIz+QFEZWaLiVmhORpRJXwEdbD41qvpzPDNu9n89Y91d4vJOpN5ZRKuQAS0HtLLeB
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(356005)(82740400003)(6916009)(6666004)(47076005)(70586007)(55016002)(81166007)(336012)(478600001)(5660300002)(7696005)(8936002)(2906002)(26005)(316002)(9686003)(36860700001)(8676002)(36906005)(82310400003)(86362001)(54906003)(83380400001)(186003)(4326008)(70206006)(16526019)(33656002)(1076003)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 07:45:52.7862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f6c898-0266-49ea-eced-08d904997d56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0196
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 03:31:44AM -0400, Jason Wang wrote:
> All users (both virtio-pci library and vp_vdpa driver) has been
> switched to use vp_modern_map_vq_notify(). So there's no need to
> export the low level helper of vp_modern_get_queue_notify_off().
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Eli Cohen <elic@nvidia.com>

> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 5 ++---
>  include/linux/virtio_pci_modern.h      | 2 --
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index 28cb5847fafa..5a657e56b46d 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -584,14 +584,13 @@ EXPORT_SYMBOL_GPL(vp_modern_get_num_queues);
>   *
>   * Returns the notification offset for a virtqueue
>   */
> -u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
> -				   u16 index)
> +static u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
> +					  u16 index)
>  {
>  	vp_iowrite16(index, &mdev->common->queue_select);
>  
>  	return vp_ioread16(&mdev->common->queue_notify_off);
>  }
> -EXPORT_SYMBOL_GPL(vp_modern_get_queue_notify_off);
>  
>  /*
>   * vp_modern_map_vq_notify - map notification area for a
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index 1b95d39b00fc..179a2fb4bf37 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -99,8 +99,6 @@ void vp_modern_set_queue_size(struct virtio_pci_modern_device *mdev,
>  u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
>  			     u16 idx);
>  u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev);
> -u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
> -				   u16 idx);
>  void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
>  				       size_t minlen,
>  				       u32 align,
> -- 
> 2.18.1
> 
