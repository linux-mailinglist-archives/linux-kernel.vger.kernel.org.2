Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A663CF3DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 07:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbhGTEgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 00:36:13 -0400
Received: from mail-dm6nam10on2086.outbound.protection.outlook.com ([40.107.93.86]:16576
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230089AbhGTEgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 00:36:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOPSL4/owmlLVRpAPrfCHiT1cnd/tQjJqJol1D0/HIl5new0Y4cR/n/hFG6AgHfpoCsIoWoR7efEiCgSXMzuKI11rmwv7B66jayqVI/pwHG1XYoSrYLb+T705a8sxKbxC5wMI7Uzbf1yUSJv+i/lMgS81oYtSiEA11M8mHmqGRvPWg15utL6gBijZeTEm7owy/t33F8NHCC2f2Xaf5x6tEoQJsoQI9V4Fc2i7vFfNkXsmQJYknDkQHdX3ggpgf0PDIQPiP+X4GaZVpGZAtH1oQ9pq+irLCLt2FulVSekeWCHD32h5GwaxBl0uf/Ul9mVSjHyBV/t95NKHLeHMdBJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4lSZWSpkrre+7D/xFVSZxOp4PVjpe+q6H0eQRGrn1U=;
 b=mYveOzZrWYQ9rhFNxab2N1mmbgjamBzmEP2QPpNLWn1/2RI6mgdtY2DhgOittCfX6MfUqwboBeH/12ke56J9Qw5wIeITwH5zLY704CYXjpcEYUtKXXz1tm9KjyMj4PNJihHQ2y82ubJ2nJ8IN1PAGbx5y1oMv/zpYub9lFv9lWFLo9rCZxLsh+/qhb7fDt108yXE5paKZxPUdF3VMvW1vM7mcmcDKvllRqRM2U9agEG/JqaRHd/oPhY3ooL3bJTl+8oQsWge35z4fCL0U9/M8DcD8k7MJT+EtbUQkL/QgsXFayVoQ1XjSuY8H4OPvE8/ddKhmMw1jgLROOjVrwibfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4lSZWSpkrre+7D/xFVSZxOp4PVjpe+q6H0eQRGrn1U=;
 b=uk7i2oXER019PoZAFVOb/567G8/wBM+UHyFTQB6f7tZZ/Sv72xQFPzompnZHjoVJmcJnUwj/uce9bmN+NI1Ot65AbXe8kN7KoBH57UUiz3GjWapJyZZb25xCkUKQPT4knnByjE6w6rxpRdgg3sS6sk0fxI+Bx7I80/ggcYCtk3m7TmzwzL3PKzYXLXXD5H/aCxWk//t4xRAouuK5AUnc1H7bbVQrcqc1xMNLIsTYY98XQssPvAhQGzEkKOK8CeliGpdSbF1RuBUIG5ow4Umc7TyXhzQtvuiKuP3hHE4DxB3wOu7hZbf5T6oVGjCTvKOk/q+Le7FetoI36Qa8mjwrWA==
Received: from BN9PR03CA0217.namprd03.prod.outlook.com (2603:10b6:408:f8::12)
 by BN8PR12MB3377.namprd12.prod.outlook.com (2603:10b6:408:46::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.25; Tue, 20 Jul
 2021 05:16:43 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::28) by BN9PR03CA0217.outlook.office365.com
 (2603:10b6:408:f8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 05:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 05:16:42 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 20 Jul 2021 05:16:38 +0000
Date:   Tue, 20 Jul 2021 08:16:33 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <sgarzare@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/vdpa_sim: Use the negotiated features when calling
 vringh_init_iotlb
Message-ID: <20210720051633.GA245424@mtl-vdi-166.wap.labs.mlnx>
References: <20210719134407.175884-1-elic@nvidia.com>
 <970569fc-80bc-b0ef-b163-c59650796515@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <970569fc-80bc-b0ef-b163-c59650796515@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25fab078-4a04-43fd-46d2-08d94b3d8fca
X-MS-TrafficTypeDiagnostic: BN8PR12MB3377:
X-Microsoft-Antispam-PRVS: <BN8PR12MB337753BD853CAF27EDB723AFABE29@BN8PR12MB3377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JWxPxzjO5BJFMCDhwqxSQxhp2ErMesMuzGYo0t456P2aSMnEDYEHPaMQGPUj7wUVSKDemaqoBFmV3HePGb8ECnjzV5/hepVZM18PMB1GERt/IXnb5rWVNKiB7Bt67nwXDuQ/3mf6EY/nQ99YDrUu7GAJiBVLf1ym2OlQfGZzAgMfYEbvvdR6OWJWqqYCQ0DLI/4rDitIfM9C7ct1kVmelpQg0d3OiuPL/7QCzAmARhpZxvozWiJ+nvAva1wobUv6vRgesrtjxkwZ3PUvY1Mj1DjtrdGc1OlROLeri5IQ0DjNFf1afPJuJoJVF86AOVKYmA6Go1MPxn/z5CUN2Yk8DQMaIF7MweCSOpoRCHuoxhJ/hVj0Tk4YlOKMiTi/YGafb/rDb8UgOL+ZKcTK2eg3ZQ2R3PVFGJaRq8rrCg3tIAWQ7t7ohv6jww0V3EnJr+khsV37bIIK6xB7ITVrrn0Va+6rJFUEMrwhaKRQUVSNid76hVSfZMvGasbv5NmJr1fjgm98TFWEAH/n4Rqv6Tt85CeBegupMFi1GJNxI6eXyV0ms+jMwf7reaTOVos0mYIReVWCCPTjlPn88vsfo4dvN/XImIqnSDMsHv9jNzgGmYDqASWO9FdY7yzw8nGUhCtxFjuLAr02lll2LorT8bpqBLYh+0UZ6BO8XJRgkNzP/Pq20nojQ8vNIJiTHfoNgv0d1yUe0sJLZDvm9OwMsM68FA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(26005)(508600001)(9686003)(16526019)(336012)(33656002)(4326008)(1076003)(6666004)(82310400003)(36860700001)(70206006)(83380400001)(186003)(55016002)(6916009)(70586007)(356005)(2906002)(8936002)(54906003)(426003)(5660300002)(7696005)(7636003)(8676002)(47076005)(36906005)(86362001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 05:16:42.5443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fab078-4a04-43fd-46d2-08d94b3d8fca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3377
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 11:13:00AM +0800, Jason Wang wrote:
> 
> 在 2021/7/19 下午9:44, Eli Cohen 写道:
> > When calling vringh_init_iotlb(), use the negotiated features which
> > might be different than the supported features.
> > 
> > Fixes: 011c35bac5ef ("vdpa_sim: add supported_features field in vdpasim_dev_attr)
> 
> 
> As Stefano said.
> 
> It should be 2c53d0f64c06f ("vdpasim: vDPA device simulator")

Makes sense. Though I haven't got Stefano's message.
I will post another one.

> 
> Other than this
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> 
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> >   drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > index 14e024de5cbf..89a474c7a096 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > @@ -66,7 +66,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
> >   {
> >   	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
> > -	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
> > +	vringh_init_iotlb(&vq->vring, vdpasim->features,
> >   			  VDPASIM_QUEUE_MAX, false,
> >   			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
> >   			  (struct vring_avail *)
> > @@ -86,7 +86,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
> >   	vq->device_addr = 0;
> >   	vq->cb = NULL;
> >   	vq->private = NULL;
> > -	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
> > +	vringh_init_iotlb(&vq->vring, vdpasim->features,
> >   			  VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
> >   	vq->vring.notify = NULL;
> 
