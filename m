Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966CD395014
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 10:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhE3ITS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 04:19:18 -0400
Received: from mail-co1nam11on2058.outbound.protection.outlook.com ([40.107.220.58]:46465
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229581AbhE3ITL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 04:19:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2QzSj4LUOyoejTxczE6aQN+SYMJd3JfrnCjvl1b04Fx9Bul0i5fG+s2hcFGuD/L1PzI4qgME/5e6/mcR5UF852Ih+n+GOCwtN6uEEYi7p1uc5f56PYBdhUqjs+JyiKwzeMnbPSY3ul2scXLdF6hz+UHxe9xzDPubTSWCr5RITw+t32eWC1oem3+0Scf8fxE1IfvffI5ija5hTlIuxkvM05o5QrVJ/eoWGa950RyUH1BeOh6yrHfJ5FqoNxjvC8BQiXxoWXaMwlHv3AOrmjcgQzFDcSgBNr5TknoM17JlI6SLSZti+/8U+j4kUAkgETNF8FwktYks9MSJbMDC+p27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUkqHCpxY5GcJNT2enO/jXsjRqj2tzrt58BhVDJjkNg=;
 b=k49uLkJNSlTGNOJUps8lW27X+gnnReuxm8kOoVTd7UHYANuJc8XKKyPo6IwW2pNG9vHt5b5Kc2lCDiw9x+Y/K/crJ0leKwzOqocdulXTFzAE97B+Ds81V4VX9i7H9xybePQwL9ZXpsExWQNAza2IAqswIceMm0B2IOrvyaJBmQ777/e6eXTFsJRQLqXZ2I7PdIavQ3Ne3a95qdkW/rdotplFo6KT33ZuExn03X6oBgMEv8eHsGdTkMun9RtjwMw0YDrpNJ1alR1FOSfXOQEQWu0Ei3nApPWfYdW61OcaZnGRHQnO6NOw/2OtrMp1KdXEGBNr55cPT3ie304Xi+D8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUkqHCpxY5GcJNT2enO/jXsjRqj2tzrt58BhVDJjkNg=;
 b=tiR+eUSKKl0hIOXdOH2j1BZZE2y87bd7Y9kG5S7I0IuxMNkv7MK/IGVKJA5hBUTDh2czOo5ZSFTyWEmP6ZdNO8og/q6YPakbbnt6N+E6+gldl7HK1KIBEiF25v2WP8OQ3cgBpnzqSMAR/L1OEACDaw1ZZKGg+7Rn248BN/IXkGnXh0+COKsEwq4PG9jRnjueCbNAUXMFSNJergZS/30yw3RFYjU+1qsc94QnhzAoiqNakBgL0H5aDAULAIUOLeF/PnVGxImZ1ZEiVIrlz8jg2AeiX+oee7Ivk3Wv/hT/hDwWSYrZ6cPkchjoghh3y30KWlnNj+wthiIQECt5Crth4A==
Received: from BN6PR11CA0041.namprd11.prod.outlook.com (2603:10b6:404:4b::27)
 by BN8PR12MB3057.namprd12.prod.outlook.com (2603:10b6:408:64::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Sun, 30 May
 2021 08:17:26 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::16) by BN6PR11CA0041.outlook.office365.com
 (2603:10b6:404:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22 via Frontend
 Transport; Sun, 30 May 2021 08:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 08:17:26 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 May 2021 08:17:24 +0000
Date:   Sun, 30 May 2021 11:17:21 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] vdpa/mlx5: Fix possible failure in umem size
 calculation
Message-ID: <20210530081721.GB119906@mtl-vdi-166.wap.labs.mlnx>
References: <20210530063214.183335-1-elic@nvidia.com>
 <20210530040523-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210530040523-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcebba7a-1e75-48c2-8ce5-08d923435c50
X-MS-TrafficTypeDiagnostic: BN8PR12MB3057:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3057C46CA2D1606EF983EC80AB209@BN8PR12MB3057.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sb6MkLK6cXkdj7zgJr3V3gfie2LhqxmTgbNpfvMQurSwrxlYph+AhEWRrheWs1j+xelYMJCumnev2L93GslDzwDLDKL4PRf19j1hO2fpgCjxBAryYXxJ6Bw3HBOKjWKheCEX1rDyPxAlAkYXMm6FOj10MMlXrVrAy0GP+SD3RJkufpCDAzIW+kNub2obL8BoelKWubaLjDYRhW8eVrY4SB+I7KNgNfzacWlpMEVVBWCx4Mn4xkoWKJHq2rITyXz5oF5NWlRj5BpUxkBCqevD9r/relFNhp1RiqtB+6e9pLehyy26e19c20Y55QG81qsdSeGkUpseSWK2RGayoeZJ9+KsV8Otcz4EXOu6g9Jz+ppDqYMrMXCYgviMfkg52rN2hSWhpJVEEakcIap5KZsX/sREX5xmyoAPuLOwyRMi4ro5e4E7ZqxxOU3dCZPHU+84uhRIkZgvZ7mt9sSUVRsJ9iRIwCXK9+WMuuW9/CI0g8dlMQmUmedgcmL9JGGsdAspBKsrr1wb5s+35Mi0qbKVTqSZxkQuUTy54XAeBmDWHLKszl3xcx+jJOFjNNkQFMVaohxkDrk9tp1w8k7HG+WQzA+7mETxBrXdw9gO51quV5Z9rtRyeQaodI4B7kARuZCWDV4/+sr6CAjsRvjQfZoQmA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(36840700001)(83380400001)(5660300002)(186003)(336012)(16526019)(426003)(1076003)(82740400003)(70586007)(356005)(82310400003)(70206006)(33656002)(8676002)(6666004)(26005)(316002)(36906005)(54906003)(7696005)(8936002)(6916009)(9686003)(86362001)(7636003)(47076005)(4326008)(55016002)(36860700001)(2906002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 08:17:26.6380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcebba7a-1e75-48c2-8ce5-08d923435c50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 04:05:57AM -0400, Michael S. Tsirkin wrote:
> On Sun, May 30, 2021 at 09:32:14AM +0300, Eli Cohen wrote:
> > umem size is a 32 bit unsigned value so assigning it to an int could
> > cause false failures. Set the calculated value inside the function and
> > modify function name to reflect the fact it updates the size.
> > 
> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> 
> could you clarify the impact of the bug please?
> 

This was found by code revew. I did not see it causing trouble becuase
umem sizes are small enough to fit in int. Nevertheless it's a bug that
deserves a fix.

> 
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +++++----------
> >  1 file changed, 5 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 53312f0460ad..fdf3e74bffbd 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -610,8 +610,8 @@ static void cq_destroy(struct mlx5_vdpa_net *ndev, u16 idx)
> >  	mlx5_db_free(ndev->mvdev.mdev, &vcq->db);
> >  }
> >  
> > -static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> > -		     struct mlx5_vdpa_umem **umemp)
> > +static void set_umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> > +			  struct mlx5_vdpa_umem **umemp)
> >  {
> >  	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
> >  	int p_a;
> > @@ -634,7 +634,7 @@ static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
> >  		*umemp = &mvq->umem3;
> >  		break;
> >  	}
> > -	return p_a * mvq->num_ent + p_b;
> > +	(*umemp)->size = p_a * mvq->num_ent + p_b;
> >  }
> >  
> >  static void umem_frag_buf_free(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_umem *umem)
> > @@ -650,15 +650,10 @@ static int create_umem(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *m
> >  	void *in;
> >  	int err;
> >  	__be64 *pas;
> > -	int size;
> >  	struct mlx5_vdpa_umem *umem;
> >  
> > -	size = umem_size(ndev, mvq, num, &umem);
> > -	if (size < 0)
> > -		return size;
> > -
> > -	umem->size = size;
> > -	err = umem_frag_buf_alloc(ndev, umem, size);
> > +	set_umem_size(ndev, mvq, num, &umem);
> > +	err = umem_frag_buf_alloc(ndev, umem, umem->size);
> >  	if (err)
> >  		return err;
> >  
> > -- 
> > 2.31.1
> 
