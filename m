Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1CA43AD0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 09:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhJZHWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 03:22:23 -0400
Received: from mail-dm6nam11on2076.outbound.protection.outlook.com ([40.107.223.76]:54269
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229635AbhJZHWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:22:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guN84q0r5lahDj5x01ZpbpFBEuUeNW/k1j0kQE7sib0HNFRbaEJLtO4LlX6WkAkfAscqAJEpnabRUQXw8+ONOvnlVBldIWap/tGjDZ7/zyCRNQRSMUiA8Ghj/n2MyJXB8y1OGbBmb3JdrMFF+m0cRSF4FEx3eFkeZ/h5XAKuHEiC8lUYerCQgAK8r0AinZuQKHPJqunGyup9LFuen+ucNWNNbGiIjGWrUUeWc5nehm5cKEZheEkX3SEZuJZn4cc5HVy7Rak4sWyO9d5yC+7quX98cp4+UZoAbJzfp9UPEg6kuP3L1II/DIwt3ON72V6H//cYs1/CXy0xkN+Xbu3FVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcOPOKadvheEvm32q1aSlsVIhXYknlYtvjdA4afz3K4=;
 b=DPviKNkZ63KQbi74NrzbUw76+B0X7Hpuk/VNVxNykcZ5eT2T68e8i89RKSziLK9Mv8xRjdE1tqHE33w7wpmdjuTUW5rH/SLe/Pc3ZUGs9FHGoQeqMAzEhSzrWwrU6j2Dh16AVBw6NqwvMcZB7iN3AvNVh903tSOpMOU4T8oZDgMKBSwdMx/4XV0VCuZq3VH4XNRPi3DuDxN3TM4WZN+UlO/21tgL8UUU1W3g5kMGKETZbist5KL575Jt08ICWhULrpUWOw8II0tIVYYCeufq0DDIoR1xcliRksI6cZ/XbmxXf6ONPARKWx3tOPuDUq0u1HdbwDUTq2RxAB6KRSTxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcOPOKadvheEvm32q1aSlsVIhXYknlYtvjdA4afz3K4=;
 b=rutPyEuD0G105EMHKC9c/+dexwLo1oO6UllAgXHjJTACNjYQjVDrioE3TVSaJNSAK6UyTnYpo6uOYQeQYu1VckB0aahtES/Y6yMcJ1ofMHlQMhSLB6jWlD1fzlmqiaGud0+QH5ttahtbGdZL228RAewFzBxTNIHGa5lFSi+0Lmc=
Received: from SJ0PR02MB8595.namprd02.prod.outlook.com (2603:10b6:a03:3fc::22)
 by BYAPR02MB4390.namprd02.prod.outlook.com (2603:10b6:a03:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 07:19:56 +0000
Received: from SJ0PR02MB8595.namprd02.prod.outlook.com
 ([fe80::20df:6203:3fe1:db8a]) by SJ0PR02MB8595.namprd02.prod.outlook.com
 ([fe80::20df:6203:3fe1:db8a%9]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 07:19:56 +0000
From:   Abhyuday Godhasara <agodhasa@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Michal Simek <michals@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        Manish Narani <MNARANI@xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Tejas Patel <TEJASP@xilinx.com>
Subject: RE: [PATCH v6 1/6] firmware: xilinx: add register notifier in zynqmp
 firmware
Thread-Topic: [PATCH v6 1/6] firmware: xilinx: add register notifier in zynqmp
 firmware
Thread-Index: AQHXyXm2z7oJJqmDVkeNegd3tRQp3qvjY2gAgAA0UuCAAAX0AIAAAKAAgAFCANA=
Date:   Tue, 26 Oct 2021 07:19:56 +0000
Message-ID: <SJ0PR02MB859566234C2BD56F8A6D605AA1849@SJ0PR02MB8595.namprd02.prod.outlook.com>
References: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
 <20211025082350.10881-2-abhyuday.godhasara@xilinx.com>
 <YXZsLJ3SfCjYr3gk@kroah.com>
 <SA1PR02MB8592145E6C1A9A1FA561FA33A1839@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YXadDpOHWs2kUA6J@kroah.com>
 <SA1PR02MB85928833B8C133B4593882BBA1839@SA1PR02MB8592.namprd02.prod.outlook.com>
In-Reply-To: <SA1PR02MB85928833B8C133B4593882BBA1839@SA1PR02MB8592.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a845623-e34b-4dd7-e15e-08d998510355
x-ms-traffictypediagnostic: BYAPR02MB4390:
x-microsoft-antispam-prvs: <BYAPR02MB4390C081B3D6C3B244C5FD6FA1849@BYAPR02MB4390.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L2B8bdSqBGMpgbp6Rd7N5xDvrOYRNY09o/+HkQ8qKZE2PxPC+/E2HGSYOx9s8Znoj1zTevhRXF8f8RgH7QXnpytr3vCRJS6ZLnafIb6MQyELkxTbKK2u++gjFt+McwYIcFvzU+zMa52/7RFachNrb0BzMOazd6Oa+JsUnXkbu8RBDBSl7N+G/YZoK3pVz1p7Pvk7aTVRQ0HW8OL2Zr3HmQTGowYGFqbQGrIHo7ildA1tCi8dYDFAMp08Xze35K3CzpzKO7Q5/Qkd6B4nL8Q6EGynehWWehQ36VVtRykDYILE1Qin9uaFuibGqfJjdKKbvbJErMQolVj/Q3lKQQMCmifQQuL/v0vLU8ya88vQRSvcikMmPq0jt/z1rkg/UAHTlllYFkU+UcVTmeNC/oAS5P80HNNURX4VP0/GIxqS26p3CkJDdvJrcPHoqqL4ki/SQcl6vb5SxMhh256b/kas6vgD5brxlSZXzZfsUuQ8sRGyL2IHUn1jrESdOwDOuGusri3rqSXCbRevVFW6G4IX/qTs7W5mSADymQkZW88B5jjg9M9KvzvwiQOOPvZOq0qDhZ1AcYCnloOAOIZa9x4bHydhVgXsQJbWEvvXWtE58dIQCj2CxT7OQloKDLNqVKG9r3rqWBFKMbOOEXo0s9SE/2z5pxrwqigeX0b4SugqZNG4dwY55uPJGP+lg48/VioGMFPBUub0iQmN5J3+IZDFvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8595.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(316002)(83380400001)(6916009)(6506007)(53546011)(71200400001)(38070700005)(26005)(54906003)(66946007)(186003)(38100700002)(86362001)(8936002)(52536014)(76116006)(9686003)(66476007)(66446008)(8676002)(64756008)(55016002)(66556008)(2906002)(5660300002)(107886003)(122000001)(4326008)(7696005)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0ukcvGARBidunL/GpX0xPLGghoRZCJS2f+BWUb9KrQfmDGzshZBn83Uk6nbC?=
 =?us-ascii?Q?xa3Fp4wOv0Wd9qPowjzahvPohFWHjn6prgngxcIYts/ZOqvxcuSfwu2PZPUg?=
 =?us-ascii?Q?J/nUOOox3aC15QKXRqnIs6rvC80CySKmSLP4Tdg04Tzk3VbLn0UeUlMPwprs?=
 =?us-ascii?Q?X8Wi5yjzffiEvo83xXS8WDowWw+ktQdwETmyelG//5TGKm+n6v8s/ogiu6zK?=
 =?us-ascii?Q?8m8XbUEbMY+SlEXuan10OZ3TDVPichST3yQfSUnn5/Gg6eoTG361RPBkVUNf?=
 =?us-ascii?Q?aK/5oGnZU7cQcRlw5J+fnXMAb9H8WNuT+S0AwW985U0cZgHgzFxMZP/706A4?=
 =?us-ascii?Q?vOqMImOp2YfQX0oHmcsCwqRLRfPMx6WUiVpJ+g1GunZnsgPvJxJTllXCrvJl?=
 =?us-ascii?Q?uaKviC8oxai9tzZyBKQ7vWRIifzIUebW4C83cawz5UlvAl1wrOPW6Bgx3QEX?=
 =?us-ascii?Q?fV/3QmXHBJwO0QGstrqiX7Ksw7xwNJn3qwvT+8eU2CPUWv9XNncrvElFjJTm?=
 =?us-ascii?Q?Tr92Aldtx9mFMaI/osajPI151k+J41uwFriwYyZyDC8HsiFANgck0ZC5Wt6v?=
 =?us-ascii?Q?Qtdfg5Ja9HoxccJxdJzWkmy4leXE79be52fQKh0S6hqJ+g62VPUYrMvHkuJ+?=
 =?us-ascii?Q?82AzTn5buJqGroEO8D9hlTa0XXCbU/RpFjGCz3fHGEuUGzeFq6mOHouCb7I1?=
 =?us-ascii?Q?dWfPE/06gQuOybmTVIjMptqQeUzJsKrrgqKp2cQGlXICIlZBectepsT8g3dF?=
 =?us-ascii?Q?+5WyC4qpvHaM4S4UVy2XEPBKrJrXNFHZM6uZSHlvFZl+JmXWv1Ii9borusPq?=
 =?us-ascii?Q?YvgCnURcbvYYK12skZpZmigXRjPebx8Grl5WmDU/I4DttJNB+77XV/TF3Ax1?=
 =?us-ascii?Q?LcybCdbyIA3HLrnpzcIjywWLGUufPVA97BREXBkEbOBC91r+l4IQ6wGgiBHs?=
 =?us-ascii?Q?U/GZmbXbmMG9El8rHeyRy25P3LxF1i2QaY0ZDR+4oRX4wbshiOnxfGvRC+x5?=
 =?us-ascii?Q?W0JtjnD6B1t5xG0V93qFzqais5KivmFV2LNrrkiy+lyCmAI9MXbrESPRBaiG?=
 =?us-ascii?Q?ldIt99+ngMvsIWqjAx2/x1UqgH1ZM38cwrh/cVBo07g2KLX/fbM1FAgEvQXR?=
 =?us-ascii?Q?yV2+AT8R3DOylE8k6iD6lmCSUba6TW9jgDWAoimwuPvcaKs6nkkM2NF8Ym1Q?=
 =?us-ascii?Q?lAdNxOkiZ8wkkm/FyCHjm2BDG9nHOhe47blEZ6fmrFhnLDOKr10Y55Rkn4pn?=
 =?us-ascii?Q?jRObAzPsQwgpANNpqcHNBb+kZWuZgiZGXgOGCI3YSH0rY37pAfh9JTF54lk3?=
 =?us-ascii?Q?60620IE/dJsvXcTzN4G/J94EuIyEXxjPMXbwYwpdIYRMQzZUU1aSbZZ8t3At?=
 =?us-ascii?Q?UgfDHX+VtLdrh4H3uqCu+a+1+y9+QDwjh/ML5rUCbBcTzO1Nz175i38K+PR2?=
 =?us-ascii?Q?8Od0V7UocyiwqAOBSMemZh+GSQd561lp4jsuUu+7MR2ydm9pSmeRFjLqFNk2?=
 =?us-ascii?Q?AKvcLeVGd55M24rANtdZ6O1Yt+CmBIfvPpAdSmew6H3QAwQhIK/SBhPxNITi?=
 =?us-ascii?Q?LumFVODlUb2UuXEUwJr7m/2VllkJlE4wysm3pqTvq/Hejo9RaYU3bb/uJsrV?=
 =?us-ascii?Q?uFuafAVMN5kwz6XisrLrjYw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8595.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a845623-e34b-4dd7-e15e-08d998510355
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 07:19:56.3068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zh+eudSEJaQt7CO6RSPGM4VX7pkGQzehjxq2NWOFKi0ABmMhrORwvrejeIW+ObvA1N+nuKislOgkHq63cOoW7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4390
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Abhyuday Godhasara
> Sent: Monday, October 25, 2021 5:42 PM
> To: 'Greg KH' <gregkh@linuxfoundation.org>
> Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;
> Manish Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> Potthuri <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Tejas Patel
> <TEJASP@xilinx.com>
> Subject: RE: [PATCH v6 1/6] firmware: xilinx: add register notifier in zy=
nqmp
> firmware
>=20
> Hi Greg,
>=20
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Monday, October 25, 2021 5:33 PM
> > To: Abhyuday Godhasara <agodhasa@xilinx.com>
> > Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;
> > Manish Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> > Potthuri <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>;
> > linux- kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > Tejas Patel <TEJASP@xilinx.com>
> > Subject: Re: [PATCH v6 1/6] firmware: xilinx: add register notifier in
> > zynqmp firmware
> >
> > On Mon, Oct 25, 2021 at 11:53:17AM +0000, Abhyuday Godhasara wrote:
> > > Hi Greg,
> > >
> > > > -----Original Message-----
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > Sent: Monday, October 25, 2021 2:05 PM
> > > > To: Abhyuday Godhasara <agodhasa@xilinx.com>
> > > > Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja
> > > > <RAJANV@xilinx.com>; Manish Narani <MNARANI@xilinx.com>;
> > > > zou_wei@huawei.com; Sai Krishna Potthuri <lakshmis@xilinx.com>;
> > > > Jiaying Liang <jliang@xilinx.com>; Jiaying Liang
> > > > <jliang@xilinx.com>; linux-kernel@vger.kernel.org; linux-arm-
> > > > kernel@lists.infradead.org; Tejas Patel <TEJASP@xilinx.com>
> > > > Subject: Re: [PATCH v6 1/6] firmware: xilinx: add register
> > > > notifier in zynqmp firmware
> > > >
> > > > On Mon, Oct 25, 2021 at 01:23:45AM -0700, Abhyuday Godhasara wrote:
> > > > > In zynqmp-firmware, register notifier is not supported, add
> > > > > support of register notifier in zynqmp-firmware.
> > > > >
> > > > > Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> > > > > Signed-off-by: Abhyuday Godhasara
> > > > > <abhyuday.godhasara@xilinx.com>
> > > > > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > > > > ---
> > > > > Changes in v6:
> > > > > - Minor fix
> > > >
> > > >
> > > > That is vague, what got "fixed" here?
> > > [Abhyuday] During rebase of patches on your tree couple of lines
> > > code was
> > get mixed unintendedly in xlnx-zynqmp.h header file due to use of "git =
am -
> 3".
> > > I corrected the below code which was wrong in previous patch v5.
> > > +static inline int zynqmp_pm_register_notifier(const u32 node, const
> > > +u32
> > event,
> > > +					      const u32 wake, const u32 enable)
> > {
> > > +	return -ENODEV;
> > > +}
> > >
> > > In v5 it was like below, which is wrong static inline int
> > > zynqmp_pm_load_pdi(const u32 src, const u64 address) static inline
> > > int zynqmp_pm_register_notifier(const u32 node, const u32 event,
> > > 					      const u32 wake, const u32 enable)
> > {
> > > 	return -ENODEV;
> > > }
> > > So, the body was missing here for zynqmp_pm_load_pdi in v5.
> >
> > And why did you not describe this in the changelog text?  That is what
> > I was asking about here.  Please be specific, as reviewers need to
> > know this type of thing.
> [Abhyuday] Just to avoid longer change log I added it as "Minor fix" this=
 time,
> but will be taken care this type of things from next time.
> Are you expecting the v7 for this time ?
[Abhyuday] Submitted v7 with updated cover latter and version history as pe=
r suggestion.


Thanks,
Abhyuday

>=20
> Thanks,
> Abhyuday
>=20
> >
> > thanks,
> >
> > greg k-h
