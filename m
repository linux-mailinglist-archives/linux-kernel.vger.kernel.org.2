Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640093B4572
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhFYOXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:23:31 -0400
Received: from mail-eopbgr1410128.outbound.protection.outlook.com ([40.107.141.128]:28111
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229700AbhFYOX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:23:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ao6aNbCcIx94XYaGDRgI4YgsKJPL19s2xYKFzygWB5PkZuLX4PASjFXxGKj2MR9uEf2nJh+Z3mNfzK7OSY728OANG0ZiwxvhMWcxPTyhYGu/ph3qdCa/jRyks5Y0/nOWmfyLGlvv4wliOmtHTouPF5Z7yAFadnSo8CovxUEgPFce3AbskxhbOBR+rkPehUY63bLqIEwvh0FFXf4jAn7x6Et8KLi/O+PMdh0ZzDZ2gLnyrShdzL8UsnPZOLFfaKer23ubwJbqAT+d9V9+n2dvI06DTPblBN3i9jc0WK5kOv9dD/77pmS0a0fohlr7q3Tf/87CYztNqyhZ0nWPCQi9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RosX2/L2oPRypuZqL2hxk0j4aZ6L4GenKqR+SaNI87M=;
 b=lliGrMDJ1lHcIXbjagVlCpwEtD4wNt1/FVXh2d/zvEMrwQj7YxzsC79fnoQJN9PZSXAOAVYDyQnlYYSFgnGmbSbPaoSYvrOS22rQYZNiAXZVkjAqGJZ54sXPvG8PEeQ2pqtlxq3vv/KUloDaplSbevZbPWMup6ul1BPSyyF37Q6qDFX7771iRprINVyXRhTEAOZzdtif+S8TSdnCggtEMnN+d4zN+QLQQMnGsHl3d+qu7YjdiFQGaK9ogcS3+TkeeZMoEnQR6C8Tasp2CDP+snZe8X3l7CZUXAl1VEp2H0wv3a40dkp/LSci6+8m3h1IE6bf2/6hnDkk02GiXy5XUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RosX2/L2oPRypuZqL2hxk0j4aZ6L4GenKqR+SaNI87M=;
 b=XqkosJthFAcU7PLWYY8mldnXaVmnYVdHcfwww/RMmLlHk+enMRsJCjdDk5m3VlCBVI64qa/bLXzpzwsgNMZB4/3XNcM2VuLa++8LpN0v68mAic4izASutzGVDO+vQjW02vA9WhRwK7sjM6I0bOKSWXjxb29/f0GISHX26Lep+ts=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OS3PR01MB5990.jpnprd01.prod.outlook.com (2603:1096:604:d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Fri, 25 Jun
 2021 14:21:04 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::a53c:198f:9145:903b]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::a53c:198f:9145:903b%8]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 14:21:04 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Min Li <min.li.xe@renesas.com>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH mfd v3] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH mfd v3] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AQHXZGBI73dhrC6Hl0qCeqEere9Wyask0ZCw
Date:   Fri, 25 Jun 2021 14:21:03 +0000
Message-ID: <OS3PR01MB659309124542B0D712FC9DEBBA069@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1624034232-7952-1-git-send-email-min.li.xe@renesas.com>
In-Reply-To: <1624034232-7952-1-git-send-email-min.li.xe@renesas.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: renesas.com; dkim=none (message not signed)
 header.d=none;renesas.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c774beb-75d7-45f8-cb56-08d937e47734
x-ms-traffictypediagnostic: OS3PR01MB5990:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS3PR01MB5990046CCC9399CD1204FBDFBA069@OS3PR01MB5990.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D0MVwmEjZXEMEyiu6r7AblGrcZcbY0UQ+cMYRbhCW8y3bGxV4aYnPiXtHWOT1pVim1qTQSLBAccylosphW9ms7xDGtWczXG2CAsXXaZJxuHVvG2rPX6a3oi9WINOXAS6oNX+fIIJEHwDt2tbF7z/RvGNyJuBmY1bifaVks2XEmS64YHDw3RncosgXw8K1MDlgVBO9qoOx6wdHYZIWZGaO14lsPXWx0o5Xo+0wN76cequ/UG+W70rFvc0IFTokkxzWu5FeSvpwx5t6/vQu7g/wrpH85eMRzsNPUPnK1Bj8+a1tcoKtp8EUoVtBD8F26ZoPhC6eg2+Ejn6UDYfL5GbLaS/dNFAeVNv/Dj6Xq4jxvpABKAD/RqaFVLwYrDmQ3I97iXWVkHWOrzECRSDYY81/654G/GZ/VxbVenqqIxFDxEzCxNq+UgdM+8lAHwIVdEerDCtKeEijscU6d4Ig/KuSL79VgGoZnVwGn0U1xk6qwgNHpNFicbbovZTIsk1O6g4vrJHuN8s+xKmt7lVXiv+CF0ND7bcJkzgMnOzOWb7xIzjRKtwGf7H+PXOkNjkgfbnfvOs0uzKWhDMbx+jg+RXfrxjBMtheGnda2D+1P6MRVU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(110136005)(6506007)(64756008)(66446008)(66476007)(54906003)(38100700002)(2906002)(8676002)(33656002)(122000001)(66556008)(558084003)(86362001)(76116006)(71200400001)(8936002)(66946007)(5660300002)(55016002)(83380400001)(26005)(316002)(478600001)(52536014)(4326008)(186003)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?irLVtjl7XxVcwIm+bc3wl/mqJAELDgYE9WEUi4F9Pzo7G4lPfaaiylNPZvkp?=
 =?us-ascii?Q?L3g/F0lHMK+ZD6VisuB5RkXIFHQBPFl/RSujAwQWYqrzu2KlLbuNyek245Yt?=
 =?us-ascii?Q?1VJzsEolRyMwODZXBNSN4JydxT6aMo1r60GjQ4i0vhk4xOvEYHTY46kSFZob?=
 =?us-ascii?Q?8ZJorBLC3p5rKoGEe3/xfgC+o7QBbbM5XHYQTZDYc6oQEtcu6BJLZWIrxMPR?=
 =?us-ascii?Q?nZjp4A1UszY7DqcD+Id9b4NqU1TrLZ0Ar7rwL3ZzWR8/QAFpis9TD7HQ9y2j?=
 =?us-ascii?Q?rCjjJwTpBtz+xIdAhqBDDZTdrBGZ2PYapNYLtL0cNMBIC4Am5Ouah66e984T?=
 =?us-ascii?Q?5RYi8a3z6xrdgMfMadUlaN681UiBtfZJaq9cCDXwcHIspZ/fzBVYR9qOihpS?=
 =?us-ascii?Q?P3cyZoYtWnfbVyZERDWCWqwnqe/soPIY0jFVcRr5tuRtrcohW4BpTh4ovviy?=
 =?us-ascii?Q?gMVa1JqGLphC39BG4Fb4jpgGA/+97kY98F3/D8QcA/HA1l3CAPY+X0aD6mL7?=
 =?us-ascii?Q?D4F5bNpCV4KfWwDwPObhM7maMZSzd/YBcK4LqNMHh0Wenw2cMUtoxDQ7r9dS?=
 =?us-ascii?Q?UGeNNkJGK5+Sd2wN/ZpYoGxiiMc/kcjdh9kdzZQN5/KD8PjKhqmvfpm8lnSV?=
 =?us-ascii?Q?yPN6Y/m7bVsHXi4l4MhYcHej+zxVy6y++DjHg33ZYFcQSSNRM4OQVd+1322f?=
 =?us-ascii?Q?QHSDgJHLuyzq3aeFi3mhbyPUJ3MyRHIVanwWPmHYhwkV8E09xD0i4aJ9bpGG?=
 =?us-ascii?Q?XD6MaAaLVt5tOapYnfrI9eRjnnAt12S/OTnB79QXzczzvGCTJ0l55ovOv7UT?=
 =?us-ascii?Q?afclEUPzQpR61I21pdY+l/YdO7J7s0BR1Eqt+1Mryd7UBF402krpAncteTcr?=
 =?us-ascii?Q?84gt3hiNwi1+n94GXzsbGrCZGg+0urQXkkxkD2U4R1AGg9aYw8qsRN+YeITQ?=
 =?us-ascii?Q?RXnGth7sK7xRBU6rzlfLpj/PTIqVdrsfnwi6U6rr+S8dPQKTHwU82IwuGAAc?=
 =?us-ascii?Q?SLepraOy5/qPp6tWRrdbxzWvRtQFS2l44dxhFwafE5tn4OFX2hV26n9zZo45?=
 =?us-ascii?Q?Ez6Vhb/KTsuiB6+cA6Srae3ws0StX387t91vHeAnPWjJau5cViBFGG2NAS28?=
 =?us-ascii?Q?rRqnKIq/ZeL1sGmFUbzn5Rq1jrMKFYvUIOHYigpyESnbhVqu4DPUJao6Yz78?=
 =?us-ascii?Q?JhPYDmut97TvxHmw6JBBlOp4kFvL7rXh47L4avc7B/QOfI3XiZ+dImi412Um?=
 =?us-ascii?Q?kb0v5A3/Hg+nqXZbGRUyAmSSPndLp3eBO7AffsiTJU2en0+V/WrJjfqaDB5g?=
 =?us-ascii?Q?4sBrLSJxC0DzH5WgWlXRO0gt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c774beb-75d7-45f8-cb56-08d937e47734
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 14:21:03.8947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lm+wydwZbLJC5R9vbit5BW4h1VuuhTNAdKe1HNgby9RMXqnET/Rhp+4Ft2q72wmOuxTe7Ayw9D3U0gOo5sqVEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5990
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee

This is Min. I am wondering if you have had a chance to review my latest pa=
tch?

Thanks

Min
