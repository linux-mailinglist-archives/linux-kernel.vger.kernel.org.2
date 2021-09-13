Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4039A408503
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbhIMG56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:57:58 -0400
Received: from esa2.hc448-60.eu.iphmx.com ([207.54.71.102]:49099 "EHLO
        esa2.hc448-60.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237453AbhIMG54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:57:56 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Sep 2021 02:57:56 EDT
X-IronPort-AV: E=Sophos;i="5.85,288,1624312800"; 
   d="scan'208";a="1743557"
Received: from mail-he1eur01lp2053.outbound.protection.outlook.com (HELO EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.53])
  by ob1.hc448-60.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 08:49:29 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ne5FYBwddqX6N5enycIWa0E46qgMzg1kg5ikIynqPw8F1s33noRvV6S5SFJ20B9Q18pmg7wVA8MFQPBBU1HFNoR8YqSARvRDLBvXGO9ebvffFUf8UYPrw1V7r7d1lrZiWtqxGSO9IgHTkOaz2bD7F6/F7u1Bb5qg6s9iAnZM3wT/8JUH84blgcTnhgmtLGY0psY54bB4kAiuFCQXASoZajWgk96yhZb9fPuXlaDH4/2ROytkSHWdHXiwGONbRc0CAP+jDd+xZ/UgV+DSZIuhEpyDJBdhj2QhKm1A5nXyjEcoTZ9ekCVmCfp0h7q0frrK8HsVQDWIgHKluwm1m/h0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SMXuRA3Y77bS48bBEw4O2xmJUoWZ07n3QpCyaVgJTc8=;
 b=JEw7qFGznK+ucqCJpuEfMBmB6I2dNyHQnhxoPgMz/zmpyZ5suOCMbxyPZ0P/bT9gCM4lPcDO1JoucN+QSd2vgnFUamVRELotxTLAmwcq+c3vFoKG8IU61O3xXvyFWfZMxhUZ76RLruQ24kBP3Y4VRzzeXC028xc+mwwB+2wGuDqL0eP94LYe0niVZt0bNOgnrsud+oKGQQEKh3tnfPZHkBRg1FSxxKhaJQ8payoKzddu3HhToLgPxwAmdyFODWYFhq7sI8swheQVCXcc+NbkCZr+y8uzfy+pjan4S8WXg15zCKofaWaului604MBskszsOuXY0fstLIOc28yNV0www==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensource.tttech-industrial.com; dmarc=pass action=none
 header.from=opensource.tttech-industrial.com; dkim=pass
 header.d=opensource.tttech-industrial.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tttech365.onmicrosoft.com; s=selector1-tttech365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMXuRA3Y77bS48bBEw4O2xmJUoWZ07n3QpCyaVgJTc8=;
 b=Rlz2/EjnfCAUWflG/82hUpacX55rWCxLREe9mu0K0s7Fu90c6ulFvnXY/2ooSor1M2F8xjvP/B+769z7pW8zfn81d+Wd8Fqmb1paMzih9msymrjLbsBsPFOW2N2sDogkGLJXMJ1yYQNgpUiONxBG++YsMFZ/LNUhZ9qPEcuDN38=
Received: from AM0PR01MB5410.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:115::22) by AM0PR01MB4546.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:eb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 06:49:28 +0000
Received: from AM0PR01MB5410.eurprd01.prod.exchangelabs.com
 ([fe80::807e:987c:688c:62be]) by AM0PR01MB5410.eurprd01.prod.exchangelabs.com
 ([fe80::807e:987c:688c:62be%7]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 06:49:28 +0000
From:   OPENSOURCE Lukas Hannen 
        <lukas.hannen@opensource.tttech-industrial.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        "EMC: linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND PATCH] time: changed timespec64_to_ns to avoid underrun
Thread-Topic: [RESEND PATCH] time: changed timespec64_to_ns to avoid underrun
Thread-Index: AdemSfFfOqTnASerSE+/zqTNEdMoJwAXMZ6AAG/7fKA=
Date:   Mon, 13 Sep 2021 06:49:27 +0000
Message-ID: <AM0PR01MB5410AD1A0E31405EF63B3DF3EED99@AM0PR01MB5410.eurprd01.prod.exchangelabs.com>
References: <AM0PR01MB54100B19D6ED5FDE764FA516EED69@AM0PR01MB5410.eurprd01.prod.exchangelabs.com>
 <87fsucc4yy.ffs@tglx>
In-Reply-To: <87fsucc4yy.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_b8b70055-b36e-4b3a-8b31-34156bd0f0a4_ActionId=59b33203-ad07-41b8-9f5b-0e1f6440f15f;MSIP_Label_b8b70055-b36e-4b3a-8b31-34156bd0f0a4_ContentBits=0;MSIP_Label_b8b70055-b36e-4b3a-8b31-34156bd0f0a4_Enabled=true;MSIP_Label_b8b70055-b36e-4b3a-8b31-34156bd0f0a4_Method=Privileged;MSIP_Label_b8b70055-b36e-4b3a-8b31-34156bd0f0a4_Name=Public;MSIP_Label_b8b70055-b36e-4b3a-8b31-34156bd0f0a4_SetDate=2021-09-13T06:35:30Z;MSIP_Label_b8b70055-b36e-4b3a-8b31-34156bd0f0a4_SiteId=5638dc0c-ffa2-418f-8078-70f739ff781f;
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=opensource.tttech-industrial.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ace04023-9ebf-4f1c-ff9e-08d97682a1b3
x-ms-traffictypediagnostic: AM0PR01MB4546:
x-ld-processed: 5638dc0c-ffa2-418f-8078-70f739ff781f,ExtAddr
x-microsoft-antispam-prvs: <AM0PR01MB45461B76AEB9EFE56A2A462DEED99@AM0PR01MB4546.eurprd01.prod.exchangelabs.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Ofp/5/BGGjrZcnBBbFDtdOSKieESjjzPFKrboI8NrqvfPc/4SyOn4M5kWcyI4qBX45Q0KRHRY2MSj7yEaKgnX31S+85uS7c8biJBxheXjoHDMAwlxNXpWjjn16sgxJg98O06iLuRw8qG+1R24+ov6lIVTR/xB9ZwxOVMj4VmFvrIe6V9e8VSNiiigZvDMZcnNKnUXfGkmaUoIxNFyFW/aAkF75bsOwHScNGIJj9OlIWxGkIa3bLxpkojMlDcM7kWlA9Qren8lZbfLv6S3RH+IV7FAXsET2xWsRt3x92smtHlk35rVzxAh9wSnMjRoIEcQ1NM46P3AOvRqh4dQSfFvcnBoBlZdTgzQk6G4RC7I+Y/vZdYufAt04simr0r16j42YuCGiRgXmCglP0GgJG4i9oU2QDwUuLv0aF+TiABwuXYiZgN0xJccddbZjwBUnoEvN+16cgjh8vpiMaCP3oevdw/rEP18bmGWoBk7JdlaIOzLLysKf3jXS7XSmdyPm8v8Cyfbr0FshsJAgVi7V2rehjt3BW9wf9DEfmcLi7tHN9FiYt2Gt9H2t/795+zvTA0q1RSLFwCYjmEFWQ9mo1vcpQCaxJlEnBpSHUdDp7bCQRiOp2izlCJK7kHkDIeJik3/13IRa/WsxPbAPiphIaZIwPp/4fJDGXSod/89b6apMmh3WzmigBkS4oxLBt3vpxKpML1BYGZdwDFfEcbd0ALA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR01MB5410.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(76116006)(86362001)(66556008)(64756008)(66476007)(66946007)(66446008)(6506007)(8936002)(7696005)(186003)(9686003)(8676002)(83380400001)(110136005)(508600001)(122000001)(33656002)(71200400001)(38100700002)(2906002)(55016002)(5660300002)(52536014)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vYQ6i24EVuKMuCAPooI/PzI4MKUhuM8M2Us1tyDg4jcMU9a0oTOAi4+1MOlr?=
 =?us-ascii?Q?VK+xEwnGB+9MLE9I2rDrS8MdRBgtSU57pxCa8jFn6sxU22oVdKzC5rChTm9Q?=
 =?us-ascii?Q?XJPntsnnL2XZzlob4LcQY2qLce89XOahhXNlSX6X2mInyMJY2iLDgAmunVvs?=
 =?us-ascii?Q?mRvtj8XsG2ubSOnGTPwoIAF3O2Bru1K3rnBzz2AlpJp7MZDpdhH97GxSsTLi?=
 =?us-ascii?Q?WklU7rfogUCWqqxZ+/l01cpHst5uY10XB0RAl1/Xc6DHacKDXR8X2EFaAcTW?=
 =?us-ascii?Q?jj0Ws13zJL3vJ226loNAiIms5CvlbR7fU09tirICZDXcx05OQxS1rmsKXWWu?=
 =?us-ascii?Q?t9rClegzCbXelri1vFt6AgG4fvB8Wlh9oZMyKgcSrcK3u+utediWiDgs8q0m?=
 =?us-ascii?Q?Z2ZNs8r9axJkhGJbfHSfZWrq2MtlU+wmJH4jUZwCHFBiSd4fFUgOUR1PYYSe?=
 =?us-ascii?Q?i+L24nAXe4DOyifDFOpcHZ4f5IQmkK6YRuEwoyIht14RaepDBSTEwgyDixgv?=
 =?us-ascii?Q?g+stb26CZnnwmSqDQj5lyZHLnFc+pXsRtCQkopcRWixsUg0NTLT3f2d0TOxF?=
 =?us-ascii?Q?gOgNpZIuFKNRNtIyP7VfGLU/F0co36GdL7JlWyNsbONexyOov1ntJOA106nH?=
 =?us-ascii?Q?MZOqowGkJnbxhJgSRk8LRKHFaN6WbR9/QrfTH0K+FWRQgYrCdirA2YORKwtq?=
 =?us-ascii?Q?KjtB3dmqqxNpz2Gx/bQrraLDoPLlGrbD1LtuHUhWpTAP7DHx/w4zNpy7LTxu?=
 =?us-ascii?Q?gUshILmCeJhLEwq2cdu4QuSBoadVy6ELNJANQUDSXqtTefcKdSmmua1S6AyH?=
 =?us-ascii?Q?/FyXRjuJs/bxIHthTRs/5fMQdZcRwXaUrX2PPZJ9gK3afCWHNUEmnzupN9N6?=
 =?us-ascii?Q?G38Aznjami1an4ikC9zhYMsYG4q6mHSdXSllAoI14LUCTj76twl9tH8jFQis?=
 =?us-ascii?Q?+53PAeoYpAsdq1XCwfVUlNYhsepYkvP07MeBAilJZalhVvLryf7k0HfgLh9k?=
 =?us-ascii?Q?7G7g7l1T178tU5EOOai9YztBmfiXDjpORl+afLFvjT7mZ+xRyQJqBNw8//m6?=
 =?us-ascii?Q?48Iq3Qgb1F8zrZQzg3bUYO/aOA2RJjb25FAAukddL4UTdKkEXtKyLb0G9X0D?=
 =?us-ascii?Q?e0bF1y7UiTGDQ/i9KiHivNLbFxDGBhISKkIDZVJBB/tjYm2HoclvUV4gIWWS?=
 =?us-ascii?Q?OUxKITAqHYOA9wozd7lGn2BgmqzL/XOHNkFbKz9otfY25jdxmhOLSxjftfjZ?=
 =?us-ascii?Q?cVCgluO+zbyG66PG3wxrfkFKVUt0G1NUSxhk0YhMvNhC9lTBO0DLi5gGTi89?=
 =?us-ascii?Q?TDlHppu4Xf3FC26vn6fK9CNURDileYgl5prGqESw2+ooz3QFL9gu+oCpM/kE?=
 =?us-ascii?Q?Ji5uJEUyaFPcRbGnsf95tndWR/t/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: opensource.tttech-industrial.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR01MB5410.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace04023-9ebf-4f1c-ff9e-08d97682a1b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 06:49:27.9080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5638dc0c-ffa2-418f-8078-70f739ff781f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z85U4L+TWIRbXYDiyK5f63mobhGGFYgw2eCsWXhkCRRd2P4ufywcfiL+PeKNWbbFnEPAdXF5xt12wGIK+qRGr8kX+znf6fiuhN1nrYgo/EH9gxVF3k/6bdnLk5qI6lzg6i1qlZ1aA6lSybn0pl8LpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR01MB4546
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Lukas,

> why you are resending this patch?

(also ad 2,3 and 4: ) unfortunately our company mail system never showed me
your replies to my original mail.

> 1) The only change you did is adding a prefix to the subject line
>   Changed patches even if the change is just in the subject line or the
>   changelog want a version number.

I was unsure if the Subject line was considered part of the patch, and noti=
ced
the errors in the subject line on my own, and thus thought my previous mail
got ignored because I had messed up the subject line.

>   But what's worse:
>
> 2) You ignored any other review comment I gave here:

I greatly appreciate your help in regards to commenting style and content.
I am obviously entirely new to this community.

> So what exactly are you trying to achieve by "resending" a patch which st=
ill
> does not apply and still has a non-sensical subject line and changelog?

You were right in assuming that the format of the patch was messed up by
our company mail, I am as infuriated about that as you are and will try to
change this situation asap.

The other mishaps (like the wrong use of the RESEND tag, failing to check
if the changes were already applied to your tree etc. ) were caused by me
being a young and inexperienced contributor.

> Thanks,

Thank _You_ for not immediately ignoring me forever,

Lukas Hannen

Public
