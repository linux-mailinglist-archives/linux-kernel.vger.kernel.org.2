Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4EE32CFF2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbhCDJoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:44:32 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:61392 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237808AbhCDJoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:44:02 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1249PVg0022911;
        Thu, 4 Mar 2021 01:42:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=jVInz5fdC4fS1KetxTZJOqQW9FzgJueb5jorQ2MP/tU=;
 b=E6fmV4Lt/Cvw1TslPzNiCYoG9gxfiSsczXgtqpit4W6Gi+cTcHhsUk+gbrRoWmZjYJBp
 AgQT9JlS7AviSTpH0P0gdPEFceai2CRF81bAH8PPx4ybTxaBCXIYkqy6aYG/69O1KpHv
 BDc1cQTNTIPIhdBXLkhukIvqU/Xr2+E4eHXyvP+TFLZfqX03yAfofgxyGhzhcTQXLoVA
 Ni2JyG8qRusCu7xJxwfnVMgQ8D2WdSrfXWO0u4RKHYva/rwtK1P0nLLWdMR5Kg6XSwYX
 EvUFUvWreN6hv9l/Jhehsm+0WKcCkAuba2jHlzsj8wkaxbJfQGVHY43UuPJuuPq1tuyt Cg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0b-0014ca01.pphosted.com with ESMTP id 36yjj2ru4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 01:42:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hp5RT6jVORqM0IVC7rpYs0GVuNWaPtrfZVDLUwDF+ihbBkiyQ5qCfmTCcZ1e1M5NslLSb8XfLiWZQm/QSwzEmuUNdfDwX0bYZHRNKlxONY8d5B04l/osoJhI5KayjR0rMxH0uWxSJuW3X+n4hZW9sHwJTQs49rw+8pExTQWjEFwCEctx8btP4t4UoWhhTEy6h9s5W4I3xqV1XS1taYd9Yo4UtsBII52kMnNebPDokyB7J3K+npsWv92zMD6Nc2EsNeXrUQo1l2uOh+jw9ZIWJ5llG0QDS/c2Ccyr5hMXxaqYTlBb3NJwRToRUTN2MPg5xY7iq3Q86PBB8HsPjJSSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVInz5fdC4fS1KetxTZJOqQW9FzgJueb5jorQ2MP/tU=;
 b=LWWGDl5H37qWyfkai2AJURCWR1G590q5774VuV1fEMHFK56fgrB93YpATXTrfvfPW9Y6JqK4M8FFndON26eiton7IC/XUJZyGboJdq/NErDAbtDiFlRIbZRpY4e8PH2lYswV7JWsLBijBIW0w5yWGNWafxEshpkjvUEFY227yHw5T3ONKOvAqI0gYekDB6wQm2L9wkH5RLh13Bm0I5x2IeEr988IsJCssql6D2cPCvFmWkuo1jzWmXf6PbfuKsauV/WesYljC6QmY37sMOleNkIrMbiUSKRWlaMVBqQl/eYq7XIadkr72T/+SKN7sE7EJGaZJwvv8X1o4IunjmP4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVInz5fdC4fS1KetxTZJOqQW9FzgJueb5jorQ2MP/tU=;
 b=EGnwTQO5jDQDR2uO+ItXuPsddwPSaKI8nNsb3RFTS+EH7otQiEfOII1tHSbZSeqDW6oIrF5ULLvVvxVMk3B7Hy1VO1Lpeo150cEmUzEJ0ReQBvGEM4nWyalXJg8i3NcLpLCRDUsBXxP/WgMZqWc8pyE1ULhpMcGX3SSjHcVrN4w=
Received: from DM5PR07MB3196.namprd07.prod.outlook.com (2603:10b6:3:e4::16) by
 DM6PR07MB6809.namprd07.prod.outlook.com (2603:10b6:5:17c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Thu, 4 Mar 2021 09:42:34 +0000
Received: from DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::3160:6a62:6e4d:2226]) by DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::3160:6a62:6e4d:2226%5]) with mapi id 15.20.3912.022; Thu, 4 Mar 2021
 09:42:34 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Parshuram Raju Thombare <pthombar@cadence.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "slongerbeam@gmail.com" <slongerbeam@gmail.com>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>
CC:     "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "praneeth@ti.com" <praneeth@ti.com>
Subject: RE: [RESEND PATCH v9 0/7] I3C mastership handover support
Thread-Topic: [RESEND PATCH v9 0/7] I3C mastership handover support
Thread-Index: AQHWxlqimuqIIVh8yEeU28e0sY0Zk6p0KHBw
Date:   Thu, 4 Mar 2021 09:42:34 +0000
Message-ID: <DM5PR07MB3196B095030FB077B5AAC233C1979@DM5PR07MB3196.namprd07.prod.outlook.com>
References: <1606659554-19229-1-git-send-email-pthombar@cadence.com>
In-Reply-To: <1606659554-19229-1-git-send-email-pthombar@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1lZjk5YWVkOC03Y2NkLTExZWItODYyZC0wMGUwNGIzNmI1YjFcYW1lLXRlc3RcZWY5OWFlZGEtN2NjZC0xMWViLTg2MmQtMDBlMDRiMzZiNWIxYm9keS50eHQiIHN6PSI0MjE0IiB0PSIxMzI1OTMyNDU1MDUwNTQ4MzciIGg9InRLV0oxYXZ1aUpKNG9DU3h4YWY0akFOUllzcz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 770aa90d-54ad-4040-87fd-08d8def1d6c3
x-ms-traffictypediagnostic: DM6PR07MB6809:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB6809D63D40EA7A23E6A2C8BAC1979@DM6PR07MB6809.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U7yQHcTjWf+Yqplh2IeNPa1dMBqDo7DajN8kWuPSGTlZdvFcS52e0jf4196zRT2nWq8RPsELvB+EXPnOm1SKb4902lneDfNWEnJonDKj5Fww3DYO6fUsMtMDir8ig7pAs8sbJ/pRZWahUVfiCpqL87bxviTMn/blz5jmEdzDiv0JVOy9c3CV7ZDaxsgVONBmd7fCnVRIHG00AFskz4LaB3Avipq1j/0jphJTf0XvVu4PGCM3fJMBUMamleIjnAlk83Gs7HGwanCKpy/p+GZkvCu0Srb3CQUHzkmahDfbVprkVqu5YR5foSgSjgEq/eVwJp+eMaAxFzxjilfwhxE4RqpwP1LvFJBFcXIzvwKgBoe6DKyXZvA4H9Xk+QXN/6KgBJzXGaq///Cmswi9kK2SezYxlaNaS2hE4itJbtwTIVEtYzSU6b01vBeJ0UeZSZeGKJqw2GMqF9ej+cLTqXkxhU7jmM/yehjemC/ujKQtyHucrtkGgYCkiDx9zRabZkm15DBiQDDXo57bwa+cNNTMNeeYdYFpz7mcEARjmP9dpDSLSCW+j2+xixkuGGuqBNLMzJRkgn0jI4lZnh+QR6UhBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR07MB3196.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(36092001)(316002)(66476007)(8936002)(2906002)(66946007)(83380400001)(71200400001)(33656002)(110136005)(186003)(8676002)(66446008)(26005)(6506007)(52536014)(4326008)(55016002)(76116006)(86362001)(66556008)(64756008)(7696005)(54906003)(9686003)(478600001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UO+HmHWSniS21NGrXI8ec9Ko2Rsgt7LZ1cRhVg9R8wxZPc7Aj8+4Ico4yIXb?=
 =?us-ascii?Q?suL7bYaDAdOx4VRMwpZAcWsWOmFGQMsyoO0oQq/0uvIOhXy/dGHY4BpmbqBZ?=
 =?us-ascii?Q?7ctMFuFSOzQORTc4QXu6Q+U6npWye5Q1Kca/+7Ha1ktUU5Gu4StKvNILKxZ2?=
 =?us-ascii?Q?aG9MWBfZk/sSEveBS1rZOJrRzwefQUuRqE54RS1IN4i3i6abWOnOXGk3SqF8?=
 =?us-ascii?Q?ItU1e1oEBJ0lAudOftg6zFgLmmvW5u7eT6OoX179rCyb0euPviHe6SzswZWr?=
 =?us-ascii?Q?5WYabza63uWNlBUf0rOPN7oCQG4ck08bKtrZvxHT2NpT6sti3goC7THpSRrd?=
 =?us-ascii?Q?ar7X4SSzZRAVjX9JlLx50XPuUiKhTmoqeJFsOsSCfmWEQTg7vcaxHwIAs+2R?=
 =?us-ascii?Q?MKVeiQPPO1Up6QIAs/nBHUM3aeSGCescBguw/PWFCXWZcOVZqPsnIG6W2MFj?=
 =?us-ascii?Q?IMyrbgOo7ohqU3ImxDC02/MyL0zqE8Hd5Ju2SLG/5NynC8mG1m4s9WDMEoaG?=
 =?us-ascii?Q?JMIs6oHNjwO3HyKimxX9Xwt3cu2GUg+Sd6oE53I9RaOTLimR9CDervixpSRC?=
 =?us-ascii?Q?SzbU8PqrS9IP79+2cjXdXj3Bfr11zcsIA+NbeLG0M5uKladqdO6rlhiNpJuh?=
 =?us-ascii?Q?+i9ydOuLwnd7VEU0d8J9IkqOnGXQwYMdJH24Fx3lQVaaHF++jC6C0SonCLBr?=
 =?us-ascii?Q?21uJJ1RzEEglH0kKsWJn5tmU63aZSmRlIAP3s0iHDGyy884lJASG3n5kK2nh?=
 =?us-ascii?Q?RIqLe9p0BtnLH++9DPs8Is/Cjc0RuqZME3MN82gr9Jro+H/wf5L5j9EEY/4A?=
 =?us-ascii?Q?boI7zypBfhZNak1wCSAr0v8bIxYVQkw4grfwht1jgNJlUsbzNiZPReyvI0+Z?=
 =?us-ascii?Q?pfUZZOZZTtnKGKQdI/+qbuIZ6skgAmWfw3iaxpE/QRGm339l4MdiabxjkYmy?=
 =?us-ascii?Q?lsL8U9ieRc5S/1y2BYpueDxkk9ICVcnyE0XC2/w7Whzae4vS3AlRfYtJjdcG?=
 =?us-ascii?Q?NE8B/XgxfSbQyeGJ/lBIqPHSgcWtV0hWni+DZYt6rocerDTQQO2wthTl8fmy?=
 =?us-ascii?Q?8MnHlBBKx4Yp/rsHL4IpyhMez7wzSpqaiFSAKms5u0ctCo7xCNzh4jnL4qu2?=
 =?us-ascii?Q?nHg/v6X7UiD/20LRx9ypXorVHqe4IG95O1dC04k2GlZZ07UKf4+FL0R6yUDf?=
 =?us-ascii?Q?79TDmrdISOkseJMXEKE7Z/859Gp/MNIhBa9lchxZPb/lzDp8ySUtFBEg5SjY?=
 =?us-ascii?Q?ZCd3amBHYQmjtd/iJRcckgLMjW6FUzQMtpZWo4uf8myQ8q8yElUOjw/EeQ3A?=
 =?us-ascii?Q?QhTNrHOweK7hb7ZkbwYB9Qmd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR07MB3196.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770aa90d-54ad-4040-87fd-08d8def1d6c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 09:42:34.2969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GdoK59VFqHUmHskzmJ6HHOHVOREE4iJZHlaWr13pys/PxQX6K14nWC54smMdzBLVxJ4rR7GX0GqtMSaiJ7GOHTgQk2VRZyUQVOfKx2hiW44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6809
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_03:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 clxscore=1011 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103040042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping !

>-----Original Message-----
>From: Parshuram Thombare <pthombar@cadence.com>
>Sent: Sunday, November 29, 2020 7:49 PM
>To: alexandre.belloni@bootlin.com; slongerbeam@gmail.com;
>vitor.soares@synopsys.com
>Cc: linux-i3c@lists.infradead.org; linux-kernel@vger.kernel.org; Milind Pa=
rab
><mparab@cadence.com>; praneeth@ti.com; Parshuram Raju Thombare
><pthombar@cadence.com>
>Subject: [RESEND PATCH v9 0/7] I3C mastership handover support
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
> include/linux/i3c/master.h                         |   23 +-
> 6 files changed, 968 insertions(+), 73 deletions(-)
> create mode 100644 Documentation/driver-api/i3c/master-initialization-flo=
w.rst

