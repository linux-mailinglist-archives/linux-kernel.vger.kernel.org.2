Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606A24395B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhJYMOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:14:08 -0400
Received: from mail-dm6nam11on2071.outbound.protection.outlook.com ([40.107.223.71]:22753
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230167AbhJYMOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:14:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k25Mb0lVz9QTBhqJ5T9iU0uv+7tQjobMQolO6Wes3K0gRzD1oJnjOG78jKPLvLGygyOEttyTsX4tpAEXxDFAUhP82HvISMgauZ2fFW66blpvmbdwEaJp2Z/Yjqwd999YbgAwr58Qo2hUzALQgbDwecioTq2QaKfQBWXqF00QtfzG6z+Pncb1SSK+J1iE+JCWXW6RVTnmhw77CHqH766bAMXYjQZWIllIgdoUCdcyJHAeMJsIS55FzkAHalHhOaMYmXnoBQe83Dobwv4xu/SLmYyu23CailfsKyKfXd94yiblEbQ1pXokUrz5+FytCyxhb66oWar7lHFFZlXkbGGzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgSIl79DgZXlaDpE/Lxzwwlnu3z12qUGeTfZlNPbutw=;
 b=Jv/X4otmvEtn4K/PKrIB+9NbdRFDPTJDB/y409e4OJYg7S4oE3wvLs2969DkHAkgQ8BRKyNw87JuiQKticUguU+BC8Q0WqdOkQV4hSsA9gFf7+AVsK6bSu1vbG5k1m258hZbpC5cmsCUiIZTYOk6BBJ5qVyzx5L9HHHAxf496WScimmZOD0ZU7hjdnHboA5h6QH0v2FH//nlHo6g1U2oZDSsvvONV+Fi/ybnUmel0AzwXVK7wx2o6idkBBLTp5KZVjIV4W27IJpvNpBnMm0k/TC4kUgnwXuAcjKc+mKSKqURrw/vUMECNIRXTntXCHY7pa5KIrF2rg/QSQ4X5Vc7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgSIl79DgZXlaDpE/Lxzwwlnu3z12qUGeTfZlNPbutw=;
 b=P5KFQsZ+hBATUvWyicHa9Gm1al5gMUemnAIxwoauegLfgjXBjhULH57jZr0/YOVU5JOpZCXhGZUdz3akWuk1mG1ySBV3OIoUH2BHo2yhgt5njgEGPPqMExXMFhSEMWchFm8Lhcy9OsVXeIRXvyn61gsnoh0H/fMPeSXCef0iQO0=
Received: from SA1PR02MB8592.namprd02.prod.outlook.com (2603:10b6:806:1ff::18)
 by SA2PR02MB7755.namprd02.prod.outlook.com (2603:10b6:806:147::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 12:11:43 +0000
Received: from SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::6d3e:7010:c43d:fb23]) by SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::6d3e:7010:c43d:fb23%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 12:11:43 +0000
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
Thread-Index: AQHXyXm2z7oJJqmDVkeNegd3tRQp3qvjY2gAgAA0UuCAAAX0AIAAAKAA
Date:   Mon, 25 Oct 2021 12:11:43 +0000
Message-ID: <SA1PR02MB85928833B8C133B4593882BBA1839@SA1PR02MB8592.namprd02.prod.outlook.com>
References: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
 <20211025082350.10881-2-abhyuday.godhasara@xilinx.com>
 <YXZsLJ3SfCjYr3gk@kroah.com>
 <SA1PR02MB8592145E6C1A9A1FA561FA33A1839@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YXadDpOHWs2kUA6J@kroah.com>
In-Reply-To: <YXadDpOHWs2kUA6J@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40e9fbf2-3663-42fa-f0ee-08d997b09bd2
x-ms-traffictypediagnostic: SA2PR02MB7755:
x-microsoft-antispam-prvs: <SA2PR02MB775585CDE2A30C43DBAC932EA1839@SA2PR02MB7755.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: huq6AGjbBrFIFwydIKtv1rs/JA79L+J6/X5NLcokXIfZYeOtsAFzSN/roB9HuSuTQ0vctUnAdWk803uHLo2uIZ97UiSmYD1NNKGh/tfdMRH0wORpHogycFNIAdYSevN0vsoKcv34Lo165ijnN7uYyYQnuWMcJ4BttgsJ+K6OUSLzP7b6WCbto3doSSJMeHnUyOi7IIcp1BbvBDxOcnYBFhONr0ciXGIpk3Nsq4ofjXtPPTY8WDI4lJB4+ckp4b5maTdqeivMm3ueQpi5vO+bvDzhLq41TGHyFQSsc00KzOa9xc7dxMZ/NWTfpATt60Bz7/wF3oRZhA6Qd+Vvvoa75b3GgV0DyR9YKgp3rTpLk7OS1S6IBH0OA/pd6G/xbTc6mKlPoGiSH2mbKPfftvdb+YZUwmabglgsokRrrwzXc/XfvDOc5d9USnnM+uIz0kiZ8MtAS1l4+94ETwfMC2SPSXpcWm00sEnT3F5C5yblaTEMYod5mMbbxS0YtsNuIVFnIXjQNjzat9elx8dp9l7ZR8jjldr9v8Qk7Krtc9Tv7ngqbkz7DSLUaIPP2r9o3a4u/t2ylbzKSlXIdiGVjc26XP7TSuzSAzgssj3zI6XW4yFX1u9cf6eaTLyjCZ7aYTWuYXoTlS1GE1VPt6OBnc0ebFyb4pFGZ4HqXCjYM+Bhx/yxCflBIJhMOj5VogjwEXTlSaFUUyzfeOQ7VSBprFgt7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR02MB8592.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(107886003)(8936002)(6916009)(55016002)(86362001)(186003)(4326008)(9686003)(6506007)(316002)(54906003)(71200400001)(5660300002)(66946007)(7696005)(52536014)(83380400001)(2906002)(38070700005)(76116006)(66556008)(64756008)(66476007)(66446008)(508600001)(33656002)(8676002)(38100700002)(26005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8tlMyscDoiJ6gdQQZY06/L/M4q0ECotdqVOeT62gP4HEeimKnRlhYZmePz2f?=
 =?us-ascii?Q?cQ35kvIespcTgaPavt8VCVrr6gQZV0hqBP8BA9r36v54tube8o1123LS10pJ?=
 =?us-ascii?Q?KYzHHmViH0LfaJy2/ioNkdhJGNMX+4d29xqoIBczVKj/eQ+iD/OLuIxH8wkr?=
 =?us-ascii?Q?cqgiLGXnb+IDGoCHd3Ha1w+l2G/ZshNaODTf3lMJB3RzkDdjQWt0+oVD6ex6?=
 =?us-ascii?Q?5GZAm8a7YuJencu16EuOX7vkqRW4ZW3MwKjUEjmKunBfXl6CS/NiRxlAv43D?=
 =?us-ascii?Q?AnauGItfESCtBqkxGjrsKaxY0vmevyBMrHIK1SoNDFO5GMrcggfHlDdI0ASU?=
 =?us-ascii?Q?T8DWF0bEud5dxvnc+GWhqCRrS5Ud7yl1BrxRRknomJyXtFUBIV1fD2YmMTVH?=
 =?us-ascii?Q?9JtsFNNupzj9Y274RsvgmOk9aOkiV142tZGnYFQSqWeUF6UUN2hPnYohjkp1?=
 =?us-ascii?Q?qIiULCHMH6PPpHSK5bRxntnLSPg1squEoTA1fZLSJiNRf+VYx5w4Cz0uUDxH?=
 =?us-ascii?Q?kygF1+h42WnxNsj34To/eNFVAfASeY84KkbAaJ9C2eZ5C5H2D2tb7SSZYcdt?=
 =?us-ascii?Q?sK6fOPVmDTmc8Vct4qoBwQcP8Np/nnupsulfItWwhK45HLNBu9A+hPg0FGys?=
 =?us-ascii?Q?j7KarPOUVmJ7ZPggCb5TqvrQ81GrZMKTqWsU2KgDP62oTmrsOEjNtu67B9HZ?=
 =?us-ascii?Q?XM5+XJiHRj/f4T/yiRxxVDQ7CK68M16DB9ij7axcqS6VBslAhnq8Vu9Z0mno?=
 =?us-ascii?Q?yV2oHpMNgfnX8feeogRaTVt6Emd6Yp4kWdIt79EzuLzQZgArv3tZqF3NUGlc?=
 =?us-ascii?Q?xzwxGFoQPcqSrD1qc7+S/bS7F9r/ku7RZTSOnnSPE5rWlCaQ9F9cicmezWPq?=
 =?us-ascii?Q?oknsWaZ0i6pza3c9ekCrXmxixVQkFXIBCQTzBpbmJFQXKyFGtce+h8ZnBNvn?=
 =?us-ascii?Q?okrWlY4qeImgpG/gDsFCcVXutbpky/IzStq1lWqbWEnt+4udz9FfkVHbtqI1?=
 =?us-ascii?Q?CBmPxgv1e7mF4c/+SwkhFA2txvtYjd6TQsOy/3ptWbSaIu1BRnATbyyQctQ3?=
 =?us-ascii?Q?mFgI7CoJ10q9KLRdss5TEkSKQLPmkkkaecTG1GkXvCl8Xa1pnyQ+vDiz4BRi?=
 =?us-ascii?Q?J/FSn8TrSYyoCHtdt18no03aWrza9hKT70dQgY9sS9DW9L0MqeuY5Ojde2sc?=
 =?us-ascii?Q?Dqz/AW9WBgn6Pt8e26591EHhg0UgfKsUfnFQcCAE7HPaiamXD0eUCJ7nAC7I?=
 =?us-ascii?Q?hVUZ3/kwf8B1J5WcMNgFMQsYIMe3WNbkXHoPn13VGTI4IyI/s/Vzr383xgNB?=
 =?us-ascii?Q?kSaWzRM3fW6y3yqs66d7fsLu6cNbh7B0S6O20tSYJGca6RAvMraW/kqqCeJf?=
 =?us-ascii?Q?9QCKJoxR6aY23q2TSzispj5u8K7Z49ezoF6I5Fvlf7d4OkJgEf4YhEABwzJW?=
 =?us-ascii?Q?q4RnkdfQLqcKanOMrAdpKBqZmDStj6UDdmyKTIvM7c17oss/Dk1/Jwcu6HpC?=
 =?us-ascii?Q?vhgt0KS7SDs6kynOw9WmWHaKwiFuJCHWHkYCG0sMzaMvrGId69iDPb9lyY7l?=
 =?us-ascii?Q?2Ju1agfQiXDvW21Yy18OgEO64+VjxwnoJmu53xyjNDTtpdKIo/bKW2w3dQQL?=
 =?us-ascii?Q?27ZJxPMKiPe6AAIf0Zzuayg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8592.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e9fbf2-3663-42fa-f0ee-08d997b09bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 12:11:43.2114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W4iVmpP0L5d3d6S9JJiKlbjMqLsM+MedG8886P3HpwOU9vzQCmbu3UZKAfmsYTgWWYERxCNgp1OEdOcbjhxVWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7755
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, October 25, 2021 5:33 PM
> To: Abhyuday Godhasara <agodhasa@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;
> Manish Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> Potthuri <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Tejas Patel
> <TEJASP@xilinx.com>
> Subject: Re: [PATCH v6 1/6] firmware: xilinx: add register notifier in zy=
nqmp
> firmware
>=20
> On Mon, Oct 25, 2021 at 11:53:17AM +0000, Abhyuday Godhasara wrote:
> > Hi Greg,
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Monday, October 25, 2021 2:05 PM
> > > To: Abhyuday Godhasara <agodhasa@xilinx.com>
> > > Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja
> > > <RAJANV@xilinx.com>; Manish Narani <MNARANI@xilinx.com>;
> > > zou_wei@huawei.com; Sai Krishna Potthuri <lakshmis@xilinx.com>;
> > > Jiaying Liang <jliang@xilinx.com>; Jiaying Liang
> > > <jliang@xilinx.com>; linux-kernel@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org; Tejas Patel <TEJASP@xilinx.com>
> > > Subject: Re: [PATCH v6 1/6] firmware: xilinx: add register notifier
> > > in zynqmp firmware
> > >
> > > On Mon, Oct 25, 2021 at 01:23:45AM -0700, Abhyuday Godhasara wrote:
> > > > In zynqmp-firmware, register notifier is not supported, add
> > > > support of register notifier in zynqmp-firmware.
> > > >
> > > > Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> > > > Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> > > > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > > > ---
> > > > Changes in v6:
> > > > - Minor fix
> > >
> > >
> > > That is vague, what got "fixed" here?
> > [Abhyuday] During rebase of patches on your tree couple of lines code w=
as
> get mixed unintendedly in xlnx-zynqmp.h header file due to use of "git am=
 -3".
> > I corrected the below code which was wrong in previous patch v5.
> > +static inline int zynqmp_pm_register_notifier(const u32 node, const u3=
2
> event,
> > +					      const u32 wake, const u32 enable)
> {
> > +	return -ENODEV;
> > +}
> >
> > In v5 it was like below, which is wrong static inline int
> > zynqmp_pm_load_pdi(const u32 src, const u64 address) static inline int
> > zynqmp_pm_register_notifier(const u32 node, const u32 event,
> > 					      const u32 wake, const u32 enable)
> {
> > 	return -ENODEV;
> > }
> > So, the body was missing here for zynqmp_pm_load_pdi in v5.
>=20
> And why did you not describe this in the changelog text?  That is what I =
was
> asking about here.  Please be specific, as reviewers need to know this ty=
pe of
> thing.
[Abhyuday] Just to avoid longer change log I added it as "Minor fix" this t=
ime, but will be taken care this type of things from next time.
Are you expecting the v7 for this time ?

Thanks,
Abhyuday

>=20
> thanks,
>=20
> greg k-h
