Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39068398089
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 07:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhFBFER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 01:04:17 -0400
Received: from mail-eopbgr1410081.outbound.protection.outlook.com ([40.107.141.81]:11729
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229571AbhFBFEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 01:04:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DthjvWLLYWMjFCZq0wcSJpoXs/6sRdgYOGpBBwv6lnoV1pgs5Mch7LdRf54AKvjQSxszCmNCigPyo+DZ0lTQqkkQOUksBNBlq+EYF5gunyJtK4qNvfe+xB7ftjsFYfahc9N8H7ABdOzE1TIlkH5lPmx19DQRt/WGpee5lMqtfnGF5UYGjPNEBlkCLLUZLYWEDX3XDwCN2700MYf6WT0nn42L9oi2t03/Qi9XhUWtNWFuoAdvNpfvlSkiYIlrSjqw3sGY4tGsszsJoEFYhjM7JfSWmn3D200Jg1G6CNXEnz7XWP5aRZI/cWdlIfW0B1iFaQ65VkZsiLTg7pZ+38QWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFPBqX4VmKKsQuBynXDccVIOSRbs1pykqGvYeBQMyoY=;
 b=U2ZQ+fgP8PBjB0yrgrVuYbeL66RQSwimFG2XqeSG+9wYCp9bZb1cYDUldD0rOgyRD0vw7zknpGAD8M4SaCdMEFsAS21QmTBdzDchlfJoGQlz6N7Lx3zD7/V3OKNGZciGQp+8hPuQL6dh0adRKGsyLmX0CW5LvNVwoosMZASRxOf8wPcbcfmQV8nFvX+DGTdap1Gt/jdo1ubpP89zGrc9wfvQRJ3AEntGVoJBrwIC6yqMrMu94UMDr5reOfC+KzbBGGG3ZBK/9HEemswbCnUBgPGDmrTALkrZB32PfiZESxurWAT9pvFejQOx4RCM1/y2P0OjLkLPvHAt2k1oxZ+ExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFPBqX4VmKKsQuBynXDccVIOSRbs1pykqGvYeBQMyoY=;
 b=C0g/+a1RpZ82XAc7UdseKLlC9e5H+J8dMRISNiV+cTvLHy2tV9Rpvsiimq7rjthNz+jtmn+ETioowKcYNjCGr1o9dJ2IxeSyKQvcC/t9Y3ZuUmrw79E/4E1aYTYkV/jmQQy+EKF1i6RvZx6DtqiqAWwuUBc291P5EEZvg3TIjnI=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYAPR01MB3742.jpnprd01.prod.outlook.com (2603:1096:404:c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 05:02:31 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::6c0c:4121:b48b:7f91]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::6c0c:4121:b48b:7f91%5]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 05:02:31 +0000
From:   =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= 
        <k-hagio-ab@nec.com>
To:     Baoquan He <bhe@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: RE: [PATCH V2 4/6] mm: rename the global section array to
 mem_sections
Thread-Topic: [PATCH V2 4/6] mm: rename the global section array to
 mem_sections
Thread-Index: AQHXVf5It4/cv5fnAkyoOipmGTT39ar+0qiAgAAD+ACAAADYgIAA/vwAgAAHHqCAAC5HgIAAA2DA
Date:   Wed, 2 Jun 2021 05:02:31 +0000
Message-ID: <TYYPR01MB67770ED42E65667E304F2FF9DD3D9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-5-aisheng.dong@nxp.com>
 <42617372-c846-85fe-4739-abbe55eca8f6@redhat.com>
 <CAA+hA=Ss4j8qeoe7RtDJ14nuqy+TpOk2qi-A9+YN6=2y8c_CGg@mail.gmail.com>
 <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
 <20210601165246.99d7374d07661b7e91e49cb6@linux-foundation.org>
 <TYYPR01MB67775E2EC60DEE1195A49577DD3D9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
 <20210602030353.GA409140@MiWiFi-R3L-srv>
In-Reply-To: <20210602030353.GA409140@MiWiFi-R3L-srv>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bf4bcfe-80d2-44b1-a107-08d92583a0a1
x-ms-traffictypediagnostic: TYAPR01MB3742:
x-microsoft-antispam-prvs: <TYAPR01MB3742C9E9E861A119423DDB1CDD3D9@TYAPR01MB3742.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: raiAcxTfFbT2m1dl0jLlBRabWbO/JgucZD5Iz0Mwdgd2DPiCCN7jk0y5Z7rkKG039UNNWmEFKms9TZ7acpgGTkm9dYVorT7qM1jVoAwsF+wLz5nlnVFIZGnnCA6CmKW4k8Zdxzb2O5B7CYfThCotx/OvyjISyT5B0RBBDcmv/ohTX1GHyOmaDdoeKzqosy/8lfnjZ6p4VlB3RH32VcSZdJ+BldckiDcrp47QAcDffynIh55tYJRnuHeQS3jRR/iNsbyAyTvvieTRpEHI2adEQwiW/O+HEhrhWKkBdTujyNn+aAOYI0IK0UpujdgD+h94K8Qvc1gMy8zCz+wfpy+/zYoTr5OQyxCkYQ8Xy6FXNo1DuPE8KFWdyilwoUdq1uPg0O5mYahnuj+KaGu9AtZtW7VCqkBMAkjFX1Uj7y87HNOgcpbW9XiZF2IJCcseQQOADm02EUlavQ5v4PRUOL6m++1070ZqVdoqPBWaf8VlbbahL7qR6FPVXHwcDMNcGECJtxQgMwzqLA1pF7Mzb3eIfVUGzfUyaR0WAZJp/KIBi7QCkzqq22oB2fM6y37W/pODxdKIpSkJMGEBFGU/E9Atmlo3Dc3IK72Fwl8BPUPLwsg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(38100700002)(6916009)(122000001)(186003)(7416002)(478600001)(66946007)(71200400001)(55016002)(8676002)(33656002)(66446008)(9686003)(66556008)(7696005)(5660300002)(4326008)(26005)(52536014)(85182001)(55236004)(6506007)(8936002)(54906003)(2906002)(83380400001)(86362001)(316002)(76116006)(64756008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aHlGRkVrTnJkUm91M01yQ1IwZm9jbnVuR0lQcTJFWVFoSEliUGhpRG5YUzRX?=
 =?utf-8?B?cDBMdWNLMjF6VDVON3NxQWlHeWZpbEthb0FveTdrbWdhSGVkdjg4ZmRwYm53?=
 =?utf-8?B?QVV3SFRVZWx1eE50ZGxLS3JwaGlaNWdvNVFnc1VJZE5sSHVrek1oTDhON1BK?=
 =?utf-8?B?S1huQm4wV0lPQWZTVDFBdWU2d3ZtRHpOdVlObnRiVm1rZjh4NmlkclcxRnNi?=
 =?utf-8?B?RzQxSG1UY3FyWm16ck9YSUFZTDhsVGU4dUZUUHdZZDlCUFE5bEJmSVJFT0dU?=
 =?utf-8?B?MW9tTFNOeUh5U3Q4N1VyR3NuYjdXUG8xUHdTSUNDejdQS3pWSm04Wll2Y2VP?=
 =?utf-8?B?YjJTK1pFTHpnTC9maEVJOEFmLytXSEZKbGp5cEFYNEovY29ZMWZWTU1GaSt6?=
 =?utf-8?B?RjJLd1BWZjJKbmZkdmFXbHZUUStmdEh2S0NkRDIyaVdlanlHRTZWTFMzY24x?=
 =?utf-8?B?SCs4ZExvSWNoWURTekJUNFp4eW1aUytSQmJXZ0U2V2dmRmtEU3pvVGxkQkth?=
 =?utf-8?B?ZGV5YkE2azBFdHM2TUZNWXhFT2F4azIrYkpHdWg4S29tQmQ3LzB0bVlLWjZj?=
 =?utf-8?B?Ym1MRzhhRWExT2t3OFdSNVNBdjdGZm40UWxhRWVocGE5MmUxaFdkMXQrc1F3?=
 =?utf-8?B?NmdqOWVZNDFCY1FBS2lBOGJKWURqeitqY2p4L1YvbTZ6SzlNZ2pEblJueThJ?=
 =?utf-8?B?UzhYRGc2LzVDOTloSlpINmM5Z0xubGNNWXFmemNTakg5aERJTjVkczBsM0NL?=
 =?utf-8?B?dVU5bzV1eGl6RFVFbjdsWFZLb3hhTXBVZFEvekhPT3A1Zm10VnRDMWVFRHoy?=
 =?utf-8?B?Q0dWKzNVUE5hend1TExMUkZ4YVVSeXFjQjljS1IxLzEzMzRlZ0h6dDhPd0NR?=
 =?utf-8?B?K2dub3JmUElvK1ZSbGtOWXgrOGZDa2tuaUFtdElHRVVDcTF1cG1OeDZRQ21k?=
 =?utf-8?B?R1R4c1JORzZSTUEycWJ4cy9VV21jNHRKbXhSS01KK1E1V1VoNVgxUEhyS3Fm?=
 =?utf-8?B?VEhYL0hYWm91ZnVRc3BYeHJtcmJ0NmthTGMvRG4rcDMzRjJaR25SMmJTaHhF?=
 =?utf-8?B?RFpqenpFZ0VzVkdYR1RlVUR1NE4wUHZxYmxjeTFCU0hWaW1mYzQzMHJHOFpk?=
 =?utf-8?B?RzlZUVVyR1VCNjNCcmJ6cDBjU01zdFJaa0JJaDJHQU9BeHNwWEN5NWdMWmxm?=
 =?utf-8?B?a3llT0M0bWoxbGR3aUNHMko0SFlxc2JOUFBBeGdETzJXb2V6WGlSK09aajVE?=
 =?utf-8?B?QkZlM0RhQm4xeXNmVnkzRm9URk92UTJhOGZJRmRYTDFEdGoyL01UemlHWGo4?=
 =?utf-8?B?U0xVTW8rWU5qL3d3dXlaZ2l5WmxQVklTMVN4VGN0SVNVY2RaLzN5RnJWSXh0?=
 =?utf-8?B?dExzejhDK3BGSVRKNDJCRjBiNWJHeDlOcWRYdWxyMXBiUnZVWTFNSVhHSVBu?=
 =?utf-8?B?ajFpb0pOTTE2U2tvcENxNkVET0RLREVROE1MVDFpbmRoSlMyVXFyODdiZVhi?=
 =?utf-8?B?a3Zaekx0UU9oVUhUZk9aaUl1dkF3emJZVGpxV0dTSStoenhxNTFVZ25SSmFJ?=
 =?utf-8?B?TENCYURFS3JYMThjR2RzK3U1dlNjakptYmM0MWtCRzhkeHk3d2s2OWR3Q2Vp?=
 =?utf-8?B?VFdqLzYrVG1DN3UrU001N0hBa2ptdlRZN0VMSVRabzBkaG04Y1dXS3RkOXZT?=
 =?utf-8?B?MU1ZN28xeGFBbWpzRHpna0phQVlKbjZmRGdxWHdJZEJLQWRCaVJ2eElhRVdh?=
 =?utf-8?Q?iVi8oVlWnjkvrBmB137CjDiACVgSoLCg3AQuDaB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf4bcfe-80d2-44b1-a107-08d92583a0a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 05:02:31.4640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SXB/+xNRoKfLkOylfbAC2jt08Ycb7hderhsso9ncADVyBQUWq0ki8S7h3rxMsh9ZjqKDZ/ZrdoxgbvpVhDD6Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3742
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gT24gMDYvMDIvMjEgYXQgMDE6MTFhbSwgSEFH
SU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSkgd3JvdGU6DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPiA+IE9uIFR1ZSwgMSBKdW4gMjAyMSAxMDo0MDowOSArMDIwMCBEYXZpZCBI
aWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiA+IFRo
YW5rcywgaSBleHBsYWluZWQgdGhlIHJlYXNvbiBkdXJpbmcgbXkgbGFzdCByZXBseS4NCj4gPiA+
ID4gPiBBbmRyZXcgaGFzIGFscmVhZHkgcGlja2VkIHRoaXMgcGF0Y2ggdG8gLW1tIHRyZWUuDQo+
ID4gPiA+DQo+ID4gPiA+IEp1c3QgYmVjYXVzZSBpdCdzIGluIEFuZHJld3MgdHJlZSBkb2Vzbid0
IG1lYW4gaXQgd2lsbCBlbmQgdXAgdXBzdHJlYW0uIDspDQo+ID4gPiA+DQo+ID4gPiA+IEFueWhv
dywgbm8gcmVhbGx5IHN0cm9uZyBvcGluaW9uLCBpdCdzIHNpbXBseSB1bm5lY2Vzc2FyeSBjb2Rl
IGNodXJuDQo+ID4gPiA+IHRoYXQgbWFrZXMgYmlzZWN0aW5nIGhhcmRlciB3aXRob3V0IHJlYWwg
dmFsdWUgSU1ITy4NCj4gPiA+DQo+ID4gPiBJIHRoaW5rIGl0J3MgYSBnb29kIGNoYW5nZSAtIG1l
bV9zZWN0aW9ucyByZWZlcnMgdG8gbXVsdGlwbGUgaW5zdGFuY2VzDQo+ID4gPiBvZiBhIG1lbV9z
ZWN0aW9uLiAgQ2h1cm4gaXMgYSBwYWluLCBidXQgdGhhdCdzIHRoZSBwcmljZSB3ZSBwYXkgZm9y
IG1vcmUNCj4gPiA+IHJlYWRhYmxlIGNvZGUuICBBbmQgZm9yIGhhdmluZyBzY3Jld2VkIGl0IHVw
IG9yaWdpbmFsbHkgOykNCj4gPg0KPiA+IEZyb20gYSBtYWtlZHVtcGZpbGUvY3Jhc2gtdXRpbGl0
eSB2aWV3cG9pbnQsIEkgZG9uJ3QgZGVueSBrZXJuZWwgaW1wcm92ZW1lbnQNCj4gPiBhbmQgcHJv
YmFibHkgdGhlIGNoYW5nZSB3aWxsIG5vdCBiZSBoYXJkIGZvciB0aGVtIHRvIHN1cHBvcnQsIGJ1
dCBJJ2QgbGlrZQ0KPiA+IHlvdSB0byByZW1lbWJlciB0aGF0IHRoZSB0b29sIHVzZXJzIHdpbGwg
bmVlZCB0byB1cGRhdGUgdGhlbSBmb3IgdGhlIGNoYW5nZS4NCj4gDQo+IEFzIFZJTSB1c2VyLCBJ
IGNhbiB1bmRlcnN0YW5kIEFpc2hlbmcncyBmZWVsaW5nIG9uIHRoZSBtZW1fc2VjdGlvbg0KPiB2
YXJpYWJsZSB3aGljaCBoYXMgdGhlIHNhbWUgc3ltYm9sIG5hbWUgYXMgaXRzIHR5cGUuIE1lYW53
aGlsZSBpdCBkb2VzDQo+IGNhdXNlIG1ha2VkdW1wZmlsZS9jcmFzaCBoYXZpbmcgdG8gYmUgY2hh
bmdlZCBhY2NvcmRpbmdseS4NCj4gDQo+IE1heWJlIHdlIGNhbiBjYXJyeSBpdCB3aGVuIGFueSBl
c3NlbnRpYWwgY2hhbmdlIGlzIG5lZWRlZCBpbiBib3RoIGtlcm5lbA0KPiBhbmQgbWFrZWR1bXBm
aWxlL2NyYXNoIGFyb3VuZCBpdC4NCg0KWWVzLCB0aGF0IGlzIGEgcG9zc2libGUgb3B0aW9uLg0K
DQo+IA0KPiA+DQo+ID4gVGhlIHNpdHVhdGlvbiB3aGVyZSB3ZSBuZWVkIHRvIHVwZGF0ZSB0aGUg
dG9vbHMgZm9yIG5ldyBrZXJuZWxzIGlzIHVzdWFsLCBidXQNCj4gPiB0aGVyZSBhcmUgbm90IG1h
bnkgY2FzZXMgdGhhdCB0aGV5IGNhbm5vdCBldmVuIHN0YXJ0IHNlc3Npb24sIGFuZCB0aGlzIGNo
YW5nZQ0KPiANCj4gQnkgdGhlIHdheSwgS2F6dSwgYWJvdXQgYSBjYXNlIHN0YXJ0aW5nIHNlc3Np
b24sIGNvdWxkIHlvdSBiZSBtb3JlIHNwZWNpZmljDQo+IG9yIHJlcGhyYXNlPyBJIG1heSBub3Qg
Z2V0IGl0IGNsZWFybHkuIFRoYW5rcy4NCg0KQXMgZm9yIHRoZSBjdXJyZW50IGNyYXNoLCB0aGUg
Im1lbV9zZWN0aW9uIiBzeW1ib2wgaXMgdXNlZCB0byBkZXRlcm1pbmUNCndoaWNoIG1lbW9yeSBt
b2RlbCBpcyB1c2VkLg0KDQogICAgICAgIGlmIChrZXJuZWxfc3ltYm9sX2V4aXN0cygibWVtX3Nl
Y3Rpb24iKSkNCiAgICAgICAgICAgICAgICB2dC0+ZmxhZ3MgfD0gU1BBUlNFTUVNOw0KICAgICAg
ICBlbHNlIGlmIChrZXJuZWxfc3ltYm9sX2V4aXN0cygibWVtX21hcCIpKSB7DQogICAgICAgICAg
ICAgICAgZ2V0X3N5bWJvbF9kYXRhKCJtZW1fbWFwIiwgc2l6ZW9mKGNoYXIgKiksICZ2dC0+bWVt
X21hcCk7DQogICAgICAgICAgICAgICAgdnQtPmZsYWdzIHw9IEZMQVRNRU07DQogICAgICAgIH0g
ZWxzZQ0KICAgICAgICAgICAgICAgIHZ0LT5mbGFncyB8PSBESVNDT05USUdNRU07DQoNClNvIHdp
dGhvdXQgdXBkYXRpbmcsIGNyYXNoIHdpbGwgYXNzdW1lIHRoYXQgdGhlIG1lbW9yeSBtb2RlbCBp
cyBESVNDT05USUdNRU0sDQpmYWlsIGR1cmluZyB2bV9pbml0KCkgYW5kIGNhbm5vdCBzdGFydCBh
IHNlc3Npb24uICBUaGlzIGlzIGFuIGltaXRhdGlvbiBvZg0KdGhlIHNpdHVhdGlvbiB0aG91Z2g6
DQoNCi0gICAgICAgaWYgKGtlcm5lbF9zeW1ib2xfZXhpc3RzKCJtZW1fc2VjdGlvbiIpKQ0KKyAg
ICAgICBpZiAoa2VybmVsX3N5bWJvbF9leGlzdHMoIm1lbV9zZWN0aW9uWCIpKQ0KDQojIGNyYXNo
DQouLi4NCmNyYXNoOiBpbnZhbGlkIHN0cnVjdHVyZSBtZW1iZXIgb2Zmc2V0OiBwZ2xpc3RfZGF0
YV9ub2RlX21lbV9tYXANCiAgICAgICAgICAgRklMRTogbWVtb3J5LmMgIExJTkU6IDE2NDIwICBG
VU5DVElPTjogZHVtcF9tZW1vcnlfbm9kZXMoKQ0KDQpbL3Jvb3QvYmluL2NyYXNoXSBlcnJvciB0
cmFjZTogNDY1MzA0ID0+IDRhYzJiZiA9PiA0YWFlMTkgPT4gNTdmNGQ3DQoNCiAgNTdmNGQ3OiBP
RkZTRVRfdmVyaWZ5KzE2NA0KICA0YWFlMTk6IGR1bXBfbWVtb3J5X25vZGVzKzUzMjENCiAgNGFj
MmJmOiB2bV9pbml0KzQwMzENCiAgNDY1MzA0OiBtYWluX2xvb3ArMzkyDQoNCiMNCg0KRXZlcnkg
dGltZSBhIGtlcm5lbCBpcyByZWxlYXNlZCwgdGhlcmUgYXJlIHNvbWUgY2hhbmdlcyB0aGF0IGNy
YXNoIGNhbg0Kc3RhcnQgdXAgd2l0aCBidXQgY2Fubm90IHJ1biBhIHNwZWNpZmljIGNyYXNoJ3Mg
Y29tbWFuZCwgYnV0IGEgY2hhbmdlDQp0aGF0IGNyYXNoIGNhbm5vdCBzdGFydCB1cCBsaWtlIHRo
aXMgY2FzZSBkb2VzIG5vdCBvY2N1ciBvZnRlbi4NCg0KQWxzbyBhcyBmb3IgbWFrZWR1bXBmaWxl
LCB0aGUgIlNZTUJPTChtZW1fc2VjdGlvbikiIHZtY29yZSBlbnRyeSBpcyB1c2VkDQp0byBkZXRl
cm1pbmUgdGhlIG1lbW9yeSBtb2RlbCwgc28gaXQgd2lsbCBmYWlsIHdpdGggdGhlIGZvbGxvd2lu
ZyBlcnJvcg0Kd2l0aG91dCBhbiB1cGRhdGUuDQoNCiMgLi9tYWtlZHVtcGZpbGUgLS1tZW0tdXNh
Z2UgL3Byb2Mva2NvcmUgDQpnZXRfbWVtX21hcDogQ2FuJ3QgZGlzdGluZ3Vpc2ggdGhlIG1lbW9y
eSB0eXBlLg0KDQptYWtlZHVtcGZpbGUgRmFpbGVkLg0KDQpUaGFua3MsDQpLYXp1DQo=
