Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C1439665C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbhEaREh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:04:37 -0400
Received: from mail-dm6nam08on2087.outbound.protection.outlook.com ([40.107.102.87]:6369
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233625AbhEaQGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 12:06:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/2zjXfB/qXG2zjacaOfm8JWs+wPtbcz694DduBQ3FKI2tw27Y5tg4BQdmffTeCyBfjv6En6PL9c2Pk0oOS+d93kRjznh08w34vO9paX9/VHPgh/I38fpgxIbKE8dDRDA0nfa2U4ZC9Xi5KWfnrnZLPlzyWv9X1b8ahvy7MRREniq0LanoogrZQPmYXFrKpVVy6RksEMlhDie0pZWNF1Wn6iE4dXfuXcyUNau0vgCv0hJzu4VbSmt/Y7kyv1jppVzT/aWTmcKPS5gDF0TF2OWkm/JpMNppL2tmvb5TVi3R7jgvl/BBlpgDCvmefFZARHZ+5hlQrLGKNm4I2ex4K0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cKw7b2jsObhWr+Ae+eQnIbtTmP+KeRA/UcOISxjPuk=;
 b=Y5vgdqvKEKmxOei7o39ga3XP7L/95F4eHk5Ae3cwU0dmHfAUemE3LrUl+1r0KX9nZNylr9VGvxz9NSB0gkLMSUcywircT2DdA/RpQUY2OQvgLAwHSP6u8BC2VVtJG/GAox3qYLsdAwxaWvpYhQmqibV+G/vMhf1+3Ezkmp/i717Pr77F1bAuOs3uFkg73graVl2CgSeQp+sv4kKsez8UREt+VB0hUe9nHvJzLZO7NVnNxPpYikX9UXRnFIZ/2YErGQ2GqSu+1pds2nOW6H+RcKWQ6zA04qtAKhOBqKLOQbHajoPuyW2GN3vDC/nBU0pMBLHEjCxXltp9aIXbsFSsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cKw7b2jsObhWr+Ae+eQnIbtTmP+KeRA/UcOISxjPuk=;
 b=Kx7DDzRa3LEKWdWd8emZEa0VtuE5/ze/yvQufJksdy1dHN10uVjIZLJhv52YWcVxizMok3jexEu1a3a+g95ssA7q98MwX2Y9W8lON5x4cZjp01AUd7tCHA232qA/jzztoHvhAQXmtrsPMF+GPpF1O73ihCH+GYuCGgV4mjLYOWAD1uQeBP3jGmWKiISu7zNrSpZS44gr0qF5lCii89C2rNeXz+ul9cYKpoQMVx2rzhrUxjP3Q02kTQoJ/ESHRboDo1N2ZH2tcn5NsreCN4H+vYzPTPYlf5dhxGDp9WzvbfmOwQebO97yzcKpGkoR6vN/veV2zcPqt3n1lqw/jIACug==
Received: from DM5PR05CA0023.namprd05.prod.outlook.com (2603:10b6:3:d4::33) by
 MWHPR12MB1775.namprd12.prod.outlook.com (2603:10b6:300:109::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26; Mon, 31 May
 2021 16:04:55 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::ff) by DM5PR05CA0023.outlook.office365.com
 (2603:10b6:3:d4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend
 Transport; Mon, 31 May 2021 16:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Mon, 31 May 2021 16:04:55 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 31 May
 2021 16:04:55 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 31 May
 2021 16:04:54 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 31 May 2021 09:04:52 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH 2/3] vdpa/mlx5: Only return vq ready if vq is initialized
Date:   Mon, 31 May 2021 19:04:48 +0300
Message-ID: <20210531160448.31537-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a993ff91-2512-4ccf-5a0f-08d9244dd53d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1775:
X-Microsoft-Antispam-PRVS: <MWHPR12MB17755BA2FA6FFFACAE5D5ED2AB3F9@MWHPR12MB1775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/s2FaAvu7/rpDkhj8yDn+AGfBW+la8FORErNXR7afpOB0yNsKMbrdS1CeL/bUngnB6tgcLbLke+bNik9AkduZvO4S67Xx/md0XwV8LQoVP8ZiZkjDgaMtRtRn3h9mtLFnGKJness8L9kdr5bV1n9Iwhq8aXFmtrXHgXcO8zJzn9ppenG1lGd8T/IUhwa6e6VqedCPblwaBq3s3s3XyGFIEeTuwd9b5x8TiaONQcF87qpaa7O0wBgzwMciVHXZTHSuPwQ72//gW4utNP4IT2aP2egqY09eCVSKj9guf/EzvZGqqzvvzsMppCPiLF2SWckyVpp4rLtn+p3aAj/R6GpqKcbVQJGbpwUQ/8QbIsnJySmNguA/0CQIu+9cNzHjoLpFgFEKWsSZQsBGtB14JasDYCOu17UNmMKmF3ywtEoJLd9273znfNuzTfYqpYzSwMJL94go7wKvkh8a1m1g0H37cZNTHllO2pgA06uPlvOWPV0PJp3q6yHUfO4BCz5ZdM623egdz9qYwXc8D/D2kqjbtNKbOSq9PG8MQpSFh8U//6b5c/wme0/1qLTw0SCIa/hSa96q7cI7tcIe1XWTtnxBPIpO0UxOUImZeLT1/rEUzalE1O0wrIgYnRdgfhjMyoCxyetHeJe921IdOrWlLDYLwmvtRr1CkuYlndfYJW3xc=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(36840700001)(46966006)(7636003)(8936002)(478600001)(82740400003)(6666004)(47076005)(7696005)(426003)(2616005)(110136005)(316002)(186003)(336012)(36906005)(70586007)(36756003)(107886003)(4326008)(36860700001)(1076003)(26005)(82310400003)(70206006)(86362001)(8676002)(2906002)(356005)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 16:04:55.7135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a993ff91-2512-4ccf-5a0f-08d9244dd53d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1775
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only return the value of the ready field if the VQ is initialized in
which case the value of the field is valid.

Failing to do so can result in virtio_vdpa failing to load if the device
was previously used by vhost_vdpa and the old values are ready.
virtio_vdpa expects to find VQs in "not ready" state.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 02a05492204c..f6b680d2ab1c 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1407,7 +1407,7 @@ static bool mlx5_vdpa_get_vq_ready(struct vdpa_device *vdev, u16 idx)
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[idx];
 
-	return mvq->ready;
+	return mvq->initialized && mvq->ready;
 }
 
 static int mlx5_vdpa_set_vq_state(struct vdpa_device *vdev, u16 idx,
-- 
2.31.1

