Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8FC38F39C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 21:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhEXTZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 15:25:24 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:36798 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233026AbhEXTZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 15:25:22 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 69E08C0ACE;
        Mon, 24 May 2021 19:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1621884233; bh=2kEvfmAHdsuCvRgb63lIenXTOYeD0uOkz4SOBk49JAc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RcmCtlHEuzEo7caO+fkbWgcP2feUkOsC2OqsFPJcj5Z0Pr90mb7j18lPOEflu1guy
         I3MfdUOXKXGnzlFqHPTRrB14IlK8kfV4cgBMtixjDLf/yWPkXzbbAjgubppm8u25UK
         569wMD1duY/vEp78agqYBqQsxfu4Z1AGZXDfZQcnSK0WsStdcKJnOiy9EEowjER4Cj
         oJIvS6JxP/t1CFmCMUzgRPnbnK9PbzPmtqFwKSpDqQtLuVKA7ZjxH/K0a8ErjqOaOT
         5pTqtfICtDlfrpGTyQ3EOJhcMy90L4bMUaVfG09Jdnln4qfQC6bIrIC5xVzoXhYfZs
         skFlWnD8cJrXw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2567AA00B4;
        Mon, 24 May 2021 19:23:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0C3E9800C2;
        Mon, 24 May 2021 19:23:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="FXX3UJw6";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAgmd1PrgzMmwSr3sOSto5zx9LD+1xGEZ54c+v/LJU12Zat7u5lNep9TY6U8L3IqTSRhi3ZxlP9RZNoBDDegW0FleuDE6ZFpJ1WWnHBjQY7GT5GJIv+0iYhOkA4GTG/7Rf645TD27dYUXzeZVIedJTomZvnmngPRlP1N3ihQAc/viewzfFJQtyten8yOblXsa1BIPw7w6UMbkvMTBA9Gy3oS6pCCuvqkJplAd1yc1I4O/w6Hm8X1ldyssqTuadR/MUOMVB23d922/eVenfAhUvSJoZTCLuBpT4+rujktqm5+pkdVi/xnFGtLI3eoHE8MdMsgYRFNTtJFnW3URhqGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kEvfmAHdsuCvRgb63lIenXTOYeD0uOkz4SOBk49JAc=;
 b=lfjzgUpls3Bf4pRMcLTkZVyyaDGDD8jN2ekE8j1nh69jjIVEs4hTZIjdCNPLGXm57TNiMSMfTGXSCyjydp0vyV/jkLnkjjttq4Bolz8RyJeEN7vGtox9DAfW8ojXCwJ9wjzFx4w/eLs5htIz6m8o/wmxEf2K6yO6wTsrQIZPEsE7xwSxjDs4W21f767oY0pRZW+00a6kPT94F3btEQo3/n09UoN0wy7VpX+ALhUc9zl2r6urd7w+Nj+bq2YER6RCHqn5RW8FGYOWtF6tZz70Rm1rM1gDaZqlCA/llsl2W053RwXfK+PB+0FTbA4Ne5Kjot8D2GCny4WaFg42lSA/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kEvfmAHdsuCvRgb63lIenXTOYeD0uOkz4SOBk49JAc=;
 b=FXX3UJw6nT08OmjrZX5SQbpHvLXkIuU3YV5z09pF5NmH6I3iMmet4G7CR4xoRXhcOUEwKFWsdV9VQoq3ob9AHbZepnFbJSjTaHAxFbSsG4NoSoItahuc2+sZ9dtoGV44QMsRhs/0EUhpcU1pOK+Rh2Blb8njq0/Qr8dO7/dBZiA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB4711.namprd12.prod.outlook.com (2603:10b6:a03:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Mon, 24 May
 2021 19:23:41 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::88be:f751:f493:25f9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::88be:f751:f493:25f9%6]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 19:23:41 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Guido Kiener <Guido.Kiener@rohde-schwarz.com>,
        dave penkler <dpenkler@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        USB list <linux-usb@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [syzbot] INFO: rcu detected stall in tx
Thread-Topic: [syzbot] INFO: rcu detected stall in tx
Thread-Index: AQHXTOaYgJWmk5cMcUemqbVphw6dSKrrnjyAgAE1xgCABfJugIAAPHIAgAAH6wA=
Date:   Mon, 24 May 2021 19:23:41 +0000
Message-ID: <354a16cb-ba96-aa6f-7f10-388e6201e56d@synopsys.com>
References: <d673611ca53f42a3a629eb051cabc6eb@rohde-schwarz.com>
 <20210519173545.GA1173157@rowland.harvard.edu>
 <12088413-2f7d-a1e5-5e8a-25876d85d18a@synopsys.com>
 <20210520020117.GA1186755@rowland.harvard.edu>
 <74b2133b-2f77-c86f-4c8b-1189332617d3@synopsys.com>
 <37c41d87-6e30-1557-7991-0b7bca615be1@linux.intel.com>
 <20210524185520.GA1332625@rowland.harvard.edu>
In-Reply-To: <20210524185520.GA1332625@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
authentication-results: rowland.harvard.edu; dkim=none (message not signed)
 header.d=none;rowland.harvard.edu; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [73.15.163.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d30c20fb-cc9f-496a-a23c-08d91ee970b8
x-ms-traffictypediagnostic: BYAPR12MB4711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB4711C394E84208AB8F5E0FB2AA269@BYAPR12MB4711.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cz8VP997QxwKh/k5FJGbJZq0tvxHVUegkrAR/5ag6Y94iAkQsD3eYIb4o4fGYdFY1a6d/O26TTy+lHc8oCoZ6EluaeCOUIMtekH+9OtPx65ow4Sod2fUJm1tIoBKg6bjkz/dSN0hNMpTfkCj3v2+NYyE5cIYhTMLn+IB34gQbKtjSoSWhtaLX82a+bqCU7VjzB4H8jFOESe/VWkE1b3S54SfvXjiqc8Uo+JDnAu8Muo6rDWyX6OaE7cxNWYjU6ab3owDoIB1J61v2qbzZQX/qCo/pQ2IN97es2DJ7LUrjZn3h27cCEBOIfIgqXZ2OZR/I6OioZsu1qozhzL85ddCwh3JnoPdQUwJDEqli8Z8BNOxBiY7DUlAh7YC9XPkXEKhfGdcCzJwS+Dyx0L6D5WDoTzT7z5uBRj3s1q46fhToVlUY5xOCwZbaj61nerF6MPcQi/5RNbO9iJ8WrLcuD4y2+41FaX8G0X0U+i0ARYcJC0U4p+RGuWAlyTZyOJknDpWRY1ZwpjZvh+H86Z3hoJXQE4li8o2QllFaTUYMvGlgxyfIYjgzLx0la4SjnP6PCnpDN08hkknhAHF3+UiJlOAuHXOliEcL53Tw8tBxWpx0d+oNgx1xlOdeOL+dCzX43Ap1tLK5FDym7vJRqM0aqGT2/xbbB3OYCZihMeH/8OREL9ZDKnCjFxZv3TfS+/6RgiT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39850400004)(366004)(136003)(346002)(396003)(54906003)(110136005)(86362001)(478600001)(64756008)(5660300002)(31696002)(2616005)(66556008)(31686004)(8936002)(66946007)(66446008)(76116006)(6512007)(66476007)(2906002)(316002)(4326008)(7416002)(36756003)(71200400001)(6486002)(122000001)(83380400001)(8676002)(26005)(38100700002)(186003)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?a1NTK1YrcEtxZDlQelIraEx5UkZiNmx4YVJ2a3Q3WnltWTlEUHpoaHZoRkF0?=
 =?utf-8?B?WjhJUjhzR1pzVjhFckxPL1lJVzN6Mmo0SG5hVjl6NnJSZDBJd1hSWDNFNkQ1?=
 =?utf-8?B?NHREUXRUVVFRaWVUSlZCb0JNREVIWVZzZXZBbHg4ajNKM0VEMjlVOEpwUUZx?=
 =?utf-8?B?RFA1N0Y2ZjhieHRYZitsSXFJUXVpaHk1dWNqM1RyWTBtMXU4Z1lUOElQQnRW?=
 =?utf-8?B?VEt6U2ZSVmdzWHloUXhYQ09iWkN4V0lLb1czY1ZZdnpNVklnZk5MNHdjb0hh?=
 =?utf-8?B?K2tVREVrTU41QTFKZTd3VGlwakJTbUJDdUxPKzduSUpHTDlxNDFGdkZ2Z1Rt?=
 =?utf-8?B?NElnUldCRW04T1ZRSHF3MTYvRVhDTWZZcHU2YzV5b2w1OFg3elRuZTBRMzhD?=
 =?utf-8?B?L0RDWnMvSUJQclhpTEVPdEo0T0ZjQnRGNkxuSm9tdXZRUTY5Rk5GYjQzajRr?=
 =?utf-8?B?VjhNdTlYRkMwU1JOd1dhaHJ1d3k0K0ZEdlphV0ZZRGpEQWp0Q1JsQ1BoM2N1?=
 =?utf-8?B?SVg4YmlQSXNmMDZwSEhxWW80VGxpL1gvZ0lSQ3BmUUJBeGpYeDFXdXpwWDZO?=
 =?utf-8?B?Nzc5b1dqWGtIdUhKaUZyTmNZeGROdEdjRjNwQVM5ZjZlSU5jRWRUcFdJM0Vj?=
 =?utf-8?B?MzFpMkcwWW9ORWwrdDJuYUtjTGc2RVZmOWkycGtEdC9NdFp6YlFQR29DQ1Jw?=
 =?utf-8?B?TGVFWVNrTUZDdXpUUFZLMHZVcnJIVVlJQ1p6dEYyNDYvVk1HRWxXaGZsMFQz?=
 =?utf-8?B?QXFWNjAxZHphYitndGREaFBoUDJQcTd4czV3TU1mQUVUWnpKUkxhVjdvUmZ0?=
 =?utf-8?B?aGswb1NJcFNlbGt0d0U2NVhLNDM4eDQzaXRSZFRwTEVJVGRwM2NNWGtleWky?=
 =?utf-8?B?N0h1YWVhYytlR1JBQy93Z0Z6RzlKUHVYNjV6NWk4N0FwNDE2ZEpIeGt2ZmZx?=
 =?utf-8?B?YUp1cVEzYjl0T05WOHBnK2JuSDk0NzF0ZXJFcE9lZ3dyemUvd3d1Y3IySkdJ?=
 =?utf-8?B?MkdpdVFuR09xWkoxbWVkNVpoZXE2WEZUTWhPSStKekRRQUlBNDAwQ0NmTHRM?=
 =?utf-8?B?OGVaazRtaUFhbVlvSWRmWTExcGNBMWtDNkxZdUwwWXJUeTU5V3JRMW5OeHl0?=
 =?utf-8?B?Z1kvazhBZWFmTGNiRXhtMTVXa09ObGozTTU2UVJmelcwd1ZXaFVQdEYwamJv?=
 =?utf-8?B?NjRNakwyNjhXSmh4RDY5N0szWjlaaTF2bW1HQ1gxd2lkVTRsamJ4dHo3bzhv?=
 =?utf-8?B?TURNY2FYVk84Z3k2ZXNGUk9mMnB4cmFBTHRZMXkvaGVGL21TSWt5SDlPcjVZ?=
 =?utf-8?B?MHY1bHpKcnBBbG9mQ2JKaVBwa3djUWpQdzAxdVlkZCtwVURmajF0QTIyK21k?=
 =?utf-8?B?T1pCWXZoeFo4MENhcENvT1lNdnRRWEZ2SDV2UjVmN3M4UUtrajY1VlE1Ym1P?=
 =?utf-8?B?dGxWaWZuSll0K3lFN2lPc29MVnlHb082ZU0vNVVtZ1drRHNvRFBkTmFBUS9z?=
 =?utf-8?B?b05OWUVKaFVIWXRjZkJpN2hkdG9TTE15T1BZeGNoV1ltTis5bDlrOFU1dDNi?=
 =?utf-8?B?K1o1MjlCTzI4MzFFb2hPVnNIeXdaVWpuRU93Y21SR3N3Q2l4UVBnRVJyQUR6?=
 =?utf-8?B?SlptOW01Mk40MGVVQVFobHltcEpNaVd4VTVRZm94amxwWlhKWmpFRTM5T3kw?=
 =?utf-8?B?MnI4bG5qWDdrVVU5VitKZXF2VFE2bEM5ZS9jQUpzNFA3VmlXKysrcEJLOXV5?=
 =?utf-8?Q?TzCWh3MmxmBOXCJJ30=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BCAABF922EA12429FE2660E784F5970@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30c20fb-cc9f-496a-a23c-08d91ee970b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 19:23:41.6277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6Ad4ajqKIIHESSMH+LZISsGBuhJuTo68bowTe5lp4VrebdqWospIQ+aTnKYKccIgMM3HdYCEuwhtz4t1wCYXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4711
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWxhbiBTdGVybiB3cm90ZToNCj4gT24gTW9uLCBNYXkgMjQsIDIwMjEgYXQgMDY6MTg6NTlQTSAr
MDMwMCwgTWF0aGlhcyBOeW1hbiB3cm90ZToNCj4+IE9uIDIwLjUuMjAyMSAyMy4zMCwgVGhpbmgg
Tmd1eWVuIHdyb3RlOg0KPj4+IEFzIGZvciB0aGUgeGhjaSBkcml2ZXIsIHRoZXJlIG1heWJlIGEg
Y2FzZSB3aGVyZSB0aGUgc3RyZWFtIFVSQiBuZXZlcg0KPj4+IGdldHMgdG8gY29tcGxldGUgYmVj
YXVzZSB0aGUgdHJhbnNhY3Rpb24gZXJyX2NvdW50IGlzIG5vdCBwcm9wZXJseQ0KPj4+IHVwZGF0
ZWQuIFRoZSBlcnJfY291bnQgZm9yIHRyYW5zYWN0aW9uIGVycm9yIGlzIHN0b3JlZCBpbiBlcF9y
aW5nLCBidXQNCj4+PiB0aGUgeGhjaSBkcml2ZXIgbWF5IG5vdCBiZSBhYmxlIHRvIGxvb2t1cCB0
aGUgY29ycmVjdCBlcF9yaW5nIGJhc2VkIG9uDQo+Pj4gVFJCIGFkZHJlc3MgZm9yIHN0cmVhbXMu
IFRoZXJlIGFyZSBjYXNlcyBmb3Igc3RyZWFtcyB3aGVyZSB0aGUgZXZlbnQNCj4+PiBUUkJzIGhh
dmUgdGhlaXIgVFJCIHBvaW50ZXIgZmllbGQgY2xlYXJlZCB0byAnMCcgKHhoY2kgc3BlYyBzZWN0
aW9uDQo+Pj4gNC4xMi4yKS4gSWYgdGhlIHhoY2kgZHJpdmVyIGRvZXNuJ3Qgc2VlIGVwX3Jpbmcg
Zm9yIHRyYW5zYWN0aW9uIGVycm9yLA0KPj4+IGl0IGF1dG9tYXRpY2FsbHkgZG9lcyBhIHNvZnQt
cmV0cnkuIFRoaXMgaXMgc2VlbiBmcm9tIG9uZSBvZiBvdXINCj4+PiB0ZXN0aW5ncyB0aGF0IHRo
ZSBkcml2ZXIgd2FzIHJlcGVhdGVkbHkgZG9pbmcgc29mdC1yZXRyeSB1bnRpbCB0aGUgY2xhc3MN
Cj4+PiBkcml2ZXIgdGltZWQgb3V0Lg0KPj4+DQo+Pj4gSGkgTWF0aGlhcywgbWF5YmUgeW91IGhh
dmUgc29tZSBjb21tZW50IG9uIHRoaXM/IFRoYW5rcy4NCj4+DQo+PiBUaGlzIGlzIHRydWUsIGlm
IFRSQiBwb2ludGVyIGlzIDAgdGhlbiB0aGVyZSBpcyBubyByZXRyeSBsaW1pdCBmb3Igc29mdCBy
ZXRyeS4NCj4+IFdlIHNob3VsZCBhZGQgb25lIGFuZCBwcmV2ZW50IGEgbG9vcC4gYWZ0ZXIgZSBm
ZXcgc29mdCByZXNldHMgd2UgY2FuIGVuZCB3aXRoIGENCj4+IGhhcmQgcmVzZXQgdG8gY2xlYXIg
dGhlIGhvc3Qgc2lkZSBlbmRwb2ludCBoYWx0Lg0KPj4NCj4+IFdlIGRvbid0IGtub3cgdGhlIFVS
QiB0aGF0IHdhcyBiZWluZyB0YW5zZmVycmVkIGR1cmluZyB0aGUgZXJyb3IsIGFuZCBjYW4ndCAN
Cj4+IGdpdmUgaXQgYmFjayB3aXRoIGEgcHJvcGVyIGVycm9yIGNvZGUuDQo+PiBJbiB0aGF0IHNl
bnNlIHdlIHN0aWxsIGVuZCB1cCB3YWl0aW5nIGZvciBhIHRpbWVvdXQgYW5kIHNvbWVvbmUgdG8g
Y2FuY2VsDQo+PiB0aGUgdXJiLg0KPiANCj4gVGhhdCdzIG5vdCBnb29kLiAgVGhlcmUgbWF5IG5v
dCBiZSBhIHRpbWVvdXQ7IGRyaXZlcnMgZXhwZWN0IHRyYW5zZmVycyANCj4gdG8gY29tcGxldGUg
d2l0aCBhIGZhaWx1cmUsIG5vdCB0byBiZSByZXRyaWVkIGluZGVmaW5pdGVseS4NCj4gDQo+IEhv
d2V2ZXIsIGlmIHlvdSBkbyBrbm93IHdoaWNoIGVuZHBvaW50L3N0cmVhbSB0aGUgZXJyb3IgaXMg
Y29ubmVjdGVkIHRvLCANCj4geW91IHNob3VsZCBiZSBhYmxlIHRvIGdldCB0aGUgVVJCLiAgSXQg
d2lsbCBiZSB0aGUgZmlyc3Qgb25lIHF1ZXVlZCBmb3IgDQo+IHRoYXQgZW5kcG9pbnQvc3RyZWFt
Lg0KPiANCg0KV2hlbiB0aGUgeGhjaSBjYW4ndCByZWNvdmVyIGEgdHJhbnNmZXIgd2l0aCBzb2Z0
LXJldHJ5LCBubyBvdXRzdGFuZGluZw0KdHJhbnNmZXIgY2FuIHByb2NlZWQvY29tcGxldGUgZm9y
IHRoZSBlbmRwb2ludC4gSWYgdGhlIFRSQiBwb2ludGVyIGlzIDAsDQp3ZSBqdXN0IGRvbid0IGtu
b3cgd2hpY2ggc3RyZWFtIG9yIGVuZHBvaW50IHJpbmcgaXQncyBmb3IsIGJ1dCB3ZSBrbm93DQph
bGwgdGhlIG91dHN0YW5kaW5nIFVSQnMgb2YgYW4gZW5kcG9pbnQuIExldCdzIG1heSBhcyB3ZWxs
IHJldHVybiBhbg0KZXJyb3Igc3RhdHVzIGZvciBhbGwgb2YgdGhlbSBhZnRlciBhIGxpbWl0ZWQg
bnVtYmVyIG9mIHNvZnQtcmV0cmllcy4NCg0KQlIsDQpUaGluaA0K
