Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EE335B052
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 22:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhDJUQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 16:16:03 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38160 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbhDJUQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 16:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618085746; x=1649621746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JdZ6yqoT+yY03EZdwTwg1+8ugf51kLlK5tL9m+KS1Vo=;
  b=HaBUJbvhPZ82tMAXkUj/9K4JX0jstHlXfGUV96pSnOCaH7FvFBeFpuUw
   /nd/sutwxtyhmM9DS6GK+ZicMhOgllKPVW7xl3qvL3Rotb0apYXhsUfvU
   RRQLe11ppekoLpfpX6PF2kdHWaY++MFNYPDJFU6oevZAenpocqZgZyDd+
   NcfAoeJGBUo8vIlRYYvy3oUx/NZwPtxDfR65JiI4Llagfzf4TM/81zIVr
   y0/t1SjiF3YPV1KLXsUydg9OZiEmtiiZQg3uz9RrpVF9tl9zM3Ug7Gp9V
   2Y2HGS0cCzpokV7zI/L3x8zjLA6aYvWjdvjuIEvvHDUEe1CAssNJYD6dd
   Q==;
IronPort-SDR: LMPm/7vtDzhX5RAaeSw6yi2tp59UZ+sziHiLh5AGYgHJKgjtIsTvhGWXo7+WvLVwUvbvy0eMKP
 mkuN4kD69tX+cQMsf4UdXYbyWpIrmrboyBmWy8xhQJa9SGYfzOxWGivZ8G5qrMmy5qq7G890hG
 kEFvFGsHUWNpofYg1K8UNmArEAci7jXH1rEhK3Y0nDBCeZSAPWaia80r3n7p+dxCpZPxJcNp19
 iF873s9jvX5cKyCuNjTQE7WeCiQ37s8a/1R12AS1jLu1p4BYh6Jl8hTRAIEoNci2EI92jKgtPp
 pww=
X-IronPort-AV: E=Sophos;i="5.82,212,1613404800"; 
   d="scan'208";a="164388708"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2021 04:15:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHP8w1tWCUwRrA3NEcbZkee82QpWKnqRhJdjQ5i253FbvjRsiIbkcgKkxZSncLNZKwArNwy92h4JPfulUwMsZ1A102u49u4UGYcBlkNM7BnIQoiDVX3lNb736X/zijAZcjxVzjh68pyam3odyFyJ6E1U7LgpbGbfPnT2Hr8AL+gfWP72trXm+Ejs2aFcCrqCHRGlWhyR0jRNM7sFnP/X2wnx2eifbTYP6dg2dkpwt/oW7YBtfv5+wdNcOefsLymQzCwUT8eGUEyRUOSCwPvUOzsh3FGtTYbfck9h7NNtyhqu/9UtmqWR4HbyuLh1V0VOlkUIvct5P3XmNlicEiSMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPndd08/TYYTKce+vNu3BcIEMj7Pvm+Gq5uHNF/laQk=;
 b=S11R7zkskcq25N4bNpSfCk/SAHEygUC68MOhrcwfP+j4WfHQCuQvFn1Z7SSfrOJhQzl3UOMrFSoSnVdVME6nxZQULvCJ5MQxcsvezpjVK6MSi1r8eO0G9zGO2AX7lYi9kKDseuRxIy7NjUHuWjaBlYJhxm3XRq2+CdOwKi8sDAMVOKYnUtjEGd+wMQFl49Wy93/YnI+lYlGPZ+l7f88Jj8sLjOBMAZiqrH4GRYXePE9UfErbtEO6QizGSOqz1Xhy0tchKZGMciiaZ0FWOhEtnxMbD1ZWndGhnHEW2WC95v/3gpS2IzVzJ7vueK1zlWgN8UfKfdhFjAVl9V4tmvv/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPndd08/TYYTKce+vNu3BcIEMj7Pvm+Gq5uHNF/laQk=;
 b=Q/LwA66cQY9eN53yBkFxZFt0kF0AsaZcdKi026gOoyq8KQ1y9OxkH9FgFTVakY8JHB3VH3A34rUSaqBgpiw21bRdGGuaemkzDi1f8DfymWeECFlNQH0YlNwBrWG2H+34+1oI5wsUW88W9AWPMNyrHfT1/ZJDnYMHi6y25ectmLk=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM6PR04MB6379.namprd04.prod.outlook.com (2603:10b6:5:1ea::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16; Sat, 10 Apr 2021 20:15:43 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf%11]) with mapi id 15.20.4020.021; Sat, 10 Apr 2021
 20:15:43 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] nvme-pci: remove single trailing whitespace
Thread-Topic: [PATCH 1/3] nvme-pci: remove single trailing whitespace
Thread-Index: AQHXLkZIw1PYvCEwVE65aGcDiNBgdA==
Date:   Sat, 10 Apr 2021 20:15:43 +0000
Message-ID: <20210410201445.53061-2-niklas.cassel@wdc.com>
References: <20210410201445.53061-1-niklas.cassel@wdc.com>
In-Reply-To: <20210410201445.53061-1-niklas.cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a193224e-3328-461c-5701-08d8fc5d6b84
x-ms-traffictypediagnostic: DM6PR04MB6379:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6379293A892781B8654E9167F2729@DM6PR04MB6379.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K/DIdl2tWIDXPoEVzKfMYBwiFrzTpvCuenP/lTsP787jfyK5Czu4OUeUxx9ChDBFYeWG+MBteHZWzqurqc3E9drH2v4aemvfyIVngkBqMd55dp6hp2iDp5GLTd+EW7tj3E0SSVVmYTgzKWqx+aHrtHzpjG0b8N0yrZ/bmPfZxcxJ+LUT9WtKyXIwL6V1prulP8gcaqjp6qmgBJQV5CeNSv1kvSSnUvXiBFxnHwpVi8YzBQJ+s9ezQgqkwp/NqNeABQ7AujcB0J3Ia59ltuwAud+AAGCefXtZVDGmvLntK4zGRyKQTzovWF1tBoEACW+I86Do5pkPlu5Wwm8u6vFOXZYa82yMU90ewBLYa1sVdkjE9oRzHD3KubmKJiVFW61jMA3PACOr2ZSMcjXB181bzboPtCeC+Nqm0Qx6ivP9LBjEMuuxtmzZvUcqSACvN3TtufhvFnziZaEnCNa45dCxsx0ISPMlYsA/MqEQB+m4qDqjggOjyBs3ZMYIvnMzrkhlSRPXJYbKr1G0Cejs28/eQA3Ir4/BPy1HvSPxGHEYRRxR4cbcrk0YC7C/d0MQ3ig5+FrFD0YNhYFYSzHdK9UX1Zt5eDqIrUD14z1v6u83GHE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR04MB0684.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(66476007)(8936002)(64756008)(4744005)(66556008)(66446008)(66946007)(1076003)(76116006)(91956017)(71200400001)(5660300002)(2906002)(86362001)(36756003)(38100700002)(316002)(4326008)(8676002)(6512007)(26005)(186003)(2616005)(83380400001)(6486002)(110136005)(54906003)(6506007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?kRAkcKo3jO90AgjwatzGLPrB5t7ATWPHOv9PS3PlNbIsrXrXLWhN5a6t3g?=
 =?iso-8859-1?Q?zDBkFkhOA8JKV87WfejuUyZHYHSGfKelA6uJ8qtSBAyzyNeZsxdZAUyQTZ?=
 =?iso-8859-1?Q?vTCwqQKer5lnvcASIb8et+gnGPn5rcwpknY0yw9ldPxKILV906FgJDX5qk?=
 =?iso-8859-1?Q?mMJkOr7UcxhG6w/u3IrPw2xfjafLx5zFwZQP+ksFRlRjqRaQAMLOhATzqD?=
 =?iso-8859-1?Q?b8D15Qjc2Un/3ReUAlU/OzKERe0q3aww1a6d82e0682Ak3SDN+9La2lmFJ?=
 =?iso-8859-1?Q?Ga+mkRLdQDl7rJfqUBMug6Oo5L9+SWKjMP2KNzK2gS/npcCC7OXpYxuiiB?=
 =?iso-8859-1?Q?Vz2LzBPmFxqZcsGeJtIHe790by0dCtEYAPUZ8KKNeEzLZHrH5nOWjkXIJz?=
 =?iso-8859-1?Q?KGmfGwenAUq7Ebhli1dJ2U1HxxMYgw1bl4+3h9EIPHDnWpoDi85pNj/xaI?=
 =?iso-8859-1?Q?CIH6y40IhQ6uy7jVqW7DieXPihJCrIuQwAclxBtaHrGAa6bACZc3a23IAp?=
 =?iso-8859-1?Q?bIHCuedoJcL0euYxuh78ieMtCpKEobuZDQNfPXfBmvueS0lvPF2t2cwjKz?=
 =?iso-8859-1?Q?cIcCs7BYFwJWV8dzXL96efv9sFZpsxzDtbLKcz9/xg8bg1MoO0Vmq/Y9gk?=
 =?iso-8859-1?Q?8ni1w0isxgXe/uCtZ9BDdJyvZcGkwTq5hxqJQaPMtbKSv74WFZhrHnGefC?=
 =?iso-8859-1?Q?Ub5PsB5Os9vYWq3xWuw99Yxqe9kXQ9EotAIzcnTeql2b4adfqkxY+pZ5Q8?=
 =?iso-8859-1?Q?Hz+YecnNc2q1fQVgx788IBcM4lEvO/I5tv8jH5/Rh1bmDthtMAD/dldo3h?=
 =?iso-8859-1?Q?cRDnfWfB2QP7gzdlCvy6lgq4L13VuSkkUdalq51rCZu4pNJvHq3Ss3RWxj?=
 =?iso-8859-1?Q?lPR+Fiyep5ZrGHQeP7L8t+9ZKhxOQVm+qRMof2/IqAp1CK/vxNFBiHSMHr?=
 =?iso-8859-1?Q?lFYaluFTb3I5/JJM91OGK1LA2gJJW5Tk33S2YqbB5sSwS34QA5k28Ik6uj?=
 =?iso-8859-1?Q?avFc3QhAgT73XHuJFi69gBzWH9f2n5vJBBY5jjihpsH7sOv1uL6P2ZofTm?=
 =?iso-8859-1?Q?JqMqWGGBibw6f4Gwnqcv+AmacI0gLJ6hY7bGvy5nccbkschahs1DxxdqBf?=
 =?iso-8859-1?Q?+NU3+dvPJ8Pszut/Wvp0yEN3IDAB+osiEJF7O9gwHShmS+H7CvGupdmmcy?=
 =?iso-8859-1?Q?npnK9ndvx2KSHlI3M35/4VWyBnI6RW+WfQ2uumtju/uMYTNqSyklXNlObs?=
 =?iso-8859-1?Q?bowX6ssVMr0JvUWlTp8JT0xRNVC9JllGS65eVPcmCh8UTSKXq9WOljKfXS?=
 =?iso-8859-1?Q?R4G4cwD1agzDmUeH32LIdpVQzh9KiFdA7VTDORVRf06GAOL/Mcr09klCsV?=
 =?iso-8859-1?Q?Zc2lSrpRxX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a193224e-3328-461c-5701-08d8fc5d6b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2021 20:15:43.7728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NRe6bsumMWSZwDaAaG2xuPTw+UR0VuSBon7qD7uKG2zS6gNO7fBTTEtTE9zwqVV3Y05X0jxIHcPW1duGtLCOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6379
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a single trailing whitespace in pci.c.
Since this is just a single whitespace, the chances of this affecting
backports to stable should be quite low, so let's just remove it.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b06e685d1250..09d4c5f99fc3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2172,7 +2172,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
=20
 	if (nr_io_queues =3D=3D 0)
 		return 0;
-=09
+
 	clear_bit(NVMEQ_ENABLED, &adminq->flags);
=20
 	if (dev->cmb_use_sqes) {
--=20
2.30.2
