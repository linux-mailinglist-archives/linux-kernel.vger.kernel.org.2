Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626CA38F5D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhEXWue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:50:34 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:42466 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhEXWua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:50:30 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 66953403A2;
        Mon, 24 May 2021 22:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1621896541; bh=BftsDmDAFIoIKsoMz/o/rdPp08/qs7po3MTfPgAgKxo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZAXW9/XBRQuj2B88JTzG1sXlGDyF1vskf5eH1UwqrIB5QhffBbG1zrgpYs04LW4Ty
         4Ia/PQjJ5lPUnoLMsT8zuBZa0xFxpg/sQ6qESxVtFeEMn0IWgXkzrCBJXunEIIpfbw
         4wnzOxUtdRrx47E3gMYfUuifXTG+/3wjdgFEVFetq4c0ZccOzmhU38XbxtfyfmbDZK
         MmVc9J3qiQvcszxI6uzC+wfMBu7ln/lLDxGS3sI+emu9NOqywPFD5ASrcKlyp7qrg4
         3zrLUM9Sy7wUU70YR2LDsCYqeSgyw+47L3fUQMT168dBGMK56yHBiUzDlyuO9J2MO8
         P7rZd9cW/W+hA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4AB9EA027D;
        Mon, 24 May 2021 22:48:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C9474800C2;
        Mon, 24 May 2021 22:48:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="EJgGU6t7";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYO6Y08WJxb71DrQZy0I3+8zlw9EOFkgvAdhHDV1DaPZ7hWJaiaokJxT6HxBrbGbFDPyK8H8ZJpRXMCLIoZ0diBnn7vcqp9LW7DofCJ18Ii23Z0WkZNLIPdDM/PC4iJL+zrn1GmY9PKPMw6BGVG6Ra/JRsThh0qUaNfiV7XLxbKZrs2WQV6FIdrRUUScEoSbRI0/My9Fit86bUAflUJsyeWvlnLdNihmKoRZzm2z8UY7fGLQUwQygZro6IUQkw/yNW65RANhamhtNRNbrBSj0E2w2/YpWDcksqw6UMgVi2Klgo1WGVh19n9TI96JTbtC/3F00T5uBrnP1F+yNzUVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BftsDmDAFIoIKsoMz/o/rdPp08/qs7po3MTfPgAgKxo=;
 b=fhHF3vqnOjJ/po3jnOkT9SE74wEOq22AMsN97ln4LEENWJwPh4BMUNZfYUeSXBUQGVOP9HQlfTpJepNljDAbCKncUTkUFfsau1Gqt0VRhds3XpOjUG/6hwDtaAbZb8cLW4Z8SVOPFjBT+dyKmZphkWVYr2/XdSSVTsY+HN4MCdXbjVnRxActwHgC6qJrJs54cXSjpqSlDwQ/tV2t7KNBy5HtRFG0GNZ6yJX7T2f1xjFy0hq/WvJax3h3Ekg2QNzCQZDbla9QozBhnWJJDaV5FzOJKF4QEnJHSMmhotngs4pX5r3+Q83ukDY0PNTMVWDm1V/OWUdvoutAARrbhr/x2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BftsDmDAFIoIKsoMz/o/rdPp08/qs7po3MTfPgAgKxo=;
 b=EJgGU6t72ubWc4xFq2H7XMuSRqzQEm2HlAfnkLNkHDJ6K7ALw1xU+8dD1WYmmd8ZjL8xa8X5LUx+h5m67lNSQAGVXyVJt7TDr8YBTjqLvkuC8wc1ah0oOeWyl+tcFLb1QjtZDAV7b6qDgfx3HTFYJl/wPzOlqd5aDa4AWE+Va0Y=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Mon, 24 May
 2021 22:48:51 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::88be:f751:f493:25f9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::88be:f751:f493:25f9%6]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 22:48:51 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
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
Thread-Index: AQHXTOaYgJWmk5cMcUemqbVphw6dSKrrnjyAgAE1xgCABfJugIAAPHIAgAAH6wCAADBmAIAACOuA
Date:   Mon, 24 May 2021 22:48:51 +0000
Message-ID: <c53c7313-55fb-dd6a-465d-1a4e08e42469@synopsys.com>
References: <d673611ca53f42a3a629eb051cabc6eb@rohde-schwarz.com>
 <20210519173545.GA1173157@rowland.harvard.edu>
 <12088413-2f7d-a1e5-5e8a-25876d85d18a@synopsys.com>
 <20210520020117.GA1186755@rowland.harvard.edu>
 <74b2133b-2f77-c86f-4c8b-1189332617d3@synopsys.com>
 <37c41d87-6e30-1557-7991-0b7bca615be1@linux.intel.com>
 <20210524185520.GA1332625@rowland.harvard.edu>
 <354a16cb-ba96-aa6f-7f10-388e6201e56d@synopsys.com>
 <f9b96ec8-cf5c-6d62-2ec2-390dd72ea4d4@linux.intel.com>
In-Reply-To: <f9b96ec8-cf5c-6d62-2ec2-390dd72ea4d4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [73.15.163.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e06977e-2d4b-4f17-b0a0-08d91f0619e9
x-ms-traffictypediagnostic: BY5PR12MB4067:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB406757BC474E27FE5F386380AA269@BY5PR12MB4067.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b2y95WzvMUr7wW+aoawMz+ZcpfrIq9ecjPNCwMq/6HBwyE6broD1xb/VrXMa8XQMjqp27NiHq/4J2Bwm9EpDlbvkCOO3n6iYPDcfjWNIeOPH8e6d/rhXIObbg1DLliI8KrknJbCaHMLIJwl+K61xU3QSBX5mE2eESTFcMGujQsYYDjASdij+2E5gN2Y7fL/lyB4A4AcjZAutUnW34U27nbKZvlVB3cMUs44xzKk4Pw/4p0rIWyjjogg5NTywi5ra6wBnMJPozKq0qL0EiPd8mMCQPVcj8+jNNQp7ToKG3jSgtXI2bhS1Zz+qrAL6fgoqY3Q3MNXpXj1S6lv/QNzxuW8kfdOEEfIr/T3xr/PGLis8nweaPnxMA6CJXAhL78xccGnMHvmsL70du6LNAEo36I8hDA0Y4/VnR1+1fkNfToD0quISDyXeJ7W4mlTwzL9yokP9tz9/4rgmsvTdVChFtnn6sUMOt0bMIaLDF2sfR7xYE+hiGX/Cqdz/tGGssTXonWvRKsrhUJcIxtQvpHMwtBfhThATnWw+99J19yrOGxX0T9Iy9ZNVPNJSUK5oMHG6W2NYSItcExJeVoMr6skO4g5vu3CPfKixKzuC0Squde91Jf4QHYy8pXO6lTILiQHSr0YDXmucJasscdLh/CzcBuEnlUMDkgX2+tlLUHS+CEu6g2snZsO+HVji1Bsa87Ck
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(39860400002)(346002)(316002)(6486002)(110136005)(54906003)(26005)(31696002)(7416002)(36756003)(4326008)(71200400001)(8936002)(8676002)(6506007)(5660300002)(66446008)(86362001)(64756008)(66476007)(6512007)(478600001)(2906002)(66946007)(76116006)(122000001)(66556008)(186003)(38100700002)(83380400001)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?V0FmYU10T3RoQjJNR3BvVHpwWWVqdEV2a3pCN2VtNFlwcndPTDhmdGlLbDgv?=
 =?utf-8?B?aDI0ZWF4VXpnZ1lhTVVDUW9ZdU56bU1PRVE3b1BRaGRTa0VaU3JEZzVHNVYx?=
 =?utf-8?B?NDZqWmlzRXlHMFhnZWd3QVdrL0ZwalBRTXVRQ0hrcTN0cTJzN3hITnJUR2Rw?=
 =?utf-8?B?Z2dkNGxzQVAwOHFhbjY2WTVsc3M2NDVjQk1TeW5PSE52Y043V1JGMStBTzkw?=
 =?utf-8?B?dEx0N2IwTFhaUG1aWTdoR3RwSkM1MWhMNC9lR2cvS1ZxQVR4UHIxRlZsOGIr?=
 =?utf-8?B?eXFtYVU5Z1lJME9GT01WOTdRbytFSG9EYzl2L3UzR3NYc1c2MGc2ZUZtYk9h?=
 =?utf-8?B?Zmxvb1VscHo5OTg2b0J6aHU4RXF5ZUIvMDMrR1lUSUJWZ3FsTnowU0ZTdVBU?=
 =?utf-8?B?VEdESC8vY1JRMmxUdVRzcFRMTmxZendHMEFvdVNuYklKbm5zeGVleGZ4ZDNo?=
 =?utf-8?B?NUtrTTE0bTJjYXU0OEZMU2xRaVVjdUI4T1RjMXgvT25MS1NtVzhsRnhac3Zx?=
 =?utf-8?B?K25WRTI4SG93bnlqNGpJN1pVSE96d2lJQUg1UlRWU0ozSzB0cGtnZHBoSU5u?=
 =?utf-8?B?c2dVWW9uaHFjUWpYOEcvTlR2VDBYRDVhcDkzTnJrNEhHVnZFZjZtSldOc243?=
 =?utf-8?B?a2FpdFZSR0VCb1haclhEejBITU0ycEtsOVJQa1dWRERNZDY1QlV4WVdkcHQx?=
 =?utf-8?B?RlNKSGMwOUYrcUJkczBCMnJDVHZNKytPOVFPeG1QV1RtcDNqeWwweFJRaXZM?=
 =?utf-8?B?L3ZiTDFoVU5YM2F2TFcyVlRaZWwvOWc1QTJ1anZ0VmphT2xjVCt6RWZrYmRl?=
 =?utf-8?B?aGxOTlJkaWNYSUkxMXd0d3V6RzZUUVluM0ZJcnN4aFkyenppVThJUFJiN3hk?=
 =?utf-8?B?bk9HUkJrRXcxY0pzejF5bGo0a2NnajBPRTV2RmZxM3VPVmp4YWRFQmtqSEty?=
 =?utf-8?B?NzBzT0s0VHRsd29Fdk1GbitwcjhqdmN1dXE0VUdRYk1xbkJzUVUreFp4Mk5I?=
 =?utf-8?B?ZlQ2NWg3Mk5RcW9Dd0MrL0N0NDJSQ3dDWTdsd0J0SFdqcEdnMU1zSG83QUpF?=
 =?utf-8?B?cDNuWnZVTFliYWN0YzJ5bW4wem9heW5XTTV1ZmZYa0JMdExaVkVqSXRZMEJ3?=
 =?utf-8?B?NTFnRXhjajFLU0xvTjNUT0NnRzhiYjNTWStBTFkrUi9MdC9ZNXo5U2xmbzlL?=
 =?utf-8?B?K211cHZNQjRSZWYyZENscGpQcjF4UWpZckt4cUREbklaN3dveDFzSDNPVE84?=
 =?utf-8?B?V0lmcmxaWlhydjZEVGdVT3VCTmNUN3ZGeDhYeEgwWGNqeFVJQlJlcTJUZ3Bt?=
 =?utf-8?B?OTg3akxqNXJsVDZMaVhJZnpZV1RsdFduMEdOMkV0dVhKVjlTTVNXV3RFQ0VD?=
 =?utf-8?B?ajlMQnRBY3ZxVHcxSG1ZcCtOVHVoWDlGNjVHMVpXcFR5bGNGVFowakhYMDBK?=
 =?utf-8?B?QVhZdHo2TGN6Yy9laWxENGQxM2tFN3pNdXVVUTIyMStQYW5yaFArb0tUVFJC?=
 =?utf-8?B?Yk9XOXBRcE8xOEMxOHpLR25SbjdEcFVadDBjMXdtUFppbHBOelNOMzd0RmtS?=
 =?utf-8?B?dkcvRU9uWVFoWno3dCtLbEhncDFGQVg0cFAyQi93NEhNSTJlcjVENUNWWGV6?=
 =?utf-8?B?NmJMSWw1ZXJsS0ZzVlBvaXlGR1hyMGZyKzNuaVNwOGMrUnh6bUdCWE53cEU5?=
 =?utf-8?B?T21YMG44OTArTUdSWEQ5dlRsdHdxWHJya3RhZUFhbytvOUpLVFFuOVpuOW41?=
 =?utf-8?Q?dqFMknmrB8EXneGEAQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CAD230CB7DA0B41B0D960BA62D044E5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e06977e-2d4b-4f17-b0a0-08d91f0619e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 22:48:51.2867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgTwXMr0TE3uKaWMQLVzSS7NhIPSL1eMFKgjQZ9IBtoRS1tXDcNcCC6WtT6a7LC8Gv/reqltWtwLq/TVgmx/pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWF0aGlhcyBOeW1hbiB3cm90ZToNCj4gT24gMjQuNS4yMDIxIDIyLjIzLCBUaGluaCBOZ3V5ZW4g
d3JvdGU6DQo+PiBBbGFuIFN0ZXJuIHdyb3RlOg0KPj4+IE9uIE1vbiwgTWF5IDI0LCAyMDIxIGF0
IDA2OjE4OjU5UE0gKzAzMDAsIE1hdGhpYXMgTnltYW4gd3JvdGU6DQo+Pj4+IE9uIDIwLjUuMjAy
MSAyMy4zMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4+Pj4gQXMgZm9yIHRoZSB4aGNpIGRyaXZl
ciwgdGhlcmUgbWF5YmUgYSBjYXNlIHdoZXJlIHRoZSBzdHJlYW0gVVJCIG5ldmVyDQo+Pj4+PiBn
ZXRzIHRvIGNvbXBsZXRlIGJlY2F1c2UgdGhlIHRyYW5zYWN0aW9uIGVycl9jb3VudCBpcyBub3Qg
cHJvcGVybHkNCj4+Pj4+IHVwZGF0ZWQuIFRoZSBlcnJfY291bnQgZm9yIHRyYW5zYWN0aW9uIGVy
cm9yIGlzIHN0b3JlZCBpbiBlcF9yaW5nLCBidXQNCj4+Pj4+IHRoZSB4aGNpIGRyaXZlciBtYXkg
bm90IGJlIGFibGUgdG8gbG9va3VwIHRoZSBjb3JyZWN0IGVwX3JpbmcgYmFzZWQgb24NCj4+Pj4+
IFRSQiBhZGRyZXNzIGZvciBzdHJlYW1zLiBUaGVyZSBhcmUgY2FzZXMgZm9yIHN0cmVhbXMgd2hl
cmUgdGhlIGV2ZW50DQo+Pj4+PiBUUkJzIGhhdmUgdGhlaXIgVFJCIHBvaW50ZXIgZmllbGQgY2xl
YXJlZCB0byAnMCcgKHhoY2kgc3BlYyBzZWN0aW9uDQo+Pj4+PiA0LjEyLjIpLiBJZiB0aGUgeGhj
aSBkcml2ZXIgZG9lc24ndCBzZWUgZXBfcmluZyBmb3IgdHJhbnNhY3Rpb24gZXJyb3IsDQo+Pj4+
PiBpdCBhdXRvbWF0aWNhbGx5IGRvZXMgYSBzb2Z0LXJldHJ5LiBUaGlzIGlzIHNlZW4gZnJvbSBv
bmUgb2Ygb3VyDQo+Pj4+PiB0ZXN0aW5ncyB0aGF0IHRoZSBkcml2ZXIgd2FzIHJlcGVhdGVkbHkg
ZG9pbmcgc29mdC1yZXRyeSB1bnRpbCB0aGUgY2xhc3MNCj4+Pj4+IGRyaXZlciB0aW1lZCBvdXQu
DQo+Pj4+Pg0KPj4+Pj4gSGkgTWF0aGlhcywgbWF5YmUgeW91IGhhdmUgc29tZSBjb21tZW50IG9u
IHRoaXM/IFRoYW5rcy4NCj4+Pj4NCj4+Pj4gVGhpcyBpcyB0cnVlLCBpZiBUUkIgcG9pbnRlciBp
cyAwIHRoZW4gdGhlcmUgaXMgbm8gcmV0cnkgbGltaXQgZm9yIHNvZnQgcmV0cnkuDQo+Pj4+IFdl
IHNob3VsZCBhZGQgb25lIGFuZCBwcmV2ZW50IGEgbG9vcC4gYWZ0ZXIgZSBmZXcgc29mdCByZXNl
dHMgd2UgY2FuIGVuZCB3aXRoIGENCj4+Pj4gaGFyZCByZXNldCB0byBjbGVhciB0aGUgaG9zdCBz
aWRlIGVuZHBvaW50IGhhbHQuDQo+Pj4+DQo+Pj4+IFdlIGRvbid0IGtub3cgdGhlIFVSQiB0aGF0
IHdhcyBiZWluZyB0YW5zZmVycmVkIGR1cmluZyB0aGUgZXJyb3IsIGFuZCBjYW4ndCANCj4+Pj4g
Z2l2ZSBpdCBiYWNrIHdpdGggYSBwcm9wZXIgZXJyb3IgY29kZS4NCj4+Pj4gSW4gdGhhdCBzZW5z
ZSB3ZSBzdGlsbCBlbmQgdXAgd2FpdGluZyBmb3IgYSB0aW1lb3V0IGFuZCBzb21lb25lIHRvIGNh
bmNlbA0KPj4+PiB0aGUgdXJiLg0KPj4+DQo+Pj4gVGhhdCdzIG5vdCBnb29kLiAgVGhlcmUgbWF5
IG5vdCBiZSBhIHRpbWVvdXQ7IGRyaXZlcnMgZXhwZWN0IHRyYW5zZmVycyANCj4+PiB0byBjb21w
bGV0ZSB3aXRoIGEgZmFpbHVyZSwgbm90IHRvIGJlIHJldHJpZWQgaW5kZWZpbml0ZWx5Lg0KPj4+
DQo+Pj4gSG93ZXZlciwgaWYgeW91IGRvIGtub3cgd2hpY2ggZW5kcG9pbnQvc3RyZWFtIHRoZSBl
cnJvciBpcyBjb25uZWN0ZWQgdG8sIA0KPj4+IHlvdSBzaG91bGQgYmUgYWJsZSB0byBnZXQgdGhl
IFVSQi4gIEl0IHdpbGwgYmUgdGhlIGZpcnN0IG9uZSBxdWV1ZWQgZm9yIA0KPj4+IHRoYXQgZW5k
cG9pbnQvc3RyZWFtLg0KPj4+DQo+Pg0KPj4gV2hlbiB0aGUgeGhjaSBjYW4ndCByZWNvdmVyIGEg
dHJhbnNmZXIgd2l0aCBzb2Z0LXJldHJ5LCBubyBvdXRzdGFuZGluZw0KPj4gdHJhbnNmZXIgY2Fu
IHByb2NlZWQvY29tcGxldGUgZm9yIHRoZSBlbmRwb2ludC4gSWYgdGhlIFRSQiBwb2ludGVyIGlz
IDAsDQo+PiB3ZSBqdXN0IGRvbid0IGtub3cgd2hpY2ggc3RyZWFtIG9yIGVuZHBvaW50IHJpbmcg
aXQncyBmb3IsIGJ1dCB3ZSBrbm93DQo+PiBhbGwgdGhlIG91dHN0YW5kaW5nIFVSQnMgb2YgYW4g
ZW5kcG9pbnQuIExldCdzIG1heSBhcyB3ZWxsIHJldHVybiBhbg0KPj4gZXJyb3Igc3RhdHVzIGZv
ciBhbGwgb2YgdGhlbSBhZnRlciBhIGxpbWl0ZWQgbnVtYmVyIG9mIHNvZnQtcmV0cmllcy4NCj4g
DQo+IFdlIGdldCB0aGUgZW5kcG9pbnQsIGJ1dCBub3QgdGhlIHN0cmVhbS4NCg0KUmlnaHQuDQoN
Cj4gDQo+IEkgZ3Vlc3Mgd2UgY291bGQgd2FsayB0aHJvdWdoIGVhY2ggc3RyZWFtIG9mIHRoaXMg
ZW5kcG9pbnQsIGFuZCByZXR1cm4gdGhlIA0KPiBmaXJzdCBVUkIgb2YgZXZlcnkgc3RyZWFtIHRo
YXQgaGFzIGEgcGVuZGluZyBVUkIuDQo+IHhIQ0kgc3BlYyBjbGFpbXMgdG8gc3VwcG9ydHMgNjU1
MzMgc3RyZWFtcyBwZXIgZW5kcG9pbnQsIGJ1dCBpbiByZWFsIGxpZmUgDQo+IFVBUyBwcm9iYWJs
eSBvbmx5IHVzZXMgYSBmZXcgcGVyIGVuZHBvaW50Pw0KPiANCj4gLU1hdGhpYXMgDQo+IA0KDQpU
eXBpY2FsbHkgVUFTUCBkZXZpY2VzIGFkdmVydGlzZSB0byBzdXBwb3J0IHVwIHRvIDMyIHN0cmVh
bXMuIFdlIG5vdGljZQ0KdGhhdCBzb21lIG5ld2VyIGJ1aWxkcyBvZiBXaW5kb3dzIE9TIGhhcyBh
IGJ1ZyAob3IgaW50ZW50aW9uYWw/KSB0aGF0IGl0DQpyZWplY3RzIGFueSBkZXZpY2UgdGhhdCB1
c2VzIG1vcmUgb3IgbGVzcyB0aGFuIDMyIHN0cmVhbXMgKHByb2JhYmx5IGENCmJ1ZykgaW4gdGhl
IGRlc2NyaXB0b3IuDQoNCkkgdGhpbmsgd2Ugb25seSBuZWVkIHRvIGRvIHRoaXMgaWYgd2UgZG9u
J3Qga25vdyB3aGljaCBzdHJlYW0gdGhlIGV2ZW50DQpiZWxvbmdzIHRvLiBPdGhlcndpc2UsIHdl
IGNhbiBrZWVwIHRoZSBvbGQgbG9naWMuDQoNCkJSLA0KVGhpbmgNCg0K
