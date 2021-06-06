Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C785939CD5C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 07:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhFFFGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 01:06:42 -0400
Received: from mail-dm6nam12on2079.outbound.protection.outlook.com ([40.107.243.79]:40896
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229464AbhFFFGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 01:06:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCxFDgNdP5s0giulwf3+fc8iGbjrRS7BovoboOZUcc7bxfaFNh+pLApePYIexAtUZ+0l50/P18MHqJWynkThrgI4kDQagdpK6PuLgr7xga+k7lzmBHgXyLGQhAyVes369D2mT+Ojs/AXXmja/W8NcahsL5qwUHeOpSA0/UTSIA2Jf93d439Z1aD6gq7y2O3oLaXD0d6pt2PIWGMFyfn4xXmL9DforyTgiJjr8NP3k6GBjnYG3VIY9BBhKJNm/m/zekdYyIlZA0pw5jPOY/nOfuhqEDeiL2UJ6INAhs7QPdga5Q67+audnUY6ni12a7J+wCg0HHAgc+YjyHHO6Dlqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JabLZYhHWxz7QHjUUd80G1S3vT7+vt1Wp2jSrGYQNyo=;
 b=nmu2nmg2amUE2wFzqXY1XPduwwCo7ZbWRYD6vqtUVW7rvtBci6dtITrVZMQXr4I7yRNk5N6EHLMvqLu9xuP0BZAakyv0t0zCVQhv2HY0xayi9Z0leQrFi1QK0KbhJu7rV7QtC3VJQo6SdKy8thwVwF+/1AEgBAEgQ0i7RXdaeei/hYKtitjqKvfrjoRm2d5jJlmMBVxGxFJLk3eDA29bSnEnvuGOqRGSvDoPGKkluKHay0idl98cQecUjIlrRifiJjEJZeS7X4gIAVfeV9dtmU9lE8+mHy9g1a206sYTGyIidcG7+EUdfYMDGxlnIU4vyvgdj+Bn5jpr0tdNytW/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JabLZYhHWxz7QHjUUd80G1S3vT7+vt1Wp2jSrGYQNyo=;
 b=Vx9FNpPVTWkHHobw5bi7q3/lJdYFJY0DaV0j1L/KbkYWRbz1KbGW69wplfzvLMlGHQJTQM8OeoPV5Ww9W6IJDKByyxKnA4xLCYBqRwXLpw/miM42f+7/fvWpThgiHCBxuAO3ZI2TzGtDN667Yps4D+L3/gu3XZ3dc3dApKv6g0iv/fPkjSEG17LETPqxBsCBCeMbTYgYVE7FoX8NdE5CEQJKuN1SDZH/U3SyS2cTRMqynMTUEe1HXFKSJDAp1MzqgKL9hR1/R1adweDlfzyRsADtTfgwBJaGdapzZ5bvrcw/9FGklmS2A0hDk/Vf68iJJZShlIXCPb1tBANh6uC1fQ==
Received: from BN8PR04CA0055.namprd04.prod.outlook.com (2603:10b6:408:d4::29)
 by BN8PR12MB3585.namprd12.prod.outlook.com (2603:10b6:408:49::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Sun, 6 Jun
 2021 05:04:51 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::c6) by BN8PR04CA0055.outlook.office365.com
 (2603:10b6:408:d4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Sun, 6 Jun 2021 05:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 05:04:51 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 6 Jun 2021 05:04:49 +0000
Date:   Sun, 6 Jun 2021 08:04:45 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] vdpa/mlx5: Clear vq ready indication upon device reset
Message-ID: <20210606050445.GA189356@mtl-vdi-166.wap.labs.mlnx>
References: <20210603081026.5640-1-elic@nvidia.com>
 <9ec6480d-3eee-c644-2a06-8a180aa9fb07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ec6480d-3eee-c644-2a06-8a180aa9fb07@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1df698a6-9944-447d-495f-08d928a89dad
X-MS-TrafficTypeDiagnostic: BN8PR12MB3585:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3585A3AEECC47BAB9D1FD94BAB399@BN8PR12MB3585.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrRfcMl/8F4SuAWlE5f7QRR8Pj0b7xKFl5qf/oJHYCp6oVK5DPThY1jFyMxHKdKXrxbHMUbkHlpKWlq62z7ZUj1W9HK5IOdbSM3annc1tXHiFsRZcGMDqcpmSy/U68P8RbXJs9VZPSizhMxoo0sJ+oIrSFJrr1CN32FROjvh1iyP6RLgh5vNuL1ciqw8YSvKIbk7wIUP+S8VayV7cC7mu5NhQQSAVJkp3FmKO/aVES86SByRJcDOSH08+B8NWYPmDMzxDu6JkUiDC9aNR9K11iVdduIC+WAqqJHgys385PecQK0q1PXPVqCAgheD2mjbQj87bCRWgXe1yHh3QTYEiwgm6IVUDa1pewlsfddUwFZ55qyX1Kvpb1XzRAqsl/GxQ/WFhgkdnoDYG2zNKbI4dsAOjIaGSayoBxlYg95vOpAEzRzeWJksSLQUPZmJqmXv6B71B97kiNVjyE9c8lLsIGoNDVhK06ie3eLf1Pj4mM/15glslE1rYgMWhnyjf079711tzvmRvg0IVILCw5S85dJEgvgLAtYMxJyPg4yW2qGHaJOMxxRGgsuF7oQBMZoADfpKXJENqpEpGEwpuCXGLz+zuvpqav7HWphu89Ry+F8XOqWtm83bGe8iHPbvW9QihDIekEy7GXgCgTyENGilG5YP6q59xtbNfod1wJwx3dc=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(36840700001)(46966006)(316002)(26005)(54906003)(36906005)(7696005)(6916009)(70586007)(70206006)(2906002)(478600001)(4326008)(8676002)(8936002)(1076003)(16526019)(5660300002)(82740400003)(426003)(33656002)(83380400001)(356005)(47076005)(6666004)(186003)(82310400003)(55016002)(336012)(7636003)(86362001)(9686003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 05:04:51.1503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df698a6-9944-447d-495f-08d928a89dad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3585
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 10:34:29AM +0800, Jason Wang wrote:
> 
> 在 2021/6/3 下午4:10, Eli Cohen 写道:
> > After device reset, the virtqueues are not ready so clear the ready
> > field.
> > 
> > Failing to do so can result in virtio_vdpa failing to load if the device
> > was previously used by vhost_vdpa and the old values are ready.
> > virtio_vdpa expects to find VQs in "not ready" state.
> > 
> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> > v0 --> v1:
> >    Make sure clear of ready is done only in reset flow
> > 
> >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 02a05492204c..eaeae67e0ff0 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -1766,6 +1766,14 @@ static void teardown_driver(struct mlx5_vdpa_net *ndev)
> >   	mutex_unlock(&ndev->reslock);
> >   }
> > +static void clear_vqs_ready(struct mlx5_vdpa_net *ndev)
> > +{
> > +	int i;
> > +
> > +	for (i = ndev->mvdev.max_vqs - 1; i >= 0; i--)
> > +		ndev->vqs[i].ready = false;
> 
> 
> The patch looks correct but I wonder the reason for the decreasing used in
> the loop.

No special reason. I just copy pasted it from somewhere else in the
code. Will post another version.
> 
> Usually, it means it has some reason that must be done in that way.
> 
> Thanks
> 
> 
> > +}
> > +
> >   static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
> >   {
> >   	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > @@ -1776,6 +1784,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
> >   	if (!status) {
> >   		mlx5_vdpa_info(mvdev, "performing device reset\n");
> >   		teardown_driver(ndev);
> > +		clear_vqs_ready(ndev);
> >   		mlx5_vdpa_destroy_mr(&ndev->mvdev);
> >   		ndev->mvdev.status = 0;
> >   		ndev->mvdev.mlx_features = 0;
> 
