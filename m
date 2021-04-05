Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98E3353AEF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 03:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhDEBw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 21:52:57 -0400
Received: from mail-eopbgr1410110.outbound.protection.outlook.com ([40.107.141.110]:43840
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230052AbhDEBwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 21:52:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JF/fSpShOJu6VUSUGObbfelRjHNDdCfjOSjC8kfAU+ZtNWtS4Uh262fMuzY9N3m9ugWhEm4Bs50gjl6EWRNVbw53Wu8MIylfduuZ7oZt4xBHJmFgSB5DzKCEfYZkvBIqUI5MAe0IAWourU7775ejsmafnLzSKUIDRERSVDo8tGWnckZ+G65Kg3x2pwi+d3t97iRnWnwJ4pzacgZVrGqrom8OpZHZKUEGZt51nQi5A77yNZVKED0CTu8WTOtSCv4P+D/x2jRaFCKxcpz1wxETFxDB+DLe7EZ2nBqdQQtJ2bRWWVnS1Dgx1kF9j4SKavbpJ/mDuZ6i47hNwnu0+LTNgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/aB4yvysIv1KM5G6wyJKcZbY0tG8mzJHoL5QyItP8M=;
 b=YBZ4RJEMx0VKKMIJUTiSxyDwlnv0MCxOlkrhdIpazP6+GMJ5zb/vGeXsLeGUJ0qzysyn5LCYnXjEAX88pbOXeCwjIx9lSu+EI3Dg2qjccyKkVEVal3xL6sMxdZ5/aQQOR9REpO5aauLwRSgXFjT69sHo6GAb+wqJsEj68SvZaSVn5W/YFpss3FKoAudqd/VklxG1l0IOvYEtL1895zAf92vZxfr5BIg6B0TwMBg9o7dzj0vNv7cfL0QhJFoK5fxDpRDiJQn8Bwx/Z8BpI6BCg2239/R8JP0FIvpGxO5I0npA+GT8/J6arfZPP8onP8jTIDmZ+SteGaHFb3v/KvE95w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/aB4yvysIv1KM5G6wyJKcZbY0tG8mzJHoL5QyItP8M=;
 b=CE37ux9Pj6lO9Go/yn9eARymfkFZ8EVfesMuLwSFLT7lNFCMFgeHbyVI2x8s6KmieXKZr1PdDvuo6OzuOHdjm1Mwnf0v5IedFFbjGNneHq9JnkghSuLd+dACkuT9XMyFzcZWr7QTOtSKkkFLKtW0airL7xIsxBHPQbuyOLGUCeY=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSAPR01MB3315.jpnprd01.prod.outlook.com (2603:1096:604:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Mon, 5 Apr
 2021 01:52:40 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 01:52:40 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH next 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Topic: [PATCH next 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Index: AQHXKNYoPNBeg4xORkG1GcxDTKZKeKqkI0+AgAEGM5A=
Date:   Mon, 5 Apr 2021 01:52:39 +0000
Message-ID: <OSBPR01MB477323303D45865B0B2AD96CBA779@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1617487714-8312-1-git-send-email-min.li.xe@renesas.com>
 <1617487714-8312-2-git-send-email-min.li.xe@renesas.com>
 <YGmQKyweNi3lWoGM@kroah.com>
In-Reply-To: <YGmQKyweNi3lWoGM@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db9a29ee-1ab6-4188-bd0d-08d8f7d57efe
x-ms-traffictypediagnostic: OSAPR01MB3315:
x-microsoft-antispam-prvs: <OSAPR01MB3315C3B9EEC462B2A9FF0E47BA779@OSAPR01MB3315.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oaEpZDNpNNM9ZKwV2ES5oGUYfgQafVq33ruzOeY3B9uTzOdgwgrqg4pEA9coT41sFsJ73vKS+CvazeMjccOCHMr+fgLbS8qYmNHqVHluUMkKhSguL7E8Pzn7yve4d1Gdj/CCxGc7BA4EzvVe/vB3po7qYN3EmefpBjaKKYyTcg3ha+iTIGRvLrNMwB4ZzZd1KTLsQqhLs6DKwGyuflWdI6WtWwgwDQQDHRvrOmeByx7ay5smYimtaANJD8TyX5o4+4IZ4yWUJkrruy8l5FujNn/LZfhlLfmKzn9VSfA297e+Krl9o8KRrpt+7xAJocmPQF3mkCaM2CiR/XdtZPre62PQUeG0mv146KmdckUQbY6+IH28TsgiW8hh5fGMspwYfIDVw9MDiri1Dq5VDl91FC8+889JkbqXrkgf2mAICnVenMdNkC06XJVxWkfRvlivKW5LalrgahdcBc+SsjHViUHkMsF6UAQk1cqFpCvW7vbIaZGm+XGNIWWAaOze9C2iZrm3ecnmlusKWra1xt5THshDGgRPdnrJiT9d4nd52xxTQmAJtYjAibmIaSEsbsN2JC+seQFSKHHRVmqLaV/WFhA9/icXbp0wRAwj0S6g1HHk4es5k9tMRDQyFhAe3QqbrYDuZRJVyuiPWXeYZ11Qt0hvphJx76+odytJ3OPvvSo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(4744005)(186003)(6506007)(26005)(38100700001)(6916009)(7696005)(4326008)(76116006)(64756008)(52536014)(8936002)(9686003)(478600001)(66476007)(66446008)(55016002)(66556008)(66946007)(8676002)(33656002)(86362001)(2906002)(71200400001)(5660300002)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SZJSWfrGBUD5YXJnnVwFurlbk/+iC8AWeAPXzHg0Okph9OW5HNwj1rbWxoZP?=
 =?us-ascii?Q?3YCfgVgDDrKXVWEk2rvH4wtioslAVSqp3+rjAEI9Ieg9DHYFHZebN0AruJtX?=
 =?us-ascii?Q?89J8FH0/hpQneb+xNgq1QFfYPRn78RLKLYk0Ep6ZWuY9S6s1tEwGeLMO7nwx?=
 =?us-ascii?Q?Yg+9d0Xitl1kRGzToWo8VAzhahCssg4M1CuHGZiOpCGxQ7Qy9VQPH7p3EqLg?=
 =?us-ascii?Q?LV4sOd62Clf3mkaaNSOA8tqWEjPydONgGxrHpcZtSOTTNrOBKVCODA3t5H2f?=
 =?us-ascii?Q?ZJDREQdTYrBKb7Jqgb2HgA+nDcQ/oQk2e67+USVfOljggC5qYQ07MRUvpUnq?=
 =?us-ascii?Q?hXJo0NmpBbdgANnm8mHfLyFOxT+o/h5GoH9ad3HTy1gMKOz6FueagDWgXB4d?=
 =?us-ascii?Q?AZiDnjCjAkkcCssrCh7aw/9yywD0A/nqr9tkRa5o4lDX0ObClAZ+3uBjom3z?=
 =?us-ascii?Q?rdxelhtKbnXtqs9P3t/bI3zeQgG0M1Vvdsxryuf3P94jNmpHidwxKIw8qUr5?=
 =?us-ascii?Q?Ts8RhJYpQsSkVK/4Cx4QipPkJleGP3y8AQ+4cz00X8ZQmZnVXOMSE9lIenjo?=
 =?us-ascii?Q?4GypRCLrnR6emnwRVastYjhExnglVVt3eclg9fRtR5DozwPJFTCUqFs++yfl?=
 =?us-ascii?Q?fPHTM1nUWKIwtgjL6/DaPewpUnEkNZ8brKwt0z0ASMuf78jZcgdIUXTWTcAg?=
 =?us-ascii?Q?3z1i7hpuT/JM+QOcb51ndWuDgdxAuczKcFaoRrE9TLJMZtOhKWzTyIpd+seC?=
 =?us-ascii?Q?48pqgu+cStVExufO0b7KWl6rDwArnlDsBFvrNrV6FZhGyo0FXC9TDHJo1iXK?=
 =?us-ascii?Q?m5knVUqGuQu17y+ozO7+TbFSYgknY27RzEQK9uKnBvdmHK1UzeZEbqlmKspY?=
 =?us-ascii?Q?AAk+T0f5LJU03w9nGT8yqqOEN7IHX4bMtU68fGrVEiNRJUg7rqhlOxnDNvPl?=
 =?us-ascii?Q?4CGJROuupiObwKZR1QOpPotd9bB+sWn+5NxWxWT6W7W42y1Ba5qFvzhAlaeo?=
 =?us-ascii?Q?UuocRIe45M8foG82lyFu41qSUb9Caqi4VaaOF8K4gNjsSMfvhLkefCnSjcGJ?=
 =?us-ascii?Q?p4sZrZFf50dpJ6FUfCA+wOXU2UCn1mytyCrLTjjGAg/4VwP661C4gEpjYWCi?=
 =?us-ascii?Q?eXChMHMJaHplhoL0RO8H7pEt37ydE33fY/ny8AeIqsBO0b4VpdN1rTbhZ6f5?=
 =?us-ascii?Q?3fj/nt8FYK5RdoWg/p58C0OxCuTLk2vZ5dvFm5sHtT+FjljMy20bG+PxmbqN?=
 =?us-ascii?Q?671ltaXJR948MXvZ+AhZ/M5IWcDINg0hq5HYf/AwQK5brrST93Z9J/9+RRgU?=
 =?us-ascii?Q?ssh3qKdbM23JNEJ6gHi9Lwhp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9a29ee-1ab6-4188-bd0d-08d8f7d57efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2021 01:52:40.1005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jOrQdslxwjKLVj7eGNP8V7vSbTdL/80QCimunWQGkoJEniXGJDTltgpK2hUKmk2WWIn7k8ksb6pMIj4CEY7Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3315
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Any specific reason you are not using the misc_device api?  That would cl=
ean
> up this driver a lot, there's no need to create a whole class just for a =
single
> driver.
>=20

Hi Greg

No specific reason. I just didn't know the existence of misc_register API.=
=20
Do you recommend using this API to create the device? If yes,=20
can you tell me how to obtain a appropriate MINOR number from miscdevice.h?

Thanks

Min
