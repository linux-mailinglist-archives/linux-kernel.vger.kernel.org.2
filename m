Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4121F439040
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhJYHXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:23:33 -0400
Received: from mail-co1nam11on2137.outbound.protection.outlook.com ([40.107.220.137]:56929
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230183AbhJYHXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:23:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNDRy9HJAJkQytCfFThthC4U2EAgb3A9RaWctKJUtFKTUxahLbqDXSWjTovSyLFziEXKQVvC8280kXfZHYGdTheQxc6NJidYv1uGyktJxYU25A8yXw0bYn77IKDszDGIw3ENRWTaEqhvocDu/8XO4HrfYA0J47aTXUEwqKlmdiRxO49GqI5qi6WiaqsNVwINGUKwx7+2GFnxRwFFaXk5JapQTOdi7KxL5fyIHC2Hlv9qoxZw4Z22Fsvmo2fXEkGTktK8nZ0d/sQUs72k9hUbgmRIyV87t/MvldkTIyDg071CmbnBSZvPut55f6cujbuPZ5XeRDSKEb/LwhyQXdOdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZGG9R4eclrHKTbo5+GvFpKSIoItreqFVyuJf/6wYqc=;
 b=Av9vFuQyLhnBUJybgNcRK05xKG2MN5k7xvYe4wgJmBwu6Czx4QGc1jSuonm0k4QMAW1zmnzs19107seewYyHC6F60qAIANG5LaUr31UqcoEBF4766bsDAhof/s6bTeKqRKYQtbnEETpQCykb4NazZV4d5PxBux2CDkqCnHez3Y1CiqysH0XCAulhQ64GGrmDi5zcHKKFPAzMuHv0gbWhOZMfUVDVtjM7+kor3+kj8WmAlXzCzKI0G8/3iS1TDtHOmSmyXEatO7yzARSeatsJ64BU8nGdBnKMTeHnuf6doYdCdGANgeGvLKRvcjV6eMxSP+op5xdhaQdlDm2Y/cyk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZGG9R4eclrHKTbo5+GvFpKSIoItreqFVyuJf/6wYqc=;
 b=hVtAzbhRJbv+rj+ro0xwiDuKGS+mRvqSJcDnroQ8nJ1vstpMhTB3pY6kF20zf8UaJTFR2M227iQKL0xhzatjji8MGY+VnlK7sIr3N/VDHN/fPRJ141KcJqN+08tJzaSW65BrxvZt8CfE4MJA2hdjaFoyLuvtNAguD4jUGlMe4vU=
Received: from BYAPR11MB3671.namprd11.prod.outlook.com (2603:10b6:a03:b3::15)
 by BYAPR11MB3191.namprd11.prod.outlook.com (2603:10b6:a03:79::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 07:21:06 +0000
Received: from BYAPR11MB3671.namprd11.prod.outlook.com
 ([fe80::49d4:a1dd:5b55:4c94]) by BYAPR11MB3671.namprd11.prod.outlook.com
 ([fe80::49d4:a1dd:5b55:4c94%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 07:21:06 +0000
From:   George Song <George.Song@maximintegrated.com>
To:     Rob Herring <robh@kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "george.song@analog.com" <george.song@analog.com>,
        Steve Lee <SteveS.Lee@maximintegrated.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: RE: [EXTERNAL] Re: [v5 1/2] ASoC: dt-bindings: max98520: add initial
 bindings
Thread-Topic: [EXTERNAL] Re: [v5 1/2] ASoC: dt-bindings: max98520: add initial
 bindings
Thread-Index: AQHXxYzchpH6DJKApkO/H481ZyF2a6vfsF0AgAOl1zA=
Date:   Mon, 25 Oct 2021 07:21:06 +0000
Message-ID: <BYAPR11MB367174F7CBA3ADEB98B64489F4839@BYAPR11MB3671.namprd11.prod.outlook.com>
References: <20211020083055.23625-1-george.song@maximintegrated.com>
 <YXNLJkzWTBoqVa1n@robh.at.kernel.org>
In-Reply-To: <YXNLJkzWTBoqVa1n@robh.at.kernel.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=maximintegrated.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a1ebf6f-5e32-4b84-ef51-08d99788028e
x-ms-traffictypediagnostic: BYAPR11MB3191:
x-microsoft-antispam-prvs: <BYAPR11MB31916F85A97B23D3EB27F5C7F4839@BYAPR11MB3191.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GQ2vWTBTbYGKnruwif3yZsLdZd/sYgISoD2Uj7u4ECOgLB5l6F4MTzX7iuCyo0QzUq5fVBmouvkXYJdQ/skhjzVF06ffiQRcrACz/9JVk8FgTbE0EcDXk9WKFWAO2caj06A0rhufoSgSTxGlgFhUgFIDu3j+iSjGPmQaEzUbViEsH/7l/p82LFB9CAMBcR24Ov+iMDgK20oO9qGBMaqT1MatRYhOUgkZVGUM53GaS/t4UhvqUV7upBdbkTP9uy6Iu5NQXiMyaquiQwvBbTxxV/0oukuvNB7TKkeA5Y/kEMkyHkZSYeWBsXamkDf60bzr4zPY2206JDKbHcDYz5cSN1H+KGdNBDsZlUw3DB76pLDRwGmu3Aq3vsdwB8hIdMuRA48iyg3KAAfr5p6AFsyNXBRI/T4CvX1kJz8rMVmUtRabOonwxqct9tJRbuNQ9vInd5R6yNFksQE1T2icQyXM1PbwdmYLJXH2BcLvKenR98XahI+Yfx0zgh3P+1ie84mVg4ieokDgFpd0Mzz21cH7HOGm7SNTYFE0TKzMdyJTWNk5KWeOdX4pb/5Lb7Cn2HU697mWc/79RfhOvvOtaMyKQHmxadrXsziA+RauY9/H0XQxCrN4kvUt2izKi/vH/8ikpVydnJradKBWK6uVeZdnsiwpPFcPvc4IKcIwWp2O89kwgS4BtZiuNojr+5f8AoXjSB5eLjgxiDzWeVF027RAzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(64756008)(8936002)(122000001)(66446008)(71200400001)(4326008)(9686003)(8676002)(66556008)(107886003)(52536014)(66476007)(6506007)(508600001)(26005)(2906002)(38070700005)(55016002)(66946007)(5660300002)(186003)(4744005)(33656002)(7696005)(316002)(54906003)(6916009)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HC8Lv7ZNKqlwyH/ha8mJ6aNNx41qZHnDVdOy+znBsGNzs9jZDt4LlB/ZJn1c?=
 =?us-ascii?Q?+hJJgiUK8Hz7416LXAjPmsxRHH6vmH/Ak+MX48ZT2yfoyzDPMsv4zhsmBjEE?=
 =?us-ascii?Q?gT8SSLF9QHniwo2odOmaMGQT1EV8S0g+x9MiW1M0T8WJbBPPkLdH+Mr5/nAr?=
 =?us-ascii?Q?uKef/SgU7KimDgMKGK6ADn4vx4JA8GSS7U0YKREGzkEO4KiEgFAOUHyVH25n?=
 =?us-ascii?Q?QIfCziY3WmcezGz8kyXSOgEw/DECNWU74XJF91QXZ+J7dc1bi6AxFujZDvEZ?=
 =?us-ascii?Q?bW2WmrhMQLsNaW201iuCdnAhCqKkP2tkkCEPAFA74QdxzjEdy6B/swiB96ux?=
 =?us-ascii?Q?cGuOOb+rchm8c4MEbClNk7Ag/eqwa9n/OZgU6dGO2jsnjx1EJZX8z4hVlR3M?=
 =?us-ascii?Q?Vzbuw7MkvOypvH8DOl4F25TtbXaD+FOUiVY1WT8QiydlRfqRZQcxmQHRVIl8?=
 =?us-ascii?Q?EDwo8YC0Z5+nYDKvVY5ezeO0USEKptF0EJHFiF992A0AztAKBwpPQ7TL7oU8?=
 =?us-ascii?Q?Pqm1Vvz49M+3TOBqoTv4s1l58N1GOg8qdX6+G65pw+KEOBImj9YdMv/qJLXH?=
 =?us-ascii?Q?ZqMcQhPQDrmB0Uz1tXpyEhbXXmOq0mCcqKWowtVp3ZZ8HqXPtlJn2ENNjo4H?=
 =?us-ascii?Q?amsjdiFJc5HJMd9zMc3GD+MnR/onKOtXq6PKlVM+X0jS/nCW4iYiz4kmaXkm?=
 =?us-ascii?Q?ZD/A//o+s2zL5idK3+PBVBJJiErZsZAMEUSugiMyHGyVO2j2ufB5xY8nQtjX?=
 =?us-ascii?Q?+14GmzawXEqLkmKwzVEGweGhwLwEekYX8zlg7y+/EQ0PViySuGhuTNVDSZGV?=
 =?us-ascii?Q?y6rbbHms8Ea3GcGig7gtVQdKWtwX9V4chkyrs0gQ2P5jNl4HPvl3awlYGwTa?=
 =?us-ascii?Q?z3Vq2sLGspElp7iohwP+53FIbPPOe10GVnceVaZxNASae3fU56+BUGqR9qFd?=
 =?us-ascii?Q?NQVp48dkZL4WAkhEykiNd88bN4qQgeYS4Mx26s/9Ld0TKh9YFn2jHHGxAzGA?=
 =?us-ascii?Q?pQ/5bMgkEJnS+P6Ducr/u5aE1jJ2PHSZWI6a0f+HFzX+UohsPGj8HY7Idzhy?=
 =?us-ascii?Q?OFko4gZH3Z5flNTxFlGWflBBUuq02r3DWcm/1nc/EHIfuJnNBBnTiOocBIPT?=
 =?us-ascii?Q?vOFZZfIJPsTc2lVyUFmpCsmKSgOcbvxIspUWVnSfmbLcO9wcY8c7BzdmNqax?=
 =?us-ascii?Q?bJ8uPXux3UrM2OFGvwTR9L1ZZYb0YO4zwexRLcP0kiY8msPrDzEQ9HFzcv8S?=
 =?us-ascii?Q?XlPx4SS6nblpK1ExZrqlsfnreHRRCAm0kQMkBRGLgybDEmwAk+F5eiq8kpge?=
 =?us-ascii?Q?VzS0xTmgmnDhXPJf/IF2i7OW/VzEVboyawg30VGsJzIXzENiUUFzHr1kLmZo?=
 =?us-ascii?Q?KVxXOARGiuf7ujV/+Y5YNW1/QrS3ZgVv7cgHOXsO+qa5BVALK8KDiQBVuQdc?=
 =?us-ascii?Q?7tphhxBz3s90e1OJtQFbFBFFTFjv3Sv+KgT5icMACxw3IElOTdDpgi5ZpM5R?=
 =?us-ascii?Q?VljTsAWC/r3TEhmvKtHC9x2CFmpkaCmvo+plwzzZyLOqgQH8H8/1p+SsWxwi?=
 =?us-ascii?Q?huq0TvPfz36OuKk7XYWi0uoGWCyesd6ROHixjexg75y1J+DQNl5Qm9ZNsTpB?=
 =?us-ascii?Q?uq85QfzwxgYhJPA3l6coCzStHGPn7E62SUdyh5z/1+q5I6i3MBFolM+7xxK+?=
 =?us-ascii?Q?2h2P9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1ebf6f-5e32-4b84-ef51-08d99788028e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 07:21:06.1925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24d9w0bnp1Fm/F7bk/zt3zyw3iuGc+LHLaFzfAyMd0ozM5VUT4RhxVRBvc7lTkn2Ezki+1NCWNtnPvyggEGLqZI3VvZ/PveefEEOXNXZbQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3191
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 20 Oct 2021 17:30:54 +0900, George Song wrote:
> > add initial bindings for max98520 audio amplifier
> >
> > Signed-off-by: George Song <george.song@maximintegrated.com>
> > ---
> >  .../bindings/sound/maxim,max98520.yaml        | 36
> +++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/sound/maxim,max98520.yaml
> >
>=20
>=20
> Please add Acked-by/Reviewed-by tags when posting new versions.
> However, there's no need to repost patches *only* to add the tags.
> The upstream maintainer will do that for acks received on the
> version they apply.
>=20
> If a tag was not added on purpose, please state why and what changed.
OK I`ll add Reviewed-by tag which is remained from you in v3 patch=20
as "Reviewed-by: Rob Herring <robh@kernel.org>"
