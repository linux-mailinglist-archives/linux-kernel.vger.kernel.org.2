Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A270330653
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 04:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhCHDU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 22:20:26 -0500
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33]:27161 "EHLO
        esa16.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233754AbhCHDTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 22:19:51 -0500
IronPort-SDR: eBeE8fCp5mTVw2GT/fOfU4Ji8FHLZ/sA/8zYMfd6wukgF7j9+jNNSvKn6rtB8jiK9a4iYLClNF
 cM8UveL6b3XDijKeUs1r+/zTfwS5WFWHdGINDLvNL6WRcNwdhom8O4Dojdwd/g6nl22yPo47Ev
 o7p/2vOJyhXsGUdL06mGg+DuxFzyF/zSQP53KiiAAcRRxx8CePyx6hWwuvKwb3hW/TnU/w9jw1
 D51AB2a6rmlTg8574UyHlIxeSsJTXsFqApYkNbhSUBGQdE7BzAku1xb4pcISthv1Bu9r8VUnIF
 O54=
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="27394246"
X-IronPort-AV: E=Sophos;i="5.81,231,1610377200"; 
   d="scan'208";a="27394246"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 12:19:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBIj5GJFxKgXnZPGEr3CCZBrU9XIcx0txmj5RpbX9fgdDbc75Sm2xUiJ/OTBwIsq0p6eRx440vtYDjOnlVpjR3rEYHgUFdRLm0kHIbw7IWgOreIw2F6i6twIzYnZa/Xf8arD/JYMSNWqU7lSFEmIPxEyF8WCOoz6BcjjtBu5ZGlp/oB3Qk0O8tK3VSq+jADep8XtphOOXW6dV/pasYwJASFIOA3RdKNyLK9cnvIdOLb8JV/FAthIjH5rp08+z7bnb0HLCz97eFclsfoLuZ3svne3wS3+JIQVRJDGBHYFIvHshB3ErxxX1NYjIsEEB17Nmuksb9WJUgd2pXVEgF1nTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QFEuAMy6cEWLQFXqCzHORMlmufGKPzY+0qnqDJfR7c=;
 b=gLPD0/DGQMvAjqxfgeqb85xwHbuGt2rvNb1EM98DJPqbGy9wQwfLtC5oJ6LFNE2EywEPaVZqV7eB3uj6P4rULs+uE0pv9KicMKvAXVdfXVfGOmQm1MDBFZKkghMgE6h9+HoB5ewcxG2jh1F3Gxqkzmt4zXwEZrY4HFp2kIPkmFoz/7FmlkmYLyNgVEatHKGE/ow9AwD+8GyiHi2WHlAQCDd12M6S54j5mUWaZV+JqO9b9ybz5b7iEvMo+KAn1TvOyr+zZPhxxgvBah1xRdSqNR9aN+73edB/s8iSwaV43QH5jMXefP0U4o9iy20vdKJdcYVTTTvwmaunRF8S9tuzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QFEuAMy6cEWLQFXqCzHORMlmufGKPzY+0qnqDJfR7c=;
 b=I8L3XxbvVlBIPAqN/soDTVxx6raZ07V1A+8OxUo+ZWJOq6YY514X/J3d5iNUaP+1TbqHt7h7Ja5TDWPu5GlFYerZS2tjJ95NjjEIMGGd9SFISY7PPzw4CCegImlmrbyy17URkX9ULETtorkKp+RZzm2xIfmF/KdXRo+7MDyfS34=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OS3PR01MB5751.jpnprd01.prod.outlook.com (2603:1096:604:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 03:19:43 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3890.037; Mon, 8 Mar 2021
 03:19:43 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     John Garry <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/4] perf tools: Add lexical definition of event name
Thread-Topic: [PATCH v7 2/4] perf tools: Add lexical definition of event name
Thread-Index: AQHXEKlBkVxBxv6w0EWmceCNSxz1JapzkeUAgAGbKNqAAitpgIACFK2X
Date:   Mon, 8 Mar 2021 03:19:43 +0000
Message-ID: <OSBPR01MB46006C7AB7B1096DD2E1904DF7939@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210304032610.3112996-1-nakamura.shun@fujitsu.com>
 <20210304032610.3112996-3-nakamura.shun@fujitsu.com>
 <74955041-45ab-10df-e044-5d64898c81d9@huawei.com>
 <OSBPR01MB4600C6910F2AFFC5819C8145F7969@OSBPR01MB4600.jpnprd01.prod.outlook.com>,<YEPUhZPoUZrzGvaJ@krava>
In-Reply-To: <YEPUhZPoUZrzGvaJ@krava>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7703106-2074-4756-1c3d-08d8e1e104c9
x-ms-traffictypediagnostic: OS3PR01MB5751:
x-microsoft-antispam-prvs: <OS3PR01MB5751A0021F7B97F477B15537F7939@OS3PR01MB5751.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6bt6utkkE3kw0r0h5ZOhxo21QAuBAwtAQlt8tjJcjhj++tLKWosaumyw+VU9HO4KL7dJEvcKGKKsolbhV8heULt+VmaQWau2NAt5qZ7rwHM6OvLFltQM2op04vh3VyqpG6ofHzhumTW7QaYbOxsyMBg578cE5qMijizXoaxE92BeGZ8tePemozURYoJVopTytunjCmmJ96kUWceNThBfexmusJD2Z5tsNbDJc/STWAWj+/HxDiuyxkVYLDmvlEyMI8KAF6qTHnBhd2MrY/mFyurTQKFENG8oV8m7qgkTUAMGumVCAusw70JwQxL6XcmV4khcwIU16BOTJoU/NlKweSJk9zXB7rDt8FCrhxOpfgkn7/m0xKfCbiYwoiB495/XKldjb2KKV5PnPggPdgU//JhTtdmIZS2it5k4qG2BKH3UVobcZTDdIsso8XGFvY1PK4KqVY5bwNdix2oNAQk5gsS3KdxYHOCppylbIhb4A2O182PNFeFc8ppM/GsqXQrkH5L3YXhlxSC+bMxfo0qHIBRgDt5z4fPJDx4OY64QTKWCGoblt3LioIIwqCa/8G/VJxOsqknr4uftEaxtyVlgb0aTDfAesesNrVe2kfH/cco=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(85182001)(54906003)(478600001)(966005)(2906002)(6506007)(52536014)(316002)(186003)(26005)(8936002)(55016002)(33656002)(66446008)(86362001)(76116006)(66946007)(64756008)(9686003)(66556008)(66476007)(8676002)(4326008)(5660300002)(7416002)(7696005)(71200400001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?NXYrbFlIb0F6YTR4N1VzYWhwOGE4c2M1bTErMGlFS3Z5WGFLQThEWS9m?=
 =?iso-2022-jp?B?cFRWSUQwcVo5dEFHVUhxZTVWL0YxaDh4ckIzZG0vcDExa0N6dWl6bGNm?=
 =?iso-2022-jp?B?YnlFN2FTNWp5ZWRPMlBNc0dhNytRUmR6Q3hhSkFLRU9JcktkcnNtQTE5?=
 =?iso-2022-jp?B?WUFqS3l0VTByN3VLYVlnZHgzQ09hQWxlT3IvbU9JT0tKN3psdHVuMFox?=
 =?iso-2022-jp?B?T2Znc1NneThrb0tqYXcwa2d0U21yQ1hHMENjb042MlRMOUs3ZGdyajlu?=
 =?iso-2022-jp?B?ZEJSaEU0c0FsNlE0dGZhN3FrbTBvOTRXRVNsSCtXM0V0NDlrTmkwY0M5?=
 =?iso-2022-jp?B?TzVIelZBb244aDRpZFMva0JwWHkxVGFHdHloQkk0RmZJM3hGTm16citI?=
 =?iso-2022-jp?B?alJPSkRrSFhheUd2T1RKMlJDY1BwOHd6dXBzdU5pbjF2T1B2d2s2dkpa?=
 =?iso-2022-jp?B?SnZDYnhZaUFlS1R5Rll5QXVQQm1lZnNBaHVnOHVneENoMk9SNWZQdis0?=
 =?iso-2022-jp?B?UlJNdUVydUdpWk1kcUZwL2ZWYU1PU1JQWS9zZk12ZXFzVWRSeFByOEsv?=
 =?iso-2022-jp?B?RHBJSThMYjA0WGlEcEZmT00yZ1lYWkZzZE1SYzg4dUZySFpXZWpoN1NJ?=
 =?iso-2022-jp?B?L1Z6YndiVy9FVHlpWFFqZnFIQnZ5K2o4MXlSUnpGaElxWHpTMHFaRWcw?=
 =?iso-2022-jp?B?K3ltOTE2aGVoRXhLZTA2b2dKMGVwS29kZ3gwVTlNeFYvY2dKcVdJOVNl?=
 =?iso-2022-jp?B?N0tCWjRkb2pvdDV2Yzk1L09JVUNocnFNQVd4MjNheFJ0OXdCaStMZ21D?=
 =?iso-2022-jp?B?RWRaelUwa2NRR1RQZ1k1M1VNMzFWMDRKb201NXZxSlJzeTh6N3R2V1pX?=
 =?iso-2022-jp?B?SW9LeUlrK0tKSnBXS04wQjBLWCtZK2tQOUpOWUZDUE1oRlR5S1ZHWStP?=
 =?iso-2022-jp?B?ZE9BdlZkNWdBajJkQmlSQlIzTkN0S3RkRjFIUDQvanNJU2srVzJCaHFM?=
 =?iso-2022-jp?B?c29GRml3THFneDBGTjRkUEtPQjZWM0tOZEJJZno3czNXVm5aQ0JEL2tT?=
 =?iso-2022-jp?B?MUhqckVaVmlFN0JwZTRMQ2tOWVJPNnV2T1JhbW5hOWJKZDhHbDJxak9K?=
 =?iso-2022-jp?B?b2lHSFV1T21CYUFZSU5lTkJSTWt3cmZpcFlTK0Y2a2xmOXF6YVF3TnJl?=
 =?iso-2022-jp?B?eUdLcmxQWFZlVDI2azV4RERhSEsrWkZiZlVIYTNrM3g3Zmk2bjh1OU40?=
 =?iso-2022-jp?B?RlFhK1ZHQ0gxaHRrOGYwMlJlM1k1NlpUNlg1Q25leWxTSzU5UnBiRG9x?=
 =?iso-2022-jp?B?N1pVbWRMWXpSVElvNkp3c0lseTAwVlZiODNKRXlROGZidHZkTnA0N3FW?=
 =?iso-2022-jp?B?RTVKdys3MHRReTIrK2M3cG9sd05TMVdyMmxyTkljSk9xWkwyR2FMNTJ2?=
 =?iso-2022-jp?B?M0tvTVdQZzMvdHpSMDg0dURRa0Y5NlNZZmpRaVpSVGw1WDJGMlVWREFZ?=
 =?iso-2022-jp?B?SE91VzhLcGdzcWxlSVBwY2R4RGFYSnJLSjlTaFprU0xJN0MwdFdWcmVa?=
 =?iso-2022-jp?B?WnVYMG9tRW5MWVJrZkxJZHUxSG5DcVdTTkViZGJrT2NXVEY4TnlLUEUw?=
 =?iso-2022-jp?B?cmQ4ZGZZNGthc1hHNzBBMnhnQnJ5OTB4TCtpNVJOZmRTeWpMajBKTWJF?=
 =?iso-2022-jp?B?TVNTOUppTm9MTTJaZ2xjbTF5T1Q0S1VscGJQd0dJdDBBN2R3Q2FkZll1?=
 =?iso-2022-jp?B?MHBlUXBWQmVKT1JnZTRIS0xvbGxxdFppdCs2azVwb3c0cU8ydENFdUFx?=
 =?iso-2022-jp?B?Y2g0RXN0MGhwNVJNUHY5MjlOU2hMZFdnbG5EcmF3TjgvM3I4NjJnYU0z?=
 =?iso-2022-jp?B?V2lvK1owbE1JbnluWXZLRjBWSUZZPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7703106-2074-4756-1c3d-08d8e1e104c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 03:19:43.6295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRg7aIVZnmLImnuE2+2mItIF6ADBwdf6E/ZTO2Zx1sFu3QEcGJAaeTG3ozo6byEP0CmXkyUFbDYKTVyX6WF7f5etz/fv+VTV/k0QXWxaWLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5751
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, jirka=0A=
=0A=
> > > > From: Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>=0A=
> > > > =0A=
> > > > Add the lexical definition of event name so that the numbers are re=
cognizable.=0A=
> > > > =0A=
> > > =0A=
> > > Sorry for the hassle, but it's not clear that we got a definitive =0A=
> > > conclusion on this patch from v6 series:=0A=
> > > =0A=
> > > https://lore.kernel.org/lkml/YCuo01Wxxe%2FMCrC5@krava/=0A=
> > > =0A=
> > > Would it be so much worse for you to change format of these event nam=
es =0A=
> > > to not start with a numberic?=0A=
> > I was trying to match the specifications published by Fujitsu exactly.=
=0A=
> > We also thought that being able to parse event names starting with a nu=
mber would be an improvement for perf.=0A=
> > We've discussed it with the team, but we decided to change the event na=
me.=0A=
> =0A=
> hum, I'm not sure what's the final decision in here.. are you keeping=0A=
> numbers in the start? would be much easier if you did not ;-)=0A=
I don't keep the event name starting with a number.=0A=
=0A=
v8 patch serase changed the event name starting with a number to start with=
 "_".=0A=
https://lore.kernel.org/linux-arm-kernel/20210305101841.3133721-1-nakamura.=
shun@fujitsu.com/=0A=
=0A=
Best Regards=0A=
Shunsuke=0A=
=0A=
