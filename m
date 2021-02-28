Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBEF327451
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 21:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhB1UIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 15:08:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:55766 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230167AbhB1UIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 15:08:05 -0500
IronPort-SDR: 0ggdj6rVea6U+aUCUmummPWbnzOktGNPV/SZ0dQFyyhyC1YiZ9XIgQySLuFXSwO3Z3M5mT0aJ3
 K1fWHEMMfGiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="185618577"
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="scan'208";a="185618577"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 12:07:24 -0800
IronPort-SDR: 5HC3zik/quD32H4ibWBQ4yKpyxV+op7mbsAS3fkEtDdSrJX7t2CuFWB76niUEmGp3ouIYpCkiO
 lDnuWH3Th+iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="scan'208";a="435168133"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2021 12:07:00 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 28 Feb 2021 12:06:47 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 28 Feb 2021 12:06:46 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sun, 28 Feb 2021 12:06:46 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sun, 28 Feb 2021 12:06:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZ6XENTOQF1h1S+Z3qKMYDsNNEg+shYhCHqxD1ntzwemI6MpvUA/su2iIoqBwYkft6d1nK5lI717ILupr/rytXZ1l1UtrNrdyvmSMIimPG5euXznTfSRM6VGIR60Cf6S+hUGHdPtivjW5kTvrZBsBIZ9CMNzhus0tdrHuJ0xqfrqznnxCVGGjf7xVbjom6e+JMMCc3DVUrfl2c2P5Fe+fR5GK/UkEFfMfXBbAduY8Qv0tHCAnVr1g7gkwDv3iFP1eiF4i+NaHOOyIco7vZlFXMdfoU+gfqcBJiKqd05a0VB3ZKdttRRH0m+O2H1P0oPZJf0qMrxkvxipu3ImsD2rlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DoCNthfRpF0HCpICpd2wOlTBxfby524mJTHw7+sduY=;
 b=ERV9Xt/CR0nvirf1E13B31Y56iojqc9GxWCDVuYcII4Dpq0njUyaLvIB84WVZHpY/HDvLWgImGC3EVpOIjyy+MQrmcZgf+46c9bI0XYWd2wq+8FlY/FykSmQdbNnjaCgWjwdVZWy4lu7WbxZghrIKd6aEv/lRtga3WkCz7bEGEmVYC0YrGR5IHeJnqndl2Xyf7q1CQQysxhlGCHwclbrdBP8UYK6slAgFH5NbmVFWQkY1yP9xllfS0b+8elS8F8DqIG+04lp4mSal/gcQPDTwiw1Km2yd33kUgxd6cpaVlLnZyglzfH5bwbV07OXeuQaCY1vFh4dW5J22d8Q6FbNtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DoCNthfRpF0HCpICpd2wOlTBxfby524mJTHw7+sduY=;
 b=Y0Mv/1WR68yqc3AjwZnqrgd8JhX6HIBSZLUhrFsOXs6O708MWm8WCkwT4/aQsKS0iFo3E7BjByeWQSCHJGGZNcHbPxDDPkHty0ZNw9RNQFc9kXP8AwjiPOHKJr8G5d8HJ+TqXklUFWsPGTzF0MDoNO+a9z9OjMzKCe31yfp50L4=
Received: from SN6PR11MB3103.namprd11.prod.outlook.com (2603:10b6:805:d7::13)
 by SA2PR11MB5116.namprd11.prod.outlook.com (2603:10b6:806:fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Sun, 28 Feb
 2021 20:06:44 +0000
Received: from SN6PR11MB3103.namprd11.prod.outlook.com
 ([fe80::3918:f9f7:3be9:8357]) by SN6PR11MB3103.namprd11.prod.outlook.com
 ([fe80::3918:f9f7:3be9:8357%3]) with mapi id 15.20.3890.028; Sun, 28 Feb 2021
 20:06:44 +0000
From:   "Chen, Mike Ximing" <mike.ximing.chen@intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johan Hovold <johan@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH 2/7] USB: serial: xr: use a table for device-specific
 settings
Thread-Topic: [PATCH 2/7] USB: serial: xr: use a table for device-specific
 settings
Thread-Index: AQHXDEOYbtWRQarFBk+AqpuOf7CZt6pt/lFw
Date:   Sun, 28 Feb 2021 20:06:44 +0000
Message-ID: <SN6PR11MB31032B4182769288DC5F5A0ED99B9@SN6PR11MB3103.namprd11.prod.outlook.com>
References: <cover.1614345081.git.mchehab+huawei@kernel.org>
 <7277c90d546f63b9ca69e6381a2f342e7054befd.1614345081.git.mchehab+huawei@kernel.org>
In-Reply-To: <7277c90d546f63b9ca69e6381a2f342e7054befd.1614345081.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [69.141.163.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be964cb4-ef8d-45a4-ddc7-08d8dc245ef3
x-ms-traffictypediagnostic: SA2PR11MB5116:
x-microsoft-antispam-prvs: <SA2PR11MB5116D2CBBDA8C1CBBAEFAD85D99B9@SA2PR11MB5116.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qvitt3VXwA297reciCv7S5nyJNIIc3XE4mn258MKekgN5DM00fu4OgjXUq//5lVtVFHdrgmleZuq/2lzZDFFMfky00mPsqtBBCcuwg0uZ9gJ8aui39mcP8ZjR0Zc2DV7Scl3OEpK/47iboV13lAWWn1paKtPECCWfjr+uj3l+lbC6e+Hst/YUUWFmpNzB9aE/i0XvHWF3eWfKg0Nm5MiGys8IRTBjelsl+VCtGdrCl6OqmGqisMT3Y6RFrOsawJ5B7q5QH8MdwSMZ/YBkZ7lsMeqGd32OFm6pwt+vvhfNvbq0p/k7RJvrlDEJRXIyAUGwvgUBixup8YZeFOrrQ2YQVlQ0SbntgzsiZhuWV6HScuFueAZtqTTWwbTalLt4BdKvAjQJQmEQVR9c3RY109L9MtnMl+QELHa/KLTvXEuuRlHpKRTBXkR34STiB0y0yxBMN6Rd2850o00gOcCFxkExkZSAamtP99Icrd5j+cpkOovP6ih4f14SZOZDRNhSfaTNH0Zuzs8pjhbOS5hrqkpcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3103.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(136003)(346002)(376002)(71200400001)(83380400001)(2906002)(186003)(6506007)(7696005)(9686003)(8676002)(66476007)(5660300002)(110136005)(66446008)(76116006)(64756008)(33656002)(54906003)(66946007)(316002)(55016002)(66556008)(478600001)(52536014)(4326008)(26005)(86362001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YDIcteFcg/coPUdXsEACVoafGbjbKdZRStq8JUWvIYEEtN+FgUFXadlsYi1n?=
 =?us-ascii?Q?C4hgO3u2932XtIzXSvNXiiNukrTCbK5cvixvdGYDHYVGms4Z7V3w5apx0DwC?=
 =?us-ascii?Q?waD0NHv/uSLGwTeXwQ1Hwz4YWk4lryH24fVkxgxoGe2xuDQmDxJYBKLf0HLP?=
 =?us-ascii?Q?jT7eJQTan8jYjSsdxqzgm7QAqTbnvfEmrMf//+tS7Q7EJzlSQmDROa9xAURY?=
 =?us-ascii?Q?4Z640/bkVWfyhqpzSJSYyNN1pSmFwvH2rPcubV+O3tXMc59u2f16Z+xfAzpg?=
 =?us-ascii?Q?peMEBd89eS97Pzpm4QIUau85a8k5yujb1mkIUfggqJeyQf+f8cUXFaf/HBX5?=
 =?us-ascii?Q?rX/rk/RtShUUz4jEjeh9glEPhNri2gUBwZbaQXA2vfdzmXFaHO4E3iKmYpa0?=
 =?us-ascii?Q?uHxMtsk8grq1+VpBparW/HN+wf5NXjB2KzdbfqUKMyEtFEqHWaWuDTHHuGcK?=
 =?us-ascii?Q?JiynFD1QeiSkrBKXglMJpbUFiRKqiMtAH3SKhjN32/3ZnjJlByuVVYn1FOi0?=
 =?us-ascii?Q?8KBJKyWCBvQSdiXXvfEYnTlGJz8xYHAbp9BIxJ2c48z0wmgQcq/xpfZzUBsu?=
 =?us-ascii?Q?o52X0CDzcrjFgR4vahudKGhut7guQBgAR9y0keIenFP5vGwxoosK6QQkZypj?=
 =?us-ascii?Q?fgL3oUcoaFu80hq0/ImCdZG/zGJbXeVAYxlbE/wVJHyto1if53wOtqr8U815?=
 =?us-ascii?Q?2g6QKv0pYDOypI+YzkS56800Jn4nVkiCS+6RuDaSgXgjRwM5FQga7LYDhv/1?=
 =?us-ascii?Q?3/fXvWjuwosibq2vM/fwoWCXf9fyPoKK6lA6utajjbjL3G6dgzz61w2ccwI2?=
 =?us-ascii?Q?vncg6D/uSWNMFD0n+ploBAK6xqSFCCGVjNTD2CjVKGV6EY8IVa519r2/uIvG?=
 =?us-ascii?Q?pj2UdrwtcS++/nrTpjkyipyPA/NXL493lOcU+rw/c2Sf5mNjh2koJa1FufmH?=
 =?us-ascii?Q?PiJnN5Gt1q05N8Zks7d19V7OEjtcLt097bk9SJj34rGFc81cyvUCtwQp2+ge?=
 =?us-ascii?Q?Qv20mpp/EgN+pOUHsmV5/7dvhbhPHqhY2+tkp579atRaTLRZ1EjKD07a8jo6?=
 =?us-ascii?Q?mQ4b9AYnGMl8uw2HWns5tYuFuwjk53lb9+aGOQsMZP/BNRd63l+Z/nl9pwlV?=
 =?us-ascii?Q?5/h5tnI3fZw6VdTsinbsBG6u/svI3xR2v4Ke0yF5/hoboqMK2rgwGT7OmE4P?=
 =?us-ascii?Q?zATx4e86DVZ8HcRe+HPWpCG6eWMCfs2BzpluxfVDAWwVV7jbI+NVthYWsH2U?=
 =?us-ascii?Q?Ehq3wxZiJlfTIk3eqnmqBFvTbpsqUm/s5IpNlYVr9Prk4XGKtrp9TcuO34O4?=
 =?us-ascii?Q?YuW2uqDyWH1YUSsESP5BoWA4?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3103.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be964cb4-ef8d-45a4-ddc7-08d8dc245ef3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2021 20:06:44.2109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUqYbGPb+KCNKRi9e35XYgb45A4xU89AjVqBDUs3ara9xcOie3CbBEgc8DPZYranm8IuScfWJvdJ9/hCAUZ0+MipXuaQ8nxBCUAN7RDM+LE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5116
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mauro Carvalho Chehab <mchehab@kernel.org> On Behalf Of Mauro
> Carvalho Chehab
>=20
>  static int xr_probe(struct usb_serial *serial, const struct usb_device_i=
d *id)
>  {
> +	struct xr_port_private *port_priv;
> +
>  	/* Don't bind to control interface */
>  	if (serial->interface->cur_altsetting->desc.bInterfaceNumber =3D=3D 0)
>  		return -ENODEV;
>=20
> +	port_priv =3D kzalloc(sizeof(*port_priv), GFP_KERNEL);
> +	if (!port_priv)
> +		return -ENOMEM;
> +
> +	port_priv->model =3D id->driver_info;
> +
> +	usb_set_serial_data(serial, port_priv);
> +
>  	return 0;
>  }
>=20
> +static void xr_disconnect(struct usb_serial *serial)
> +{
> +	struct xr_port_private *port_priv =3D usb_get_serial_data(serial);
> +
> +	kfree(port_priv);
> +	usb_set_serial_data(serial, 0);

Probably a nitpick, but shouldn't usb_set_serral_data() be called before kf=
ree()?

> +}
> +
>  static const struct usb_device_id id_table[] =3D {
> -	{ USB_DEVICE(0x04e2, 0x1410) }, /* XR21V141X */
> +	{ USB_DEVICE(0x04e2, 0x1410), .driver_info =3D XR21V141X},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(usb, id_table);
> @@ -566,6 +640,7 @@ static struct usb_serial_driver xr_device =3D {
>  	.id_table		=3D id_table,
>  	.num_ports		=3D 1,
>  	.probe			=3D xr_probe,
> +	.disconnect		=3D xr_disconnect,
>  	.open			=3D xr_open,
>  	.close			=3D xr_close,
>  	.break_ctl		=3D xr_break_ctl,
> --
> 2.29.2

