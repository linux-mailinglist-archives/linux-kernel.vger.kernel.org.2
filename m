Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D053C2073
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhGIIJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 04:09:02 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13708 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231286AbhGIIJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 04:09:01 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1697xOI5007298;
        Fri, 9 Jul 2021 10:05:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=STMicroelectronics;
 bh=86lJcBa/fdV6JLHVaQamNfgdV6di5KKXKmmM3s4H33Q=;
 b=pQQ2TUAj0woDgFlbdshlpr94xxd1hIYrKSIS8dkSrXJmULbRB67ywtTFBYSWq+fS7GHM
 5nUuB14HXECMi80j+kX17UFe0Lr0taeOVk2juqZKpM48H/6T3FBGduzeEnHSEa1YYWaJ
 KIRvrCLD7dPvYXKf9V6sbIWWVQjTgKqLduDg9ODunIhkfbDzg681eGGH/EQW2RiSNcrR
 XAz3ShuLP5MPHEd8uqhx1L6i8WuRab0LTDK9osiZfGI5F4d0dQ+AI99JqLIzut1T+mry
 94UVNdNP+BfYdCfhkYO0T9EDY1KgV5btfW8LG0cGIYaU0xA6ztjsHowQV9t7hk6L946I yA== 
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2054.outbound.protection.outlook.com [104.47.14.54])
        by mx07-00178001.pphosted.com with ESMTP id 39ph72gmqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 10:05:59 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8qAbh63AZ8u+bnkuXuqPlwc0sNwePinydhqEpTnTA+E0LyDhD96BmGPAp83JprquYr5/c4SPGfqo1X0aXQL1PFRQennVCQWSrnn1Qg/6r8wJULzLWtCnK9YpYmPBHXS8MOlr9XxviveaGMw7p6XZaOERokKsd32usmxzfnhYw9sxuYMSRFBMxFFzXG5qq17iswZTEIYUeGhL20H7dFLrAkttitwpYum6NxNtRDSxIb9pe1OvtxC9Fn3PIY1kUQ8Uq6ili+xt/XMy9sPJZo7hINGNGiOXLKfHEA3+RDSq9K05/B5meYBG72GvXEzxVSUsskOqQTedUIITOQKJR8ybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86lJcBa/fdV6JLHVaQamNfgdV6di5KKXKmmM3s4H33Q=;
 b=ihOAK85PKuUMxo5/sIxYzsyOA3V3SH479Jfi4iBnt1tJUiLCUK1X+B/q4dC95Weje5FvejEmiiS+KwvPKhfabliI++My3y319djo1rNebp0g7CKY3O4qUv4CsFQTAFHE9qNZlSqYa0k5S6E4wPI4Xfb3WgU6AIMeOSaoxO0nfwP8LyOUC+RzzS+xh6o7NNWMd4d6ykYvaTOVzf32AIU1uzrZwBm3lxX88+OF25cnOUIaTP83oAjqX0fdNFFvVGkKsSl9FDvrDWp66De1nKzcSzNLW9Xp6NgpyoxBROHrCU8iYicK/idCscAHtvMgTd6YWRi2woBpPNHl62+d6DHoyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::13)
 by PA4PR10MB4432.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Fri, 9 Jul
 2021 08:05:58 +0000
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4858:5053:1e4b:698f]) by PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4858:5053:1e4b:698f%8]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 08:05:57 +0000
From:   Etienne CARRIERE <etienne.carriere@st.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jerome Forissier <jerome@forissier.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
Thread-Topic: [PATCH v2 0/7] Asynchronous notifications from secure world
Thread-Index: AQHXdJS65UfruOlOmEi1Z/kon7B6Yw==
Date:   Fri, 9 Jul 2021 08:05:57 +0000
Message-ID: <PAXPR10MB4687E737261282B78600272DFD189@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=True;MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2021-07-09T08:05:57.619Z;MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=ST
 Restricted;MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=0;MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard;
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=st.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2695f2b4-e429-4e46-3c49-08d942b06234
x-ms-traffictypediagnostic: PA4PR10MB4432:
x-microsoft-antispam-prvs: <PA4PR10MB443227DBCDC6D77451F7D3A7FD189@PA4PR10MB4432.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eJnXDJPMZ/7YXw/sHzG9QEyMVT7KlEIshJYs5vb1oPMyQr19rrLwTiCg1nEq2M9H75Gwjqe0e9B6JgJ6E9An9sMctPUsLjdbdmbjeOBtbuJ6rNmnm/5XTzS6FNPWFIqThs62CiG+udLukEhemYZ+eA32FJ17AoH8CczJIIhod6WQdOXMtBzZpzrMB7/dF/d2iYkg9zmj5Y0SzhD7OZOYLIrtXBu9eW0FS4jOSaaD+EPZu/hRNF9QJYoYjiKNbxmahX5NrNlQ3so3jMCI3PHhgeiQtOlWKNm7eH/uEv1WD+J2I7dSKtZWUG5vvuZjghISMxBw2DGWkLQEMG4YMgWcqyS4ba7+ThdDYzQSunw2/M9kjgc2Fm22TSfnilJgW5wjGDB+6/HE6iEh4RIvG0Cl5tvFECGPzOeryHWZ8KRiT5tLJcrimeIH0JgZ9zeYcJaXGlmca+ioGDZ+qVKiok5tUsjgIqb1XyZVAP+lW3CTQXv+csq4aN5Kt5dLXBjFlNalT4FCFD/5pIXkBVDNiLj0hMpVct3m8thkjoXuXAc89l6Mtabu90Hf8p1HnphdHXzHcBBxlqeII8NYKXJGIa8RD8BNTPBSWam7wpwjGFDFjfZA8oULTgrlTunM8fY2xUBRvyLejjkaVDLVRkzHTBeWxkM3ix+lhg6bE+UDJXogkSoityVYDoIRQLHE9bBBzSc8/tb6hh8mqUMsehhvivQGVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(66946007)(66556008)(64756008)(66446008)(55016002)(9686003)(76116006)(2906002)(66476007)(86362001)(7696005)(122000001)(921005)(6506007)(33656002)(15650500001)(186003)(7416002)(38100700002)(83380400001)(52536014)(478600001)(110136005)(316002)(5660300002)(71200400001)(8936002)(8676002)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8qqHvlMw8/ycKU4hWtehmO2yb4ix0zZqOqAPyK9jXjy/E4+0+5IIzJvdqM?=
 =?iso-8859-1?Q?SxALFmha8IqbG54LW6vCrY5//QLtgM1V1QF6MwQMXd4zu/7fT3G23945cM?=
 =?iso-8859-1?Q?o0MF3+ypo7mGAL0Z8cq6bZiAIDuEGnlNtVxH1kFQfcgCmB2aN+Kx1i2C7j?=
 =?iso-8859-1?Q?OAOzu9VuoxpymiGbSL8OpAUS6DMTzaOGJJwv/KgEth9wRZXnW0E9Qghebz?=
 =?iso-8859-1?Q?+1dpw9qu8Eixs7iJThYZlbrjZXz3NtA3sBX3bOKsXsCaBIxLEbMZS84Niz?=
 =?iso-8859-1?Q?BakP5o06ryULd05Ard5gSFCwLc7YlsFozPvYG9mkhHGWbr5wGUmjuyL0Of?=
 =?iso-8859-1?Q?9zf9zdPrYWIawfeBE/VLpsJktrdkNUcLSsufO78nwdUYYYpHP6onCkGntJ?=
 =?iso-8859-1?Q?r4TW/xNlbRvic3e8rrputQ85ANoA/8BUqSp/TxO9LVjW6ZmF0jrIV2ohLX?=
 =?iso-8859-1?Q?1My9Y+7nrVbWO2hpwebJuOq1CurwPjxh2FofukOHwU6qeQBHik+o7DuxHL?=
 =?iso-8859-1?Q?1fQIOdZpsfnAijw+B5bUMtui/yBu6HK17B4l8WJID3Hn1lgsBl150BB1nv?=
 =?iso-8859-1?Q?5hvE1NQPm2ihwupmzW7B+wPK41WBPsawKeHQ5uN1OH1+njhS1cQNdmuita?=
 =?iso-8859-1?Q?A9Xcj3rW+EmN1KhslMPVFVMeDVI73I17jZDU0MM2LoQbQLyVFdMsVWKS7/?=
 =?iso-8859-1?Q?uIrO701TJNt7SmqG0Zi70EfvTev8juhcQgOu8TYd2zWF8Xqx/uiFxRxPbU?=
 =?iso-8859-1?Q?BhESZMsOlecmybk9H49BWZbw/j2+zxjBfyOMr7s6KJ3P3CJKmZEIO9mZ6E?=
 =?iso-8859-1?Q?v1phJnyuAdq4+Vf7QIckCFN8zLNJuOuUr/0JLOr3MtNP0XjOtGYAD1N9Sz?=
 =?iso-8859-1?Q?MGctT0z1W1MIjwcSFb+zKaL8tTY4ZOcNM//HnlpYBmdoQE8ABjAywKnawc?=
 =?iso-8859-1?Q?LcnJ88+d4NIZR9he17DZy3tnkmxlLvZFdxe8E4ADV+lG0nypCr/Xrm28Fh?=
 =?iso-8859-1?Q?WrDVyNaqkNJzog2Utx983WRkPpqFfxv5OmYALWolObd7elMSy3QOy1YVLo?=
 =?iso-8859-1?Q?Ci4ZJws/K+jN5Pspe4NUFjxZhDWiXK+hbXg8q+pHvY7trLDgd9cutw4a5+?=
 =?iso-8859-1?Q?94larppPNBL/GOL2P0qCTLQRinWS4IuJ1NIFTEa8W1nF4QtGQfL+C4AqKD?=
 =?iso-8859-1?Q?CqF3let5m3its+z9wTkEkb9lTGaESaJHAQKbCzX6UE/qEydoT1gbPKok9w?=
 =?iso-8859-1?Q?iymeS+zvo3UUUzR3wlCEIHyG9hEnHFfcSoplGEsXIEXpQlsrGDoUBJFQy9?=
 =?iso-8859-1?Q?NL8wkzPkykhJn/gKFurytVh5GN6QJ1CWsZVh4nXOZ58sDQU8ZasUkgKFpS?=
 =?iso-8859-1?Q?T5pALj/dbTsDzTFHaKEemtHA4VH/S0LtyBRbBfz/kW7912iUWPKJ49sV7X?=
 =?iso-8859-1?Q?+YPLbUhqu8+AJt3i?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2695f2b4-e429-4e46-3c49-08d942b06234
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 08:05:57.8136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AtBMpjd7OXkMJCUdwBQTrFl/GXaoy5pdeHWrNvmLwDDAFWc3DALxwZZeHyqIh6vhpddZXuutRC7IixlzHxnqiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4432
X-Proofpoint-ORIG-GUID: f0gF-y0XNNStRcuuwNtT7YJLwNikZY19
X-Proofpoint-GUID: f0gF-y0XNNStRcuuwNtT7YJLwNikZY19
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-09_04:2021-07-09,2021-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107090040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sudeep and all,

On Wed, 7 Jul 2021 at 19:52, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi Sumit,
>
> I was holding off you reply as I didn't have all the background on this.
> Achin did mention that this is preparatory work for FFA notifications.
> I did mention to him that this is more than that, it is custom extension
> to address what FF-A notification is trying to in standard way.
>
> I share same opinion as Marc Z.
>
> On Wed, Jul 07, 2021 at 11:22:23AM +0530, Sumit Garg wrote:
> > On Tue, 6 Jul 2021 at 18:16, Marc Zyngier <maz@kernel.org> wrote:
>
> [...]
>
> > >
> > > I don't care about OP-TEE. If you are proposing a contract between S
> > > and NS, it has to be TEE and OS independent. That's how the
> > > architecture works.
> > >
> >
> > Agree, here we are not proposing a common contract among the S and NS
> > world that every TEE (based on Arm TrustZone) will use to communicate
> > with REE (Linux in our case) but rather an OP-TEE specific
> > notifications feature that is built on top of OP-TEE specific ABIs.
> >
> > And I can see your arguments coming from an FFA perspective but there
> > are platforms like the ones based on Armv7 which don't support FFA
> > ABI. Maybe Jens can elaborate how this feature will fit in when FFA
> > comes into picture?
> >
>
> I can understand that but won't those platforms add the support both in
> the kernel(current series) and secure world to address notifications.
> While you could argue that it is small extension to what is already prese=
nt
> but I prefer they support FF-A is they need such a support instead of add=
ing
> custom mechanisms. It is hard to maintain and each vendor will deviate
> from this custom mechanism and soon we will have bunch of them to handle.


There exist armv7-a platforms that expect OP-TEE notification support and w=
ill not move the FF-A, like the stm32mp15. This platform won't move to FF-A=
 mainly due to the memory cost of the added SPM layer and the device physic=
al constraints.
We have a usecase for OP-TEE notification. We're working on the integration=
 of an SCMI server in OP-TEE. SCMI notification is a feature needed is this=
 scope and it requires OP-TEE async notification means as those proposed he=
re.

This OP-TEE async notif also brings a lot of value in OP-TEE as it allows a=
 OP-TEE secure thread (i.e. executing a trusted application service) to gen=
tly wait on a secure interrupt (as a slow bus transaction completion or man=
y other usecase) with the CPU relaxed. This support is provided by the prop=
osed series. I believe existing device should be able to leverage this OP-T=
EE feature without needing their OP-TEE to move to the new FF-A interface.

Regards,
Etienne

>
> [...]

ST Restricted
