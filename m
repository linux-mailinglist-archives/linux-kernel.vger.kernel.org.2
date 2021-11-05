Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336EE446024
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 08:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhKEHhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 03:37:40 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247]:64570 "EHLO
        esa10.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229749AbhKEHhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 03:37:39 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Nov 2021 03:37:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1636097700; x=1667633700;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=6+OM23Z6ulynEWWNpRaniXUtFmJxHXUXx8GE2LaF6jY=;
  b=RuZ63+ZM0yU3sdE5wIenGc/qa471pRJKKbow1KbI6Z5vpJWLEmqsw+Vg
   JE7Ndx8zkAYRAOSHZIQEF4vIPHMdHHQl/8ez4xuOQYbeLXDCT9fR0jnCs
   ZbTQ/6bRuSlUc0kychqfAl0flTgmpnoxcYU5qyG7rOzNtDvErtVsVlx+U
   nwoB0RVsVfZ6Xd/ueO0mijy/yoozallR7feXS4ulGpIfSbm6NeFg2Xn4r
   bMU5g88nb3q3HawiMgJRdtXaPgMfzYbCQ6wc4PlqeaxKMYHhZXPavOuP/
   n8YPbmhnje/NsucJX9Y+GnnDDjHaND4oqB+tDSJgA2wh5n49+lpYBIO//
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="42951948"
X-IronPort-AV: E=Sophos;i="5.87,210,1631545200"; 
   d="scan'208";a="42951948"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 16:27:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGP1m/DWX8qu2cGyu7zx5VyQdDCJhRhlNqTBxhDfkRQaT+plVCH8Uw6CP7KlFEMDl9o3TVml6ToBcoLF//5onSAKijUU4FOHzRi0OQIlMT9jbf5PKiUjSv6VIBquqRAM0+jCKMW4ZUsE2rpczEL5RgrAu3RINYk6e8Eft86YPoo4R4SakLHPxok6XpRefdsfgFQAaT67Hg5uMyPfOz1oIHk6tHB1Xb2hbITDt3u0EbNUAR3RHvlut6aNnqKGAOWXOGQ7tRWUSsjbd6czKBUQlvcznQvs0JH4HQ6UMH8o69YO+NbxCiA0lBZ0lRQ8AR/5CdGho5EzaSydCtZG+ZMAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfbJW4KSnKe5XXhrFUICSV/g8++q7G0ux4PPfG6YXaU=;
 b=OhZqyQMkvMhv1nhI7eOfmvyYBq+tJTmHjQdY8n2rJti9NllNkUfplZJgI7sSFT1H8PD+bpXJ7Zz8ck0MWYkt9LsEAOmNjC4FALbYKQup+pciyFOdDCWQ/bRQasmYuCQZlp8iLvhKdw9VRXXHwfSKFQlMMunoFCoY9rYV3b4itzIYE4e9CCj6eyKW4oW+WqN4phEVBRdB+fp/QHzn66W/DiB32yS9TfquHCmpBjGIm36i+rGBBxUdwSUsyPYZ/SD3Rktez5Bs1iktP0PRPGqz6pYm6QgjrGrjPpeMov1V16MjKz9YDs0uoBg5vMZE6bQstE0jENoAxbqfoQApWrlyMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfbJW4KSnKe5XXhrFUICSV/g8++q7G0ux4PPfG6YXaU=;
 b=KcAYQbn+uOjcJG4xqdMR8kfzY6H1uUryRcf+vWo+E0q9kJ9c9ZznMcM3TZZebmJOapzAYrLWYBg5diNeJ8m8DcUzjwLpU2U4FABUHwQDvJQOprEZG+fdEMizDQLnqxYplcANAQZYDJzxlSrek5fgPV1j6FiyDk3iLgcOJrpxgPM=
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com (2603:1096:400:4f::8)
 by TY2PR01MB2827.jpnprd01.prod.outlook.com (2603:1096:404:6f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Fri, 5 Nov
 2021 07:27:41 +0000
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::ac12:8bf4:9dcc:55ef]) by TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::ac12:8bf4:9dcc:55ef%3]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 07:27:41 +0000
From:   "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
To:     "'rafael@kernel.org'" <rafael@kernel.org>,
        "'lenb@kernel.org'" <lenb@kernel.org>,
        "'inux-acpi@vger.kernel.org'" <inux-acpi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'orenzo.pieralisi@arm.com'" <orenzo.pieralisi@arm.com>,
        "'guohanjun@huawei.com'" <guohanjun@huawei.com>,
        "'sudeep.holla@arm.com'" <sudeep.holla@arm.com>,
        "'inux-arm-kernel@lists.infradead.org'" 
        <inux-arm-kernel@lists.infradead.org>
CC:     "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
Subject: [RFC]Development of the AEST(Arm Error Source Table) driver
Thread-Topic: [RFC]Development of the AEST(Arm Error Source Table) driver
Thread-Index: AdfSAOVUBSylD1LoS36428+l3vTllQ==
Date:   Fri, 5 Nov 2021 07:27:41 +0000
Message-ID: <TYCPR01MB6160551BCB54E2AC118FF988E98E9@TYCPR01MB6160.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9ZjExMTM3OTEtMmM3Yi00OGNlLTk5NmQtNmNk?=
 =?iso-2022-jp?B?ZDAxMTBkZmM0O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMTEtMDVUMDQ6MjA6MzFaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a4f547f-0307-4194-fcf2-08d9a02dc05d
x-ms-traffictypediagnostic: TY2PR01MB2827:
x-microsoft-antispam-prvs: <TY2PR01MB2827B3A8855B373F144EF671E98E9@TY2PR01MB2827.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I+6k7D/X+i2RxsOp95BvFwfICOYjWD105k97GGWzj3cjcSRgka4SOCwNQIGW8LI/MlcIXuFW0T8aRa0lN33pTwUOUM1MVDD1v8gUBRXBHYbAgYG4SgeEk8HJvCacoz24/dpbvWYueG3zp1Ur/JzunnNfWh6rt6qD6lDuJycIzpsGxBqE10dBzkF1ajOtr2XeSV4ars1f0gjLiV+jZDasrFGmJhIITe84ailwqVxo52CD5VDTbdWOC2vO5hO2XZ6mvFs8iWxtm0XpvjoY8mGUm/fAWAfh72gm1GcBBiC1/HOrlZ7KDHWgfLvoQeKbRoNHT5hv/vZkoG99B3zDb+8cpa/rO7xBYsvEtj/jXGxrddHXlWQP5NS3SyR2Jc9oW+zR0X0PbQ4rQQ+67yxGqY50QyBw0nJNkh3jKrVMtJltCqbSHFkLxy6FngXtRq482Y4NG9JnsjfcOk1d9zcg3Wzmktbtiq0Q07OQciDt5zdVgireb5ev5QutRRxG9UzzuMILUurda1X2mw+/VkkRg+Jj9v7MGI2T2gKMbnyPFa26npddhfe984Dm9lhoAoB/Gw4tViguv5OLbzB71eTXhvV9VrV1m+u03mdl4s7royfP5SKXWGq5b76wUGz0gwUGmD8wbKphJSXBOvREIHsP4nLFDxfoDt6yBC05e9myUERPyzmdEpoTQN90k7YvdA6ra0cms5LDkaWXpjdPF/LU+hJHLD0x8QCTJXlIzbiBNnlSWScilA4evZxSzCqUSI2PnNCZdMd7iHatbVC4JwtUt2cO5qXXolUTlU2kn1ibVX6CYsy4QxMCcYbp/mJTHVEg6uo6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6160.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(82960400001)(33656002)(4326008)(86362001)(71200400001)(186003)(66476007)(64756008)(66556008)(66446008)(66946007)(8936002)(8676002)(38070700005)(5660300002)(966005)(122000001)(508600001)(38100700002)(52536014)(6506007)(9686003)(26005)(107886003)(7696005)(2906002)(316002)(55016002)(83380400001)(110136005)(85182001)(76116006)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?L0J1dXljV1FOWFVkaEp6KzV3QW1nVWR2cTNwMmJNS29ySXpXNUNQVFMy?=
 =?iso-2022-jp?B?alJlWlhjVVgwYWt6UHdCUXBzcjkrb1hFcUVvM3ZRMEVuaUoyK0k5NVAr?=
 =?iso-2022-jp?B?c2xQWjAwcEp2b1JiSHFQckdVeEE3RVk0YXZLTENWc2ZvcUVSRG1VOWlw?=
 =?iso-2022-jp?B?eWtqbDNHRHJhZjRXd2VKT0pySG9zYjk4QUNJaVdqVHJ6d3Q3Kys2ZmRD?=
 =?iso-2022-jp?B?THRPMThuMlFRYkJOWWtMcXpyR0ZKTWw1Sis1bi9CMWhad1NaaGJsc1gx?=
 =?iso-2022-jp?B?M2MrKzh4V1pTUTNVeVJ5aUdFOC9LYzF4bm0rakNDeDlacENoL25GOGlN?=
 =?iso-2022-jp?B?MXZxMHFFS2RabmhBVU1SVGxYU25rU3JmMllzdVdwcnBPWEF2ZmhUTzBp?=
 =?iso-2022-jp?B?SkhXVDFqY0lGRGtrSDUrWktnT044ZW43aFJCcXdUK2t3R25VdlVySUc0?=
 =?iso-2022-jp?B?QkkwWm1vMUxHTGtiNzlPalI3dnl3M2FUbVNjQU9lNG5NWnVXNlpmVzZv?=
 =?iso-2022-jp?B?RjYxNlV5M1RKMlRwL2VTcXlKT2RIdWtzU2ZGUnk0L01YaGZRdjFFTGpx?=
 =?iso-2022-jp?B?RXY2aWRiaklNeTh0end3SlozL2ZvU0taN0EyOTNuZGpncWFDRGhScy9t?=
 =?iso-2022-jp?B?M29qQnZXdEoxVTljbDBoNDAraXBZay9uQzZ3YmJPYjl1Qm93SjNDZWlZ?=
 =?iso-2022-jp?B?bmdQQWl1Q3NiekppZ3h4NzZMUnhkb0tiWGRoTkJtUFdyaFBMTUd2Umox?=
 =?iso-2022-jp?B?MFFQL2RNbVlIaHZpTWxyTW1vTklmMm1TN1RRcXNaNW5GUU9OSFdvbHBJ?=
 =?iso-2022-jp?B?cXJYYVZuTUdZa0JPV3o4VklhYjZaYW1HdnlXQUh4ZmxkS3o4SnpUMFRv?=
 =?iso-2022-jp?B?aVg1Z3owSDJ0MHArOXEwbjBhcnk1cnhWVEUrZFdVcitCL0N6VHMyd1l5?=
 =?iso-2022-jp?B?WktFYWpXbjQzQ2lURjhKajM0eSsvMmZGWGJVM0NYeWMxLytXVnQ2T0ph?=
 =?iso-2022-jp?B?dUVUZFVrQVF2ZUhVSktiWFVhVkltRGlxYWJ1N3lucVFVYlZmdDZ1WE4z?=
 =?iso-2022-jp?B?enJHUjE4Mm0wMjdueit2ZlE3WFJNYWpaMUoraUN1S0RkZFc4MjZCNXhD?=
 =?iso-2022-jp?B?cGxFT2VpODAwZUlrOUoyMEtsTjlSMm90RVp0T3dLZExtb1djN0dmU2hB?=
 =?iso-2022-jp?B?SDdKbkx3dTRiVk9CN05rVVBDall6UkRJL0U2dHN2cE41dk1yNnlibGlp?=
 =?iso-2022-jp?B?NkdHQVRSTTNsekQ1akRNRWd3UXJVQzl3bE03YVBFNkYyUEI3ZDZnYzY1?=
 =?iso-2022-jp?B?TUhQM05jOE03d3JQTmxjekJrUkRJc3ZwY010MXVRQ1JsVyt2eHYvVUls?=
 =?iso-2022-jp?B?YkthUm1XS0FkQUFJRWw2V1dXOXkzZ0FQS0FzT0oyNUt0Zk9FMUd5L0VV?=
 =?iso-2022-jp?B?VHhreXo3bzgrYlJGa2FuSWd4dUpFR0NtajRDViswWTNUMnhEWFZtbnNK?=
 =?iso-2022-jp?B?K0Zwd3hPcW91dUY1ZUl2enc4MG1sOElTdjI2UGxJV3Y4aWdTVGJ6c2VV?=
 =?iso-2022-jp?B?TWx0emJGNnA1blFIZ0t3TmJxbkdaWVNnV2N4QWF3cWRrcGtXMmx1YzAr?=
 =?iso-2022-jp?B?VEdYRU5aaGNNaVkwc01GNEtBSzZZeUZuc2prWWpQUkdKUXAyN2YzeTcy?=
 =?iso-2022-jp?B?RTFTOHk5Q1F6cm5rT0tkU2xiR3pzOHlyOUtCbWsrVlY3YzdiQnA3U2Jq?=
 =?iso-2022-jp?B?QmNQakZuRW41Ry9TL0QzNlhlbDlzMWJXRDdGRUdvc29TQkVuZWxpR2N4?=
 =?iso-2022-jp?B?OTZNZHdtNmN6WGoxNXMrcjYrZlVZS1VIOGplTkxNaGtOakpsR0x5VmFK?=
 =?iso-2022-jp?B?aW9SR2wycEhCQlZ1OXBmUmhiSHVZS1lGM1JVRzB0RmVNY0szSTMyazZm?=
 =?iso-2022-jp?B?T3dZZnhvekZqd1R1SFhCQmx4WDl6dXhDTnJDS0Y2M2lMK1d3bHpPUE8r?=
 =?iso-2022-jp?B?eS9DZG04VnFmSWFwUU1GQXVsalVaOHd5T1ZCZG93Mk9tcXVsQ0Q4SFZs?=
 =?iso-2022-jp?B?WjJicWRxcW1ia0FkVmtuNVZoWlNWeDlGektDK0lLOVpHcnhiVkRZaWVE?=
 =?iso-2022-jp?B?aC95V2R3RGh2YjdNbVhRMVlBRUhOejRRUmUweTZlZnpMTUpydUNlS3VY?=
 =?iso-2022-jp?B?WHZRSURLNmo2T1FHMTZ1SnlpZlZUMS9sUzhWdmRicFFYcmQyVXFpNDls?=
 =?iso-2022-jp?B?bEpCUSswVndQK05ma2Q4bmJaTnZmTmxPWGViRWxVc2hkdU5pcU9TeHAz?=
 =?iso-2022-jp?B?SkU1MlNvRm03YXRBNUZWbVNKMEhacGFVWWlKRFU0c0lJRWxkL29Ua0JR?=
 =?iso-2022-jp?B?T2FrWG93b3h4ZzFZR21ucU9zQ2dmaGxpSm00NkgrV21Rb1h1N095MnRq?=
 =?iso-2022-jp?B?VGJtSkpRPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6160.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4f547f-0307-4194-fcf2-08d9a02dc05d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 07:27:41.0455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hwu+t/Z/zxXLT4na55EZXphTR0QX6FonVqdOMPVyl9AXKtxuqM34VXNJ8hsaBlrRtx9OTRlQDAVdOdcZV1R8UKE6+lQd1GfD6lOw2d3uQEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2827
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
to all concerned with ACPI (arm64) processing implementation,

We are considering to develop an AEST driver.

Currently, the following has been posted as an RFC patch [1] for the AEST d=
river.
[1] https://lore.kernel.org/linux-acpi/1562086280-5351-1-git-send-email-bai=
car@os.amperecomputing.com/

We sent an email to the developer of this patch to check the current status=
 of the AEST driver.
Unfortunately, there was no response, so we would like to make the necessar=
y feature updates.

We have two questions.

Question 1: About the update features.
Since [1] is implemented based on the ACPI for the Arm8 RAS Extensions 1.0 =
specification,=20
we are thinking of updating it based on the latest specification.=20
Any comments would be appreciated.

=1B$B!!=1B(B(a) ACPI for the Arm8 RAS Extensions v.1.1[2] support
=1B$B!!=1B(B(b) Register addition and its dumping process to comply with AR=
Mv8.4 RAS Extensions
=1B$B!!=1B(B(c) Addition of processing for each missing error type.
  =20
  [2] https://developer.arm.com/documentation/den0085/latest
   =20
Question 2: About the directory to be placed
AEST will be ARM specification.Is there any problem that the directory
to store the main source (aest.c) is under drivers/acpi/arm64/?

If you have any comments, please let me know.

Best regards,
Shuuichirou.
