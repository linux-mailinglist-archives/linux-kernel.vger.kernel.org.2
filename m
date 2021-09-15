Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B68040BF95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 08:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbhIOGRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 02:17:38 -0400
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77]:51296
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230428AbhIOGRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 02:17:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFe3iOzpknMLdBCyE37h+Qc+vYr4nEgbIDO+zMQP8E8ia25TK5WiG+EV5dFLt9mb0/9tLvQSI2YioxtSmZvRk6WQZvcoFmA+6pAvmOqSwaxZEtsEfHTjpFQZuPoBosljQ/qVcW5WmyFIxNjaUQki2Xk3OuJDLpr52RG0zjcPtVbQS1CYoyPSNuadBdto8XsAaSlrZrwMaQj8VPElZoM/pRaH3HqDA+Md4g4cP/zjFQD99qjxU7hh60Bf8lWDgjQ+3wyFsUatN058IP8nFmO2VVX9pYW1Weh6fxy3ezYiB5zq0ajANdqCbwMwvE1QteoWoZkRc29D3Ta2zs2r5uKS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Uf7r+m3RGSrQga2h9Zrga9YtlFjdUqsvzXCnC2wdxgQ=;
 b=G18McZhRYDm3Z8l6I8BrauTQu0GiY8JKyYB3JpgSEkuRFB4Ib9BAypA5pmKQfA/zAWuuuLcVfoI3JgDc4Nf9C/wZJiSGLLLlE2toCB0tc1izaYBtDlX1t8YqChs8tWACZG/uGUHHGftUQqZTRm/otHWSXwac8nyRWM+JiOWtvj909PiVinOqjKTSj+KZnyhdws2S14Y/Xwjx68z4Zx3h27UMgXHmsF4Jv7vGoGwC4bDsKZ6neo1uTB4ge9sfglvtJUgFynGcRU6WOWk9q/NTepOzEh0kioNKdmMRSC0XhQq0+Mx7s5x1i4M0G01IUyy3tH1CsN62kflc2vavflwxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uf7r+m3RGSrQga2h9Zrga9YtlFjdUqsvzXCnC2wdxgQ=;
 b=aiLa65gkMBRig7uBJiuyPu0LPiBuKwZocnYrsOjqqot+e/gjkRP9C8p3LQLs61h//sVPqA8OQSnmgyBVrvJMSNyEQ1Q6gfOHOYOafhue86e/2FI8LNn4d+GiQfa6JOBzeZeigudnTX/O3IJXquGAUU3DqwwX4D6ZxrI5Ij6Ioig=
Received: from BYAPR02MB4488.namprd02.prod.outlook.com (2603:10b6:a03:57::28)
 by BYAPR02MB3941.namprd02.prod.outlook.com (2603:10b6:a02:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 15 Sep
 2021 06:16:16 +0000
Received: from BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::99ea:4428:526e:4a82]) by BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::99ea:4428:526e:4a82%7]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 06:16:16 +0000
From:   Ronak Jain <ronakj@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>
Subject: RE: [PATCH v2 3/3] firmware: xilinx: Add sysfs support for feature
 config
Thread-Topic: [PATCH v2 3/3] firmware: xilinx: Add sysfs support for feature
 config
Thread-Index: AQHXqHr2mimi3nx8iUKHSoOC4mnBQqujQsiAgAFdQYA=
Date:   Wed, 15 Sep 2021 06:16:16 +0000
Message-ID: <BYAPR02MB4488F74E21490FC4801BA375A4DB9@BYAPR02MB4488.namprd02.prod.outlook.com>
References: <20210913083955.27146-1-ronak.jain@xilinx.com>
 <20210913083955.27146-4-ronak.jain@xilinx.com> <YUBpjUGaB3G72wRa@kroah.com>
In-Reply-To: <YUBpjUGaB3G72wRa@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88e9d387-b0bd-46a1-5513-08d97810534b
x-ms-traffictypediagnostic: BYAPR02MB3941:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB3941C68B16DD33E974C44316A4DB9@BYAPR02MB3941.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jxFd4iRD8aEzISXWz4C1oiijhalrMCzWPL4mbfpLb6KwhSrB/TSOCzNbdoFoAdDeY1TSrobiCXwtf+ZmHhpUhKlwfRyEh2s8nCxcBNGRp0gyl2PShGykVf4tfKocklMt7XtZZvKo1hOdIqOoW1/4jhybaPkTfGty49otpJGIa+Lt5DCYsmuoJZDuhwmrt5WnIJF/AN6kcGk9WkscMP5bEAM/ZMp0JSsNqDSUwrNJQQr6FKY3MDkBAndCxZXni5fla6GOpfebtCU4CpLnA2QQy+7gZ/J6BpCiP+dOY1uVsJGqCxJZUT9Q9YRhGhLWpISCW9Ao3p0wflMqJLdLMiKzxf0VxDRK5M/ZKXt1bwJQtzBgi8gOFjwSlxkRoFciGW+ZTOjvVG4I6Ck5sCeG2hKDU58+8ztfuGtPdv7zG3Rhr26lN+AfcnkhCv+riyMeYGYED9exaULcGC8jscBfumLBlE9MD5tr7B1M/wdkzxkhtzmIr/5nKKZbk/zD9zlQSynthDeaFsHrSCbuP9cmgoj3aHJwj03g+r+ObG1OdOalCvxiah8uBgupHhAi41MCGWyKGcGo1qP3q6N7rGFFzOHRMLyEX7N7IcbmaTcB4MByaUEwwojWcwDPH/Bl/4HeOytTMA78b/4WsNfRzu8fdYBElmIkPsdURbWqIwevB2AeMOp1nSvt0eOYHYYOoPEPjf0in2L5JRVOf4KRk7kxAWzeAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4488.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(4326008)(5660300002)(54906003)(8676002)(122000001)(38070700005)(508600001)(38100700002)(66556008)(83380400001)(76116006)(9686003)(6506007)(64756008)(6916009)(66446008)(55016002)(2906002)(71200400001)(186003)(66476007)(86362001)(33656002)(316002)(7696005)(107886003)(52536014)(66946007)(53546011)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6sYZV9zWi7WtsegDp8NdysAgNzY2BnnvPRrsbY3Z0lBtfU0WfuvHkq9jo7K1?=
 =?us-ascii?Q?QzA/OT+UM7F4ddaNr6J4bkdPalN4llbRR+WeQB3OrwB5bVRWMd4jEEYufWnk?=
 =?us-ascii?Q?2Yae5EmLtaZIVHXx75dFwEADzNm1zGJ4lqGa+wnTDPI/lDZf4RBvq2RTgzAu?=
 =?us-ascii?Q?rsPp/whVB5vi6VzhO1g6mWDjGXYn6OhRvGFJMTcgbbEsCypcBtebhDCriyP1?=
 =?us-ascii?Q?n5Eq12WCjlWgEjk9w6sBp+1rjIsI0VmtAEoRg1dcv7mwGSy7i/oXCmETbaQ1?=
 =?us-ascii?Q?mt7syjgNnaU6xR39W+ER7LhlsaIe6X/EPhkEZIFRIdVJ3ln4E485gnV5oFqA?=
 =?us-ascii?Q?bRqL2O9pXD1cbk14xRjUBc/silOy174mHCksHgJepB89uQofTF9HLzpW3Pte?=
 =?us-ascii?Q?LPPTTCQphcqbiHVI6D480roc20zehdQ8g3fzvKXjzh5ytXmSd3Rs1g/L7mQN?=
 =?us-ascii?Q?GRx5xTXaalnWfZnxToZAkKJWLfz6ab1aHhpcDIIclCB59n5NBhgdsMD1SkZt?=
 =?us-ascii?Q?7zAcQBagCM0oUSTpblIKMD/sl1hZAjPKsnX9rFK8dMcuiPZ82GgTuRWPLRKS?=
 =?us-ascii?Q?uT+Py0sBH+RG7zJcRrXN2FWWGgZAfipi8DFk32tDFQpyKNwmnvUGAwAjpU7z?=
 =?us-ascii?Q?QW9JwRd8iNzWvDGwPzjZxT4/1rkk/QQHK/ORPQetCjs18qjNxQhdt8QoHLjY?=
 =?us-ascii?Q?+I8MMyGlnV+llf8w/3WmvyFv9hodWD9NcNABV+33FKZeFwe2Ezd1AVHxfoZc?=
 =?us-ascii?Q?JDpnXLcXZPTTyPJ9xa6x3u3UEPaQpvrUCknEhzGX22USe9EmqGgLQ2X6DTeP?=
 =?us-ascii?Q?KID0dKs3UW3wyDRxsLglYTj54u04IiuE/b+Bt0rdLnHwcTmkrYgUthIFe9BI?=
 =?us-ascii?Q?6XMee9+uKiiqdxAHxT8JiMNivN+GkbtgyFlqdjQjryfT+QxOzpragNIaYlPq?=
 =?us-ascii?Q?jmO3wHtXOcObZnYS4SwvTrQGkhBmj7dvBK1C6wv5eGjPIWd4R/hUn6mfQZTB?=
 =?us-ascii?Q?vD37cBIc0N4XHcwS36GN4xWFRquuAuJzXW0nA41IqmbIHpTg1OYw42IuT86z?=
 =?us-ascii?Q?rWNMr+FZ6Xpr6ouSigEsj713pJznO64sxOL8AfNr0wH/3ZNK0EbufNZ3/3oV?=
 =?us-ascii?Q?Newzc8+xZ0xgFmR47GZIt+k3prEjdJEYed/OQf+XKjmt/JvDPSvfRf38OwEa?=
 =?us-ascii?Q?+PYzgOPC1CFx9IYhOSiVIi3a+B8mBdL06X7lXlvSiMJkiPr1MmO8r7F71Yu6?=
 =?us-ascii?Q?xRRRRuy/EriAnVpenFjtZPBoiKMzJbGe/rBzMh2o70TezMzOhxGYtSUwNoRI?=
 =?us-ascii?Q?SIOBbmBkRnugug/0K8jGYMO0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4488.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e9d387-b0bd-46a1-5513-08d97810534b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 06:16:16.0942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8wjAzvZdwBZfyk1+Q3dXjHOrWCo0ZuRWzh+HlHXvtwwSakFyEgComCEQzI1Wyu8HR8SSR10s5tWXMjVct0vUFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB3941
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg KH,

Thanks for reviewing.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, September 14, 2021 2:51 PM
> To: Ronak Jain <ronakj@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; linux-kernel@vger.kernel.org; Raja=
n
> Vaja <RAJANV@xilinx.com>; corbet@lwn.net; linux-arm-
> kernel@lists.infradead.org; arnd@arndb.de; Sai Krishna Potthuri
> <lakshmis@xilinx.com>
> Subject: Re: [PATCH v2 3/3] firmware: xilinx: Add sysfs support for featu=
re
> config
>=20
> On Mon, Sep 13, 2021 at 01:39:55AM -0700, Ronak Jain wrote:
> > Add support for sysfs interface for runtime features configuration.
> >  The user can configure the features at runtime. First the user need
> > to select the config id of the supported features and then the user
> > can configure the parameters of the feature based on the config id.
> >  So far the support is added for the over temperature and external
> > watchdog features.
> >
> > Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> > ---
> > Changes in v2:
> > - Update commit message
> > ---
> >  drivers/firmware/xilinx/zynqmp.c | 71
> > ++++++++++++++++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >
> > diff --git a/drivers/firmware/xilinx/zynqmp.c
> > b/drivers/firmware/xilinx/zynqmp.c
> > index 875d13bc1a57..a1434dd368f2 100644
> > --- a/drivers/firmware/xilinx/zynqmp.c
> > +++ b/drivers/firmware/xilinx/zynqmp.c
> > @@ -1361,6 +1361,75 @@ static DEVICE_ATTR_RW(pggs1);  static
> > DEVICE_ATTR_RW(pggs2);  static DEVICE_ATTR_RW(pggs3);
> >
> > +static atomic_t feature_conf_id;
>=20
> Why does this have to be an atomic?
Use atomic to avoid race conditions. Suppose the case where the user is try=
ing to write the variable and at the same time it tries to read, so there m=
ight be chances of occurrence of race condition. Also, I am not so sure whe=
ther the race condition will occur or not but just to prevent race conditio=
n I have used atomic variable so, the read/write operations can handle auto=
matically.
>=20
> And shouldn't this be per-device, not global to all devices in the system=
?
This is to store the config-id set by the user which will be used to retrie=
ve config. There is only one firmware device so we can consider it systemwi=
de. Please let me know if you think of a better way of handling it.
>=20
> > +
> > +static ssize_t feature_config_id_show(struct device *device,
> > +				      struct device_attribute *attr,
> > +				      char *buf)
> > +{
> > +	return sysfs_emit(buf, "%d\n", atomic_read(&feature_conf_id)); }
> > +
> > +static ssize_t feature_config_id_store(struct device *device,
> > +				       struct device_attribute *attr,
> > +				       const char *buf, size_t count) {
> > +	u32 config_id;
> > +	int ret;
> > +
> > +	if (!buf)
> > +		return -EINVAL;
>=20
> How can there ever be a NULL buffer?
>=20
> No need to check for impossible things.
Will update in next version.

Thanks,
Ronak
>=20
> thanks,
>=20
> greg k-h
