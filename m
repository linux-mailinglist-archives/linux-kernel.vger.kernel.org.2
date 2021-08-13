Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA86C3EBEA7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 01:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhHMXWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 19:22:25 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:34024 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235330AbhHMXWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 19:22:23 -0400
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 30188C08FE;
        Fri, 13 Aug 2021 23:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628896916; bh=l1o1zdX8q49zZobnpmR9rKPZCyfb6JP63muZ5t/jbtk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GjS4THDkxj0yAAvsEdLXggYUHczFf5o6fJPaoytW0SVwWFiCRwm5Qk/hRW0nu0wq+
         D06c8ySfM3tkt+Y1r77VvjBc+u6AUnMn5a3I3xykNq+iWyYEQTVMoZbKOxuTI31690
         2YMuDkWVWqMy6ZQp4zjeLKPZMmofEU9IPJLAO8rOnPSlkEvMXJsoS+h7acThanekQG
         8nZ1ch57wKNUsv1WkCguE/wpaV7KoR/FhWy4fyVkrq3jjxxj0z3lnvEhYTHZoqHBVk
         xmekuOyZtI9PsDvobYa4W06afZVg7Mgcc1ww8f8EqoS7e4TuZ4Q/JwIuJbBKGGBged
         wfq4qCEnI9UDA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 88492A008A;
        Fri, 13 Aug 2021 23:21:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 90C0180147;
        Fri, 13 Aug 2021 23:21:54 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="www4nVTT";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGss0ryHYQ9aEj+LmzSgmtl+NW477MPGD87DZJcOqAoMiLFTzIukIvJS9e9/eA9p2SHLwouB/QlWX53UEdSHzTMyHgImRqFJ3PZIPycbpiDDx8kZw591O0j6pmpzu7YCaI0jU2gVMnZnwO6PQj/qR/JPwEyDMHd/5+lr8mIbt6L8mbyZBOzVfBeEVCG3x7KXLNd2cztbJzDNIhSP+eD+IBVzWo/SKj+BsUKeue9YWuigpIx/36caTYW+lM70xoP5IqAK7F01trWE9HqZkTuu+WfPnSotzt0UMESMMIAztH/8jbZTxHSKES0/HIhXIHtOJJs1R+1CXSzsdw2fIz/ALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1o1zdX8q49zZobnpmR9rKPZCyfb6JP63muZ5t/jbtk=;
 b=H013yV2HhoUUwVzYVE95evca0EY3QuI0mZ1Cv9R8zE5Zs0kn+3UikjpMU0qWdvcGFQ429TRVd/iR0BrTFHWVMD0FnNHWeWgKZ9fzqKuTkFhRBfFIsSGHvtGH26B83YDqzu5vf9a/ktKUFj1hS7CHzkqbtQ9RrKnRJnhrGbRVIt/hsOt6fr18I3HcNSBCdHX6vgQWpXRFlBBphjziR14G0NZzzEJGgLVFyRfW3pVdinFD/gOeOnCjWvASLZ1s77wmcWYDam58hK7XKxSGBWeUqV97y1OADbQN6KDQHsu6/URLi1pJUpSipHms9GVPNy7jOfL5Y7CBCBsZdGTzElU2YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1o1zdX8q49zZobnpmR9rKPZCyfb6JP63muZ5t/jbtk=;
 b=www4nVTTLqpsVCASbkgd4eHu69NrrZDjL0sburCpMp6XMfnhLKzlDffIO5XpXmYz9KzqWGI3GHYA3uWSon9dleqSUf1m4vvZvLP/ps2+yjXXefvuUYg9Nd1teHnhwks+CrSGM8rL0avVI+XFhumCt7hgKjrmnpb5CV/DYvVCqGY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2663.namprd12.prod.outlook.com (2603:10b6:a03:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Fri, 13 Aug
 2021 23:21:52 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9%7]) with mapi id 15.20.4415.017; Fri, 13 Aug 2021
 23:21:52 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeauora.org" <jackp@codeauora.org>
Subject: Re: [RFC][PATCH] usb: dwc3: usb: dwc3: Force stop EP0 transfers
 during pullup disable
Thread-Topic: [RFC][PATCH] usb: dwc3: usb: dwc3: Force stop EP0 transfers
 during pullup disable
Thread-Index: AQHXjlfnBCk6lwHDK0Kvf9A7ww7BQqtvCnaAgAETMgCAAEh3AIAAHhwAgAGTEQA=
Date:   Fri, 13 Aug 2021 23:21:51 +0000
Message-ID: <f760fdcf-cd59-2c71-8c85-a4624620edeb@synopsys.com>
References: <1628648608-15239-1-git-send-email-wcheng@codeaurora.org>
 <bcc8ff30-5c49-bddd-2f61-05da859b2647@synopsys.com>
 <3edf74ba-d167-0589-a7ab-827b57aa5d9c@codeaurora.org>
 <e07b7061-e9cf-3146-d115-56967298051e@synopsys.com>
 <c82ee8f3-a364-f96f-76ac-2b78c1dc0517@codeaurora.org>
In-Reply-To: <c82ee8f3-a364-f96f-76ac-2b78c1dc0517@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4e37f7b-a16d-4a1e-b0ee-08d95eb121de
x-ms-traffictypediagnostic: BYAPR12MB2663:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB26634FDEAB81A62279B5B9D3AAFA9@BYAPR12MB2663.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M11dgjKgUN/6tsqXC3L2WH0WkO/Gp59WHJmLtUHpVCjhSj/j3/+ec5tMALCdCHT51/tM+zR7+1Dn554ruADNeDjG8DlOeI0GwTpxUyyHOjYVjrLaImxy03uxIAit0HE8+d7daX/dvMcTNDtVRAYlLZA9cbdJSoPx7JKG2J8hXV6+XtOl6/oRTN7PTuHpwK21eyAN/58VUDTJZADKDHiPY21epVvCalbMsOtXo1DR8RqXaDeqM3FJDBrvx+OcBK+Ae4Ses7UYA8Pv5a3kXq2ih4nxj/l4BF2IjIg0/L+W5DGfuzxdf/5nUVW4wouhGreewpOT3cdfFAU0Yj3fQkCpzx7IK2OIWmLPxWjVWoBvyXeGIv9vqK+RGK98HXSitcj/xnxr2iR3VOG9DYw76d3qvkA6LPocEFlGbRIlBmdopoCA14qM5zyZwk6sQLMOdUOcyyDcTJd1ycNqAAcLbUssbwb0rEZbGJNoUqw7aASWPvLtTRsAiwanZSapuRh/PA8DMCnuqAmDBl+PiDWrPVJtqEh+afFm2uO1YNggQEJIrTOeWRMhw+GVxqVeC4FJUrlPzLZG8ta8CRB+wm8D2EzTA3vqR5mYnbTCaDbtI7dWwCYCwHFNWPrmrMZm133aeRU8mSH9XaXbPaWzFOumNyYnV0GwcedqidN1CbW2N6T4/seb//EfOn89GYIn2jjKqQdLRb6pWsB2UMYocnGUm2iumK4VfRixZoTiZxKIMupKRKiCVcgZFAU42OUD2KJkzCCwrn1vQP9z6/sQJVunAEviTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(8936002)(8676002)(66446008)(36756003)(53546011)(6506007)(31696002)(316002)(64756008)(6512007)(110136005)(122000001)(2906002)(38070700005)(31686004)(4326008)(83380400001)(6486002)(26005)(54906003)(38100700002)(71200400001)(86362001)(5660300002)(66556008)(66476007)(66946007)(76116006)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE5wUUlFVlQ5ZkhSK2cyZ0JLUC8xV1RGa0xHTHlaQXQwbGowN0JwVUxvZXhv?=
 =?utf-8?B?czAwb1ZrZUhaMEZaSmN3UnRYamVkeWJVZHRyd29NUExhVjRJNDhmRzRzWDcz?=
 =?utf-8?B?Ymtsd2xPMnN2ZXZvelV2VzJvdTlXTlV3Y01YYzJObm0vRFBaaXNWVVFUQmVP?=
 =?utf-8?B?b3hxaFc0Y0RUMXNTUEFnUkN1TFBxZW10Y3I5b0djV2NON1FRRG5PbUxlSTI4?=
 =?utf-8?B?NVFCQXUvZ3hzWUVvOHd0Y3M1UkFDOUM1MXFkZTVQakgzaE5MelM3MVEwai95?=
 =?utf-8?B?OWFwZGxVcEg3aFBWYm9aZlI1Uk83ditFOVV3NUJZbWpadDJSalR0cC9DN1l6?=
 =?utf-8?B?SHhtemJPV3BzVGg1NjBqdVhIZFg1ZmdUbHRQdDhIaTFUUmdaWnIxclpxa1Jo?=
 =?utf-8?B?Y2lGRzlJTmo4YVN2NzZpcUxwT2xRUGJoTlpIYnNSMjlhQVg4RnZ5NURJSTJp?=
 =?utf-8?B?U0tEY2xnNnh5VStQWlVKR1loNjJnRUNESzhHZEFFYzFzWHB1NVJ0Mi8rRHRW?=
 =?utf-8?B?MWRHU0FienltV0l1QVNtY04rQWcrVlVSZTV1SGhFc3c1OXdBOGdJZWY5bkRh?=
 =?utf-8?B?NDA2OHo4RzlGSzVxQVUxbm11SXJRMWFxOEZLMUlGZngrTG9ucHdxVHNVeW1I?=
 =?utf-8?B?Ung1QUREeXhTRTVYY08rSnZ3U3FIYk1SNlMvZ3hiUzIraHN5djRiNXl0Qkgv?=
 =?utf-8?B?Y2NUcHlEQWhKdFpXN1ZFTVovczVMb0xTRUU4dmpFZ2V3RWJaZHB4NlE4RkFU?=
 =?utf-8?B?YzErRE1maXY3cTI0K25EU1RJUDdVS242Y3RiT1JXelR2ZjVnWGpQM2lXNkFH?=
 =?utf-8?B?Wm9zNjFmQ09UVkx0MFp6ajFQY3dNREQxejNFdEhVbitqMk9aQWw1MDcva2c3?=
 =?utf-8?B?bEY4ZkVNZVh5NVhnNzNpdkNiMHA0WEpoZ2xqaXUyV1EwWDF5R0ZGMFRTcCsx?=
 =?utf-8?B?Z1FReGFDMTBuQ21VRUMwcmVaMUY1MXJ0cWZpU2FzSVlpVFJURlBqL0FPajlK?=
 =?utf-8?B?aE1OenVUblYyS2EzYnVmSDVkbFlJbG9icUNGQ1c4MXJUcFBkWG55VzEzR0lE?=
 =?utf-8?B?ZWh6Y2ViaTlONkhTK293cmtDeEU2VU4rKzUrMmluWmRVaW5lWWFwYmlQTVg0?=
 =?utf-8?B?amFUa2cybmxoejdQeWxOYVJnNFRNRmdseVJheTdHV2hIVWExeXdzZysrNG5N?=
 =?utf-8?B?SWU5c3luUGxoM2l5aXEyTUFkQWY3dk5hRytPOVpMczQ3aEQ4TDh4NnhFZmly?=
 =?utf-8?B?czduakRoZll1UXgrTkUzUlM3bXN1dlZrcnlFc2kvUXJUeW03ZkdtVDl2T3FW?=
 =?utf-8?B?eGUvZE9aRDlPSXE5L1d1YUpKcnB6OUhLUnE4QzNaM3RMSEQyZkdmY3ErWWFN?=
 =?utf-8?B?bSt5aUN4R053eE1Nd0dRRFJmbzVIaWRlUjN0eW1TTm9OWWZRcm41cmtKSy9v?=
 =?utf-8?B?dXV4aHNNWlZuem05d0lXSWlaQktwZlhiVHk5N3YvK1NYTEdjRjF0SndUanBy?=
 =?utf-8?B?Y3lPUHVBYURhVkxzc2gzWnBCc2cwTTd3M1pJdEpMek9FRXFYblVPcjRHWW5t?=
 =?utf-8?B?T3JYZjRVUnhnQzlzeG9SWXFVbUpmdTJaWHRDa0FQQWQ4MEVReFBjMjRJVmNO?=
 =?utf-8?B?UWk4aVdZV2lpeGZtNmZGUGlJNk92MTZJNmVxemMwSVNVSDh1MjV0dWJxU3Ft?=
 =?utf-8?B?R3MyOU50K1JwNTNoWGkzTW14U2Y0bXhoODhuM0lNUnhjUDAya1hwaXF6TGlQ?=
 =?utf-8?Q?l+QgTP0hPbeYVaAbts=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <503D03658984804898BBCD044A3E496E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e37f7b-a16d-4a1e-b0ee-08d95eb121de
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 23:21:51.8391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbRWM01iF+s9V9jX/HdUSATBos1EFq50b4flo3NMn3GQsdpdPdAWK5HuCSsGoEH9og6A5JZs9XQ3Mr8XZbWRaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2663
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4gDQo+IE9uIDgvMTIvMjAyMSAyOjMx
IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+PiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4gSGkg
VGhpbmgsDQo+Pj4NCj4+PiBPbiA4LzExLzIwMjEgNTo0NyBQTSwgVGhpbmggTmd1eWVuIHdyb3Rl
Og0KPj4+PiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4+PiBEdXJpbmcgYSBVU0IgY2FibGUgZGlz
Y29ubmVjdCwgb3Igc29mdCBkaXNjb25uZWN0IHNjZW5hcmlvLCBhIHBlbmRpbmcNCj4+Pj4+IFNF
VFVQIHRyYW5zYWN0aW9uIG1heSBub3QgYmUgY29tcGxldGVkLCBsZWFkaW5nIHRvIHRoZSBmb2xs
b3dpbmcNCj4+Pj4+IGVycm9yOg0KPj4+Pj4NCj4+Pj4+ICAgICBkd2MzIGE2MDAwMDAuZHdjMzog
dGltZWQgb3V0IHdhaXRpbmcgZm9yIFNFVFVQIHBoYXNlDQo+Pj4+DQo+Pj4+IEhvdyBjb3VsZCBp
dCBiZSBhIGNhc2Ugb2YgY2FibGUgZGlzY29ubmVjdD8gVGhlIHB1bGx1cCgwKSBvbmx5IGFwcGxp
ZXMNCj4+Pj4gZm9yIHNvZnQtZGlzY29ubmVjdCBzY2VuYXJpby4gSWYgdGhlIGRldmljZSBpbml0
aWF0ZWQgYSBkaXNjb25uZWN0LCB0aGVuDQo+Pj4NCj4+PiBUaGFua3MgZm9yIHRoZSByZXNwb25z
ZS4gIEkgZ3Vlc3MgdGhpcyBpcyBzcGVjaWZpYyBmb3Igc29tZSB1c2UgY2FzZXMsDQo+Pj4gYnV0
IHNvbWUgYXBwbGljYXRpb25zIHN1Y2ggYXMgQURCIHdpbGwgY2xvc2UgdGhlIEZGUyBFUCBmaWxl
cyBhZnRlciBpdA0KPj4+IGdldHMgdGhlIGRpc2Nvbm5lY3Rpb24gZXZlbnQsIGxlYWRpbmcgdG8g
dGhpcyBwdWxsdXAgZGlzYWJsZSBhcyB3ZWxsLg0KPj4+IFNvIGl0cyBzcGVjaWZpYyB0byB0aGF0
IHBhcnRpY3VsYXIgdXNlIGNhc2UuDQo+Pg0KPj4gRG9lcyB0aGF0IG1lYW4gdGhhdCB0aGUgQURC
IGFwcGxpY2F0aW9uIHdvbid0IGV4cGVjdCBhIGNvbm5lY3Rpb24gdW50aWwNCj4+IHVzZXIgaW50
ZXJ2ZW50aW9uIG9yIHNvbWUgb3RoZXIgbm90aWZpY2F0aW9uIHRvIGRvIHB1bGx1cCgxKT8NCj4+
DQo+IA0KPiBZZXMsIGNvcnJlY3QuICBUaGUgQW5kcm9pZCBVU0IgZnJhbWV3b3JrIHdpbGwgdHJp
Z2dlciB0aGUgcHVsbHVwKDEpIGFnYWluLg0KPiANCj4+Pg0KPj4+PiB0aGUgZHJpdmVyIHNob3Vs
ZCB3YWl0IGZvciB0aGUgY29udHJvbCByZXF1ZXN0IHRvIGNvbXBsZXRlLiBJZiBpdCB0aW1lcw0K
Pj4+PiBvdXQsIHNvbWV0aGluZyBpcyBhbHJlYWR5IHdyb25nIGhlcmUuIFRoZSBwcm9ncmFtbWlu
ZyBndWlkZSBvbmx5DQo+Pj4+IG1lbnRpb25zIHRoYXQgd2Ugc2hvdWxkIHdhaXQgZm9yIGNvbXBs
ZXRpb24sIGJ1dCBpdCBkb2Vzbid0IHNheSBhYm91dA0KPj4+PiByZWNvdmVyeSBpbiBhIGNhc2Ug
b2YgaHVuZyB0cmFuc2Zlci4gSSBuZWVkIHRvIGNoZWNrIGludGVybmFsbHkgYnV0IGl0DQo+Pj4+
IHNob3VsZCBiZSBzYWZlIHRvIGlzc3VlIEVuZCBUcmFuc2Zlci4NCj4+Pj4NCj4+Pg0KPj4+IFll
cywgd2hhdCBJIGRpZCB3YXMgbW9kaWZ5IGEgZGV2aWNlIHJ1bm5pbmcgdGhlIExpbnV4IFhIQ0kg
c3RhY2sgdy9vDQo+Pj4gcmVhZGluZy9zZW5kaW5nIG91dCB0aGUgU0VUVVAgREFUQSBwaGFzZSwg
c28gdGhhdCBvbiB0aGUgZGV2aWNlIGVuZCB3ZSdkDQo+Pj4gYWx3YXlzIHJ1biBpbnRvIHRoYXQg
c2l0dWF0aW9uIHdoZXJlIHRoZXJlJ3Mgc3RpbGwgYSBwZW5kaW5nIEVQMCBUUkIgcXVldWVkLg0K
Pj4NCj4+IElzIHRoaXMgb25seSBmb3IgdmFsaWRhdGlvbiBwdXJwb3NlPw0KPj4NCj4gDQo+IFll
cywganVzdCB0byBoZWxwIHZlcmlmeSB0aGUgZml4IGJ5IGluamVjdGluZyB0aGUgZXJyb3IgY29u
ZGl0aW9uLg0KDQpKdXN0IHdhbnQgdG8gY2xhcmlmeSwgc28geW91IGRpZG4ndCByZWFsbHkgcnVu
IGludG8gdGhpcyBwcm9ibGVtIGJ1dA0Kd2FudCB0byBmaXggdGhlIHJlY292ZXJ5IHBhdGggcmln
aHQ/DQoNCj4gDQo+Pj4NCj4+PiBXZSdyZSBydW5uaW5nIG11bHRpcGxlIGRldmljZXMgd2l0aCB0
aGlzIGZpeCBhcyB3ZWxsLCBhbmQgZG9pbmcgZGV2aWNlDQo+Pj4gaW5pdGlhdGVkIGRpc2Nvbm5l
Y3QuDQo+Pj4NCj4+Pj4+DQo+Pj4+PiBJZiB0aGlzIG9jY3VycywgdGhlbiB0aGUgZW50aXJlIHB1
bGx1cCBkaXNhYmxlIHJvdXRpbmUgaXMgc2tpcHBlZCBhbmQNCj4+Pj4+IHByb3BlciBjbGVhbnVw
IGFuZCBoYWx0aW5nIG9mIHRoZSBjb250cm9sbGVyIGRvZXMgbm90IGNvbXBsZXRlLg0KPj4+Pj4g
SW5zdGVhZCBvZiByZXR1cm5pbmcgYW4gZXJyb3IgKHdoaWNoIGlzIGlnbm9yZWQgZnJvbSB0aGUg
VURDDQo+Pj4+PiBwZXJzcGVjdGl2ZSksIGRvIHdoYXQgaXMgbWVudGlvbmVkIGluIHRoZSBjb21t
ZW50cyBhbmQgZm9yY2UgdGhlDQo+Pj4+PiB0cmFuc2FjdGlvbiB0byBjb21wbGV0ZSBhbmQgcHV0
IHRoZSBlcDBzdGF0ZSBiYWNrIHRvIHRoZSBTRVRVUCBwaGFzZS4NCj4+Pj4+DQo+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHdjaGVuZ0Bjb2RlYXVyb3JhLm9yZz4NCj4+Pj4+IC0t
LQ0KPj4+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvZXAwLmMgICAgfCA0ICsrLS0NCj4+Pj4+ICBkcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgNiArKysrKy0NCj4+Pj4+ICBkcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5oIHwgMyArKysNCj4+Pj4+ICAzIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2R3YzMvZXAwLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+Pj4+PiBpbmRleCA2NTg3Mzk0
Li5hYmZjNDJiIDEwMDY0NA0KPj4+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPj4+
Pj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPj4+Pj4gQEAgLTIxOCw3ICsyMTgsNyBA
QCBpbnQgZHdjM19nYWRnZXRfZXAwX3F1ZXVlKHN0cnVjdCB1c2JfZXAgKmVwLCBzdHJ1Y3QgdXNi
X3JlcXVlc3QgKnJlcXVlc3QsDQo+Pj4+PiAgCXJldHVybiByZXQ7DQo+Pj4+PiAgfQ0KPj4+Pj4g
IA0KPj4+Pj4gLXN0YXRpYyB2b2lkIGR3YzNfZXAwX3N0YWxsX2FuZF9yZXN0YXJ0KHN0cnVjdCBk
d2MzICpkd2MpDQo+Pj4+PiArdm9pZCBkd2MzX2VwMF9zdGFsbF9hbmRfcmVzdGFydChzdHJ1Y3Qg
ZHdjMyAqZHdjKQ0KPj4+Pj4gIHsNCj4+Pj4+ICAJc3RydWN0IGR3YzNfZXAJCSpkZXA7DQo+Pj4+
PiAgDQo+Pj4+PiBAQCAtMTA3Myw3ICsxMDczLDcgQEAgdm9pZCBkd2MzX2VwMF9zZW5kX2RlbGF5
ZWRfc3RhdHVzKHN0cnVjdCBkd2MzICpkd2MpDQo+Pj4+PiAgCV9fZHdjM19lcDBfZG9fY29udHJv
bF9zdGF0dXMoZHdjLCBkd2MtPmVwc1tkaXJlY3Rpb25dKTsNCj4+Pj4+ICB9DQo+Pj4+PiAgDQo+
Pj4+PiAtc3RhdGljIHZvaWQgZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0YShzdHJ1Y3QgZHdjMyAq
ZHdjLCBzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPj4+Pj4gK3ZvaWQgZHdjM19lcDBfZW5kX2NvbnRy
b2xfZGF0YShzdHJ1Y3QgZHdjMyAqZHdjLCBzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPj4+Pj4gIHsN
Cj4+Pj4+ICAJc3RydWN0IGR3YzNfZ2FkZ2V0X2VwX2NtZF9wYXJhbXMgcGFyYW1zOw0KPj4+Pj4g
IAl1MzIJCQljbWQ7DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
YyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+Pj4+IGluZGV4IDU0YzVhMDguLmEwZTJl
NGQgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4+PiAr
KysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4+PiBAQCAtMjQzNyw3ICsyNDM3LDEx
IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcHVsbHVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBp
bnQgaXNfb24pDQo+Pj4+PiAgCQkJCW1zZWNzX3RvX2ppZmZpZXMoRFdDM19QVUxMX1VQX1RJTUVP
VVQpKTsNCj4+Pj4+ICAJCWlmIChyZXQgPT0gMCkgew0KPj4+Pj4gIAkJCWRldl9lcnIoZHdjLT5k
ZXYsICJ0aW1lZCBvdXQgd2FpdGluZyBmb3IgU0VUVVAgcGhhc2VcbiIpOw0KPj4+Pj4gLQkJCXJl
dHVybiAtRVRJTUVET1VUOw0KPj4+Pj4gKwkJCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ss
IGZsYWdzKTsNCj4+Pj4+ICsJCQlkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3YywgZHdjLT5l
cHNbMF0pOw0KPj4+Pj4gKwkJCWR3YzNfZXAwX2VuZF9jb250cm9sX2RhdGEoZHdjLCBkd2MtPmVw
c1sxXSk7DQo+Pj4+DQo+Pj4+IEVuZCB0cmFuc2ZlciBjb21tYW5kIHRha2VzIHRpbWUsIG5lZWQg
dG8gd2FpdCBmb3IgaXQgdG8gY29tcGxldGUgYmVmb3JlDQo+Pj4+IGlzc3VpbmcgU3RhcnQgdHJh
bnNmZXIgYWdhaW4uIEFsc28sIHdoeSByZXN0YXJ0IGFnYWluIHdoZW4gaXQncyBhYm91dCB0bw0K
Pj4+PiBiZSBkaXNjb25uZWN0ZWQuDQo+Pj4NCj4+PiBJIGNhbiB0cnkgd2l0aG91dCByZXN0YXJ0
aW5nIGl0IGFnYWluLCBhbmQgc2VlIGlmIHRoYXQgd29ya3MuICBJbnN0ZWFkDQo+Pj4gb2Ygd2Fp
dGluZyBmb3IgdGhlIGNvbW1hbmQgY29tcGxldGUgZXZlbnQsIGNhbiB3ZSBzZXQgdGhlIEZvcmNl
Uk0gYml0LA0KPj4+IHNpbWlsYXIgdG8gd2hhdCB3ZSBkbyBmb3IgZHdjM19yZW1vdmVfcmVxdWVz
dHMoKT8NCj4+Pg0KPj4NCj4+IEZvcmNlUk09MSBtZWFucyB0aGF0IHRoZSBjb250cm9sbGVyIHdp
bGwgaWdub3JlIHVwZGF0aW5nIHRoZSBUUkJzDQo+PiAoaW5jbHVkaW5nIG5vdCBjbGVhcmluZyB0
aGUgSFdPIGFuZCByZW1haW4gdHJhbnNmZXIgc2l6ZSkuIFRoZSBkcml2ZXINCj4+IHN0aWxsIG5l
ZWRzIHRvIHdhaXQgZm9yIHRoZSBjb21tYW5kIHRvIGNvbXBsZXRlIGJlZm9yZSBpc3N1aW5nIFN0
YXJ0DQo+PiBUcmFuc2ZlciBjb21tYW5kLiBPdGhlcndpc2UgU3RhcnQgVHJhbnNmZXIgd29uJ3Qg
Z28gdGhyb3VnaC4gSWYgd2Uga25vdw0KPj4gdGhhdCB3ZSdyZSBub3QgZ29pbmcgdG8gaXNzdWUg
U3RhcnQgVHJhbnNmZXIgYW55IHRpbWUgc29vbiwgdGhlbiB3ZSBtYXkNCj4+IGJlIGFibGUgdG8g
Z2V0IGF3YXkgd2l0aCBpZ25vcmluZyBFbmQgVHJhbnNmZXIgY29tbWFuZCBjb21wbGV0aW9uLg0K
Pj4NCj4gDQo+IEkgc2VlLiAgQ3VycmVudGx5LCBpbiB0aGUgcGxhY2UgdGhhdCB3ZSBkbyB1c2UN
Cj4gZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0YSgpLCBpdHMgZm9sbG93ZWQgYnkNCj4gZHdjM19l
cDBfc3RhbGxfYW5kX3Jlc3RhcnQoKSB3aGljaCB3b3VsZCBleGVjdXRlIHN0YXJ0IHRyYW5zZmVy
LiAgRm9yDQoNClRoYXQgZG9lc24ndCBsb29rIHJpZ2h0LiBZb3UgY2FuIHRyeSB0byBzZWUgaWYg
aXQgY2FuIHJlY292ZXIgZnJvbSBhDQpjb250cm9sIHdyaXRlIHJlcXVlc3QuIE9mdGVuIHRpbWUg
d2UgZG8gY29udHJvbCByZWFkIGFuZCBub3Qgd3JpdGUuDQooaS5lLiB0cnkgdG8gRW5kIFRyYW5z
ZmVyIGFuZCBpbW1lZGlhdGVseSBTdGFydCBUcmFuc2ZlciBvbiB0aGUgc2FtZQ0KZGlyZWN0aW9u
IGNvbnRyb2wgZW5kcG9pbnQpLg0KDQo+IHRoZSBtb3N0IHBhcnQsIHdlIHdlcmUgdHJ5aW5nIHRv
IGZvbGxvdyB0aGUgZmxvdyBkaWFncmFtIGluOg0KPiANCj4gCTQuNCBDb250cm9sIFRyYW5zZmVy
IFByb2dyYW1taW5nIE1vZGVsDQo+IA0KPiBXZSdkIHRlY2huaWNhbGx5IGJlIGluIHRoZSAid2Fp
dCBmb3IgaG9zdCIgc3RhZ2UgYXQgdGhpcyBwb2ludCwgc28gaGVuY2UNCj4gd2h5IHdlIGlzc3Vl
ZCB0aGUgZW5kIHRyYW5zZmVyLCB0aGVuIGZvbGxvd2VkIHdpdGggdGhlIHN0YWxsIGFuZCByZXN0
YXJ0Lg0KPiANCg0KWW91J3JlIG5vdCBzZXR0aW5nIHVwIHRoZSBkYXRhIHN0YWdlIG9uIGhvc3Qg
c2lkZSByaWdodD8gU28sIHdlIHdvdWxkbid0DQpyZWNlaXZlIGEgWGZlck5vdFJlYWR5KGRhdGEp
IHRvIHByb2NlZWQgdG8gdGhlIG5leHQgc3RhdGUgdG8gaW50ZXJwcmV0DQp3aGV0aGVyIGl0J3Mg
dW5leHBlY3RlZCBkaXJlY3Rpb24gdG8gZW5kIGFuZCByZXN0YXJ0LiBBbHNvLCB5b3Ugc2hvdWxk
DQpjaGVjayB0byBzZWUgd2hpY2ggZGlyZWN0aW9uL2NvbnRyb2wgc3RhZ2Ugd2FzIGh1bmcgdG8g
aXNzdWUgRW5kDQpUcmFuc2ZlciB0byBlcDAgb3IgZXAxLiBPbiByZWNvbm5lY3QgYWZ0ZXIgZGV2
aWNlIGluaXRpYXRlZCBkaXNjb25uZWN0LA0KdGhlIGdhZGdldCBzaG91bGQgc3RhcnQgZXAwIGZv
ciBzZXR1cCBzdGFnZSBhZ2Fpbi4NCg0KTm90ZToNCkkgZG9uJ3QgdGhpbmsgd2UgY2xlYXJseSBk
ZWZpbmVkIGEgcmVjb3ZlcnkgZm9yIHRoaXMgdGltZW91dCBmb3IgZGV2aWNlDQppbml0aWF0ZWQg
ZGlzY29ubmVjdC4gTW9zdCBvZiB0aGUgdGltZSB3ZSBkb24ndCB3YW50IHRvIGlzc3VlIEVuZA0K
VHJhbnNmZXIgZm9yIGVuZHBvaW50IDAgKE9VVCBkaXJlY3Rpb24pIGJlY2F1c2Ugd2UgbWF5IGJl
IGV4cGVjdGluZyBhDQpzZXR1cCBwYWNrZXQuIEhvd2V2ZXIsIGluIHRoaXMgY2FzZSBvZiBlcnJv
ciByZWNvdmVyeSB0byBwcm9jZWVkIHRvDQpzb2Z0LWRpc2Nvbm5lY3QsIGl0IHNob3VsZCBiZSBm
aW5lLg0KDQpCUiwNClRoaW5oDQo=
