Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206DB371F27
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhECSGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:06:18 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:51260 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231406AbhECSGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:06:17 -0400
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143I4Hhx026066;
        Mon, 3 May 2021 18:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=agcShTBuU4duvseCWIvE6ONhcj0G9zO8EW/4GPhnbQw=;
 b=nk16IfDbR5gvmZl/Ycq6JJNss0W02KdkrOkvaH87RqGoDF8k/lTxSnbaNAN3sEDIBwTs
 Et8f4VqCNwbjQr9eUIcRD56dpk50OqmVvMdYd5V0yjfZG2efGB8MTAuGOZtyLGnIZXEK
 zrpUz2R8bE4/8JlPAD41ga2WH7tbLzjO5kcG2oW7CpbHJbvBw8bJPgkSyGtCNEIycICu
 4ud+F+Cw6BwsO+4WOtP3n2O6G6zBDnRrwVKPrRME1HpfDW8gLXmweaQOXkhVclbJL4Mu
 JHqEKppfI87JzScGsqItAiSnegvdOgrm+oS88odgEmquieQCH9CNsz3IcHY2jMP3Mlyv Wg== 
Received: from eur02-am5-obe.outbound.protection.outlook.com (mail-am5eur02lp2054.outbound.protection.outlook.com [104.47.4.54])
        by mx08-001d1705.pphosted.com with ESMTP id 388w6mh52n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 18:04:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD8EUbjkofXxd3vsqBjf7ZRcoDgnqj/UPQXXdt//JnfLo3qIwXvUnvrLTHePZDVrOLdeCQ5qfiGPzrDeBk3cWay4mJIIUFBFALIZseyA1dCO1qAPwEUNQ170+gX43p+sfdaN+iXmZrYoIz8LA1Rpca0gwWIEFGi6AWeMp0CB2uy7dbeDgg1xlakP2tAF31ZL1oJDW0iTcaynGvE6c/rAmKHVGwfVzJf3OQt1F2HQmuWTtkVW6OobJKP8Og2CQq2RVnPLRnchukirujxhHmmWBPvePdu0q9uPrUfpbjckqPL0R6t4cdnwn1fu7oG0nx9rwE1zUt/VXeXhhK28y9je8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agcShTBuU4duvseCWIvE6ONhcj0G9zO8EW/4GPhnbQw=;
 b=SwkB4IckwIWL3AbKZGm0DkAC3Cx3rVbRec4Tszcue49URbpnhQOIRRdqDZISldODJ1XouXNBb6I01TlSal4BVYiUndf2IKGeT8Jrrw44UhBOhBmtCl9OOHgNlkr0QleiLcT+z2dzu4cZ3imVc1WLDfgFlnAUfUFEHntwSrKLCeMfxKzCStQYEjTOfHiiPJTS9BnOqjo0nbQVe9/cBkLfuB2onOHkajUGYzbROngDTU047oDgTrJdO9lecwyNYgiWny8tLdYah7fw1LfiBDtAtVuEvDKo9kgUEVDNGWj6GMLburYoKlUxM7Lh2VDP25f36PXohZjePYK8soMnyaQUBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM0P193MB0740.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:14a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Mon, 3 May
 2021 18:04:34 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::311d:abde:1437:dde1]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::311d:abde:1437:dde1%7]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 18:04:34 +0000
From:   <Peter.Enderborg@sony.com>
To:     <ebiederm@xmission.com>
CC:     <mathieu.desnoyers@efficios.com>, <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <akpm@linux-foundation.org>, <peterz@infradead.org>,
        <ast@kernel.org>, <christian.brauner@ubuntu.com>,
        <dave@stgolabs.net>, <walken@google.com>, <jannh@google.com>,
        <christophe.leroy@c-s.fr>, <minchan@kernel.org>
Subject: Re: [PATCH 1/2] tracing: Add a trace for task_exit
Thread-Topic: [PATCH 1/2] tracing: Add a trace for task_exit
Thread-Index: wQHXPcxKtEu4vBDankanfcyX4+Z7rarR2y0AgAAcuruAABoKgA==
Date:   Mon, 3 May 2021 18:04:34 +0000
Message-ID: <663fc7fa-e7fc-7d63-9de8-91b5f6fe4f06@sony.com>
References: <20210430142223.25500-1-peter.enderborg@sony.com>
 <20210430142223.25500-2-peter.enderborg@sony.com>
 <m14kfnzmsp.fsf@fess.ebiederm.org>
 <4bb24db4-f720-f5e7-9054-36bdeaee1d79@sony.com>
 <20210501091104.418765bd@oasis.local.home>
 <1214833117.22933.1620049830326.JavaMail.zimbra@efficios.com>
 <769a00d2-a76d-62d2-aa56-5a107dfdc53d@sony.com>
 <m1sg33lqyo.fsf@fess.ebiederm.org>
In-Reply-To: <m1sg33lqyo.fsf@fess.ebiederm.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: xmission.com; dkim=none (message not signed)
 header.d=none;xmission.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ceb0bbc3-5e11-4592-d75c-08d90e5de895
x-ms-traffictypediagnostic: AM0P193MB0740:
x-microsoft-antispam-prvs: <AM0P193MB0740CA787F677E928AE12E04865B9@AM0P193MB0740.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VB5Tapw9Me8qzZgF0ZBRCvcZ18n6U67ZOwKwjHFd4TnaTSplqDHX67YQsDnaojkFMWRYToLRvMpf75sV33C8Iq0wIUYckS5+KO5XI8UIU6G/pilffr7yizIv17l9ZSr/2bGS6N4WFWkHXcYfwxlGScFscTHaH2ZHKEcRzTJOZA06/uNbDdoXhxUqOd0ex4ZA6ffnhxmD14/rG/FxH9G8jGzO1GLURSGvscl5rXBQ/un2Q1vZeM6a5zJpbjv+ByyFyjGyy4+cdG2THu0B4zTT/RYZoecRM5kbb9miiyHQEan2M2/QYxlj2zhK4tADJCFsItuHaMIxpJkJCAvWcbFvcUHYu+F7CJyauOZsvA01dIP223eXizCqDMVHJ2YUu91q95WaK376AlE7jjw2QkyQKN36LBseFXWxaUB9VlqkiP5haNyPv6Ym8Z4CtslIerVFvPYM5lidbcU6GPeTC9umflQ+GTuNaMvRZap+u8IoGWrfzW0YDUL+vgU2RqvmRBQ4HwdgcTPCntFMT7+zErDajxWiAhoSnGZXn7afa2P65RKdbUTsFmWNbootzW1UE4pRCpLZHUzdokNdjH4degzG1CgW5DY69Na75Dr1IJGMkqN4ZSPHI/YNot75WlQfKGNvshRGAWdia1LciXocysxfXrdNS79dDgKe374X8GXZkKfpwuzWfEb5HZPuZ0sxpIsQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39850400004)(346002)(376002)(26005)(5660300002)(66556008)(53546011)(6512007)(86362001)(6506007)(83380400001)(122000001)(66476007)(66446008)(31696002)(186003)(38100700002)(54906003)(64756008)(6486002)(8676002)(91956017)(76116006)(316002)(478600001)(66946007)(6916009)(71200400001)(7416002)(31686004)(2616005)(2906002)(4326008)(36756003)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NDd0eEVuR1BCc3RYMFZ0cWcxWW5NaXk3Y2xSQVVJdlZDRDk1YW5VaFVLbUdh?=
 =?utf-8?B?VWF5ckZzRHFzN3dma1RIVHRrczRvc2xacGNsOGpKQ1RQMVNkWk53R2JmQ2lH?=
 =?utf-8?B?eW94NmtvOUkxajl5WmloZXJLYVNYampzdmhNcW1yZlhhNU95cXkraFlJd29M?=
 =?utf-8?B?SmJpMVJMZUVGWGxZUm9hYTlUYk9SZE1qQStqYUVzWW5qenJyb1htNVJZNVcr?=
 =?utf-8?B?cTc3bW9XS2oxcUhEU1VBb0NOYTNyZDM4bGtkUWk2SXYyUEF1SjhYVk5XVFZy?=
 =?utf-8?B?cGh5dnppeGl3R2htQWd4TUFMZGlGd0JSOFlJNkczaFgvQ25DQ0o3WVdvSFUr?=
 =?utf-8?B?RlpFcy9Ucm0vSnBuUzY2Zm85TjJMZDhKY3lRTmZXL0tqa2J6N1FVbXpMeUk2?=
 =?utf-8?B?aGJpYkJNLzZMdVMzVTAxcy96UDd6NnNtdkd6MlVROXJLM0VqUHl2Q3hERXJr?=
 =?utf-8?B?S1JjRTZvVW1XQlFXMlRwYlBWZldhTmt2Q2hmTjN1K0R0ZmExSWdKSjluak5T?=
 =?utf-8?B?QU1lUHZIQWR4UUxmVnVJY2pvSHFnSlV1a1lTRjI1TkVWTDJrL00yZ1VyOFNm?=
 =?utf-8?B?UnQxZ1EwUjVIcGhLY0FWWGtXWGEvRm9OMmV0WDhWczRUZXdpcDBCMEdNTVU0?=
 =?utf-8?B?NGxMMFF3anpWOXJLWUFrK253b1cya2FhOVBpREhLdCs5QTI0RXlRakw0MTI0?=
 =?utf-8?B?MHJIME5WWWF3a1MzUTVqTXZRU3AxMTlFU2tYZWpTSlFhOHp0aWl0V241MTFF?=
 =?utf-8?B?QUU2U1hWRGxlbncxR0hrYWxOQWtWQis2d2hQSFVNaWlXSEhHLzBUNXFQRzN3?=
 =?utf-8?B?c29ON3JTcnZXTlpaZW9lbncvcUp6QzVIaUFvc05wQU9tWTBOUEZtT3JLaUJ1?=
 =?utf-8?B?VVc2RE9qK2FYaEI3Rkc1L3JRTGhSaFpOK3puUWVqaUtWaTR0dTNDdzBpbEln?=
 =?utf-8?B?YjZ6ZnBaZ0NrU1paOXFxOWNMTFpBRXZNVFArelBPekh0WUJOSHBPME5RWGZj?=
 =?utf-8?B?TjByUTA2a01GVXQzVXBabnh5OHMxeDZ2SzFBRXJIQnJFT1Vnd1ZPdkY3MEEr?=
 =?utf-8?B?QUs5NTByOVI1OHM4SVl6WnVhK21QeXlBRUo2WkhkZ3RRQ2F4Q1lWdkZEcjNx?=
 =?utf-8?B?SW0wRUhqR1R3Sm1DWm1CaEExUG04SHhQRGQyNHIzMDdxcUljd2FLRC9OZ2Jy?=
 =?utf-8?B?RGkzbDNLejc1RmFFYUNFdGNwczNvWFcyeE8zSHVzcncvWjZzcWJycTUzT295?=
 =?utf-8?B?a0NIMWZLWWs3NFJ4ZjlrV09ydm1rcDRkT2hmT2M0Mm1SSU9uM21RZUhqek9B?=
 =?utf-8?B?WDNNNGN5S0RzTkovQTBoK1Z5eG55aTNLS1lUM2llMW45bDErWU5pUVZKQ0JU?=
 =?utf-8?B?TjBrZlNTbFhvY0trRGJtQmlsRFZFUjFTRjdhTUt4aFI5dTBCQjFSd3I5bHBu?=
 =?utf-8?B?ME9tN3VoVmlleFFueFhSc3FERkg1TjVoTjdZVWN1bzlYSks4cEsySDFmMXpP?=
 =?utf-8?B?MlRHTTZUVW5sOHI3OVVWVm5ZWEZ2ZC9PM0EveVRsMW9hY25iWHZCcTJDa3pN?=
 =?utf-8?B?NU5kdWdpbCtQZDd1K2IxKzk2ZDJwR1lhWEhhYlRDTzAza1BESmJEaFMveEsx?=
 =?utf-8?B?enNtN29ucVRZeHZ3SFY3WEFKN1R1cDBnVzdBZ3JZNXdiYWtVSUdqNFJjREgv?=
 =?utf-8?B?cGgrclI4NTdpcGJQVDFZTU9iR2JackRWcHNoS0U2ZURQWUVJY1krR296bXlr?=
 =?utf-8?B?QjAvVGFaL1drTk9hQVBvQnpPcUV0ZUZ4RjZpV2pMbzB6SFEvRElRZUhTWVp5?=
 =?utf-8?B?VkNkUE5xR0VnN1UwRGN2Zz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4A051FC20782C46BE6E3AF24C37F515@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb0bbc3-5e11-4592-d75c-08d90e5de895
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 18:04:34.5621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 852R1nTIHcN8da9xNpxiCKYP97RNVppwUDGDUhh3TaEHubA15/Wm4Wxgbwvl0MC7L1OhTKPMbpACdcu0vj22Z6lBQa88qOWiA3xIG+X4vaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0740
X-Proofpoint-GUID: vcucJAAldzsG4_jk8Hg1TzZV527me53T
X-Proofpoint-ORIG-GUID: vcucJAAldzsG4_jk8Hg1TzZV527me53T
X-Sony-Outbound-GUID: vcucJAAldzsG4_jk8Hg1TzZV527me53T
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_13:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105030119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zLzIxIDY6MzAgUE0sIEVyaWMgVy4gQmllZGVybWFuIHdyb3RlOg0KPiA8UGV0ZXIuRW5k
ZXJib3JnQHNvbnkuY29tPiB3cml0ZXM6DQo+DQo+PiBPbiA1LzMvMjEgMzo1MCBQTSwgTWF0aGll
dSBEZXNub3llcnMgd3JvdGU6DQo+Pj4gLS0tLS0gT24gTWF5IDEsIDIwMjEsIGF0IDk6MTEgQU0s
IHJvc3RlZHQgcm9zdGVkdEBnb29kbWlzLm9yZyB3cm90ZToNCj4+Pg0KPj4+PiBPbiBTYXQsIDEg
TWF5IDIwMjEgMDk6Mjk6NDEgKzAwMDANCj4+Pj4gPFBldGVyLkVuZGVyYm9yZ0Bzb255LmNvbT4g
d3JvdGU6DQo+Pj4+DQo+Pj4+PiBPbiA0LzMwLzIxIDc6NDggUE0sIEVyaWMgVy4gQmllZGVybWFu
IHdyb3RlOg0KPj4+Pj4+IFBldGVyIEVuZGVyYm9yZyA8cGV0ZXIuZW5kZXJib3JnQHNvbnkuY29t
PiB3cml0ZXM6DQo+Pj4+Pj4gIA0KPj4+Pj4+PiBUaGlzIGlzIHRoZSBwZWVyIGZ1bmN0aW9ucyB0
byB0YXNrX3JlbmFtZSBhbmQgdGFza19uZXd0YXNrLg0KPj4+Pj4+PiBXaXRoIHRoaXMgd2UgZ2V0
IGhvbGUgImxpZmUtY3ljbGUiIG9mIHRhc2sgYW5kIGNhbiBlYXNpbHkNCj4+Pj4+Pj4gc2VlIHNo
b3J0IGxpdmllZCB0YXNrIGFuZCB0aGVpciBleGl0IHN0YXR1cy4NCj4+Pj4+PiBUaGlzIHBhdGNo
IGlzIGluY29ycmVjdC4gIFRoZSBsb2NhdGlvbiB5b3UgYXJlIGRlYWxpbmcgd2l0aCBpcyBub3Qg
cGFydA0KPj4+Pj4+IG9mIHRhc2sgZXhpdC4gIFRoZSBsb2NhdGlvbiB5b3UgaGF2ZSBpbnN0cnVt
ZW50ZWQgaXMgcGFydCBvZiByZWFwaW5nIGENCj4+Pj4+PiB0YXNrIHdoaWNoIGNhbiBjb21lIGFy
Yml0cmFyaWx5IGxvbmcgYWZ0ZXIgdGhlIHRhc2sgZXhpdHMuDQo+Pj4+PiBUaGF0IGlzIHdoYXQg
aXQgYWltaW5nLiBXaGVuIHVzaW5nIHRoaXMgYXMgdG9vbCBmb3IgdXNlcnNwYWNlIHlvdQ0KPj4+
Pj4gd291bGQgbGlrZSB0byBrbm93IHdoZW4gdGhlIHRhc2sgaXMgZG9uZS4gV2hlbiBpdCBubyBs
b25nZXINCj4+Pj4+IGhvbGRzIGFueSB0aGluZyB0aGF0IG1pZ2h0IGhhdmUgYW55IGltcGFjdC4g
SWYgeW91IHRoaW5rIHRoZQ0KPj4+Pj4gZXhpdCBpbXBseSBzb21ldGhpbmcgbW9yZSBzcGVjaWZp
YyBJIGNhbiBjaGFuZ2UgdGhlIG5hbWUuDQo+Pj4+Pg0KPj4+Pj4gSSB0aG91Z2h0IGV4aXQgd2Fz
IGEgZ29vZCBuYW1lLCBpdCBpcyBpbiBpbiBleGl0LmMuDQo+Pj4+Pg0KPj4+Pj4gV2lsbCB0aGUg
bmFtZSB0YXNrX2RvbmUsIHRhc2tfZmluaXNoZWQgb3IgdGFza19yZWFwZWQgd29yayBmb3IgeW91
Pw0KPj4+PiBJIHRoaW5rICJ0YXNrX3JlYXBlZCIgaXMgcHJvYmFibHkgdGhlIGJlc3QgbmFtZSwg
YW5kIHRoZSBtb3N0DQo+Pj4+IGRlc2NyaXB0aXZlIG9mIHdoYXQgaGFwcGVuZWQuDQo+Pj4gV2hh
dCB3b3VsZCBpdCBwcm92aWRlIHRoYXQgaXMgbm90IGFscmVhZHkgYXZhaWxhYmxlIHRocm91Z2gg
dGhlICJzY2hlZF9wcm9jZXNzX2ZyZWUiDQo+Pj4gdHJhY2Vwb2ludCBpbiBkZWxheWVkX3B1dF90
YXNrX3N0cnVjdCA/DQo+PiBGb3IgdGFza19leGl0IChvciB0YXNrX3JlYXBlZCkNCj4+DQo+PiDC
oMKgwqDCoMKgwqDCoCBmaWVsZDpwaWRfdCBwaWQ7wqDCoMKgwqDCoMKgwqAgb2Zmc2V0Ojg7wqDC
oMKgwqDCoMKgIHNpemU6NDsgc2lnbmVkOjE7DQo+PiDCoMKgwqDCoMKgwqDCoCBmaWVsZDpzaG9y
dCBvb21fc2NvcmVfYWRqO8KgwqDCoMKgwqAgb2Zmc2V0OjEyO8KgwqDCoMKgwqAgc2l6ZToyOyBz
aWduZWQ6MTsNCj4+IMKgwqDCoMKgwqDCoMKgIGZpZWxkOmludCBleGl0X3NpZ25hbDvCoCBvZmZz
ZXQ6MTY7wqDCoMKgwqDCoCBzaXplOjQ7IHNpZ25lZDoxOw0KPj4gwqDCoMKgwqDCoMKgwqAgZmll
bGQ6aW50IGV4aXRfY29kZTvCoMKgwqAgb2Zmc2V0OjIwO8KgwqDCoMKgwqAgc2l6ZTo0OyBzaWdu
ZWQ6MTsNCj4+IMKgwqDCoMKgwqDCoMKgIGZpZWxkOmludCBleGl0X3N0YXRlO8KgwqAgb2Zmc2V0
OjI0O8KgwqDCoMKgwqAgc2l6ZTo0OyBzaWduZWQ6MTsNCj4+IMKgwqDCoMKgwqDCoMKgIGZpZWxk
Ol9fZGF0YV9sb2MgY2hhcltdIGNvbW07wqDCoCBvZmZzZXQ6Mjg7wqDCoMKgwqDCoCBzaXplOjQ7
IHNpZ25lZDoxOw0KPj4NCj4+IHNjaGVkX3Byb2Nlc3NfZnJlZQ0KPj4gwqDCoMKgwqDCoMKgwqAg
ZmllbGQ6Y2hhciBjb21tWzE2XTvCoMKgwqAgb2Zmc2V0Ojg7wqDCoMKgwqDCoMKgIHNpemU6MTY7
wqDCoMKgwqDCoMKgwqAgc2lnbmVkOjE7DQo+PiDCoMKgwqDCoMKgwqDCoCBmaWVsZDpwaWRfdCBw
aWQ7wqDCoMKgwqDCoMKgwqAgb2Zmc2V0OjI0O8KgwqDCoMKgwqAgc2l6ZTo0OyBzaWduZWQ6MTsN
Cj4+IMKgwqDCoMKgwqDCoMKgIGZpZWxkOmludCBwcmlvOyBvZmZzZXQ6Mjg7wqDCoMKgwqDCoCBz
aXplOjQ7IHNpZ25lZDoxOw0KPj4NCj4+IFNvIGluZm9ybWF0aW9uIGFib3V0IG9vbV9zY29yZV9h
ZGosIGFuZCBpdCdzIGV4aXQgcGFyYW1ldGVycy4NCj4NCj4gRm9yIHRoZSByZWNvcmQgcmV0dXJu
aW5nIG9vbV9zY29yZV9hZGogdGhhdCBsYXRlIGlzIG5vdCBhcHByb3ByaWF0ZSBmb3INCj4gYW55
IGtlcm5lbC91c2VyIEFQSS4gIEl0IGlzIHBlcmZlY3RseSB2YWxpZCBmb3IgdGhlIGtlcm5lbCB0
byBvcHRpbWl6ZQ0KPiBvdXQgYW55dGhpbmcgdGhhdCB3YWl0KDIpIGRvZXMgbm90IHJldHVybi4N
Cj4NCj4gSWYgeW91IHdhbnQgb29tX3Njb3JlX2FkaiB5b3UgcHJvYmFibHkgbmVlZCB0byBzYW1w
bGUgaXQgaW4NCj4gc2NoZWRfcHJvY2Vzc19leGl0Lg0KVGhhdCBJIGRvbid0IHVuZGVyc3RhbmQg
d2h5P8KgIG9vbV9zY29yZV9hZGogaXMgcGFydCBvZiB0aGUgc2lnbmFsLA0Kd2h5IGlzIHRoYXQg
bm90IGludGFjdCB3aGVuIHdlIHJ1biBfX2V4aXRfc2lnbmFsID8NCg0KDQo+IEkgcGVyaW9kaWNh
bGx5IG1vdmUgdGhpbmdzIGZyb20gdGhlIHBvaW50IGEgcHJvY2VzcyBpcyByZWFwZWQgdG8gdGhl
DQo+IHBvaW50IHdoZXJlIGEgdGFzayBzdG9wcyBydW5uaW5nLCBmb3IgYm90aCBjb3JyZWN0bmVz
cyBhbmQgZm9yIHNpbXBsZXINCj4gbWFpbnRlbmFuY2UuICBXaGVuIHRocmVhZHMgd2VyZSBhZGRl
ZCBhIGJ1bmNoIG9mIGNsZWFudXAgd2FzIGFkZGVkDQo+IHRvIHRoZSB3cm9uZyBwbGFjZS4gIEkg
Y2VydGFpbmx5IHdvdWxkIG5vdCBoZXNpdGF0ZSB0byBtZXNzIHdpdGgNCj4gb29tX3Njb3JlX2Fk
aiBpZiBjaGFuZ2luZyBzb21ldGhpbmcgd291bGQgbWFrZSB0aGUgY29kZSBzaW1wbGVyLg0KPg0K
PiBXaXRoIGJvdGggc2NoZWRfcHJvY2Vzc19mcmVlIGFuZCBzY2hlZF9wcm9jZXNzX2V4aXQgaXQg
bG9va3MgbGlrZSB3ZQ0KPiBhbHJlYWR5IGhhdmUgdHJhY2Vwb2ludHMgZXZlcnl3aGVyZSB0aGV5
IGNvdWxkIGJlIG5lZWRlZC4NCj4gdGFzayBleGl0Lg0KPg0KPiBFcmljDQoNCkl0IG1pZ2h0IGJl
IHdoZXJlIHdlIGl0IGlzIG5lZWRlZCwgYnV0IGl0IGRvZXMgbm90IGNvbnRhaW4gaW5mb3JtYXRp
b24gdGhhdA0KYXJlIG5lZWRlZCBmb3IgdXNlcnNwYWNlLiBJIGRvbid0IHNlZSB0aGlzIGFzIHRv
b2wgZm9yIHNjaGVkIGlzc3VlcywNCmJ1dCBhZGluZyBpbmZvcm1hdGlvbiB0byBleGlzdGluZyBv
bmVzIGlzIG9mIGNvdXJzZSBhIG9wdGlvbi4NCg0KSG93ZXZlciBjdXJyZW50IHRyYWNlcyBpcyB0
ZW1wbGF0ZSBiYXNlZCwgYW5kIEkgYXNzdW1lIGl0IHdvbnQgYmUgcG9wdWxhciB0byBhZGQgbmV3
IGZpZWxkcyB0byB0aGUgdGVtcGxhdGUsDQphbmQgZXhpdCByZWFzb25zIGlzIG5vdCByaWdodCBm
b3IgdGhlIG90aGVyIHRlbXBsYXRlIHVzZSBjYXNlcy4NCg0KSSBzdGlsbCBzZWUgYSAibmV3IiB0
YXNrIG1vdmluZyBpdCB0byBkb19leGl0IG1ha2UgdHJhY2UgbmFtZSBtb3JlIGNvcnJlY3Q/wqAg
T3IgaXMgdHJhY2VfdGFza19kb19leGl0IGJldHRlcj8NCg0KDQpUaGFua3MNCg0KUGV0ZXINCg==
