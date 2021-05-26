Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995FF392290
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhEZWMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:12:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:5946 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhEZWMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:12:46 -0400
IronPort-SDR: qvMUR81qz/blXHjC9i7F5U2cUTC/fbGgbRwyyh94wxUF6lQAm4kVLfzOhThVX6YDvfZyipZ4fY
 Nw4iQcIA1p1A==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="223786573"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="223786573"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 15:11:11 -0700
IronPort-SDR: 30XZLlu8DuKecQ47qi0RyY8zYmdio8OvPzzcn4EJR3BlFbcGSiQV800aSXcet5FoD3VmHAQo8X
 IVd0UDCGuwmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="615131556"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 26 May 2021 15:11:10 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 26 May 2021 15:11:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 26 May 2021 15:11:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 26 May 2021 15:11:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD3GeuUEJ+QSPigGXY4y3J40wpX0FRLp21VSVSRfYkwDozqTt5s4YeaG+W0hkVP05cHpSjdN9/0pqz7yGAbvT5yKMFKXHg6r4HL8foMWXVMlmF9UR3bARZLqln5+YQp17S21jcNrBvA8tSmZ+F8MHaZxScVzSjkAHCIkhEvY2W6eg5aN/9ZNe35ZyZ0SuqB2TGFfx1Q2pGZ6F+LmNMqvVWooYExpwRG/w5LnzAEw+eZVKnj8WQTbzjfcT3CjMlGo6n9rkdfsO8C7tmRGu7l+lmJDTCq+nVT7IZPGfDYfYgeg8mUVTfFh6TShs39aOTxpMqzEGlvM6G4x0PkjT9Bgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoOyeDyHVnZ5EqvNB6er2I0hQoxjiiLs4sK8yadgD9A=;
 b=ldXIgr7HQzpc4HJ4aRw49NnHqnCUak6U/j+jFuKnBQSseN05n6ff5G2FIoXsIFE1bwsmXdCjfd14Ani60E6kUDBxyHB3Nh9sOAzftkx7NJPDeraL8IItOH5sUIjkYWigoY6I86mgGqdZSA1cZp9ezKKIuWO4yKz0xswZw1FN32lfurN4yD8nxRYVEEK8FfKhXCrI/mAHwiGnDLqbQ2dKu7jvZ2FZg12tj1swCPJOT9fw25aNxjzjc+Y9LBZWS/fXfl67jzfEggQN7ttznL6E4qcvN1hqklqLSKC0WAKgvDC3FldG/7lRt1RWy9zU1CaD5jM9ctDqD5a3GMryGhCB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoOyeDyHVnZ5EqvNB6er2I0hQoxjiiLs4sK8yadgD9A=;
 b=ETlTAz0ewfm+iuOkp1P+NxvW73VVYrWpCDnjCo1swx5TFhVtF4rJguvuJtweSxw3y45OcgNpVefKOTlWpXhDWxz+1rY7WIjmIbERWOizBzOeJDfw+2IjuU9CfDMiKyYFJHyNPyRK7K2As0YwNE5Xga51xIoV0FiTrOdOzHryix0=
Received: from MWHPR11MB1518.namprd11.prod.outlook.com (2603:10b6:301:c::10)
 by MWHPR11MB1279.namprd11.prod.outlook.com (2603:10b6:300:2a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 22:11:08 +0000
Received: from MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::cd86:ba9c:8d8e:9c7e]) by MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::cd86:ba9c:8d8e:9c7e%10]) with mapi id 15.20.4173.020; Wed, 26 May
 2021 22:11:08 +0000
From:   "Shaikh, Azhar" <azhar.shaikh@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: typec: intel_pmc_mux: Update IOM port status offset
 for AlderLake
Thread-Topic: [PATCH] usb: typec: intel_pmc_mux: Update IOM port status offset
 for AlderLake
Thread-Index: AQHXUQn5EYYa9JR3CkK0cmvUSE1py6r1TUyAgAEIaeA=
Date:   Wed, 26 May 2021 22:11:08 +0000
Message-ID: <MWHPR11MB1518ADD57FD98D687EB4FE8591249@MWHPR11MB1518.namprd11.prod.outlook.com>
References: <20210525020401.6738-1-azhar.shaikh@intel.com>
 <YK3pdXzYKdSy8d31@kuha.fi.intel.com>
In-Reply-To: <YK3pdXzYKdSy8d31@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.39.108.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3920c1f2-122e-42e4-ca73-08d920932a19
x-ms-traffictypediagnostic: MWHPR11MB1279:
x-microsoft-antispam-prvs: <MWHPR11MB12790496DF19846FB9373D6691249@MWHPR11MB1279.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bV7CRV3xWYoY8vm7lb596GDYQ+oZ6L1Wi9luc/xCHZNEW6tL6loRGXGC0WVcj0NtpoN98QUAjyUdrMdLEINWQZKOmCAtbST27EUAdl47c8UTmnEsaPfLUYZy+gEd7TdtjbwNu7fIMztVhVFY/frkVQfqHqy4fuJePaEHNhIMsxyl3Rh3kqPbZr4sVEvbThcksc8Ix72QqDfU3/CHl9nOhLBxW6YDbcSVxvHLEgusLeYJmvefUZVXkR47LHVZgQBcg1TEcxZmrETR8tacoxZi+n5UFkNPR5VpQogQp7QjS+2OvevMwRZ9A0IFXIVbcJ/4UR7UinfDPBUqPIbaSoQwfDdnEXb7I2mknuIHEO5LrYD8I2Q52YaPG9QM9vfbnW+qWJiOnAikncwMomSeeW//6Gfbu4979YRfUACrVZL2PUwBF0qxZRglV4fw5qde5zfJ1tua4rMRDXmFvBL1VshohgEHGvom0cfqg98EqmqcHC1DwS0xongxKkqjjJwR6eMPVQ91ZmsPwd1tbT+KOwcq4H6hxFCmBqXBi0KFQCM5hhvXCdO99JqEJ0zrjXpfzwnyL13xfN03f2XfOx4nkcSfSiopr0kBMnnZndVh4ALdic4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1518.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(376002)(346002)(136003)(66946007)(66476007)(66446008)(6916009)(4326008)(64756008)(66556008)(76116006)(6506007)(33656002)(8676002)(2906002)(7696005)(8936002)(54906003)(52536014)(122000001)(71200400001)(38100700002)(5660300002)(86362001)(83380400001)(53546011)(55016002)(478600001)(9686003)(26005)(15650500001)(186003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?c54O6Jo4QzePN/lIET65UlvkTknQHHWN63OdDcsKb2KQXTs/dGXRbi9WC+JF?=
 =?us-ascii?Q?/+xcRIneMRfJnsPmLnMD4o06FlIoMO89JhQCWaK2lYpCg9zuX4yqwlPBQQlB?=
 =?us-ascii?Q?TjWCErirFkLuAvQR5E/WYDWPoqKAbShUl9vQL4VbiFOqnmSid2PNqH/xIuT7?=
 =?us-ascii?Q?zPkUJMz/pgJVxel9kFi48PCaTnz68HFxv+vwfnhho2RYews8cBa1aUm1x6Td?=
 =?us-ascii?Q?nebI+I68EnPn5hrsgR+ofYDIxEbUj3OqgFVAT2CrCP6hXS2AJKwUADpaQNiw?=
 =?us-ascii?Q?ZHaHexpGCQrX8iszNaI6QIC4tKa3VXLuHTS0bUqWFjFpA2Dyh/F9IQh+D2/D?=
 =?us-ascii?Q?nY2E2GbQFCFtojK18VRsjlSboK3fIGsFBH8/MnaSIjnqjvtBQrlKFPuUe5B8?=
 =?us-ascii?Q?hzrF38uKv+9i5HPLR3PJy54vIB9iL1hNH94A7bB3y5XY/lT+pNOAUzTiQ0xK?=
 =?us-ascii?Q?LHqlGe/g7Enq6/LK626w35AoKGqeawt6DgjdPv9hbddqjfM1OAiprxkDrmsK?=
 =?us-ascii?Q?ApPxV98G2K5Ai3ydrxg73j9PdnJOS8esvsycFAkRoDTl2EAm9FwhVkhx2dkg?=
 =?us-ascii?Q?2l/6UmrD66KBQp6DsKHcJrBD1RLhAGd2acPH7v/yjMK5S23m2BIlsnAFBopJ?=
 =?us-ascii?Q?8bOgxX4Ei4YNwpMcOqc6SeOrA1WufIWOEmo4wQ+aWrCGdNL2+NIPKnnsQxFw?=
 =?us-ascii?Q?COnBBWTiZzqiQaS0cF4Vo62s8mo+eKe6jGowKZOZOd/Xg/oX7nVEI2tJ/s43?=
 =?us-ascii?Q?H/tT3uGpyn92ClRVXLn/ZAetgBdmIjkujyT6a2tBaGesXDhurwXubqpI7K2G?=
 =?us-ascii?Q?/dAN79jUVI5PCr2U7GyurZxO4yHBAKawVF60Kx7PUOMjLQO5eq2j9ZgFvQjt?=
 =?us-ascii?Q?Q9U2fL7Wb4x7wTQnVrdhv8vpHzximFZkiv49ZtI1mHoTZv7oJ6n3ECTj904Q?=
 =?us-ascii?Q?QkNKte+2ALoJFhI6cnP9wmdKnHfidCFfx/z8/+x2dEXP8L9TlTCjxYO4IvKO?=
 =?us-ascii?Q?oCB7a2WS2tVHG4gxNfBVKf7Vq9ZZJpqks9zMDoX+JWYGAyLRnBceMkifxTSC?=
 =?us-ascii?Q?bJxWDhjrGn3Nbpn4QDll+SI0P+F7dgVLVUn6atX37MUm0Te4DkrM6D5/5kaB?=
 =?us-ascii?Q?gAbB9FynZDC8NZu+yBZboV7eWvOzitZ9ecKsQJuCanpSoAaIn+i3pBuQODXT?=
 =?us-ascii?Q?TiMkEarLyeImJIwohVtOXPWOZJ1ruPxEqg94Gql4uvDYb65H9ZbYHKUA/AAw?=
 =?us-ascii?Q?6yawGxNQVRhEI+1RGG0zWlmlQU41ddZrmHKW4Wx/f+BeZMndTFEH6gdJ3jdc?=
 =?us-ascii?Q?qtVuF3/b/3HcD5brI6sNvseY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1518.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3920c1f2-122e-42e4-ca73-08d920932a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 22:11:08.6961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tn0SrHiXPNVRTtLv7XDJu8E4r4UE6xePA74jtRhyiDMqDFGXEcmyJ6QD2v+BkEKDro49m1r9g3b/CMix8Eb8BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1279
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Tuesday, May 25, 2021 11:24 PM
> To: Shaikh, Azhar <azhar.shaikh@intel.com>
> Cc: gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] usb: typec: intel_pmc_mux: Update IOM port status
> offset for AlderLake
>=20
> On Mon, May 24, 2021 at 07:04:01PM -0700, Azhar Shaikh wrote:
> > Intel AlderLake(ADL) IOM has a different IOM port status offset than
> > Intel TigerLake.
> > Add a new ACPI ID for ADL and use the IOM port status offset as per
> > the platform.
> >
> > Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
> > ---
> >  drivers/usb/typec/mux/intel_pmc_mux.c | 28
> > ++++++++++++++++++++++-----
> >  1 file changed, 23 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c
> > b/drivers/usb/typec/mux/intel_pmc_mux.c
> > index 46a25b8db72e..5ef41cfa8213 100644
> > --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> > +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> > @@ -83,8 +83,6 @@ enum {
> >  /*
> >   * Input Output Manager (IOM) PORT STATUS
> >   */
> > -#define IOM_PORT_STATUS_OFFSET				0x560
> > -
> >  #define IOM_PORT_STATUS_ACTIVITY_TYPE_MASK		GENMASK(9,
> 6)
> >  #define IOM_PORT_STATUS_ACTIVITY_TYPE_SHIFT		6
> >  #define IOM_PORT_STATUS_ACTIVITY_TYPE_USB		0x03
> > @@ -144,6 +142,7 @@ struct pmc_usb {
> >  	struct pmc_usb_port *port;
> >  	struct acpi_device *iom_adev;
> >  	void __iomem *iom_base;
> > +	u32 iom_port_status_offset;
> >  };
> >
> >  static void update_port_status(struct pmc_usb_port *port) @@ -153,7
> > +152,8 @@ static void update_port_status(struct pmc_usb_port *port)
> >  	/* SoC expects the USB Type-C port numbers to start with 0 */
> >  	port_num =3D port->usb3_port - 1;
> >
> > -	port->iom_status =3D readl(port->pmc->iom_base +
> IOM_PORT_STATUS_OFFSET +
> > +	port->iom_status =3D readl(port->pmc->iom_base +
> > +				 port->pmc->iom_port_status_offset +
> >  				 port_num * sizeof(u32));
> >  }
> >
> > @@ -559,14 +559,32 @@ static int is_memory(struct acpi_resource *res,
> void *data)
> >  	return !acpi_dev_resource_memory(res, &r);  }
> >
> > +/* IOM ACPI IDs and IOM_PORT_STATUS_OFFSET */ static const struct
> > +acpi_device_id iom_acpi_ids[] =3D {
> > +	/* TigerLake */
> > +	{ "INTC1072", 0x560, },
> > +
> > +	/* AlderLake */
> > +	{ "INTC1079", 0x160, },
> > +	{}
> > +};
> > +
> >  static int pmc_usb_probe_iom(struct pmc_usb *pmc)  {
> >  	struct list_head resource_list;
> >  	struct resource_entry *rentry;
> > -	struct acpi_device *adev;
> > +	static const struct acpi_device_id *id;
> > +	struct acpi_device *adev =3D NULL;
> >  	int ret;
> >
> > -	adev =3D acpi_dev_get_first_match_dev("INTC1072", NULL, -1);
> > +	for (id =3D &iom_acpi_ids[0]; id->id[0]; id++) {
> > +		if (acpi_dev_present((const char *)id, NULL, -1)) {

Also here I think it should be=20
if (acpi_dev_present((id->id, NULL, -1)) {

> > +			pmc->iom_port_status_offset =3D (u32)id-
> >driver_data;
> > +			adev =3D acpi_dev_get_first_match_dev((const char
> *)id, NULL, -1);
>=20
> This one I think you still need to change:
>=20
>                         adev =3D acpi_dev_get_first_match_dev(id->id, NUL=
L, -1)
>=20

Yup. Will fix this.

> > +			break;
> > +		}
> > +	}
> > +
> >  	if (!adev)
> >  		return -ENODEV;
> >
>=20
> thanks,
>=20
> --
> heikki
