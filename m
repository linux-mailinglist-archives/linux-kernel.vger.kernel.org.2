Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AF530BA41
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhBBIts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:49:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:12317 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231447AbhBBItk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:49:40 -0500
IronPort-SDR: FI0JBrTTnd3RVwUQcmCZObVcdesPPbbAxra++tau5Ww4KfIOSuY+RP1Iyo5bSxNuKfvDWf1TwK
 gTdTQROaUV4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="177312265"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="177312265"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 00:48:53 -0800
IronPort-SDR: 5hD44ajJfFsFqdQThD2i6w6F9apcuSaAGv7WQKkEePK9hxrgMI59EPD3U6KyTsDZtPPSrJ33Eq
 oaioJkk6Nmdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="479488904"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 02 Feb 2021 00:48:53 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 00:48:53 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 00:48:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 2 Feb 2021 00:48:52 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 2 Feb 2021 00:48:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LezIRExBoDiVYF9Gxi/aUVvMKsUJT/1G/+U0PuP/NMF3zB2N7wlIwCLFOnAizoy7WvhBDpDKw1jKdRx9ZhJCNc9NbiXjiJ8Wg5+VOyYKyjHGG70F3zzfQ8gks9suC//EwwcSpV5+RRCVZQpoKekeljntfvL9GQ1aY2WLEE/uFmei5dkoSQdf6zl8mXN17a59gvZLRp+ceYzD3+iU5uonfTGTyi1P76V3Dy6cVCdJKGJduvQha2iqgW+/v/y0MrnsVVOh2LGvTegUVOPDJEpXQk2ee8Y81iV9QtTdAJDkRxcjNhxaUzEDRBNkjKi704jWv704wNlnlqPN828EZK6t5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOt/c18T+EYcMLvGrTaUy3Z2J+p6AP9I3UuibU++rpw=;
 b=VXBUreJls6bpfIxd+wIq90yLjOWWkpRnSaRmc1SjwywJwbvAv6kLV/JMmSgZavKmFYYkYVBviEan7EO7wx/9KgE2xau08Dku6+tP/a6LInzrl7MvmPZRx82pBCcCrKZmbr++vE5C+yG1Ct8iocEFsDkZmYnrLs3EFh58MuvqMbZHwbeytVBnV5fjrL2Jvg1qbjWU2EvaMOxAvxR2t31IUXIUZkZMmoi8yBjFxfMCAEyViQ2tuDMbwYT6i2jDbcP9pti0jfClBdF+tLD7ne2Qkzgjz3U22h+Qa9XUWSo4bsVb9eds93B/4QdSEY7hFYmzr4P0xRmB2EEg/M7qp9r8yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOt/c18T+EYcMLvGrTaUy3Z2J+p6AP9I3UuibU++rpw=;
 b=VFamoxyyiMXpV8Y5mBNYXl7Lc+Bnn3SObNkXTMqr12ksaFHijjjS+DeL3ICHmhKL39s9r5rQ5jfeYzRU8PyW9H8Pjenr51CvCygmtQoCCVSLYPiq2H5HXoRbglBEUZdTsZwoZDT9Lb9j8s9iGat9VOiFMsWOGH5VWGResLANfvw=
Received: from BL0PR11MB3234.namprd11.prod.outlook.com (2603:10b6:208:65::14)
 by MN2PR11MB4415.namprd11.prod.outlook.com (2603:10b6:208:192::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 08:48:50 +0000
Received: from BL0PR11MB3234.namprd11.prod.outlook.com
 ([fe80::d19a:edde:cd0:9835]) by BL0PR11MB3234.namprd11.prod.outlook.com
 ([fe80::d19a:edde:cd0:9835%7]) with mapi id 15.20.3805.023; Tue, 2 Feb 2021
 08:48:50 +0000
From:   "C, Udhayakumar" <udhayakumar.c@intel.com>
To:     Rob Herring <robh@kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>
CC:     "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@suse.de" <bp@suse.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 32/34] dt-bindings: misc: hddl_dev: Add hddl device
 management documentation
Thread-Topic: [PATCH v4 32/34] dt-bindings: misc: hddl_dev: Add hddl device
 management documentation
Thread-Index: AQHW9q6qjchvo/QHyEKQO/AcKFSXgqpAa+8AgAQm5HA=
Date:   Tue, 2 Feb 2021 08:48:50 +0000
Message-ID: <BL0PR11MB32349C46E65481B14A8815DAE2B59@BL0PR11MB3234.namprd11.prod.outlook.com>
References: <20210130022124.65083-1-mgross@linux.intel.com>
 <20210130022124.65083-68-mgross@linux.intel.com>
 <1612027420.855682.1419431.nullmailer@robh.at.kernel.org>
In-Reply-To: <1612027420.855682.1419431.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.172.179.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5450885-ec52-422f-e0b2-08d8c7575ce4
x-ms-traffictypediagnostic: MN2PR11MB4415:
x-microsoft-antispam-prvs: <MN2PR11MB44158577952611FF65E29812E2B59@MN2PR11MB4415.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GkwfNTeZ/ym2PuHOJfizD375MDlF3krcBh4HGV9BJkB8McmAHgS8zr2f1nUPK4OQm2PYl0H5/K0sHMV1oSxwG/+D+EHCSw+RZrbcpMczEjoNRNvd7lG8xQJjZAsEFm5UHIaoIoLCK+E1r5NRgKcC73CrV2bSEg8nX0ENKre1JAk2ldAZJ4sCAnjl6Noe2inS2IYSnDMADlxAx/s0LfiAz08CEP1e7QdpX09qrCyQ64uwtcI98AfFwsahslejBjBLAkRuD/oHi0eYdzloEJ4+L+NTHJHIatWcm6/d3EIVpqQrqUo9jqQpovIZVQripjEx9VRq1g60EdGC+X5PTFZPcteGVa6x6gNeyz+nKBB3+/t8h58Vmd75JyXvGC35KjaltOESd78aVaJD7G51Y023SoYLvvOgxyopr4kLsBNHsTljNpvWGVvdqcM8ZZNBjk+BqJfm4x/6fIRqXNU9LWaiM4sFCguNvSzgYpD6Eq4iu5w339bff6wXxlZpNsX4I+b0DHERrGuisEDUup+9j2IpRov7rdJb3lbSUnbtzbAy2xZAP5Gn54/JepxwWxv3X1emKzZOT5qp+dcY+GrX2ifVRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3234.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(71200400001)(55016002)(83380400001)(33656002)(110136005)(186003)(66476007)(66556008)(8936002)(64756008)(54906003)(66446008)(2906002)(7696005)(8676002)(86362001)(478600001)(66946007)(4326008)(76116006)(7416002)(5660300002)(26005)(9686003)(6506007)(55236004)(52536014)(316002)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Dh6nVYTETUIJcVRTgI7Yp+q8aSmeOW45c4mwP/+1TCTaDrPoQttCEsQihsBm?=
 =?us-ascii?Q?uYN0d/6+SGi3XePmI2QjdlQQFrFH9gJrTcxOzooAgxlVzD4EHPf4EZUMMeon?=
 =?us-ascii?Q?GSEIdyyG/uBlJaWG5G0VTqr9L7oFB6dDLveZ1/wCmf1duQCHl+izGxohjAmM?=
 =?us-ascii?Q?lJr27n+bmdUupzDRVtsOQSs7RMCASYyynrwvVfV1QfxHsRcwLjevK1fMuvqy?=
 =?us-ascii?Q?jd5qPNlsbRGLI/LomLVCy2tYBFWZsBXrVD/sq46nybJrmgsIXspDKYBgq9Me?=
 =?us-ascii?Q?KGg7kiXZ2iom3V4Oyl10dl/FIviFvdaJoiuWU9D3ub+tTqzoVW2XEMX9Hdwf?=
 =?us-ascii?Q?hjTQTXX2DEfHbp0XaTEd8eU7x5LSzLEl3VmQOXChFhExbdfpXTEXTWi28PAH?=
 =?us-ascii?Q?0t7/gcCP8Ubp091qwRacRVl/QNMGxQxk+8NRs6oPPf1fnveBmudO4aEj6Ah3?=
 =?us-ascii?Q?AZS/tGrffXk6b18tTuamZatqakiQqARKTCJWlEjYeji/7Wf9k9b9Kch1Y8E/?=
 =?us-ascii?Q?J3NFzSVieWegTml0gyUGx3IX4ArVc0EunFmz5LSJxFmaueEP5EXMA7/QgRaa?=
 =?us-ascii?Q?xnLQR3XmRibm3zXseGsFCsVnK4vqsbHTtSyUl8YmBw77OXDICiSan8dtbO8w?=
 =?us-ascii?Q?P0GU7LAATMC0PuDv+cTrU685YWgEOw8BnLJMlhZEWga6m6LHHF1SU9ltkk0O?=
 =?us-ascii?Q?lXD2d+VfQ11Ux5xuwka7TPuDL/FNf4NV0MNHL9iemUG7+pt3OQiZkjnqIDN2?=
 =?us-ascii?Q?CClffjr8aRL3eOOitRH9L/FG45R/JYkpyEELv7QktIavsQM8JaHj5u+Wqq6r?=
 =?us-ascii?Q?CsyL+IDxvqSE0HDrHp9ZwPXd8WLDVVZzbFz10IzBRgE03D3J1JkJt23PGpjv?=
 =?us-ascii?Q?u7CzohPzyl/m61nsLpMAa6l0KslTLYO/0DGcKd9cMv5S1beZaLGJI0tDGqVI?=
 =?us-ascii?Q?R8oALNRajWaYWx8Nm3ePA6L7NZ27oWrt8UcyTZ1OxVgja79I5tfxBd1u3AyI?=
 =?us-ascii?Q?2DC5282GKyu50IRuTa92R4CC2oxARez20BUM7g+hlzS62DPOb70PEGSyk08N?=
 =?us-ascii?Q?X5PgV9oh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3234.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5450885-ec52-422f-e0b2-08d8c7575ce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 08:48:50.6781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /bdkCYOQryrOwGrAVg+WO0aj5vrnUBuIz8EOpE+yd74oTLpB5YcDmNpFqfH+klO8BkDiWcmEjREb5ywzL5qYnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4415
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 29 Jan 2021 18:21:22 -0800, mgross@linux.intel.com wrote:
> > From: "C, Udhayakumar" <udhayakumar.c@intel.com>
> >
> > Add hddl device management documentation
> >
> > The HDDL client driver acts as an software RTC to sync with network tim=
e.
> > It abstracts xlink protocol to communicate with remote IA host.
> > This driver exports the details about sensors available in the
> > platform to remote IA host as xlink packets.
> > This driver also handles device connect/disconnect events and
> > identifies board id and soc id using gpio's based on platform configura=
tion.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: C Udhayakumar <udhayakumar.c@intel.com>
> > Signed-off-by: Mark Gross <mgross@linux.intel.com>
> > ---
> >  .../bindings/misc/intel,hddl-client.yaml      | 114 ++++++++++++++++++
> >  1 file changed, 114 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/misc/intel,hddl-client.yaml
> >
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/misc/intel,hddl-
> client.example.dt.yaml: example-0: hddl@20320000:reg:0: [0, 540147712, 0,
> 2048] is too long
> 	From schema: /usr/local/lib/python3.8/dist-
> packages/dtschema/schemas/reg.yaml
>=20
> See https://patchwork.ozlabs.org/patch/1433603
>=20
This lint warning is due to missing address-cells and size-cells fields.

make dt_binding_check dtbs_check DT_SCHEMA_FILES=3DDocumentation/devicetree=
/bindings/misc/intel,hddl-client.yaml=20
  SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
  CHKDT   Documentation/devicetree/bindings/misc/intel,hddl-client.yaml
  DTC     Documentation/devicetree/bindings/misc/intel,hddl-client.example.=
dt.yaml
  CHECK   Documentation/devicetree/bindings/misc/intel,hddl-client.example.=
dt.yaml

Will update the fix in next patch version.
---
Thanks,
Udhay
> This check can fail if there are any dependencies. The base for a patch s=
eries
> is generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.

