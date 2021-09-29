Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B99D41BF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 08:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244345AbhI2Ge0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 02:34:26 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13963 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244177AbhI2GeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 02:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632897164; x=1664433164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=raYVdb01/Hhci04VCb0J6xlNuvq2bjGYYK8YzcIQWUg=;
  b=qQanZfzFPa8E9ddznjEgWoh1xXj2dInvjTGEfEdl6oAU0xGsSANwP6FL
   9UeixjoHNwyfFHNXGB2B3M6+r6+GufLPwiumCMnwe1yQf7Cj2VYxEU982
   CJWvpeBt6nVU5DTbvWwhpsO3YGv/135E5WsNNTWBgQc48Oe0iHws+nzO1
   4iqnGQCodH3q7atl9TddVegvMOerN++TAIJIxYl7S21j+WmO+mzrVEHMZ
   QsuJXlhLfDVmOno+OSQbn3bDSFlgFlMfsumVa3WTFHLcoVj/T4GlP3VWK
   /+WeYW7u5UVxg36qc4BTIdVbyKZ61+5BVCXgSLz9+eLjsrx94DOInotCp
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,331,1624291200"; 
   d="scan'208";a="292916770"
Received: from mail-bn1nam07lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2021 14:32:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+41Y7pClnTvfPRLp0rP+gSt5G9nUPC0zvW8Mjz7FBhVpkgLanpfj1FReT1wuzMhd1PwE6Np0myoOTE/mITUoAI2vwi3aN5perhN7pgIZQYFK4nZger9L2OI7jSYyOdHOt2qrLoypJHlGB+Kk+pdFMElOkrXKmXKq+ogVSekxHNoQbwea2C/3foH8muYy0kNGxnMiHm3FeYn1bPsOmlS/wL83gHz/OjxUcI7q/vTDtERIZGJV2HU00Xtuy3rpCyTod1GHQpZhFTPx3fBT9tXZY69OK0WD3OIGTtpZGqIM/NYZQzI54J2sKTq4jcGA/fH0uZ3Ai5Q2XxZzmiv/V62vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=l48A1+So/SeDNXJOJbbhqCpOlhms0ouqoSFp666Sp9I=;
 b=OYYCUY5xkEzh1CucT7IIbaJCuMdj4D27MN2TCf24JbILuuZhlvgn6WqMIhvPS3HcA/MU9nNPTchAbziu+Gc9rKJ1Z2Vb99zGFP5TRPvl5dih3nYv6bWD68e6PW/sJtk3HxwqWrokWUJOocgrd3xMImW3bLhB7ExI5NA6oR71jYMSB6hcXigsGlRQ05vXyp71llLjeYSZkA6GRWTm8xLphCFXKnbBx3GjA4hT5AgLrj9zu0CGdlMUvAKawwFizqhgIN8yzoGKfVhntABkqqbRmmKVyDU7CvyrTIZaReJn2Aj0K+pErV74mp52VJ2j8ajl+CuZAv/KBLOSXkcwkALOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l48A1+So/SeDNXJOJbbhqCpOlhms0ouqoSFp666Sp9I=;
 b=qbbsdUBKAgPX9dmIQBoAwGpsSzIIs5WGHvp3HD3JKn3gEqgWI/KAuKh0X8MjAFda3yaQ7zJp/k6HANNjZcIHUkeuQgtHwB2s7WY63fuuP4QF/64rPgiwpSlBx2bafQ8qbX4t9tEg7jBz5oZwNGJDRmr0YPCGiuARUZ/dlgR8EN8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4843.namprd04.prod.outlook.com (2603:10b6:5:2a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.18; Wed, 29 Sep 2021 06:32:40 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::edbe:4c5:6ee8:fc59]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::edbe:4c5:6ee8:fc59%4]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 06:32:40 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 16/17] ABI: sysfs-driver-ufs: Add another What for
 platform drivers
Thread-Topic: [PATCH 16/17] ABI: sysfs-driver-ufs: Add another What for
 platform drivers
Thread-Index: AQHXs6f5Yuh6nmqV7E6a9UXcE4axwKu6iE1g
Date:   Wed, 29 Sep 2021 06:32:40 +0000
Message-ID: <DM6PR04MB6575E3C9D13E8B41627240FDFCA99@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
 <bc61469964bbcabe38d12aa88f2734d38a8741e5.1632750608.git.mchehab+huawei@kernel.org>
In-Reply-To: <bc61469964bbcabe38d12aa88f2734d38a8741e5.1632750608.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc16b692-69d8-4ab3-9f77-08d98312efbf
x-ms-traffictypediagnostic: DM6PR04MB4843:
x-microsoft-antispam-prvs: <DM6PR04MB48430B837ADA2241576CFD55FCA99@DM6PR04MB4843.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QHDdgOUhqgkgrXekfycwrAZtF1T/ucQ8tLp2gYdRtgZ18IedOuAjZHE6lgzsG0G7igRDKaW4Ebl5BixrereJaHicjCHWPO05pmsGpEqb1q6UBADU5AhGBIvBh0AnyRmhjh4GqNmZCgiUKfw16kItSUkceOP8c0sTFUrOAzWCfJLLLTnbzjLNCvYq44BZo+f+OZ88jkejcdrXd8Ih9v99tYgepoXlJ24kmusz6k3RJfAMKHW0Vp3SJMvCh6nCEsftuOyrHXgliWug+on7Fp+18+HZc4EH7lMf2cmcyMOlQMY1pyX6qNqPRGJ4lpOFY6Cgs8HI1L/O+96P6OTche/VU9etNgZKuUrPI+hb8vJ5gmoIl+OPndzjsDbp5gu4nyZ9UgZaaiiDo/+JIvkMsHr6mqq4uMtfwuEdzevNZ1LvIx5RC5JGgzYffBw5QwSJ8Wnc9jD7jmw1/9sdr2M1lTTD6JuMAZnY77ErdbJyMq76nfkM15a4x8539/S9ajnljnqD0xHyULIOSuchEewPw+fyZqjrURd0BflbP83X1cws9TXAHiGQLxoy1AgAZvHkgqdDKP/3yQsWD3aYacQlkdL0Fm2P0/LLoG/mmnASynJY3sjIZ23BZ3SW5TjTm2qZ5/BgAtX2lWJKnf7dV/8jBqHiiweEV4g0Y9BiUFLWW42bOKBH3IA37EykCo7iQ5m5e2XLBqw1AX11qXOhcTZtGZn3TQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(54906003)(4744005)(38100700002)(64756008)(122000001)(86362001)(26005)(8936002)(76116006)(66946007)(8676002)(33656002)(7696005)(2906002)(5660300002)(66446008)(66556008)(508600001)(186003)(66476007)(55016002)(9686003)(52536014)(71200400001)(38070700005)(316002)(6506007)(4326008)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gdui1lvC3X8wSLQV+ZLgunSQqOCC0xXb3Dn2ZCcUnQQw9qY0g2apmQKJgaHa?=
 =?us-ascii?Q?CBZ7H/QFwJSt92KX9DS7Wmo8krzEdRcPLaXouh/J51stueTb8whsKAGvSvxy?=
 =?us-ascii?Q?mEEeycHh58GcqP+ud8/i+k/239A+lN/xxy48r/X+ep+qnOtUlgD/UzusQPWh?=
 =?us-ascii?Q?GX7MzSFl1GtsfJTpt8VdsT+BizeI9Srqk2u62Hc9MBVhGt1qg5H8trfVVzEX?=
 =?us-ascii?Q?t4XltXJukYvnbyB2T6Rs5hA/52m7h8LHYKJDeQg40HVy9ezDaq3fURe9zORE?=
 =?us-ascii?Q?ccdfGH0Ymfz5ySSDBONvyymP2nHN+ZHi9Nwcv4qyVVGh/cqi1M8JqrFHOuUk?=
 =?us-ascii?Q?dUn0oxwFbY05YUYU+RGCgSH77vruco6oXVAm4kc69GFh++6ToDRHHZ41z8ps?=
 =?us-ascii?Q?woVNHIDxynN6Z6ZmegZm2GUX+904GuOmLT9DkwCJOtZmHWmbwmCgMCHkQ41t?=
 =?us-ascii?Q?ke+fao0cHnyTwkF0zXDqGoOn9SeLRLDNQ1+eRp+0vs37w9zeeHcqdz1eBusb?=
 =?us-ascii?Q?uaVyCixrRODJA7EY6OzzXo+z042bxRI/pj0Ey2lGbr/iTWto2I1L3KdhSEQq?=
 =?us-ascii?Q?D2PItbp1pG/5LMp2rOhyTmow+sObF6+XFpIelktjZhtLqBOJ9amjTcAYL+M6?=
 =?us-ascii?Q?EiBHombDB2QQA+v/n0qZkZrjmfPA+PW6H1QV4MsDojfPfEu9OMIFdS2mo4L9?=
 =?us-ascii?Q?ToY7pLF6lJWvauTfwMfhEcRx/GyPXJgLmKKmAJ/SM1zBRPStrhyjpxQTlwIt?=
 =?us-ascii?Q?zbVDetlZuBfM8kYD8HkNv1AqHIF21L2dKVuF3kdeIBO+kXCOhoHhyb5g4X0C?=
 =?us-ascii?Q?HdMc8mNT+JXC7X+PTDaZr8RjYVauNRG9DxDhuLR1a+bZk9wAKteenwLc8zhx?=
 =?us-ascii?Q?suzIioSDc+hkzTRo9B37nBG6jLfcHH+WH50wi5fQcOOxxIEE7HnEmzfQE/m0?=
 =?us-ascii?Q?idUpfqZgI1+zjq2x+layde+my9S3Dcp0rp1hL0rbu1gOX/rnqJbU7JfeWgts?=
 =?us-ascii?Q?R7XxjMtPZgY8NUfaZtirqPb8lLg/bnUQKwD4DHt0X+twsQp9spDGAnr+efXX?=
 =?us-ascii?Q?rgtcs63n3vvUuH//aXV0gwdJfbNxwf27z+KfqANPwFOi9v32hXhCmf7WHfgf?=
 =?us-ascii?Q?Ki9XeL4X0ZiF2VB4pLVAj9vhsA5B3KTNrdP3dIWW0HDLpliSDU4pg+tcT/+i?=
 =?us-ascii?Q?/kAjIc6arfnkKXsUFRmcfNGPg9K/aQifIB1qiRCWaH9PyZclXrebRxxpm7lD?=
 =?us-ascii?Q?NkwU2dD1K4uc/WGX+J8tQICg4TdyR0/BZCwGzZhMCUJDmzEr6Sa/lyRQ1YFv?=
 =?us-ascii?Q?VTLwZJQtK9magHXFYNmA2J+w?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc16b692-69d8-4ab3-9f77-08d98312efbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 06:32:40.3354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzqMRTagJhi4rcIbAP4X4fHYeMJL9juBxQS254H17I4B8r/8u5KwyHJfK1O6maKoXCIcJDzsPIEAiTGEJv5zQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4843
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The current what expressions:
>         What:          /sys/bus/platform/drivers/ufshcd/*/...
>=20
> Doesn't actually match what (some?) platform drivers actually
> export. For instance, drivers/scsi/ufs/ufs-hisi.c actually
> creates the sysfs struct for ufshcd inside this directory:
>=20
>         /sys/devices/platform/soc/ff3c0000.ufs
>=20
> Which has those aliases:
>=20
>         /sys/devices/virtual/devlink/platform:fff35000.crg_ctrl--
> platform:ff3c0000.ufs/consumer/
>         /sys/bus/platform/drivers/ufshcd-hisi/ff3c0000.ufs/
>         /sys/bus/platform/devices/soc/ff3c0000.ufs/
>         /sys/bus/platform/devices/ff3c0000.ufs/
>=20
> So, add another What: for such files that will match the
> device ufs entries, e. g.:
>=20
>         What:          /sys/bus/platform/devices/*.ufs/
On some platforms the suffix is .ufshc
So Maybe use:
/sys/bus/platform/devices/*.ufs*/

Thanks,
Avri
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
