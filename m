Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9A0399B99
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 09:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhFCHcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 03:32:43 -0400
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:21216
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229840AbhFCHcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:32:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhOSIlnTqGWB/RoFX5retou4SlKgvXbDHjVHRWBIcFiEpms3zSigKw6vGwZqrA2ydwS5aNuMslR0reCr4edPp2GSOZESLEF23vdxscbL0rJ5t+kWHxZ5hpPx9aty0iVpxtgncQkJoLQuS0V08AJvuqtbtRTY8cXZRb+d7D2nKgE3M7rWX6pLDsDcMZVTbbUEIXFKRsl/kAb6mmCWHVd+0/Nxm6CHwEccdtAbW0OdgBIaaefJf7jRFqXueoN8FYZ2XXEhG/WrG6CSidMw4uQEsQAx8Vl29MqfXyZ4h8oqn4C2nXHbgHhLV4vXpJW0/vxPetC72GLFhTwQ2+dfRPV0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3gqw5Ftv31dPRs89GfA71IyzSpP9hrE1Zk7pfs8d+E=;
 b=ki4Fs1+SMdTW1hz3P+0rqlmNVevfBgpOeQko1tRqnIEjI5BmkR9avyohcO8BuT+MmgMBkStyQZOpSQsJxEMnOCgHt4z/5iJ3jDH9GqaviUDSfhPkMWwQYpZ40Ld+FOm1fNozYYmBS6gm8zQnz5R1K+oR0gBkBSrvmVCs/laBx5xVzZUDq31alTKaSex59JJ3dvkHvQVJYcv+BywZwabRHKpvFzhPXZMe8Y/061FWkmBRTQwoTRQnvC4nIPcmCS4Xib8rQds5qKidqbVDbgiO14bBoSPJU4KhNdzoP/fHlRjJz/RfqHZE0CT2NHJv5vJvsxrouKALcO9INCvvJVG+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3gqw5Ftv31dPRs89GfA71IyzSpP9hrE1Zk7pfs8d+E=;
 b=f0LnWmFVSv4mwENOmvAxBfcerJRJ+Ui/VMThcDYzCJhSZEzZBktFuHHF6L6fDC8X5meA0O0EmbWtB/YK2JRDJ5Ykm9cC4beXSGaqN4SkNh+uobLVpnW89/uwdrgaiouhSiopK4YQRM57CKjQiYXBCNG7eoaRQPf/vAQxTmd0rklTOcTECbMlRaBigyY8LFUvAiKE0SmCzamWV1SlHREzhvwOeGz8VdyMw0QJbP6MevIK8m6VGndlslU6ZCTaJMHdtPoDWbfii18L6OYibiuzaZlGXDvspNWFBTS3XRpnFquH26I7d9XmCTnWltB+rqy4RQneLN/JCZmP9GFwwTjihA==
Received: from DS7PR03CA0226.namprd03.prod.outlook.com (2603:10b6:5:3ba::21)
 by DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 3 Jun
 2021 07:30:55 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::eb) by DS7PR03CA0226.outlook.office365.com
 (2603:10b6:5:3ba::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Thu, 3 Jun 2021 07:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 07:30:54 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Jun 2021 07:30:51 +0000
Date:   Thu, 3 Jun 2021 10:30:46 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Clear vq ready indication upon device reset
Message-ID: <20210603073046.GA58414@mtl-vdi-166.wap.labs.mlnx>
References: <20210602085924.62777-1-elic@nvidia.com>
 <6e4f9e1b-2c67-fae6-6edd-1982d0f48e22@redhat.com>
 <782562f2-6903-68cb-d753-ac90aea854e4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <782562f2-6903-68cb-d753-ac90aea854e4@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bae4d6b7-25c6-4a2a-cc6c-08d9266185ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB3433:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3433D4DA4F898DBADEC46D42AB3C9@DM6PR12MB3433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: piShNjCwP55G4Vj9QHIRcn872x5HItx4GzvQD6YZCBwH2N1i2bZu5P7JfxVxkNuli74ZgDIrFbTnKf8RgNuSGY8XgiBMicsjrzDFXch//mmMfLZdl34mM80TtYpras5/YZ06bCCV+958yPnEWHHCCShGmA3hTXbNcQccxueF9hD4gJ0XrN983bCIUpvvgnMUPV0OJjPHMF3Q7GV1BHu96hqeWgPdlZVC3LQ4pa0mvsroE0gXtHLNKr/wlAhm+vo43YdykBgk3w08d9jkHpLG5JBffyt9jPG0YREbStDZgCNSv1XOolIVDqGUTyv22mfnW8mWuM9cacX3IORX+N+hFdz1uaEDmeVqQWJmPUdg76bQjnguLg30oefWolrORLmbxsUw8IhFUq2A/tc/6dL/IbZmSOf/1zkY6MIhUp6ocunNylq8Hud4RbU72gAbEc7hIXMzcTW+BmUr6xRr7wf7m2/waRYgaWY/lMjtmkYC8rKYjFihtmxchoDF/0gtqLCBq1v7Kni9dqNS9dxlERNTqauKN3yUMGqpUqfFQIEwklqqo9stZnSjfLYEdotPFRgpWjafxAqx42Z1Bu7p5LVljxq/qyC2bVvccNdrAjH6/7K3ENnFdeyNAy0RvjimOXHF5Nl+CO4WCYkOrjPPsr9xsjrWFEGkNrQUF3KZSUZcKCY=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(36840700001)(46966006)(6666004)(83380400001)(8676002)(7696005)(82740400003)(6916009)(7636003)(356005)(26005)(70586007)(33656002)(55016002)(16526019)(86362001)(186003)(54906003)(2906002)(316002)(36906005)(5660300002)(1076003)(9686003)(336012)(426003)(4326008)(47076005)(8936002)(82310400003)(478600001)(70206006)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 07:30:54.6332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae4d6b7-25c6-4a2a-cc6c-08d9266185ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3433
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 03:06:31PM +0800, Jason Wang wrote:
> 
> 在 2021/6/3 下午3:00, Jason Wang 写道:
> > 
> > 在 2021/6/2 下午4:59, Eli Cohen 写道:
> > > After device reset, the virtqueues are not ready so clear the ready
> > > field.
> > > 
> > > Failing to do so can result in virtio_vdpa failing to load if the device
> > > was previously used by vhost_vdpa and the old values are ready.
> > > virtio_vdpa expects to find VQs in "not ready" state.
> > > 
> > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5
> > > devices")
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > 
> > 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> 
> 
> A second thought.
> 
> destroy_virtqueue() could be called many places.
> 
> One of them is the mlx5_vdpa_change_map(), if this is case, this looks
> wrong.

Right, although most likely VQs become ready only after all map changes
occur becuase I did not encounter any issue while testing.
> 
> It looks to me it's simpler to do this in clear_virtqueues() which can only
> be called during reset.

There is no clear_virtqueues() function. You probably mean to insert a
call in mlx5_vdpa_set_status() in case it performs reset. This function
will go over all virtqueues and clear their ready flag.

Alternatively we can add boolean argument to teardown_driver() that
signifies if we are in reset flow and in this case we clear ready.

> 
> Thanks
> 
> 
> > 
> > 
> > > ---
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 02a05492204c..e8bc0842b44c 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -862,6 +862,7 @@ static void destroy_virtqueue(struct
> > > mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
> > >           return;
> > >       }
> > >       umems_destroy(ndev, mvq);
> > > +    mvq->ready = false;
> > >   }
> > >     static u32 get_rqpn(struct mlx5_vdpa_virtqueue *mvq, bool fw)
> 
