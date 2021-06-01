Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818D6397174
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhFAKab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:30:31 -0400
Received: from mail-co1nam11on2058.outbound.protection.outlook.com ([40.107.220.58]:10224
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231610AbhFAKa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:30:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hA6kzMIYwiVNyg+5slzzGX3tfQtGP4I8tZBs2jcNU1pBt49fxrBan2ji23uEg67OnhXMDGF/tI8P+5msQ/a3K02fFdRb9/dsS2/EmPv4wqURKfl64UWJXswqCB2ijHCxWJcSupSsWiIhJQ2nKGuduEaU8tvHM/W3f3NdR6QDqj0gobtEB+2ZQo6WUfP5rOh/36O3dbkWxNoCeTWVauurIxyV/aVxMdxZwEF/eO/SU+vzQokj3dG1ZyEtAlPlNiiOcm9N8RvkqAegntMJHxiuEQpMdZ1jagYtNszWVO41TCIsdp1Ud9frc0zBNnKkTFTA6i6UudPlMqJHnnjrICbTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/onPDxtGC/i3p+6usAaFmzNWIbIO4sziHTeRDEKIFxQ=;
 b=b1OlHpAbhZchK4k4qi8YaMRcjmBlHFodFO15oVcgFP3t8qmEGb2SYom6sIphYIqDVOpqo2qX2bpGw63qcZg/xXGs2BwtsiuBpkgTBOkFQ5ozj1eJQ/PLXU+kGwFMLZ9rdLm49KrJ59hBSkgztNRzHLAU0qzvufHkpsfI346OtUu+JHp8tMJaH0a4QNY3eYpIAtU3HEi1na3kQTUQrk2VSPbY+inbjvnvo84xJ3qgzoeb7Z2Tq27NI8IQH0j0pCwIXlSAOQZCNZVEXCDpuHePt/ovciZbGA0N7CXM21UpCzPFPZ7gQsHPDoTbiwBNg6Fa2cW8AXejEVbRTgylvR+pIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/onPDxtGC/i3p+6usAaFmzNWIbIO4sziHTeRDEKIFxQ=;
 b=d1Bf1jQOAKXOwA3yLP6OY6tHNgR+YQvHwSjXxjF83WRZgbKp/TEo7Rxg3wq8cSTMd9bFKadCFD6T4cLuzreI0KvuEnQxlgwRCnkBW4JL8vhCrg6U/kZM/QAzX3xw4OCfySgf3nP9hFZM8GxJaVAr/kwRga7rjoG6AKWGzWgtt6Ib7NOfnBp4n4K6KtxvjHzIfVGBYFnl0wow4xmvWPKHggsUD8jMvq101YkSHr3bYW899CXzjU6I6JTsf5i1LmS2Yk+RnkVyYbtjx/Mbg/D89+5oowmoyLuhwp+QfdFTwnDHBV2c2IwwEKFFCiuFrQq3wnYucnu5Bzl48v+LRi8iVA==
Received: from DM5PR16CA0022.namprd16.prod.outlook.com (2603:10b6:3:c0::32) by
 MN2PR12MB4813.namprd12.prod.outlook.com (2603:10b6:208:1bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 10:28:46 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::b7) by DM5PR16CA0022.outlook.office365.com
 (2603:10b6:3:c0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 10:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 10:28:46 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Jun 2021 10:28:44 +0000
Date:   Tue, 1 Jun 2021 13:28:40 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
CC:     <mst@redhat.com>, <jasowang@redhat.com>, <sgarzare@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa: fix error return in vp_vdpa_probe()
Message-ID: <20210601102840.GC215954@mtl-vdi-166.wap.labs.mlnx>
References: <20210601080505.8394-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210601080505.8394-1-jingxiangfeng@huawei.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05f9ecdb-8c94-4ef8-45b4-08d924e809c7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4813:
X-Microsoft-Antispam-PRVS: <MN2PR12MB48137F148B57632A5DF88EF9AB3E9@MN2PR12MB4813.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JeS1GfxfPGW3CtdTMH+ejkDsAB0jJaDhCvvA+7abq5NvGSwtHSh6kGvoF6v9IpUrBccripgJ+XdJLvorV2KyWIr+HSAEn6Lae26AgoVbe8YfD3qmXcwe6dgaSzMTDB2yF6r2cZ+BRoYEWMFyZD90t/ee0HXWFQGM3Vp8G5w7PwZq+PwCdW5h1jj38If9tr3+Orrh2YlQYZtklyFc8fVsHa/Pecx4CuU0YjeHYN7v9wXVC7lqmnFNMcTslskTosTl4mKIgILbrpKiP+Q8qJDSg7QVgAkwxSAj+LRs5iTn0oCl84vnPJ5oVh1OcGJKMCK5Fyslq5pi6FhArlFxM7J24Xdp6EAIPfpCBRMUQtUyERvO4Xr8iSk1x9jIjQ0VSgaYi+uqBQ+4kXLfEZvzFUiTK05R+A5rzOUtNeEC8+ZhHxmVo3CmhZLBqXU4SSmJu6uceW4WDbELObakvuqQCTKrE8CIIE9gGvlIQzovP2rg9SyAyXtvFYeb4ZN+QO6E3gF16AZ7/MQrE1a17YS1BB6WelEwg7ryINubapjEBiB/6fJtCH3A6bb4L6j9vyyhg8o6glt0RtZoRfai9hcOBbtdmDSZy1Opo6NKuM7V2n55/mKHDl1wvS9SSkf0bsbyAODWu9BrjUvpZLWZn/noqv76U/v0D0xN3/fmL4Cm+vOKfoU=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(46966006)(7636003)(4326008)(70586007)(9686003)(8936002)(478600001)(6916009)(47076005)(8676002)(356005)(70206006)(426003)(7696005)(4744005)(86362001)(186003)(16526019)(316002)(1076003)(55016002)(82310400003)(36906005)(5660300002)(6666004)(36860700001)(26005)(2906002)(33656002)(54906003)(336012)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 10:28:46.3643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f9ecdb-8c94-4ef8-45b4-08d924e809c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4813
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 04:05:05PM +0800, Jing Xiangfeng wrote:
> Fix to return error code '-ENOMEM' from the error handling case instead
> of 0.
> 
> Fixes: 11d8ffed00b2 ("vp_vdpa: switch to use vp_modern_map_vq_notify()")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Reviewed-by: Eli Cohen <elic@nvidia.com>

> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index c76ebb531212..e5d92db728d3 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -442,6 +442,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  			vp_modern_map_vq_notify(mdev, i,
>  						&vp_vdpa->vring[i].notify_pa);
>  		if (!vp_vdpa->vring[i].notify) {
> +			ret = -ENOMEM;
>  			dev_warn(&pdev->dev, "Fail to map vq notify %d\n", i);
>  			goto err;
>  		}
> -- 
> 2.26.0.106.g9fadedd
> 
