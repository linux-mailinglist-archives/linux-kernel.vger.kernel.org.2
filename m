Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C973C228D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 13:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhGILII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 07:08:08 -0400
Received: from mail-dm6nam12on2114.outbound.protection.outlook.com ([40.107.243.114]:39392
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229641AbhGILIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 07:08:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKFk2BRI20XHJpuYzKO3Qippl8gD2OPcOS9xBgDojcl4z6mAZJUdGz9Y0CDOXnnUnh/Tz3Pv2Y8BMPRhrTM0KVZaZldJmejuRnY+rEFRIPhxBji2oK1zyBRXErEjKqu59avHu0cvnFL/rhmAwUeRLl6kCz82Oup6w8rF+U2I8Giika0wTQDyMLPpziKVR4Gz6r28ReQU8HKsQBR0Co09zPAH3HAaY33/0mEUQXqM+OvA1POFrM044wOxCHF50g/6EMlZLfQZ5GsIkD+MfM76e2ozuWtFauFrFrTC96fWmCD5MxL4Tp8aSSNPOnRVc1ci537uMSwm/ByKYfGQyy0xAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFrpE1kmaI3B6AEfuOj50rLcuFt34fY8USoOz0LD9Po=;
 b=HyKA1ONngyHzAksE7lW7Z5Ik5/vWVkrYG9lP7e31v4xWJoXvto62NH6bqAX6l3fQ6qFg+LkfeHcC4pJkHXbSf5dE8oUnQxpR23O/Bvo3o++WAgBhJCv935q1ckH6hEkdLPNGWRt3+lmWDwcrk/r6o/gISQ4gqT7PA9Oq3pMAOG4qEPVHKzOjuj3Et2HtsHtLlkBOgAC3Gwst70/tlIl1XD7hG667DJCHSVU84pjZF+eb6foBKAIgJA1HD7nN8savWDo8ZIY4YIedv21rOw7+xYeDohipx42cZnMAwWM/YKCXpvGFoaEMCwzHYvHMjI1BVbM7fE8pPDvcsvMaPZvysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chelsious.onmicrosoft.com; s=selector2-chelsious-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFrpE1kmaI3B6AEfuOj50rLcuFt34fY8USoOz0LD9Po=;
 b=1xbVbev/qVh30+4J/wDtIGri2hMV8qvqpIrhuD3PIjRQQaDNCPam6WUfMsvx64igcu4kas568TrKYEyecb6KltyroE7a9lRCk6Fz/TTvS3DlLIaVZlOkHhybRTJxZUseOAIWfTtqy1ygx0DdzrqWMHxpVTkvIhtNkdt1e5qJp1U=
Received: from BN9PR12MB5321.namprd12.prod.outlook.com (2603:10b6:408:102::20)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Fri, 9 Jul
 2021 11:05:22 +0000
Received: from BN9PR12MB5321.namprd12.prod.outlook.com
 ([fe80::5c18:2c80:2e44:1fb7]) by BN9PR12MB5321.namprd12.prod.outlook.com
 ([fe80::5c18:2c80:2e44:1fb7%5]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 11:05:22 +0000
From:   "Raju  Rangoju" <rajur@chelsio.com>
To:     Josh Boyer <jwboyer@kernel.org>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ramaraju Yelavarthy <ramaraju@chelsio.com>,
        "Raju Rangoju" <rajur@chelsio.com>
Subject: pull request: linux-firmware: update cxgb4 firmware to 1.26.0.0
Thread-Topic: pull request: linux-firmware: update cxgb4 firmware to 1.26.0.0
Thread-Index: Add0snUMvCC4/zNUSJaMLTWOmh6eBg==
Date:   Fri, 9 Jul 2021 11:05:22 +0000
Message-ID: <BN9PR12MB5321B78120F39E6FE2D46798BC189@BN9PR12MB5321.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=chelsio.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3985762-5ab1-46e7-d2e6-08d942c97258
x-ms-traffictypediagnostic: BN9PR12MB5179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB51796B56135BF2A30AB5FE84BC189@BN9PR12MB5179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 88C8HfIJwhFi6abgpPcY6PuqFiA/q1H/Mc9+N/jmGtVEfsiM4k468Z1O6qZUK1eFvRCprm3PyWPLQhbD4VyI1sO5Euaggi6GfX636kUyE984L1wAHGqt+qFdlU/t22yK3nkRnPuCsyUCFvoArlNtrivZ8F+dx73oukj+cSkTlOkmcyeI1Rq7q9Kq/AaEm7hrWA1sKhEYOoZ8J5/KMvFFEoQKQKqePH2Ul3EIjZEDm9/mSuQbY0EqDFX65pPanmo+pEddS+PLbd0VptVwnoDyxpKexidLxoncyd68//kthed2NlKhUvcoeDv9zU9VevXYzM8aQ/pOfGwrI/2T5RgcgPJdQ8pmetORv7RNyC++W0ilZL5lZG+lJEE07I1qsgD2ZJT76GyB3ocbbzxfwfsUvs0jxPHGNK/zu/b7JcPNNa+R4mQZSUqaztvDJj9KR73wrxtMOQsfm+FtQYg9TycgFNXDpeq3I1Wtd3l9fFwFPK+KJ6k95OxpGWBag79d0IgXiaMIaUDPLNciErgURrmdsDZI4IQ6ViHv8A7asVQdzVu9RrMxybuqXCqIAzaZzoxAQ5olAAEx0q+UZxRDMWUgvq+5Oz6VnMoju647wk2IHeW/CCXS2ibdF3VzU3/7j673YpILgzGrFN8vTxg8EOy3Kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5321.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(376002)(366004)(136003)(346002)(396003)(26005)(76116006)(64756008)(66446008)(7696005)(66946007)(66476007)(15650500001)(4326008)(186003)(8936002)(66556008)(71200400001)(9686003)(52536014)(8676002)(5660300002)(86362001)(6506007)(83380400001)(316002)(55016002)(38100700002)(33656002)(122000001)(107886003)(478600001)(54906003)(110136005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?91Xur9KNfaJs7OyIfW2gdzx8jNjatCz1W5djI7kFst7z6o+D/QYYz5A81Dnr?=
 =?us-ascii?Q?QXMX6RUJ71d/oTCMZDzQSE3DZMMXl9/GGiEto4III03BXgxoigkRqC4GYUle?=
 =?us-ascii?Q?11jVc6RqbhXO5rkVDq2/eAV9Whp6E+oZ6nRKdACLo8r2fTl4EPKzEx+a5MkI?=
 =?us-ascii?Q?8Ypnzi1LAhiDwoHelKogl/GNhHM4WAhUctlOti/WwDJOLobIW3APLLKUaWAQ?=
 =?us-ascii?Q?npdRb68kXYz/MiOpJE+ahlCRkFhMl0XfYpYB1/LYzc+6S3VKLzudzLHKt9O3?=
 =?us-ascii?Q?W+Kq35ECdzg0c3afH8l5qTQSYqHFd40MjIvWRd4zFuT4o7tChUVR1IRFmA2L?=
 =?us-ascii?Q?iKBYn91a7AkdgDSRcsNEJq5lYHtdI50+/oIb+c65LRan6TXM9qw3H6KJJBRw?=
 =?us-ascii?Q?iGsrSq8Nk/PqEH5VOJ1UgtRFS8MF9lg7GddZKgPv97C3nA3QtbT38GolPkfE?=
 =?us-ascii?Q?qVie9wY5LJ5cPD07H2jvl7+CgAf2n1FkDL+Twpt7nVki02Y2UKqnId18rdk3?=
 =?us-ascii?Q?eMHMxYu/mUifyIwoQn0K3iFK51B20puGh1N487pcNreWLoUNO/Nnev/cg9JQ?=
 =?us-ascii?Q?95SwlGjz6zIDTKqUkPpgOVFV8JxYQqaNpMH0//HghCETGOZztBBayaNUlQgs?=
 =?us-ascii?Q?hjqjTg78wgLOXo04Wu22AFT+W+8hnrDF5SHilax++uuNDdxim769bzsEmDEd?=
 =?us-ascii?Q?ICSYqeUSYfXYTcCNonXpQbTqGuWLoWtVDCUsZwyBzkvhYMFwlmf3MYVb4ogD?=
 =?us-ascii?Q?kxKFfUetypLEtQyixQu2mlfMFpkNwXqvSxQlwdP1DKE0vECZrV3a1RNMF7aA?=
 =?us-ascii?Q?wdC/qfW/lbSdQf68rZMgQvVVCTuqtUQou/O5KPKI+hpgPSJ9aKtAg5L5s4FO?=
 =?us-ascii?Q?kkLvjbCrIceAlvl2wLL97JybBPvSxymrbQxXxEQtu9baBd3XeAbRYYdXFkjo?=
 =?us-ascii?Q?QfgDVfNci6T/ETjn9SfRSTr0BszPPZPypSNz5azgdOi/MvORdiL3ZMijuy6z?=
 =?us-ascii?Q?qb8ZALmh+AlzNBrIEyAF1D4GVLgFV5TFidGJEPdylRvfnRn4mRjdW4ulHraO?=
 =?us-ascii?Q?uuCPR+F3WBfkyNT6XLrbB7P05O6YcdzshOydaWQc5YONEpffmSYxwN7lM1cE?=
 =?us-ascii?Q?ZTR6nVKWI19f0KvBnyu5aVlbcQAlAPx77B3N5NbQXILx6pEZROCOG4VDZvod?=
 =?us-ascii?Q?2IVlksidv1COxNNt+vEZGzS0J1gcME5On8hoCHB4SODtB0g3LBNNX5fsAzd4?=
 =?us-ascii?Q?hHfVG5kvJzNS+MyJmU5nLMJS9yoQ6ST8nbOUoWEtLwBTiz4Qp0akWDjqX3fm?=
 =?us-ascii?Q?KSUWGiDQeGqODy1FB1WaXccs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5321.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3985762-5ab1-46e7-d2e6-08d942c97258
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 11:05:22.2167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ix259rdldpn9Eltsnx6kFmF+zNMALVM9Z0EN03hHl/c2U3chzRCbEHseLMsm7kud/+5XUOeefAP8V787nrtRQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can you please pull the new firmware from the following URL?

git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

Thanks,
Raju

------
The following changes since commit d79c26779d459063b8052b7fe0a48bce4e08d0d9=
:

  amdgpu: update vcn firmware for green sardine for 21.20 (2021-06-29 07:26=
:03 -0400)

are available in the git repository at:

  git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to 99cd4f9425cb0ecba3e46f0ccae70f760ceb0e27:

  cxgb4: Update firmware to revision 1.26.0.0 (2021-07-09 03:55:45 -0700)

----------------------------------------------------------------
Raju Rangoju (1):
      cxgb4: Update firmware to revision 1.26.0.0

 WHENCE                                         |  12 ++++++------
 cxgb4/{t4fw-1.25.6.0.bin =3D> t4fw-1.26.0.0.bin} | Bin 570368 -> 570368 by=
tes
 cxgb4/{t5fw-1.25.6.0.bin =3D> t5fw-1.26.0.0.bin} | Bin 675840 -> 675840 by=
tes
 cxgb4/{t6fw-1.25.6.0.bin =3D> t6fw-1.26.0.0.bin} | Bin 730112 -> 729088 by=
tes
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename cxgb4/{t4fw-1.25.6.0.bin =3D> t4fw-1.26.0.0.bin} (77%)
 rename cxgb4/{t5fw-1.25.6.0.bin =3D> t5fw-1.26.0.0.bin} (72%)
 rename cxgb4/{t6fw-1.25.6.0.bin =3D> t6fw-1.26.0.0.bin} (61%)
-----=
