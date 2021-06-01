Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FB2396BF1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 05:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhFADoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 23:44:38 -0400
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:47330
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232516AbhFADoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 23:44:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxKyykKAFxRg+ycSc7InlFQ+bAQj1Q5jA0uvKM8I2ww+/Q+OKd5P6Uva7ZPW1zehY3PDCOCGNkv71hsCECzWh4+8VJl332QdWcBl0oczCv6fkJiRoDK/CDjL3YKLvF7RU/wYIOlx+imQc3eP1kzV5oUkjYc5tNiJ1exX3RLmLv75Nk/RVwjIcHSwWYZ4qk9oPlgd/3hfoBkRpTwHQwhmZqsIBuGlqLy1hzAvlc3sREwwZ09O4Orgaii0z0FaKMyY3bSWt90+Cht31pPiDQYSuFKqEFH+iQUYvO/hXu+hWelHpJI1C78yjEvVjVm/ZBCkNpVadlTrWhNklVsCQDS1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myw7op7IAdPeHY0NLUX9NjvgcDIehiYx8jeeq/Yynrg=;
 b=kaBnqBf4jnC6Qqc9zRNLHWRcI7rLdECMw6M/PBtnVIoWiBobxgUsfphpAcNtiZ5yA0fdaeYCJjP1lo3RxLVB2IS+ehmgdgq/NLX3bQE+xZMzTJNno+1NOp/3L8JltoW73c0AWfDPcxtBlLw4LLNAxThTnstme2tbS4n8wqBcPYbrx7BtDCjuFmcXAS446rIWqmqT8kKyjE+xOUxO2sA+sS1ypICDep7/9mqpoMxo4if5/440JguqsfnehZ8VBzRLHlqpUgDqFRqCpjO2f7a5hwJKfpube5ZORp+gaMPMsEFM7p4E+gxLlOGEt6FpyuyEVl4sNbPnJbfzfcT2RhKIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myw7op7IAdPeHY0NLUX9NjvgcDIehiYx8jeeq/Yynrg=;
 b=gCldvHU9oUM2fAxkgb+cc0XBivB1WCDSd5rxJGt7BMLeBl0xvCSWV4ipNErm/BrsctB9LJF1MQnRtI/RWXEtkJblEgQ6NFnpn7HhupjbQoUY2z5G44lUExpDsmyA/HANGJydqiKpExWAMSqvJNwsLNhcisLy/SetMgzFwO/gqspvMwcpL4Yqs1tUyy0QmwOt3wkHgrDfivenc6NS+HYwE9gXgfLzuXBmfqrw22bAIooaOnxCFXLgSM5zK3LncczUPu+Q2ZyHEBCoUDQ8Cwau9R2uaLnn6HzuLBKAKYGwh+C0AppM0Qb7JlROhnxfVWx1qBpACBCbmD9jEnD6eGlJbg==
Received: from BN9PR03CA0657.namprd03.prod.outlook.com (2603:10b6:408:13b::32)
 by BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 03:42:54 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::aa) by BN9PR03CA0657.outlook.office365.com
 (2603:10b6:408:13b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 03:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 03:42:53 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Jun 2021 03:42:46 +0000
Date:   Tue, 1 Jun 2021 06:42:38 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] vdpa/mlx5: Only return vq ready if vq is initialized
Message-ID: <20210601034238.GB203469@mtl-vdi-166.wap.labs.mlnx>
References: <20210531160448.31537-1-elic@nvidia.com>
 <0fbd8484-9e8b-d7cc-4996-74306e6e2867@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fbd8484-9e8b-d7cc-4996-74306e6e2867@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03876ecb-03dc-4622-502e-08d924af5681
X-MS-TrafficTypeDiagnostic: BY5PR12MB3763:
X-Microsoft-Antispam-PRVS: <BY5PR12MB37633D54369F10C4629AC114AB3E9@BY5PR12MB3763.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: teavxC17jRyzB7cQsflzWsVHaoA0vPPaDuPEr7YTmlYUS0eDLpJmruTdDmw/0Vp01CvCTqsV1V4emn/Qm5s9QTb1QflSASxffrJbKqXEZfFmfTxp0DPsM0tv5KmqEMCjHb7f6bEQuASqhQgM8dAJGEw9+pHj00jfedc4+nFXwY+MplaNEi9HMUFExhBZ0cvy5rIsbsQTqFCE0/P1xcjl9YdYmkiPT1zxKnzbaDacmGkIj9fYlrKLB3mL147oSpVOp9H96M4BU4UW0R97l+jX1BNqL3ydw/lb0FhFjcODlPnml6TghpAuHtgnskIe0thOzOfYCopEg2OtzvYWXRyjYOiSirez+qKWinjdl/zhlvf8TKcHpneTSB0QSumruF0XUzU4K8OZfzcXfEnHDN+pS5u7W4FsvKUm0hyuUPgiLotaaEck7N8VnE17/KH9a2k7C4egX5d7zl92P99BmKrLgqUKMWvYitiG2JBXfqMsSheoSECYE3MXDADR7n3Shy7yV+Nq4DUSs8hTUJNgeY7JAAiVSf03x5QIZ2B+GGB8qw0e7irHEOK05j/OxPfNKOQNPMR3iAVjIU3uzVQwGhEk15mawCeuP83S11sNuoiKG6shlavBLBQmWxTMYvKYdWufe8+Xms5CNR2f0i2wYDIcyXtEezu2T0Pct1n37VoMPOc=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966006)(36840700001)(83380400001)(5660300002)(186003)(16526019)(426003)(336012)(356005)(70586007)(1076003)(82310400003)(70206006)(33656002)(86362001)(55016002)(26005)(6666004)(316002)(54906003)(36906005)(7696005)(9686003)(8676002)(36860700001)(6916009)(47076005)(7636003)(8936002)(4326008)(2906002)(82740400003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 03:42:53.6599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03876ecb-03dc-4622-502e-08d924af5681
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 10:18:04AM +0800, Jason Wang wrote:
> 
> 在 2021/6/1 上午12:04, Eli Cohen 写道:
> > Only return the value of the ready field if the VQ is initialized in
> > which case the value of the field is valid.
> > 
> > Failing to do so can result in virtio_vdpa failing to load if the device
> > was previously used by vhost_vdpa and the old values are ready.
> > virtio_vdpa expects to find VQs in "not ready" state.
> > 
> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 02a05492204c..f6b680d2ab1c 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -1407,7 +1407,7 @@ static bool mlx5_vdpa_get_vq_ready(struct vdpa_device *vdev, u16 idx)
> >   	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >   	struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[idx];
> > -	return mvq->ready;
> > +	return mvq->initialized && mvq->ready;
> 
> 
> I think the more suitable fix is to reset mvq->ready during reset. The
> vq_ready should follow the queue_enable semantic in virtio-pci:
> 
> "
> The device MUST present a 0 in queue_enable on reset.
> "

ok

> 
> Thanks
> 
> 
> >   }
> >   static int mlx5_vdpa_set_vq_state(struct vdpa_device *vdev, u16 idx,
> 
