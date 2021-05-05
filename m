Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DC7374805
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhEEScg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 14:32:36 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:40384 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234661AbhEEScd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 14:32:33 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E484640391;
        Wed,  5 May 2021 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1620239496; bh=2us2de1YV7dU3IVZWU1vf2ArFZlvU07OO/xbR++nHNo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=a4HSXLHkF9xIg8xQ4wEtynPtC73+lrt+eq6JQtxc/9FRNWHe8Edle3PkUuaZvfZ/u
         0SI2zPaTWm+ADDVkMptiqE/Ss/7bp82IZPM+UFubyo6Occ4HoNuJLLdF4nTZi5Ucmz
         sn5T1HEYA3aS9UTl9Rl5FRO9nwbLOb957vQEmOnBzvVzao/Pglhj3qipWZHbib0a7X
         6pI3cNv+BF2DHWuDl6gJvY2lLleI82Kp3rC/u49yqCPq6NHYPgTX2E//ffNFJ2z078
         ehjxLnCSiwXsrZfwIVIGBEzJDH9QNlqH+UUdA4pSmWEwhD+t9YW4Tl2y4RcwOdRFlf
         Tp1zhqMLUE5uA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 899A5A0082;
        Wed,  5 May 2021 18:31:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 86C82400CB;
        Wed,  5 May 2021 18:31:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="MlnfbLqh";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhAG3VEe/d9TcELaCYrIvLaMuUHRupI2Bdbe4h2ExeluxnWunk4ja41XE6/I4XwBVfKFw/nVDX/cQFqN25ORttZqDgB0IqNUDLjc69btXYPGWRYwLdMAzbuoy7XQNSg4rPyuez41VSvv1b45lVYOSS3wGdG6m/bmvZweVF+B2Q5Poy2RFsn+T7DUJj7FZbe5EutFdtxuyy+xl6v0ptvIjcCxb3d3rjTtJvQfkQMjJlHTi/sPdSFqQqb1/JjxKjpCyJUIzU1NZ/4W1XjVl1o1As2iAYoCJaMIwkEYHjdtQJQIkglLMYPtmzx96S8OuBo9q4X1UHJM3xusmWYegz3gnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2us2de1YV7dU3IVZWU1vf2ArFZlvU07OO/xbR++nHNo=;
 b=Ea9iG8KwYCfDdXM3dWRI8U2Xt25qNvRNiHq4HrkflUsF40XjUr5LbUke0UOdyMR3gf0fIhEy73DBaEOmql1uQ7bQzsG4VytxFBz/m14cBlHeLjezK87+mjed5OV4i3QSHZw6fZ0e75AVWzua1DwFwfbUg9Ipu0bKVQI1Fbm53eqDNRJz+/tKM8DPWdyuWn7y0p85zE8p7H0aBOTUg4Mx746zkt79d55+NRh0pkLo9BdcKEXD41kkbpcVWh2EINeZaHW8NHXmaM/74Ir/wH8R3laE8WB2nqjSQFBhR6DuKSkdIpzx405yB2XiuU54HKjS19EETHzsbKDjYBln48WpdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2us2de1YV7dU3IVZWU1vf2ArFZlvU07OO/xbR++nHNo=;
 b=MlnfbLqhz1gVtFO+vzUNsELsOhtn015WhOU/JWI2G8IO2aSI+yvYGQ7wdTLfvx9z9Nzktz6lukhN10FXIDoWh9ptZ2aqA4gasC4+0NyAsLt297uIdUQbfpPIk+AV6Wkl4hi00S9VcivxhwYWJwzT3CbJYB62315WfxCvqxAq0lw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB3045.namprd12.prod.outlook.com (2603:10b6:a03:ac::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 18:31:31 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 18:31:31 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>
CC:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request for
 queuing error
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request
 for queuing error
Thread-Index: AQHXQIPY22SwGH1kNUWWUhU4M8TqE6rSlx0AgAAHAwCAAj0igIAAJ7uAgAA1tYA=
Date:   Wed, 5 May 2021 18:31:31 +0000
Message-ID: <400b174e-3a09-c172-462a-fdc8a5e24873@synopsys.com>
References: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
 <5b46e4a1-93ef-2d17-048b-5b4ceba358ae@synopsys.com>
 <513e6c16-9586-c78e-881b-08e0a73c50a8@codeaurora.org>
 <8735v1ibj4.fsf@kernel.org> <20210505151915.GA696631@rowland.harvard.edu>
In-Reply-To: <20210505151915.GA696631@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
authentication-results: rowland.harvard.edu; dkim=none (message not signed)
 header.d=none;rowland.harvard.edu; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a0b080b-a8ed-49b0-66e6-08d90ff40105
x-ms-traffictypediagnostic: BYAPR12MB3045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB30453A7F062EB2E31EA7FF9BAA599@BYAPR12MB3045.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QOrGVmyCYAIkqPu93JRlEZf1dJwtoJ0JhjFttdk1xKxrf6VYZnSss85Ren0lcBynyOALBavbUfGaSXmPcJvG2DkgmSHl5W63qKZVUPIA6XKWtoTZoQCjZeWwtLOz/FMyHeC7UEjAJtl4ZSoolTeUpgistgVJwgCGO7z9Ay1YBy7rxvC8HOY/mNgZ8YJ5/W4lCI5CO/HVAorZcbtYvmZsdXSYE9JwCfih682L6ckKPJmYOHDYHcWSSKU+T+Ok2BtWTKN3E9oqHaLiJSytFvf3HsiDBte0GqnwATRfazyDg7nweEO9uAMfHyAKkhhISGuRKSfyK63m+5jtxuzPdTEV4ebfRqiugzgCQ6ZTtdPSbAisXYzOQz6R79SBnhhSMAHbB20Vr9EvbndYkS6HdB/9imt2dRj9u8rGhjsQqUEIccVq9xVxHOe8BhIBI9NecwwqBaWHKKEyYQ1n7AJWyHBNzn54JlMrQnuIjAUskgbnT47kY7LxyURu3VSXU6Nm9ZOgo2Mv0bOld/5AUH/eArAcElf3vvoFlXY19znvRHby1I6xhU5dpSmRm3iv8g5quk5eD+6pQiRqU+o8S4jxlMcJwT1zXiUvnvNcicJq+EIK9Uax11at4NjdIG+fau86nyeJSE33vn9ylO9+nqfYvHb11hFunOLRJiBCNQhfRchbHkAndjaibkQ9ouAiK4eWqBVK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(346002)(136003)(366004)(376002)(396003)(186003)(2906002)(64756008)(36756003)(26005)(66946007)(76116006)(66476007)(4326008)(8936002)(83380400001)(86362001)(6512007)(5660300002)(31696002)(8676002)(122000001)(6506007)(2616005)(54906003)(66446008)(66556008)(53546011)(38100700002)(6486002)(31686004)(478600001)(316002)(71200400001)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eGlLdmJEZWU0MnpGbTBjbGxja2phYUJCWlJpM3c3MDhJSVNLK05ESU1KY2Jr?=
 =?utf-8?B?c1phNFJtT1JiMExpejlVZWhpQzl4SmhaMWNhZUtjcmpLaEZtd2RsZlNPQ0Z5?=
 =?utf-8?B?SlVNMWxSVkw1bmlicHFGNVM1b3BIaTRWSVl5TU05Mkg4eElmRmZtbDkvZWd4?=
 =?utf-8?B?aEJHa2lQc0FwVkVlZVQ1Uk5rd0crN011NEtzSkFvakRYSGg3NlpvMG1RN2Jl?=
 =?utf-8?B?MzBQVjk1OTJuS1ZaWG9FRy9rdHhTOVFWZERlY1NZQjA2QXRLRS83aU1TTDNz?=
 =?utf-8?B?UGg0aUlUZFVEQU1TY2YvMDF0U2tkTCtYMmMrUWQralp6UnppdGlxWHovYmJw?=
 =?utf-8?B?VnFYaUJ3UHdOb3VJNGx1UEJjY3VZa2lnUkZjQ3ZyZmtsdWsxUk9nK2JqZDhG?=
 =?utf-8?B?enZrdUYybXRmYXZreUM5TUlNM2FuWmh1WEpiTy8xeUxMdzFNcXdCZ1hSaGhV?=
 =?utf-8?B?R0pXVlhGUWRZajFjMmpwYXpoc2cxbDd6TzFNZ1ltRDljVVdpZFVnbDRNMGVv?=
 =?utf-8?B?d3BNb2lqdlFVeGRZOTJyOHU4bWxVYWp6KzNvK21kNEY3emlqajBSWmUreFpL?=
 =?utf-8?B?bDhqQksyTXA2NUUvRXlEVkFBS0VtS2haK09pUUZUbmZJemkyejBoVDBCT1NR?=
 =?utf-8?B?c0RsT3djSWJKU0ZnYjdZRGtseWY5a0hKaFR5NW5LTlZCWTFoY1BRYUk2Nk80?=
 =?utf-8?B?aG9Ca1lBWUp3K0c5azJBOENYNFNYVWtCRUhKN0oxYlFPakErME84eFJORVRk?=
 =?utf-8?B?S29KZmR1SFBhd2YxR1NFQ21NNTZieTF2ajdoYnJ4bTlXQTAzWUVxVDRmYzZO?=
 =?utf-8?B?bnFBM2Iya1NzbmVEZ1psbDJPd2Q1NGdibkMxY3hWZGJpUnNab1hkNmNvSFAr?=
 =?utf-8?B?bGF1dTkvVmtBeWRnZ09KQjNZMGZ1NUNaeU1Gamt5bHI3U0xsTHUwMGtSREdC?=
 =?utf-8?B?TjF2Tms0V21BeGVxSnpkeWxBandCZHg5KzlLWkZGRHBlWFczOUFSNWNwNTV4?=
 =?utf-8?B?MG9jR3V1NnlNL0FIMnUvdFJ5UzJWT0UwaWVuQTdpRFlPRU1tSGRoRWplekZn?=
 =?utf-8?B?QS9HK1FJSDQ4KzZlaE5vRWFZcFdQd1JhL0lTbFV1WVp6MXlwcjhSaVRISlNx?=
 =?utf-8?B?T0NsRDZGeERucVhnTVR5WU43ZnVuMHJDTnRuVURmV25oRUcvQXloTE02eWh3?=
 =?utf-8?B?UkZqUWJkMFJHM1JDSllKNU54VXE1Q1Z4dVdKV3JlLzBwdmZZeENNMUdvMjNz?=
 =?utf-8?B?dVd1bG9ONkpRNXJCVFJzdEJwNVhQdDFvbGtHZTlSb2ljcTJUdmtRN2J3ckpP?=
 =?utf-8?B?UXNDb2dXNXRQZ1NhTnNZeldjTE5RQ2hZN3p4S3NpZzRIeWk2SXJDZkFzSjRH?=
 =?utf-8?B?L0h2MGpGdmZ1djU0L1I1MzJwTTg1bVZaR3VhMXAxdXMwQXpLY2tlSllFbUNx?=
 =?utf-8?B?ZVM4aU1QVEhKV3lsYWMvS2VjRm1YVDV6bGFvcHZLVmRRTDZpeGlBMzhaSG1L?=
 =?utf-8?B?YUhIbEVuUkZZUFFwa0huRGhnUE0wNWRIa3l5YW5yU2EwVXE5aE83NTIrcnFG?=
 =?utf-8?B?SlVGcS9YelcrdHplb0VZRGFxbnM4OFh2eDBJK2FvTTRNTXZqSUtZSlZ2SXh5?=
 =?utf-8?B?bWJNTk83Zm9yL1JrQTJGbEVxMWE0dGhIUzc3bStHbm56ckpGVE50WnUwN1Nm?=
 =?utf-8?B?SUNrd2RqKzdCRVRqWDRWWmlyTW9lNHkzZTNSN3Nwb2N6b3N4b1BPYVpVeUJn?=
 =?utf-8?Q?mINb6Ry9+KKNXzwY/Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0A9D1E212C39B49BB506E188DEBD3E7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0b080b-a8ed-49b0-66e6-08d90ff40105
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 18:31:31.1045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e1lBWy/6TN08G998DrfSFEYyuoyUwvXmWnTj5F6NGQsG4OM/dYd4BfOR4h/g9wTWBjrT2oy2Ol+7ECc/Cn+Auw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWxhbiBTdGVybiB3cm90ZToNCj4gT24gV2VkLCBNYXkgMDUsIDIwMjEgYXQgMDM6NTc6MDNQTSAr
MDMwMCwgRmVsaXBlIEJhbGJpIHdyb3RlOg0KPj4NCj4+IEhpLA0KPj4NCj4+IFdlc2xleSBDaGVu
ZyA8d2NoZW5nQGNvZGVhdXJvcmEub3JnPiB3cml0ZXM6DQo+Pj4gT24gNS8zLzIwMjEgNzoyMCBQ
TSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4+PiBIaSwNCj4+Pj4NCj4+Pj4gV2VzbGV5IENoZW5n
IHdyb3RlOg0KPj4+Pj4gSWYgYW4gZXJyb3IgaXMgcmVjZWl2ZWQgd2hlbiBpc3N1aW5nIGEgc3Rh
cnQgb3IgdXBkYXRlIHRyYW5zZmVyDQo+Pj4+PiBjb21tYW5kLCB0aGUgZXJyb3IgaGFuZGxlciB3
aWxsIHN0b3AgYWxsIGFjdGl2ZSByZXF1ZXN0cyAoaW5jbHVkaW5nDQo+Pj4+PiB0aGUgY3VycmVu
dCBVU0IgcmVxdWVzdCksIGFuZCBjYWxsIGR3YzNfZ2FkZ2V0X2dpdmViYWNrKCkgdG8gbm90aWZ5
DQo+Pj4+PiBmdW5jdGlvbiBkcml2ZXJzIG9mIHRoZSByZXF1ZXN0cyB3aGljaCBoYXZlIGJlZW4g
c3RvcHBlZC4gIEF2b2lkDQo+Pj4+PiBoYXZpbmcgdG8gY2FuY2VsIHRoZSBjdXJyZW50IHJlcXVl
c3Qgd2hpY2ggaXMgdHJ5aW5nIHRvIGJlIHF1ZXVlZCwgYXMNCj4+Pj4+IHRoZSBmdW5jdGlvbiBk
cml2ZXIgd2lsbCBoYW5kbGUgdGhlIEVQIHF1ZXVlIGVycm9yIGFjY29yZGluZ2x5Lg0KPj4+Pj4g
U2ltcGx5IHVubWFwIHRoZSByZXF1ZXN0IGFzIGl0IHdhcyBkb25lIGJlZm9yZSwgYW5kIGFsbG93
IHByZXZpb3VzbHkNCj4+Pj4+IHN0YXJ0ZWQgdHJhbnNmZXJzIHRvIGJlIGNsZWFuZWQgdXAuDQo+
Pj4+Pg0KPj4+DQo+Pj4gSGkgVGhpbmgsDQo+Pj4NCj4+Pj4NCj4+Pj4gSXQgbG9va3MgbGlrZSB5
b3UncmUgc3RpbGwgbGV0dGluZyBkd2MzIHN0b3BwaW5nIGFuZCBjYW5jZWxsaW5nIGFsbCB0aGUN
Cj4+Pj4gYWN0aXZlIHJlcXVlc3RzIGluc3RlYWQgbGV0dGluZyB0aGUgZnVuY3Rpb24gZHJpdmVy
IGRvaW5nIHRoZSBkZXF1ZXVlLg0KPj4+Pg0KPj4+DQo+Pj4gWWVhaCwgbWFpbiBpc3N1ZSBpc24n
dCBkdWUgdG8gdGhlIGZ1bmN0aW9uIGRyaXZlciBkb2luZyBkZXF1ZXVlLCBidXQNCj4+PiBoYXZp
bmcgY2xlYW51cCAoaWUgVVNCIHJlcXVlc3QgZnJlZSkgaWYgdGhlcmUgaXMgYW4gZXJyb3IgZHVy
aW5nDQo+Pj4gdXNiX2VwX3F1ZXVlKCkuDQo+Pj4NCj4+PiBUaGUgZnVuY3Rpb24gZHJpdmVyIGlu
IHF1ZXN0aW9uIGF0IHRoZSBtb21lbnQgaXMgdGhlIGZfZnMgZHJpdmVyIGluIEFJTw0KPj4+IG1v
ZGUuICBXaGVuIGFzeW5jIElPIGlzIGVuYWJsZWQgaW4gdGhlIEZGUyBkcml2ZXIsIGV2ZXJ5IHRp
bWUgaXQgcXVldWVzDQo+Pj4gYSBwYWNrZXQsIGl0IHdpbGwgYWxsb2NhdGUgYSBpb19kYXRhIHN0
cnVjdCBiZWZvcmVoYW5kLiAgSWYgdGhlDQo+Pj4gdXNiX2VwX3F1ZXVlKCkgZmFpbHMgaXQgd2ls
bCBmcmVlIHRoaXMgaW9fZGF0YSBtZW1vcnkuICBQcm9ibGVtIGlzIHRoYXQsDQo+Pj4gc2luY2Ug
dGhlIERXQzMgZ2FkZ2V0IGNhbGxzIHRoZSBjb21wbGV0aW9uIHdpdGggLUVDT05OUkVTRVQsIHRo
ZSBGRlMNCj4+PiBkcml2ZXIgd2lsbCBhbHNvIHNjaGVkdWxlIGEgd29yayBpdGVtICh3aXRoaW4g
aW9fZGF0YSBzdHJ1Y3QpIHRvIGhhbmRsZQ0KPj4+IHRoZSBjb21wbGV0aW9uLiAgU28geW91IGVu
ZCB1cCB3aXRoIGEgZmxvdyBsaWtlIGJlbG93DQo+Pj4NCj4+PiBhbGxvY2F0ZSBpb19kYXRhIChm
ZnMpDQo+Pj4gIC0tPiB1c2JfZXBfcXVldWUoKQ0KPj4+ICAgIC0tPiBfX2R3YzNfZ2FkZ2V0X2tp
Y2tfdHJhbnNmZXIoKQ0KPj4+ICAgIC0tPiBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZChFSU5WQUwp
DQo+Pj4gICAgLS0+IGR3YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY2FuY2VsbGVkX3JlcXVlc3RzKCkN
Cj4+PiAgICAtLT4gZHdjM19nYWRnZXRfZ2l2ZWJhY2soRUNPTk5SRVNFVCkNCj4+PiBmZnMgY29t
cGxldGlvbiBjYWxsYmFjaw0KPj4+IHF1ZXVlIHdvcmsgaXRlbSB3aXRoaW4gaW9fZGF0YQ0KPj4+
ICAtLT4gdXNiX2VwX3F1ZXVlIHJldHVybnMgRUlOVkFMDQo+Pj4gZmZzIGZyZWVzIGlvX2RhdGEN
Cj4+PiAuLi4NCj4+Pg0KPj4+IHdvcmsgc2NoZWR1bGVkDQo+Pj4gIC0tPiBOVUxMIHBvaW50ZXIv
bWVtb3J5IGZhdWx0IGFzIGlvX2RhdGEgaXMgZnJlZWQNCj4gDQo+IEFtIEkgcmVhZGluZyB0aGlz
IGNvcnJlY3RseT8gIEl0IGxvb2tzIGxpa2UgdXNiX2VwX3F1ZXVlKCkgcmV0dXJucyBhIA0KPiAt
RUlOVkFMIGVycm9yLCBidXQgdGhlbiB0aGUgY29tcGxldGlvbiBjYWxsYmFjayBnZXRzIGludm9r
ZWQgd2l0aCBhIA0KPiBzdGF0dXMgb2YgLUVDT05OUkVTRVQuDQo+IA0KPj4gSSBoYXZlIHNvbWUg
dmFndWUgbWVtb3J5IG9mIGRpc2N1c3NpbmcgKHNvbWV0aGluZyBsaWtlKSB0aGlzIHdpdGggQWxh
bg0KPj4gU3Rlcm4gbG9uZyBhZ28gYW5kIHRoZSBjb25jbHVzaW9uIHdhcyB0aGF0IHRoZSBnYWRn
ZXQgZHJpdmVyIHNob3VsZA0KPj4gaGFuZGxlIGNhc2VzIHN1Y2ggYXMgdGhpcy4gDQo+IA0KPiBJ
bmRlZWQsIHRoaXMgcHJlZGF0ZXMgdGhlIGNyZWF0aW9uIG9mIHRoZSBHYWRnZXQgQVBJOyB0aGUg
c2FtZSBkZXNpZ24gDQo+IHByaW5jaXBsZSBhcHBsaWVzIHRvIHRoZSBob3N0LXNpZGUgQVBJLiAg
SXQncyBhIHZlcnkgc2ltcGxlIGlkZWE6DQo+IA0KPiAJSWYgYW4gVVJCIG9yIHVzYl9yZXF1ZXN0
IHN1Ym1pc3Npb24gc3VjY2VlZHMsIGl0IGlzIGd1YXJhbnRlZWQNCj4gCXRoYXQgdGhlIGNvbXBs
ZXRpb24gcm91dGluZSB3aWxsIGJlIGNhbGxlZCB3aGVuIHRoZSB0cmFuc2ZlciBpcw0KPiAJZmlu
aXNoZWQsIGNhbmNlbGxlZCwgYWJvcnRlZCwgb3Igd2hhdGV2ZXIgKG5vdGUgdGhhdCB0aGlzIG1h
eSANCj4gCWhhcHBlbiBiZWZvcmUgdGhlIHN1Ym1pc3Npb24gY2FsbCByZXR1cm5zKS4NCj4gDQo+
IAlJZiBhbiBVUkIgb3IgdXNiX3JlcXVlc3Qgc3VibWlzc2lvbiBmYWlscywgaXQgaXMgZ3VhcmFu
dGVlZCB0aGF0DQo+IAl0aGUgY29tcGxldGlvbiByb3V0aW5lIHdpbGwgbm90IGJlIGNhbGxlZC4N
Cj4gDQo+IFNvIGlmIGR3YzMgYmVoYXZlcyBhcyBkZXNjcmliZWQgYWJvdmUgKHVzYl9lcF9xdWV1
ZSgpIGZhaWxzIF9hbmRfIHRoZSANCj4gY29tcGxldGlvbiBoYW5kbGVyIGlzIGNhbGxlZCksIHRo
aXMgaXMgYSBidWcuDQo+IA0KPiBBbGFuIFN0ZXJuDQo+IA0KDQoNCkhpIEFsYW4sDQoNClllcywg
aXQncyBhIGJ1Zywgbm8gcXVlc3Rpb24gYWJvdXQgdGhhdC4gVGhlIGNvbmNlcm4gaGVyZSBpcyBo
b3cgc2hvdWxkDQp3ZSBmaXggaXQuDQoNCkluIGR3YzMsIHdoZW4gdGhlIHVzYl9lcF9xdWV1ZSgp
IGlzIGNhbGxlZCwgaXQgZG9lcyAzIG1haW4gdGhpbmdzOg0KMSkgUHV0IHRoZSByZXF1ZXN0IGlu
IGEgcGVuZGluZyBsaXN0IHRvIGJlIHByb2Nlc3NlZA0KMikgUHJvY2VzcyBhbnkgc3RhcnRlZCBi
dXQgcGFydGlhbGx5IHByb2Nlc3NlZCByZXF1ZXN0IGFuZCBhbnkNCm91dHN0YW5kaW5nIHJlcXVl
c3QgZnJvbSB0aGUgcGVuZGluZyBsaXN0IGFuZCBtYXAgdGhlbSB0byBUUkJzDQozKSBTZW5kIGEg
Y29tbWFuZCB0byB0aGUgY29udHJvbGxlciB0ZWxsaW5nIGl0IHRvIGNhY2hlIGFuZCBwcm9jZXNz
DQp0aGVzZSBuZXcgVFJCcw0KDQpDdXJyZW50bHksIGlmIHN0ZXAgMykgZmFpbHMsIHRoZW4gdXNi
X2VwX3F1ZXVlKCkgcmV0dXJucyBhbiBlcnJvciBzdGF0dXMNCmFuZCB3ZSBzdG9wIHRoZSBjb250
cm9sbGVyIGZyb20gcHJvY2Vzc2luZyBUUkJzIGFuZCByZXR1cm4gYW55IHJlcXVlc3QNCnJlbGF0
ZWQgdG8gdGhvc2Ugb3V0c3RhbmRpbmcgVFJCcy4gVGhpcyBpcyBhIGJ1Zy4NCg0KTXkgc3VnZ2Vz
dGlvbiBoZXJlIGlzIGRvbid0IGltbWVkaWF0ZWx5IHJldHVybiBhbiBlcnJvciBjb2RlIGFuZCBs
ZXQgdGhlDQpjb21wbGV0aW9uIGludGVycnVwdCBpbmZvcm0gb2YgYSB0cmFuc2ZlciBmYWlsdXJl
LiBUaGUgcmVhc29ucyBhcmU6DQoNCmEpIFN0ZXAgMykgaGFwcGVuZWQgd2hlbiB0aGUgcmVxdWVz
dCBpcyBhbHJlYWR5IChhcmd1YWJseSkgcXVldWVkLg0KYikgSWYgdGhlIGVycm9yIGZyb20gc3Rl
cCAzKSBpcyBkdWUgdG8gY29tbWFuZCB0aW1lZCBvdXQsIHRoZSBjb250cm9sbGVyDQptYXkgaGF2
ZSBwYXJ0aWFsbHkgY2FjaGVkL3Byb2Nlc3NlZCBzb21lIG9mIHRoZXNlIFRSQnMuIFdlIGNhbid0
IHNpbXBseQ0KZ2l2ZSBiYWNrIHRoZSByZXF1ZXN0IGltbWVkaWF0ZWx5IHdpdGhvdXQgc3RvcHBp
bmcgdGhlIHRyYW5zZmVyIGFuZCBmYWlsDQphbGwgdGhlIGluLWZsaWdodCByZXF1ZXN0Lg0KYykg
SXQgYWRkcyB1bm5lY2Vzc2FyeSBjb21wbGV4aXR5IHRvIHRoZSBkcml2ZXIgYW5kIHRoZXJlIGFy
ZSBhIGZldw0KcGl0ZmFsbHMgdGhhdCB3ZSBoYXZlIHRvIHdhdGNoIG91dCBmb3Igd2hlbiBoYW5k
bGluZyBnaXZpbmcgYmFjayB0aGUNCnJlcXVlc3QuDQpkKSBFeGNlcHQgdGhlIGNhc2Ugd2hlcmUg
dGhlIGRldmljZSBpcyBkaXNjb25uZWN0ZWQgb3IgdGhhdCB0aGUgcmVxdWVzdA0KaXMgYWxyZWFk
eSBpbi1mbGlnaHQsIHN0ZXAgMSkgYW5kIDIpIGFyZSBhbHdheXMgZG9uZSBhZnRlcg0KdXNiX2Vw
X3F1ZXVlKCkuIFRoZSBjb250cm9sbGVyIGRyaXZlciBhbHJlYWR5IG93bnMgdGhlc2UgcmVxdWVz
dHMgYW5kDQpjYW4gYmUgY29uc2lkZXJlZCAicXVldWVkIi4NCg0KSWYgb3VyIGRlZmluaXRpb24g
d2hldGhlciBhIHJlcXVlc3QgaXMgInF1ZXVlZCIgbXVzdCBiZSBhIGNvbWJpbmF0aW9uIG9mDQph
bGwgdGhvc2UgMyBzdGVwcywgdGhlbiBteSBzdWdnZXN0aW9uIGlzIG5vdCBlbm91Z2ggYW5kIHdl
J2QgaGF2ZSB0bw0KZXhwbG9yZSBvdGhlciBvcHRpb25zLg0KDQpOb3RlIHRoYXQgd2UgYWxyZWFk
eSBoYW5kbGUgaXQgdGhpcyB3YXkgZm9yIGlzb2MgdGhpcyB3YXkuIFdlIGRvbid0IHNlbmQNCnRo
ZSBTVEFSVF9UUkFOU0ZFUiBjb21tYW5kIGltbWVkaWF0ZWx5IGFuZCBjb25zaWRlciB0aGUgcmVx
dWVzdHMgdG8gYmUNCnF1ZXVlZCBpbiB0aGUgdXNiX2VwX3F1ZXVlKCkuIFNvIGhlcmUgd2UncmUg
anVzdCBleHRlbmRpbmcgdGhpcyB0byBvdGhlcg0KZW5kcG9pbnRzIHRvby4NCg0KVGhhbmtzLA0K
VGhpbmgNCg==
