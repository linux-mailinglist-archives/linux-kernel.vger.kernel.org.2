Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920813896D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhESTka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:40:30 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:53662 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232144AbhESTk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:40:27 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E1ED0C00CE;
        Wed, 19 May 2021 19:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1621453146; bh=QLSWF7OYe8/jXU0tBbLB1soUPCD9L3ulBUOnU29+sJw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Vdc8bQh//P23UHx71ushlohlm4NN7qYzh9daMl+NXTsfaCi0I6tz25gdpxyzlH2dI
         RcA1DTobM0ydVIlPjkTDt2CfvlWeoHW4XoKWU5E3uX9lDm2MGEOyKDSHvjCkD6Cq4K
         /DOuxIlrH0KKZtVYkGSNE26cCwUmfIQ7/CStqG1tygtti+cAcuEOOf+ZQmsCR4M9wT
         5DD4frNHIoAKEbDs7jgcw1nk/8T0lLKA78TFGQ+reA4/fTqqoHOcO8uYYo+4HQ0/+k
         geJq4aPhEIWvdYWQTZGHS6bckI3hbT8qrLDceDe2K6VZdNUOKZNfJpWfqPvPYI8NUx
         JfQyXyLAhnUyQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E2198A0071;
        Wed, 19 May 2021 19:38:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 42C0280269;
        Wed, 19 May 2021 19:38:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="gAOQ4okh";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in8mfIqfQ9zfaLuKdEVqecFcPrrTqd2ulYD9KTPzz/gV5ZphF4aMF2VMlks8CaqMUjciYN+So3WtYTnGxo3Ju9aO5yS6xQ9yz40eT+fcfNHCbvSboGzs2dUc906fDyBVnU+UI9tL7aneDRcIHXWAcDryreH5LILCpa4uWmVwTNnFVIgbLl1a+FEyCioXCWNVJR3b/E9ln6q/WNyS2XWRgG0U6g9lZbATimWCjdU1Wb4ywsXPDyXoUfoI4GXZzij8oMxIWhrheL3BdGO5mhIgB/fnIRuZWolgWiX4mv8A4ddfTG5sCWbFYEwUt/DekZ6cBMz4+Y9f7lLm4Zr/CkiJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLSWF7OYe8/jXU0tBbLB1soUPCD9L3ulBUOnU29+sJw=;
 b=jGtJ3lZCR69k6Q0vn3hO4qnfk+1w0lapsAo+pZW6sy+vEwwp2UCRLy76WGBclJVCPjSFHOaBuMmcrWEAcO8oWbqr8PXmNR5x609+Tt75cLVkGFZ9JhDfNxcB+3GH9nObP0yvmopOSE2ICtCjq1eWSRS26AseLR8aqV6367lTaG3A2XLDm1jnoi/n7SpSqvs+7lLC/nWXe9D+34EHMrJwBdUWMudcZTGDDZd0yrJF+yhqRwLuGoUNPiu4lPHvSPMzimYJYUkmaMU3hSd2nEP2ue9X/MfPY/h50XOhZ6YpLIE//PLbYN8qgvGokk8x9QaNhlahGmwYHMRVIYSXdh3U8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLSWF7OYe8/jXU0tBbLB1soUPCD9L3ulBUOnU29+sJw=;
 b=gAOQ4okhvehWoYiR6xZYQrdjmVvtMlE6ce5TZKD/w5UKMVXYEYKhpPC3Udk391Mg5wzfEnsj0Iimi7R8sXqiyVwQmfgm+xRmP+BMwgRtDfmDi5EJROVOD76vJnCVyXHkh67+aaxH5rKrZyPWya9tVdkDTLN9O+cMqSQA8y5kEos=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 19:38:52 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::88be:f751:f493:25f9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::88be:f751:f493:25f9%6]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 19:38:52 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Guido Kiener <Guido.Kiener@rohde-schwarz.com>
CC:     dave penkler <dpenkler@gmail.com>,
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
Thread-Index: AQHXTOaYgJWmk5cMcUemqbVphw6dSA==
Date:   Wed, 19 May 2021 19:38:52 +0000
Message-ID: <12088413-2f7d-a1e5-5e8a-25876d85d18a@synopsys.com>
References: <d673611ca53f42a3a629eb051cabc6eb@rohde-schwarz.com>
 <20210519173545.GA1173157@rowland.harvard.edu>
In-Reply-To: <20210519173545.GA1173157@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
authentication-results: rowland.harvard.edu; dkim=none (message not signed)
 header.d=none;rowland.harvard.edu; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [73.15.163.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e729398e-2fab-4133-c77d-08d91afdbbb4
x-ms-traffictypediagnostic: BYAPR12MB2806:
x-microsoft-antispam-prvs: <BYAPR12MB2806AD7E60BC2A4CAF71E46EAA2B9@BYAPR12MB2806.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i+JZwrA9+YmY/FYhkyx8KIkJ9VavQP8+5/AJcVDxjEa0gp5uP4bJap7PN8PAVvGmqV3xYWnpsQjU60TKZTEYb0u10LiBLzjBeDvUHTrzKVkCs2X/DOVXk9zpHwBP9ixd7K93mJMZMGyMAMRzEDSm7INbPapgUdaB+3cIABK/tl0K+2+WBhojc73chVHpmlm5IMXc74rZf+zQOsgpzgOlGjebdVVuVAzp1OSoE/kXC11vuS1+sscnz9Z47xoF0VKRoWpVrCMPc5W43g2F8DCKc9WGlTYU2OcJWSYTzfLNhqtc8BFQ/PKSRxA3YR0CLUKxurQCjYkhrYYYzhXexYZHHHBYiGN2u0wIrrPr3hKtMvV0OSemrWLsf1UDWKx+fR7oOzAjRlm9DW/7MtuCXy8FHXgI2BDBuHHWRL5N+gzgdG7G2uZDRb8qzXKh3PjOF3GS1HBH6R8lEFVr/QH0LLjc0NgCBXaj7VxFzwCEruvmOFHmwPEP2foRKQH9JrnD9oJHHbYDNtv0ke0QcFIp+dYomzKjrQiB3t842+ftUmJcvkurPlPLLKQxu4miaACVXqjFbAXXba6FrRVw1X1vqZBEwTPl+jdYL+sU2xDC95d9btuGKtyNo6zbLTilMOmCjPw+/F+OlvD7frORGWtBhy/s7PWuUGE0WNP20giTd7Qun6oUJg7yEemrRnBKWVjVTKK+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39850400004)(346002)(396003)(366004)(122000001)(6506007)(6486002)(86362001)(8676002)(36756003)(64756008)(71200400001)(83380400001)(38100700002)(31696002)(66476007)(76116006)(478600001)(66946007)(66446008)(8936002)(110136005)(186003)(5660300002)(26005)(54906003)(66556008)(2906002)(4326008)(2616005)(316002)(31686004)(6512007)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eTJGQW91UzZOMFZMTjFMQXZNOUVVZ0FYVTlkSXhUVFVNNlhqdTNVZ1F5SzJv?=
 =?utf-8?B?UDlodm1sZFFZbkg1MU5iNjMwK0xDMUlLM1AydWRTQXE5ZUJ5RUVhVjRmQXI3?=
 =?utf-8?B?bkFhMzQxSXRhMHhNdU93N0tzTWM1RGt3SHZPWjEyMzJkR1RQS2U2N1BSamE1?=
 =?utf-8?B?WllHQVIxRnVnbjZzSW03RE9tRFg0TkFYbDVseXI0Zi9EZjF6RTJTN1lUNXRj?=
 =?utf-8?B?RFdBZzAzd3IzdVkxbzZ1Rm0zOG9sTjZsa0FNaHFaeVJlWjFhTWdHaXFLRUQr?=
 =?utf-8?B?VlI2eld4d09aWjQvV0lLR0Nqb1k3WVhzWmMyYXlidlByUk84VTMxbEl3aURp?=
 =?utf-8?B?TnBjMlRjMTNHQVZwdy9aNWRPTlZSMkRlTnB2d2sxdnd1OXo3aW5abTVjbW0z?=
 =?utf-8?B?V0RndHUvcFRGM2Z6OGVPd2hRQVh1cXFlc0JxZVBRTzNGY2RJUzVMVTdLbS82?=
 =?utf-8?B?cHlROEVEQnZTcG8zN0dsV2YrODljVG9odHlRWjJHMitQeVdDc3NpOEQyU3FU?=
 =?utf-8?B?OEtsWkV3cTc2VkttTHd3ZVZqUlBYSTJ2dTByWi9IclpqQ2l0TnR6eTdaZy83?=
 =?utf-8?B?R0NZWjd6S0pObnVYZ256WUtxTGNvd2JoVStsbmdYbk9HSkRrMTRPekdLOS9R?=
 =?utf-8?B?VG9rcDVQc3VyaHYwaXhpNUs1cGpYSzJXVFl1SW1UL3BLK1kwbHd1cmV1OVA0?=
 =?utf-8?B?MmErNzBQdW1XNDhhc1U1b1Fscmtqckx4cU9lbll6Y0FYY1ZNNGI3Y0duRjlW?=
 =?utf-8?B?OVN0eFdpVG1MOE95ZWRrU1pRZFh0cnJ0czVtdDhmVlF0WkRsTVFBS2pzc1A2?=
 =?utf-8?B?Z3lsUUE0TEk2eEpvU1JWZzk4Q0lhb2RFRTRhMTJkNENock9taHg3ZHZKRHp2?=
 =?utf-8?B?cXVCRWcyNmc1a3pvOG5Vb2pwL0NwbXJpVll1eHIwS0hvQ1R3YXVTanVzendN?=
 =?utf-8?B?T0ZiTUxDL000MjJURmd6MWFGRHFxUmo5SmpxSWo1TjVzbzdHbTVvSTVWN2xu?=
 =?utf-8?B?M0ltc090SGxVVDdNYjl6aEV1dUpIb3BmOXhDdkF5MVlPZlpwRE81ZWUxeWdh?=
 =?utf-8?B?akZvNmttOGdkeVMvVEp6d2FpSE94ZTZwZFc2bHV3bXIzUEhxZ1YrUkNYRjg1?=
 =?utf-8?B?RjRCTitwUUZrZE1FTHpFT0g3Z2U0c3dDeUthVnBzdFgwb1lQSHRBMEY4YUwr?=
 =?utf-8?B?RmYrd0ZybFUyeDh2WDdBYWhRK3VZOVVhNXA2UmRrb2llNDJPR0EzWVpYS2x0?=
 =?utf-8?B?OERDNTZ6UFJQOFk3QUNHV3ErWG1FZExvRUllckpRNVU2ZzRsUmtHOGIrK09V?=
 =?utf-8?B?eWxmalFzZCtlVTJpbUhFeFJWVW4wdWE2azRGVkZITU1xNGMxaGYwNXBtSVFI?=
 =?utf-8?B?aGJsT3dQVzQzbFBrRFMySW9CRDFwY1pYeGN5cWdFaFh4QkFQenkyVTBtTVc1?=
 =?utf-8?B?NmhyTlZ6ZXhjYUpLd1JGZXBEVFBzNkNFM3lUcW13V0hQRjYrZTVMS0ZQL0pj?=
 =?utf-8?B?NE5odUU2MVcvOXNrTG5CWmJSaFpKa0o4NlQvT3RUZkszY0tSZ3FaRFdNYUw4?=
 =?utf-8?B?bnFwTXp0Rjl5TjVrRnlqVURSL2xPNFRKTldUTVZTdFE3MFNJVUtBT0szM3N6?=
 =?utf-8?B?NFBWcGJ5OGh6bGxNbU1CampwMEFWUC9QSXBUbUgwejRPa2VGaGpTcFpmN0Er?=
 =?utf-8?B?aVdMTkZMVmtjNElqWUZxTGpnSTRWNSt6WmszMzRhMnFXY1pFWFRLZVdoQXd1?=
 =?utf-8?Q?lLMO6oHJ4zwSJwJW6A=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5872D9C7373E3942BE2A11A84FE9386B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e729398e-2fab-4133-c77d-08d91afdbbb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 19:38:52.5752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8cjptQLOl0xGWhrUvMHYa+WznMvfV3fEfwtHdvcM/EWkl/Jpc7SNyrOvhKi/OPfut9ymyDh/W/jT4V5Vxx+OAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWxhbiBTdGVybiB3cm90ZToNCj4gT24gV2VkLCBNYXkgMTksIDIwMjEgYXQgMDQ6MTQ6MjBQTSAr
MDAwMCwgR3VpZG8gS2llbmVyIHdyb3RlOg0KPj4+IE9uIFdlZCwgTWF5IDE5LCAyMDIxIGF0IDEw
OjQ4OjI5QU0gKzAyMDAsIGRhdmUgcGVua2xlciB3cm90ZToNCj4+Pj4gT24gU2F0LCA4IE1heSAy
MDIxIGF0IDE2OjI5LCBBbGFuIFN0ZXJuIDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1PiB3cm90
ZToNCj4+Pj4+DQo+Pj4+PiBPbiBTYXQsIE1heSAwOCwgMjAyMSBhdCAxMDoxNDo0MUFNICswMjAw
LCBkYXZlIHBlbmtsZXIgd3JvdGU6DQo+Pj4+Pj4gV2hlbiB0aGUgaG9zdCBkcml2ZXIgZGV0ZWN0
cyBhIHByb3RvY29sIGVycm9yIHdoaWxlIHByb2Nlc3NpbmcgYW4NCj4+Pj4+PiBVUkIgaXQgY29t
cGxldGVzIHRoZSBVUkIgd2l0aCBFUFJPVE8gc3RhdHVzIGFuZCBtYXJrcyB0aGUgZW5kcG9pbnQN
Cj4+Pj4+PiBhcyBoYWx0ZWQuDQo+Pj4+Pg0KPj4+Pj4gTm90IHRydWUuICBJdCBkb2VzIG5vdCBt
YXJrIHRoZSBlbmRwb2ludCBhcyBoYWx0ZWQsIG5vdCB1bmxlc3MgaXQNCj4+Pj4+IHJlY2VpdmVz
IGEgU1RBTEwgaGFuZHNoYWtlIGZyb20gdGhlIGRldmljZS4gIEEgU1RBTEwgaXMgbm90IGENCj4+
Pj4+IHByb3RvY29sIGVycm9yLg0KPj4+Pj4NCj4+Pj4+PiBXaGVuIHRoZSBjbGFzcyBkcml2ZXIg
cmVzdWJtaXRzIHRoZSBVUkIgYW5kIHRoZSBpZiB0aGUgaG9zdCBkcml2ZXINCj4+Pj4+PiBmaW5k
cyB0aGUgZW5kcG9pbnQgc3RpbGwgbWFya2VkIGFzIGhhbHRlZCBpdCBzaG91bGQgcmV0dXJuIEVQ
SVBFDQo+Pj4+Pj4gc3RhdHVzIG9uIHRoZSByZXN1Ym1pdHRlZCBVUkINCj4+Pj4+DQo+Pj4+PiBJ
cnJlbGV2YW50Lg0KPj4+PiBOb3QgYXQgYWxsLiBUaGUgcG9pbnQgaXMgdGhhdCB3aGVuIGFuIGFw
cGxpY2F0aW9uIGlzIHRhbGtpbmcgdG8gYW4NCj4+Pj4gaW5zdHJ1bWVudCBvdmVyIHRoZSB1c2J0
bWMgZHJpdmVyLCB0aGUgdW5kZXJseWluZyBob3N0IGNvbnRyb2xsZXIgYW5kDQo+Pj4+IGl0cyBk
cml2ZXIgd2lsbCBkZXRlY3QgYW5kIHNpbGVuY2UgYSBiYWJibGluZyBlbmRwb2ludC4NCj4+Pg0K
Pj4+IE5vLCB0aGV5IHdvbid0LiAgVGhhdCBpcywgdGhleSB3aWxsIGRldGVjdCBhIGJhYmJsZSBl
cnJvciBhbmQgcmV0dXJuIGFuIGVycm9yIHN0YXR1cywgYnV0DQo+Pj4gdGhleSB3b24ndCBzaWxl
bmNlIHRoZSBlbmRwb2ludC4gIFdoYXQgbWFrZXMgeW91IHRoaW5rIHRoZXkgd2lsbD8NCj4+DQo+
PiBNYXliZSB0aGVyZSBpcyBhIG1pc3VuZGVyc3RhbmRpbmcuIEkgZ3Vlc3MgdGhhdCBEYXZlIHdh
bnRlZCB0byBwcm9wb3NlOg0KPj4gIkVQUk9UTyBpcyBhIGxpbmsgbGV2ZWwgaXNzdWUgYW5kIG5l
ZWRzIHRvIGJlIGhhbmRsZWQgYnkgdGhlIGhvc3QgZHJpdmVyLg0KPj4gV2hlbiB0aGUgaG9zdCBk
cml2ZXIgZGV0ZWN0cyBhIHByb3RvY29sIGVycm9yIHdoaWxlIHByb2Nlc3NpbmcgYW4NCj4+IFVS
QiBpdCBTSE9VTEQgY29tcGxldGUgdGhlIFVSQiB3aXRoIEVQUk9UTyBzdGF0dXMNCj4gDQo+IFRo
ZSBob3N0IGNvbnRyb2xsZXIgZHJpdmVycyBfZG9fIGNvbXBsZXRlIFVSQnMgd2l0aCAtRVBST1RP
IChvciBzaW1pbGFyKSANCj4gc3RhdHVzIHdoZW4gYSBsaW5rLWxldmVsIGVycm9yIG9jY3Vycy4u
Lg0KPiANCj4+IGFuZCBTSE9VTEQgbWFyayB0aGUgZW5kcG9pbnQNCj4+IGFzIGhhbHRlZC4iDQo+
IA0KPiBidXQgdGhleSBkb24ndCBtYXJrIHRoZSBlbmRwb2ludCBhcyBoYWx0ZWQuICBFdmVuIGlm
IHRoZXkgZGlkLCBpdCANCj4gd291bGRuJ3QgZml4IGFueXRoaW5nIGJlY2F1c2UgdGhlIGtlcm5l
bCBhbGxvd3MgVVJCcyB0byBiZSBzdWJtaXR0ZWQgdG8gDQo+IGhhbHRlZCBlbmRwb2ludHMuICBJ
biBmYWN0LCBpdCBkb2Vzbid0IGV2ZW4ga2VlcCB0cmFjayBvZiB3aGljaCANCj4gZW5kcG9pbnRz
IGFyZSBvciBhcmUgbm90IGhhbHRlZC4NCj4gDQo+PiBJcyB0aGlzIGEgcmVhbGlzdGljIGZpeCBm
b3IgYWxsIGhvc3QgZHJpdmVycz8NCj4gDQo+IE5vLCBpdCBpc24ndC4NCj4gDQo+IEFuIGVuZHBv
aW50IHNob3VsZG4ndCBiZSBtYXJrZWQgYXMgaGFsdGVkIHVubGVzcyBpdCByZWFsbHkgaXMgaGFs
dGVkLiAgDQo+IE90aGVyd2lzZSBhIGRyaXZlciBtaWdodCBiZSB0ZW1wdGVkIHRvIGNsZWFyIHRo
ZSBIYWx0IGZlYXR1cmUsIGFuZCANCj4gc29tZSBkZXZpY2VzIGRvIG5vdCBsaWtlIHRvIHJlY2Vp
dmUgYSBDbGVhci1IYWx0IHJlcXVlc3QgZm9yIGFuIGVuZHBvaW50IA0KPiB0aGF0IGlzbid0IGhh
bHRlZC4NCj4gDQo+IFdoYXQgd2UgY291bGQgZG8gaXMgd2hhdCB5b3Ugc3VnZ2VzdGVkIGVhcmxp
ZXI6IE5vdGUgdGhlIGZhY3QgdGhhdCB0aGUgDQo+IGVuZHBvaW50IGlzIGluIHNvbWUgc29ydCBv
ZiBmYXVsdCBjb25kaXRpb24gYW5kIGRpc2FsbG93IGZ1cnRoZXIgDQo+IGNvbW11bmljYXRpb24g
d2l0aCB0aGUgZW5kcG9pbnQgdW50aWwgdGhlIGZhdWx0IGNvbmRpdGlvbiBoYXMgYmVlbiANCj4g
Y2xlYXJlZC4gIChJdCBpc24ndCBlbnRpcmVseSBvYnZpb3VzIGV4YWN0bHkgd2hhdCBhY3Rpb25z
IHNob3VsZCBjbGVhciANCj4gc3VjaCBhIGZhdWx0Li4uICBJIGd1ZXNzIHJlc2V0dGluZyBvciBy
ZS1lbmFibGluZyB0aGUgZW5kcG9pbnQsIG9yIA0KPiByZXNldHRpbmcgdGhlIGVudGlyZSBkZXZp
Y2UuKQ0KPiANCj4gQWxhbiBTdGVybg0KPiANCg0KSGkgQWxhbiwNCg0KU29ycnkgaWYgdGhpcyBk
aXZlcmdlcyBmcm9tIHRoZSB0aHJlYWQsIGJ1dCBJJ3ZlIGJlZW4gd29uZGVyaW5nIHdoZXRoZXIN
CnRvIGFkZCBhIGNoYW5nZSBmb3IgdGhpcyBhbHNvLg0KDQpGb3IgeEhDSSBob3N0cywgYWZ0ZXIg
dHJhbnNhY3Rpb25zIGVycm9ycywgdGhlIGVuZHBvaW50IHdpbGwgZW50ZXINCmhhbHRlZCBzdGF0
ZS4gVGhlIGRyaXZlciB3aWxsIGF0dGVtcHQgYSBmZXcgc29mdC1yZXRyaWVzIGJlZm9yZSBnaXZp
bmcNCnVwLiBBY2NvcmRpbmcgdG8gdGhlIHhIQ0kgc3BlYyAoc2VjdGlvbiA0LjYuOCksIGEgaG9z
dCBtYXkgc2VuZCBhDQpDbGVhckZlYXR1cmUoZW5kcG9pbnRfaGFsdCkgdG8gcmVjb3ZlciBhbmQg
cmVzdGFydCB0aGUgdHJhbnNmZXIgKHNlZQ0KInJlc2V0IGEgcGlwZSIgaW4geGhjaSBzcGVjKSwg
YW5kIHRoZSBjbGFzcyBkcml2ZXIgY2FuIGhhbmRsZSB0aGlzIGFmdGVyDQpyZWNlaXZpbmcgc29t
ZXRoaW5nIGxpa2UgLUVQUk9UTyBmcm9tIHhoY2kuDQoNCkhvd2V2ZXIsIGFzIHlvdSd2ZSBwb2lu
dGVkIG91dCwgc29tZSBkZXZpY2VzIGRvbid0IGxpa2UNCkNsZWFyRmVhdHVyZShlcF9oYWx0KSBh
bmQgbWF5IG5vdCBwcm9wZXJseSBzeW5jaHJvbml6ZSB3aXRoIHRoZSBob3N0IG9uDQp3aGVyZSBp
dCBzaG91bGQgcmVzdGFydC4NCg0KU29tZSBPUyAoc3VjaCBhcyBXaW5kb3dzKSBkbyB0aGlzLiBO
b3Qgc3VyZSBpZiB3ZSBhbHNvIHdhbnQgdGhpcz8NCkN1cnJlbnRseSB0aGUgcmVjb3ZlcnkgaXMg
anVzdCBhIHRpbWVvdXQgYW5kIGEgcG9ydCByZXNldCBmcm9tIHRoZSBjbGFzcw0KZHJpdmVyLCBi
dXQgdGhlIHRpbWVvdXQgaXMgdXN1YWxseSBkZWZhdWx0ZWQgdG8gYSBsb25nIHRpbWUgKGUuZy4g
MzANCnNlY29uZHMgZm9yIHN0b3JhZ2UgY2xhc3MgZHJpdmVyKS4NCg0KVGhhbmtzLA0KVGhpbmgN
Cg==
