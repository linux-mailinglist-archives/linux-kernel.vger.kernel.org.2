Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D94E348D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhCYJs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:48:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32452 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhCYJsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616665720; x=1648201720;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=AgdirdTWsZQ6MPIWl9eIxAFv8O5QoASvQvryiZzxIx4=;
  b=KEpszI5LIWUoRrIn97zIQj2WaxvNLlH/nZMi0EZToKkHkORw1fJhktac
   J68RlxEDlqihCFHj8pRv/KHmEV/AiNrcobAct2OqgOFXiRd57J2bRTUDG
   FT7iqPPP7r3HOHUWlz2TUTjBjPuRPO5cUsW068XFRmrN7pIXxFaKxhIbn
   AhQx+WGAUubRwIUoVjHb1FkvGQ3UMH/6PXiB3GceviK2gyD7Caq1owVWs
   hjbggIQQRdZExWVMS7P3huNWTNuyLB9Z0m6u/r66O50dK3lF/PVgEz1b1
   Z3KvhZUzc6qxmKF/JikA1NN0xwa+DD1wq1Qz1rv+p8C1d6+ElWqksMp5q
   Q==;
IronPort-SDR: kZpGICwW5mKVqbK8WsjuSYXsG6C4uRjcg9wMU1g+8hhV/GIgpN5/d8ygpf/PKChwPyK5Xl/LbX
 JPdy7yKvD1UJJoX2msRiNT5Nhd9jLDDbPGTeBZyBnW0HWjXUksb+fnHb0qnywGR0Mz5uMQ2/GJ
 fZnnwLlnBnsf5q6FunhEfd24zPfkq2U8nzf6IzVuZQa+yVwmnjik9P8RE+395ZnckJ+42ZKX1Y
 GEQ2qQmsWnLos1UKmZ6Y2PnMisKkhTA5flq/Y+ZVj0aMW3qWE1teZN6nViWk1hVRgkVMvfF5x7
 AsM=
X-IronPort-AV: E=Sophos;i="5.81,277,1610380800"; 
   d="scan'208";a="162968175"
Received: from mail-co1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.51])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2021 17:48:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm3yRvdJeVviphivihMgI/scHK5Pdu0xiyjHcxVYeKD9L3VUeHFIDnZIRlmuQOB1km7QsyRKMH0Bg9K9fou1miKJu+4ImQdG5JNAAn8A4VrR7O8XMx822kP/vA7xSDpTBhfazgpQAZnWpIt/rF/jBKDUqq/5eyFohL3tBN2de+sDvHa+0ZTMWjdAJOyPUogqUyJnakWc2T2U8/eZn/GgNkmXosZbGVJ3dW291U52SfkDWJ5UPWw8naIVsc4fz6MtrkLnvXJAwH8EDO3aivnXo1qi+8SvY3+wwzLhEctxom7JwDemtRnsiJLwRHszihMeGSUKjRIDjQfY3z2ZDel9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hByx77g8UvnVWV6rdi6Hrr5Kc2xurGO8zutJsYAVs0g=;
 b=ZwYc4iZ23DJHeDjjFdvntjLwd+k/L2q3c4P4qoU+Xc+HV9D3TrZ9DEIea6qjjdnrROxSzckDaDVaJynda/XfyUUfRPWUaKS2H5WeAeuzdLEXBsg3pMPAVFrisgdqxs3XLOMXJviC6JOc1M5JPxC3qt6kTLIJtpmRbK2TFDkhrRBPkrJPNBmnLByCWo8uKT8Hc6e0yiyYyXamIRKm70Lxf3VUkmuyRUIS2XQuDongMyp75YsjnF2J6VPPfGNnRtaD5zgfsq/kQyHr2vGmRlYVF9oAXWZPMctfhX5ZapoSq7DOBBGPIj4sMRoJTQPfMmzSrtEzacoRAhFRzRxnPELviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hByx77g8UvnVWV6rdi6Hrr5Kc2xurGO8zutJsYAVs0g=;
 b=yEPzXz9zyF0LJhbGxkFSnBd2ykP9FLmslhI+US9W0GlnG1nTKK4b3QXESRQPI4leYfXBu7u0uqdlIlhb2hrVX5wXVxH71cVBSs9lF0+cIGMKJxGo4C5CMhgWBEu3+LhDzVmkV949xBDHkpzFe9jsyG38ORMICLFzS7F3Ty6+UhI=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM5PR04MB0682.namprd04.prod.outlook.com (2603:10b6:3:f6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24; Thu, 25 Mar 2021 09:48:38 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::f0ed:1983:98c8:3046]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::f0ed:1983:98c8:3046%12]) with mapi id 15.20.3955.027; Thu, 25 Mar
 2021 09:48:38 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        "javier@javigon.com" <javier@javigon.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvme: disallow passthru cmd from targeting a nsid != nsid of
 the block dev
Thread-Topic: [PATCH] nvme: disallow passthru cmd from targeting a nsid !=
 nsid of the block dev
Thread-Index: AQHXIVwH1ScTxDZzaECPp8Ru2XC2tA==
Date:   Thu, 25 Mar 2021 09:48:37 +0000
Message-ID: <20210325094807.328126-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 514b1b31-ce3a-427b-5e1a-08d8ef732a2b
x-ms-traffictypediagnostic: DM5PR04MB0682:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR04MB068239A3AE34BB855CD36FDFF2629@DM5PR04MB0682.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tUhD+cVSxLnbPAYqsU4PlkhviPCS9N2atb25vT2bP0+Fxa/d67A6aFmoJTn5zOqNh5+cugmK1MU3h4g92WA/HXaaSSeyDGAuzhhbGftrQonCLbyx20oLDeIYP8I/7ezYUY2ZkZzb/L10mmwznNV2Bfk//eeuoY6ZCMqVivNrhmnX/9V//G5JqLCwb1I/atRk8/l8yB0LnD3b5eB+AJLT8TUPSaRbcKuTxf7IarbqdiPADRVfq3ZWyDAgnm1W43uzIzq812dX2oyTLtlV0459rQOID+lsKTn04qIGkmN6PJFrwNSoGcIvYy1sGVH2nFsDpLGcKRu/LhzKo2eSlk+KS2DRVysVJONVnrxMKGptVnoZSR26xEWoXd1V753MyLX4Y51GR6mxb6EQij7vHarcbsTIwtqQUCHac5tW6O/LGyJGVq2TUDSfsq6rdGQzFFTDsrpjkFpHPi3jzsMbrglBFkgKwVtaIJxYTlVeu3igDygsWt3g96p2x9Re6pCcZdMmksZ7p7vnJB4VzCV6l9ToqZiuafVXNDiODKFax1ZE0pLh/sQc/gZeMSD0pTh3EcQTCmMs/6prHDOcqSn06035XctJ4A2bdu/T+T8rAtlQUJ1CpOHOqBlkhGC/mqOoDx6NFW7/iFY237Jm5zCBHAyI60t6UR8HpHNEDHBsXQaRi2s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR04MB0684.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(6486002)(86362001)(2616005)(1076003)(5660300002)(4326008)(71200400001)(8936002)(66476007)(6506007)(36756003)(110136005)(54906003)(64756008)(186003)(66556008)(66946007)(316002)(2906002)(26005)(478600001)(91956017)(76116006)(83380400001)(6512007)(38100700001)(66446008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?u6ouSctc2ZUq5xzTteH8z/ff2Dz68GablKgwIoKXSAnBlS6zfn5bPkqevO?=
 =?iso-8859-1?Q?u+ZIRcKiVDLvU5/HCAHxpdk0BeQkQgMhHSLod2vc6IOO2qGnK0mHvIXQd0?=
 =?iso-8859-1?Q?QQCfuN0XpTR20VZkG2NZu5ys1UzuDhK/0WMzZthXXFLJaUjMl/AQS1hug+?=
 =?iso-8859-1?Q?sA4r2hkyQf6D9SXVNjESZ+eX3pynRIaAuchpqGgViv8BC1e43EK9tbX5qo?=
 =?iso-8859-1?Q?pHiyonL8BRD7Y64+CE1k65lgjaFzoDlPguPNwC/rdNkU9lkmA6cBrt7/zn?=
 =?iso-8859-1?Q?l0B66RmYD0YQpab3f3G1v3chM/JVQz0LWx2NfhP4zSvXkhgSzmMXgnSKyV?=
 =?iso-8859-1?Q?NsszmauF2jdGdRH8SjRu4mVlNfqEjlissRVKRVVPGrNSaZzi3Hwi0Il8Qp?=
 =?iso-8859-1?Q?EobXSm00wW3BXhnrk/8AUbbMi+C9bOwre0oAk7Nm/m+PsQw2ThCEiIgyRx?=
 =?iso-8859-1?Q?wrd/Cayqid2+5/1kODc7s7tSHJCsfVXYeuEDKBAezx8f1XyKQyhrsxhmJ9?=
 =?iso-8859-1?Q?2oSkEX1/79AzigN3OUIkH22QhGnXyAeAMD6cjG3zT12GSBK2fQWUIl10cj?=
 =?iso-8859-1?Q?LqplHdHAlHbV9evhKEueNMvgUUh9lrjcMwpFfxHUMeu1pnps43nWzb7bQH?=
 =?iso-8859-1?Q?RrLU8B6TeNY9klbNblykBEUMzWmGtUZZKJ/rqX2RRoLJ24cLZPCFZ8T2k6?=
 =?iso-8859-1?Q?Piwz/GkRJyvQcOhb388v7zNMgH2IvQLDSQhLSk32rCKan3XkA6xPfyDW9e?=
 =?iso-8859-1?Q?t0mzDUPF5iFMy8jKJ11la1a+gP6i5CHiZT4T8q+tGo4EuUrwv9/3GQ+ksC?=
 =?iso-8859-1?Q?KXvzlsb3X+qRWeTv5KbDOho2chL/c/Vm8txN1VO5mO0EsiCrx7E9/jEU6p?=
 =?iso-8859-1?Q?+SwjHnLJbl/DfTSCbVACFwOQFzR/ZTVs8/3cEe0da3zoVFOjmPQhEvG2Ll?=
 =?iso-8859-1?Q?sZ4id/8mzd754iQX6eDUd06ylA3RzByRAxDgWcQNZ5Skbpk5W8427ROy9Q?=
 =?iso-8859-1?Q?ZKZc5zDIsoWC7xQSKyhvCSc4Uz/ZgJABqa9BGXtssCbjRHFYnSpTpk99j6?=
 =?iso-8859-1?Q?44/GI8ycpMO/wRSQvM8kCLLvCI0X3AfPoocmbFSBpBaFa9dq0jMLXam68v?=
 =?iso-8859-1?Q?MY0X5M2RO7ZHXpKn4vV6yBjZgYQb7YdpzjVMJzFaDoQ2ZJwAP9iIk0MEx4?=
 =?iso-8859-1?Q?dHVyGY6U7bI2tKlGN1BU8ZvNQuCo9OJPvycXnkuXtrIzbXv8xaXwnSBDHq?=
 =?iso-8859-1?Q?Qc8RaYedmKuuXU1vCIIIafzlPXyMxdDvb8pBVYXyXuMSwleVeH4OxmrUgz?=
 =?iso-8859-1?Q?x3tdI/J4PZ+lIEh+vca5RemdBhkS3FJ5kF4P3zZns0x98pHqCHb4akRhkD?=
 =?iso-8859-1?Q?TuJumYxfaT?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514b1b31-ce3a-427b-5e1a-08d8ef732a2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 09:48:37.9028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sUtf/79cOKFEed+KY+Sfk8SkSXlxfbQSTZWzj4lanat4ksIQn4H9z6tFD/pChtERgqBFlHMFVvMkAlMwv3R8cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0682
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

When a passthru command targets a specific namespace, the ns parameter to
nvme_user_cmd()/nvme_user_cmd64() is set. However, there is currently no
validation that the nsid specified in the passthru command targets the
namespace/nsid represented by the block device that the ioctl was
performed on.

Add a check that validates that the nsid in the passthru command matches
that of the supplied namespace.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
Currently, if doing NVME_IOCTL_IO_CMD on the controller char device,
if and only if there is a single namespace in the ctrl->namespaces list,
nvme_dev_user_cmd() will call nvme_user_cmd() with ns parameter set.
While it might be good that we validate the nsid even in this case,
perhaps we want to allow a nsid value in the passthru command to be
0x0 and/or the NSID broadcast value? (Only when NVME_IOCTL_IO_CMD was
done on the controller char device though.)

 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40215a0246e4..e4591a4c68a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1632,6 +1632,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, stru=
ct nvme_ns *ns,
 		return -EFAULT;
 	if (cmd.flags)
 		return -EINVAL;
+	if (ns && cmd.nsid !=3D ns->head->ns_id)
+		return -EINVAL;
=20
 	memset(&c, 0, sizeof(c));
 	c.common.opcode =3D cmd.opcode;
@@ -1676,6 +1678,8 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, st=
ruct nvme_ns *ns,
 		return -EFAULT;
 	if (cmd.flags)
 		return -EINVAL;
+	if (ns && cmd.nsid !=3D ns->head->ns_id)
+		return -EINVAL;
=20
 	memset(&c, 0, sizeof(c));
 	c.common.opcode =3D cmd.opcode;
--=20
2.30.2
