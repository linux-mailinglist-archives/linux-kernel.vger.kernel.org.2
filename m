Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23E738878E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbhESGcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:32:03 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247]:60194 "EHLO
        esa10.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbhESGcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:32:01 -0400
IronPort-SDR: 1ESyxrf/1u1leirt7py9GiPuc0BT0p/9xlfyvdIjPKBZ24YsoVvNJ9ym7i85omXkLR7hj1J4c5
 1ZyDFGsEEOIOmx8rSVE6zXmVn564g3PVbsLmiyMKmIFx4/4v50Z2AMXWrlk4PJvz9BlefP2LNC
 NVONi8UyAMYZr96BOwp/DxZIJVa2E7QE73gVgJnVquf+MOvq1VjoZi4P8yyqKNwpA/Xy7CItTN
 PIiN4Y7EDRZyhREG7wCkuQz+kQ8JQQjWgKbbvHB6elH5zkfSa40Eu0lcVCT4e3eAWlgxR0IH1l
 U+c=
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="31547564"
X-IronPort-AV: E=Sophos;i="5.82,312,1613401200"; 
   d="scan'208";a="31547564"
Received: from mail-ty1jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 15:30:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNjPc413R6nVZbXs5tFcyskjnd28lZoJNW0DcElxb2tfUR91YtOOH7acz9JnAyiXYmSysEKtnmSjuiNqxAuIWZmK/RdOobL0skqPvcT5NmRMKEVnGSGHIbDDoAw5sFoJs9fedJuL6iw1VYDQm2S1o8UnNidiqlzlucn3gq7erDxsZlF+fmAefyJliUTXhiIfn/VKIkA50/xJWM3r5BZuqKU23+utc3n2624xI4lbS3WYUaADv9pqFAAOU1fIFLKhlkSLPSuWPNxf9dIXiPnz/Y8OqzsyIRsTpFHzNj5eYrpfwJEUGqFfBLnAW+Sm9BkCkGCtPXoR3gQouxPYoClyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM7ZQ/OXLVRXKc2Qq9a2PJSDwFGgaJkgZmeoOs1Q7kU=;
 b=PYpAvZ7S05RvP3+cNwLW6a7eSHaDg6EWwu2RuA3FYHTxu7KrIskcLVsHGQ0syA48MP07ueDdrTObmTrM0j5sa9rR6DybhPgPa4uARd2c9a7/c5KoTNjdYi1giFlWqv+/Hx0D35lh89D8UuCH0ZMSIfET4QXoZJUsbOLLvGBVlcowYfm5YdXUkJuWBkzzmH/OGhWDbrz6OMxvJEydm4/MgrkqBHx6OtYdQC1m0iOCOGcOCIpapkPpNilV+E4gg4CAGpqxT67ARQm9GJsx43IBct+GPin6mAV22prLzqT0NE32Tq/+HpvcQrAW36Z6PkpDmcqt/4bi+kav5IQDzvEXsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM7ZQ/OXLVRXKc2Qq9a2PJSDwFGgaJkgZmeoOs1Q7kU=;
 b=BBkKyq0XCt9pMfbpBC74rPBODRAUGhgZgU52naYvveWYw/52iA0iHj/4/cJT/8JXIoC1NeZLWYRk6lxy4emBbe5BUmRuYFcNi58l9DPKaBXYqdBcRa2PdEbh0NN/NyjW7gyUxV4gjnOG6pr1Qf4dHgHvM3y8FePdJVuJpSdW6TQ=
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com (2603:1096:603:22::14)
 by OS0PR01MB6051.jpnprd01.prod.outlook.com (2603:1096:604:cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 06:30:36 +0000
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::702e:951e:8f05:5cbf]) by OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::702e:951e:8f05:5cbf%7]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 06:30:36 +0000
From:   "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "'mingo@kernel.org'" <mingo@kernel.org>,
        "'fweisbec@gmail.com'" <fweisbec@gmail.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'juri.lelli@redhat.com'" <juri.lelli@redhat.com>,
        "'vincent.guittot@linaro.org'" <vincent.guittot@linaro.org>
CC:     "'dietmar.eggemann@arm.com'" <dietmar.eggemann@arm.com>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'bsegall@google.com'" <bsegall@google.com>,
        "'mgorman@suse.de'" <mgorman@suse.de>,
        "'bristot@redhat.com'" <bristot@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Thread-Topic: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Thread-Index: AddG3PD5Dm9CD2RNQ7+TrQrb7bYc8AE2IspgAAJjxoAAIq+F+A==
Date:   Wed, 19 May 2021 06:30:36 +0000
Message-ID: <OSBPR01MB21835E55331FCAE6F75E8332EB2B9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
References: <OSBPR01MB21837C8931D90AE55AF4A955EB529@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <OSBPR01MB2183384B29F6291EB7C0BB81EB2C9@OSBPR01MB2183.jpnprd01.prod.outlook.com>,<YKN5cQpFSdsgBlBU@hirez.programming.kicks-ass.net>
In-Reply-To: <YKN5cQpFSdsgBlBU@hirez.programming.kicks-ass.net>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f810ae4-9cb6-48fe-766c-08d91a8f9caf
x-ms-traffictypediagnostic: OS0PR01MB6051:
x-microsoft-antispam-prvs: <OS0PR01MB605137254CBFE548702EA012EB2B9@OS0PR01MB6051.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jhAppYaONqGHBWuTM7O2Rzll1qaqV4057n9+k/i/2YyDVtpM/AI/M3qRCr6u5FUb/vuPYunZLC2Irj9+07TbJqtmPEsk7MA6X7YpZsqrwss/Tv+dStxTWzAp4U4MoNZAFuK6+N/Se0l8shL0bODW0nskCxo7yf5cy8PqU8KJfrztIED5chjseepOO/aW8VZ+D1VADVx25Flf7MLlI3JnN+5C7zfXPWG4+PwudhB9D/0EW4jqWRLkgxvS3t12GBz16iLX9OkH1prl27KrupjjiP9C+236/VYfOf+4jCUMmDxH6/G2HTJSv0q3zxXl+fcLkEF9we33gsMZwp5AkiCNvtucdn3NoEFTYOIq/HmkYUijXNhkeCvV0RFmV9XOISokNy8LWcUi2L5yfo8/P+px3qvb+7jTR46VpifdBrQQd0Txjz3wf5fsFXXNPwpSy3F68St6aDY+9pqIbSgeF1tV5ru/uEkN+9I5+tAiVHLlVlkMHCIFLkMY6PRYFWzy9OursS9SEdkOUR8pnKzlYavdL8YFmkZAR6nQR2tZqkshHurmPFMn8f0J8JAc2zMXB1v22KhJP3F3LQjfDQ19ERqvLtfdVRcbJWRS/t9Q/EKfEHsfg/4ndBAtwYBbXuQ11zXnDOW0Zk3pzlrQcktia6q08A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2183.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(39850400004)(396003)(316002)(478600001)(7696005)(8936002)(5660300002)(7416002)(86362001)(110136005)(85182001)(66476007)(64756008)(66446008)(8676002)(122000001)(76116006)(71200400001)(66556008)(33656002)(83380400001)(6506007)(55016002)(54906003)(2906002)(38100700002)(26005)(4326008)(66946007)(52536014)(186003)(9686003)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?bjVBOTNlb1pVNnBkeVJpUk0rNWZQVC9RbUkzQkl5OVI3alJCUnZyRU53?=
 =?iso-2022-jp?B?M2toVGcvZytCTmQvTmFuNUduYWVKOUEvVzhhRyt3b0RiN1hnT1I4Q2Rh?=
 =?iso-2022-jp?B?cXdWL1RVUTd3SCtyekVIQ2ZwMmtITVR3U1BKMmQwb3RsMm5Nbmlrb09G?=
 =?iso-2022-jp?B?MUl6UlJETmQ0RVhlV2ZLeFgxUFhQZEEzSDJzbGxiVzRNNzVmM0Uwajlr?=
 =?iso-2022-jp?B?S0lTUzJFTE5EcGVXdmZJUDYzSkRzelR3UlpNbUNQY3VtTEgxbkhzQWdP?=
 =?iso-2022-jp?B?c2s4R3M4dUpJKzhjUkZzTXVmeFY3azJybFBSTHh3UTRZODM5dDZCa2Z3?=
 =?iso-2022-jp?B?UjhQR0ZESGQ5Y1grWW44ZlNucEo1UVMwT3hsNVVDYXVGK0M4aHkrcDRO?=
 =?iso-2022-jp?B?NlZnNGdoR0FpNmdMYytRU25IMmQ1TVZJOGFsSDNiZ0FWeXpXeUNFSVMv?=
 =?iso-2022-jp?B?Qk1LaGdBUTYzTWJNWG5mQndnNWhjeXo1QU12NS9mVGhOWHBRSU4rUTJ2?=
 =?iso-2022-jp?B?V2duckZRVzVVc3JobjRCUjhyQ1lSRmtLbytjRkhVRERucjRic3E2SFJa?=
 =?iso-2022-jp?B?eWl6cEtjcjhTRWtoUThqMlRtY21RV2dDK3JEY3pqOFpSLzFNOU03WGxY?=
 =?iso-2022-jp?B?Qkc1d1g3aHcrMUZmcFA0T2FtMVZ6Rlk1MEVKQmJJdUZOcU4yK3ZmQnB3?=
 =?iso-2022-jp?B?Z25oSGxMd3VpQ1p3aGhocnQrWkxXZGJsay9oWmpFdThKNmZKTlFQSEFQ?=
 =?iso-2022-jp?B?Q0VCays0Rm9PL0RYdTc3NlBPZGxHRll5MCtWVm51SkZqTmdiRHNmWnBN?=
 =?iso-2022-jp?B?cGpCMlZrLzcwNWlBOXdMUThDRXc5dlJKNVdlUFdMNHVUMDlJYk1icTVu?=
 =?iso-2022-jp?B?d29QZklCa3ZxR09aY2dUa2VDdjdMSmJHZHZOemRZdE55b1k3aTQ0S3U0?=
 =?iso-2022-jp?B?NDBPbXhDWnZLYnE2WDhMd2l6STYwNjM5UXFzV245RmJTRFE4ZTh1NERM?=
 =?iso-2022-jp?B?TnRpbGZ5d3FMdUdHTVl2QmltZFRRZWZWSEY5QlNGU2RTbzk1THJOSEgx?=
 =?iso-2022-jp?B?bjZXWFdVMldYVmk3RU5jUTVYU2NTNnB3STJMbTZmM256M2pscUFTZWRT?=
 =?iso-2022-jp?B?UkZIR0cvaVZzaHA1SExKOE5kbVF3REgzWFVVZTJodXdxRnkyS2pCS2hF?=
 =?iso-2022-jp?B?aG1MUmtiU09BUjNTc25MRzRsOWJKYlZKcU5pVEJRdVhOZ01SZGJDVTRr?=
 =?iso-2022-jp?B?WG1BdGc0NFVCQUZNMGduL1N4Z3l1L3V1YU54TmlBN1lDZjZ1alU1dk5k?=
 =?iso-2022-jp?B?UkRhN01YWlRjMUg4Y1lUWmFYd21rU2tRQ05iM3RCQ2F0WWtxUXVKZTMw?=
 =?iso-2022-jp?B?bzRmMDZVVjVCWnlaWHVxWDRiMnRxVU5iOG5aTnVKbmFQYk13V2lWeTBE?=
 =?iso-2022-jp?B?cVhPbC8wbnluekFyTDBSMU5reHVyaHNRMGxTNUloK09zOTFqQU9IbWtM?=
 =?iso-2022-jp?B?bjRCTVhEdDZ3bzNQRWtUcndXWVNtcFNVcEtsNTBwbEF4aU9rMHgxY20y?=
 =?iso-2022-jp?B?aTA3V0xSbDIyRDRiSzQxaHlvdWNUcFBwNExPTFdxLzQ5OXE2T0RIbE5t?=
 =?iso-2022-jp?B?MGtnMVFoMHVGWC94aGZETHZwdUs4TXFPZjcwTldIV0FhVS8rU3V6ZVVw?=
 =?iso-2022-jp?B?MkFpVm1icGVnaE9LWlptV0FHZGhkcWhNU0V0VjVaL1JZejV1RDloQmlz?=
 =?iso-2022-jp?B?SFFiV1B3dWsvellDUUhDejcyVEJJemduNU9rdExIbjRaY1JOYlRWcEhN?=
 =?iso-2022-jp?B?TU9vRFY5bnVsbFhtbHFSRjQ4NnBDNisyZW4rYXJCUTAzeTZQV1VqVEpU?=
 =?iso-2022-jp?B?Y0tMZTZFcnByVERHMUhZSTZoY3ZVPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2183.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f810ae4-9cb6-48fe-766c-08d91a8f9caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 06:30:36.0166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ay5LQWmqHOBJgAi8q0ewDtxJQudrI1jrgkUU8X/kZz5MdF9oCD9rDGAfMXd4x+sbAKU1HvyP4yk+M/4fk55en1d3Sp22uSB9SjsdJcO/fQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Peter, Juri, and Vincent.=0A=
=0A=
=0A=
> Your email is malformed.=0A=
=0A=
I'm sorry. I was sent in the wrong format. I correct it and resend.=0A=
Thank you, Peter, for pointing this out.=0A=
=0A=
=0A=
I found that when I run getrusage(RUSAGE_THREAD) on a tickless CPU,=0A=
the utime and stime I get are less than the actual time, unlike when I run=
=0A=
getrusage(RUSAGE_SELF) on a single thread.=0A=
This problem seems to be caused by the fact that se.sum_exec_runtime is not=
=0A=
updated just before getting the information from 'current'.=0A=
In the current implementation, task_cputime_adjusted() calls task_cputime()=
 to=0A=
get the 'current' utime and stime, then calls cputime_adjust() to adjust th=
e=0A=
sum of utime and stime to be equal to cputime.sum_exec_runtime. On a tickle=
ss=0A=
CPU, sum_exec_runtime is not updated periodically, so there seems to be a=
=0A=
discrepancy with the actual time.=0A=
Therefore, I think I should include a process to update se.sum_exec_runtime=
=0A=
just before getting the information from 'current' (as in other processes=
=0A=
except RUSAGE_THREAD). I'm thinking of the following improvement.=0A=
=0A=
@@ void getrusage(struct task_struct *p, int who, struct rusage *r)=0A=
        if (who =3D=3D RUSAGE_THREAD) {=0A=
+               task_sched_runtime(current);=0A=
                task_cputime_adjusted(current, &utime, &stime);=0A=
=0A=
Is there any possible problem with this?=0A=
=0A=
=0A=
Thanks.=0A=
Hitomi Hasegawa=
