Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CCC3759F6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 20:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhEFSHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 14:07:51 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:48100 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229633AbhEFSHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 14:07:49 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 00474C00AA;
        Thu,  6 May 2021 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1620324411; bh=jsedNeVX2jLI580wGuIDfNTy88FTn3WCAF0DzWjztTI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WJgABFCmKeVQKLPqzCgc+JCWbGhx3xXhn1U2zWehOLH4fM08xyWKER9hjgWiqSZYE
         DtZ01R7Qh80HXIRFY/91bQic7W+GcpeOOxe3pxqo7M1n901v9GtQUbYvjxxjgbM1CH
         Qo+zP9Lbq+k7QKJwg+qxRzYhXW45O9vd8gnKEjRnouwaFnzKKwJVGLFaMsRXX8mLDx
         yhuBmwG/AvwsFA2nQfOuNchMwCiTJ1BaHE7Q3q4bExYQhMRzYtrHHjOGYWX9TDqnF3
         Ui0Xib4NZ//EysRxXf8A1Iy/RI1XIjhrGDZYNuDnA4YwCnLRRtDJK6pk+p1m10PhSx
         Gt6isCzjI4c9w==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id DAA44A0064;
        Thu,  6 May 2021 18:06:49 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 76ECE80292;
        Thu,  6 May 2021 18:06:48 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="C6nwAGrn";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmGU0Vh0z6JDLUvBLdfRIi7fGDMFpBP53mOPKUPEU1ItYMGOPoRs3sqoTrnG7ybyZNHuoKM5UHbbV4UZGYCovwVBqxMVL9zWECrOyPLFGVneWNj0A/9YEgDQeYk0JHtS8UR2WnknWddO9jABaBwr1emKbqWzVp4cU1suB8V9NEcx86T5QrTKkjdFCIlMWcQJlBvCfF2IN1C+uJvaj0AaeY/rkZRKP703wBGZ8j/yXSBAduQHoGOFQFeiRWFhMiE2+urDxPzVdtAl5vkssNx45a3a5NfRRBMLDXvIEV8p20PlZPDHjyEpqK3w2NK7Q5rCWCUuSx8F5vwOb5wADxYMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsedNeVX2jLI580wGuIDfNTy88FTn3WCAF0DzWjztTI=;
 b=oFZzuWcFktyf9xFR8Mmbb74FYrCEaPvLGeu0iYUBjcH/MZy5biBmsPB/6o3JWnX+dcinuRJCgWCoTiRyYCfGeaA2OAvjDTagXG6r1TIXQsCRnUo2VgQejU8stE+ALWP/q3otl5j12oFMuCDqC0qOK3MlVeE6mchwJJP0qp6KctHS5OsP4TAH5Eq/C7lVn9rpltGyFqRQNgEDwY+nPIx7cfd2RdosLBhN1WQQW3gq/AX9J6znZ0ena7x1IVz4kllYrofii7LzjGl3AbSuIEhQkwIWzLckzbpaDtl02Lc9qbP/YN+PJOWN4H3pXhpvuz7dRcPql+kFxdPo4d18IoL0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsedNeVX2jLI580wGuIDfNTy88FTn3WCAF0DzWjztTI=;
 b=C6nwAGrn44CYkR4+0qAn2riqe96m9U6AkBE4DL2PJRMYF3bfxaCHc3WNwGK4d16bon/ZMU1G6Nd3LtXZExGoyYqpr9w119qgRowgO1mfLuwvFDnvgxTAKrYLQcpcFr1HPfI8jmVBUgGcoXOBg9NYizTbw+npUvEBvTEMvDguek4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2632.namprd12.prod.outlook.com (2603:10b6:a03:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Thu, 6 May
 2021 18:06:46 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.4108.027; Thu, 6 May 2021
 18:06:46 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Wesley Cheng <wcheng@codeaurora.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request for
 queuing error
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request
 for queuing error
Thread-Index: AQHXQIPY22SwGH1kNUWWUhU4M8TqE6rSlx0AgAAHAwCAAj0igIAAJ7uAgAA1tYCAAPP7gIAAl3AA
Date:   Thu, 6 May 2021 18:06:46 +0000
Message-ID: <1f0138ea-baac-4006-6deb-95131da7cca6@synopsys.com>
References: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
 <5b46e4a1-93ef-2d17-048b-5b4ceba358ae@synopsys.com>
 <513e6c16-9586-c78e-881b-08e0a73c50a8@codeaurora.org>
 <8735v1ibj4.fsf@kernel.org> <20210505151915.GA696631@rowland.harvard.edu>
 <400b174e-3a09-c172-462a-fdc8a5e24873@synopsys.com>
 <87o8dogrmc.fsf@kernel.org>
In-Reply-To: <87o8dogrmc.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 277d35ad-168d-4d76-1615-08d910b9b648
x-ms-traffictypediagnostic: BYAPR12MB2632:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2632DF30271733FCBE18CD0AAA589@BYAPR12MB2632.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: afVERAiC8GgP7Zg6NjuNYhvvU1MXNIG/7WY0tOVuxHZy8XxnHvw/QpWj3CQF3U93nHmKZPMC0cqd1yYxjNFOs78hu2WoeK11wtzXNYsL4h+PZmTdjA9A2IKQb8I2H1GnxDtmBQjdUY/ocncVKzhBuX254aXxTPFQz1OAnREPNQl6gXWpYKTa8+o+5Ss1G5fZLD1/UD0beKtwiceTN8JJA5hBddUwHrAvB1d8DniTAyLiyFSw1iplWNeQ+uPwifyDioCKkDIIMxBzqIYeYSLGM4OSQutAKtegrJ6hY3kpu4fFSk8q8PnJkma48gsy2D6iDZD5DoZQX9ZC/hlDgZSl0ICx4kzLFZ+GARvHXQXHr7S2co3PUMGQij2iT0zVidZhY7zx/tanjEJqyTds4oFMIiwdn0ckeEaMOPbUzBlxCG4jfl2QxKfPVrRkSqbHPBMC+rIIFucXfcQ7+Fv7xgPWU5NC+Mq91y8OlZzsqXlHxklVF209P1AS6z8aI6Oi3Xmjtl1Dal+FhhnNVDtvb4qjDq0y2j4IwDU5ryJvriG2bsk5Kg4nSTJUwvqtnrxddpKARJ9LTBTxL3kZGoUgMvSgJ64O1apLOvbysLzTZeKZGCw9F8FSSfDNQfrmeI4Cc/4Yp9A5WWtldbBXtTKmkZWeaHr/2YBD69wfDbL6wwovCz4MW2OUMMnP1v55NLMkyJJ9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(366004)(396003)(376002)(346002)(136003)(5660300002)(66446008)(8676002)(4326008)(2616005)(71200400001)(66946007)(478600001)(316002)(110136005)(31686004)(66476007)(36756003)(54906003)(2906002)(83380400001)(122000001)(6512007)(76116006)(26005)(31696002)(86362001)(38100700002)(6506007)(66556008)(8936002)(6486002)(53546011)(64756008)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TnBUZ2tKYUdMNkVFeWdZUXRhaldBMUQvUHNyaUV5bnJGaElOMmVGZ2U5aWtZ?=
 =?utf-8?B?cTFDdUNrRnN6c1A5SGtCd1dJclBMa20xWWpxM3JvcGhWUWxaSjdWU0Z1ZmZp?=
 =?utf-8?B?Y2k5NTd4aEh4akd4cEtVMGFTTHRTOGw5cEplOHB6UnhWNUtYYXJ4N09YUkU2?=
 =?utf-8?B?YUVVbHZEVGRhcVdHZUxjMkRiV0dCRnA5UEtBa2hicXgrRW9rWEtlNjYxVWg1?=
 =?utf-8?B?ZmQ4emowWjRwb3ZYUXJac1JCeG5GUEJzNlBQUFFneHdMbVlYcGM5Z1l0S0p2?=
 =?utf-8?B?aGxDYUJYMkRYa3FlV2t3eXpYTFZmZHhtT2RqdjYyc2U4bzhjZlBCSEt4NCtN?=
 =?utf-8?B?bDIvUFE3dlRwU211Ylcvc2JhdURQNnAxRmVCWW9sUnB6NDNkcUduYkRqaFZ0?=
 =?utf-8?B?NTA0WnBRMi9HYlI2MkhPSmdlaWlLQWhQNjgvNXFNYlZuNzhRSFZNby9oYkUz?=
 =?utf-8?B?amhlOWkxS3ZVSlZUbVFxcityaTczUzEvSWpvNkt3ZzJFaWJxQVgremZrTjBZ?=
 =?utf-8?B?TmpqZWxrZTFvTm5uV1g0V2svMVgreU5xOGtEcmlaZjByZjFFYllnZDVXcWlE?=
 =?utf-8?B?NVpLMXo5Y0lRVjdZUnJRMzhwdzFZMHBCQ2EwUWh0NmNsVzFqeEwwb2s5V3FL?=
 =?utf-8?B?TloxUWgrUXFBcWFSNTI5cGhtT0thb21NUnFIUVhvMWJtcTMyV3F2Tjk0UlRk?=
 =?utf-8?B?ZFllSFN1NUVzZzV6eEs3L2lzR1Jvc3JJbld6T1B5cTNzSXpGUHZjTDZpTS9T?=
 =?utf-8?B?U2FOVi80dnErYTdsei9OaFhDY2k0MDg4cUk3dzJIenZVQnJyRlhwdW9hemVT?=
 =?utf-8?B?VmZUeW1PNmpDYWJqdWtmN1gyRkJZODF4YVZja1BJVE5ZSyt4blFwQ2MzR0dt?=
 =?utf-8?B?dEFqREdJWkF6M0NqT3A3akFMeEE5WXB5bTh3ZHFwbnRTN1BKVGxVcldjbmwy?=
 =?utf-8?B?Y3RjWUVvbWU5MnRtekxZb0pyUTR5SW5rNEcxVW9yWlIxenJZZjJKbytBbGhZ?=
 =?utf-8?B?am9XMFM0WnhRUWErSXY1NGRkZ3pSdDE3dHAyQVFJRXd0eVRWb1VSMTgwSWRY?=
 =?utf-8?B?TW5VU0pRQjYrdDZMbTRHZTZYbytocUtNSjNXditPS3BVREd2UmhnNW5hbnRh?=
 =?utf-8?B?bXNjdzBIQjA4QXROUFRqWjNZbmJuWWswQWpBL080cWYwdFp3OXJnTnlFWVpX?=
 =?utf-8?B?d0JiWjBpbExaeFBRN2Roa0VULzhWUEYxMUFFRG1qc0dMa2h1byt1c3QxN1Ax?=
 =?utf-8?B?cDVBUzJDMlFhWHYwdWpRVzFBcEkranRJNjRQUkJaRTlyVTl1MG4vTjM5TlhD?=
 =?utf-8?B?b1hrQzNWS3JrWXYwK0lRN2dUK2gxNVVjM3gzdGtMS0hIQkxkbXV4bmZNOXNu?=
 =?utf-8?B?TlhLS2lLVUNwVXVJZVJVS1BWUGQzNlRwVE9mZ0J2emFiNFEzd3hONXZjalVz?=
 =?utf-8?B?ZHQ4UGcvZUlXUTZFMGxoNkVxRlJ5TExaNFRaNHA1dndIWS94V2l5NWVlbFhp?=
 =?utf-8?B?MEZpK29VWExuQ3EwSHlmcHFmY3h6NnMxbGtSMG9lYTBOQ0FSMTUzdVB2cC9K?=
 =?utf-8?B?MjFxcHc1ZHpQODVhUDFjRzJGOS9HUUt2eFdvQVNRRG4zSWxWd3pTa3hjbXlj?=
 =?utf-8?B?U2xPM1RCa3cxRURzcmZ1Y3VZWmQrTnhSRDVXeWNrNlAxemU0d2JGZGdZQW1a?=
 =?utf-8?B?NnRCWHk1SlZreHhPR1JwbFRGV3JzTlBpa1M4cHMwR3g4UkZ3bnJTL09kdDMx?=
 =?utf-8?Q?xX0yRhW901zEp3SKbc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D57FBC50A4EA943B7F7F0096A90DDE5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277d35ad-168d-4d76-1615-08d910b9b648
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 18:06:46.0778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbpvp6tSeUuyXzLunt3vjzEGqzuIAKzXK8fDYbadD846g+Gnkgjvk2qpqkZ6IosCcAMvHQPpq6VeQMfIFLHvPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2632
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RmVsaXBlIEJhbGJpIHdyb3RlOg0KPiANCj4gSGksDQo+IA0KPiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+IHdyaXRlczoNCj4+IEFsYW4gU3Rlcm4gd3JvdGU6DQo+Pj4g
T24gV2VkLCBNYXkgMDUsIDIwMjEgYXQgMDM6NTc6MDNQTSArMDMwMCwgRmVsaXBlIEJhbGJpIHdy
b3RlOg0KPj4+Pg0KPj4+PiBIaSwNCj4+Pj4NCj4+Pj4gV2VzbGV5IENoZW5nIDx3Y2hlbmdAY29k
ZWF1cm9yYS5vcmc+IHdyaXRlczoNCj4+Pj4+IE9uIDUvMy8yMDIxIDc6MjAgUE0sIFRoaW5oIE5n
dXllbiB3cm90ZToNCj4+Pj4+PiBIaSwNCj4+Pj4+Pg0KPj4+Pj4+IFdlc2xleSBDaGVuZyB3cm90
ZToNCj4+Pj4+Pj4gSWYgYW4gZXJyb3IgaXMgcmVjZWl2ZWQgd2hlbiBpc3N1aW5nIGEgc3RhcnQg
b3IgdXBkYXRlIHRyYW5zZmVyDQo+Pj4+Pj4+IGNvbW1hbmQsIHRoZSBlcnJvciBoYW5kbGVyIHdp
bGwgc3RvcCBhbGwgYWN0aXZlIHJlcXVlc3RzIChpbmNsdWRpbmcNCj4+Pj4+Pj4gdGhlIGN1cnJl
bnQgVVNCIHJlcXVlc3QpLCBhbmQgY2FsbCBkd2MzX2dhZGdldF9naXZlYmFjaygpIHRvIG5vdGlm
eQ0KPj4+Pj4+PiBmdW5jdGlvbiBkcml2ZXJzIG9mIHRoZSByZXF1ZXN0cyB3aGljaCBoYXZlIGJl
ZW4gc3RvcHBlZC4gIEF2b2lkDQo+Pj4+Pj4+IGhhdmluZyB0byBjYW5jZWwgdGhlIGN1cnJlbnQg
cmVxdWVzdCB3aGljaCBpcyB0cnlpbmcgdG8gYmUgcXVldWVkLCBhcw0KPj4+Pj4+PiB0aGUgZnVu
Y3Rpb24gZHJpdmVyIHdpbGwgaGFuZGxlIHRoZSBFUCBxdWV1ZSBlcnJvciBhY2NvcmRpbmdseS4N
Cj4+Pj4+Pj4gU2ltcGx5IHVubWFwIHRoZSByZXF1ZXN0IGFzIGl0IHdhcyBkb25lIGJlZm9yZSwg
YW5kIGFsbG93IHByZXZpb3VzbHkNCj4+Pj4+Pj4gc3RhcnRlZCB0cmFuc2ZlcnMgdG8gYmUgY2xl
YW5lZCB1cC4NCj4+Pj4+Pj4NCj4+Pj4+DQo+Pj4+PiBIaSBUaGluaCwNCj4+Pj4+DQo+Pj4+Pj4N
Cj4+Pj4+PiBJdCBsb29rcyBsaWtlIHlvdSdyZSBzdGlsbCBsZXR0aW5nIGR3YzMgc3RvcHBpbmcg
YW5kIGNhbmNlbGxpbmcgYWxsIHRoZQ0KPj4+Pj4+IGFjdGl2ZSByZXF1ZXN0cyBpbnN0ZWFkIGxl
dHRpbmcgdGhlIGZ1bmN0aW9uIGRyaXZlciBkb2luZyB0aGUgZGVxdWV1ZS4NCj4+Pj4+Pg0KPj4+
Pj4NCj4+Pj4+IFllYWgsIG1haW4gaXNzdWUgaXNuJ3QgZHVlIHRvIHRoZSBmdW5jdGlvbiBkcml2
ZXIgZG9pbmcgZGVxdWV1ZSwgYnV0DQo+Pj4+PiBoYXZpbmcgY2xlYW51cCAoaWUgVVNCIHJlcXVl
c3QgZnJlZSkgaWYgdGhlcmUgaXMgYW4gZXJyb3IgZHVyaW5nDQo+Pj4+PiB1c2JfZXBfcXVldWUo
KS4NCj4+Pj4+DQo+Pj4+PiBUaGUgZnVuY3Rpb24gZHJpdmVyIGluIHF1ZXN0aW9uIGF0IHRoZSBt
b21lbnQgaXMgdGhlIGZfZnMgZHJpdmVyIGluIEFJTw0KPj4+Pj4gbW9kZS4gIFdoZW4gYXN5bmMg
SU8gaXMgZW5hYmxlZCBpbiB0aGUgRkZTIGRyaXZlciwgZXZlcnkgdGltZSBpdCBxdWV1ZXMNCj4+
Pj4+IGEgcGFja2V0LCBpdCB3aWxsIGFsbG9jYXRlIGEgaW9fZGF0YSBzdHJ1Y3QgYmVmb3JlaGFu
ZC4gIElmIHRoZQ0KPj4+Pj4gdXNiX2VwX3F1ZXVlKCkgZmFpbHMgaXQgd2lsbCBmcmVlIHRoaXMg
aW9fZGF0YSBtZW1vcnkuICBQcm9ibGVtIGlzIHRoYXQsDQo+Pj4+PiBzaW5jZSB0aGUgRFdDMyBn
YWRnZXQgY2FsbHMgdGhlIGNvbXBsZXRpb24gd2l0aCAtRUNPTk5SRVNFVCwgdGhlIEZGUw0KPj4+
Pj4gZHJpdmVyIHdpbGwgYWxzbyBzY2hlZHVsZSBhIHdvcmsgaXRlbSAod2l0aGluIGlvX2RhdGEg
c3RydWN0KSB0byBoYW5kbGUNCj4+Pj4+IHRoZSBjb21wbGV0aW9uLiAgU28geW91IGVuZCB1cCB3
aXRoIGEgZmxvdyBsaWtlIGJlbG93DQo+Pj4+Pg0KPj4+Pj4gYWxsb2NhdGUgaW9fZGF0YSAoZmZz
KQ0KPj4+Pj4gIC0tPiB1c2JfZXBfcXVldWUoKQ0KPj4+Pj4gICAgLS0+IF9fZHdjM19nYWRnZXRf
a2lja190cmFuc2ZlcigpDQo+Pj4+PiAgICAtLT4gZHdjM19zZW5kX2dhZGdldF9lcF9jbWQoRUlO
VkFMKQ0KPj4+Pj4gICAgLS0+IGR3YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY2FuY2VsbGVkX3JlcXVl
c3RzKCkNCj4+Pj4+ICAgIC0tPiBkd2MzX2dhZGdldF9naXZlYmFjayhFQ09OTlJFU0VUKQ0KPj4+
Pj4gZmZzIGNvbXBsZXRpb24gY2FsbGJhY2sNCj4+Pj4+IHF1ZXVlIHdvcmsgaXRlbSB3aXRoaW4g
aW9fZGF0YQ0KPj4+Pj4gIC0tPiB1c2JfZXBfcXVldWUgcmV0dXJucyBFSU5WQUwNCj4+Pj4+IGZm
cyBmcmVlcyBpb19kYXRhDQo+Pj4+PiAuLi4NCj4+Pj4+DQo+Pj4+PiB3b3JrIHNjaGVkdWxlZA0K
Pj4+Pj4gIC0tPiBOVUxMIHBvaW50ZXIvbWVtb3J5IGZhdWx0IGFzIGlvX2RhdGEgaXMgZnJlZWQN
Cj4+Pg0KPj4+IEFtIEkgcmVhZGluZyB0aGlzIGNvcnJlY3RseT8gIEl0IGxvb2tzIGxpa2UgdXNi
X2VwX3F1ZXVlKCkgcmV0dXJucyBhIA0KPj4+IC1FSU5WQUwgZXJyb3IsIGJ1dCB0aGVuIHRoZSBj
b21wbGV0aW9uIGNhbGxiYWNrIGdldHMgaW52b2tlZCB3aXRoIGEgDQo+Pj4gc3RhdHVzIG9mIC1F
Q09OTlJFU0VULg0KPj4+DQo+Pj4+IEkgaGF2ZSBzb21lIHZhZ3VlIG1lbW9yeSBvZiBkaXNjdXNz
aW5nIChzb21ldGhpbmcgbGlrZSkgdGhpcyB3aXRoIEFsYW4NCj4+Pj4gU3Rlcm4gbG9uZyBhZ28g
YW5kIHRoZSBjb25jbHVzaW9uIHdhcyB0aGF0IHRoZSBnYWRnZXQgZHJpdmVyIHNob3VsZA0KPj4+
PiBoYW5kbGUgY2FzZXMgc3VjaCBhcyB0aGlzLiANCj4+Pg0KPj4+IEluZGVlZCwgdGhpcyBwcmVk
YXRlcyB0aGUgY3JlYXRpb24gb2YgdGhlIEdhZGdldCBBUEk7IHRoZSBzYW1lIGRlc2lnbiANCj4+
PiBwcmluY2lwbGUgYXBwbGllcyB0byB0aGUgaG9zdC1zaWRlIEFQSS4gIEl0J3MgYSB2ZXJ5IHNp
bXBsZSBpZGVhOg0KPj4+DQo+Pj4gCUlmIGFuIFVSQiBvciB1c2JfcmVxdWVzdCBzdWJtaXNzaW9u
IHN1Y2NlZWRzLCBpdCBpcyBndWFyYW50ZWVkDQo+Pj4gCXRoYXQgdGhlIGNvbXBsZXRpb24gcm91
dGluZSB3aWxsIGJlIGNhbGxlZCB3aGVuIHRoZSB0cmFuc2ZlciBpcw0KPj4+IAlmaW5pc2hlZCwg
Y2FuY2VsbGVkLCBhYm9ydGVkLCBvciB3aGF0ZXZlciAobm90ZSB0aGF0IHRoaXMgbWF5IA0KPj4+
IAloYXBwZW4gYmVmb3JlIHRoZSBzdWJtaXNzaW9uIGNhbGwgcmV0dXJucykuDQo+Pj4NCj4+PiAJ
SWYgYW4gVVJCIG9yIHVzYl9yZXF1ZXN0IHN1Ym1pc3Npb24gZmFpbHMsIGl0IGlzIGd1YXJhbnRl
ZWQgdGhhdA0KPj4+IAl0aGUgY29tcGxldGlvbiByb3V0aW5lIHdpbGwgbm90IGJlIGNhbGxlZC4N
Cj4+Pg0KPj4+IFNvIGlmIGR3YzMgYmVoYXZlcyBhcyBkZXNjcmliZWQgYWJvdmUgKHVzYl9lcF9x
dWV1ZSgpIGZhaWxzIF9hbmRfIHRoZSANCj4+PiBjb21wbGV0aW9uIGhhbmRsZXIgaXMgY2FsbGVk
KSwgdGhpcyBpcyBhIGJ1Zy4NCj4+Pg0KPj4+IEFsYW4gU3Rlcm4NCj4+Pg0KPj4NCj4+DQo+PiBI
aSBBbGFuLA0KPj4NCj4+IFllcywgaXQncyBhIGJ1Zywgbm8gcXVlc3Rpb24gYWJvdXQgdGhhdC4g
VGhlIGNvbmNlcm4gaGVyZSBpcyBob3cgc2hvdWxkDQo+PiB3ZSBmaXggaXQuDQo+Pg0KPj4gSW4g
ZHdjMywgd2hlbiB0aGUgdXNiX2VwX3F1ZXVlKCkgaXMgY2FsbGVkLCBpdCBkb2VzIDMgbWFpbiB0
aGluZ3M6DQo+PiAxKSBQdXQgdGhlIHJlcXVlc3QgaW4gYSBwZW5kaW5nIGxpc3QgdG8gYmUgcHJv
Y2Vzc2VkDQo+PiAyKSBQcm9jZXNzIGFueSBzdGFydGVkIGJ1dCBwYXJ0aWFsbHkgcHJvY2Vzc2Vk
IHJlcXVlc3QgYW5kIGFueQ0KPj4gb3V0c3RhbmRpbmcgcmVxdWVzdCBmcm9tIHRoZSBwZW5kaW5n
IGxpc3QgYW5kIG1hcCB0aGVtIHRvIFRSQnMNCj4+IDMpIFNlbmQgYSBjb21tYW5kIHRvIHRoZSBj
b250cm9sbGVyIHRlbGxpbmcgaXQgdG8gY2FjaGUgYW5kIHByb2Nlc3MNCj4+IHRoZXNlIG5ldyBU
UkJzDQo+Pg0KPj4gQ3VycmVudGx5LCBpZiBzdGVwIDMpIGZhaWxzLCB0aGVuIHVzYl9lcF9xdWV1
ZSgpIHJldHVybnMgYW4gZXJyb3Igc3RhdHVzDQo+PiBhbmQgd2Ugc3RvcCB0aGUgY29udHJvbGxl
ciBmcm9tIHByb2Nlc3NpbmcgVFJCcyBhbmQgcmV0dXJuIGFueSByZXF1ZXN0DQo+PiByZWxhdGVk
IHRvIHRob3NlIG91dHN0YW5kaW5nIFRSQnMuIFRoaXMgaXMgYSBidWcuDQo+Pg0KPj4gTXkgc3Vn
Z2VzdGlvbiBoZXJlIGlzIGRvbid0IGltbWVkaWF0ZWx5IHJldHVybiBhbiBlcnJvciBjb2RlIGFu
ZCBsZXQgdGhlDQo+PiBjb21wbGV0aW9uIGludGVycnVwdCBpbmZvcm0gb2YgYSB0cmFuc2ZlciBm
YWlsdXJlLiBUaGUgcmVhc29ucyBhcmU6DQo+Pg0KPj4gYSkgU3RlcCAzKSBoYXBwZW5lZCB3aGVu
IHRoZSByZXF1ZXN0IGlzIGFscmVhZHkgKGFyZ3VhYmx5KSBxdWV1ZWQuDQo+PiBiKSBJZiB0aGUg
ZXJyb3IgZnJvbSBzdGVwIDMpIGlzIGR1ZSB0byBjb21tYW5kIHRpbWVkIG91dCwgdGhlIGNvbnRy
b2xsZXINCj4+IG1heSBoYXZlIHBhcnRpYWxseSBjYWNoZWQvcHJvY2Vzc2VkIHNvbWUgb2YgdGhl
c2UgVFJCcy4gV2UgY2FuJ3Qgc2ltcGx5DQo+PiBnaXZlIGJhY2sgdGhlIHJlcXVlc3QgaW1tZWRp
YXRlbHkgd2l0aG91dCBzdG9wcGluZyB0aGUgdHJhbnNmZXIgYW5kIGZhaWwNCj4+IGFsbCB0aGUg
aW4tZmxpZ2h0IHJlcXVlc3QuDQo+PiBjKSBJdCBhZGRzIHVubmVjZXNzYXJ5IGNvbXBsZXhpdHkg
dG8gdGhlIGRyaXZlciBhbmQgdGhlcmUgYXJlIGEgZmV3DQo+PiBwaXRmYWxscyB0aGF0IHdlIGhh
dmUgdG8gd2F0Y2ggb3V0IGZvciB3aGVuIGhhbmRsaW5nIGdpdmluZyBiYWNrIHRoZQ0KPj4gcmVx
dWVzdC4NCj4+IGQpIEV4Y2VwdCB0aGUgY2FzZSB3aGVyZSB0aGUgZGV2aWNlIGlzIGRpc2Nvbm5l
Y3RlZCBvciB0aGF0IHRoZSByZXF1ZXN0DQo+PiBpcyBhbHJlYWR5IGluLWZsaWdodCwgc3RlcCAx
KSBhbmQgMikgYXJlIGFsd2F5cyBkb25lIGFmdGVyDQo+PiB1c2JfZXBfcXVldWUoKS4gVGhlIGNv
bnRyb2xsZXIgZHJpdmVyIGFscmVhZHkgb3ducyB0aGVzZSByZXF1ZXN0cyBhbmQNCj4+IGNhbiBi
ZSBjb25zaWRlcmVkICJxdWV1ZWQiLg0KPiANCj4gT2gsIEkgc2VlLiBJbmRlZWQgdGhpcyBzb3Vu
ZHMgbGlrZSB0aGUgYmVzdCBtaW5pbWFsIGZpeCBmb3IgdGhlIC1yYyBhbmQNCj4gYmFja3BvcnRp
bmcgdG8gc3RhYmxlcy4gV2UgbWF5IHN0aWxsIHdhbnQgdG8gZ2V0IGJhY2sgdG8gdGhpcyBhdCBz
b21lDQo+IHBvaW50IGFuZCwgcG90ZW50aWFsbHksIHNwbGl0IGtpY2tfdHJhbnNmZXIoKSBpbnRv
IHR3byBwYXJ0cyB0aGF0IGNhbg0KPiBtYWtlIGFzc3VtcHRpb25zIGFib3V0IHRoZSBjb250ZXh0
IHdoZXJlIHRoZXkgY2FuIGJlIGNhbGxlZC4NCg0KWWVhaCwgdGhlIGRyaXZlciBtYXkgbmVlZCBz
b21lIHJlb3JnYW5pemF0aW9uIHRvIGtlZXAgdGhlIGxvZ2ljIGNsZWFyLg0KDQo+IA0KPiBBbHNv
LCB3ZSBtYXkgd2FudCB0byBtb3ZlIHRoZSByZXF1ZXN0IHRvIHRoZSBwZW5kaW5nIGxpc3Qgb25s
eSBpZiB0aGUNCj4gY29tbWFuZCBzdWNjZWVkcy4gVGhlcmUgc2hvdWxkIGJlIG5vIHJhY2UgY29u
ZGl0aW9uIGFzIGtpY2tfdHJhbnNmZXIgaXMNCj4gYWx3YXlzIGNhbGxlZCB3aXRoIGludGVycnVw
dHMgZGlzYWJsZWQuDQo+IA0KDQpIbS4uLiBJIGRvbid0IHNlZSBob3cgdGhpcyBpcyBiZXR0ZXIu
IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHRoYXQNCnJlcXVpcmVzIHRoYXQgdGhlcmUgd2ls
bCBiZSBhIGNvbW1hbmQgaXNzdWVkIGZvciBldmVyeSBjYWxsIHRvDQp1c2JfZXBfcXVldWUoKS4g
SW4gb3RoZXIgd29yZCwgd2l0aCB0aGlzIHJlcXVpcmVtZW50LCB3ZSdyZSBlbmZvcmNpbmcNCndo
ZXRoZXIgd2UgY2FuIGdpdmUgdGhlIHJlcXVlc3QgdG8gdGhlIGNvbnRyb2xsZXIgYW5kIGRyb3Ag
aXQgb3RoZXJ3aXNlLg0KU28sIGlmIHdlIHJ1biBvdXQgb2YgVFJCcywgdXNiX2VwX3F1ZXVlKCkg
d2lsbCBmYWlsPw0KDQpUaGFua3MsDQpUaGluaA0K
