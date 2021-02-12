Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5B131A500
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 20:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhBLTHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 14:07:10 -0500
Received: from mail-eopbgr1410098.outbound.protection.outlook.com ([40.107.141.98]:30160
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231466AbhBLTHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 14:07:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djue6P9WzRWsTxsVSozL54fYZn5S3Oe7LgDxDGVS/weutOXRrDykprlX3QE6WJBsT10jeDc8DvO2NvHvskyCBugKIZ6uou/VERplQbLZK4K2CTh1CICKxPKOMwhhYtbNNrm37JUvsSeftAXpVFpM5CJymuQArjNlwrz58zUJ/MzHJRj5AoVmfT+DbV+JCR1hYkJjIDKeENSVXzSpi6XBrGXd42Y1aX8i/F3Ec6H/xXhyDSFRtqVPt3TRznGWI9gm88EfRWlFy/gVqL8GcdvRLAympwcOH4leZcZHGm/SUFUv4nSJPyly3XQ8UD57jRzQhZktQFY60Pp7k1Tm9CVMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8aIMXNhl4CBHjaYja/pH31ggOnPk1P80VKoCLCCfm0=;
 b=dKleoMP82PZEfv11ikuB3PD2XuOmMziP4HSJZHbggGkxek843F49QjQPU3u95yBum8TSVsJLbbm9VIY6guk2fJb9qD7FxDZqFfUyK5MFJMRGpg57SsA9tENe+7WoXouomshuITE/BlWYqpwU8tfFGBsIxnFi6iwDNtfOeHmhEj3sxZ/O8OXoFRKhrVZ+bDExzup/4N9MOj6GNc9cEoFfpxnE1V+KbfVRWjV6xaZDfb8HaXVjvkLz48Y7Bvb4iakrDv5blK1KX6FG1+vC7vxsQrvFQgwd5Z8MVK7Rscx9XXGYi7SAQ1tBdNb49ZeBYyy5EIHT5uYFf6c5nODrzd2XdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8aIMXNhl4CBHjaYja/pH31ggOnPk1P80VKoCLCCfm0=;
 b=lUxgQQURnpWzpWDyK9VUqyb39EMc/w4z9OUB4d/Kr4koBc8QrogeucRHHswGPopjvZ7kKxGvHAdkxu5XeTlDN4Z/MXPRiM6YzY5cw/rxCGpTxMSEnH2AkUC5Hh8USpklFoMrRrmJEYiNmipH7mzcG9d6StEYQqu0LqDuPqGHByc=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSYPR01MB5399.jpnprd01.prod.outlook.com (2603:1096:604:89::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Fri, 12 Feb
 2021 19:06:18 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::1971:336c:e4c0:8c5]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::1971:336c:e4c0:8c5%3]) with mapi id 15.20.3846.029; Fri, 12 Feb 2021
 19:06:17 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Topic: [PATCH net-next v2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Index: AQHXANy3Kc3xxVsbt0Wl/bCSqSMNqapUIuqAgACGZWCAAAPqAIAANK8g
Date:   Fri, 12 Feb 2021 19:06:17 +0000
Message-ID: <OSBPR01MB47733B3FE2242E0338DC5983BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1613092575-17311-1-git-send-email-min.li.xe@renesas.com>
 <YCYw5xXe16fSj6eI@kroah.com>
 <OSBPR01MB4773472EE0C8D34456C79121BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YCak7Eu2X0dzapPz@kroah.com>
In-Reply-To: <YCak7Eu2X0dzapPz@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45cc20ed-be4d-49ac-011a-08d8cf8946cf
x-ms-traffictypediagnostic: OSYPR01MB5399:
x-microsoft-antispam-prvs: <OSYPR01MB539919F515CC485862A2F15EBA8B9@OSYPR01MB5399.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7tZjBjsE86XzB0j150nE8+Ax+7DCoQU7BmiAU5+NBuyXjPsH3OLUx8QQUgF9+XxdqJAA8JfddGr0DUD2Oof9RX3C1siY/5EUGmDEt0dUA/KDgNeEt/hIaaRbw2Yu35/V2/y3uTafY3tdhtOAwEHP4xAMXD7zsLK+JyNH5sk2GjNpK6VYVVvYPTXZwh11p9gKVqf5sPCOu/7/mYnMBUnQyyRdTXb+3ASOC4A8qiQ+w0RlS+It9vr6EEou6QAxlXWxlBHCq8pYtXCTZ8MtIFk64ghg7JqdIsUQOmqJ13eBlbh9/YPuQWCxKlfuUM0Ap7SevMFAf4IIz3lu605h14xcuiSwjEcgtr8ei5eMe5mC0yNEcDWVmZwshz79xn7R+kYo4zmLI0REKyN9afSE9EILmkieS89XMX+w2nw6Kt7Yj48A/0D0b5JbRwhxDA0GHH7FHg1UO995ZFT+o78h/zMRObZTtIzGxMaPXjGNRV55uLtWhXCECCxD0nL5UD2TVK66TK2ekMyop/wsRGTq2fQVzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(66946007)(76116006)(66446008)(7696005)(52536014)(64756008)(33656002)(66556008)(66476007)(83380400001)(478600001)(6506007)(26005)(86362001)(71200400001)(8676002)(2906002)(316002)(54906003)(4326008)(55016002)(8936002)(9686003)(6916009)(186003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RzgUDLuet6HK7c+O5fvkXsG4qZZMA5ASL9bzQ0qoqjA3OuTntCkhlw2TjfqV?=
 =?us-ascii?Q?F4jdUizW7WCd2rw2RKFHhltWIjvuGfQUqMtr55FLAMPPTGO+yNfAXoek92e6?=
 =?us-ascii?Q?u4voSxBcWO9Z52DrJvth2CIowigbNzT/+4I23J7ZxhzGK9Q8LIUgdRt15xsd?=
 =?us-ascii?Q?CLyFcyZk9BI/W6mgFs8EUGQqTCjoBOlbdj9cpoPDvI9YmYvcVzBlyOICdv6T?=
 =?us-ascii?Q?oWA3DpHVf7blQRmJ9R9ZLelAyi755f/t6z3rJ5DlmHFByRQ1icGRGyq+ouGG?=
 =?us-ascii?Q?gV/MwJeWawpgZE+s7MONdJjyS4KcZruwHsudBQ5XOzygPlYdzWfOomSeu5Im?=
 =?us-ascii?Q?6lV90vgyvjLLLoH/FS5EZHLyfSzsRN/DHvSj/JSwysev+fBJ5QtmgXPMVK7l?=
 =?us-ascii?Q?jlv3/uYaYIDPe6un2FaSjdtxtmnqRUKqlia2tkIpM4RRXUPLd3HQs9ny1d9x?=
 =?us-ascii?Q?uscdsraSZFXHHRzkTrZbdWwUyE1r2fBYxzK2P0D3zcW/rp28XSDGdeZ+R4eA?=
 =?us-ascii?Q?zyB3it/Ni7S7ur3qpk+AdlC5IIW+aE78HyWE4Wfkru3SHF+J0TZgiWtxQjvP?=
 =?us-ascii?Q?qOupXMLDTlD9FVOXseeDez4ZV3sK6EvM/Y00y4zHx1vnMjcIMZScqLSDkwX/?=
 =?us-ascii?Q?DgpjgjmCPYIsdjq/1TrdQl9BPoT8NYsCfmG26ppacB8GQKGv5s8FUTGzVZeB?=
 =?us-ascii?Q?D5NiA6om1nyLNEazCpD+O4qbx+6KT/nE+gC5LKde2HN5UStFZTiy2GsjmbaQ?=
 =?us-ascii?Q?MWnVysKm3Hun9QsVOP7baZVDqQZJ1IJOjgWWbOg6Lwq/bgZrXdarJ+ks5sXT?=
 =?us-ascii?Q?VbrKQbUonpplDpwBlHAs+hq3xn2QOzdeS8B8DB4KSRNFfEf63G2SHvzd1Dnm?=
 =?us-ascii?Q?pksdGRnQAIBKoMvgZl9iibr9hzZ2kf/fJ9oIJAAfjynIZjIMmRysD+eWWDL/?=
 =?us-ascii?Q?/yHagm/EybzMiVCzcJwHE/K1/BVurax5hJjF68rUgUnQXg7qjO23CnsUcAB3?=
 =?us-ascii?Q?kP4pe7thdKEQFeb9mKiAOTmJCr+zCtWRleemYz23G0kOa0nyfo1pI2e9dZlL?=
 =?us-ascii?Q?Lq5BUQ757fYt/LCWsklewc0/igcmZrkzQKKkcqg4FE84hfBFKUsP9/6tOuGB?=
 =?us-ascii?Q?Gj+JhNLL2shDNydJYB8dIPzevc7D9mLYwKgTK23kdnqGgcvNMfeilmPmaLL0?=
 =?us-ascii?Q?3mnPCoNCYlFcvzyoLPwsgUc9qjxOfJ0fvhVqpvbroU6KBvYdL/UmUEMIvcDA?=
 =?us-ascii?Q?t6xONITd7xDr4hXiCYBiPswYtFovuwYFkAR8Rjs60O9Tj8C7xnGRwHOKznxr?=
 =?us-ascii?Q?yz7JEkFkVWp2YsdD8gKNbUe5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cc20ed-be4d-49ac-011a-08d8cf8946cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 19:06:17.7476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lpMzormPiCKAhbr7WEACHm/9WErGD9qkLy5ug0GG1AJ/gqfZSbl5Oc3ettG4VMz9iEBATQ08kY2nqXLZbxwcFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5399
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Fri, Feb 12, 2021 at 03:44:52PM +0000, Min Li wrote:
> > > >
> > > > -set combomode
> > > > -get dpll's state
> > > > -get dpll's ffo
> > > >
> > > > This driver must work with Renesas MFD driver to access SMU
> > > > through I2C/SPI.
> > > >
> > > > Changes since v1:
> > > > -Provide more background for purpose of the change.
> > > > -Provide compat_ioctl support
> > > > -Fix ioctl cmd definition
> > >
> > > This "changes" list goes below the --- line.
> > >
> >
> > Sorry, is this a problem that you are requesting me to address? I am bi=
t
> confused...
>=20
> Yes, please place that list of changes below the --- line in your patch.
> The documentation says to do this, right?
>=20
Hi Greg

Do you mean this "---" like below? How can I do that? Sorry I was never ask=
ed to do that from other reviewer.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/misc/Kconfig      |  13 ++
 drivers/misc/Makefile     |   3 +
 drivers/misc/rsmu_cdev.c  | 449 ++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/misc/rsmu_cdev.h  |  75 ++++++++
 drivers/misc/rsmu_cm.c    | 214 ++++++++++++++++++++++
 drivers/misc/rsmu_sabre.c | 153 ++++++++++++++++
 include/uapi/linux/rsmu.h |  61 +++++++
 7 files changed, 968 insertions(+)
 create mode 100644 drivers/misc/rsmu_cdev.c
 create mode 100644 drivers/misc/rsmu_cdev.h
 create mode 100644 drivers/misc/rsmu_cm.c
 create mode 100644 drivers/misc/rsmu_sabre.c
 create mode 100644 include/uapi/linux/rsmu.h
