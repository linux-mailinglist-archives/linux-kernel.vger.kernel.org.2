Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261A0393DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 09:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhE1H2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 03:28:23 -0400
Received: from mail-vi1eur05on2045.outbound.protection.outlook.com ([40.107.21.45]:58337
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234430AbhE1H2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 03:28:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SG+/h7St17FOCQORnBfbw84JuRjZwCLvAOzY3o4L2Vd9beFOyuz2A81RfWbbQUQ2hrtP0NpYfd/DPp9n1klSSZR9DO1Dd3XOFBA7IBy4BOZc4y4akpQenoKn0cDcqJIvge0ByPu+JbyOwMJAZoJ12ITFnb8iXKMU6FjWvbYKxJeWlA+sjlbpHIKh10IGKJyQ0nfhhrvy8dGqHkU8gT3aAg/tCXtynA4k10buFPpBbfaJN5AWTpZh4it/4T7pGKY3a46wB3AAEDp/TIYJvU42h0AAPMEUgPqb4iCa853E1IXtykMyJ49hRqCUpuVXUE3Cn2avmlWz0Euj9ErCn3AMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc3RlqGvOh+teo1xjYARWIpAebKiAOud11EBQKjarzI=;
 b=dqoSQjTqkYSGRIMTUcuBgsXSSYnK7fdeo3uKra8Z2qveQKeJSQPu+9enJrUJdW3Z3dMyjnLH3Cw/OvXUX+AuX3H7oJAQWfEPgzO+VxdK2koJtKt+jgkXUkmEeOZVuzmXnVkYQoOcKhUyhoYpt18ogfuAafNaoD/2ihhM9ljqaAlFLOXJCmSJx4lURl7enL3Nybq7fJrpsTbTmoxqT2Q84ztjuSGuhnVWmifSEk9+M+1zZEQs5d06qi9YrQPu/L0zT/n+tcDOq8jxX+218yPgx6G5o2SOnz4OhouEoQ8I9OJ4PWd3mih713t5Wk9Gx/fkNs+MyImM/P5YVNu2mB8ucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc3RlqGvOh+teo1xjYARWIpAebKiAOud11EBQKjarzI=;
 b=L32LVHF7U1j7UqAftpF4smtOzzr5GNHAWwtdGFPBsj3uJZNPdIicBvXU9KncTOtlwoglVTf2WH+efib8qNXYjMfzCP7K/CF5Bx2dtJ7sYoEIbavjshktLttntc8XgD9lzXRWnT4s+Zs9i8Efd+A/lWHDy2Bmmj8T7JtzRA43gGg=
Received: from VI1PR04MB5935.eurprd04.prod.outlook.com (2603:10a6:803:e9::17)
 by VI1PR0402MB2735.eurprd04.prod.outlook.com (2603:10a6:800:b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 28 May
 2021 07:26:44 +0000
Received: from VI1PR04MB5935.eurprd04.prod.outlook.com
 ([fe80::453c:f24d:af8e:f194]) by VI1PR04MB5935.eurprd04.prod.outlook.com
 ([fe80::453c:f24d:af8e:f194%7]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 07:26:43 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] usb: typec: mux: Remove requirement for the
 "orientation-switch" device property
Thread-Topic: [PATCH 2/2] usb: typec: mux: Remove requirement for the
 "orientation-switch" device property
Thread-Index: AQHXUkTF1Hli5+/RLUyh4hA8exUVWqr4dZKQ
Date:   Fri, 28 May 2021 07:26:43 +0000
Message-ID: <VI1PR04MB59350F5BC9129F9E0B21773889229@VI1PR04MB5935.eurprd04.prod.outlook.com>
References: <20210526153548.61276-1-heikki.krogerus@linux.intel.com>
 <20210526153548.61276-3-heikki.krogerus@linux.intel.com>
In-Reply-To: <20210526153548.61276-3-heikki.krogerus@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49580206-5412-42c0-7c19-08d921a9f1bf
x-ms-traffictypediagnostic: VI1PR0402MB2735:
x-microsoft-antispam-prvs: <VI1PR0402MB2735144352C85F86980ECF6589229@VI1PR0402MB2735.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p0qd76e5P4Yw+VyE5d2uRr9P4Y+T0NKzJ/rAI+W6XGCcAUOfwAXLhk8fOOO/57iR3aasfNFY9DkfipFOLne9xvmkft+9R85+qQskUTEqM+KNpFA+xdN6Na++2lchIEmXn7vnSK15iqQqtDyQaDQ3s7uHvT7sk0+CQam+tjf8g5BFUCLm9FXdwqqc+2Xm9ZfiyfouoltynMHPVtRHSIAvDTJrdB+fFTkefFMfF8VLKPnZQpweTJ8LCANhSoz/OdYdzioqaz+uhf1xl1rVidOOBRk/gYJa7mueH4d0fQq4RY71C4MBrAUF44/byump0NCWgJdeksioSnBsmpOllY7pH/UykOqr1m6D2zlr8ClxiWZpA3usbaawk8qVVlZ2sPXh1QHVeKs7n5AnaFMpsL/HAB8kQZ61uVs7bVAVyD3/dcWgD2n7xLCQ9qzBMyDXJ0t/gg0elL3dY00TODPrGfq2nwJHD1NRkHP8EvrZ6+9kEfR1yEnMyEMSkdFhT06ehKw4HgPWSpu5old1fM2eqhc+L38aAvHzkie/fTpYZtXwVZuOGacKaz5N0F3IvsU1fvUh9AKTzt/jRd13LcJpCMTmz8rTHdosJRkV5he+N4YYotA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5935.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(64756008)(6506007)(53546011)(26005)(7696005)(86362001)(44832011)(4326008)(66446008)(71200400001)(83380400001)(66556008)(9686003)(38100700002)(55016002)(2906002)(5660300002)(186003)(52536014)(33656002)(316002)(66476007)(122000001)(478600001)(8676002)(8936002)(54906003)(110136005)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Af5mwDVvdZM5GxZsVShlLbW7tT6l9CyHTBamoqKJPOHtZ+FPhEeixkJK1Pop?=
 =?us-ascii?Q?zc5XsuFpFl/BXx1MnSf5eCDz9PW8iSs97V23nxTbLqkvAhmWFQaH71npZkxe?=
 =?us-ascii?Q?/ic96PESUGYNhvKJLd8pyk32JnLGW5cc4LiiIn77AZvtkBeQFRwLiteBfgSX?=
 =?us-ascii?Q?vHmK/lTMp1w9pRoDdxkYi2dVN2fwhBaq7dzZnfjGrTn4dsztNvBps+74afLX?=
 =?us-ascii?Q?M5FCux3KREvyiyd6Aix3dpYiBkrOXd5d/iu8mXkfp740P2QDLeXJVGH8cu89?=
 =?us-ascii?Q?xA8zoty8t4ZJv0n7QQdpZLlLyQbRUFQ2BnH5G/wR7+I+BEYVd3+WyIWvDNtT?=
 =?us-ascii?Q?qEJPeKAuZ604xoRH13BafcFXyzv56sjpBJ1/xZYGvrsiBN8uUEkwbJU2glm0?=
 =?us-ascii?Q?5kYWbvTJAwWD9u/myY5PCHiDzqhd00t5wHADVidwFzH+rffYfr6lTVfQK0p3?=
 =?us-ascii?Q?utVcz2DTIMB4oe1i6aladUcHwDT+pMvmDakOtZp69eniGDEWRy691bavrfzo?=
 =?us-ascii?Q?YVX2Qhk7GFSvg7JtMWT9a8j9HCxBAmdfhAaDKMf8wlR6p7P+Qj6BYlL90jtM?=
 =?us-ascii?Q?n2HOGvBkID6xXHbpLqYcCREfWjyJQNDy0TB+Jz7q2WGe8ztMGQFCp+30MKhh?=
 =?us-ascii?Q?kcyrksJnfZlyMFJIAvdmCZPgEx2gIL7UdC2UBpnLy7xdcss/cErGPHARAg3l?=
 =?us-ascii?Q?+v+iLCecfwPOsCh7bF0zad4Q9yPmbfkvRs9al6dcrlPL8PmCXD1CWg32Tk89?=
 =?us-ascii?Q?ft1BrBgvsPHaTdy4VBASvwq1pv1b2vCRrbIRTWoF9i2bFAQ045/nK/gHi3Dy?=
 =?us-ascii?Q?L1GjVPptwKkNwsa/2K35SkoMVtJYtMeoIXEtjXgbFWy2wwMHkTU45Z1gNom4?=
 =?us-ascii?Q?SSrV3dyjHBdUcpBzfJVm5Jt2SD0vRBJlonid4QErCNja3qv10bUmA6SYE/+X?=
 =?us-ascii?Q?3LbcqXkMiErjIv90a+CNYRWx4kKvWtbe6WmD3sjDAE9o8l/UpXHSvMsAxkwc?=
 =?us-ascii?Q?uNMgppnAONvIsD91iDEwYl+mZdPw+IAEUSzQq0em/mTW4pw+R61ZzatXqpma?=
 =?us-ascii?Q?7gKzUPoDMwY+rjIzOvJ49vxeDwJAhlhBsmjWIFWKRNdTrZEpQcoyq4AC2MkK?=
 =?us-ascii?Q?ri6hrTt+W/nIvXLBlECWIlStqwec9tAS35PBbPx9cnsJ5riNiR2lvuTY/cZ8?=
 =?us-ascii?Q?ZNntRg3jhQISP5p+eJANDYa4UOeQNCjPB/7y+dZLQRmewRXn4QeNKeYhTuGH?=
 =?us-ascii?Q?4DDuwgiVYfjfBvfqOAkVp8b0s3NubV8v5YjK+hR9+hCOUsbNloZ9OE2I7oPB?=
 =?us-ascii?Q?ASFhwkh9+L2/COxXj3k6Jyh3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5935.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49580206-5412-42c0-7c19-08d921a9f1bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 07:26:43.7264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1z2kWMvitHm/u9D4t8Mzr5GQvOCpJe064qZJhkcYkxzofF9hO5ZtlHPb6OvCdQhF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2735
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Wednesday, May 26, 2021 11:36 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Hans de Goede
> <hdegoede@redhat.com>; Jun Li <jun.li@nxp.com>
> Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 2/2] usb: typec: mux: Remove requirement for the
> "orientation-switch" device property
>=20
> The additional boolean device property "orientation-switch"
> is not needed when the connection is described with device graph, so remo=
ving
> the check and the requirement for it.
>=20
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/mux.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c index
> e40a555724fb6..603f3e698cc0b 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -30,9 +30,6 @@ static void *typec_switch_match(struct fwnode_handle
> *fwnode, const char *id,  {
>  	struct device *dev;
>=20
> -	if (id && !fwnode_property_present(fwnode, id))
> -		return NULL;
> -

May this change the result of fwnode_connection_find_match()
if there are multiple remote-endpoint node?

After the 2 patches change, typec_switch_match() will never
return NULL, so

  17 static void *
  18 fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *co=
n_id,
  19                           void *data, devcon_match_fn_t match)
  20 {              =20
  21         struct fwnode_handle *node;
  22         struct fwnode_handle *ep;
  23         void *ret;
  24                        =20
  25         fwnode_graph_for_each_endpoint(fwnode, ep) {
  26                 node =3D fwnode_graph_get_remote_port_parent(ep);
  27                 if (!fwnode_device_is_available(node))
  28                         continue;
  29=20
  30                 ret =3D match(node, con_id, data);// ret can't be NULL=
;
  31                 fwnode_handle_put(node);=20
  32                 if (ret) {
							 /*
							  * So loop will go to here and stop
							  * checking next ep, even this ep
							  * actually is not for typec_switch
							  */
  33                         fwnode_handle_put(ep);
  34                         return ret;
  35                 }
  36         }
  37         return NULL;
  38 }

fwnode_graph_devcon_match() Will return ERR_PTR(-EPROBE_DEFER)
even this ep's remote parent already probed but it's not for
typec_switch.

Li Jun

>  	dev =3D class_find_device(&typec_mux_class, NULL, fwnode,
>  				switch_fwnode_match);
>=20
> --
> 2.30.2

