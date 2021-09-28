Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E6F41A72B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 07:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbhI1Fjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 01:39:55 -0400
Received: from mail-bo1ind01olkn0169.outbound.protection.outlook.com ([104.47.101.169]:57942
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234243AbhI1Fjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 01:39:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FS1d4TldWV0Hy1VBPkpQYGX1eIE1R+7qaBRfU/zziZM+UWqAIKrM2k1UKI04Fslgd3xPwSDT3hiEELvkWaKaqM32EA+97e6UY7XZmsozDjqLIn6ZJ/E8+gv0P2Ef/hXKhOn09gnLwv+Wu8YDxHsdcH5A117bsq1uazz5bhiB37NAdgZXSNAWsmjAbgBJPNMkpb8zLBUH4C2XR//ne7LWP04+LOHbjdZ+y0Fq1yl4tw2yADhLxfWS0njRkv3x2VWVBknR3gCHWtsFF+wXK8rFA7pK4YBbBvd3qognGwcpO5EATyTkes9+2CR43KWO7syEgrcP6k6Chn16ViOebOLtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=n/dglOcWIpnFrvbnxh3vpzSAEknKr0fQW0DHzX/vmvY=;
 b=aYWANDDjX1GFI8C6OmsNJ7zAObCeSYzLOQjqwTLbr6NN0auv4cb4N107g19DUE5XgQ3DFrQFn6XIN5c6EFRWr8vqZMO8mzOUq9uzE94etRj6h2W5PVmZOCXmtgimfiw2H0DoI1BRi0iGsW9pJTelEe3hwIgdLuEKXzGPOLwh7BZpckIwIuSxPAwfC1zk1H3gmaTQWod8oZKsAbGSZLrTAwM9VTZVXy8EUc6o6Dm3OEJcDEBVFRqQSqjz9CaztAbUpCzdcX00W+B0fiPAGJW7VKlOji/+XpwHTAB3xpLUOojrD9b68+h+8vkoCatDSpD+AvXDZs7jRimc10csZqiQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/dglOcWIpnFrvbnxh3vpzSAEknKr0fQW0DHzX/vmvY=;
 b=eEzvptCkpbiCpu5jnAFUu1OeAvHhnK0cuMHSabbzgXXX4FZXRQANCbitJzWhXZ7CNTLuVgihYW8IfjYbxIE45bG8LxoiLxq0mz5x587d+xE/9pPhjXzr6HybFrSxxnwzfZbBXcbTQHQWRXT62+R5VGHyLPTgPQ7EYm32oZAINV0+ZnldqXRHpg36E2GZFbE2GjgqmAGtsmtXolbu0s8YDCtNj26PcvcJWI0u5yFlxtjfXtbo6nX6oEU57cvDvz3syJQBDRzG2qFE5JyzQqqfflrxUiVpaNAKxn65J6tyjpqLUpHZj0/e7KGBpgvIo8rrXA4ay294cjs+i4ocWPLtpA==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNXPR01MB7090.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 05:38:10 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc30:dd98:6807:9ea]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc30:dd98:6807:9ea%3]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 05:38:10 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sven@svenpeter.dev" <sven@svenpeter.dev>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCHv2] nvme: add command id quirk for apple controllers
Thread-Topic: [PATCHv2] nvme: add command id quirk for apple controllers
Thread-Index: AQHXs7ZsMiAV1bP6xk6nzlpopYUoPau47ZWs
Date:   Tue, 28 Sep 2021 05:38:10 +0000
Message-ID: <PNZPR01MB441530003CAF17304C0B3329B8A89@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
References: <20210927154306.387437-1-kbusch@kernel.org>
In-Reply-To: <20210927154306.387437-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 902e148c-343e-0077-3ff6-4da4a8263db6
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [u6CnXFU/693OFAVgogW6mdB6VRkeC3IC3ZMcsOhXqBKWszVS6gPH8cm0Nf+QOFpi]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7e560c0-7b33-4883-113e-08d98242285d
x-ms-traffictypediagnostic: PNXPR01MB7090:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cwoBWT8sou3XX4hTA9I75LF9mYOlx3FTJeLa1ZtS5+/7k/OIPpjRmuJ1yeTcwK2Ipr1+KA+2BkzE4aLYRKxMBBAJZRgFUPub5oVaA2zCioqpErK6XRT7f1iWmrQ5C9Rwm7cLl3wHzfAmLNbDhRlOApVIw+oLrjxmbUj10YpMLTWVwHMFduIbR5fZzHiLNYE9uENNobkS0FJAj0um7XKFRXjaP92ZWT2TNDeyPP2ekFas3c1k/72Tx6KyQtVXnGUYGXzufc5yxCCNnMS1OhScZl37Ak/LhsOmDifjAsKnt9FRgm6+qbc4uoaYSXXNpNCmxGILkH3410Ly7Vud6riHO9+aGB0VDJ0YtroYZNLfc1Kf1HPU+PSpocPpgzz7jTGUb6gGMEBdI1702VWHon/KuqDif0zmKU02lYQqcWNMQJHsBHLVqMJt1FR8YDyEmXRVueLsOgT23fOWnViIYVPuXQajT84HgcZVkEK0byLN4Dc=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: L9Hm+cN1XYDuAwF2bcWBPb0OMDzj5Zu2eLrc2UqzbNA+Vwnx/URGHdzxF3C1krevOlePHtY/zTk3Jx6VpRlKhVCu7ThdGunaUmW5h1Ch/SJHZjcpR2MCysv9AuCS8qaD389LIQWvxC/sTHJiTVK/gUX3nQjnzZfaPCtdK+50n7UWxCzVsxhUgvpi+bKCjrVPb6Y5uShnGExFcCiuucf6Hw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e560c0-7b33-4883-113e-08d98242285d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 05:38:10.5818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the issue on my MacBook Pro 16,1. I have tested this on 5.=
14.7 thus it has fixed the problem on stable.=0A=
=0A=
Tested-by: Aditya Garg <gargaditya08@live.com>=0A=
________________________________________=0A=
From: Keith Busch <kbusch@kernel.org>=0A=
Sent: Monday, September 27, 2021 3:43 PM=0A=
To: linux-nvme@lists.infradead.org; sagi@grimberg.me; hch@lst.de=0A=
Cc: linux-kernel@vger.kernel.org; axboe@kernel.dk; Keith Busch; Sven Peter;=
 Orlando Chamberlain; Aditya Garg=0A=
Subject: [PATCHv2] nvme: add command id quirk for apple controllers=0A=
=0A=
Some apple controllers use the command id as an index to implementation=0A=
specific data structures and will fail if the value is out of bounds.=0A=
The nvme driver's recently introduced command sequence number breaks=0A=
this controller.=0A=
=0A=
Provide a quirk so these spec incompliant controllers can function as=0A=
before. The driver will not have the ability to detect bad completions=0A=
when this quirk is used, but we weren't previously checking this anyway.=0A=
=0A=
The quirk bit was selected so that it can readily apply to stable.=0A=
=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D214509=0A=
Cc: Sven Peter <sven@svenpeter.dev>=0A=
Reported-by: Orlando Chamberlain <redecorating@protonmail.com>=0A=
Reported-by: Aditya Garg <gargaditya08@live.com>=0A=
Signed-off-by: Keith Busch <kbusch@kernel.org>=0A=
---=0A=
v1->v2: fixed logical bug checking the quirk setting=0A=
=0A=
 drivers/nvme/host/core.c | 4 +++-=0A=
 drivers/nvme/host/nvme.h | 6 ++++++=0A=
 drivers/nvme/host/pci.c  | 3 ++-=0A=
 3 files changed, 11 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
index e486845d2c7e..7712a8f78337 100644=0A=
--- a/drivers/nvme/host/core.c=0A=
+++ b/drivers/nvme/host/core.c=0A=
@@ -978,6 +978,7 @@ EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);=0A=
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)=0A=
 {=0A=
        struct nvme_command *cmd =3D nvme_req(req)->cmd;=0A=
+       struct nvme_ctrl *ctrl =3D nvme_req(req)->ctrl;=0A=
        blk_status_t ret =3D BLK_STS_OK;=0A=
=0A=
        if (!(req->rq_flags & RQF_DONTPREP)) {=0A=
@@ -1026,7 +1027,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struc=
t request *req)=0A=
                return BLK_STS_IOERR;=0A=
        }=0A=
=0A=
-       nvme_req(req)->genctr++;=0A=
+       if (!(ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))=0A=
+               nvme_req(req)->genctr++;=0A=
        cmd->common.command_id =3D nvme_cid(req);=0A=
        trace_nvme_setup_cmd(req, cmd);=0A=
        return ret;=0A=
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h=0A=
index 9871c0c9374c..ed79a6c7e804 100644=0A=
--- a/drivers/nvme/host/nvme.h=0A=
+++ b/drivers/nvme/host/nvme.h=0A=
@@ -138,6 +138,12 @@ enum nvme_quirks {=0A=
         * 48 bits.=0A=
         */=0A=
        NVME_QUIRK_DMA_ADDRESS_BITS_48          =3D (1 << 16),=0A=
+=0A=
+       /*=0A=
+        * The controller requires the command_id value be be limited, so s=
kip=0A=
+        * encoding the generation sequence number.=0A=
+        */=0A=
+       NVME_QUIRK_SKIP_CID_GEN                 =3D (1 << 17),=0A=
 };=0A=
=0A=
 /*=0A=
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
index b82492cd7503..456a0e8a5718 100644=0A=
--- a/drivers/nvme/host/pci.c=0A=
+++ b/drivers/nvme/host/pci.c=0A=
@@ -3369,7 +3369,8 @@ static const struct pci_device_id nvme_id_table[] =3D=
 {=0A=
        { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),=0A=
                .driver_data =3D NVME_QUIRK_SINGLE_VECTOR |=0A=
                                NVME_QUIRK_128_BYTES_SQES |=0A=
-                               NVME_QUIRK_SHARED_TAGS },=0A=
+                               NVME_QUIRK_SHARED_TAGS |=0A=
+                               NVME_QUIRK_SKIP_CID_GEN },=0A=
=0A=
        { PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },=0A=
        { 0, }=0A=
--=0A=
2.25.4=0A=
=0A=
