Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9ECD3C9F69
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 15:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbhGON1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 09:27:45 -0400
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:19809
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237453AbhGON1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 09:27:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3SIUaE5RNNNX3cDmCCy5S+s77RL56l40mrCjRQr6ATkoYtpo4yQ2E5decnOKuTna33OnHGPi2/PRw7pPVOKB2eZX4lNAUp4S6cIBennUfNIUHiTgPH7M6aBYRmIAoKVdL4Y+YFJ3uI/0zl8jkzx+ilvT+IAKdYGjWZvXVlh07xy3z8+st6qbhNeBEidjYKlpaAyupsJ0kw47AnAtvkq2cJ4eejeyVl33H5o0LgrGvTP/PSrF8moF+lQZUtTz03GuVG6xn/az8WzR9QkxI3fXMR6JLt1+Gsd5Koy4Jv1VkcTsJqsaLYGiaaYGlt6lN7LUkkb9vIrAINH4yiElzc7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/rTcF4/LNuPq8qhODARE6HGazfu//8UGRbpZpujXwU=;
 b=Pu/8MW4RBO7FNq5uW/oREmGLL+T+wVb/vuKgb7uYo6EybXLxiMjgkemlwNIChH1/9PfwVQbOMW0k38OZPJx8lr9zLuvcrMj6t4sPFONt9Py4KqnjfsOUZvZMLSfy4cyNsFp3UONmUcb0L6Q4L8ZMms+PBWy0jQO0SMiZH+dZkRT403gpxEnlPGkkzLo+51Z9u3rA1Cg/Az8+qMS+EYd3TbtCUFOoIJq84+1OzAygUrnRVgMno0/473KNNnK8FBgsd7XS3liZEwzJEOdKyCqNt623hmiFWRBifUR7l3H5lH1e7XomeupzwfmPUZBpYcU1ltzBbAJVRBADVaUDcpN+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/rTcF4/LNuPq8qhODARE6HGazfu//8UGRbpZpujXwU=;
 b=lajkOfVWrrLnmbvYH2j6MwvneulSLw9nASZW84qLBHIoYKee9AiSEwv0U4SwmNhhiWW8CmW6yCbKeFQJ3yo+zO77T6llNa2/NowjCEj86Z3ZPllCQzgB+M+CyWMYJLuBXaQfmN/Zx4r+vylCFkUWXhyzqIXqtTWGtQ5EyvQEQ1w=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Thu, 15 Jul
 2021 13:24:47 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f855:c635:97a4:54c5]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f855:c635:97a4:54c5%9]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 13:24:47 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Vincent Pelletier <plr.vincent@gmail.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6] regulator: da9063: Add support for full-current mode.
Thread-Topic: [PATCH v6] regulator: da9063: Add support for full-current mode.
Thread-Index: AQHXd7eVexOOXcWgIkGRAuIceWWOtatEChWw
Date:   Thu, 15 Jul 2021 13:24:47 +0000
Message-ID: <DB9PR10MB4652AFDF3F223FE627FA5D2E80129@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <824518e6391b783a12eba9ff0527f06607a34bfb.1626160826.git.plr.vincent@gmail.com>
In-Reply-To: <824518e6391b783a12eba9ff0527f06607a34bfb.1626160826.git.plr.vincent@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d797c84b-7535-43f7-2388-08d94793eac4
x-ms-traffictypediagnostic: DB8PR10MB3737:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB37373728B35D9F828C06A864A7129@DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tZVdfOWF9c9hOYIc1EC620nWE+Sevx4Oa/hrOAOV2BDYT4HYg6Agfu7grbklQcjq4Nbx5SbgzBePQu+wb/ByS0A+mN8UM/g+P9jWUZvJPaTmeiSgZa3+QKlmPywD7QWki9RDVsGqVqE5EBiAPz31AX3ryc54L0I3Oqv+fSJddUh8DC1Sr+XWdn+m7pSc0aLDRQoNLY516CN2v91/OTRKyYt0zdAAVBhFf7nO28H+zmeRwbrG0BovqXI85eW9xGZLd95+MwUs55VOlpbfiutViwQzvhJuwRfnESDu2ORsckiNKN8AkL3JQtuByyPxNz6y9uvd7gDA67kDFyztRfXjoRMPnzLNQcd/IgFh9uShftJpi+iPLpzkhfmxF/iTk3sTwBl9Y+SlgcLhuGvYhQmhICRmzKGrCUro8YFQEleGHJ9D+dzEc6qlOxKLnFP2qkHUcRJnCAkGuXs89yVn1zvyMGtkSgZYlTVpjOucCMNW8STYfAkR0laV03vd02M4VPY3sBgwk9PFWMZmo//gNA2eXIBHepfXR+zXFqPYxIU4gV2RYX2Mp3Pd88bAgqX2vGrBTdyNMkFFgQdPQCVSksw0Tbvnd5zpO17c76+Bm0geI0f+zxoPgDh0o56JwjCLlfkDL4ZvmzdFRLt+dD3quLJiXuhGKsZGIeo/D2iruwVbUNKmmjlCs0jsn5navr0AnQSFvTadJcVYPpsHGV/IZa4gGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(136003)(396003)(366004)(478600001)(5660300002)(122000001)(6506007)(4744005)(33656002)(83380400001)(86362001)(26005)(55016002)(52536014)(186003)(8676002)(71200400001)(53546011)(9686003)(2906002)(38100700002)(64756008)(316002)(66446008)(66556008)(7696005)(8936002)(76116006)(66946007)(110136005)(66476007)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z+1Wsn7/VsojjILd43Fkqh7tni4czpgJAvZ8BRdskOHXnFQO2imwBop4itpS?=
 =?us-ascii?Q?KT290mfgA+6K0AGRDO0T2yCdpyjmzXVDNvoMSUjAR+9fB52Db22gFRfensDD?=
 =?us-ascii?Q?IKU3VipVp7nW1JTpTKjdmFV4pLB5xAoCvaYdIp9YrAjgzagMyTLDUPKAPgPZ?=
 =?us-ascii?Q?8JIvnfkor7hsbS/ovqAkxb/L5oFtiwNi3Ltx5WTkpdcHB3G4DCSMK99Z/0x8?=
 =?us-ascii?Q?TI1Fz6i4uIbo9PeQcYWXR8uYdGrzRz5J1FJIqGb23dMpmipi+kB0vufbd0sx?=
 =?us-ascii?Q?6mzojbLXnZkK8H4Ko5+t6RpdRohsPE4qn3iFOUoHIRl67gWHZ1OucEJqgh+v?=
 =?us-ascii?Q?FCMPhatc96Iu1+TSwHigXPqibhhaGRyTFdJulWa2KqYEOrM2nBaUnRZe0uE6?=
 =?us-ascii?Q?EcJH15+ebyuUbxFtLSyE5gqSU9MAKoGHifB1JgNPGhci8bt331QnxrQ6yEbU?=
 =?us-ascii?Q?E0QhYe/vq584a+SbO8NWLsMI6Nf1hunMFPtd3C0Hlt4OtAD4rhxck+Z93EKm?=
 =?us-ascii?Q?ZHxMgMSnb5oj3Jx1CxQRKuWCsm04qP0zeBnnn9Hwqiy5Ez3rL+wv89FX5GyK?=
 =?us-ascii?Q?FApNLQ/zYmYrhfXOeCRT+DFP2FvVJOSwQ8AIAK42p2vJksIpJpjedF+FzqCy?=
 =?us-ascii?Q?aHSjYVeDNzZI0CmT6Tq5+DlzN4VtShwb7ZTceGHBCyhXKeLsLtkXRfwybdZ4?=
 =?us-ascii?Q?WvYaQeIIT5TJr4P+X9kmqWCy8rGHAP2wJkH6NnZGH8WbJF+rS4hSO/XBR/99?=
 =?us-ascii?Q?NoSYz6ON3USjNnSiYhnBcUlAYJgxGTokV+t6Qaeu1nvEQwP9fTVnj/zHCKWB?=
 =?us-ascii?Q?7jaA+c1req/zcNelf2kdoOs2MqvtTYMgT1r9lp5Psmks5DljkkHAkH0yPgSN?=
 =?us-ascii?Q?O2Ybk5rK9HnSHiayUJc8ufdNq2YRFSI/Ym/alHvT1+I80BNRJ76RPO43GIvT?=
 =?us-ascii?Q?qVORnulJiQtY4hx0uMjXuDFC4SyJ3YB8teS5pRDB5wbTLu261aq2U1z5V8Dt?=
 =?us-ascii?Q?6mw62klpEJUQvyGN0BSOq+6ZVIIpurDXVosFmDioZTyfgc6huqyOx2m1kYcM?=
 =?us-ascii?Q?lPLubIPfNbFg2IeNT116R86C0T6niojo26kuW3SoVoDcWZS5m2ch4ppPbOXh?=
 =?us-ascii?Q?mYw/fUK9eMYYvSwdIxIBijS4EqRzMFRtNvN9EOTDZQX+J2uUbnOW7FYI5J00?=
 =?us-ascii?Q?Kk0brQAaNvXqZz/EfvWfRBHo4tyOVVY9eJhcnsUr1MMGF+6YGQbN3Dzpftid?=
 =?us-ascii?Q?/Fl8vO6HELqw2ihfVcKU8DuV1WoRviQd435d91reHEJPFzhgUJ2Qv+DTcIh4?=
 =?us-ascii?Q?wsc9564vLOryqD5dDyqCB0l7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d797c84b-7535-43f7-2388-08d94793eac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 13:24:47.3326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7YNUCm1TXr+OVgsecjkwK7AGiwmNoV77Lo+yxFT7YPGPa/8Z494c51hb2vhmsw1ushIyvQAvNZ8JTZnYA1NeC0eP2zls4plA1ME1FuXGNiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3737
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 July 2021 08:21, Vincent Pelletier wrote:

> In addition to the ability of merging some power outputs, this chip has
> an overdrive mode.
> BCORE1, BCORE2 and BPRO have this ability, in which case the legal
> current draw is increased from 2 amps to 2.5 amps (at the expense of
> a quiescent current increase), and the configurable current limits
> are doubled.
> If a current higher than maximum half-current mode is requested, enable
> overdrive, and scale the current limit down.
> Symmetrically, scale the current limit up when querying a overdrive-enabl=
ed
> regulator.
>
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
