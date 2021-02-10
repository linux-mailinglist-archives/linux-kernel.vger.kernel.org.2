Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A615316A68
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhBJPmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:42:05 -0500
Received: from mail-eopbgr00046.outbound.protection.outlook.com ([40.107.0.46]:65152
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231894AbhBJPlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:41:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm2CwMIuNkN2tEKvoOR4iv8XCRFKFFTVRyl1fDbTf1gG1B7SHE11B28LD3OWz2V21FrjYEdsy8OWXK91S+aan2mxzSvufTuU46xzYkOZxXYKIJLPSFcJ4y3f+U3tOE4LBwNCWiUeLDL/wwXdqLwEluf9OoLqF9JMVKlhYXyM7hi3Qw7pbnQpBqEfpyifG/KxNLbq0TcHqZSw92zJCO1HSaqzefr6NGz8hycqAEZppodPbGK9aeB4PQBbRgODXqO+Zrrro2VgHWOb1HNOM01ty66vd31PiaJWTxuvmN/7GGCOHgwakoDwaG/CLiZHWRr9cZ60RxDutcj5rjrs5NgqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5R80X8Zr1i1CGYiuJGTjwB6qVX7KgMz0zMTqaxlJqE=;
 b=e6P3pMapv3www9CmDpfwepeehOarBqs851OrmU+Lqs0ssTtzrEsb6Hq98n3LT16w008LfddW5LRlfIgiIq/n+fVp/wiAnlFiItvEY9rPhlaY3XaYTUmompCTeqlzIHe/H6HSsjM5KD9KOSQepqsd2DxfQU1l5QWu42shdQ6P9PraU3vM2uWpTYxHg4jN7Z0dDVwNdbqC1q4fNEhr5M9rgF1vVdK/X5x/z1iY1NbwrmYcFAZ5cwO0DT4OHsVqYbMbZOmfc+phT3DQSDa62hil/DYGsgibtxs4MlKFNkWARt1mE6XfEUHWWIngQB5vOiBAAdlJgEshuyA5vayQyHJe/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5R80X8Zr1i1CGYiuJGTjwB6qVX7KgMz0zMTqaxlJqE=;
 b=OonQQG667qZT47GsAhVeog689Vyy/WmnCF9z+GvJ8Dc5L72BKJzdW1Qu6oYUJ3YMGtEn2GLyKxBJj/cJUynFjxk+3wqq+OZ79XoNr/sO3eJXMJiGfrNWrsATj7hZkdupRfA2ry+ug9oSQ9H5/CiKfdw4aDPZhJRk4imSfIi8dXY=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB4909.eurprd04.prod.outlook.com (2603:10a6:803:52::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Wed, 10 Feb
 2021 15:40:32 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::3df3:2eba:51bb:58d7]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::3df3:2eba:51bb:58d7%7]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 15:40:32 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: ls1028a: add interrupt to Root Complex Event
 Collector
Thread-Topic: [PATCH] arm64: dts: ls1028a: add interrupt to Root Complex Event
 Collector
Thread-Index: AQHW/n36X417tT1c50ix7Ht/4eSN/KpRiSUA
Date:   Wed, 10 Feb 2021 15:40:32 +0000
Message-ID: <20210210154032.dqvzs4oam3iqwows@skbuf>
References: <20210209005259.29725-1-michael@walle.cc>
In-Reply-To: <20210209005259.29725-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [5.12.227.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa4dc1b7-33ff-485c-a221-08d8cdda33da
x-ms-traffictypediagnostic: VI1PR04MB4909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB49093A1B945F2D736ACE2A1CE08D9@VI1PR04MB4909.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2D+DCwOUAZeJ+pYz4RlBGcWM0BejSyj3U2XhWaCtxVKkVxI+VnF9lKv5vDujveseJJdP2szwHhPb6taCQRICnVeNep5xAiEheO/s/a1B4GruCly4zxDrDrbaPwk08sZY2M5uDS6cMJ7+V81XaX1/TtIGD8Qy34QZYxnlUNfMCdZJpuCrA0FEkICObw3uthj5KeXaJFP34fSxS+IF1yWhsWD/OaEqhnPaJ3H0vdKXhhD9eRfDf15QGCL/pq300ZTjA1Jsq2RGZBfhemH+Qe4sF4EGQQebDyzXL40YreGA87Znn1syA+8bhkp78FE4wvKzetlpk6wWPt/bv550GjQQT3jd6SVnajY7+rkB5enqQfD7VxM/sh6WWES+UUCK/eKM60vqjdbGnMDsyROJJaIqNMtZyAO1/0q9d5DvByLYdvhAvyoB2rHg0WY2SLeLQru+PweVsTLJ4QcCR8Jw708AjE5XtXdhchQ9S49yyNmYV50zyiWry0MxF5Viqeu4D5BSvrwmwCXW6GTxqnNhDVOqIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(376002)(39860400002)(366004)(396003)(136003)(6506007)(6512007)(66446008)(6916009)(4326008)(8936002)(26005)(8676002)(33716001)(478600001)(1076003)(2906002)(71200400001)(86362001)(66946007)(186003)(44832011)(64756008)(66476007)(316002)(5660300002)(66556008)(54906003)(6486002)(4744005)(9686003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sI4E2b3YxqFRIkdHA2tLPx22GrRUy/gBDP4hiO2OC+/UUMNrTkNMtBD6cExw?=
 =?us-ascii?Q?P/JpMLPlAsu1kgPrJE80SjkIBNVLDdnmd+8A4sjw/7vg9+8HFXDOY7w388D5?=
 =?us-ascii?Q?+cAQdfBzn7fWXIq56m5dZsQ8m2K+RdfJDgfGm8c/g2tA5NCBaxdBZfBxit42?=
 =?us-ascii?Q?J9vDJA+SkKz5eiXeKRwOeTRHzExQ8cVKAIxpcV8TJS1HXjVGbFG5PhaVlXg/?=
 =?us-ascii?Q?UyzbJGAox7DSCsVOumRYL6LW6tF7XvHnF2gaMbK5OXPZgkunUwVECPetbiSA?=
 =?us-ascii?Q?xBHoYIAcd7gmK3XYzAP+wQK88RNgKu4rIMHImVzQmODhvo6xI05SZfAYLaBF?=
 =?us-ascii?Q?OSdZAw4vSTSvC4wbswi33nwso5jBhyeVAkmf9pHXQfsX+izRUGnzBb9Pn6V7?=
 =?us-ascii?Q?ihIpo53DsZu+g0c0Kl4D7/5x7cLFA8j9JIQ9FuvGJxxZMS8u53t3wUhsS200?=
 =?us-ascii?Q?Y2os1lqUdpttNKjMYg0YRaYwE4XZ7qCOwtSWxMM8GC4rmAsCqhc5pOstDDxk?=
 =?us-ascii?Q?UbsXcKdt+9A2LGA4ksalrLjgN0L5e5FG4dgIvaobeJVBa9gHLG6T4ZBOzIIV?=
 =?us-ascii?Q?TxamVg77MI7Hjf+kobrVlySS93PNDAO3aJBahKmtqoJdsSMeGSBdwdWUbMDT?=
 =?us-ascii?Q?9PcnAYna7+oewKlJGdMUp1vmR5eeuqGkHOoRDRX7LRNoYUT4n9qZtfNS53yv?=
 =?us-ascii?Q?HufRrc0ZzJcjBP4D0AJyBUzo3sQJugwDWb7xLoRnhmJlSzADetWhD+aOye//?=
 =?us-ascii?Q?2PEyLG/Fjxx7f6VT8b/a1nYlklEKQRZuQhW75M4LhT+5B0Do9kHmdvRfevVP?=
 =?us-ascii?Q?hiiwkayO6t7DdsMT35EGBKz3yQP+5k6M2mgROucPQ+Vtl1UqKLTcRu93xNZE?=
 =?us-ascii?Q?OCpLx5u0D4k8lWMEmT2aHuoVoqXwiWRVBaCn0hPrFIz7ZvwVjmHYe/S6nUcp?=
 =?us-ascii?Q?tIIJkCqvWwIVCmyboQye9n7d+TbhtnvLyZS8agAoHhbjQbM4jP/pW/Eu1qWt?=
 =?us-ascii?Q?aGYioCQ6CG0TbpM91CgjGIZhuKonqr/RaIQIcjZFC3Ystyddj9tDOZ7Mr/VB?=
 =?us-ascii?Q?36gDglnaNaNJYxUBqaESMT/gnshQfuamiFgHQMyzUBPTmcWVCMp59M9zyf5T?=
 =?us-ascii?Q?8PJ19S8xfZ4DxqXOlRek+B2Img4UwT9OZUSCM81vfpMadfLC4s+NZPt6Qq8N?=
 =?us-ascii?Q?jsNfgE+PTzUunDM3uwnM7lJOmsuyIlxk1+5Ri08gApVs+DkiV/MckUJKwF5+?=
 =?us-ascii?Q?R9piuEVx8tUvr5BOl/mFkq6xEbpRxDyHXTdHdNwKWsGzgciTtKvWkxlLEzoN?=
 =?us-ascii?Q?1Ma93dHguGDGLlAM9alyzFq2?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D22E1D0EEA191B41BCE8A7AFDF5BE90C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4dc1b7-33ff-485c-a221-08d8cdda33da
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 15:40:32.8506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/wwzmsru6fClMmTXp+n5666bwJnm3kaaQbvWNlKjlEL/c+w09YA1VwNIjbs4g/Uva17+cEi19z8QFrsFJLwsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4909
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 01:52:59AM +0100, Michael Walle wrote:
> The legacy interrupt INT_A is hardwired to the event collector. RCEC is
> bascially supported starting with v5.11. Having a correct interrupt, will
> make RCEC at least probe correctly.
>=20
> There are still issues with how RCEC is implemented in the RCiEP on the
> LS1028A. RCEC will report an error, but it cannot find the correct
> subdevice.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>=
