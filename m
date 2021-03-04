Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0254A32D06C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbhCDKKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:10:08 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:41642 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233310AbhCDKJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:09:37 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1249l1Ea028931;
        Thu, 4 Mar 2021 02:06:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=3W4P7Yly1A/cG04Htd0UgDqM7fv7wWTGfI/KQ7u9eHE=;
 b=Y3pEKlvaUgbEn8F193MMgW+B0AQnotKdSTf/XUkxsL6DRqOonK+sgJUwcO+b96Siupl3
 npokC9YPFPwkjdKAxargYcXU2vNBgcndzJ6yjFPqk61HzQA6SJNbaZAwnAzXLL12nYYy
 13i9FfY9j0G1FyCWDG9gsIJ9vxN5TZQOIJS7Dnq0C9D3a9QkPVv+xYq6wJT7VhBfsasq
 VEHjv4Yhxx6KMQXGdvfa3PScsO2feA5rESjDuIZo3Bc5B6vG7B+llHZ73Pcdu9iUuxZ0
 9rGDJjRZ0MV76ZDmGmvxsE07OqTZf2PICROZNYHpy9IE0GdicK4xyMrmO38EV3hjEvFl oQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0a-0014ca01.pphosted.com with ESMTP id 372bvqkdfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 02:06:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVwsK9YK6A0GZrgWpL8hXt2op+hqNMuQb7UEnRV5zXoCgcyWnjpknmV3JV0tlqvYhCfnX/bM2fGLZDzdoGnBlwZNqW0nBFOR8rOtVcAF+mkUjn3qfs6vuhCaxHXiyZe9vssnJRjA3VQNwiOMv/wczHmZdWTuVV9t2gWlor9EAHve2RGaL+4VDFKL4nfIfap/GwoT6lgShNKen769mWHL1uCjA84hiZSvWrj3HXTvnYQY+NkEpV2epAJ6C2nvp1IbRHSqC9cRmoVYWM/tEE+mrDnEyQ1kmguH9EQ/cbT99MH3vqyyaBU/+9qjdxPBBSVkptgU0+B6W7DSLzfcrF0r8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W4P7Yly1A/cG04Htd0UgDqM7fv7wWTGfI/KQ7u9eHE=;
 b=E7eGfxazF9LQWV8oYgJgcmrTsZXx2njB7iXi/dprsbb5djhyYqqKUTJpkE3CpXXmXdHi63pxJqJRt484z3e9uv9R5llGrDTXQvyxVgRBC3Cr4B47WKryVqPcBBw/4f7a3uA2phSF54LzSiMk0TNbMpJUR2xYacXTVW/89RWLGSpwtUyjw069bqv8umWPfnKOp2GqB9WCFtJy19ArhWU5FUeu5jWDRaqZSLk14TfY5wM0ZEyCJi/oxL7MxdCSz4xWxaQRmTikZfAEtijknwQjcvZXoHJbevW1bn10BNkbvBfTHnj1G5GW9RmJN7wxR1mRoESqKb8CZ+dYb64lN0vgYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W4P7Yly1A/cG04Htd0UgDqM7fv7wWTGfI/KQ7u9eHE=;
 b=3d0tu04jUyW7SHq3VvZThSWifFYS1z+EDudLG/QgPoM8i22VJq9a8L7r/deBoi/CX9257Zz2TZ/tgr4/kAB/BDznPE3Zz6vlleUuA5La5WsVp7GWOilGzqKxGNnX7D7Fd+UV93AxvsA+5A+7h+vlRbjr7k00b6Yo/LtApTu1KUE=
Received: from DM5PR07MB3196.namprd07.prod.outlook.com (2603:10b6:3:e4::16) by
 DS7PR07MB7704.namprd07.prod.outlook.com (2603:10b6:5:2c5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Thu, 4 Mar 2021 10:06:32 +0000
Received: from DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::3160:6a62:6e4d:2226]) by DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::3160:6a62:6e4d:2226%5]) with mapi id 15.20.3912.022; Thu, 4 Mar 2021
 10:06:32 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Parshuram Raju Thombare <pthombar@cadence.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "slongerbeam@gmail.com" <slongerbeam@gmail.com>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>
CC:     "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "praneeth@ti.com" <praneeth@ti.com>
Subject: RE: [PATCH v10 0/7] I3C mastership handover support
Thread-Topic: [PATCH v10 0/7] I3C mastership handover support
Thread-Index: AQHWxuBZNoKhWMffhki2cVmktFQEIap0Lk5w
Date:   Thu, 4 Mar 2021 10:06:32 +0000
Message-ID: <DM5PR07MB3196C2BCD48597E8CAD2DD34C1979@DM5PR07MB3196.namprd07.prod.outlook.com>
References: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
In-Reply-To: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy00OWM3OWJlNy03Y2QxLTExZWItODYyZC0wMGUwNGIzNmI1YjFcYW1lLXRlc3RcNDljNzliZTktN2NkMS0xMWViLTg2MmQtMDBlMDRiMzZiNWIxYm9keS50eHQiIHN6PSI0MzYxIiB0PSIxMzI1OTMyNTk5MDMwMzExNTEiIGg9ImVxOTdrR0hydmxFU0tMUDFXSFRvb2N2RUhGRT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52af3ddd-e42e-459b-16c1-08d8def52fef
x-ms-traffictypediagnostic: DS7PR07MB7704:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DS7PR07MB7704A7829ADFE61640F24F65C1979@DS7PR07MB7704.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QYLpXBAIpyikSa6jJg81ZBUkx3znj2EyEPUrRYPj9bWekBvfZgkMYoCI0awC/M1N6evXeh+Z1o56z6DcBffrdJBcjQtTio6KDF3WgeTxuWhAIOeeB0ynPhZroXG4T9SuU5BRNerei/kd0OKUhFb/4TsQaH3AR4xRoFyToIEf++vMwjcT9XvZIdxwmU7K9vcOg/k8A8MrUT5pTM65ct0sucZ9dvxZw4JUepEi1OiGJk9/m6titkXP4QabS83dRRzbfn6OC5Jy2hplvceI5L3F+HAsCsQPrIuHZjNl7cKg4Coeq9olsdABO4Owaoy06aQlYimoEvjGxO39vVL8q6DSrlUy5ABDR1zETV2ttTYUNmJ1qmDbotWilCjIEjzCGrCXr0o9BzuySedgE/I6tJuvVxu+02NZFyBH0lTNfLvr4xJ/NfeZdfJ4SxURYHQqP/CeNrg6zgQxamfGIVj+KN3mWR0rRUfmezssjfw69fHKDLsr20bLrgE3onpOyAgWuRktZIyYsu5mJBV77E0Hz1Gbctqb1Ws0ZwW1o1MCKq/O+KrhJhxag0+l+IodzTweFMe8YLObhdZOeMuhTZiS/oPGOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR07MB3196.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(36092001)(66556008)(66946007)(76116006)(66446008)(66476007)(64756008)(2906002)(5660300002)(26005)(86362001)(8936002)(4326008)(186003)(8676002)(478600001)(9686003)(6506007)(7696005)(55016002)(316002)(52536014)(33656002)(71200400001)(110136005)(54906003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?u8DgQGzIbIgDsOZKPm20stx5iDBeG704F3UxkJ3GupwObX4E64PdIazta0TK?=
 =?us-ascii?Q?FqTrHLb1J0r5wFQzbPdYciRfKy3I0EIlmjNEfH1pCFfDwD9TvNoTg/lOoKJn?=
 =?us-ascii?Q?HeWW7XN/8C4V0tI/fP5a4w9JHqtjjX3/3oXkiV3vvvyc5c9aODRFVy3b9G9S?=
 =?us-ascii?Q?5yfW0wQzAvCuixGFvYLPWDKZQV2tBI3IWHqOB0Cl3tQNz4KvZ/FN07ppMMbt?=
 =?us-ascii?Q?iWRkl/WQX8bzrfGhbxkanmkVDUl9wdlK/ipbe0zUK4Ljct89FJ4iq4OK9mOZ?=
 =?us-ascii?Q?KmXMqq3XCJo03zc7jHFuSc+BG7c10wGay1e91YHPmiBx9WuThIlT7GprqQMj?=
 =?us-ascii?Q?Vl3NdNggm/txC//l5ueTfZMtm7i9FwyP6ktue1c7Gzm4KZq/7oDHgF/Jf7Dn?=
 =?us-ascii?Q?SApWogC48NPf0sw8w6qIrsQ5hiCfVc6woToX+dqY9CgZucSiu08eQH3FcGqs?=
 =?us-ascii?Q?MnzuR9ZPMWSYDpAcSiKtckfWNyCEarIZHTqc61bLc6M0odGpmpd82TgCQt8P?=
 =?us-ascii?Q?9h021H0yVlewTmlUXeh7HN4VyUg8d4flVG0JZkvzat6u4Vg9iq2gWHuHYkRT?=
 =?us-ascii?Q?LOej5OwgHIV+abFev34iVkQHiHbFGMc67WhiD+A1zunTEYqmWNcBBSRnjElr?=
 =?us-ascii?Q?gxejeYSOv789Iy2cQpZrxJWwnfUekrOclZZbz8GohbpMpKWPmjO6Az9/VNsK?=
 =?us-ascii?Q?TsAmq0R3fcKhdF5EZeBk8VTUY2osJD4XhATBx/R98slP9nW/1aze9VDDRna8?=
 =?us-ascii?Q?tbhm1iiNiAajOenTWqinNQ+GoIxZioSs7vQcAzX3Jtp8upKyKltDQhIS7tsR?=
 =?us-ascii?Q?ixuYZRrySglYMMEDDeKATuSjUhEjCnPWReMSu51HHiYWaTdJZnH/1flAaj3r?=
 =?us-ascii?Q?vM3+7oiqqp4/Ma0Bt7SZt+z344W+4QC6XC/andH+FulolezvqW8OjAFQrqBZ?=
 =?us-ascii?Q?K38obG3nTgo90V1+1iO34x+HtBWRt9H5wYwpNzDj7qezA0nUMtbD9pA2TXlO?=
 =?us-ascii?Q?/JNj4Yrx94qqkh0R9rbK5eOKCN4WPrB3ssJJ2s28id9VNLLiW/Emarh1ZqwO?=
 =?us-ascii?Q?yCW9j7tcHFK8YBHtHLLYPZbbb4YSqzYHjMuXe/8Zw3QOfFYlVRIpRp97TCAN?=
 =?us-ascii?Q?+6XS85AH6kp3qZ0G84WhSu40Tzn2rU7ysvIYvsn1UEXHYCUI18dX4DxJg4Pv?=
 =?us-ascii?Q?ZyYZ3z7+1wT21L7UZHPYidmPq05KA6nKNNl7oRV5X2NG4Cy660FW0FVvA3uU?=
 =?us-ascii?Q?IEsuWT3fsMQVwURUX1exPSeSeTvfMJpgO+WviMSoVxNuzsInvOUrBBaYKK5B?=
 =?us-ascii?Q?YaL+JLLfGvQ9oZ6KaZW+wpi3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR07MB3196.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52af3ddd-e42e-459b-16c1-08d8def52fef
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 10:06:32.3907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TjD7FGH4OvDgBStVFbSO7Dzc+JHgj1uuM9IqO6IG3v5egHKxZU2/xzSoTT5xnh79xXwRbMBgVyPYD7q1kSqzFj8ODGJ3dF8mR3SF3DzoV3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB7704
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_03:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping !

>-----Original Message-----
>From: Parshuram Thombare <pthombar@cadence.com>
>Sent: Monday, November 30, 2020 11:46 AM
>To: alexandre.belloni@bootlin.com; slongerbeam@gmail.com;
>vitor.soares@synopsys.com
>Cc: linux-i3c@lists.infradead.org; linux-kernel@vger.kernel.org; Milind Pa=
rab
><mparab@cadence.com>; praneeth@ti.com; Parshuram Raju Thombare
><pthombar@cadence.com>
>Subject: [PATCH v10 0/7] I3C mastership handover support
>
>Main changes between v9 and v10 are:
>- Fix build failure reported by kernel test robot
>
>Main changes between v8 and v9 are:
>- Fix NULL dereference issue in current_master_show when
>  cat'ing sysfs key current_master for secondary master
>  before primary master gets initialized.
>
>Main changes between v7 and v8 are:
>- Document format changed from table to DOT diagram
>- Appropriate names for few functions
>- Moved mastership request process entirely to the driver
>- Reuse of i3c_master_add_i3c_dev_locked in core defslvs
>  processing
>
>Main changes between v6 and v7 are:
>- Added separate functions for main and secondary
>  master initialization
>- Secondary master initialization don't wait for
>  DEFSLSVS.
>- Change to use I2C device information from DTS,
>  and corresponding changes in controller driver
>  and I3C core DEFSLVS processing to ignore I2C
>  devices received in DEFSLVS
>- Reverted bus_init split
>- Fixed formatting issues in document
>
>Main changes between v5 and v6 are:
>- Moved populate_bus() hook to master subsystem code.
>- For secondary master initialization i3c_master_register
>  spawan separate threads, as secondary master may have to
>  wait for DEFSLVS and bus mastership.
>- Populate bus info is based on DEFSLVS data and take care
>  of hot plugged / unplugged I3C devices.
>- Split bus_init into bus_init and master_set_info callbacks
>- Moved mastership aquire and handover to separate state
>  machines.
>- Added DEFSLVS processing code.
>- Moved back all locks in side the subsystem code.
>- Secondary mastership support to Cadence I3C master
>  controller driver
>- Sysfs key 'i3c_acquire_bus' to acauire bus.
>- NULL check for pool pointer in i3c_generic_ibi_free_pool.
>
>Main changes between v4 and v5 are:
>- Add populate_bus() hook
>- Split i3c_master_register into init and register pair
>- Split device information retrieval, let add partialy discovered devices
>- Make i3c_master_set_info private
>- Add separate function to register secondary master
>- Reworked secondary master register in CDNS driver
>- Export i3c_bus_set_mode
>
>Main changes between v3 and v4 are:
>- Reworked acquire bus ownership
>- Refactored the code
>
>Main changes between v2 and v3 are:
>- Added DEFSLVS devices are registered from master driver
>- Reworked I2C registering on secondary master side
>- Reworked Mastership event is enabled/disabled globally (for all devices)
>
>Main changes between initial version and v2 are:
>- Reworked devices registration on secondary master side
>- Reworked mastership event disabling/enabling
>- Reworked bus locking during mastership takeover process
>- Added DEFSLVS devices registration during initialization
>- Fixed style issues
>
>Parshuram Thombare (7):
>  i3c: master: master initialization flow document
>  i3c: master: use i3c_master_register only for main master
>  i3c: master: add i3c_secondary_master_register
>  i3c: master: add mastership handover support
>  i3c: master: add defslvs processing
>  i3c: master: sysfs key for acquire bus
>  i3c: master: mastership handover, defslvs processing in cdns
>    controller driver
>
> Documentation/driver-api/i3c/index.rst             |    1 +
> .../driver-api/i3c/master-initialization-flow.rst  |  187 ++++++++
> drivers/i3c/master.c                               |  497 +++++++++++++++=
+++--
> drivers/i3c/master/dw-i3c-master.c                 |    4 +-
> drivers/i3c/master/i3c-master-cdns.c               |  329 ++++++++++++-
> drivers/i3c/master/mipi-i3c-hci/core.c             |    4 +-
> include/linux/i3c/master.h                         |   23 +-
> 7 files changed, 970 insertions(+), 75 deletions(-)
> create mode 100644 Documentation/driver-api/i3c/master-initialization-flo=
w.rst

