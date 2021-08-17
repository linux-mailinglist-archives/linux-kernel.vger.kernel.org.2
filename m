Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCA03EF003
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhHQQOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:14:24 -0400
Received: from mail-sn1anam02on2072.outbound.protection.outlook.com ([40.107.96.72]:16647
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229696AbhHQQOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0dxgUpOdcA9RvCi/wvSIfqsOdC1gy7R2LqfVqKzzYPVClUuQDEiBMOXhQTV6owlMGkGQM35hGOiQIs2OI3Y4lrobS5wuo/VXirOZkWV7omqHghYZ8YB+WQxbASENja8Nt8vKlnKWVwv/Rfh7j82txYStigI/tsnryG7nnG+oXsKkej16KxOZ93M2hl5XMkTHjJ0mvmCJr19j3LOKtWQbDIKGoHieAFIwDAtkBja04LI+AqO8S/zBfOiC7iWUmTvTcsmgCQ0O2K3I3MMD5CD/aysggx7+VahmoTvL15xArTH83qhITNyckzRaLnuwYWaLCTmGizjg13qoKGXu24w7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAjSDxNSshzsDs3fWPckTK6re+UclwHTWt9TFD6arW8=;
 b=AYfZB8d1aX18WlMYiERALDJS6QqT6vNoTyIzv0oE4JYqHDxszXMSDuEc380G3QDqLdGtV2ANQtL26UiXxNOBXVpB0F6fGoz7aStAByPrr/jUMSJNxXs8GV8No9Q7NSU3lFf4MVOU5dTk8sjjEeo0SYp25O8RAdiqt4sh5X74jyxYOXht7V0JYFRB27iRrygvvhc+pyuMOO/JvGwXQvro2McIprkaiMtteKFoVoqhvaY5pOGnK0wafeUNAtamSLCDnNPw8Uyor7WdyLU+u1zs1jAAOz9FL18LVXQ5t/IRrrRfY4Y/ncGLrWyePfbVA6TqJnSodFWWjWzGWx+843J4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAjSDxNSshzsDs3fWPckTK6re+UclwHTWt9TFD6arW8=;
 b=La41BJKLHjG+Xfz4KQi2N4ZXFFP1RCFI1pvg3lPhU6ulycsZWL7zaVjhy+2UypmRjyxwCA+RpCAQcALib791xNBcqo8tN8wskvk9BcR+X6UqrkFNHt+qUmKkBvVVoXSfL8eH6W+5dzoKIHzP7DzG02OGot09x4fwTiA8u6LsEXE=
Received: from BY5PR02MB6817.namprd02.prod.outlook.com (2603:10b6:a03:20e::22)
 by BYAPR02MB5336.namprd02.prod.outlook.com (2603:10b6:a03:67::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 16:13:48 +0000
Received: from BY5PR02MB6817.namprd02.prod.outlook.com
 ([fe80::b887:6f3c:f290:d654]) by BY5PR02MB6817.namprd02.prod.outlook.com
 ([fe80::b887:6f3c:f290:d654%9]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 16:13:48 +0000
From:   Daniel Steger <dsteger@xilinx.com>
To:     Daniel Steger <dsteger@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fs: sysfs: do not remove files if group is null
Thread-Topic: [PATCH] fs: sysfs: do not remove files if group is null
Thread-Index: AQHXjV8UC7gCN7I2e0G9u5frN+xGX6t36pQA
Date:   Tue, 17 Aug 2021 16:13:48 +0000
Message-ID: <BY5PR02MB68170E18D6B5C79BB0AC9083C1FE9@BY5PR02MB6817.namprd02.prod.outlook.com>
References: <20210809204228.2987376-1-daniel.steger@xilinx.com>
In-Reply-To: <20210809204228.2987376-1-daniel.steger@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50a20c59-40a8-4894-b780-08d96199ff28
x-ms-traffictypediagnostic: BYAPR02MB5336:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB533656EF64ACF2CCA1C55416C1FE9@BYAPR02MB5336.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y0pZYpvUr7x8opU0rYBh43IOc3ahY0mcttTzIPdKrX2i8jzv4+x5zluc4SRgdGvvpdzBj/QIsSBEh9gxJ362/3LmJxlxDqSXj5VZ/CTWNCbWr74rlSnG+Uq10u3XxUwSwwvb38ehdd5F30Mq5NGJdPf+yM0IMmANkW5P3J+jiXqv5r4/Zsbk+nSwYNyXUd+iVbQRNRxElk9Cj4F5+VimBRP5JQaSraqOL8X5uf8eVsagXJg3Vz2AQ8LjGW+92y1qQhlKk7hBDKfeur+/wkkxDz1KvN6wULNMOXth7yA/6gRjEv3fVQD9YTuKyPdudWz8v53SBJXETuZVK5caTIkN23Ko0H67fLv32aXv6netkVqDVFxA/hJ8MooqG+OkVk5h09BBh5MUTfM9281Gsd4e/OtOzl8Qii8iyhWPvGtOC3kz0ILoveQX67gypuqk9bkYC9I63/F3F+CmTKnBHArq3bQ5QLitO4eXtrDmSVtuHWOJtZxdAgyV5AeSHFJsAWf6Iv0tZ77vUzz6VUJkacUytExkII4leyqrfiTPI8lXKnmb6hMjDrpAqqnkqq4cKYv0vlrMH/Th/ZX661z4KGwNazT44pa1EzdJCPORh/EWsua3/wKfHjlQ0DDJJg2wkNHRbgaSLXhAFmNJDvu71fDPRbZ4WJXGhL8m/gi3/6dX5do6/Tr317XV6HcPJQyQaNqnyzroIlkhFO2+djrgGKHjng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6817.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(8676002)(2906002)(8936002)(478600001)(7696005)(4326008)(316002)(110136005)(38070700005)(5660300002)(52536014)(6506007)(53546011)(55016002)(64756008)(66556008)(66946007)(76116006)(66476007)(66446008)(71200400001)(9686003)(38100700002)(83380400001)(122000001)(33656002)(186003)(26005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qM2yYFmuRf47JqkGKgq7/Q0XhpAaaAxQRBq1uAKnuJ3uH6d2oMSUStaNWTIS?=
 =?us-ascii?Q?ddQuISuzCnpUtFB65wNEwiMY4C6whxSs+QKCmYf0tNRajopadYVbteJneHCE?=
 =?us-ascii?Q?wbLCkjznLgkiIF8M47cWmhcxK9sQWX7+KkFC5QJUr83eaGQB9PtBzhWd4kj/?=
 =?us-ascii?Q?mc9bHjQRzSCia5NQThpEyKYIzCFXKHD5XfPJt6TPCsLgyPhkjaPJSn1JUOFy?=
 =?us-ascii?Q?hIAlFV0kxVeSkW10XKb9yZiOO5jzYrqSr2ybZVJaIkN2S+YPRDuN5q6agWtD?=
 =?us-ascii?Q?Sq7ozKH+gopERiRrWAWIZ197wGrbDVkBk82IsXTBTQSvgmIJsChrlpZtOa2J?=
 =?us-ascii?Q?rISVDYDPxvZ7e7sEzPNBWNDRoUJ20SOoAEo7AS0HvA1ei/PfC9gEg97engif?=
 =?us-ascii?Q?tVeUxuM1Q5tlWD7y6M58PzfnuyfvSHgYHZv25DCkDK61dL4efIRMsy9irqrw?=
 =?us-ascii?Q?penVgoG7hbW2pcVSTm1QeyaTYWsUvc9DVAoItl+X+kYEU/l3gqayEwWVNVi8?=
 =?us-ascii?Q?903NJ1T07SfwblNYzBSwyCgLD6ryorxhsJm/JVpQDBKYjmsiTY6kDsRxm2rB?=
 =?us-ascii?Q?DFzkdHws4XfaIUVPl+Tkr/l/FCRV565zdQQakJsMYWJJxHV9lnlaF3IPoLRg?=
 =?us-ascii?Q?0B58HCWsgotPBuKGVlU4a3VuDLaiAiekQOfpj+6TxKwPqYPW3OAskRr4mwQ9?=
 =?us-ascii?Q?1TJYoEd0xSLWgEuLUUlmNcMpoNybxz4s4CqrIlPgdfpMOCg+QW4xuQkD6/H8?=
 =?us-ascii?Q?fzVGx/BfeE/HxB60Vfj/MXlHAPVfO+RuvWN63rnumVUXksMuBl5E3D8HX3U4?=
 =?us-ascii?Q?kOGsO4JZ8OHnLIsZga9FUYWsO4Np+DB39qfMV+DNukzC64Hd55fNQaB5MFXB?=
 =?us-ascii?Q?sWC2IFGr/jdOQGbAQtldB43Buej1Ozkcpk6C8J51/PqIwz+fXOBZwJbIEVcE?=
 =?us-ascii?Q?u10WJCFDSE7qM5RDUNJiGjB4gu58YKbvO6Cqt4rQzqhkLCitp52dbfWKL680?=
 =?us-ascii?Q?RFak7vYyGSFJ+cQRl/gXrF6yIQ+7lVuC/Gr2cMdiDRbiYL1qFHlsX9z7xcWB?=
 =?us-ascii?Q?vkqMmI3jA92UYsGUP8ZM1I/1NWLy5bm0hJEzyo6Nb7HrBebhkGW5b1lJBCRp?=
 =?us-ascii?Q?sMvuIjXj7eMsjsjsJLQpeSidX3Q3329F2QFGsAhgKHE/zth55GBjrIVd+ExF?=
 =?us-ascii?Q?YNc8dbp7khVkj+cIU+F0QazutQggDVsZKrxDMNFB7+PPnsXhjtnOw8v+uv5I?=
 =?us-ascii?Q?aOa6DGVCiZKq7/C2nGpUDhZ0aT7RxUw7ZPVIeL2hYFgyDJNLTwlHz38CzuNl?=
 =?us-ascii?Q?vbh5nwT8PNC5YsL6X6fbKW0V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a20c59-40a8-4894-b780-08d96199ff28
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 16:13:48.7399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntaVzoqu+GgcGzHzrESPqW4j8T16wKfPn+x5iBGVs1NeZjOTp2n3APEucDnUvexAMGtxU5Q2L1FiCfAHWie2Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5336
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Rafael,=20

Have you had a chance to review this patch?

Thank You,
Daniel

-----Original Message-----
From: Daniel Steger <daniel.steger@xilinx.com>=20
Sent: Monday, August 9, 2021 1:42 PM
To: gregkh@linuxfoundation.org; rafael@kernel.org
Cc: linux-kernel@vger.kernel.org; Daniel Steger <dsteger@xilinx.com>
Subject: [PATCH] fs: sysfs: do not remove files if group is null

The current implementation allows the remove_files() API to be called witho=
ut checking if the grp->name is null. Ensure that the group name is valid p=
rior to removing files.

This patch fixes a race condition where device_del() will cleanup sysfs ent=
ries prior to device managed sysfs entries. This results in a NULL group->n=
ame and a system error during device cleanup.

To reproduce the issue, simply create a new child device in a platform driv=
er of your choice. Add a sysfs file group using devm API. On driver exist e=
nsure to unregister your child device.
Do not call devm_device_remove_group() and leave it up to the implementatio=
n to automatically clean up the files. Here is where you will see a kernel =
error complaining that the files have already been removed.

Signed-off-by: Daniel Steger <daniel.steger@xilinx.com>
---
 fs/sysfs/group.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c index 64e6a6698935..023b40=
840f36 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -286,9 +286,10 @@ void sysfs_remove_group(struct kobject *kobj,
 		kernfs_get(kn);
 	}
=20
-	remove_files(kn, grp);
-	if (grp->name)
+	if (grp->name) {
+		remove_files(kn, grp);
 		kernfs_remove(kn);
+	}
=20
 	kernfs_put(kn);
 }
--
2.25.1

