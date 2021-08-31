Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733743FC1F7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 06:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhHaE0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 00:26:36 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34]:11042 "EHLO
        esa17.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229662AbhHaE0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 00:26:34 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Aug 2021 00:26:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1630383941; x=1661919941;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MdATv2upy9CRVlMksvtepZJz+iM9Pn9RN05CdKuhZ88=;
  b=yPXwinSmbQN6ztFgNFIPo9A0hnHf3IK2rkcMiXAe5IcWGxdbaLL5qfWJ
   F8Ci+O0Zkg1RqdozIXmZw1twHm6tgBAcCbVEZtLrUqWdiSIIgCoi2b6qf
   7S+ROvBZjuVgp7X17SiJa9ak4vclSE2rY01rvdfi7HRgMTmLwKH8Oo3B2
   a1L1pJgewhlOJhdKdas1LIDVkQwa7bND/2+ZwwcmSCA8VyRaaPmPuh5Vo
   1FTdKInAwI4vVw4NXsnDVctz26Bt18gSTEtVKGYuH8zrEZxD61bLKxppT
   hLWrCvT5snPAAhphuhOtRkswHs/mejHbdtAEJEE3kCzDU8XOuTtv5dC+E
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="37958942"
X-IronPort-AV: E=Sophos;i="5.84,365,1620658800"; 
   d="scan'208";a="37958942"
Received: from mail-os2jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 13:18:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atUkdoHkOxYTiBZW/zrMvjg0/3lQ8CL9M2npaw7hdoMvYTEF1FIkUCnGCTikXU6GTUB0qrNXLfKvddCwWzz/7HcCsk1jJcUwoVC9b3Hp0sTZf8aluUKvsYxYQN3aievQns46CD/ZAEErtMqFdST8GFkB52hos9wzuxDA2Q5HY92dCcK8IHk6aV2Yk3OoQ0gL74V0bT61oYKLFDOAQIJkBBegYTpqQ4LMDWE4iIZauiJNaW4JXdVDkpbdqKm68kydDxo+Rw7LjWrwqgwIDgpVYwDWQh/2nwudsRIfZw9dx5rRiFLBgHzg8A+RwKOhqhdK4i6pvlMnFMktlPemN3aivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdATv2upy9CRVlMksvtepZJz+iM9Pn9RN05CdKuhZ88=;
 b=ZYRWEWcB+fMUFAn7PRu5wmMIiGil3zyBPjfsLZNiOaa39ZhZJkfnSXPZdxNKFE6NSX0SMZ0s7S1iOKsIcz/IMcGAnxzx3zQeF40xqt6Yh6o/ECD6140dQ8xO9/VXV4f+nbf4zj0LG4JJaoHBdLEszLEXIcINLbFfaZGuijny3ffuqKT+PV6zunf2Ae4yeOIP+Ngc/GP+fDhZxE2+S8XDZNZ5bSIsJbQquy0M6zZaAI+8oF5rg52n6hGfjMKTDU8Ww+hK6s7S57ee3WakSZQ6a+Fid3CsbEGQUmQ6L8V2I1Xtk3XfZGdn/FLzHRqderQSyhuqVpjuNsbmODkH0uSyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdATv2upy9CRVlMksvtepZJz+iM9Pn9RN05CdKuhZ88=;
 b=N4+LKJ7hvknBfclxKr52Rr2ObCpXgdXDNvasrwYIB5TMXikFlTALMmIHgXN8newh1OYEdMWm+7/zdU5UMtuitQgzRzK3q5Ie3eGQPeAdgUWxhcI+ALUzr4jdgkgbG7XAXEyluRD2GRu/6AAXPBMUALZWtAFFCdeTStq9fCMwyaU=
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com (2603:1096:603:22::14)
 by OSBPR01MB5286.jpnprd01.prod.outlook.com (2603:1096:604:1a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 04:18:25 +0000
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::790d:4d39:f3ec:6c25]) by OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::790d:4d39:f3ec:6c25%3]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 04:18:25 +0000
From:   "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "'mgorman@suse.de'" <mgorman@suse.de>,
        "'mingo@kernel.org'" <mingo@kernel.org>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'juri.lelli@redhat.com'" <juri.lelli@redhat.com>,
        "'vincent.guittot@linaro.org'" <vincent.guittot@linaro.org>
CC:     "'fweisbec@gmail.com'" <fweisbec@gmail.com>,
        "'dietmar.eggemann@arm.com'" <dietmar.eggemann@arm.com>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'bsegall@google.com'" <bsegall@google.com>,
        "'bristot@redhat.com'" <bristot@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Thread-Topic: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Thread-Index: AddG3PD5Dm9CD2RNQ7+TrQrb7bYc8AE2IspgAAJjxoAAIq+F+AARwywABYd9iwABIB9liwEkfn4KABmb7AAMfYBWZA==
Date:   Tue, 31 Aug 2021 04:18:24 +0000
Message-ID: <OSBPR01MB2183E96914F5DDAEB293274AEBCC9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
References: <OSBPR01MB21837C8931D90AE55AF4A955EB529@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <OSBPR01MB2183384B29F6291EB7C0BB81EB2C9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKN5cQpFSdsgBlBU@hirez.programming.kicks-ass.net>
 <OSBPR01MB21835E55331FCAE6F75E8332EB2B9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKTZag/E8AaOtVT0@hirez.programming.kicks-ass.net>
 <20210616125452.GE801071@lothringen>
 <OSBPR01MB21836F532CA384C7378C1284EB099@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <OSBPR01MB2183D3C6B2BBF25B22DD09FAEB039@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <20210628141300.GA5710@lothringen>
In-Reply-To: <20210628141300.GA5710@lothringen>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-08-31T04:18:24.461Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d72d1054-b859-48ad-0ae7-08d96c36605d
x-ms-traffictypediagnostic: OSBPR01MB5286:
x-microsoft-antispam-prvs: <OSBPR01MB52860968F08D317244392786EBCC9@OSBPR01MB5286.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8aTAnNjgR0B/iaaSB78vahyQ87xIWRlaLeETiAEYSJhvD4iGEH9sJOI7JGOm21tb5Ay9u0d3qsxcUTAAOVcNTlAOOY0A64XII7u6G03Q9FsW0HN7g+XZwula7oqs/0X0w/ate98Njp0V0yljNL6RROMrAMat6jeI9UDPfsJpMbL66GrOZgucRJRUunbBpRERlelj9PRp1n2DrctTjqVGH4OT2qATYRIwLMd0nndzGP8KGBYQmHWDPIm8IxF7xKu+XNFcgzVsPd0TPTlDxP9OwF/6X6U8b/BfhSfq/UosJn8K/fTXhpJrJt2Gcxrm7xMDc+KzjGcfdkRHSwvmnW2n5qJYdgYrkwFNoU3bRrvZoEsNl+y/hIdvKgbKSkIfnyiHL7I1HBp+xJF8zH8uUMbrTWs6a6nxuuynFFf0OOCviCKjxRerzJmHH+GjEeFr3rxXHEoWxQ8U4wCglJbo7t0Gm/6m6GrhjyJnPJf3yi1CKxBSL772IrnqNYIJwT+yx+LW9GDDTP820uFuHcte3TfqpPvsyrajUmILXd5Hg8VqO94hcn2fZEC5xxGqxJz9wRMegGK+43zRjeeiaxnvTTT2IRn+jbtfVELVn6CXfAvDkRWej7iiMl/sHByyKVodZAr9MPMWhHCHkUshkiPjCJ5wxeIlDt3wKs8lPkEhmCZGRcT7Aum8FJ8dt8SBZh+MSjwvWfYe9bp2zl991QEAksC8wvKznAjoid9NSK6qijc36NY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2183.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(55016002)(86362001)(316002)(9686003)(76116006)(66476007)(186003)(5660300002)(38070700005)(558084003)(91956017)(66446008)(64756008)(71200400001)(6506007)(66556008)(83380400001)(66946007)(7416002)(122000001)(110136005)(52536014)(8676002)(7696005)(8936002)(38100700002)(2906002)(54906003)(4326008)(478600001)(26005)(33656002)(85182001)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Q0JySjg3RWdxdG1zZkxjYUdvS3MvbUphb2dDTS9nekFONmtCVE5qM1BU?=
 =?iso-2022-jp?B?YVZmYzFXanZndWxNd3RrVzlBN1NFTFNhMUJMcXVxVitjY084S2ZNTk9W?=
 =?iso-2022-jp?B?aXdnVnFkRmxqVnU2d1dTRWRnQXZ0NnVaSXQzeGpoQk5VOWRPTk1lUVVE?=
 =?iso-2022-jp?B?U0Rmc1lJbGtqcFJCdDVjN2RRaVZFdEh2MFlJbS9pblBWdDV5MlZuYVZm?=
 =?iso-2022-jp?B?WVVsem50ZFNBa2d4K1JJaGErQ1p4ZVN2djdwZE8wa0FycWhHdXhWajdK?=
 =?iso-2022-jp?B?aUo5R2dHZVN1LzlZU1VjQTdURWNsSldyNExYMWh5ZHNDcUpISkVpK1hp?=
 =?iso-2022-jp?B?Q2xVQU5mOHM2Z2RwUUdacTJNd29nLys1VFpvVDdVU1NSUzNPMTQ3U0Jk?=
 =?iso-2022-jp?B?N0dpUnN3V2sxVlVidlo4UmJ3Wmllb1owTjVjbVdDK1YydlVOYTY2YXpu?=
 =?iso-2022-jp?B?UjVMbEFTVmQ1Mlo3MWJOSjBjdzlJOVFLVEpXNVRqM1huKzVZYlB2Z0Nq?=
 =?iso-2022-jp?B?b2xxQ2lRU2U5ai9tUFVGMGZycEJsbThoTzV0VFpNYjZVYnRLRmVGamI3?=
 =?iso-2022-jp?B?ZzF6QlR4VURJWkViMkNXbzJMVDVZL2xBQWZvOER3WjlJd1NDTVdhcUR0?=
 =?iso-2022-jp?B?eHJsRTFtb056MVYrYmFMTFlxTXhQRjRXWDJnZkpPd2xPZ1NQeVBUdzJw?=
 =?iso-2022-jp?B?SEttcGdHc0lTUDZOeWswbEVhN2JtbktpcXNjWWNqY21XVDFmQjdxWFRC?=
 =?iso-2022-jp?B?UlBKMmNuQkJ2RWs1RmZpejBXWjJzUitwbzdtZTFUUGNLWDZaRU1FVlNz?=
 =?iso-2022-jp?B?Y0ZhZ3QzZkNXenc5cDhDRVFPZGpjQkZHZzJMdVhoZXpDNExpUDZ3bkt4?=
 =?iso-2022-jp?B?VUxQaU1acTl1Y2xVK1NiYVB3SjJHVUFiR3VCN0ZaaDZNRUg5R1RaUVhC?=
 =?iso-2022-jp?B?TXYvQm0rUWx0QWRPckFjZ2ltVXIrcGN5Y1dNMzIzV0dnT1dpVDlTeTJC?=
 =?iso-2022-jp?B?b3lueCtyOGZSMFBEL3hqUWxPMWxXQTdCUUxuK0Nwa0czUDNMRFkvYkRF?=
 =?iso-2022-jp?B?M2tQazJSUS80dHdUaEZXdHNNYUlDUzFmczNlbGJheVJIMGRKL0cwSDlj?=
 =?iso-2022-jp?B?SFN3YStIMmtTRlZvUkI1Qy8yczNqbW90Y2g5ZHh5bndIdXBuMlpVMGRR?=
 =?iso-2022-jp?B?OGIyZmxvRG5JWDd5bWVHWm5uUXZNZFFjZkNabW91a2tGbjFBbmpvQ2Zj?=
 =?iso-2022-jp?B?bTl6OFEvK3pWajFydXpnczhkakVIcGNTVisvSjdGUWttdG53T0c5NmlL?=
 =?iso-2022-jp?B?VVJwQy9Takp5M2RxZjZmRlJXNTlOeis3L08vRDlHeDdGMlhrbjMvTXZG?=
 =?iso-2022-jp?B?Q1d3RzlEVFpveWRwcFNnTUpYNnc0MDdWUHdGRGhDdnMxS29rN3pLYi9t?=
 =?iso-2022-jp?B?Y3E4b3owZ2VMNzJNZnBCV2dFTnVTNEFKa1FEWWVzQlFZbkwrZ2ROTkVy?=
 =?iso-2022-jp?B?bVNPc3lhNS9QNkgxN1FzbFV1VVd1eGZFZTNiaFYwMHdlZHRyYUN2NGVO?=
 =?iso-2022-jp?B?V2IweUlEOGxSdURvM0FKSGtIZXB0cjNMTTAvaThncnI0Ylc2QXpBWXlJ?=
 =?iso-2022-jp?B?M2dVVkZUUmZOQnBQUWx3SEtvZkFYUEJCUTRIZkMveHJYYmlsU0grTWNl?=
 =?iso-2022-jp?B?azh1WkdKdEFSeTdJL1JHc3c3SkMwSDQ3dkZlS3B2eFcrWjVQWG03UFNa?=
 =?iso-2022-jp?B?VkRpSTMwN1JudWxQV3BQajZvUUxPUTViWE45RUxmN0NwNHF0MmtVbjF5?=
 =?iso-2022-jp?B?aU1uMkpuZDhmeFhQU1daWFhqVFRTOEFxWWJ2VU1Eb0IxbHNuS3ZZeWJ5?=
 =?iso-2022-jp?B?ajVGN25ndzR1SzNSRkwrVmU0S2djPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2183.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72d1054-b859-48ad-0ae7-08d96c36605d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 04:18:24.9700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wFnN8JbG2iOIOxtpaBpPZijzn0SnMmvfW3cPMzFObjqRDtcCxOZW6ABO/aLohd3c84/epqxlDl8dawwnaLtcowMaCWM3XA83kCyxveby5do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5286
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,=0A=
=0A=
> > I have also confirmed that CPUs other than nohz_full have very little o=
verhead.=0A=
> > Please consider merging it into the mainline.=0A=
> =0A=
> Ok, I'm going to submit a proper patch.=0A=
=0A=
Thank you for working on the patch.=0A=
Do you have any update?=0A=
=0A=
Thanks.=0A=
Hitomi Hasegawa=
