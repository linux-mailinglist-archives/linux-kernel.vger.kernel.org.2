Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8DA3E4EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 00:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbhHIWHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 18:07:52 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:34592 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232683AbhHIWHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:07:51 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3E1CCC0176;
        Mon,  9 Aug 2021 22:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628546849; bh=S3UYjJA2TFcvKu61noBF4fovK1dlAAPrmSe6+RKxbZo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WLbqoRVXBrRn+D3XBdKa1mTEkkFSc85dZ3YxXb3E55LPL2qDCWbTByHq3NUFO0mqR
         WZR8hnvsSSIKKfPAnm31SBqOrZzqQ1A3sZAMqLl6J5VdXQb78Fg4IPeFYkswVQxr71
         UbrKuEWP/P2BvdunysfV1hTvpeqN+6XAikyagvmvIxgJrrn4Ljjvc5RG4iSaL+DTel
         QOpyAqB5k13w0YzRfr0xd10e2hMLuYpKb3WTToC5d9z4AouOUIMPo5iVPqJqnSbN9w
         HUCHfUz9Ypq3ZkMOH09g3TNua5XXatMIdfjMZqsoOhoNyGpqcdv0BCqk6TwDW1gpdY
         7PpywKjUUhk8g==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E7330A0080;
        Mon,  9 Aug 2021 22:07:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8515E80267;
        Mon,  9 Aug 2021 22:07:26 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="dsK6ibzo";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsDCJbuoBmCWL7V7K3rZiPPXaThO/2a4EeGhjN+WteCLBvp0UA2nXhZkUlq0DuHnaHz7PUxy7wKYY9ToO90tTwEjQ3SmZtSSvu1w4fCX2TR1H58GD4LPb69gNtsgAiUhIAq+1z8BkRZk9ITUEtxBjxryyIu3E0bhteLVQfdxwfLycL0mdINYRhwIOg4r6s10x1Hj10VNPQN30ewrqQKp7Wo+7gc08kwpiEq0DPI9B39j/c53QMX8rZvEDpi4SPH4kgN3sv2jvLDDl96x/GEf/U0EopvPEWb2OEOabH3AX2POW+aalffa4sVPdJgc9szqusX+WY8LgWVioOZmVMgmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3UYjJA2TFcvKu61noBF4fovK1dlAAPrmSe6+RKxbZo=;
 b=JS9Lg4q0EqpMBnRQtmbocgcv02VHqdlMxYHBnnsIB3PLfkS75w5BIwr9GZIN/IRY/jEEAnWPqEDxkQTp9s86S5rAEsqSt3igb2r8mrhut7i6a+srdyMeYJN0il+gL4JcwJMJwEzbFD3d+oPMWhx0mye+2kXkCqNnJeO/ybBHWw/5x3oMK95EjBXFKUQnOH7kJXETZ72ygrSipPGsv0ZvpWFqlhSxkg40fDjafQawraW5IY734+UqpCmeZRRB03ANuCU7esCg3NkzaNgZMvXkq5oKUaxN6bfoCnK1oFp+/U8lO6LvC9MvURXtEz1Uel03Io6B54xNwztCaySeu52b/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3UYjJA2TFcvKu61noBF4fovK1dlAAPrmSe6+RKxbZo=;
 b=dsK6ibzo7fagiByKKYSmC42Uk75WpNO2feYemotlF0lo/eSDDHXY/W54joaCqoArCBUpLBgrL9yBoNII56vPG6ILUWSuXbR9VgwNb26flQr7wmCDjqZFjrj9pB+Pqt0qfPlCwLLFFfkuKCpi2uZiw1L6I6RRXwqQy/45CJYeG2A=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 22:07:23 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 22:07:23 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Use list_replace_init() before
 traversing lists
Thread-Topic: [PATCH] usb: dwc3: gadget: Use list_replace_init() before
 traversing lists
Thread-Index: AQHXhEwIHPAGllb6FUCkuU2eyXN2WqtrzUIA
Date:   Mon, 9 Aug 2021 22:07:23 +0000
Message-ID: <22969fbd-c16b-9443-7673-1e0ae72c873f@synopsys.com>
References: <1627543994-20327-1-git-send-email-wcheng@codeaurora.org>
In-Reply-To: <1627543994-20327-1-git-send-email-wcheng@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e142a61-1468-4599-43e5-08d95b8210e7
x-ms-traffictypediagnostic: BY5PR12MB4212:
x-microsoft-antispam-prvs: <BY5PR12MB42123A7023C3FFD0E6AE1DA6AAF69@BY5PR12MB4212.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UKamBmFX/diZDEJBKW8Uxo0RUo0UhFdBh2YNDXdNQY2N9vocrj6iETl2NyIOhoiLG6ir/E/D7Q7IXIyY/PPz3sEcYuBNKtU8iEAxLgkLiU4d9pN4ztGZBlviVRzaZyi09YNKUuPcbUTmvi95pFet6klYCvC/nTNm62R2rpFI93MXeqC3svKXxhFTCI14xiRO5pIpDOACRRNGjORBeidJNbH2YplBVSk4qUlPfLyOUjPnSXuk6FlQWSnIDi33P9G8TCAoTbRsMDxaPm52ioyttdYuYXLffrTmhpJ7eOucow/ouHaeyx4WsLxcAyz6xq9N+pHPGnlvfYWnSBHv+PsgGe6a96S8qccpLVspVBBXLBkTIBv/7JhBm2IJybZDJ0kDii6pzo4iL8ZdgmAL3z94cSWNPxMhFAtDNlDvVGicaBIFbVpHMumCvRogauUm0+7AnMNJSQtVwPNF5lYzqI9OM+XcZW/Se6RL5mivS7EyYqxovWg76NawpZ0N2NlbwYRRHqvWwo6yUhW0cJLunyWsoeeP3d2fhNjPHvIu7Yb58UPDA80OYhVMsOlg3/c7H1su8eeXzk+bWPKkDZrVKsmzDfVPfHQitevDJ5qVmAs72foWnRBnSyVYEY+7fevHyCorjc6BqMKsD+OTX5TcexFPPq9qqOs+cP4a8tyTOl5g37FZ1SkJaF8YYqyxgPB/hLuzAFJ3i/HPWD1z3oYrnFKrN7G7fsOCW6UspZKFrwtQeEsUbu/ELTcS9GUNdXq5d9caUlgpNu3HqMmqJowuVMESyxByL8rIps8fhhuClFAQogwey5ukFiBOnixWyIRlg/FotHmSeB/D21eMffVlqQ925Ni0od1peYx0gdXkd7wjSwo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(39860400002)(396003)(346002)(26005)(6506007)(76116006)(86362001)(71200400001)(31686004)(2906002)(4326008)(2616005)(6486002)(38070700005)(186003)(6512007)(122000001)(38100700002)(478600001)(966005)(36756003)(66946007)(64756008)(54906003)(110136005)(8676002)(66476007)(66556008)(316002)(8936002)(66446008)(83380400001)(31696002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFFWVncvSS9XamRvelQ0QVlxVjBVT251TE14djBuZWRQc0s0a0R0bXVuVzRo?=
 =?utf-8?B?c3BNaTJGc1lGMlNqRjVXNjV5MGFZQUdYTEgvbG9iZm45QUpBSVdvUi9MNzRu?=
 =?utf-8?B?VFg2UUp6RVNlNWtURnVUSEZrM3hVSVp6RUVWTzIxdGpndm4rTUZsSG9HWlo4?=
 =?utf-8?B?QmlDanlXRGxFeXdFNElIN3haT3h5NEVMU0VlU1NxbWlqK2FWNE5Md3pnRHNk?=
 =?utf-8?B?M3lNSkRaR1pBK01mUnA1S016MEQ0bVBqdlVSSzJSWG14NlFFVFoyc3NUcnVr?=
 =?utf-8?B?bnZCUmhXaDVIQVUwNWl1UXkxSmUzOWl0RXBzTGVPZWUrdWdjTUNXUnE5MWF1?=
 =?utf-8?B?WDNSK1l3aHRaRFJJMXlERW9oOWNrZ0RTcDdXY1k2WklmMEdOT2JhVjVva2xH?=
 =?utf-8?B?dWROV0RxdUdQVnpPdis4b0lvUXNkYjBCYmdLV0VvUDdSZjVjUnBtZ28rYVZT?=
 =?utf-8?B?VWlTeVRiL1ZBbnFqbHNNM1Y2U0dSTmhkMm5ZVEdkSEJidmFDRENMcGdYMnhM?=
 =?utf-8?B?VGU5MkpkbmwzaWV6U2ZxM0VLemxlTGVFQWpSVUhWQ0x1RGM0ZXJaVkhCVEVO?=
 =?utf-8?B?dWw3cTdhbUMvZEpuRVZlZFE2bzBwR3MzaG1FOFZWdEtxTkw4ZTJGU0dxRG04?=
 =?utf-8?B?bjYwcEt0b1VwdDl2c1FUT3lFdWQvYXQ0czBzeklFMXk0YktTUWQrN2xjeWtF?=
 =?utf-8?B?OGFvaDgrUDU3SitjTjNRWFpsa3Jtbjh4RDNnbTQ3MkQ2elltemtUaUJ3VHlV?=
 =?utf-8?B?a0w5TXFFdEhWYW56dm9ub0ppb2JJN0Fsb3F6bHlGbnlDcVhNcFc2dUFpdXR0?=
 =?utf-8?B?ZURlYXJma2d6eHE5aG1SVmFsbjlLdHFvTWorTmpTcTY4RHc2aE1vWHdTTlFu?=
 =?utf-8?B?eGdUbFVoQTBDazZHQ3FnK3Rmak1QaUE5SVVuR0dQY2hrejFSMHhXcngrdHBO?=
 =?utf-8?B?MHBPRFBtNE1wRVZlZmhPMEFYa3Jub0RsaGN6UlVFTURtYVhvV2g2WE5SdmJm?=
 =?utf-8?B?UklvSGUxblJRM0E2RUFjZXZwaXdJQnlPWFFyc3lMcUNMa2NteklISC9nTXly?=
 =?utf-8?B?aVEwaWYxNWNtTG1uUGI1RW9aUCtzZkRvK3IwaE4rdXByTTd0MmphejFKODRG?=
 =?utf-8?B?YU1SbVdlQ0RuY1Q3aEpNY2RLSENpQy9WbEJYTDU2cWhYNHhhenhCUHlnOXdK?=
 =?utf-8?B?MDlHS2Z0WW5zOUgzTVpwSjZzRkRadnpoejBERDQ0MEUxNjRmS1djRnJJYnA4?=
 =?utf-8?B?KytHVVg4REx3VU5MQmhvOThjT1lWR2had25ra0ZmWXAwUys5SlUyeTNpbWFQ?=
 =?utf-8?B?dDh2Q1hnR28wT3JXU0dFNmtHeXFZcktNV1J1M3pScUtQZ29OeVBHSDVNcysr?=
 =?utf-8?B?a0FHcTExM2pqT2pzaVRGTW1tWnkrdmZyNDV2Um9Gb2dBSHFxeVR1RVErOFAw?=
 =?utf-8?B?ZDZpV0R6S04vczFIL2NqSXA4dUUrK0VJamRBUWhMNTh4cm5LekxkMjlPMm0x?=
 =?utf-8?B?WkJsb01qKzRQVE82dEtyZ013dG9SQ2lRTS9yV3ZieUVHNUo2aFN1anJWcFFa?=
 =?utf-8?B?R1ZTUUg3QnZKalN0WFVsNlRaOU9PdUVIZ3NkK3dCbDVtK21VQXAwdjAycFls?=
 =?utf-8?B?WTJpNVhyS3Z6b2pTc3NRVGl4ZzNVV1hIc2h4US9sUmV5Mk9uTUh5UEpnMUdP?=
 =?utf-8?B?eFdXU2ZJVnJ0QVh0N1E5bHRxTmlXbk52VDNydVZacmVrZ0xmK05VYW0wUDJw?=
 =?utf-8?Q?NkuNNITiUTTqgb1GbE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <20DC5982DD52F546B802CB2C42058EDB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e142a61-1468-4599-43e5-08d95b8210e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 22:07:23.5194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZswgxfSeC2jjooA+BxGr6QSkflli80zld3raYYK9CxRg2ck525wciADx7e8gzuYPUPwAxZrIp8awReWQYrbSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KyBKb2huIFN0dWx0eg0KDQpXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+IFRoZSBsaXN0X2Zvcl9lYWNo
X2VudHJ5X3NhZmUoKSBtYWNybyBzYXZlcyB0aGUgY3VycmVudCBpdGVtIChuKSBhbmQNCj4gdGhl
IGl0ZW0gYWZ0ZXIgKG4rMSksIHNvIHRoYXQgbiBjYW4gYmUgc2FmZWx5IHJlbW92ZWQgd2l0aG91
dA0KPiBjb3JydXB0aW5nIHRoZSBsaXN0LiAgSG93ZXZlciwgd2hlbiB0cmF2ZXJzaW5nIHRoZSBs
aXN0IGFuZCByZW1vdmluZw0KPiBpdGVtcyB1c2luZyBnYWRnZXQgZ2l2ZWJhY2ssIHRoZSBEV0Mz
IGxvY2sgaXMgYnJpZWZseSByZWxlYXNlZCwNCj4gYWxsb3dpbmcgb3RoZXIgcm91dGluZXMgdG8g
ZXhlY3V0ZS4gIFRoZXJlIGlzIGEgc2l0dWF0aW9uIHdoZXJlLCB3aGlsZQ0KPiBpdGVtcyBhcmUg
YmVpbmcgcmVtb3ZlZCBmcm9tIHRoZSBjYW5jZWxsZWRfbGlzdCB1c2luZw0KPiBkd2MzX2dhZGdl
dF9lcF9jbGVhbnVwX2NhbmNlbGxlZF9yZXF1ZXN0cygpLCB0aGUgcHVsbHVwIGRpc2FibGUNCj4g
cm91dGluZSBpcyBydW5uaW5nIGluIHBhcmFsbGVsIChkdWUgdG8gVURDIHVuYmluZCkuICBBcyB0
aGUgY2xlYW51cA0KPiByb3V0aW5lIHJlbW92ZXMgbiwgYW5kIHRoZSBwdWxsdXAgZGlzYWJsZSBy
ZW1vdmVzIG4rMSwgb25jZSB0aGUNCj4gY2xlYW51cCByZXRha2VzIHRoZSBEV0MzIGxvY2ssIGl0
IHJlZmVyZW5jZXMgYSByZXF1ZXN0IHdobyB3YXMgYWxyZWFkeQ0KPiByZW1vdmVkL2hhbmRsZWQu
ICBXaXRoIGxpc3QgZGVidWcgZW5hYmxlZCwgdGhpcyBsZWFkcyB0byBhIHBhbmljLg0KPiBFbnN1
cmUgYWxsIGluc3RhbmNlcyBvZiB0aGUgbWFjcm8gYXJlIHJlcGxhY2VkIHdoZXJlIGdhZGdldCBn
aXZlYmFjaw0KPiBpcyB1c2VkLg0KPiANCj4gRXhhbXBsZSBjYWxsIHN0YWNrOg0KPiANCj4gVGhy
ZWFkIzE6DQo+IF9fZHdjM19nYWRnZXRfZXBfc2V0X2hhbHQoKSAtIENMRUFSIEhBTFQNCj4gICAt
PiBkd2MzX2dhZGdldF9lcF9jbGVhbnVwX2NhbmNlbGxlZF9yZXF1ZXN0cygpDQo+ICAgICAtPmxp
c3RfZm9yX2VhY2hfZW50cnlfc2FmZSgpDQo+ICAgICAtPmR3YzNfZ2FkZ2V0X2dpdmViYWNrKG4p
DQo+ICAgICAgIC0+ZHdjM19nYWRnZXRfZGVsX2FuZF91bm1hcF9yZXF1ZXN0KCktIG4gZGVsZXRl
ZFtjYW5jZWxsZWRfbGlzdF0NCj4gICAgICAgLT5zcGluX3VubG9jaw0KPiAgICAgICAtPlRocmVh
ZCMyIGV4ZWN1dGVzDQo+ICAgICAgIC4uLg0KPiAgICAgLT5kd2MzX2dhZGdldF9naXZlYmFjayhu
KzEpDQo+ICAgICAgIC0+QWxyZWFkeSByZW1vdmVkIQ0KPiANCj4gVGhyZWFkIzI6DQo+IGR3YzNf
Z2FkZ2V0X3B1bGx1cCgpDQo+ICAgLT53YWl0aW5nIGZvciBkd2MzIHNwaW5fbG9jaw0KPiAgIC4u
Lg0KPiAgIC0+VGhyZWFkIzEgcmVsZWFzZWQgbG9jaw0KPiAgIC0+ZHdjM19zdG9wX2FjdGl2ZV90
cmFuc2ZlcnMoKQ0KPiAgICAgLT5kd2MzX3JlbW92ZV9yZXF1ZXN0cygpDQo+ICAgICAgIC0+ZmV0
Y2hlcyBuKzEgaXRlbSBmcm9tIGNhbmNlbGxlZF9saXN0IChuIHJlbW92ZWQgYnkgVGhyZWFkIzEp
DQo+ICAgICAgIC0+ZHdjM19nYWRnZXRfZ2l2ZWJhY2soKQ0KPiAgICAgICAgIC0+ZHdjM19nYWRn
ZXRfZGVsX2FuZF91bm1hcF9yZXF1ZXN0KCktIG4rMQ0KPiBkZWxldGVkW2NhbmNlbGxlZF9saXN0
XQ0KPiAgICAgICAgIC0+c3Bpbl91bmxvY2sNCj4gDQo+IEZpeCB0aGlzIGNvbmRpdGlvbiBieSB1
dGlsaXppbmcgbGlzdF9yZXBsYWNlX2luaXQoKSwgYW5kIHRyYXZlcnNpbmcNCj4gdGhyb3VnaCBh
IGxvY2FsIGNvcHkgb2YgdGhlIGN1cnJlbnQgZWxlbWVudHMgaW4gdGhlIGVuZHBvaW50IGxpc3Rz
Lg0KPiBUaGlzIHdpbGwgYWxzbyBzZXQgdGhlIHBhcmVudCBsaXN0IGFzIGVtcHR5LCBzbyBpZiBh
bm90aGVyIHRocmVhZCBpcw0KPiBhbHNvIGxvb3BpbmcgdGhyb3VnaCB0aGUgbGlzdCwgaXQgd2ls
bCBiZSBlbXB0eSBvbiB0aGUgbmV4dCBpdGVyYXRpb24uDQo+IA0KPiBGaXhlczogZDRmMWFmZTVl
ODk2ICgidXNiOiBkd2MzOiBnYWRnZXQ6IG1vdmUgcmVxdWVzdHMgdG8gY2FuY2VsbGVkX2xpc3Qi
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHdjaGVuZ0Bjb2RlYXVyb3JhLm9yZz4N
Cj4gDQo+IC0tLQ0KPiBQcmV2aW91cyBwYXRjaHNldDoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNv
bS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8xNjIwNzE2NjM2LTEyNDIy
LTEtZ2l0LXNlbmQtZW1haWwtd2NoZW5nQGNvZGVhdXJvcmEub3JnL19fOyEhQTRGMlI5R19wZyFO
Z2lkM3BSRWhNMUZXaVJtRW5DR3JONkZoQnZTeERUa1BiWjRSekFFTzVVYnMwYUdTeHRpa0ZUMUFQ
elRXaGd3NDJBcyQgDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDE4ICsr
KysrKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
YyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggYTI5YTRjYS4uM2NlNmVkOSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC0xOTI2LDkgKzE5MjYsMTMgQEAgc3RhdGljIHZvaWQg
ZHdjM19nYWRnZXRfZXBfY2xlYW51cF9jYW5jZWxsZWRfcmVxdWVzdHMoc3RydWN0IGR3YzNfZXAg
KmRlcCkNCj4gIHsNCj4gIAlzdHJ1Y3QgZHdjM19yZXF1ZXN0CQkqcmVxOw0KPiAgCXN0cnVjdCBk
d2MzX3JlcXVlc3QJCSp0bXA7DQo+ICsJc3RydWN0IGxpc3RfaGVhZAkJbG9jYWw7DQo+ICAJc3Ry
dWN0IGR3YzMJCQkqZHdjID0gZGVwLT5kd2M7DQo+ICANCj4gLQlsaXN0X2Zvcl9lYWNoX2VudHJ5
X3NhZmUocmVxLCB0bXAsICZkZXAtPmNhbmNlbGxlZF9saXN0LCBsaXN0KSB7DQo+ICtyZXN0YXJ0
Og0KPiArCWxpc3RfcmVwbGFjZV9pbml0KCZkZXAtPmNhbmNlbGxlZF9saXN0LCAmbG9jYWwpOw0K
PiArDQo+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHJlcSwgdG1wLCAmbG9jYWwsIGxpc3Qp
IHsNCj4gIAkJZHdjM19nYWRnZXRfZXBfc2tpcF90cmJzKGRlcCwgcmVxKTsNCj4gIAkJc3dpdGNo
IChyZXEtPnN0YXR1cykgew0KPiAgCQljYXNlIERXQzNfUkVRVUVTVF9TVEFUVVNfRElTQ09OTkVD
VEVEOg0KPiBAQCAtMTk0Niw2ICsxOTUwLDkgQEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfZXBf
Y2xlYW51cF9jYW5jZWxsZWRfcmVxdWVzdHMoc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4gIAkJCWJy
ZWFrOw0KPiAgCQl9DQo+ICAJfQ0KPiArDQo+ICsJaWYgKCFsaXN0X2VtcHR5KCZkZXAtPmNhbmNl
bGxlZF9saXN0KSkNCj4gKwkJZ290byByZXN0YXJ0Ow0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgaW50
IGR3YzNfZ2FkZ2V0X2VwX2RlcXVldWUoc3RydWN0IHVzYl9lcCAqZXAsDQo+IEBAIC0zMTkwLDgg
KzMxOTcsMTIgQEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfZXBfY2xlYW51cF9jb21wbGV0ZWRf
cmVxdWVzdHMoc3RydWN0IGR3YzNfZXAgKmRlcCwNCj4gIHsNCj4gIAlzdHJ1Y3QgZHdjM19yZXF1
ZXN0CSpyZXE7DQo+ICAJc3RydWN0IGR3YzNfcmVxdWVzdAkqdG1wOw0KPiArCXN0cnVjdCBsaXN0
X2hlYWQJbG9jYWw7DQo+ICANCj4gLQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocmVxLCB0bXAs
ICZkZXAtPnN0YXJ0ZWRfbGlzdCwgbGlzdCkgew0KPiArcmVzdGFydDoNCj4gKwlsaXN0X3JlcGxh
Y2VfaW5pdCgmZGVwLT5zdGFydGVkX2xpc3QsICZsb2NhbCk7DQo+ICsNCj4gKwlsaXN0X2Zvcl9l
YWNoX2VudHJ5X3NhZmUocmVxLCB0bXAsICZsb2NhbCwgbGlzdCkgew0KPiAgCQlpbnQgcmV0Ow0K
PiAgDQo+ICAJCXJldCA9IGR3YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY29tcGxldGVkX3JlcXVlc3Qo
ZGVwLCBldmVudCwNCj4gQEAgLTMxOTksNiArMzIxMCw5IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2Fk
Z2V0X2VwX2NsZWFudXBfY29tcGxldGVkX3JlcXVlc3RzKHN0cnVjdCBkd2MzX2VwICpkZXAsDQo+
ICAJCWlmIChyZXQpDQo+ICAJCQlicmVhazsNCj4gIAl9DQo+ICsNCj4gKwlpZiAoIWxpc3RfZW1w
dHkoJmRlcC0+c3RhcnRlZF9saXN0KSkNCj4gKwkJZ290byByZXN0YXJ0Ow0KDQpUaGlzIGlzIG5v
dCByaWdodC4gV2UgZG9uJ3QgY2xlYW51cCB0aGUgZW50aXJlIHN0YXJ0ZWQgbGlzdCBoZXJlLg0K
U29tZXRpbWUgd2UgZW5kIGVhcmx5IGJlY2F1c2Ugc29tZSBUUkJzIGFyZSBjb21wbGV0ZWQgYnV0
IG5vdCBhbGwuDQoNCkJSLA0KVGhpbmgNCg==
