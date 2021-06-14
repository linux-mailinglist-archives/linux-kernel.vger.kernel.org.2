Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8353A7078
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 22:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbhFNUdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 16:33:31 -0400
Received: from mail-eopbgr1400124.outbound.protection.outlook.com ([40.107.140.124]:19979
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233590AbhFNUd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:33:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzJx+wCf12rl+ENCeqBWuuwqCX9VQwRMf4kHkXUeq/lYKDPfKNb8p1cV57kpqo9dhVvVRrHt3/1G72wUQp3McBx7DbDhNhcW8kDCa6twSEVwDjjkICQb/TyJe3v4eL3zwFmDUSOzyOOry83tmSjDcRra0xdiHftIsywTpINhQZuxaMgA8sNCZsZGXKF3z6xNSVKncaQD/Po4p1Ud6uiOIdkW2Yx0c69NdzaZdqnlVclC3xvvqaCYI41i8L7LGNulptfWCSDgehk/Xrfva0TvV6HUEj5CuanztTpuenXoiXCwUAN79zleIEf73KaXw3oA9i0CxOem+FZCEdr9sBQZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3VBfQb/dwxsiPE9YoqlLc88npLYViMm8ZVAsI+5VSI=;
 b=oATdkJxQYuylgD465jTpYRpMsMO41d2cTr939d5SXOVfW/k/6oDij/vU7Ef3L0YO2gpSyzMFANJev2AahcYP3RI8eeZQJyDMTDCHz4Pxdwb4SuyTS3ZtmcPxzOJOZKm+lmf/fbfJO7XmK5hNqawTst9703pTdewOMHFsogo0/sZ3v6bagNTablkf2Q5wWr+5IKpBJMOxQBu6qy3duPO58XJGSdjm0yZgGTHVEf6J8UB6H8YpRNLXx0vdezFFJtK9wDBEswxRUKO2+yJEdyf4CbYceCaCoZCOQBMqXFhUntsJY9UoYWaVAMtVDzwSTSLQSPChICOZ14j/EJnB5bpMxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3VBfQb/dwxsiPE9YoqlLc88npLYViMm8ZVAsI+5VSI=;
 b=sEZxAvnXKVMUV+Lytr2etTYj3qF9pN9gDINbwf9ChHHWu4dtUhwsnuph22XdHqg0Nk+AULMSzNvuWV9d/454obF2aYRjw1vWyOvrJ96lLbnZhAFF0Zphoc282YewIhaLVpb48ZSDYgYWjBg57fE+2B6TAqnMZO1yZ9zd3V9noGY=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OSZPR01MB6878.jpnprd01.prod.outlook.com (2603:1096:604:118::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 20:31:25 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::a53c:198f:9145:903b]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::a53c:198f:9145:903b%8]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 20:31:25 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Min Li <min.li.xe@renesas.com>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH mfd v2] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH mfd v2] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AQHXV86EpPNANrzU4UCJO/Td0zuOkKsUCHqA
Date:   Mon, 14 Jun 2021 20:31:24 +0000
Message-ID: <OS3PR01MB65933BCAA4614F104DC8CAEDBA319@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1622652224-19103-1-git-send-email-min.li.xe@renesas.com>
In-Reply-To: <1622652224-19103-1-git-send-email-min.li.xe@renesas.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: renesas.com; dkim=none (message not signed)
 header.d=none;renesas.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59ec39c0-9612-451b-5eab-08d92f73616e
x-ms-traffictypediagnostic: OSZPR01MB6878:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSZPR01MB687815DECA72BB5C26E1B736BA319@OSZPR01MB6878.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPNh81V4jWkIU261+0DX9JT8jX7vaVbWVIsYAiI8GG8X/HoGbGT7sXfcSDLMsLmL2SkkGPVrgIfLXEnLz0P+UvfoMrcZ4xCtdv0NXPUsofVetbdhaTogM4d0QF3bN1l+P7829ICrE3lxfFGRq1RroFOot2PBUmFkkMryPpQJSJLxAH/VdRAosIjG6363ExuaFl9zMkSamxTI78DdQTtq0ur+2ndGniF3noRK2W9xIoESPx18SO04n563+kAbMEWuQPj6rkVyABv8Dnum/WpH+vPhbQa+qM1NtSl+6md2NQ6Xyvz2umKkJ88afgf6smlCVK71yRsZeWU/UlKA5U0i6uy/APse+4Ds/5eGhRf3OoRMHDJsQkyvEAnIjG0sF+OfPrbFtq+kF+Tx1x1RII99v03QgTB0uvvadTaQ04oTT1Qsv5r3A27pKBbyG8zcBQIvjgMwrxeqsdkyUkgzi+zUwiXJ14QOrb3C5E5iqB3ls/PPl6CI4evH1xqoF6fuA9Cu9pLhNpWfJ5uFQlP8t3oDwTizJa5iRcwLLTyR/KgryxIAawFika8TBdkQaKrok/F8VlEwojkV0O9TZ3Z3HIhUFBQ0KTe035XOmRQT0/mu6+8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39830400003)(376002)(396003)(5660300002)(8676002)(86362001)(9686003)(8936002)(71200400001)(2906002)(33656002)(66476007)(66556008)(64756008)(4326008)(76116006)(66446008)(558084003)(66946007)(52536014)(122000001)(54906003)(4270600006)(55016002)(38100700002)(186003)(6506007)(7696005)(26005)(478600001)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Vftp+W7Euc14pqGZNU8AFvblkjzR11rcFQJbzzCleMFSG2ZKQIeVVFFRnF/i?=
 =?us-ascii?Q?5qWN3fZJ+1s+CdSqM1+NooVOBkr1YacIF0gIPk11fTxXIhpxEuSqbwwlAg/Z?=
 =?us-ascii?Q?v0CaLdJwSSl0eHFQ3tU57Efd2R/aWciZXOfVqrffSnJf5CmwwiCGDna1eAQ4?=
 =?us-ascii?Q?R8guR20dO2knUoHPEmhuw9AsN7OiQvHxrbFbVBPOWNx0estdHnlbNe2+dret?=
 =?us-ascii?Q?ZnAotdjkDBeymK6V4FyOxri6fpK7bXq0wvR4+bwXpFT2sg6OF7J0VPZ1+oQ6?=
 =?us-ascii?Q?IA3eMUrguWZneS3kzL6jE6fSG+68JzKUdsrcZgUUZuxTQ0JZjIbCLsuyeFeK?=
 =?us-ascii?Q?JDJsQVwxosUrrQvwcBwUGDWnup63pLrc6od6ek26gNtLN7uoDxXry5ZOga4g?=
 =?us-ascii?Q?LuFILLYiwEOcWgB67bM9YHNkIjK8BFacHmYAIQ2Ee6j8dsjWa+UEIYhVSw66?=
 =?us-ascii?Q?rCPnZctVQfMzEGTUqAbiXr7UGmKfScYtvqJ+PSgvicNLXzSM/i0wr2HeLO2T?=
 =?us-ascii?Q?+utBLd+j3Tuo58KA5FOljfGNMlP9rBhTE59JCe/PHWElc2MIB9+nwovFH/xb?=
 =?us-ascii?Q?GdiyDHIbRawb97+aL2VlDjc493BLJbfOyiaa6f6qzmBD8q2AO947z6Vtg4s7?=
 =?us-ascii?Q?fT0Mv71o4q5pkhvUQiN61qVhdi7oRzicHuezSyoEJCwZa6p/V28QK8gK7/Ue?=
 =?us-ascii?Q?j32FCBsvbGa2jWyNUeKgSVeEemNr9Nbzc+o0r6iJ2YmcKCekanSoRMqT4KRV?=
 =?us-ascii?Q?M5EONRN74Kys2OLY15SUKRpD6EwihDStME5MMzEeuh8j5SsowYt+DngiABoU?=
 =?us-ascii?Q?eZEaSlNtxhhiUzkVOdX1dHc1ZWbZiYSfgmFbTOBLPptjdSdhO66CK35+WyIX?=
 =?us-ascii?Q?MJ1jbL7rj7rZwrsZ4knrjlJjjRqEbItCgqwow473k9I+bOE/hdEldlE6pqb7?=
 =?us-ascii?Q?/OQGxdjz7AgEsS1Ibx/ztbrO6cL7wy4ZehEvWE5z/tNUbWVsSlXMm0ieiAHb?=
 =?us-ascii?Q?jXMwPK1i6Ids8FRobYsiAxXGWKSsRTDVI2O7e+oeP+wnmDkBtFO/7jilBOc1?=
 =?us-ascii?Q?QYSK5h2XzZkHYj1TvWqYUlT86JpaT8GJnn5fhg7r/PgHJfEeQZf5GLlqAPYA?=
 =?us-ascii?Q?CATxA41LCycoP4yjBO4l+6dewGFlU6c/qVwRMYzBPZ8kWkukX+R1h2bomSh8?=
 =?us-ascii?Q?1LEfpXkuJJNbj4qbnGkiD5lNBlYtHDMq/SLJKi8CrGLYo6VPUiBYx8opttJD?=
 =?us-ascii?Q?LL2j+ITwWzQEerIVrNEczoifGB1mllhUlyFsa31WNs1fNhRszFwkY4fJP175?=
 =?us-ascii?Q?eYd8ZK8T/n5mQpeSrEsuhm2j?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ec39c0-9612-451b-5eab-08d92f73616e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 20:31:25.0340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McVXiv9lpzJkZOj4ohDpqatO/aAKJQUwxZVsPwD5rCp52ET+yz0vb0yCpi1ouTxpIK+Epzf75WB8VHps34U9sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6878
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee

Any chance that you can review this change this week?

Thanks

Min
