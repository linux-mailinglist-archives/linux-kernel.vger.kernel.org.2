Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D81531F30F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 00:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhBRX1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 18:27:46 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:42726 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230019AbhBRX1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 18:27:38 -0500
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11INLpQ9015180;
        Thu, 18 Feb 2021 18:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=173IEF+G7l2R3kYDrZgxjeApvivdsl4EJ2cUK/VXK1U=;
 b=G8f74eR/BY9GhIyUsd71v/Upl7ucQU93qHA3ifpfiXks/CmqYrfaS4cNkULAzaOW21S6
 DBv1ldcnVRnC5C1ICxSKFGabIvJWASfJc5YDY+LScXWRiU8lyHM+/gtUmJPeTO7vP8Kw
 m4Ak0Sf+RHgDwp34H+bxOJjzHQUDpPmkos9dOK20yw7QX2P+zhYGmCw8VCB/ips6EnGL
 pr6MRaZ0a2KrXDhKZ+ESRuIXlx7NPztp09XMINNkbikxWXKusdAKQTkCpFcetItFOWYc
 Tb7Ybp1QTBlB041XTBg+zU9NeG9L/BGjlAFHODZELJQXZio298R8d3i2Pz87CuMhdiHo sQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 36pbnrt1nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 18:26:50 -0500
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11INP6Oa035907;
        Thu, 18 Feb 2021 18:26:50 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00154901.pphosted.com with ESMTP id 36pvn58tma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 18:26:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6Fh3ig8g1/SFPXakn2mPxC3qA88bj7TnOGeNulfKEuXKJp6Xsd/2ZShAHskyvUtC3qPIRTRLeevKFHXe7PNqrdtq0/1xLZCBGRGA352vM2XPBRiWxsDGmlCbVL0PgGcybDYZ9oOSen4iwBWoM7RfCvaQl2aFp1K5k1PW/bIOPMDDk5I76R/+00UJRBXDQVm1IuZ9bz2YKOmrLNFYpjAwKZxYkCBF+45U6TwzAwt+4vjXKVGpsP9QWm3GA+T0SHDCXDOYF6YE6v0kd1Xn1RgDCQ4zrf8bH8JPL8VoRfA86lX/YO1r+PDxa/R29bamutc2d953ihZX+j3QYWyYVWTQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=173IEF+G7l2R3kYDrZgxjeApvivdsl4EJ2cUK/VXK1U=;
 b=QLCnwdm22nUKPXt9sqc9OFBLbFDZPz7zzLkzY3utrTGgizedYA6pDd37Hdqkf2OM1QHKORJrfc4vCB/Se49KpI1LVyfz7EddSHMOIo60Ma/+6RJ253TtVAgFK4dICgK1ag73fJCnFl7FgjQC5YhC9IJt++/Tr7M9Z8njHQcKFmKnqzFvf1mDF9MLrBJNWO2FMe6vCqvL4k09rVlH2emeS+yb/evqyxxrFEKJYTtS1LkLIfNaKoDufzaugFxOMoyReGdLc/YGC9rRbVJwPXVLC7d+cEYJaf1hH6RXhmRZA3xLVbJ9hsYq/wmIupTQUy3yckWlV4+imThBkAfd5TZCJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SA1PR19MB4926.namprd19.prod.outlook.com (2603:10b6:806:1a6::18)
 by SA0PR19MB4237.namprd19.prod.outlook.com (2603:10b6:806:90::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 18 Feb
 2021 23:26:48 +0000
Received: from SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::1c92:24d3:b11f:bc50]) by SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::1c92:24d3:b11f:bc50%6]) with mapi id 15.20.3846.043; Thu, 18 Feb 2021
 23:26:48 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     "mgross@linux.intel.com" <mgross@linux.intel.com>
CC:     Hans De Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        Alexander Naumann <alexandernaumann@gmx.de>
Subject: RE: [PATCH] platform/x86: dell-wmi-sysman: correct an initialization
 failure
Thread-Topic: [PATCH] platform/x86: dell-wmi-sysman: correct an initialization
 failure
Thread-Index: AQHXBiq2bH3JAPkdtkOB9EMzpoMmtapehBoAgAAJxHA=
Date:   Thu, 18 Feb 2021 23:26:48 +0000
Message-ID: <SA1PR19MB49261FC8B24465A86A985975FA859@SA1PR19MB4926.namprd19.prod.outlook.com>
References: <20210218191723.20030-1-mario.limonciello@dell.com>
 <20210218224848.GB134379@linux.intel.com>
In-Reply-To: <20210218224848.GB134379@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-02-18T23:26:46.0842092Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=8ed95a80-0a95-4c86-a517-bef5af6052fd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f024f6b6-67f9-4b0b-35e8-08d8d464aa11
x-ms-traffictypediagnostic: SA0PR19MB4237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR19MB42377A1F3DAEA130B7BAA429FA859@SA0PR19MB4237.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VYnF4k1wenlyd78mbGgNGynWUPlYyfHoK0oQ81AeDYm5mkBiqFgc0FIjs7jycGEUF691EtTfQE9dt94XaLdtflB6Z01rPleQIMlENPddF0wwnGDeU4WiT5jaG/Sbv2meJYF5hH10FdLlf+nBiPKrZgKPrkDkxBH5rTFf5F/1kV/H4QBKs9+rxWrTpcI70LlyoDD5XiczoyCGCjtvVXxxQqkwoXVEN2QIizjrgzW+bbf+1LH495twMwxJuz/1e1I+RHsIGULkubnkfVqkazDERK3z+EJIEKRx19ESV9h3npPEX+iJsLqFDrzXkeq1uf/jue0E6uRfc+luWWvs83vbY0QTwTLcpJLaWqnsuPpEBuZapg+ZaDC4yEnH85K2Ci/muMlF5mtNEGqdpYO1OrJnR98eRfpvDYlpV7p1Le/gr1OsGdQ4XiuOIbbFWYW/X3QnTCEAtGDg8qNF4mndkkfCKHOA95b7wLdPe2sL3KxY8LEEHvKv6+Rp0a72laA6JXvFbuu+4eJdQiyrZWlrNahFNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4926.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(6506007)(6916009)(53546011)(2906002)(26005)(186003)(9686003)(66556008)(5660300002)(55016002)(71200400001)(66476007)(8936002)(83380400001)(316002)(8676002)(76116006)(478600001)(786003)(33656002)(54906003)(86362001)(52536014)(64756008)(66446008)(4326008)(66946007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5Jh6jciFOhJKfaanV7ZAt9baxI+tDOctWooyD/0//DxT+zY+jAyAgAk97dn8?=
 =?us-ascii?Q?S6LbyISRACXSRlMjIFjhsnmiE0OrVCl1w7Q3SzEhsZ9E97ZI02WXHVopWX6t?=
 =?us-ascii?Q?dVWQwXai6I5wFhhvma2g3uKJI7FuXUbfJ702mMOiOiWjVIBqcYmQXISDPr9m?=
 =?us-ascii?Q?9XejiIcYPWsmHpUQq4Cbejr6eCY7VF5PvY45VG2eP6y9RGEn8SQ6h/2kbJyB?=
 =?us-ascii?Q?AHdRhY+fzsgSlb0QMv8yo8E9Y2ovxtcr5LupW9TeX/GPBgM3lAvnT9zL32Ub?=
 =?us-ascii?Q?ClnEIV29mhBOoSoBXEF/uo/+dPawzFkA0RgSEgVhNv2y+0DfaK1/v5rsoeyM?=
 =?us-ascii?Q?UbW0Rz/kPd36QkBi43yfFzP2uvYh7SiXY6kzCOKU8o3n0AlBdFsX8Fp/4mPt?=
 =?us-ascii?Q?KpGVYnooX9s55SwS3WFA/HPZgGQRGQXWRWAqjYHU2I1D7FhGIBQ+ExeZ/MyX?=
 =?us-ascii?Q?1HN3My8ABMir2qvzbmxR9lAwmZDYg8rIPYU3j5nOq+zEy9f0mx2RmY4/0vDf?=
 =?us-ascii?Q?1PNHsM2rDdRT/cxWeNRkx4iZ5zHYdKH2jzjJeHyqbEI5q8CzdflPTzwIZON4?=
 =?us-ascii?Q?ktG+rTa6W5BrY7cdbibQtrfYdkcZJ7avH9Fpa6Nphwdi5OaVh51dtKZvJrEY?=
 =?us-ascii?Q?bjxHtZis/v1/QFLhvmu714JqSgNYd6Mi/YIC8TGBaEGRXvvyEL5Tn1cBf0Gx?=
 =?us-ascii?Q?SZcOPKuIUyWX+EbwN6OdjtJq4EyyoqIdiOt0LN8zfpmMNfZsCuPclSMF7s9f?=
 =?us-ascii?Q?8iKB2WqmFvxWbjs3DfE+7patSO7UpdyuHjQOmhkQIicIMG8gd1uwjttsIpBv?=
 =?us-ascii?Q?Kdr1/G1P7gyu66WWF570ntnaEJtZwyFDb0fdDkDjzMQZQta6NJoK+jtEbvMr?=
 =?us-ascii?Q?Jm0degPEALj1QvbQpjij9f6K+Ugqq6rdW+5ObRtzXUJToxVRg1+vMMuEqT+f?=
 =?us-ascii?Q?DS1XaFaIp3JZxsqxOTztR1OEq8OOT+iqAJ+gm3j4H0T6g1DmSqldcglw2WrX?=
 =?us-ascii?Q?tLU/jnRhrDQgG6Xz+BVPc2sdgllKNbzTGg9IAlwIYWEkqwDf8HhCk/TU1qfg?=
 =?us-ascii?Q?fwNLWsj8LgdpTmHk07/5IqJ56z75xqUZ2ze5m2zL0h2b+ujtMtr2k5ZDLDcU?=
 =?us-ascii?Q?RGmN+yst6iiNVJaIm3qJSF02RauET3OAGCmg3CkUmVazdplMKzHXQ8qOP0MM?=
 =?us-ascii?Q?pjhiGUlk4GUJ7RPJNWqXnMbPLMLBGqm5wqfG8f6OURr0gqftarGYFoPv4lgc?=
 =?us-ascii?Q?uvRRK1BGaDH67F1XCV/aQsDNw7cECdr0vRgYuxoZ5/vAqzHkWlesbRr33Tvb?=
 =?us-ascii?Q?4Z3hHwCEG0SuiX70ITR2oPjI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4926.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f024f6b6-67f9-4b0b-35e8-08d8d464aa11
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 23:26:48.6843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6de9vCNqZtKvEBGGz2uZconYPM2mDwldwlJQnj1emxnWuhCYgTcZoS7kzbfP1x1egzsT8R8xkZgL/Toh1z6mpKTKmR8PjnfXT7/YGC9cG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4237
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_14:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180197
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180197
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: mark gross <mgross@linux.intel.com>
> Sent: Thursday, February 18, 2021 16:49
> To: Limonciello, Mario
> Cc: Hans De Goede; Mark Gross; LKML; platform-driver-x86@vger.kernel.org;
> Bharathi, Divya; Alexander Naumann
> Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: correct an initializa=
tion
> failure
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Thu, Feb 18, 2021 at 01:17:23PM -0600, Mario Limonciello wrote:
> > On Dell systems that don't support this interface the module is
> > mistakingly returning error code "0", when it should be returning
> > -ENODEV.  Correct a logic error to guarantee the correct return code.
> >
> > Cc: Divya Bharathi <Divya_Bharathi@Dell.com>
> > Reported-by: Alexander Naumann <alexandernaumann@gmx.de>
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > ---
> >  drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c     | 4 +++-
> >  drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c | 4 +++-
> >  drivers/platform/x86/dell-wmi-sysman/sysman.c                 | 4 ++--
> >  3 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
> b/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
> > index f95d8ddace5a..8d59f81f9db4 100644
> > --- a/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
> > +++ b/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
> > @@ -175,7 +175,9 @@ static struct wmi_driver bios_attr_set_interface_dr=
iver
> =3D {
> >
> >  int init_bios_attr_set_interface(void)
> >  {
> > -	return wmi_driver_register(&bios_attr_set_interface_driver);
> > +	int ret =3D wmi_driver_register(&bios_attr_set_interface_driver);
> I have to ask if the propper fix should be in wmi_driver_register

Do you mean something like this?

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index c669676ea8e8..89d04c5e3ab9 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1415,6 +1415,11 @@ static int acpi_wmi_probe(struct platform_device *de=
vice)
 int __must_check __wmi_driver_register(struct wmi_driver *driver,
                                       struct module *owner)
 {
+       const struct wmi_device_id *id =3D driver->id_table;
+
+       if (!wmi_has_guid(id->guid_string))
+               return -ENODEV;
+
        driver->driver.owner =3D owner;
        driver->driver.bus =3D &wmi_bus_type;

> > +
> > +	return wmi_priv.bios_attr_wdev ? ret : -ENODEV;
> Also, is there any point to call wmi_driver_register if returning -ENODEV=
?
> i.e. should the call to driver register be wrapped in a test for
> bios_atter_wdev?

With some bus types it probably makes sense to register the driver whether =
or
not the device is present.  With the wmi bus it's fixed at bootup.

>=20
>=20
> >  }
> >
> >  void exit_bios_attr_set_interface(void)
> > diff --git a/drivers/platform/x86/dell-wmi-sysman/passwordattr-interfac=
e.c
> b/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c
> > index 5780b4d94759..bf449dc5ff47 100644
> > --- a/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c
> > +++ b/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c
> > @@ -142,7 +142,9 @@ static struct wmi_driver bios_attr_pass_interface_d=
river
> =3D {
> >
> >  int init_bios_attr_pass_interface(void)
> >  {
> > -	return wmi_driver_register(&bios_attr_pass_interface_driver);
> > +	int ret =3D wmi_driver_register(&bios_attr_pass_interface_driver);
> > +
> > +	return wmi_priv.password_attr_wdev ? ret : -ENODEV;
> same comments as above only for password_atter_wdev.
>=20
> --mark
>=20
> >  }
> >
> >  void exit_bios_attr_pass_interface(void)
> > diff --git a/drivers/platform/x86/dell-wmi-sysman/sysman.c
> b/drivers/platform/x86/dell-wmi-sysman/sysman.c
> > index cb81010ba1a2..d9ad0e83b66f 100644
> > --- a/drivers/platform/x86/dell-wmi-sysman/sysman.c
> > +++ b/drivers/platform/x86/dell-wmi-sysman/sysman.c
> > @@ -513,13 +513,13 @@ static int __init sysman_init(void)
> >  	}
> >
> >  	ret =3D init_bios_attr_set_interface();
> > -	if (ret || !wmi_priv.bios_attr_wdev) {
> > +	if (ret) {
> >  		pr_debug("failed to initialize set interface\n");
> >  		goto fail_set_interface;
> >  	}
> >
> >  	ret =3D init_bios_attr_pass_interface();
> > -	if (ret || !wmi_priv.password_attr_wdev) {
> > +	if (ret) {
> >  		pr_debug("failed to initialize pass interface\n");
> >  		goto fail_pass_interface;
> >  	}
> > --
> > 2.25.1
> >
