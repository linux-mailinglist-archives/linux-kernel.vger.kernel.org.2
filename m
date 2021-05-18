Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976EE3873C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242042AbhERIH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:07:58 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:41738 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240297AbhERIHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:07:39 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 May 2021 04:07:39 EDT
IronPort-SDR: vCejpcf03x/z0OcV1hD/QfWr8KGNqToWThrg2YRzc/H1VYQSEpXG6h95StjrqSvSQPlOCckp9q
 26/bI83E4FfDuqmtQS0GjzY2aKx+aoVF8FyxadWIs07xcdXnFDV9ZS0LwueUJFVFm+4U49hV4c
 DqqnCRtxiqg26c9kKrOxVjxuDNISbI4Uh7UjzR64v8GAFDwpyCWhhu3pER5eq2ogcbLooR1C6+
 uHU3ykIG5KEEVQUMlnBSWypmnID0DKqgRTaJu/AkTBi+u54tJLUCVkOKbQH5FZh8k8EhDaEl3+
 uhM=
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="31389490"
X-IronPort-AV: E=Sophos;i="5.82,309,1613401200"; 
   d="scan'208";a="31389490"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 16:59:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRoR/QyX+nG3OvCeJZmtBxd/ZyxjuPz5XakTpQJHogcQZoOyoLU3y5PipSFQuO5yI5krLhFHWOPC/lX686Xn0JYC/oMCuPQhOWiCzrrpCNhM5BSZMYHyUh+RVUx/Hol/V32AuK+iaja0a42A/oXtgZV3JaSP46zRzTDG/mSB7ids/fTqGfSbG85lz1Ckt45YZTrSzBJZh5bj9GGGqHpw5kkgr2CGkLEJnJkwHLWTpBnALXhWMIdKszR2sePQQr9/bPnhlw1tQWTnRuRdrpJmlDw37g1zgs8VLj4JmIl4t6Lm7qidxbwrYpIyr6Umwk83HPtNJpKzj8zw0xCFNB7NYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEni4upU+Muo9Mib5bavyv35Kf6/2YJp+CKDzUuMgxY=;
 b=k86jdFLB0vyQ69j0qdtjCNECZYlDijNA/aRss9WKQX6GLGqUD79sZ6vzmq51D8EhSmaeVvhnFmA0dX86t5WG5F/UhyDNw1+slaSrBvpKOmJh1+karOBhVPC1iBw+iq7u81yZ5o60XrfoNLjpmUK7xSH9cSjHpPDYgqs40VrmnV4+R1CklaxxfUsTfYTHUqF0LXeKlNJsMSzm88Ow97QbWn7F7Ckn/PSyAmZofbi69YWT2QNaIJkIlR3BL7oEJosh7+sUP31Ll34iP+MRJmeedcd3ZhO0tHtQuWTGa0v1m8ztJQv9UD1Cs3/Px+Q11keIQPsGiTI1ACbMBZJRTArvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEni4upU+Muo9Mib5bavyv35Kf6/2YJp+CKDzUuMgxY=;
 b=DdmurbyJPokqqFjSa1dopPExMuLPKtLfC8OzhHLKqeW6mrTkiSBjNv+CdRdlv/AEsa6fKwcQLxDTpplcLm4mOjHfyLS0UYpvShwh276L47zgYJEGYv1N7AJVB9AlGt0ASqa5+0ZSJrF9sMvlr+xkx+pz0/stsS48wWhOlz8cZMA=
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com (2603:1096:603:22::14)
 by OS0PR01MB5876.jpnprd01.prod.outlook.com (2603:1096:604:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 07:59:06 +0000
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::702e:951e:8f05:5cbf]) by OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::702e:951e:8f05:5cbf%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 07:59:06 +0000
From:   "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
To:     "'fweisbec@gmail.com'" <fweisbec@gmail.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@kernel.org'" <mingo@kernel.org>,
        "'peterz@infradead.org'" <peterz@infradead.org>,
        "'juri.lelli@redhat.com'" <juri.lelli@redhat.com>,
        "'vincent.guittot@linaro.org'" <vincent.guittot@linaro.org>
CC:     "'dietmar.eggemann@arm.com'" <dietmar.eggemann@arm.com>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'bsegall@google.com'" <bsegall@google.com>,
        "'mgorman@suse.de'" <mgorman@suse.de>,
        "'bristot@redhat.com'" <bristot@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Thread-Topic: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Thread-Index: AddG3PD5Dm9CD2RNQ7+TrQrb7bYc8AE2Ispg
Date:   Tue, 18 May 2021 07:59:06 +0000
Message-ID: <OSBPR01MB2183384B29F6291EB7C0BB81EB2C9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
References: <OSBPR01MB21837C8931D90AE55AF4A955EB529@OSBPR01MB2183.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB21837C8931D90AE55AF4A955EB529@OSBPR01MB2183.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
x-shieldmailcheckermailid: c6fbaf78a10a477d8d815e3c7713c412
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76d3574b-bc2e-46a8-1fd1-08d919d2cfbd
x-ms-traffictypediagnostic: OS0PR01MB5876:
x-microsoft-antispam-prvs: <OS0PR01MB58767F2F1ADDB71B8BF62186EB2C9@OS0PR01MB5876.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wGwsYCnDkRk/v5Hxm7IWJy4mvngYyEBnckOI130Ruu6OhyRTgcqGaWdHq3Vl1RdbFwllV2KanjyHfAMm1/xeLr3YZBmcJpAGvFwukiADg/HmW0+zNIR9cFol2WCoW24uoMgpl1/JMazwuYpmhhJQiqAUUzS+wvidrGc2IwI2tMEC3uCPnsbSiPoE22b2N4eSGVjd5IVKWyBnF4IyKwzOQEKx2A5FdgbKcsoJQzY8Av86+JWO0pJxV765tfU3dHvTBigM9tAksdiQV4VzKdnqMOjKQbjHXEcCtymddeDrDEvz2MKWsq+21u6WbAXrfofLDgYg8Kxj9cDS6i3BpIcU61z3UifXhyapaP7e5X22AB0+JXteLfq74gMeF/mqrqxOCRWUET9H612wvhzuzCc4qCcJKQPdT6IKMKkkvaOKbRQwJye8UBQJ5eZzJ2RIJzZpm3vKjmeBL2n6PWTg7tiIaSpjUYWOjk+JTrwwGmdNiIgUc0H96TqE3aJyIdwRdFZe5vvb7S/oL2qC+E+7lU+v/g9Dvhb01UYiQZaC407xY3Zj1NOuSWgbDy/X6+9sxBA5TwxwFxLeUFJoFCKD4ThyVEDolR+13cOv/xWCnGGHabTfQG0vmPU1Z5o0lwc+CD6yzsAsukHa985DXg4Lg5gvjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2183.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(7416002)(54906003)(66556008)(71200400001)(186003)(122000001)(2906002)(6506007)(478600001)(5660300002)(38100700002)(8676002)(85182001)(52536014)(8936002)(33656002)(55016002)(64756008)(7696005)(66476007)(86362001)(76116006)(66446008)(66946007)(9686003)(83380400001)(26005)(316002)(4326008)(110136005)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?cUhIVnhvYWhsYytvaWpPUVVPeHlsRXorVWc5eGFWMlkyZ2hKZUM0YlFH?=
 =?iso-2022-jp?B?L21EdFJkV0xHRnlGeTk4Ri85Z1VMb0VHcGJVWEliU1AvZEhrcW9qTzY5?=
 =?iso-2022-jp?B?Z0Yzb09FNlpBd1pvRGxod0c2dG9QNEwwUjBzTWxqV2htV3lpdGZDd2Q5?=
 =?iso-2022-jp?B?NHV0ZTdpSzNYZ0podnJ0QXptcnJiS2F3L202eFhKaTVOd1JGUjF3Y2hk?=
 =?iso-2022-jp?B?RWJEVDY3MHZ0eURwK29mMWh1SlNpQjd5K3lnQjhJdlArSkZQblo3UkNE?=
 =?iso-2022-jp?B?ZXN1MnNwSDlaMnJHdm9oSWoyeCtrY1ZyNEtESFd5QkNwMG5oQUNCQTlW?=
 =?iso-2022-jp?B?NHZobE9TZFpFK1BYYzJOWXhGbWhyNGxzZ0FCY2E4YWE4Q3VPOVlNZ29E?=
 =?iso-2022-jp?B?WUU4L3ZPbnY0V2Y5N25vL3laSUJPM2VheFdDL2w1V21tbjBlMFY4SlJr?=
 =?iso-2022-jp?B?QisyUTk0UlNSR21BR25vME1RL25iMlozT0NhdXhuVGdZelBMV0V3NktR?=
 =?iso-2022-jp?B?bDZDRFpPWWpsUFJWTzlQMWdLbzE4bUo0dVROWVNCZDk5LytQblNyL2Ez?=
 =?iso-2022-jp?B?QURRWE4rVHZWM2EzanVjUnRoSkhUbWRuUExUTVZlRnNjZUl3SXhXL25z?=
 =?iso-2022-jp?B?T1QxQVpuUGJneWJjMEpDMXdXUlFFRWwyazF5YTlyY1kweFRiNGErN0xO?=
 =?iso-2022-jp?B?T3lIbDJRekEvd0NKa0J5YjNYYzc0S0xMY29QRDM3bWlOUyswcVMyUksv?=
 =?iso-2022-jp?B?bzZkVk54NXJDcTh3NllOWFoycllpLytnZUpWQ2oyNFZjYzIvakRsY09j?=
 =?iso-2022-jp?B?NHk2SVNGMUFVVnRVUkZwdEJ2WXY0ellXWGd2c2FYQ1BSRmdoSlRPUGtG?=
 =?iso-2022-jp?B?L25vZE4vaWwzRWVQTXExZndGWHhnWGxUYXRaOEhyRktKU1c5NFVwUjNG?=
 =?iso-2022-jp?B?eFVySEE4STZMb1N1d2c0UDNFaG1iWUtpdGxJanNRckl5MVYyaUtOdzYw?=
 =?iso-2022-jp?B?M1dFSmU3V3h0MjRDMW9FOWJPSWRwODdNeEZMOHA4NWxUdzRvRG1CSzNi?=
 =?iso-2022-jp?B?MWJTTGttZ0ZhQWdETVlsaWZHMVpqdkZvSHRyYWVCbjk5RkhEQzhXcWQ5?=
 =?iso-2022-jp?B?a095Q2hQMHRBY1FYVndFTlFRTno1M2N6VFZqQ0ZZZnEraXJJdUZ0eVhE?=
 =?iso-2022-jp?B?c05LV1dVWk81MkNKcENlaFhuU0pXRE1OTGpPcjJWSlBpb0Z4SVNFYlVt?=
 =?iso-2022-jp?B?OWNjRUd0NUdPSU1PL0x3S0lRSTg4VGRlbkMxSDNaNUl3NjVJNlhyVCtY?=
 =?iso-2022-jp?B?UjFNeXNhTUQ3cVNBZkt1aXdCaUlDRk0xTGRpUGNtaDRtOUxGRGpSbFNT?=
 =?iso-2022-jp?B?S05UWDdEYXVoTE9uQlhNR250eGdJaTE4UXI1Wk1scjB4VjhwR2FrRlBD?=
 =?iso-2022-jp?B?TUduaUxwWjU0WFQyYzN4ZzFpaEhING50clJCRHRIK1ZGY3oxNDVxN1dX?=
 =?iso-2022-jp?B?SERtWVg2RTV0ZjVFckd3ZDlJZmpzbkwrYWdWbkE1RjFYY1B1YzdualFS?=
 =?iso-2022-jp?B?QnpPaElsMXBoVnpWcmNaOTB5bXBBcG1ZaC8zdzZuWndra2dwSDZjQnlP?=
 =?iso-2022-jp?B?TkdUWmxYVUtFem9BNGVQNFArRjVCOStXb3JRZk1WSUJWcThEMmtzVVBs?=
 =?iso-2022-jp?B?aDhHdk9kdFk1M1NubHd6ZkI1UmVwT1ZkUVZZVWRROEJCTFpCL0hVSmdY?=
 =?iso-2022-jp?B?WmZIMlhEOWwrazNzbVgzZnBENDVLNFlMTmMrQVJkWk9xbDZPTVNQdGlK?=
 =?iso-2022-jp?B?aHcxVGtKandvSUZhMTJtSkpLSTQ3STl5SHNXdmV4SnJzV1QvVC9yS1JE?=
 =?iso-2022-jp?B?aU9kczBoaUpWeEJLOFUyZlNUYzk0PQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2183.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d3574b-bc2e-46a8-1fd1-08d919d2cfbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 07:59:06.7601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOtvcx9eB6IeAC2Tci/nTZpvqrODE7uXK7G/2fRlWjP25u1Anvd7y+6pfT5G8YimwVAzryzTaGMgvngbSO8QxRelU2XZjmUUcpUFfyFZKs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5876
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Peter, Juri, and Vincent


> I found that when I run getrusage(RUSAGE_THREAD) on a tickless CPU, the u=
time and stime I get are less than the actual time, unlike when I run getru=
sage(RUSAGE_SELF) on a single thread.
> This problem seems to be caused by the fact that se.sum_exec_runtime is n=
ot updated just before getting the information from 'current'.
> In the current implementation, task_cputime_adjusted() calls task_cputime=
() to get the 'current' utime and stime, then calls cputime_adjust() >to ad=
just the sum of utime and stime to be equal to cputime.sum_exec_runtime. On=
 a tickless CPU, sum_exec_runtime is not updated >periodically, so there se=
ems to be a discrepancy with the actual time.
> Therefore, I think I should include a process to update se.sum_exec_runti=
me just before getting the information from 'current' (as in other >process=
es except RUSAGE_THREAD). I'm thinking of the following improvement.
>=20
> @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
>         if (who =3D=3D RUSAGE_THREAD) {
> +               task_sched_runtime(current);
>                 task_cputime_adjusted(current, &utime, &stime);
>=20
> Is there any possible problem with this?


Any comments?

Thanks.
Hitomi Hasegawa
