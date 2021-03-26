Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B76E34B101
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 22:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhCZVBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 17:01:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4343 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhCZVBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616792471; x=1648328471;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=DvVHZgavzTqRAUHAQuuqHdmOPV8pSeOMxuykvl/UHMQ=;
  b=pH4XM93/SYHRQOU0ZxdfiKLyaATm9eied4J2tp6wtqWu9XPONJs0ldAU
   azCexRNlvs9zOa0tAvIoLoj2DYqWueej7955k47EgJjGsDaRhFzW9N6/O
   expa5mGj/VWG3Un+i5+7izV4tTGwuF3f6Is0JHsjVuhUJo9NQOMQQ/39Y
   nkvNqBjpmhkG72DTBE1iz+g8Uo2DoZNUb/ete6lNOmUNuidtNRhpSHEuS
   aihBl+a6GgQdElbh0RDKxedpM1ZdFyHe0+2YzEDkLjfUyeDSQ0ftU+9LK
   rth/y1lO1tW9CXLQORGDz9DUBM6/HjG5yZY8oMCyT6hXfoPA4ghu9n/qB
   g==;
IronPort-SDR: /3kieWw+LwOZQb0j5oyYMbLw+k65F3XsSBCpbO5GfLi2JQMloZSgI64nwz1QqFZ15GC1jtQfRw
 xYZ77bCIwj/90RCsuP7K9vo+HVcrxaF3/HRVG3gmmHNvcvEpNGcHAY/LAFIzj7twTHuJegnrNJ
 A8eVkhmimCwTPgWrwLJBmtneBuGnJi0lwqbm2M5de6FQxbM6fZZ9ljBA4OCoAGQDCDMtBsoRpf
 1UNlOdT14YW3xSByxdpJXS+FtYA4eqzAjh43jKluwCbPHnGJhgBXoTTc+9Qx5AQUZY3lhhtzLz
 /pY=
X-IronPort-AV: E=Sophos;i="5.81,281,1610380800"; 
   d="scan'208";a="164210079"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2021 05:00:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYGAUTJ94SbKnYgBX7BLhAdcxmxVIvzbzcCwmHvu/E03JlNP96eZ4GMSkppObx82Y/d6o7OGY5rUUEHvcwZUnyYeVh8E8jdxnJLXKCl/MkBseoxkDSIsW5uqMzBgP1hbhroJy+/2pWIQTMpCx0mAyp9KJVvougAdSezdzILFE3P6OEkL7JBgQQoGeoEJIMAP/AnJcQo9c7HN9xmdgbn5LSUVc4rrZes3GyyyBeTyRQwDZsqZnFfNNHYB8f0UOCcy0J+S0JTZBr4StZ8utjsjbD/dfFoiDUHjruuZgw3qwdQgSYUhglD1nucYlgd5KzoJnA/gMcNHbVsn8sD8HWsw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=378KCzYdhhjMIQ5O647aL67+TJtgBS2MgC2hPy+0pJs=;
 b=iGe5sjkShSvI5Mc4pKEV1G6iERX5pboFCXvmnXFkEoES3gG2luf7vqCeursbz2IoBOumI9ZoCTaHmiuyZwB0W6b92VMbjdvN6dcXuPYG16Wafvq/2g0odzHuC1ImBwOPcgLmMGTQfBzMHqjdlqKEEtg0FN+9WEVBZd00rtEc8Pa1aN5lOrX3h93QWIKSJ8sHOSEDt9mDHaEA4fTFzXNgCfiNmma6S38UPyzh/4griHmsnRzZ6zr3QVr+g0E+TfTd5/drlb7ABBgJ4Uqski9c3eho+hhLH/rCYZHPwWkqwEF02EHlHlUqBczDFL4iIb3TIA2EY8QrImiTxDkxtF1lJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=378KCzYdhhjMIQ5O647aL67+TJtgBS2MgC2hPy+0pJs=;
 b=ZoxwWkfekzWe2Fzf92Ldv9zmL6D2QWek3MTq0jIIEip7Nv1nTc8B4ZOXtezF6YN8CtsSKOdUCQxyfVDa+jJQCQpimMxeHzTiyNQAfIfso/EImwz1kbUJHu87FVr/iZuZA9GDdJlyAKURr7T364wam4B5aOWt8EoOrjfeJg+jy1Q=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM6PR04MB6987.namprd04.prod.outlook.com (2603:10b6:5:240::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.29; Fri, 26 Mar 2021 20:59:59 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::f0ed:1983:98c8:3046]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::f0ed:1983:98c8:3046%12]) with mapi id 15.20.3955.027; Fri, 26 Mar
 2021 20:59:59 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        "javier@javigon.com" <javier@javigon.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] nvme: allow NVME_IOCTL_IO_CMD on controller char dev even
 when multiple ns
Thread-Topic: [RFC PATCH] nvme: allow NVME_IOCTL_IO_CMD on controller char dev
 even when multiple ns
Thread-Index: AQHXIoL7j11tDXmjqEi1+b31xtgfow==
Date:   Fri, 26 Mar 2021 20:59:59 +0000
Message-ID: <20210326205943.431185-1-Niklas.Cassel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 755ad748-17e5-4c69-a629-08d8f09a1e2a
x-ms-traffictypediagnostic: DM6PR04MB6987:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB69879967984A09218C0342E0F2619@DM6PR04MB6987.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: elCpSIc8nfu+8bMSaaAjJ5iaThZaaNfPgUeShZyR/AtCEvgoIuYbJgKf1DW2pszFrKlweT/PfNvdo2FCWsL6uokUmsFiRDlYuYw6LFO/5spckdFCSAYNrUdjowrKql9wwkCGoHdHEXDkV/8r4U+4v8xtRzhygEmL6Dx6GRFuXA2513D+oE3bGiHUHG+ZxB66xEOFbv2qyQu3R2j9XfZ4Uhoh8Kn3qXhmnzKAG+4oybAg92OAaukt9AGWf2iME9e/aiGgnjHLEOhZDwUFvxa66vjolgVQpNFj1K6KmRF9QmStPz15bbsMgtdsfrEel1DV9bdoSU3z3TkrrPNS7UeqV62qpDOP2Dkx8pg4P0i/lKYgyrBPXb1uBqVhk2q3dQDWYP39PB84yH2wYQS4bVZ9O4bKebR9zjvtfWYElHs5JOw1lt/2yfPZguqvc7GvqiGrhBS0W1D35fOLm7V57tuMCB1dwd5NoFw/Mlwnwd5PFsOvSoLaEfQExM4tp+PyqI5pOGj7gtTqKbuugm6oObyWGYlCaa0+/JLUkncJbvnM0pey4jPa1tnMHYcrakfxm++ytg/sGMe5OBNKEsj5M6C4wTFcmqj98btJFT975kdSozE43UQV3qSxJl8m0cgoxNo/BtoslT2AIWnWkKZqHBvRRz9hLOnGOV8x7PjIyBKDDiw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR04MB0684.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(83380400001)(38100700001)(91956017)(66556008)(66476007)(64756008)(76116006)(86362001)(2906002)(66946007)(186003)(110136005)(54906003)(66446008)(26005)(5660300002)(6512007)(8936002)(8676002)(2616005)(4326008)(6506007)(316002)(6486002)(71200400001)(478600001)(36756003)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?bWgpndko9YKZwpUexN3XPZPRTdK6Qgn3ctyUls3yZkNPlfiDzrnqIpsjgJ?=
 =?iso-8859-1?Q?FhMtvP8Xi0l2VYI49i58IQA2194FwhEZWQWOz5taljZkplMJWqkIdN6YRk?=
 =?iso-8859-1?Q?sheawD+eq7ingBFfrQZv72WfT69f6X6woq/K2CmJkeftAUbK7ySdOe7Yc5?=
 =?iso-8859-1?Q?JZYOvIH9Ae5508WxEo0v3lHK5ulC3f6Ym5nxkHkfEOpkjDeLKYoMNEj9wF?=
 =?iso-8859-1?Q?R4+SYSb/JzJYhwdDFcn+IKbw+o6gI1qRldNcGj2jgEQ3tsBOtNwVllRWTQ?=
 =?iso-8859-1?Q?9qGE+EOG6qK+Lsd/StI5TbmXK85T2Za46Yz2RRUcYkONTiw8S14zXgEHCS?=
 =?iso-8859-1?Q?WQfDSaUBGlOG/oqeQac48K9oDIrn87aOdPzlOmIXnKDRD4Obn6NpUj0gzy?=
 =?iso-8859-1?Q?0+7Dam1bE7slcn/UF+NxPTS9/aDyUASFD9ZVvX1q6dZ6qeb5SHx/m7NY92?=
 =?iso-8859-1?Q?DOVJNt7sLDOTd22sdGzwpdx9Q5fk+e2YlBRccqrG02Icd3gCcgjh2UmWCJ?=
 =?iso-8859-1?Q?IebXyafA9pYfoAS5jx7LXz7r0XcS3NtrkMFbQPo+gqboeL5lc0RGIpVDSb?=
 =?iso-8859-1?Q?Weh5fkVahD7DJA7Jq8P+VaeOdO/JERimXqgZ6tqJHcuF3wUSNG46flSRVl?=
 =?iso-8859-1?Q?+ssPCIVLm8V3O6He1iVjCit9bdpbgts8bp9M136M63IZJCTTaf10ZTL/YF?=
 =?iso-8859-1?Q?RuRjB65vJq+47VkjzfEf4ND3+TQr5G0Vt+O+cjLWap9mwqhco9nONVFrxY?=
 =?iso-8859-1?Q?YQQyKgnsOgY0ZJ9/B0loGTeHj+ZYATiPHDPaVgBxnq6Zk618VXXbdjOz7D?=
 =?iso-8859-1?Q?7T40u6iGpIZb0HY7bMcU1/zlmAbihPPUd7LOKRJets9U3gn4dEmrZ+1hqd?=
 =?iso-8859-1?Q?bHJrRAiIlQCBpWgQN0P/6J7ATwpMSG3kMeYuM2kWNwYlb1Rtcflwr64pa7?=
 =?iso-8859-1?Q?O/u3GoXiRTOJXRc/2CozJnfNvkwQaS3iX0d6KlVNOt8MwklPakaP+ZPje3?=
 =?iso-8859-1?Q?qQllqIcWQeq9hvipySBWVFseUtT1m/3oQ8Vqsjk5aJKO4LiyJz9hHsSPOT?=
 =?iso-8859-1?Q?ZHENw2PM8hZA73+2LmPqVh9NYRpYlJvtTL/yUciqPiD+EGm4ABqw0auViz?=
 =?iso-8859-1?Q?MqBzQDVvDRVR2nClSSjsMQm1aeyN+531OOW/dDIHabZmF5CMOIz5TrO7j7?=
 =?iso-8859-1?Q?3241DZBnnqjE8ShKDe1ibPQltE/OeN99mn4T/ayDAlINrLBt3DWvGQGOyC?=
 =?iso-8859-1?Q?ghkkqnn0oRJSvvTvlu72dPmA4PvhfdA522RVXBriuCge9iVuJiJJzYderH?=
 =?iso-8859-1?Q?oS+SN9/n8Cy12UL9o7g0AiVNzZH68OOGqobyWHyzZn5gpnvSw4KdGq8lLI?=
 =?iso-8859-1?Q?D2ussVPqi6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755ad748-17e5-4c69-a629-08d8f09a1e2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 20:59:59.2807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbmfZ+behmFnVbnvUcBXxNnBHjBJ8athKbROpu9SGMRsg8fDQRipZl035JCDE+WRnkaqaR18/GdEB0s1ohFAcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6987
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Currently when doing NVME_IOCTL_IO_CMD on the controller character device,
the command is rejected if there is more than one namespace in the
ctrl->namespaces list.

There is not really any reason for this restriction.
Instead, check the nsid value specified in the passthru command, and try
to find the matching namespace in ctrl->namespaces list.
If found, call nvme_user_cmd() on the namespace.
If not found, reject the command.

While at it, remove the warning that says that NVME_IOCTL_IO_CMD is
deprecated on the controller character device.
There is no comment saying why it is deprecated.
It might be very unsafe to send a passthru command, but if that is
the issue with this IOCTL, then we should add a warning about that
instead.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/nvme/host/core.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a50352ea3f7b..b50fdf143b90 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3264,35 +3264,31 @@ static int nvme_dev_release(struct inode *inode, st=
ruct file *file)
=20
 static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 {
+	struct nvme_passthru_cmd cmd;
 	struct nvme_ns *ns;
 	int ret;
=20
 	down_read(&ctrl->namespaces_rwsem);
 	if (list_empty(&ctrl->namespaces)) {
-		ret =3D -ENOTTY;
-		goto out_unlock;
+		up_read(&ctrl->namespaces_rwsem);
+		return -ENOTTY;
 	}
+	up_read(&ctrl->namespaces_rwsem);
=20
-	ns =3D list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
-	if (ns !=3D list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
-		dev_warn(ctrl->device,
-			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
-		ret =3D -EINVAL;
-		goto out_unlock;
-	}
+	if (copy_from_user(&cmd, argp, sizeof(cmd)))
+		return -EFAULT;
=20
-	dev_warn(ctrl->device,
-		"using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!\n");
-	kref_get(&ns->kref);
-	up_read(&ctrl->namespaces_rwsem);
+	ns =3D nvme_find_get_ns(ctrl, cmd.nsid);
+	if (!ns) {
+		dev_err(ctrl->device,
+			"%s: could not find namespace with nsid %u\n",
+			current->comm, cmd.nsid);
+		return -EINVAL;
+	}
=20
 	ret =3D nvme_user_cmd(ctrl, ns, argp);
 	nvme_put_ns(ns);
 	return ret;
-
-out_unlock:
-	up_read(&ctrl->namespaces_rwsem);
-	return ret;
 }
=20
 static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
--=20
2.30.2
