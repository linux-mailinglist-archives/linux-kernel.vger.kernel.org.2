Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D21846051F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 08:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbhK1HUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 02:20:04 -0500
Received: from mail-mw2nam10on2079.outbound.protection.outlook.com ([40.107.94.79]:54081
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230135AbhK1HSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 02:18:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLb08Ovi5tulBQZcx0mQl6PBJiEgkel+R7hbg/0Uj4OdgpDimqaaS2kW8pJdfcvjfTr7F0vf29kFR9vq6mRX9SZiz2eP3sx2o/LobDDsW3AkG68q9N8JmzbQIwhkdzOjEts8toR8Vy1p1bbyuoD5U3Fnv4b0SGeQGKmH4PwRfuiSQ51IQhTxCrhZ/od5/n5ETFrDiMme1QNDOX5ilX8m7eGykEGmNWiLwCcNDIZ1Nv2CmtiWszTnodntEgqZ//4jUpwudESTSLGuvs82ddt/2MECT7ON8EpRrZL88xX/pyH/NZbSVbnPegbk1VVSWSfb8/et6jK3E+NQjc/IYvppHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VzK9gPdbIMOFYBTrCDKQx2w1D2kkOI/2TNhwaD9JH4=;
 b=GnpvK/V1TCqcf58x0y/vPnp35fbJK11rCld/rjrvpc6tzV/dFEwfZhSm2r5H3JxIajgicUQb+e7KDBW9nXpM7OTjn0GpPNq/nG5MalxLxoM1NAyDzw3EtzMRo7fytT64JdnOwE1QywSJDBEa8+G1BSc6YACYxuv8yNyOpMFts6TQJzyLcuuaOeaav/BLUKJzv7tDQ45ZjJMgy01EN+/LFttA/47kMWRGnFx4PbCZ4yOVf1n0b1A3Q9jKS7ucAFIfxSD4+pRvS66BTwX/PBP0ThNcP9/ESrn4PmA+kjABnAZwwei5sWp2S7FkqMZxKAee5uKLxXnWmBahKbQd8ICfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VzK9gPdbIMOFYBTrCDKQx2w1D2kkOI/2TNhwaD9JH4=;
 b=CvQOzcBes0/9FACki6Tnx2dhqzAZs0wa/DDbzSXqfbzwUvm5hqk7+CAfS9NRINo5H+kKXFbmjN9UgLo3AdYbbzt+R65B1BhqEk8tjFfIAWpQSBvmjMmH2Mfl0Z2ZtF37+nyeOBVmODZmIzQAez7sLqnjsFARhSuTuqn835Yc0GhCD0sjeDCu/WUUpFW//pv5Ur2lIT0m1azLw/zok35ZlfGp1BuknoHhgXRSD2BP66paAIJhwvwkIcqhEeF0t708d5i7YXi5PAja0Z87Io5MXtHAJCIYD6twl0uQFdSk52rAuHx7BQs/bnlfQJO0Du78hGHncE3ipob6OR2heFoOXA==
Received: from MW2PR2101CA0018.namprd21.prod.outlook.com (2603:10b6:302:1::31)
 by CY4PR12MB1783.namprd12.prod.outlook.com (2603:10b6:903:121::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Sun, 28 Nov
 2021 07:14:46 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::3f) by MW2PR2101CA0018.outlook.office365.com
 (2603:10b6:302:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend
 Transport; Sun, 28 Nov 2021 07:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4734.22 via Frontend Transport; Sun, 28 Nov 2021 07:14:46 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Sun, 28 Nov 2021 07:14:40 +0000
Date:   Sun, 28 Nov 2021 09:14:35 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     Parav Pandit <parav@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        mst <mst@redhat.com>, "Eric Dumazet" <edumazet@google.com>,
        <kbuild-all@lists.01.org>, kernel test robot <lkp@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <kbuild@lists.01.org>, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] vdpa: Consider device id larger than 31
Message-ID: <20211128071435.GB99190@mtl-vdi-166.wap.labs.mlnx>
References: <20211125180915.649652-1-parav@nvidia.com>
 <CACGkMEtF+kjj_vryxXAo6PqeX3Puk-XxaaQMcu4mhB1WZRXEpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACGkMEtF+kjj_vryxXAo6PqeX3Puk-XxaaQMcu4mhB1WZRXEpw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7375cd51-da64-45e1-ccc2-08d9b23ec200
X-MS-TrafficTypeDiagnostic: CY4PR12MB1783:
X-Microsoft-Antispam-PRVS: <CY4PR12MB178366836F2D970AD272EAB6AB659@CY4PR12MB1783.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHD86weQ1zfWlcygisBsaq8menGfNgVzEb5sc2hyi9O3AQ8wezLIzN4PMOox122AhR78ELFfH3vB3TOSdC+YK2vVfpyBKu0+Fy912uVQdfzKZ6C7Ro2MzLjTzCt+mrDo+0TmO3WxxKtuUMSDIuNmKcw9a/x7SEyVWBFifeuVLcGpC68dFQ1Kpf/7BjJodREVHfJN3yF97TtHkLtryRlLd8EE2otUlyk/s1fxcdAk8wYySjCYbUBiV0gmYYqyhuJZI/gSmvCA7Nu7huH3T17vVpHuqmd2sCl+TqYYSBKhytH6IKuGIH90NcBxGlLJAkaLit3rs4tmcBRf6SFNrfTcdp9/nmiyYwIrC7YDN0OpB8bjl4v9mJMvL1y8vE2hiROEKMj6HRQ68xRXI4v4JljFD917Sy6f9jaNHG6RdzVL4oINQXrloWMoJHzBBd/f6KdXLrv39WR7YeVc7aUKMQFIvs/Iyh+3QCINCKJEyaeW7PUZaqIl92G3/OuSwjRxACZmN7Jc6fFTNheepkm2EitjN1N745nhE8y2f52B9HaUj3QrUU1uHjf7ku022uClEmHkS9pmSK8PM9YO71RIKgYjoEtx5JeEVVGvcAM7efNslbT8IBZU3huP/jcut3FIxxQvoe+5FNPbo6MKxh3PvJ39g+uSh84Lb/xXnftHQ2f4y4b3ZzKxjlG7VzJsi2ZAKtkdpot09Ub00GgHBKkesCFZ3w==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(426003)(7696005)(7636003)(26005)(508600001)(70206006)(36860700001)(6666004)(356005)(54906003)(16526019)(33656002)(336012)(186003)(55016003)(82310400004)(2906002)(53546011)(1076003)(9686003)(6916009)(8936002)(70586007)(5660300002)(4326008)(47076005)(86362001)(8676002)(316002)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2021 07:14:46.1455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7375cd51-da64-45e1-ccc2-08d9b23ec200
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1783
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 10:48:12AM +0800, Jason Wang wrote:
> On Fri, Nov 26, 2021 at 2:09 AM Parav Pandit <parav@nvidia.com> wrote:
> >
> > virtio device id value can be more than 31. Hence, use BIT_ULL in
> > assignment.
> >
> > Fixes: 33b347503f01 ("vdpa: Define vdpa mgmt device, ops and a netlink interface")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> > ---
> >  drivers/vdpa/vdpa.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 7332a74a4b00..e91c71aeeddf 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -404,7 +404,7 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
> >                 goto msg_err;
> >
> >         while (mdev->id_table[i].device) {
> > -               supported_classes |= BIT(mdev->id_table[i].device);
> > +               supported_classes |= BIT_ULL(mdev->id_table[i].device);
> >                 i++;
> >         }
> >

type of mdev->id_table[i].device is __u32 so in theory you're limited
to device ID's up to 63.
Maybe add assert here?

> > --
> > 2.26.2
> >
> 
