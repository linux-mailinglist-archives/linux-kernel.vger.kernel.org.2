Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABCA395971
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhEaLJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:09:59 -0400
Received: from mail-eopbgr30076.outbound.protection.outlook.com ([40.107.3.76]:3142
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230518AbhEaLJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:09:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiNQXhfDJtGGyddfu7XM7gCRIk9HkJA4dWNVu+eseCK6MMZ4MxyJZvZ1ee/R8DaE9bQvD2wU/EqedzmmGdD9eQqnVAp3fgtUSAl9Zo+w3FYSyEwGzakTs7mvQZS0QyAoEJ3wm29xMMEZ97VGG137rj72sWfyr3U5VE2lZbIBr/mW2aHky4xR+Wh05Pz6P0JetJNmoDkYtYH+yPyaZ8CRClPUwe/32OEfHJwuauCoxzQbP1cH1OyT/eHXI7wMht5I11sCLaWJEhUsFOlKcMrk2ruwBbmPWj15h0O+FnjUwgy9gmKIXgCOH5fq2naySxFdhMp5DOVVK2E0H2vtQXVJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY1DjwMaUhneCE1Kj3cqttjXDfIa3KaTSRUS65XTHtQ=;
 b=RVFjRnxQa0jWJgzEV8fz/yyVsmmsyN4i3Uj5fQFIMelTBqsV8bCtIvUijMr99MMfMHTxFuBWz/SouCwEBLPkcaJf70use31qzGC8Z5PKZUNt/6vYbSpev8KcDAc3Hy1HVhIsUaWPKn/55N3ggf8ZCqq5bQH36LSEQu5rSEAaZPTtu1bhdwn/74uYcSv3/Ev8zfL4jxxGux40CbRv4FpADAnOQ/IBUyJyy71WhCWlYpXISaYUXzG4snJbtTQ+nBhy7kS3wmUgcbHePz71lMLGac25lPlE57navugUuiPbzLykk3x2nKm4V0/4ikNV9KWb4xxXumtTDg+MSL/KvkC7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY1DjwMaUhneCE1Kj3cqttjXDfIa3KaTSRUS65XTHtQ=;
 b=HDeNAfdLO58aRTSio3ra6DXp/83iOmi3QgfFsdk9qOBX1cUuKEgnI6m6v278v/gcUkvsGew8MuU5JhAMDbx5cKl6TL3i8P9RigryuTQyAjz6Ye3orP2JE2RGFpcaGhhVab5Ovzs2uYSax5JBe62vVWuB3uyoyLwwHWlgvU7+7w4=
Received: from VI1PR04MB5935.eurprd04.prod.outlook.com (2603:10a6:803:e9::17)
 by VI1PR0401MB2559.eurprd04.prod.outlook.com (2603:10a6:800:57::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Mon, 31 May
 2021 11:08:14 +0000
Received: from VI1PR04MB5935.eurprd04.prod.outlook.com
 ([fe80::453c:f24d:af8e:f194]) by VI1PR04MB5935.eurprd04.prod.outlook.com
 ([fe80::453c:f24d:af8e:f194%7]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 11:08:14 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] usb: typec: mux: Remove requirement for the
 "orientation-switch" device property
Thread-Topic: [PATCH 2/2] usb: typec: mux: Remove requirement for the
 "orientation-switch" device property
Thread-Index: AQHXUkTF1Hli5+/RLUyh4hA8exUVWqr4dZKQgATB44CAAAkYAIAACCYAgAArbUA=
Date:   Mon, 31 May 2021 11:08:14 +0000
Message-ID: <VI1PR04MB5935F74E297A467D846AADEC893F9@VI1PR04MB5935.eurprd04.prod.outlook.com>
References: <20210526153548.61276-1-heikki.krogerus@linux.intel.com>
 <20210526153548.61276-3-heikki.krogerus@linux.intel.com>
 <VI1PR04MB59350F5BC9129F9E0B21773889229@VI1PR04MB5935.eurprd04.prod.outlook.com>
 <YLSPLxfyavO+AkLY@kuha.fi.intel.com> <YLSW0IoHdnzRSzUW@kuha.fi.intel.com>
 <YLSdptmScGo5TJ1D@kuha.fi.intel.com>
In-Reply-To: <YLSdptmScGo5TJ1D@kuha.fi.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c595cc4a-2216-443d-5996-08d9242462d6
x-ms-traffictypediagnostic: VI1PR0401MB2559:
x-microsoft-antispam-prvs: <VI1PR0401MB25595A4CDF81156DE6CC21FD893F9@VI1PR0401MB2559.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R4gv3e2IoiMswJG8tdKej7q1k12kWHtF5kvmCTz/FImM+EiXPBrdA9S2U6GBBPjgPKryyRMmjjSxqJ505GwpGS9tF3GSFZfjeufgG+h6n4+xjVURx7CjvpMhlZJwVA/X89jJV1wa7bgHzzD69yJh6nDbsLpEtDsFV74hP7q5nfu7Q7lzD78N4p+XpFrDI/z8vzP57uaVHh+Ybg4Vakaaqbv2Xq1uXv077NC/rZjiBZ9kEy856h57SJmeI3t9q73nwVzdbNqRtOK7J22ygPIR0NqspXKObARTwvzpJWqHw5TSEI7y/4+m5Bp6Yg9xE//Wk3qrCrduEu2cn03p6WCOafqYRvLqxVs4whxOHTgkyk72FERykH8KEWmmoyDie9ZjVmHJpoIvwmXLP07g1LlPo6bP2GQpdgpPm5yvC4ygDiS2bcV+OjdTSOXKYqP4n3LNWzFscaT34oMkxf74/jy/c7RFeVaR8gjZ0eCfhYn8MFRmnNKrhWcAsFXjUXiad16yfeur/H8Nh96cgup/jyAaWohostZRX2qNwVPaseWMDKBYJjUH6PqmhcUP1qK9mUm7EDwpcXkqIppvDlwi9Wmi8sZivoBjmFeCEAHVfl87o/4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5935.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39850400004)(136003)(346002)(366004)(9686003)(66946007)(71200400001)(7696005)(5660300002)(316002)(122000001)(66556008)(110136005)(64756008)(33656002)(76116006)(44832011)(66446008)(66476007)(86362001)(26005)(4326008)(52536014)(83380400001)(478600001)(38100700002)(2906002)(8936002)(55016002)(54906003)(186003)(8676002)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XORuZ7tgCF0a+2iFoxjEd9+QTNDau+CqP9MYFmFWBTX2s/Bs1cboAqMORld6?=
 =?us-ascii?Q?Dtxx6L0NeWp6uNcEPtiQu3RwIlt4RrYhMx0xm2ZEmdNQuj76Z0P0SFYcQ7ue?=
 =?us-ascii?Q?MI0xbwD0+PRqGN1FKpr3gIjvEGz9Zd5vt5vNUuIa44JzYeDttvWNm8KG35VC?=
 =?us-ascii?Q?iMZvXkDu5H9/ZXWQwzvtr/DwhNCXKIBzkXIqIazmqxS4MzTa6wMXCJL+Z32U?=
 =?us-ascii?Q?GLbn4osq8twLmsJqrqWGUdwDwIRsCZ9jggnhnN7IlyjFzORN7ZNVPuUMa6li?=
 =?us-ascii?Q?SOqF7f6+9xA6cRqrEYAeGf6/Kxa+IYVMJeHtMrQlFzA4qjz1L3ItDhY5cTuW?=
 =?us-ascii?Q?3ip11RAGL6wqtxYnHCySuPpo6rLF40aM0SDCFaCw8M0nP3rdscJ5vRrivHuO?=
 =?us-ascii?Q?GnSxBSr9ea9z8rkM4pWUF9VbaDZ2ykV7mnzZcJ3WzIkct5JKsrB6q5aqymDa?=
 =?us-ascii?Q?LMhpYcp2cRleHrayzIvxt9Gx7Lb435Q+cQbIsUT7cKFMHod13Z6HBhKbtgUz?=
 =?us-ascii?Q?DIOTceNoE7XsyLDaR3SmOBnCWL1OBAwCumAqdhwGEzekFnlfypl7hDQ0twHW?=
 =?us-ascii?Q?J0tVt9NfkV4QVr+QPiu6+Q/4HjfAV/5SeukV/o+BT7pb50SC6Vdl2Av1+W3+?=
 =?us-ascii?Q?RJ2JrLkQm/V3z1Hi+QH0acuFsRqnbsYBiZhJEsewkUNcz3WemfM9zNC83vo7?=
 =?us-ascii?Q?hf9fJMLeEh71Asg0689Kc7k2yZULjBxBoyTTQzilmcbjkyxNYhg/UpH6+wQx?=
 =?us-ascii?Q?ANoFIPl+xQt/0o6cGni2B41vvc5pWI74u+S6SWYH1VBeYSxp/xpBDXO0evFi?=
 =?us-ascii?Q?oEjuVQOSMl8WLq8y+YWTpGGHN5Rjs3IHafEf24ZTGhWJ1emR5INxA2NqUsz8?=
 =?us-ascii?Q?Whm43PTicnB/IT9/tl7hDFSYbi9Jkm2jfPnAVNblS/eiz7jqh9e9VnLZX7vb?=
 =?us-ascii?Q?pdMkpGVR1qtsATsnTeYFzbPUtv+/hyOSFnNtDkOnc2HLmPfnf0MAQo8aHRA+?=
 =?us-ascii?Q?b55ngZ/JM2JrHxRtpEDizAss3uFBJR9KtT9dHLMxqMvCegBzxWcX8xrCrovJ?=
 =?us-ascii?Q?1nV9HGXpx92vJJc9/SJ862mT/e0mKaJFOQ1MbVdnh+oTC4BgsoR4MngrQei1?=
 =?us-ascii?Q?KS4V7McAEf5+bVohquJPQu0Xdn4HYr5TFoPbTV41ceO/FvgHDC4bzQ4IOLCH?=
 =?us-ascii?Q?9XBn3l0XQ6IKrAUqZVxbd9QSZKN2+0yYWaoWCfITWOnHAbS9KFz4el9J/7jq?=
 =?us-ascii?Q?MpOT+jZihKbmH1csenYszSySpHefiU7X1JFkyADXvAUSILiMj2h597SLZARf?=
 =?us-ascii?Q?71ZqLNtdEmQG9VDvIqDl0crP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5935.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c595cc4a-2216-443d-5996-08d9242462d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 11:08:14.4323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G949ueXocSYBjcIdEPEjiZA6QRAhu/WgRZz38oO5+DB60COGS2JqCkAnGRRh3pW1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2559
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Monday, May 31, 2021 4:26 PM
> To: Jun Li <jun.li@nxp.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>
> Cc: Hans de Goede <hdegoede@redhat.com>; linux-usb@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] usb: typec: mux: Remove requirement for the
> "orientation-switch" device property
>=20
> On Mon, May 31, 2021 at 10:57:04AM +0300, Heikki Krogerus wrote:
> > On Mon, May 31, 2021 at 10:24:35AM +0300, Heikki Krogerus wrote:
> > > On Fri, May 28, 2021 at 07:26:43AM +0000, Jun Li wrote:
> > > > Hi,
> > > > > -----Original Message-----
> > > > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > Sent: Wednesday, May 26, 2021 11:36 PM
> > > > > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Hans de
> > > > > Goede <hdegoede@redhat.com>; Jun Li <jun.li@nxp.com>
> > > > > Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > > Subject: [PATCH 2/2] usb: typec: mux: Remove requirement for the
> > > > > "orientation-switch" device property
> > > > >
> > > > > The additional boolean device property "orientation-switch"
> > > > > is not needed when the connection is described with device
> > > > > graph, so removing the check and the requirement for it.
> > > > >
> > > > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > ---
> > > > >  drivers/usb/typec/mux.c | 3 ---
> > > > >  1 file changed, 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> > > > > index e40a555724fb6..603f3e698cc0b 100644
> > > > > --- a/drivers/usb/typec/mux.c
> > > > > +++ b/drivers/usb/typec/mux.c
> > > > > @@ -30,9 +30,6 @@ static void *typec_switch_match(struct
> > > > > fwnode_handle *fwnode, const char *id,  {
> > > > >  	struct device *dev;
> > > > >
> > > > > -	if (id && !fwnode_property_present(fwnode, id))
> > > > > -		return NULL;
> > > > > -
> > > >
> > > > May this change the result of fwnode_connection_find_match() if
> > > > there are multiple remote-endpoint node?
> > > >
> > > > After the 2 patches change, typec_switch_match() will never return
> > > > NULL, so
> > > >
> > > >   17 static void *
> > > >   18 fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const
> char *con_id,
> > > >   19                           void *data, devcon_match_fn_t match)
> > > >   20 {
> > > >   21         struct fwnode_handle *node;
> > > >   22         struct fwnode_handle *ep;
> > > >   23         void *ret;
> > > >   24
> > > >   25         fwnode_graph_for_each_endpoint(fwnode, ep) {
> > > >   26                 node =3D fwnode_graph_get_remote_port_parent(e=
p);
> > > >   27                 if (!fwnode_device_is_available(node))
> > > >   28                         continue;
> > > >   29
> > > >   30                 ret =3D match(node, con_id, data);// ret can't=
 be
> NULL;
> > > >   31                 fwnode_handle_put(node);
> > > >   32                 if (ret) {
> > > > 							 /*
> > > > 							  * So loop will go to here and stop
> > > > 							  * checking next ep, even this ep
> > > > 							  * actually is not for typec_switch
> > > > 							  */
> > > >   33                         fwnode_handle_put(ep);
> > > >   34                         return ret;
> > > >   35                 }
> > > >   36         }
> > > >   37         return NULL;
> > > >   38 }
> > > >
> > > > fwnode_graph_devcon_match() Will return ERR_PTR(-EPROBE_DEFER)
> > > > even this ep's remote parent already probed but it's not for
> > > > typec_switch.
> > >
> > > You are correct. With device graph I guess we really always need the
> > > extra device property after all.
> > >
> > > So let's forget about this one.
> >
> > Oh no. This patch just landed into Greg's usb-next. I'll prepare the
> > revert. I'm sorry about this.
>=20
> Actually, if we always need that extra (boolean) device property to ident=
ify
> the device class when OF graph is used,=20

Looks like yes, as we need a way to know if the current fwnode
is for the target device we are looking for, to return probe
defer correctly.

> shouldn't we just do that always
> in fwnode_graph_devcon_match()?

This depends on if we want to limit this to be a boolean property
(to mark this is the target fwnode), or make it to be more generic
so user can define it in its ->match().

Now there are only 2 users of it, role switch and typec mux, both work
as a boolean property for con_id.

Li Jun
>=20
> diff --git a/drivers/base/property.c b/drivers/base/property.c index
> 1421e9548857b..238da64375bb1 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1263,6 +1263,13 @@ fwnode_graph_devcon_match(struct fwnode_handle
> *fwnode, const char *con_id,
>                 if (!fwnode_device_is_available(node))
>                         continue;
>=20
> +               /*
> +                * With device graph @con_id is expected to be the name o=
f
> the
> +                * "device class" of the fwnode.
> +                */
> +               if (con_id && !fwnode_property_present(node, con_id))
> +                       continue;
> +
>                 ret =3D match(node, con_id, data);
>                 fwnode_handle_put(node);
>                 if (ret) {
>=20
> thanks,
>=20
> --
> heikki
