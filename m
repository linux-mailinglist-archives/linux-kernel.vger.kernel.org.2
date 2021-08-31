Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FDB3FC93C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhHaOBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:01:12 -0400
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:47341
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236942AbhHaOAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:00:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THIjGAHvhzV344B8p4e8j+Smf0WFKo7BhvyGzSw3QjWydXIGh6ZuFtnupZ06Hkgj1D8lEuqsxU82nQeD3x76BbCPOqUTvA9FfxBhuU4zkyhaseGyeBRIeAAkl5+NYeOhEbrzN3TjHNnsgTyL0LPf9/CSRfGZOUhZCYnEoVRmhPD2ammC63jjIt3ONR7cAaSBbQ4dG/edIL3Uvo2sggzcEpcDh22UTiQs+B7mpQ7dc/sU9F0FPKpM1dqJggL+yy02DBSWzDabthwM/r/o2ZGU5W6j2C6NFAzSB+YSQcMq9b62ua1LFQCERFk3mQQ9YIan2/Z7x0Ox9kOoS8I1s6tuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QZyEK+m2IkhTAPxU992bFYNR3uZKKmV/rLqRcMyEroQ=;
 b=kewNvsIfPw0gzWOxRGIBTEyXHgrAO3HNcgNHjUD2SsaUM0gUDPMm2WC0M7hc2maHl57+rfafRdunlPDHFp4nAJGNG0gwGSp1bbAB2wHvRnqeCNZhxnrNw069+AjCim+VsJaSagQ2k3rDlbXRArX/Fxdh1eZEn+io6PM4kwrd3eY87nSjHge8NQ1mOwEcsRZAMyVKkcFkSgmfZf0bZgG27Fz1L+xZisOwt8QkYp6kNqjveaNDzE0FWzBUIx5gIDLZQKjYXpyQ5S+oHSSfUv5n1dbiS7V6JR9Z9+CCb+fvp91V8b+8Iw8/SeU4URle3wJm0Yp5o7SEYBScsvCZ/m5s4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZyEK+m2IkhTAPxU992bFYNR3uZKKmV/rLqRcMyEroQ=;
 b=BwnpKhLeFzTUNzjp1HMH9V+IVz2dLRXgllBOCg6Cy7wngIAT3v5975ClxYJlG9RADUttHaTvxDUJ04chpYSNCsIhzlsyz+3nwly1Br7LMQrTUvML6rLYGMrX46DgMazYZLnT47S1magnWGAibBei7q5fU7VcYV3TurEmSulLdUc=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VE1PR04MB6512.eurprd04.prod.outlook.com (2603:10a6:803:120::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 31 Aug
 2021 13:59:17 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0%2]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 13:59:17 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 7/7] arm64: dts: ls1028a: use phy-mode instead of
 phy-connection-type
Thread-Topic: [PATCH 7/7] arm64: dts: ls1028a: use phy-mode instead of
 phy-connection-type
Thread-Index: AQHXnm3EiJALWCaAGkmp9YI1iG/tB6uNo+kA
Date:   Tue, 31 Aug 2021 13:59:17 +0000
Message-ID: <20210831135916.ccvyc5intxs7rlal@skbuf>
References: <20210831134013.1625527-1-michael@walle.cc>
 <20210831134013.1625527-8-michael@walle.cc>
In-Reply-To: <20210831134013.1625527-8-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff437862-3dd9-41fc-251a-08d96c878613
x-ms-traffictypediagnostic: VE1PR04MB6512:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB65126DF200D087B2216953CAE0CC9@VE1PR04MB6512.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ssTkoKKc/NimH37hK89YZAJxWCXO1/JZYXMi1VBMhfK3s6qoa+5A6ySFhZik64qWGBJ2wTWBE/k2IOL1hrJMq6YlINpX4B+8RlEDkPj0qBe3iYIoNDoLYOhklXu37yrjrD6pc/0TdfVD+FmgIF6ar9CJ4F5/mJygpXMiBwvzyu+ytSF1Tq76w6pm+dEV2E3MuhfOt+rdrhmn5s+530xiFahIuS06uHNlR3nlHD3HV+o7xjLEyJVeIO5qNvimSkhICpPiEoB1q6r7d8Zf/7uAbg6wLFJDg3lNjHYcNjrywYO2q+LuJ+YKx+CPzOf8t3y+Y+9ZfoqP09Hg0bCMDUc1cgGLWzebgcD/0ZgZgnO/QRi26BWGXKzDBA67ok10Pxefup16lI8irc//D9NhqR2XQj2550x6+VwpuL++ISu5kmNHJ34GQPqlTdyixw6tI3/FDI9gIwlbebS7bg3WKphlWIVKrVamBZTja9hjtb28fb17iel9aja4vWzKRpz2akrYeD+EKyldpZ3Xo4d8iUsuM58QcQMidYNATMMvczks5YhxhnwO9nD3csBHL1jUt+qhCwkBYM3hfLpJth+jbGkdoX1UmqRYhAGnchzd8G1NTFrUmmFZtvsZlXyiKxf8R2tKHgRrMmw79FKPuitkZkHmlh1Q5VLxjPAG/0UwMDemeUdbjwv819I/jBouZ6TAlctbiEsKolZMCR2fM5seN8brzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(54906003)(64756008)(66556008)(66476007)(316002)(66946007)(71200400001)(5660300002)(66446008)(26005)(6512007)(9686003)(186003)(76116006)(91956017)(6506007)(44832011)(33716001)(38070700005)(38100700002)(8676002)(1076003)(122000001)(478600001)(4326008)(6486002)(86362001)(2906002)(8936002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iKHScwQkjj5mdAnki6HR+3Q/NIkBTkvafNme0HxofOFzJNR/g54wnm1oMMsK?=
 =?us-ascii?Q?0LQ+T9x/LA6hEG7SZ63nBmkfyRPpx3xc3oE6gwbHYCSfvoU9YAcPg1yhdG2b?=
 =?us-ascii?Q?YYTamMSPxZa6tQnl4YeGCIMJtwUGiTrhtlb2T0bi9bwofRR44bcFWDeH285z?=
 =?us-ascii?Q?JagqkEW7M/4b47D+z0tYOJq4YQ+u2X67kSRc3DCfl6f4Uz9DqrakfxgJJlsq?=
 =?us-ascii?Q?vtfux6JmnvuQqdZyxSh+JAHE9ekd2lbLPrCIew7w8umYWmvNVr/KmPJ6Ct8X?=
 =?us-ascii?Q?fLErsT81Omlyxz7WKCE75PY6PR+KP9dQNpDuShZdoNyNZnQgAo+qvWpBm6wm?=
 =?us-ascii?Q?v0STZK9Il9sbTQEITUyCOVMvfo3HOV1dU5M5dkgIFErWQfFpb7dtJeVKLRLL?=
 =?us-ascii?Q?da/iVbRol/N8FrdmH3gmQ9+bUA3mUJYY0yIvnYqfoSSbOCc0xjM0ozfy6wG/?=
 =?us-ascii?Q?4jvQFZL7lC0wbloYuOPSSx0eL7Csq4VVpCBbQ5cnrCpcc/Xg2W43ksriR3EX?=
 =?us-ascii?Q?LYHCy3+tbtUNJGko1UuhM4GB8jTc4ouJcA85km+Yu6Imdgn7rqMEsHni2BdL?=
 =?us-ascii?Q?dzro6SEc3Kp4p3F5+/YXKF3yxuvNYgodD4PaNthffH1kfiz0JJaAt3hn3Rp/?=
 =?us-ascii?Q?vOi6JBj508bxSEmblkIEFjTqrsOyuHUdjtx4WizKmIMbTQwX6mEYQyhuhMDP?=
 =?us-ascii?Q?WE1xjEf2wSnyHJRt/knAjvAuY78yksIB7tL+xfDG2PId94HiYxQP7Za7cn6k?=
 =?us-ascii?Q?2jey5ykeJElybdE63ExNAu5rFReu3OtCMF4bN3WafeSRQa6U24SaVsY2vccq?=
 =?us-ascii?Q?UVoFf7lIkleY96SbNe9YZ6j+h1V9j+B4o+gPCF9ua0Uu9TN8ASAdHJFr1ZBu?=
 =?us-ascii?Q?hZKCYOlszXVB+L+HXCj1Rf1xb7EZNk0X8ohMncmOK8oBYGKiXVjZlEnDx6oj?=
 =?us-ascii?Q?/gzR5W1nyTNQ7i56ECL+OlKwbMsQJKRhb7c1Ba+lIBU2OrXX/Ra5FCuHkACk?=
 =?us-ascii?Q?t/pwWjrY1KZxRDk8c8w3Lp62nrh55JZvgouq13efOidaLv5nNiLwLeBZxlcA?=
 =?us-ascii?Q?N4q1nd/wfsxe/3lLc754IZAC6SoGEMkynB0Slwq66gQGjQHVe3jUyAE6fgcJ?=
 =?us-ascii?Q?jAFRyu26pDt4lqLe32nFnyzYdP7qaFRjpvnuP6b8V2YHCzMpWdJpCj87CyY8?=
 =?us-ascii?Q?YMjB7I82W6w7P8s/XYrCdmocDJqjRz0hydHgOiw2SFXjXCdZFvsBrQo9Z3QB?=
 =?us-ascii?Q?CsiEAriGSB8YO0uAv49q3HRzRCCVU8HU/sfu4iVbg4c/WVnKIoxv9ggMKcAy?=
 =?us-ascii?Q?O0oc42kgzE7M3J88wq93zVqk?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A40EE81CC3C6A40A7E8332F6B30024F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff437862-3dd9-41fc-251a-08d96c878613
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 13:59:17.4822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZlhsC2ZpnmlC5FUcnjnCmUBfoHxQBni5rPz5Ae5X+zlqAXlNejdiFzWNp/gPUC3Tupd5Mxf9xUSIoVKuviyaGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6512
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 03:40:13PM +0200, Michael Walle wrote:
> In linux both are identical, phy-mode is used more often, though. Also
> for the ls1028a both phy-connection-type and phy-mode was used, one for
> the enetc nodes and the other for the switch nodes. Unify them. But the
> main reason for this is that the device tree files can be shared with
> the u-boot ones; there the enetc driver only supports the "phy-mode"
> property.
>=20
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Actually that is not really a valid reason in itself for this change.
The enetc U-Boot driver is perhaps a bit silly in that it calls
ofnode_read_string(dev_ofnode(dev), "phy-mode") manually, especially
since right below, it uses dm_eth_phy_connect() which searches for both.

So we are artificially restricting what we support. It would be fine to
do the dm_eth_phy_connect first, then use phy->interface for enetc_start_pc=
s().

Anyway, I do not mind the patch at all.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>=
