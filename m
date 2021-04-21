Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFB036665F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbhDUHph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:45:37 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:53984
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237138AbhDUHpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:45:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5+Atr5FW/qOxW/ktxV4b9yXcXxO5gIpeTF/2vutYKIaCYUOirL0/Ut6q0Ii0CR5Fo2hT4KnXj35rswJGEjjIyYvmdGaZXNKRmqMHuQ4k1VwyTDP799m/bNAGvuMmbmwzJJ72tiMn4WSNqRAwlUc7PtrUP9Eb7poJDy4YGeZGhSoilEAwc1Ktmw/YZKck7hD1dz6FXh9pmrmMTL9ijPf8sGWehhdSwNxk2g73qtnfmCxXPim+nq6OgtmzZmPTr2/1K47sVV78DN9iGh9mIwz/gdE4Pu8M+3V+Y/4U200f8yvACM2KaRRlep698J4JKEw+QD1mLU1wPT8oRN0fj4N/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt0mHb2E6GLk8ZCVABS0GjO+01VKjeCGR4yldC1fn64=;
 b=aVd4wc410Az1T2rbuxnH0zl4HuUnuiWdkdsimfiW0Vpsb7JWqi9/j88vvimeO4wvXNmFQAotd3InjabHZn3cqCrIB47hJMpDsqNY0AWQwcOF/zKf186NVZV6VCmlX1aTgF43JleijphWCUCTgadyL+ZDUixnzG4CJDrirpg5as9wvMYVy2aN8doxBaMZ98eLS8hJrzHo8lQSwBnsEAsowHTAejd8o66OqWZLlsYr8OiF0IgmA9fGunYqKDDF1bhXuI142zhy+57px9/6AU0auwHCWSf1LoRXXJYQ4Yi3valoPkpiFU/1tT7KzpherubQNsXiw7zhS28hhkFMgVURbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt0mHb2E6GLk8ZCVABS0GjO+01VKjeCGR4yldC1fn64=;
 b=XsulaN2wgUj+PmOrAl8QqEztz+t+zNPwRpg8Q/oQuPGb4jwoAWt9aRJsDyYbh/l50KrNxr12YT+jrSOUbIMFk7ATDTDbzMSBCPFZz++Akq4Dtry4up5LgRR0ymsVpku1IDNCo95DRkRpBu6LZU4x7lL+NcManVAeDtYLjgmqbPf3qvwxEgTnd5YCtMKRivISrXBpzcmpWYxROWTuIHX92aByb+i4ZNM2tZxVGMjZUgsy7D7iTgYeUQjDnoclDqXCDTVEKJ5+1ZzWyiTmYflJFQBU1koNR7Cwnv1bOYeK1VQfFoPrtuYAQlt23eEYuU/vxwcUZ9eoelpkSeJIrbrRhQ==
Received: from MWHPR04CA0050.namprd04.prod.outlook.com (2603:10b6:300:6c::12)
 by BYAPR12MB3095.namprd12.prod.outlook.com (2603:10b6:a03:a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Wed, 21 Apr
 2021 07:44:59 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::ee) by MWHPR04CA0050.outlook.office365.com
 (2603:10b6:300:6c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Wed, 21 Apr 2021 07:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 07:44:58 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 21 Apr 2021 07:44:56 +0000
Date:   Wed, 21 Apr 2021 10:44:53 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] virtio-pci library: switch to use
 vp_modern_map_vq_notify()
Message-ID: <20210421074453.GC97533@mtl-vdi-166.wap.labs.mlnx>
References: <20210415073147.19331-1-jasowang@redhat.com>
 <20210415073147.19331-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210415073147.19331-3-jasowang@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3fd6003-4535-487f-a6df-08d904995cd8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3095:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3095C39C72AE09095835404DAB479@BYAPR12MB3095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esnhf/Nu4DD8DRufJb2jHKAFFgnnkBVhVroLcQwWXp07YWauLbDFEu/J3aIGtjW1pXpBBxmllpzanNFwbW5cnBS03UjadZT0MX3awU5Y9nSbaTvpcckKlxdMsSy/Gtin6naePHgodwoyJRhBc5QMLggkv+uVck83GObpGGlgxRYPzcTki5qFpoEqbI2tWr+V9o8b0Kopa3XkoX0WCTR6em8uI+t2AlReaOQotyw7bUM3Dc/WPe2oxeJF8THZxsKejOeHq7SAGIgJpOh0qwIzk2/vomYWD0KbIKUZAgkWx/K9HxSD0jShWTfdeUHERGWx/d2drdpAV8p0ldyxyM7oB0U03V0Ho8/OvNHD7RSvMlOr9riDXvCGCxSQXxse8KUol2ebNT8Tsi4liC2R/0LnIo0ViY/RtjHsqoJ8DVOCGecwtnGhZMQ5inQMF96YkvU8rvr1Mzvlf8Klc0COZi0RdSv0ZIHzMiF7lrPleQLpEOCa0vpBis0zcNZdTNM2lbUMfo/Ena0Yrpr3bcAyIK7IxXxs9ryIgL9rDiS2MpTVNVvU5YwaqDtAfH9GD/VJty/P/Vv+dm4L8hDheVOlgdSL4IlTKUdMfZx+U4It7pD7Zl25EWrRtd0ObL8bELE9PT8jW5SYM7Q3/dsF7baTgn8g86cBh0NITuI+n9OipsdSuuc=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(36840700001)(46966006)(33656002)(86362001)(26005)(2906002)(8936002)(16526019)(82310400003)(316002)(5660300002)(47076005)(356005)(478600001)(426003)(8676002)(36906005)(336012)(9686003)(186003)(70206006)(54906003)(55016002)(36860700001)(1076003)(7696005)(6666004)(4326008)(83380400001)(7636003)(6916009)(82740400003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 07:44:58.2666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fd6003-4535-487f-a6df-08d904995cd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 03:31:42AM -0400, Jason Wang wrote:
> This patch switch to use vp_modern_map_notify() for virtio-pci
> library.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Eli Cohen <elic@nvidia.com>

> ---
>  drivers/virtio/virtio_pci_modern.c | 27 ++-------------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index fbd4ebc00eb6..29607d9bd95c 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -192,7 +192,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  
>  	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
>  	struct virtqueue *vq;
> -	u16 num, off;
> +	u16 num;
>  	int err;
>  
>  	if (index >= vp_modern_get_num_queues(mdev))
> @@ -208,9 +208,6 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	/* get offset of notification word for this vq */
> -	off = vp_modern_get_queue_notify_off(mdev, index);
> -
>  	info->msix_vector = msix_vec;
>  
>  	/* create the vring */
> @@ -227,27 +224,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  				virtqueue_get_avail_addr(vq),
>  				virtqueue_get_used_addr(vq));
>  
> -	if (mdev->notify_base) {
> -		/* offset should not wrap */
> -		if ((u64)off * mdev->notify_offset_multiplier + 2
> -		    > mdev->notify_len) {
> -			dev_warn(&mdev->pci_dev->dev,
> -				 "bad notification offset %u (x %u) "
> -				 "for queue %u > %zd",
> -				 off, mdev->notify_offset_multiplier,
> -				 index, mdev->notify_len);
> -			err = -EINVAL;
> -			goto err_map_notify;
> -		}
> -		vq->priv = (void __force *)mdev->notify_base +
> -			off * mdev->notify_offset_multiplier;
> -	} else {
> -		vq->priv = (void __force *)vp_modern_map_capability(mdev,
> -							  mdev->notify_map_cap, 2, 2,
> -							  off * mdev->notify_offset_multiplier, 2,
> -							  NULL);
> -	}
> -
> +	vq->priv = vp_modern_map_vq_notify(mdev, index);
>  	if (!vq->priv) {
>  		err = -ENOMEM;
>  		goto err_map_notify;
> -- 
> 2.18.1
> 
