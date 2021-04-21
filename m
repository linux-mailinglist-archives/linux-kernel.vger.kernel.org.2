Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AF3366666
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbhDUHqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:46:52 -0400
Received: from mail-dm6nam11on2046.outbound.protection.outlook.com ([40.107.223.46]:65322
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236352AbhDUHqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:46:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHNw5oihEdM4HAd2hLvbCaq2ApXjKxxT59U68YOJB7sYr9H2gpSR6J8f7sYhZpTiygSQGg/qfhV/7hgizMNyhXmn1AkAZ73A18d1McYcq299bUzCqGvw77CtM1NSxnFQOj/HOfcIZadM6soLb7ldbYfrbtRn8AQvPxdtaXz/SNspo6JGbh6dylDrLMcwsL2fPMSAFzByMUSbFPdlZW0j5LVn3A66TFh9OfeaFQe8J7qwb3SUDsV4QkC8zdV+S52s64rme/cqQ6CqLPMs6+XFOgLbF8cJVEkOfzZ6FraHWd3n+dfbkOIZf4bETcw6JuIgoqq8p4iXpS16kyUA7l+GwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67uUmaJzp5nhhACqHPCJa/Y+kBc3pq3ZZwxZzIkuQ2U=;
 b=kPaUggqWGWRoCFJ5eSmbblhk/eC6uEez8zYp4oIlCt0R0+7ksD04erinzvhSLX/oG5kQzAeEOSv8tJow78KU+/+/BmHNtmphSwOYY2F5nKiTrYHkQMGUv/DtlTYtwZ7N1bEQCK5qT2i1nWo/3/5exdRD62lUZtSnCMqd2Cliawv8xJ8inyxpwBdqjNM/Jr2FOa92KhnlCyTWNXqUeM8d7spO1ld+xvXWfz2IVqikDWp36labkFCJbNhEtbV5nR27BqhSFUWw0m/jvXY0AifxTobiVUeTG6MTZzf0raLbT068HXoIQuFyF0HNpEC4YTFRYhB4Zwejsi/figuU3y3/xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67uUmaJzp5nhhACqHPCJa/Y+kBc3pq3ZZwxZzIkuQ2U=;
 b=LMNeoA4VPxSKcWEE8BF0xQ1y/cepgOVk/QDLMew/u2Sz8yWw3vdAYdg2w4j2G5jZYoy7G9JGCFv2o8EnYLq64Nb4VKKoNfMtqadqYdpBi5u8+l9Pyjt4LOymv9HYy4YyMmxr/OeAOvRDoE+Jv+pEnYYJ/DbpYwn52RxmB6RKW3VdMZhuPmn+0DAb8PnOgRpcfaLZo4rhdouRCgdkqDwJPIX8YPwquySkX8IT6gnqyP2LlhqGGHsMsF7V0YR0iFI6gLH8B2WuPLOE43so3qeaBNpbskdDkuCedAHl8au8KKWD2h1mlhDrPjoXedHncPhhxJYHNmNkcMqtzyJP/i+zSw==
Received: from MW2PR16CA0067.namprd16.prod.outlook.com (2603:10b6:907:1::44)
 by BN8PR12MB3507.namprd12.prod.outlook.com (2603:10b6:408:6e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Wed, 21 Apr
 2021 07:46:17 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::39) by MW2PR16CA0067.outlook.office365.com
 (2603:10b6:907:1::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Wed, 21 Apr 2021 07:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 07:46:16 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 21 Apr 2021 07:46:14 +0000
Date:   Wed, 21 Apr 2021 10:46:11 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] virito_pci libray: hide vp_modern_map_capability()
Message-ID: <20210421074611.GF97533@mtl-vdi-166.wap.labs.mlnx>
References: <20210415073147.19331-1-jasowang@redhat.com>
 <20210415073147.19331-6-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210415073147.19331-6-jasowang@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba299cd8-7f43-41bb-4310-08d904998b62
X-MS-TrafficTypeDiagnostic: BN8PR12MB3507:
X-Microsoft-Antispam-PRVS: <BN8PR12MB35076ADA4E7ED09AB501634DAB479@BN8PR12MB3507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6x/Mjjfxhm2ytwQo6Cp4jVjHA2tWQx8kWmTYBPbwYYdQQmW2g9xUESm6SarCsVO+xvR1JGFhsIz86W3YrUlrmMBV/BQ1CYs0hzw/oudb0SvlzXRcqylFrY7kVM+LH94vXrACkUK+bVbNrfoNRJ7+YIcvAqsxjMfboTx/V/cEOTWUw83v4WboUcnlWmHEWUp4i2j4DkIV3O5EpxTfCnSvnW68eVGLlxgu9CtAHCSsFCPnHWkGaNrHCtbjp6gvCq5vyLNKOgmC7zfq6RAdrETWiW3Ml4xeF558KLEGNkdXZtus+99wdhACouEeXl6+c/Ub3Sn3omXsGUUPzby8+OOBIjzRGKN7B7lVtG+J17jN5mrrCQIJpTK9tWPjx/wzuCWxMswj2hwyp1yGeQR/AQTtIeKr1nWmHYlIupwCZBvAydRtYMG4rpUwaLDVfowgCrEu0y/SJgC9bV0Hq0xf6JvfQrtOxlXXybP1gOv4AIcT8yIrpyJAw+VEnCAMtkNJw3tQ++d5WOZEBPzORQiYYM1O4Xae7NB6l6GjEvhL9MUTbuD614hd8ulZ1Md8mm+iJyJZhqqG4aQj0EP6SwjqkzyteGtjNC0B2X1R2ATkCmUml3n+QRcDJXXregYtAWRMa0VpCbWEr+SU6CDvdcJYn9LmijENpNKL62IiuPYfv8xZT2M=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(36840700001)(46966006)(55016002)(7696005)(9686003)(26005)(47076005)(82310400003)(1076003)(86362001)(6916009)(8936002)(5660300002)(356005)(478600001)(7636003)(82740400003)(2906002)(336012)(70586007)(426003)(36860700001)(70206006)(54906003)(316002)(36906005)(83380400001)(6666004)(33656002)(16526019)(4326008)(186003)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 07:46:16.3546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba299cd8-7f43-41bb-4310-08d904998b62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3507
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 03:31:45AM -0400, Jason Wang wrote:
> No user now and the capability should not be setup
> externally. Instead, every access to the capability should be done via
> virtio_pci_modern_device.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Eli Cohen <elic@nvidia.com>

> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 10 ++++------
>  include/linux/virtio_pci_modern.h      |  5 -----
>  2 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index 5a657e56b46d..9c241c9bd920 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -16,11 +16,10 @@
>   *
>   * Returns the io address of for the part of the capability
>   */
> -void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
> -				       size_t minlen,
> -				       u32 align,
> -				       u32 start, u32 size,
> -				       size_t *len)
> +static void __iomem *
> +vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
> +			 size_t minlen, u32 align, u32 start, u32 size,
> +			 size_t *len)
>  {
>  	struct pci_dev *dev = mdev->pci_dev;
>  	u8 bar;
> @@ -90,7 +89,6 @@ void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, in
>  			length, offset, bar);
>  	return p;
>  }
> -EXPORT_SYMBOL_GPL(vp_modern_map_capability);
>  
>  /**
>   * virtio_pci_find_capability - walk capabilities to find device info.
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index 179a2fb4bf37..e6e7072413c1 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -99,11 +99,6 @@ void vp_modern_set_queue_size(struct virtio_pci_modern_device *mdev,
>  u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
>  			     u16 idx);
>  u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev);
> -void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
> -				       size_t minlen,
> -				       u32 align,
> -				       u32 start, u32 size,
> -				       size_t *len);
>  void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
>                                u16 index);
>  int vp_modern_probe(struct virtio_pci_modern_device *mdev);
> -- 
> 2.18.1
> 
