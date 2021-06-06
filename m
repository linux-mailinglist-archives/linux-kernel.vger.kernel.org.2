Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CCB39CDA2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 08:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFFGdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 02:33:09 -0400
Received: from mail-co1nam11on2087.outbound.protection.outlook.com ([40.107.220.87]:48993
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229478AbhFFGdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 02:33:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwDWRibw9b8/NgvJH7MtrGHAwxVNTe2ZXhuwHnOtTqrvcdP56bkJ3xGTqZfHfC/l2ujL+LMVjRR9TeQuaO1c/GwjF+7vf2FjQXAMqe0U5cHxPCCWdpbjS4h01yBKMAJYvlRjkHDJ+UvhxcCpy5VGwJElq5hAcq53mBNXYc0pUxpUMFBKOKOCO5jDMXO9IHkhcjjrXHXo9mY5RqZzUhGStvVNPTtb1Gqg4x88v2py69B0sGeuqyVFxckCgaMZexPH6T52hoa/wcU7fM7cHIhPsbKeakU/S9cAts3QoEgcutFmaY1kWt1dm+85WXX3N8JOIeL99zzTMIQqcFX219IRwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqhNNFxbJvR7FnO2ctqtdUiG3FfCR86RyXgVM3Rin4o=;
 b=mIhfjnhEkYq5KEYPwzkGDNdVv9MNLCBoIIzMTRN3UadkHLnBFyH+3/bdX8hp57+pNbwy7jAp5GIPCoFefegJP9pk/spLi6OkzZ+4qbpoMbtrJrdd1SaPAK2YSjtgVqhc2uz50Av6R2XVqSkE84rNZNDaxweR43Xm1KGwouROqtKVQNE/x7KECAKbTQ7oCxx38TQRyBRKptJuzZIkf0+Msy34txY9rtSikGJbYwU67MoVnAoEjROcGMfDbp6iFoPE7JiUvLtHdAJSDGMhPSvs6d9+Rpljrs1zf5mO8vFd5LVUJzrxdg3ieeWCuBsfk42B1D5OkCIr/ay10oIiw0T1hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqhNNFxbJvR7FnO2ctqtdUiG3FfCR86RyXgVM3Rin4o=;
 b=QKp1B7qmFVVGqs2hjNzJ0FwNQqo8CKAQjUMb650U4Q0Jv+Y1K8KLh+mX/68NyuI6y2Ppw15GGX0foGDwloYebgwcOulwgvlcv20OYMptB1WQDd8dZpb2d9epfj4fIxGQfDyMdCmIsG6miaQDsbGL6Vsegm14DUBCG1/DFrnnBnEtGHCy2auE1Z4/ed19hvLztvA+ymuyFj4Fl56R0epyMYUkrgyoZj3OttL7796YOiOid86hdGtQBlQXk8BQ5qByFfcvmD6CJiDXi/LjILg57fitHo/nfNULEAfSEzTLktGKSz656z04whEUq6XRtedJBKRgvCIg+yXZ1Ji5GSHDLQ==
Received: from MW4PR03CA0092.namprd03.prod.outlook.com (2603:10b6:303:b7::7)
 by BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Sun, 6 Jun
 2021 06:31:17 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::52) by MW4PR03CA0092.outlook.office365.com
 (2603:10b6:303:b7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Sun, 6 Jun 2021 06:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 06:31:16 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.187.5) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 6 Jun 2021 06:31:14 +0000
Date:   Sun, 6 Jun 2021 09:31:10 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <parav@nvidia.com>
Subject: Re: [PATCH] vdpa: mandate 1.0 device
Message-ID: <20210606063110.GB189356@mtl-vdi-166.wap.labs.mlnx>
References: <20210604050251.57834-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210604050251.57834-1-jasowang@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89feec12-1ab7-4edc-f0b5-08d928b4b01c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3286:
X-Microsoft-Antispam-PRVS: <BYAPR12MB328649744F3A3C300BF37504AB399@BYAPR12MB3286.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vr+nzwuGg62PNtLdzS0rII7ntdQ5VgryVkMQntauEtFUVdhTjFHGfOxmr4AEcNWBhDJXZu5rCsaEKJCcpi/ZoiK078t5sopg687Yg8RZWytodwS9UyAzlEpGuIjHHgnSuhVtw5sWg42wkwWe3WlZ6cuEfCGsUsz+1WtY0rSgL+4N/oNON5yVcqgZDZ0e2hS16sF3u624WsXUz2nkCV/V0RtoSMnP6qRSKW6PJ3p9xqa+fhhxyxVrW2ArcErZqOAI6n4vywmJZU6wWW2jZxflomm5JJJ6ceSH19H+gJLcJbSt/doNEHzBE43VhP+ZWna1wbSx/GCN3pnlBsnP/KBS32LLEaFzu4hIyMtA/858DHf15ZB65/Vvh8RxoTIRjdxYaTMsZzdWVtegox1ZW+1vq6RPDjsagMvX+V7qXJ2WSx//xjx4sl6PFXrmAW7SPXxrjqcBwG4I82rkQxEBkoeKJw+ZKoAnFc4/5lHsfC3qxQozW3iFfDE37x9J79zkHLOI1bE3E+l6I1VJGb+0o2kTHzCBokYIwaKLkY+kCPleaHiYovNJU/2qkrtpVTlldlETAtJ+AORaBkJR7z6p1c8wSHQalpbjWdRwUksWpughqsWVd58bQ5U7lT80zggBh/gzWo5YWexxSHdS8ecI4NDoRZ3wFT9Q60YemtxLEFNVKVo=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(36840700001)(46966006)(9686003)(55016002)(86362001)(54906003)(2906002)(7696005)(36860700001)(47076005)(107886003)(186003)(6916009)(16526019)(4326008)(478600001)(336012)(82310400003)(33656002)(426003)(1076003)(70206006)(83380400001)(7636003)(8936002)(70586007)(8676002)(26005)(82740400003)(316002)(6666004)(5660300002)(36906005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 06:31:16.2507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89feec12-1ab7-4edc-f0b5-08d928b4b01c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3286
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 01:02:51PM +0800, Jason Wang wrote:
> This patch mandates 1.0 for vDPA devices. The plan is never to support
> transitional devices for vDPA devices in the future.
> 
> The reasons are:
> 
> - To have the semantic of normative statement in the virtio spec and
>   eliminate the burden of transitional device for both vDPA bus and
>   vDPA parent
> - Eliminate the efforts for dealing with endian conversion in the
>   management tool
> - Mandate vDPA vendor to ship modern device instead of transitional
>   device which is easily broken and unsafe
> - Transitional device never work since the first day of vDPA
Transitional devices never worked...

Reviewed-by: Eli Cohen <elic@nvidia.com>

> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/linux/vdpa.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index f311d227aa1b..11dd05b805a7 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -6,6 +6,7 @@
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
>  #include <linux/vhost_iotlb.h>
> +#include <uapi/linux/virtio_config.h>
>  
>  /**
>   * struct vdpa_calllback - vDPA callback definition.
> @@ -328,6 +329,11 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
>  {
>          const struct vdpa_config_ops *ops = vdev->config;
>  
> +        /* Mandating 1.0 to have semantics of normative statements in
> +         * the spec. */
> +        if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
> +		return -EINVAL;
> +
>  	vdev->features_valid = true;
>          return ops->set_features(vdev, features);
>  }
> -- 
> 2.25.1
> 
