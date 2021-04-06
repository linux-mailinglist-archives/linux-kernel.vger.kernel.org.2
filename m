Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D83354E60
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbhDFIR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:17:58 -0400
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com ([40.107.237.68]:60417
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232032AbhDFIRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:17:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mz/86Kimzh/HrLgdjE7fCQTJV20b7flu31ANSxA5LH1kzxAJWVk5DKY7l7JQ/gqFNzQbJiq/9v1VMsv6zXyPzuzSmSAenwm+oytUIjQdIDbzyVPAzbsOQjgcaqjbMMGeTzD2MR71yOUubYUrg//peqInFGnm9kDgPG2+995dhxd7pyhiWXBh19dQqzhJz9E6E4fXJE2Bv/guXacClRlMe7BQQKA3WEYaVfpqWFoZmSaJxdwBZKPwXZejl/dgLf05ppfYq+/9fgZY9SftdeZjHjqmEpT3Kdqp2R4YnMw/v1gNuWFg9DxgIE+TQck3Z33t2Mtlq8vJMe3UlueAl7kXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Foz4TuuCUhDKZnQ3rbTqcllMnG3kVsZqIgcQSLJKPd0=;
 b=balOkl5jn+LdSrwX73aWrzkvRUzRpci1TMhbplzMfr9rHTnSa6qKRwHXhDdUeSm/X9g65U8uP55ABuJ5SyJdTUrJj6v5P0PSlKPWG/7eHf4QKE9ucxcX0/0sf5BAKpoxlELuF/YwA0hg9q82vfeNg0uAkPiIo2H3rc/07bvqpPMi8zy+3CcwC2gKM2JujZq5qfkIMNIP7RlJZxlh0gWqHJYNNAHtpvjVqm5JUjoMkbdyaRejteHDcHRkvtzMcgmcgu8svFAW05UBILvUCOW+cqnSRdT0JqZPc0UmrqjfvHxfyijo68wUvssFwiopOWOvurettaWPGiEbzAuYME08ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Foz4TuuCUhDKZnQ3rbTqcllMnG3kVsZqIgcQSLJKPd0=;
 b=eDXJk89x+ozVDjQFDKs59jJcoD4J8speYcLETNS4CeL9zSSXUUiYy2sIchqr3n9Rw+hbGOegg0OCIqjOISD18M0/WcSFtJXPrfFWBuIEJyffsnqehAa2XZhaP30ggqEqBmxxRJZZBfj6+MgdZaqo7tz0LKIE+i54tYcTrOQvzVU=
Received: from DM6PR11MB4441.namprd11.prod.outlook.com (2603:10b6:5:200::11)
 by DM6PR11MB3595.namprd11.prod.outlook.com (2603:10b6:5:142::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Tue, 6 Apr
 2021 08:17:43 +0000
Received: from DM6PR11MB4441.namprd11.prod.outlook.com
 ([fe80::9400:9b03:a7b3:446b]) by DM6PR11MB4441.namprd11.prod.outlook.com
 ([fe80::9400:9b03:a7b3:446b%7]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 08:17:42 +0000
From:   Pho Tran <Pho.Tran@silabs.com>
To:     'Greg KH' <gregkh@linuxfoundation.org>,
        'Pho Tran' <photranvan0712@gmail.com>
CC:     "'johan@kernel.org'" <johan@kernel.org>,
        "'linux-usb@vger.kernel.org'" <linux-usb@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Tung Pham <Tung.Pham@silabs.com>,
        'Kernel test robot' <lkp@intel.com>
Subject: RE: [PATCH v7] USB: serial: cp210x: Add support for GPIOs on CP2108
Thread-Topic: [PATCH v7] USB: serial: cp210x: Add support for GPIOs on CP2108
Thread-Index: AQHXKpm+rbC2wNO7d0GjPcy5lZODOqqm8kwAgAArBNA=
Date:   Tue, 6 Apr 2021 08:17:42 +0000
Message-ID: <DM6PR11MB44414602F10C6C991A65D48CE3769@DM6PR11MB4441.namprd11.prod.outlook.com>
References: <20210406040238.1850-1-photranvan0712@gmail.com>
 <YGvuQlxyorJt+ErG@kroah.com>
In-Reply-To: <YGvuQlxyorJt+ErG@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=silabs.com;
x-originating-ip: [210.245.53.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 210bf933-45b5-4733-d9f2-08d8f8d473aa
x-ms-traffictypediagnostic: DM6PR11MB3595:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB359518E63A194C3CC656A068E3769@DM6PR11MB3595.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6sQYVERQc6l4Emq85g/LVSwwWAZHip0Ig3sRiEqq19k4nNpsvFZKV5BSyuy4LHfGYU1m8rX5sCbRW1NzAkS6Q0qm3PS+NjcgQhx58Mr4c3JUGNgKVsLYDCrASxYq/5mmSBjZe4PH3Y+HkmfEaRrQyGBZRLNyRcX+4iWc2S2XpmVo3TGonfnbFkIlw5qZ29iUkub1zL837SNfKCPIL3XhA9mJOvWMQOMVgMDN/Vmdt9W2wl6JfTKCjxHPJfgoP90be9pNt62J8xL34LWbf+ZWTicM/Ry/NIQc+rwhtSRTuLWA4LFK1IxxJoiUCNnJroZsmQ+YSiqwbumtw39n93FXCna7OEQ3sMCcNAi6nLeOaYrYGcxS7omA23VadwoNxpT5kKEOerFf3NIzzShPsY73wbxfwmnteBvzuVQ4r+6kXdQxday00sDBKZru4c0Oz24obTXIknIEZuKrF6FdnsLoElbeWKoftA5T8HL6o4kayClX0ZRhY3/iFCLAoDe8dQX+KAr3hIeIgGU/ofijYp+yjCSuuKg4HVZ1MEvkc0Qm5I1dQk84BsdNjOFNPLwxghC8c61hQW1fRyKpgY2aaiKobwAnEG5JcreW9MgTBi4p3P9J9y18yjhXc4FbfwnqsCGCErGvIuaWFIOaeWkUcNiHdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4441.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(39850400004)(346002)(376002)(8676002)(66476007)(86362001)(7696005)(38100700001)(64756008)(5660300002)(66556008)(53546011)(52536014)(4326008)(66946007)(6506007)(66446008)(9686003)(71200400001)(55016002)(26005)(478600001)(316002)(76116006)(8936002)(186003)(54906003)(110136005)(33656002)(83380400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6JTpOLScCJ4WDOdzrgY+of2+5gjpGqFaCzyhgg0FgjQ9jbajbtTr5x5ytxrL?=
 =?us-ascii?Q?c5WiJHrTlsEdecNY28L3gsMDjRbaWf18xaMf4KzsE0zglGmfEpsmA1EufoHA?=
 =?us-ascii?Q?sfAoNo1vE8PzV7spgVe4YROQ1DkoxjdEU6XmKKq4lHPc6SVoE7ntATp3fLzf?=
 =?us-ascii?Q?KzjxhfG7xzwGMIIWxmHAWLBAqfU7F69mHIp0fYEe8q93/IbMqQYsr9ZL5+TX?=
 =?us-ascii?Q?8pwCcbL0uqtMaB+4DQz3JWEErVSKrueUBRPmQSVEFuOxU2R8epyXmlXF06j3?=
 =?us-ascii?Q?mdWR21XoUos0Y8ykW8bGRxBAAW0MZDuIoudthYm+2HLPqit/XUS0kzuf+9If?=
 =?us-ascii?Q?gLsJOrR/sB1OeTAPAA3zwWaGUJoZ/td5i/8IwYpU+Y0fLe5du10VQmMitobB?=
 =?us-ascii?Q?BuyFyCj8dDRXrJrjmwspXYkpwfBuhUoo17sBKwgpZ/S+Sn8BOAiSlEbPpfuA?=
 =?us-ascii?Q?QdkpW+zZYV+/mitAv1FtTXzKJP4K+XLcUn1RgFBbF2kG1DirsjNwLalgTwMN?=
 =?us-ascii?Q?Nnr69wKsampNcdHfNUG8lc5yK4EsSAAWFSV0ydfxvN0xQjgkm8Yda5gnhMI7?=
 =?us-ascii?Q?LGQCjERxf6FagY6IZvPPd+4ncjvL4w7dZGkzq1T0AQ1ismGm3MobGbTEPg1v?=
 =?us-ascii?Q?ZAwm0i/+pIk19+HlQ+5vSCpK6vkX4x+FYlxQDevm1o2bog3j+9KEE7bx7y6b?=
 =?us-ascii?Q?5rDaENr6wAHCjXORblxr3VVhzgic3mFTZ3vefg/obqSPHlllwitbXVksE5QU?=
 =?us-ascii?Q?PYlHtgIrJK4ktkqtX9Rs0t37FPhMbXhGjKJTBeq8KFoxJp5SYsnRlqKeDV/T?=
 =?us-ascii?Q?SMbet0BP+/05hMGkMzEs24DmuF+kRD7+aBtlyMUYgeGGJ2Ousk6DfnBpz7sC?=
 =?us-ascii?Q?6malQOvk1GSHPDIOvujy/5h22VjHVSYIFLDrUcZ5HYstsqvKlFLInOX+KQEe?=
 =?us-ascii?Q?ty9dalc6R0QSY6/XmEtJtpWqICXixLlgBtd9kLjstmiaG003yUaOnGTMRUHR?=
 =?us-ascii?Q?EBJae11bvbWbnanOZ0CwabT76OZ2NVQnOcVB6QvpcIFPginKLDfJJUOYPJiF?=
 =?us-ascii?Q?WRm1Pc2Con0MdkRnuBIqbK0N00BCYuuCkWxBq2rs9MBsVm0ejbn+mfjKUGMy?=
 =?us-ascii?Q?3C8EQPUTggX32OZLJjGFLoem6eDby6tr8vJh5J7FmFJoqaEWB93H9pwpNMkn?=
 =?us-ascii?Q?jWJmyQ0EofzWiUhpfPMJAounyhSckpv7G9BwhlYDBJDmdBZWdkNVrV+Tn2r6?=
 =?us-ascii?Q?TENqRo6dwFiXbOdliJYbF7mhoOFq7kgEfJGqeYsxp4/EYjoWmN5FY0mfy19s?=
 =?us-ascii?Q?eic=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4441.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210bf933-45b5-4733-d9f2-08d8f8d473aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 08:17:42.7988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wo1VgBj3XGx8M9Gl+hlM7PAZCe9UqXFf7vsaxDSdnjbx4b9o5f9/cyketCjwfXMlvd3SVS/0tVZ2ObCqKogPXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3595
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg!
I am grateful for your promptly reply!
 Yesterday, I got the response from the kernel test robot with this message=
:=20
" If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>".=20
It's a reason why I added "Reported-by: kernel test robot <lkp@intel.com>"=
=20
to my new Patch.
Could you tell me what I need to do in the next step to submit this patch t=
o the kernel mainline?
Once again, Thank you a lot!

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Tuesday, April 6, 2021 12:15 PM
To: Pho Tran <photranvan0712@gmail.com>
Cc: johan@kernel.org; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.o=
rg; Hung Nguyen <Hung.Nguyen@silabs.com>; Tung Pham <Tung.Pham@silabs.com>;=
 Pho Tran <Pho.Tran@silabs.com>; Kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7] USB: serial: cp210x: Add support for GPIOs on CP210=
8

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.


On Tue, Apr 06, 2021 at 11:02:38AM +0700, Pho Tran wrote:
> From: Pho Tran <pho.tran@silabs.com>
>
> Similar to other CP210x devices, GPIO interfaces (gpiochip) should be=20
> supported for CP2108.
>
> CP2108 has 4 serial interfaces but only 1 set of GPIO pins are shared=20
> to all of those interfaces. So, just need to initialize GPIOs of=20
> CP2108 with only one interface (I use interface 0). It means just only=20
> 1 gpiochip device file will be created for CP2108.
>
> CP2108 has 16 GPIOs, So data types of several variables need to be is=20
> u16 instead of u8(in struct cp210x_serial_private). This doesn't=20
> affect other CP210x devices.
>
> Because CP2108 has 16 GPIO pins, the parameter passed by cp210x=20
> functions will be different from other CP210x devices. So need to=20
> check part number of the device to use correct data format  before=20
> sending commands to devices.
>
> Like CP2104, CP2108 have GPIO pins with configurable options.=20
> Therefore, should be mask all pins which are not in GPIO mode in=20
> cp2108_gpio_init() function.
>
> Fix build test WARNING reported by kernel test robot.
>
> Reported-by: Kernel test robot <lkp@intel.com>

The kernel test robot did not report this needed support :(

