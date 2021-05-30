Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E43639501B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 10:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhE3I3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 04:29:35 -0400
Received: from mail-bn8nam08on2062.outbound.protection.outlook.com ([40.107.100.62]:30434
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhE3I3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 04:29:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lz9k1pjwqiVH0+5/0CowotLp0D46pogcxLtNTg1MVvFlVHrf9oIqCe2cC0euUnCx4Yxp60klSyQpNMIhe+YMyTvQ5TnXP/XP+o+UZQWdUp5XH3iGrSuFy+XAAv+qfcNs3CF+JUP+fEW8fx1cI/rJxrPdGbG6YED8Z51yflqfoxY9E3Af96Xy7CEN988VOW2FfFBBNrZaUX8dDx3SPeAlRqmd4Q3+90pm/zDygv+6/CMnQ2Uej5eZqAxU++opJFItBC63qvnlQZYs06TPHxSrRZ99VQiSUDTEwDNQtoDQ3e8wDXdUrbtSB/NX17cZJ87O+cy7ILDX/mt4O7nPhupPNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVjdexstcgwx28gg6CdMz42E4d5bWA5maMQR4ue9bzI=;
 b=HLHxas3zdU0atZMAEJerG4IqJUqZuD4IZmrASqqu4txaR9jqtv35ziC6O2it75FVH1kFU6rS2kx+rdblStycTYg8O45ZBQZoJ/6SUUkLRJDGV5sqGgf5ZpXguSCXzAbwt8Fny2ikCXWRc7OwCj2JhPj04tMMh9iquM304rMc69djDv99DrUpSK7VEmUtZZXhlJHkjqX40dhdHnUUvhMqCGNeIGitbaFD2EJRAD/qfZ1GOcze3rcwBA5OMDeeroBJUYdGbd8s4yUikrGOM0rMmSfhlzafBgUUHcLMQ8aytjjz82UFObQx9uV1apnasWXGAVuG6BcXdFwm5hcHFgzwTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVjdexstcgwx28gg6CdMz42E4d5bWA5maMQR4ue9bzI=;
 b=QMMOZDK4XzhSTFOnfGM8fUhEwzrx6QOXHcdoPjNp8ZVQ5j48QhWhzA15GjwYRcZivAj/F5GSK4fWZfEtiFduI7uhzV+PkdW1+QXBim1fpwLG+Ex5jVsnLmvTzfxEVZMdwCtYYa1xK9cFalNY4UXdMoClrg/NCIjBSOKFkSTXTEG29Mtvn8kTiuQsFUxHMheMkUY6svtjohaARGs1GY5KfJ9j0r1YpDL99AE6VboYs15V7bRLXzZ2VcgO9v3JErOspC/a6LXeFO04NPzWtpyHT6x5hDsJoDhDQ7VNekVlHp/3dh6wq1N612eLnHPv6L12d2W9zF4MbavtRZuWqJn6JQ==
Received: from MW4PR03CA0294.namprd03.prod.outlook.com (2603:10b6:303:b5::29)
 by SN1PR12MB2478.namprd12.prod.outlook.com (2603:10b6:802:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Sun, 30 May
 2021 08:27:54 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::7e) by MW4PR03CA0294.outlook.office365.com
 (2603:10b6:303:b5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Sun, 30 May 2021 08:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 08:27:52 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 May 2021 08:27:51 +0000
Date:   Sun, 30 May 2021 11:27:48 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] vdpa/mlx5: Fix possible failure in umem size
 calculation
Message-ID: <20210530082748.GB120333@mtl-vdi-166.wap.labs.mlnx>
References: <20210530063214.183335-1-elic@nvidia.com>
 <20210530040523-mutt-send-email-mst@kernel.org>
 <20210530081721.GB119906@mtl-vdi-166.wap.labs.mlnx>
 <20210530042055-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210530042055-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d09f4498-5061-4f63-11a0-08d92344d18a
X-MS-TrafficTypeDiagnostic: SN1PR12MB2478:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24785F1E5D48F44504C4DBB3AB209@SN1PR12MB2478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zY3XQZhTqoAMUlX3cAlBNDzjF3eISFEW7vLfM64SsPeeMeYXuCAZiHF6hLUB+rUufNObk5EHzsYJ2oJ2JR4OVzDfyjshwP61w1u4Alu+e/40Rp1V+soMOLwLwSh31yRP37mCJnHqWb9kbFxh6VTg2/zhtdZeKPI+NYQQ95/bfomwSWtuDP0q0ov0o8r/58gpWA+LGgjZ8B3GZzazmo5P2JnxuyYPxh129xcLlKkD3G423CvSd0B0lIY7UK7M4X4qC+AhxLMLdxptrsPvNssWqCDUMrcV77UZmvmp6Qdk71f18YfHIRFVgSF/66/GP9WGyoJNewfcHnSI/Yb64lLAmgcjrBaAV4F+6m+S9Ee/BKxk8fCuPtl+lTRpMDjUAeyvX14jZ2fO9/FFUc+MRwi16OinEp5ijARk1/tndk1h8OBudAezYwVUffFiIjEy+8wLBMnkgwuA2bJtiKiyHlNG5uxzAsFcfttccfQf+m1SLjUGbFge0aaeLT1wJGNXAuaU/SXwTHigpdWZwEgN/ozRkN+RnH5kYKOPOvLi4yYdYdqgLgEtohv+0fW+Qy4DrNMA5S/3N+gRtEYw+cVIDJtcqgLXAY50O4Gmc8E+3dV/cqjPcLtajKBaa3usqZEgFTM0SJwGO1KIqiBLmJ7uqzKx6H9ra2lUf4zLeg8qK/rxpL8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(426003)(55016002)(9686003)(478600001)(86362001)(70206006)(336012)(33656002)(8676002)(356005)(6916009)(8936002)(54906003)(82310400003)(7636003)(4326008)(316002)(36906005)(1076003)(26005)(36860700001)(83380400001)(16526019)(186003)(70586007)(47076005)(6666004)(5660300002)(7696005)(2906002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 08:27:52.8721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d09f4498-5061-4f63-11a0-08d92344d18a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2478
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 04:21:07AM -0400, Michael S. Tsirkin wrote:
> On Sun, May 30, 2021 at 11:17:21AM +0300, Eli Cohen wrote:
> > On Sun, May 30, 2021 at 04:05:57AM -0400, Michael S. Tsirkin wrote:
> > > On Sun, May 30, 2021 at 09:32:14AM +0300, Eli Cohen wrote:
> > > > umem size is a 32 bit unsigned value so assigning it to an int could
> > > > cause false failures. Set the calculated value inside the function and
> > > > modify function name to reflect the fact it updates the size.
> > > > 
> > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > 
> > > could you clarify the impact of the bug please?
> > > 
> > 
> > This was found by code revew. I did not see it causing trouble becuase
> > umem sizes are small enough to fit in int. Nevertheless it's a bug that
> > deserves a fix.
> 
> ok pls include this info in the commit log.
> 

Not sure what info do you want me to include. Seems to me that the
changelog already provides the required information.

> > > 
> > > > ---
> > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +++++----------
> > > >  1 file changed, 5 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > index 53312f0460ad..fdf3e74bffbd 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -610,8 +610,8 @@ static void cq_destroy(struct mlx5_vdpa_net *ndev, u16 idx)
> > > >  	mlx5_db_free(ndev->mvdev.mdev, &vcq->db);
> > > >  }
> > > >  
> > > > -static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> > > > -		     struct mlx5_vdpa_umem **umemp)
> > > > +static void set_umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> > > > +			  struct mlx5_vdpa_umem **umemp)
> > > >  {
> > > >  	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
> > > >  	int p_a;
> > > > @@ -634,7 +634,7 @@ static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
> > > >  		*umemp = &mvq->umem3;
> > > >  		break;
> > > >  	}
> > > > -	return p_a * mvq->num_ent + p_b;
> > > > +	(*umemp)->size = p_a * mvq->num_ent + p_b;
> > > >  }
> > > >  
> > > >  static void umem_frag_buf_free(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_umem *umem)
> > > > @@ -650,15 +650,10 @@ static int create_umem(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *m
> > > >  	void *in;
> > > >  	int err;
> > > >  	__be64 *pas;
> > > > -	int size;
> > > >  	struct mlx5_vdpa_umem *umem;
> > > >  
> > > > -	size = umem_size(ndev, mvq, num, &umem);
> > > > -	if (size < 0)
> > > > -		return size;
> > > > -
> > > > -	umem->size = size;
> > > > -	err = umem_frag_buf_alloc(ndev, umem, size);
> > > > +	set_umem_size(ndev, mvq, num, &umem);
> > > > +	err = umem_frag_buf_alloc(ndev, umem, umem->size);
> > > >  	if (err)
> > > >  		return err;
> > > >  
> > > > -- 
> > > > 2.31.1
> > > 
> 
