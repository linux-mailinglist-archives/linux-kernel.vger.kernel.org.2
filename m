Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21342368AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 04:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhDWCST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 22:18:19 -0400
Received: from mail-eopbgr1410075.outbound.protection.outlook.com ([40.107.141.75]:26720
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236498AbhDWCSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 22:18:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnZnnNVdBBkCMSkS2B6qyuX4ENuyWJbh4+LpUDP3lOnEptmhKGVGIcwZvPl70F3wsTQXH98WouSlOeV7gVJXd9xX5YpyXVHGaMg/Fdux3w8TPpnw4/uzakj37k5s6Ylb+FxX/CRyfZbRffpxgCLMt8oMSNMv/VVJ3NeqFcmh7F58g/b834TxvubUSzO+6iueN3FNi1YFJYLDfUYK1vitD4WUVEbFOlOkgpCY65TYU0sS7+3cR+oYV+Wg+8fuc6UN28KwCb9pevoQPCKZV8poYMt6ZeOfUvj5P2OH+5lh4umrlwM5hRmaVn4sOnYZzV3o+WRRGktUgDMUg58MN2bJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCJ2wfQyDFXba+qUhT17CoyyZ2qlttL/3KGv77bubN0=;
 b=U5eR61dpklBtJbXkocLpzr1mn+FJrZbwomAECoTVgeA1wwmYdr2PbxS1hXSSmW3EOrXzKv3Tv88zPT2cDCNMh8QwnzoAfpZyx+NeXMXkZkd8Qz3hxwfkpKqeykAPOWQVQCWEVZ0JCXdFBVkqb9G7E559IlmQ3jU9RmRk4MpNxk9/29RJw0ACZv9RwDVwRZfE9Z6XEiN2e3pySMmErTdOeo+eHhxFb2X+7mp9yUMDuFpLJKuku1qdShwqG6OcX0OuyCgVcY6WXBXHyBW/90jMg8TywrbiCQjasFCSGnaXqGKyI8vJD3H3GDT2rGHqKfk7PwdFgQ5WEd4JAubwo2T+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCJ2wfQyDFXba+qUhT17CoyyZ2qlttL/3KGv77bubN0=;
 b=MM5LJIXUVJGoU/+KvllnWsU1Wz5GzwmUM9/n4rTrneaXy7gvvQWuk8L15WSHtaz065ulw3R1JmJI4KN5pAnL+XpUpcWVSDyGTWxtQVigHLoQfV+SIYt+Dm6LwRM0Ia9xqfgwv9hwqNbgIiebPzEdCmFQcOJ8dEjcEn4C3rJ7nHU=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB3501.jpnprd01.prod.outlook.com (2603:1096:404:be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 02:17:40 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.4042.024; Fri, 23 Apr 2021
 02:17:40 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, Jue Wang <juew@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] mm,hwpoison: return -EHWPOISON when page already
Thread-Topic: [PATCH v3 2/3] mm,hwpoison: return -EHWPOISON when page already
Thread-Index: AQHXNkllEN6LAIGMUEi3fVQNTtIJxqrAxd0AgACbOoA=
Date:   Fri, 23 Apr 2021 02:17:40 +0000
Message-ID: <20210423021739.GA68967@hori.linux.bs1.fc.nec.co.jp>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
 <20210421005728.1994268-3-nao.horiguchi@gmail.com>
 <20210422170204.GD7021@zn.tnic>
In-Reply-To: <20210422170204.GD7021@zn.tnic>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee4dac63-94d8-4591-efa4-08d905fdf867
x-ms-traffictypediagnostic: TYAPR01MB3501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB350139F6FE94EACF841CEFEFE7459@TYAPR01MB3501.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:328;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aFG2wbMwEe9cdM826DHgMxbdoUcqHo+uL0pSNTP5Uv1wzDDh6vfmp1SctFRC9aYE4kG3x0OmHKW3A74PY/bKkYWlDrROuJC0IkMD/NxbSemblWNuPCk7tCEiQ1coetV+VaZ1KqEaA+gbRN39CqJ7a+dTyzG9Okr4VEfQgqb6lKWA6NVMDq58pTTMbs700dtdq9mtJyc4c0vjvp0g9VDAjrYVIGEpaTyJtu8lb/6h37tLrSSEUI+wVPvmg/k8XNuexLl80enI++M4ucAM6FjlVor3ESgA12oXbAirPkgFDXPX1E87Cjy6jRtdteGVPmhXndVN+rRRZ2FBglW1LDRqCtm5FmN+L3pcZV+kKBNBE4RBmt5eB+/lp7GevHwwDWxaUQ19HTamyqd685HIIEP1qFziFqiob85MgpG+ChmKNB1LDqI5cI8+U7sttVSRmBln4lOvo89379xtRp0aO8E+ZOvCdZJHy+jvRqTK26akVwMxzoGI7GdYgKtdrxP8kqT6ijnd9uh8vXHX6z+qyyMTLoTwZQeQlcVMgDVdNi3Se69TGIiZc2GlavnauBqUOZf4pJkyv0qVrlQt+xHH7zc6sXnzL3sTlo2gldEB0jVObT0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(55236004)(8936002)(8676002)(478600001)(71200400001)(54906003)(6486002)(316002)(86362001)(6506007)(122000001)(7416002)(186003)(38100700002)(6916009)(2906002)(66946007)(76116006)(66446008)(26005)(4326008)(83380400001)(6512007)(4744005)(33656002)(66556008)(9686003)(64756008)(66476007)(85182001)(1076003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cEJqS2lnZzdnMmUrQ3E5dkxDZHIvOEsrQU1HY1ZIaW0xYXRYZElYT2U0ZE0r?=
 =?utf-8?B?OFgvTjkrdjEweTR2SVlrMWlpZVQ1Y0JmVXpDTzRZYVpBSUdJSzh0TDRDWjll?=
 =?utf-8?B?alIxbDlkRWpTZm5vT1JqcWUyN29NSmVxZVRsQzBWSmYrVDIwbzRJd0hkb29G?=
 =?utf-8?B?dUg0NlIzaS84bW12SlEwM2JHcEcyUjRCNW1Nenp5NGs4Qkd5MXFjb0EvcE1L?=
 =?utf-8?B?WXVHYllVSFdBVlZuZWs1MFJEMEVHZXN3UEUrOTZROVpjSlFBSHdyS2szeWtF?=
 =?utf-8?B?bXZLVlNtSEdReHp0akFTazh1aHptYU9nYU5ReGFMZ2x2WnFNRmc0Rm5wTUdk?=
 =?utf-8?B?T1NRNlBIM2NMeVdtK3dlYWt5NWRYSTZjeU9vaHRtejBDVk9Xekg3Vis0WjR5?=
 =?utf-8?B?b0V0RHhacHpHaWlJWkFOVEZieVZRSDQxV0ZIU1o1YTZLaks3Y3ZXdGl2eXhm?=
 =?utf-8?B?NFRWYnErN0pTZWNsU3BNYWE2aHZETmc3Y0s2VHZpWmxYRWlpdFRqSUJCMFNo?=
 =?utf-8?B?R2Y5U0VRYWVJRktjZi9KcE90cEhCS0cyYUdlRXlXTkpqUUdXT0RCNFRESEI5?=
 =?utf-8?B?eEp6MC8wd2EzRVV3b29XUkc2MVJVbjJWc0E3ZGYyeUtoRkhwMno0VkU5NHN5?=
 =?utf-8?B?MzJodzVEK0lCNzdRUkdqZWhGclR6QzVRUUxwaUpoZmxWRHBlZHZySkRRQ0xQ?=
 =?utf-8?B?N2kvUVh5cVpXeXNlR0JzNGhaOEt5SnRwTmxQVytGZnBRaW92MnNTUHhXL21h?=
 =?utf-8?B?anlSVkJLNysxN2szRlRpMWxDTzd5RGdIa3BTczFqaFR6azBVd0dRYXRaTlA1?=
 =?utf-8?B?Z0xuK2lwS0lac1JsU24yUW5ic29rT1JVaU9tdXh5SFhxVEphRGhrL3dsazhY?=
 =?utf-8?B?UVArZXNhL0wvaC9nNlpxaGJpbXNNcGs1VVhSMktIdlRuUTNQcGt1eUxjS1Vi?=
 =?utf-8?B?bk82NUZ0YTRJQlRBTkk2a252NklrNUc2Z1dLdlF2NmhQTDNiSlN4TndTbW4w?=
 =?utf-8?B?NmtWMTV0QnY1Vko0aUxxbTBSd1VyanpqRW4xOHVIeUlUa3hMMThrcStpV0lI?=
 =?utf-8?B?OTVkRGdicHh2K01WazJlNW12TDdVZUlzOHZ4MmFSK01DcXhoSDhVcE16dkJ0?=
 =?utf-8?B?dUtMKzg1VDY2V1JzVTJrTXN0RFpVMVNtUzhGajM5U1BtUWIyWUFaUmFmTkZm?=
 =?utf-8?B?djIvcVRlK2w2RFBZVVVLNTV5YUdmN1k0SDdsRm9pRngxWEV1NW9mWUg4ellG?=
 =?utf-8?B?Ym93Z0MwNkpZd1F2a0dLTTZKYlBpK0hENGRLUzVFR1dDdEpaWVBLVHFoMnpW?=
 =?utf-8?B?MmdaaStDU2NBRnhidnNVM25GM2VHbjRwYi9HM2xLdk9UbldlOEVvblAwNGl6?=
 =?utf-8?B?bUd6dmhhWWtRNFJYUDZGUG41WjlNRHg1ME44Wnp5alYvNEhUR0hwcFM2VnJX?=
 =?utf-8?B?aGtJUTFYK3JkbS9GaTBTU0J6TnV0UHp3WHJKcjlRYmRNOU4rS0pDNjVEN2ZF?=
 =?utf-8?B?L2JZaW5sNmp4UEFYMFdUZFhYYk5rdGkzUFZCUDA3OHRpMU1hNDZiYnpJdzlN?=
 =?utf-8?B?bHRZcnhSMkgra0o1cUFxWXNkUXZxRkYzbkVMaDdMNC9ITGxYdkdycFBqZFJS?=
 =?utf-8?B?S3pFbkU1VFdJaHZhcWZaSExrbGhNQWYzSUkxZTBzMnQ0OFphMTRlREt2UXN4?=
 =?utf-8?B?SjczcHIwNGZQSWFTcU9zcUI2TWxMc3RGN1RoUWVqYXBIbTluaGJLL2l5UU1S?=
 =?utf-8?Q?O9wiO2vk4tiAZMVaJ30Zr9YtoUcXpbyzl65l5NS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA0550574E0A8342BDF97EFEF13DBFD8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4dac63-94d8-4591-efa4-08d905fdf867
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 02:17:40.1392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +RXrs2Yhskp2ISWqUOLOa1wY6A8DLBbyA5alL8DXAgY8XWwZ6bBBUgHt1rKNgvMdu5UDR7KZ/vwGDCVJJQNjnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3501
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBcHIgMjIsIDIwMjEgYXQgMDc6MDI6MDRQTSArMDIwMCwgQm9yaXNsYXYgUGV0a292
IHdyb3RlOg0KPiBPbiBXZWQsIEFwciAyMSwgMjAyMSBhdCAwOTo1NzoyN0FNICswOTAwLCBOYW95
YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gRnJvbTogQWlsaSBZYW8gPHlhb2FpbGlAa2luZ3NvZnQu
Y29tPg0KPiANCi4uLg0KPiBUaGlzIHdob2xlIGNvbW1pdCBtZXNzYWdlIG5lZWRzIHNhbml0aXpp
bmcuDQo+IA0KPiBBbHNvLCBsb29raW5nIGF0IHRoZSBuZXh0IHBhdGNoLCB5b3UgY2FuIG1lcmdl
IHRoaXMgb25lIGludG8gdGhlIG5leHQNCj4gYmVjYXVzZSB0aGUgbmV4dCBvbmUgaXMgYWN0aW5n
IG9uIC1FSFdQT0lTT04gc28gaXQgYWxsIGJlbG9uZ3MgdG9nZXRoZXINCj4gaW4gYSBzaW5nbGUg
cGF0Y2guDQoNCk9LLCBJJ2xsIGZvbGQgdGhpcyBpbnRvIDMvMy4NCg0KVGhhbmtzLA0KTmFveWEg
SG9yaWd1Y2hp
