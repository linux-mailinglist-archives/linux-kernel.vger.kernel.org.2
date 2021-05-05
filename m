Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EDA3733A9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 03:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhEEBvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 21:51:38 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:34744 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230451AbhEEBvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 21:51:37 -0400
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 731F6402DC;
        Wed,  5 May 2021 01:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1620179441; bh=u6Q9lOKRqRQjSxldv45MZ+CjycBZmdWaZbh4zS+5JQw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ChNh2pC+ljWmA5YopJl/hKxiqeRusTJumJRrfJAD40WBw48/KGeBwh50Om0iMHFAu
         nU8JaBfw9SHg7cymSuuTfztLYjbGoZJRFLTQLElkLaNeUFK1TA46ALJF1lev8KCeRo
         V8CJHOmoqUy9GlYG6OoY0cLTq+RUpMp0ZgCVszJMx64mop3gjiXrDJJ6khrdl8VeqT
         NF2NLJ8i1CPLwp8z4kC+/5m0NDZKHdlMx/hh10lh/zEFeTUWwWoajM20w6R89SW8+g
         ng+RAbzmDG7phI0z3/zj3+4mjnpG2lb3OVqJ1M6yncOFpkOn9qAhWRaJH73C5KswZg
         SPrSJN07gd2oQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D7641A005E;
        Wed,  5 May 2021 01:50:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 03CF9400CB;
        Wed,  5 May 2021 01:50:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="HZ05UtuF";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cS2s6g2meGWATWa+Vec4v1A9iFPWLheZXM1QTAdXIMECOoW6WqGnJn4HYE7tzJNM3Pq6lMgTyqXiPkL+dCsPicUOidAQsowSKLEkkRL8RvIjiDPlZwXe8hW5+MMHB37MyG6uYJySqRjTRDwol+OSH1zYtLa5uYNhEgn2JNR0yql65YsE77l96loOeeTj5/EdxqRlCFByBwtNa7GeCK48nbpJTU1KLv1QOt8k+wOpk52EZSaGkGtkyn5AxUBIlINVqoQsQSa4b/Gmt+C7/bvI8IhDSs3K5xUxgfM/VRdBdE5PVE82ri5RpKWjcBUgWyJaN0FTMjM46dM5keEDj3jWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6Q9lOKRqRQjSxldv45MZ+CjycBZmdWaZbh4zS+5JQw=;
 b=Msf4uFWtr6QeqS2W1rG/5ehj51CaJ5EYzZmGDjLmnBLtgLLudIjUinT9WqCQ17jUafZH/iCHedoDKtiDU6GUPp30+Xw1zDJMDKL1g+m7Ckg6BJuXgWDDI4l2aLmt0h8JHE9RFltqnAaWIjGR+UeH2TiDfc7rQ1JF6oyyeIT/K/GmaMxwhTmPWdsBscyORrxPVVbIEQshpoPIDAVnS8uxCM6l//bWtkYykTjruqKeDNim2/raN1D7euQp6xjH86yhJAyPd0mSBXrauvkh2frOCx8GkTiLsckD9Z/5523Jpwcfg9qCE8afSRnnGxUvmdhheR1a+epAg+gUplighButuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6Q9lOKRqRQjSxldv45MZ+CjycBZmdWaZbh4zS+5JQw=;
 b=HZ05UtuFQNZO1GPjjmIs30wylNGzhZtezcQZ9/0huacBwMAHbscbO6h75de626KbVmWcjSz6szfhvrkEZ+rmZicIozWyyb0Dvw50uCEzHPbggfm84xWXIzUXf8U81uQ0QhM5IJZ6SpoaEr2E64WxleqfdKEOTk32AiYWViEhkq8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 01:50:37 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 01:50:37 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request for
 queuing error
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request
 for queuing error
Thread-Index: AQHXQIPY22SwGH1kNUWWUhU4M8TqE6rSlx0AgAAHAwCAAAdWgIAABHGAgAAf5oCAADMIAIABJDgA
Date:   Wed, 5 May 2021 01:50:37 +0000
Message-ID: <aca00596-11db-398f-e0c3-4a4d50efbed5@synopsys.com>
References: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
 <5b46e4a1-93ef-2d17-048b-5b4ceba358ae@synopsys.com>
 <513e6c16-9586-c78e-881b-08e0a73c50a8@codeaurora.org>
 <e12fc396-76e6-9506-31c8-cfdee3fb7577@synopsys.com>
 <7ef627cf-3f8f-8a52-52c4-ac67ab48b87d@codeaurora.org>
 <5c06dc0a-4274-b6f0-3844-bd8afa1a59f9@synopsys.com>
 <be826457-bcd5-3dc3-0f71-faa3ac60ac63@codeaurora.org>
In-Reply-To: <be826457-bcd5-3dc3-0f71-faa3ac60ac63@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0589e543-3506-4d9a-8929-08d90f682e16
x-ms-traffictypediagnostic: BY5PR12MB4067:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4067B534580C8A821179DB4AAA599@BY5PR12MB4067.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pxAQ2mEfqDwuKFnKBHfFgWz0np1ccX4gRByXc4IiS+WTnRjGz7KkiIMLP4Q9hcBHElTUAwuEV8qtYx6uNuGyEKd5SaYLWD1buVY0xeHvqUnGTW0eEg3OjsDjB84JLFhbkea7Y0BaHxbAEi0RIqmDY82I/Z5bdC9qW1lZ94B5qFD7KrpviTkPpZBgsgSnkRjXHx/Ef/nQGJtad4giA6YpPe5e7il4VI8BVqTNKg7bljZtJVaCeDqXazEd9HduKtQdLxjQr7NMTDt98hjI705mkJaGmEAbYxhsuSCu9r4ROr3in+jRELSyzDgHzJ0iYYTcrM9+cXTcrwBnLFFpxoxqZrYAuXvm/zQOHzAoNENi0yKnfsm3ht1v2y4ta/T0O5p1CF9hk6VkuTQmmE88xRTHnMzkDnYkGNXgRLbNcSdD1t8nOmPyjC5bW5Sz1lWPIcM+IPo0Axbm4iNM3+Db2UKKe/Jg6KDLnxMET0FQTgzS1g9PFYjLfeDZmKYlaI9k+VHXSQZx2xO+HGVlyzty8GqXQa+CwVH8tud9x9ZR7xXrXao5c51GMF0n5oUU7XLYS1OEy8SmQZMLBqyNPqgamkH0Sbf/EeDrEYhMYfBMcAD+5czIkmsgqV/wJYDN7Pi9anjli4jvPvDPKGCPgNR7AaTFTB7cy1gTW+7Hj1i2BrW10fEALI4Gt9/T4G1UcCXhMPgb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(346002)(366004)(71200400001)(2616005)(31696002)(83380400001)(6486002)(6512007)(31686004)(122000001)(66476007)(54906003)(110136005)(316002)(66446008)(66556008)(5660300002)(4326008)(86362001)(66946007)(38100700002)(76116006)(8936002)(6506007)(53546011)(478600001)(8676002)(36756003)(186003)(2906002)(64756008)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZThUdXNjMU9FWWt5NlBQWmtRUFppeUsrU3c1ZU1BY2xzbUNTV284YUwzSVk0?=
 =?utf-8?B?YXVPQzdqNW9zVlBZZXU2MzJmS2lycEQwelNwUmVEMHptV0ZUakVPK2pWZGlj?=
 =?utf-8?B?S212MmVnRkZoajI5RTBmZnlPbmUxVnU1eXRac0I5MFlteVNWay8xcjlrRTda?=
 =?utf-8?B?b3M3emNBb0pMOUVsQkk5L3RwbDF0bDlFMC9vNlkzaVNYVSs5U1RaQlQrVGlI?=
 =?utf-8?B?VUxDS1ZTNmh1RW9oaWJUNXlwVnd4cFhnL2Z2NlRpT3JTc2JwMXFsM3FabjAr?=
 =?utf-8?B?Vk9NQjJDamRqazFVUCtIK3M4Tks5MGs4YjBpVmVGZkZFa3J6M0QyU3ZJVGdC?=
 =?utf-8?B?Y0lIb1lVVk9PbnliditSV0cvSWlmREw1M3daaHFEN1hkb3RJcks2TU9KSkov?=
 =?utf-8?B?N2NaVnhmeXJ0NWR0U2V3Z01KbmVuTDIwOUU2VjRCNWtrcUpINXExZjlzaWdX?=
 =?utf-8?B?UjhkRGk3aVlLam1RZ2h4ZGtyV0huN3U4VWNvMnVGblY3bnE4a3JybVQ3Z2RQ?=
 =?utf-8?B?SXYyb2ZYUzQxOUhEWHdKa3pVdmVPaGtJOUJRWVNncmNuajN3THJTZnd1Qkt1?=
 =?utf-8?B?amhPZDgxWGlacC9vSUxJa0tZcU5OQkZkcXFaekhaVmhKdkFkUUgwcUU0TFVZ?=
 =?utf-8?B?MndHWXhsb1I3OTBTTVlQeHdDK3psMnE0ZGZjbEk5WUhRYjY3d0lxUFY4UDBp?=
 =?utf-8?B?RWFzM0FPOEJ4ZWFacmQvL2hYTTAyRjRYOHBmTEVpWkY2ck15NG5ENGlHYmxJ?=
 =?utf-8?B?cy95dHo2RG5xSHVkYzVMVVpXRSs5ekdWQm9oU1B0QmVQRTZxMjFFUldFMEpP?=
 =?utf-8?B?U1MvZkFleWxtNVNYM0ppSmFadkU4S1o2ekU3ZnZmYTIwZ3RVc3dZNHhiZkx1?=
 =?utf-8?B?OURkNEgzeEYvSUVSMHIwWVpRa1hmbFU2TDV5MEdGL2J1THVZT2dwdHJlckx4?=
 =?utf-8?B?TGpDL25mUWR5eGdqM3ZzN1hOZzRva0lsYnJSdjRocW50L2lIT2ZST2tJWHdI?=
 =?utf-8?B?MVg3RzRML1dUVkxtMmQzRjlNNHhvSmlOdkpPMGpodmo1NkJwaWRWeTlNaHRj?=
 =?utf-8?B?NHo4Rmd1Z1dac0lia3ZmdnFONG90S1BKaHlBaFAwdGI4eGt0ektwemJMTUEw?=
 =?utf-8?B?MmRPdmd4MG5zSjh5TjhNdjRxSm5pVWNJMlZ2cmxRMnJOekhtSGhyZi9hcHZO?=
 =?utf-8?B?UVc1ME90U25reTZndGJoT2ozWWdlWUxTTC9vQWJWdXJsampnL0p0aENFMXBT?=
 =?utf-8?B?M2duV1lUNHFSYVp1K09xMFltd0t2Z1VXZHd6MjJQV3Y0eFdmSmVkUTFXYmdr?=
 =?utf-8?B?WnV5Mmg5SG1HQmZ1ZU0wdUsyNDlwc0VyYWFWOCtVNGtPMkpKMkRLQTNRQkdL?=
 =?utf-8?B?YVNVNTFTNG1rdGFOVWF5NS9FWk5TNDQvaTVXUlJIWjlpSnVZYUVpZzZUd1N0?=
 =?utf-8?B?RThDNmVZZmgxNm1oeE5wT2pLRFFRd1hsSlVSU2owTVpJUEVVbnZYcHBsbWFT?=
 =?utf-8?B?M1VGaWd0SmFEdWpxaXhUUWxFQjJrdy9YOFBjcXRKSTdGV3dDdUNHWXlLM2ly?=
 =?utf-8?B?dzQ2emJXTktlZmo3VUwxNHhlcmNwdFMvSnRiR2lqYk1BZUthbVpPQ08vL3No?=
 =?utf-8?B?TXZ3TUMrWnZUNFM0blJTS1JHbWlvejZlY0xKbHA2SDlhc0JsT0VWLzJ6RkNI?=
 =?utf-8?B?ZWdOOTEvNDFSMkIxSW1ySlF3SzkrREMwTlpaOEtrUFhMSDdtRUs3WXRaYm42?=
 =?utf-8?Q?kgN2l9xDLDUkP8Wjnj/BjXpUGA3+P1nM1EVqRKQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CFB4B0A4B03A54995C15D76C8C783B5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0589e543-3506-4d9a-8929-08d90f682e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 01:50:37.3170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNWDnoRznR4hUJPzL4uYDsRHpbUlptLlrWOa+0UwFolSLPTR9wGAgFVMdP9YFBjod4OESXXrxLmx4qaGgGTr6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiANCj4gDQo+IE9uIDUvMy8yMDIxIDEwOjIyIFBNLCBUaGlu
aCBOZ3V5ZW4gd3JvdGU6DQo+PiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+IE9u
IDUvMy8yMDIxIDg6MTIgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+Pj4gSGkgV2VzbGV5LA0K
Pj4+Pg0KPj4+PiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IE9uIDUv
My8yMDIxIDc6MjAgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+Pj4+PiBIaSwNCj4+Pj4+Pg0K
Pj4+Pj4+IFdlc2xleSBDaGVuZyB3cm90ZToNCj4+Pj4+Pj4gSWYgYW4gZXJyb3IgaXMgcmVjZWl2
ZWQgd2hlbiBpc3N1aW5nIGEgc3RhcnQgb3IgdXBkYXRlIHRyYW5zZmVyDQo+Pj4+Pj4+IGNvbW1h
bmQsIHRoZSBlcnJvciBoYW5kbGVyIHdpbGwgc3RvcCBhbGwgYWN0aXZlIHJlcXVlc3RzIChpbmNs
dWRpbmcNCj4+Pj4+Pj4gdGhlIGN1cnJlbnQgVVNCIHJlcXVlc3QpLCBhbmQgY2FsbCBkd2MzX2dh
ZGdldF9naXZlYmFjaygpIHRvIG5vdGlmeQ0KPj4+Pj4+PiBmdW5jdGlvbiBkcml2ZXJzIG9mIHRo
ZSByZXF1ZXN0cyB3aGljaCBoYXZlIGJlZW4gc3RvcHBlZC4gIEF2b2lkDQo+Pj4+Pj4+IGhhdmlu
ZyB0byBjYW5jZWwgdGhlIGN1cnJlbnQgcmVxdWVzdCB3aGljaCBpcyB0cnlpbmcgdG8gYmUgcXVl
dWVkLCBhcw0KPj4+Pj4+PiB0aGUgZnVuY3Rpb24gZHJpdmVyIHdpbGwgaGFuZGxlIHRoZSBFUCBx
dWV1ZSBlcnJvciBhY2NvcmRpbmdseS4NCj4+Pj4+Pj4gU2ltcGx5IHVubWFwIHRoZSByZXF1ZXN0
IGFzIGl0IHdhcyBkb25lIGJlZm9yZSwgYW5kIGFsbG93IHByZXZpb3VzbHkNCj4+Pj4+Pj4gc3Rh
cnRlZCB0cmFuc2ZlcnMgdG8gYmUgY2xlYW5lZCB1cC4NCj4+Pj4+Pj4NCj4+Pj4+DQo+Pj4+PiBI
aSBUaGluaCwNCj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBJdCBsb29rcyBsaWtlIHlvdSdyZSBzdGls
bCBsZXR0aW5nIGR3YzMgc3RvcHBpbmcgYW5kIGNhbmNlbGxpbmcgYWxsIHRoZQ0KPj4+Pj4+IGFj
dGl2ZSByZXF1ZXN0cyBpbnN0ZWFkIGxldHRpbmcgdGhlIGZ1bmN0aW9uIGRyaXZlciBkb2luZyB0
aGUgZGVxdWV1ZS4NCj4+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IFllYWgsIG1haW4gaXNzdWUgaXNuJ3Qg
ZHVlIHRvIHRoZSBmdW5jdGlvbiBkcml2ZXIgZG9pbmcgZGVxdWV1ZSwgYnV0DQo+Pj4+PiBoYXZp
bmcgY2xlYW51cCAoaWUgVVNCIHJlcXVlc3QgZnJlZSkgaWYgdGhlcmUgaXMgYW4gZXJyb3IgZHVy
aW5nDQo+Pj4+PiB1c2JfZXBfcXVldWUoKS4NCj4+Pj4+DQo+Pj4+PiBUaGUgZnVuY3Rpb24gZHJp
dmVyIGluIHF1ZXN0aW9uIGF0IHRoZSBtb21lbnQgaXMgdGhlIGZfZnMgZHJpdmVyIGluIEFJTw0K
Pj4+Pj4gbW9kZS4gIFdoZW4gYXN5bmMgSU8gaXMgZW5hYmxlZCBpbiB0aGUgRkZTIGRyaXZlciwg
ZXZlcnkgdGltZSBpdCBxdWV1ZXMNCj4+Pj4+IGEgcGFja2V0LCBpdCB3aWxsIGFsbG9jYXRlIGEg
aW9fZGF0YSBzdHJ1Y3QgYmVmb3JlaGFuZC4gIElmIHRoZQ0KPj4+Pj4gdXNiX2VwX3F1ZXVlKCkg
ZmFpbHMgaXQgd2lsbCBmcmVlIHRoaXMgaW9fZGF0YSBtZW1vcnkuICBQcm9ibGVtIGlzIHRoYXQs
DQo+Pj4+PiBzaW5jZSB0aGUgRFdDMyBnYWRnZXQgY2FsbHMgdGhlIGNvbXBsZXRpb24gd2l0aCAt
RUNPTk5SRVNFVCwgdGhlIEZGUw0KPj4+Pj4gZHJpdmVyIHdpbGwgYWxzbyBzY2hlZHVsZSBhIHdv
cmsgaXRlbSAod2l0aGluIGlvX2RhdGEgc3RydWN0KSB0byBoYW5kbGUNCj4+Pj4+IHRoZSBjb21w
bGV0aW9uLiAgU28geW91IGVuZCB1cCB3aXRoIGEgZmxvdyBsaWtlIGJlbG93DQo+Pj4+Pg0KPj4+
Pj4gYWxsb2NhdGUgaW9fZGF0YSAoZmZzKQ0KPj4+Pj4gIC0tPiB1c2JfZXBfcXVldWUoKQ0KPj4+
Pj4gICAgLS0+IF9fZHdjM19nYWRnZXRfa2lja190cmFuc2ZlcigpDQo+Pj4+PiAgICAtLT4gZHdj
M19zZW5kX2dhZGdldF9lcF9jbWQoRUlOVkFMKQ0KPj4+Pj4gICAgLS0+IGR3YzNfZ2FkZ2V0X2Vw
X2NsZWFudXBfY2FuY2VsbGVkX3JlcXVlc3RzKCkNCj4+Pj4+ICAgIC0tPiBkd2MzX2dhZGdldF9n
aXZlYmFjayhFQ09OTlJFU0VUKQ0KPj4+Pj4gZmZzIGNvbXBsZXRpb24gY2FsbGJhY2sNCj4+Pj4+
IHF1ZXVlIHdvcmsgaXRlbSB3aXRoaW4gaW9fZGF0YQ0KPj4+Pj4gIC0tPiB1c2JfZXBfcXVldWUg
cmV0dXJucyBFSU5WQUwNCj4+Pj4+IGZmcyBmcmVlcyBpb19kYXRhDQo+Pj4+PiAuLi4NCj4+Pj4+
DQo+Pj4+PiB3b3JrIHNjaGVkdWxlZA0KPj4+Pj4gIC0tPiBOVUxMIHBvaW50ZXIvbWVtb3J5IGZh
dWx0IGFzIGlvX2RhdGEgaXMgZnJlZWQNCj4+Pg0KPj4+IEhpIFRoaW5oLA0KPj4+DQo+Pj4+DQo+
Pj4+IHNvdW5kcyBsaWtlIGEgcmFjZSBpc3N1ZS4NCj4+Pj4NCj4+Pg0KPj4+IEl0J2xsIGFsd2F5
cyBoYXBwZW4gaWYgdXNiX2VwX3F1ZXVlKCkgZmFpbHMgd2l0aCBhbiBlcnJvci4gU29ycnkgZm9y
IG5vdA0KPj4+IGNsYXJpZnlpbmcsIGJ1dCB0aGUgIi4uLiIgcmVwcmVzZW50cyBleGVjdXRpbmcg
aW4gYSBkaWZmZXJlbnQgY29udGV4dA0KPj4+IDopLiBBbnl0aGluZyBhYm92ZSB0aGUgIi4uLiIg
aXMgaW4gdGhlIHNhbWUgY29udGV4dC4NCj4+Pj4+DQo+Pj4+Pj4gQlRXLCB3aGF0IGtpbmRzIG9m
IGNvbW1hbmQgYW5kIGVycm9yIGRvIHlvdSBzZWUgaW4geW91ciBzZXR1cCBhbmQgZm9yDQo+Pj4+
Pj4gd2hhdCB0eXBlIGVuZHBvaW50PyBJJ20gdGhpbmtpbmcgb2YgbGV0dGluZyB0aGUgZnVuY3Rp
b24gZHJpdmVyIHRvDQo+Pj4+Pj4gZGVxdWV1ZSB0aGUgcmVxdWVzdHMgaW5zdGVhZCBvZiBsZXR0
aW5nIGR3YzMgYXV0b21hdGljYWxseQ0KPj4+Pj4+IGVuZGluZy9jYW5jZWxsaW5nIHRoZSBxdWV1
ZWQgcmVxdWVzdHMuIEhvd2V2ZXIsIGl0J3MgYSBiaXQgdHJpY2t5IHRvIGRvDQo+Pj4+Pj4gdGhh
dCBpZiB0aGUgZXJyb3IgaXMgLUVUSU1FRE9VVCBzaW5jZSB3ZSdyZSBub3Qgc3VyZSBpZiB0aGUg
Y29udHJvbGxlcg0KPj4+Pj4+IGhhZCBhbHJlYWR5IGNhY2hlZCB0aGUgVFJCcy4NCj4+Pj4+Pg0K
Pj4+Pj4NCj4+Pj4+IEhhcHBlbnMgb24gYnVsayBFUHMgc28gZmFyLCBidXQgSSB0aGluayBpdCB3
b3VsZG4ndCBtYXR0ZXIgYXMgbG9uZyBhcw0KPj4+Pj4gaXRzIG92ZXIgdGhlIEZGUyBpbnRlcmZh
Y2UuIChhbmQgdXNpbmcgYXN5bmMgSU8gdHJhbnNmZXJzKQ0KPj4+Pg0KPj4+PiBEbyB5b3Uga25v
dyB3aGljaCBjb21tYW5kIGFuZCBlcnJvciBjb2RlPyBJdCdzIHN0cmFuZ2UgaWYNCj4+Pj4gVVBE
QVRFX1RSQU5TRkVSIGNvbW1hbmQgZmFpbGVkLg0KPj4+Pg0KPj4+DQo+Pj4gU29ycnkgZm9yIG1p
c3NpbmcgdGhhdCBwYXJ0IG9mIHRoZSBxdWVzdGlvbi4gIEl0IGlzIGEgbm8geGZlciByZXNvdXJj
ZQ0KPj4+IGVycm9yIG9uIGEgc3RhcnQgdHJhbnNmZXIgY29tbWFuZC4gIFNvIGZhciB0aGlzIGhh
cHBlbnMgb24gbG93IHN5c3RlbQ0KPj4+IG1lbW9yeSB0ZXN0IGNhc2VzLCBzbyB0aGVyZSBtYXkg
YmUgc29tZSBzZXF1ZW5jZXMgdGhhdCB3ZXJlIG1pc3NlZCwNCj4+PiB3aGljaCBsZWQgdG8gdGhp
cyBwYXJ0aWN1bGFyIGNvbW1hbmQgZXJyb3IuDQo+Pj4NCj4+PiBUaGFua3MNCj4+PiBXZXNsZXkg
Q2hlbmcNCj4gDQo+IEhpIFRoaW5oLA0KPiANCj4+DQo+PiBObyB4ZmVyIHJlc291cmNlIHVzdWFs
bHkgbWVhbnMgdGhhdCB0aGUgZHJpdmVyIGF0dGVtcHRlZCB0byBzZW5kDQo+PiBTVEFSVF9UUkFO
U0ZFUiB3aXRob3V0IHdhaXRpbmcgZm9yIEVORF9UUkFOU0ZFUiBjb21tYW5kIHRvIGNvbXBsZXRl
Lg0KPj4gVGhpcyBtYXkgYmUgYSBkd2MzIGRyaXZlciBpc3N1ZS4gRGlkIHlvdSBjaGVjayB0aGlz
Pw0KPj4NCj4+IFRoYW5rcywNCj4+IFRoaW5oDQo+Pg0KPj4NCj4gDQo+IFllcywgd2Uga25vdyB0
aGUgcmVhc29uIHdoeSB0aGlzIGhhcHBlbnMsIGFuZCBpdHMgZHVlIHRvIG9uZSBvZiB0aGUNCj4g
ZG93bnN0cmVhbSBjaGFuZ2VzIHdlIGhhZCB0aGF0IGxlZCB0byB0aGUgc2NlbmFyaW8gYWJvdmUu
ICBBbHRob3VnaCwNCj4gdGhhdCBoYXMgYmVlbiBmaXhlZCwgSSBzdGlsbCBiZWxpZXZlIHRoZSBl
cnJvciBwYXRoIGlzIGEgcG90ZW50aWFsDQo+IHNjZW5hcmlvIHdlJ2Qgc3RpbGwgd2FudCB0byBh
ZGRyZXNzLg0KPiANCj4gSSB0aGluayB0aGUgcmV0dXJuaW5nIHN1Y2Nlc3MgYWx3YXlzIG9uIGR3
YzNfZ2FkZ2V0X2VwX3F1ZXVlKCksIGFuZA0KPiBhbGxvd2luZyB0aGUgZXJyb3IgaW4gdGhlIGNv
bXBsZXRpb24gaGFuZGxlci9naXZlYmFjayBhdCB0aGUgZnVuY3Rpb24NCj4gZHJpdmVyIGxldmVs
IHRvIGRvIHRoZSBjbGVhbnVwIGlzIGEgZmVhc2libGUgc29sdXRpb24uICBEb2Vzbid0IGNoYW5n
ZQ0KPiB0aGUgZmxvdyBvZiB0aGUgRFdDMyBnYWRnZXQsIGFuZCBzbyBmYXIgYWxsIGZ1bmN0aW9u
IGRyaXZlcnMgd2UndmUgdXNlZA0KPiBoYW5kbGUgdGhpcyBpbiB0aGUgY29ycmVjdCBtYW5uZXIu
DQo+IA0KPiBUaGFua3MNCj4gV2VzbGV5IENoZW5nDQoNClJpZ2h0LiBJIHRoaW5rIGZvciBub3cg
d2Ugc2hvdWxkIGRvIHRoYXQgKHJldHVybiBzdWNjZXNzIGFsd2F5cyBleGNlcHQNCmZvciBjYXNl
cyBvZiBkaXNjb25uZWN0IG9yIGFscmVhZHkgaW4tZmxpZ2h0IGV0YykuIFRoaXMgaGVscHMga2Vl
cGluZyBpdA0Kc2ltcGxlIGFuZCBhdm9pZCBzb21lIHBpdGZhbGxzIGRlYWxpbmcgd2l0aCBnaXZp
bmcgYmFjayB0aGUgcmVxdWVzdC4NCkN1cnJlbnRseSB3ZSByZXR1cm4gdGhlIGVycm9yIHN0YXR1
cyB0byBkd2MzX2dhZGdldF9lcF9xdWV1ZSBpZiB3ZQ0KZmFpbGVkIHRvIHNlbmQgYSBjb21tYW5k
IHRoYXQgbWF5IG5vdCBldmVuIHJlbGF0ZWQgdG8gdGhlIHNhbWUgcmVxdWVzdA0KYmVpbmcgcXVl
dWVkLg0KDQpUaGlzIHdheSwgSSB0aGluayBpdCBtYXRjaGVzIHdpdGggaG93IHdlIGhhbmRsZSBp
dCBpbiB0aGUgZHJpdmVyLiBXZQ0KYWx3YXlzIHB1dCB0aGUgcmVxdWVzdCBpbiB0aGUgcGVuZGlu
ZyBsaXN0IChxdWV1ZWQpIGZpcnN0IGFuZCBwb3NzaWJseQ0Kc3RhcnQvdXBkYXRlIHRoZSBjb250
cm9sbGVyIHdpdGggbmV3IGRhdGEuDQoNClRoYW5rcywNClRoaW5oDQoNCg0KPiANCj4+Pg0KPj4+
Pj4NCj4+Pj4+PiBUaGlzIHNlZW1zIHRvIGFkZCBtb3JlIGNvbXBsZXhpdHkgYW5kIEkgZG9uJ3Qg
aGF2ZSBhIGdvb2Qgc29sdXRpb24gdG8NCj4+Pj4+PiBpdC4gU2luY2UgeW91J3JlIGFscmVhZHkg
Y2FuY2VsbGluZyBhbGwgdGhlIGFjdGl2ZSByZXF1ZXN0IGFueXdheSwgd2hhdA0KPj4+Pj4+IGRv
IHlvdSB0aGluayBvZiBhbHdheXMgbGV0dGluZyBkd2MzX2dhZGdldF9lcF9xdWV1ZSgpIHRvIGdv
IHRocm91Z2ggd2l0aA0KPj4+Pj4+IHN1Y2Nlc3MsIGJ1dCByZXBvcnQgZmFpbHVyZSB0aHJvdWdo
IHJlcXVlc3QgY29tcGxldGlvbj8NCj4+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IFdlIGRvIGhhdmUgc29t
ZXRoaW5nIHNpbWlsYXIgYXMgd2VsbCBkb3duc3RyZWFtIChyZXR1cm5pbmcgc3VjY2Vzcw0KPj4+
Pj4gYWx3YXlzIG9uIGR3YzNfZ2FkZ2V0X2VwX3F1ZXVlKCkpIGFuZCBpdHMgYmVlbiB3b3JraW5n
IGZvciB1cyBhbHNvLg0KPj4+Pj4gUHJvYmxlbSBpcyB3ZSBkb24ndCB0ZXN0IHRoZSBJU09DIHBh
dGggbXVjaCwgc28gdGhpcyBpcyB0aGUgb25seSB0eXBlIG9mDQo+Pj4+PiBFUCB0aGF0IG1pZ2h0
IGNvbWUgaW50byBxdWVzdGlvbi4uLg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gSXQgc2hvdWxkIGJlIHNp
bWlsaWFyIHdpdGggaXNvYy4gSSBjYW4ndCB0aGluayBvZiBhIHBvdGVudGlhbCBpc3N1ZSB5ZXQu
DQo+Pj4+DQo+Pj4+PiBDb21pbmcgdXAgd2l0aCBhIHdheSB0byBhZGRyZXNzIHRoZSBjb25jZXJu
cyB5b3UgYnJvdWdodCB1cCB3YXMgYSBiaXQNCj4+Pj4+IGRpZmZpY3VsdCBhcyB0aGVyZSB3ZXJl
IHNjZW5hcmlvcyB3ZSBuZWVkZWQgdG8gY29uc2lkZXIuICBuZXh0X3JlcXVlc3QoKQ0KPj4+Pj4g
ZG9lc24ndCBhbHdheXMgaGF2ZSB0byBiZSB0aGUgcmVxdWVzdCBiZWluZyBxdWV1ZWQgKGV2ZW4g
aWYgZXAgcXVldWUNCj4+Pj4+IHRyaWdnZXJlZCBpdCkuICBUaGVyZSB3YXMgbm8gZWFzeSB3YXkg
dG8gZGV0ZXJtaW5lIGlmIGtpY2sgdHJhbnNmZXIgd2FzDQo+Pj4+PiBkdWUgdG8gZXAgcXVldWUs
IGJ1dCBldmVuIGlmIHRoZXJlIHdhcywgd2UnZCBuZWVkIHRvIHJlbWVtYmVyIHRoZQ0KPj4+Pj4g
cHJldmlvdXMgcG9pbnQgYXMgd2VsbC4NCj4+Pj4+DQo+Pj4+DQo+Pj4+IFllYWgsIHRoZXJlIGFy
ZSBhIGZldyBwaXRmYWxscy4gSSBkb24ndCBoYXZlIGEgZ29vZCBzb2x1dGlvbiB0byBpdCBpZiB3
ZQ0KPj4+PiB3YW50IHRvIHJldHVybiBmYWlsdXJlIGltbWVkaWF0ZWx5IGFuZCBsZXQgdGhlIGZ1
bmN0aW9uIGRyaXZlciBoYW5kbGUNCj4+Pj4gdGhlIGRlcXVldWUgKGlmIGl0IHdhbnRzIHRvKS4N
Cj4+Pj4NCj4+Pj4gVGhhbmtzLA0KPj4+PiBUaGluaA0KPj4+Pg0KPj4+DQo+Pg0KPiANCg0K
