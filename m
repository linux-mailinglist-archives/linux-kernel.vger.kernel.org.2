Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B13A396C05
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 06:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhFAEPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 00:15:40 -0400
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:16505
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229460AbhFAEPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 00:15:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ht7iJ4km87RFTNYixyLcoAxQpYJ4xeWq1hTssCEHO6fZIr6Hhns+rJ5FbsXvQT1A33LvIVxM/SCJdJFizAxgy+PkPHg0cFoyM9OIwu6mQpoo2poKadEyQE6q2X68oAEFAkxNPgbodebPO8UdWynQ8FUwGVJnFFbs5Jm1xx1/qN8asulcJTsGuVNdPVErs6MsiCs7v/LypUj4vyXbVj9zXCb1XjhCq8oDUzDkMzQqOweC4Bg6Uq3BxRdd+1I2E+K7a9hNxkIgeI3SVIE1CqzoX2l9BjoIB9WDIxcHkeLXMrWqGvSEOLC85a2g7+WWDyxRuFxaXRhbFLh1NHBsVssTeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIIJISiU61waSxxgIRUYg0yP3o/53yeooylliS+uYOw=;
 b=E7792QpI4XjuZLQGcS+rTl4/yyXrZFDlACseaDz0/n0+HWF+3lVRJ8iZBskxlbdd4504WqUqJZAuFLppnGS6QqCWKE9R6LtAs7p5riMjIpuF5vbuLPNiBojnjVfQORRHInxkdaEoIVo22ojo7nlK6t7wESUX/LzSKVSHIr/blzn3rOYhAnUSVSdZ13MEcktt2+YjjBdhCZiUqV18I4ayKwLymWE79S9eSzGFHlbxyn8Ie8IfCUcA+3DTaPwIBzZU1wVJrLvIwcJx1ADFyO5JnFkjSqrR3IY8/9Gsp2QHPHl5kn0YM04lP0fIpULdBNAm/tlMg4nYbDeA3dxczvkIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIIJISiU61waSxxgIRUYg0yP3o/53yeooylliS+uYOw=;
 b=dGcuav8Yj17SQtNwvKIc5JYpbmyFOjdA2IJAiyX1CAVaFQPBG8kk+aHyuwhUSvzrGj6tSCHqxuISe0X2OINCO7YI7gLacsHy7G22pqQ5+cuDEYGnMyQlUavPOE0QTF7a1k0GqKnYvIxo3Fn070MzWaGXVqbMqrQ9F3poRYZPMc6/I46OcAjv5Pf7ByQIUjF81HATCXK65XE2Omdvex2xJDdmfII9ZqSXJKBkcVVvCRisuZt06Px9uGMZuveuHitDyW/dSMEYXhiP0ESmUC8vSFCL1za+aD4q/ELWuokU6OCPBVbCj3DarFoFqghMjfiIu8k9LGlKiULhqYDbtmP8Xg==
Received: from DM6PR06CA0028.namprd06.prod.outlook.com (2603:10b6:5:120::41)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 04:13:57 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::15) by DM6PR06CA0028.outlook.office365.com
 (2603:10b6:5:120::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 04:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 04:13:56 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Jun 2021 04:13:54 +0000
Date:   Tue, 1 Jun 2021 07:13:51 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] vdpa/mlx5: Only return vq ready if vq is initialized
Message-ID: <20210601041351.GC203469@mtl-vdi-166.wap.labs.mlnx>
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
X-MS-Office365-Filtering-Correlation-Id: 521a0951-b9ea-4603-4a5d-08d924b3acbc
X-MS-TrafficTypeDiagnostic: CH2PR12MB4165:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4165B979D293862D08535288AB3E9@CH2PR12MB4165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7PjdBasunQYaykspt8Q6BA88jKBQnQvHYww0Q4msTngICTkJdWt9ijvd9MBIfQdT3zT4XdOrukckznvlkiJmUMbKQ+kFT25DtyLgf0D1fAsgUd58WKvs2QU9b6THgrxjmUWCas9SnK5gjg7BCsfHebpCLJvh/K5U5+ykslWIEP0u5Lu73gdnffABk77XuzHiv8pKWprAAMBtI0fNHiMvJiTATWhW47kh8xnjILboqDifHf5Hg3cuYIH2uU9YtC8/8NyWMlTZFb/KzbMjfJqyddvpKNtXmeH5r0PkfBlNKCt0lO1zIljzNjEv3qQu1VYPs1KYuFevX3yDaQypH0j21jUj9pPnHVr1hvQFKt3fILXbZr/e+b9ucHkOHZDWCWl6j/XMGIWSwsDyZdmVw/So5uHUDwWp3W+1CLI4ia9UhutCkfRWiMGJ1IAtOX/GmIUNc5fXP5PTdSLUOxJQ+Rkj8nf2HMvB1PCfHkAcVjh9RLEd/KZaA4Kdnj/Wmu4P0nGVYHOA9Q5/wq3UHu5EQ67D6AyM72TfSuPnAMyZJYnyrBiPdM87AHyBo44J4d6xqfcRO038QuO9lmVVdsNhFBK5IawYDcglCSKwrHM4yUOqnV2UEDAvFMcHbvlucBYRuAePB3ab+CCPfwYAE9AqXhwpO2LCnAlzLd9dK/OF8+ahxAM=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(8676002)(47076005)(82310400003)(9686003)(478600001)(26005)(2906002)(7696005)(36860700001)(8936002)(1076003)(36906005)(54906003)(82740400003)(316002)(55016002)(4326008)(336012)(33656002)(70206006)(356005)(5660300002)(7636003)(83380400001)(70586007)(6666004)(426003)(86362001)(186003)(16526019)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 04:13:56.4403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 521a0951-b9ea-4603-4a5d-08d924b3acbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
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

Thinking again, I think we should call set_vq_ready() from
qemu/virtio_vdpa etc. after reset to explicitly set ready to false.

The ready indication is not necessairily a reflection of the hardware
queue:

"Virtual queue ready bit
Writing one (0x1) to this register notifies the device that it can
execute requests from this virtual queue. Reading from this register
returns the last value written to it. Both read and write accesses apply
to the queue selected by writing to QueueSel."


> 
> Thanks
> 
> 
> >   }
> >   static int mlx5_vdpa_set_vq_state(struct vdpa_device *vdev, u16 idx,
> 
