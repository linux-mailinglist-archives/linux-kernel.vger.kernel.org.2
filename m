Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB6936119F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbhDOSCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:02:52 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:58054 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234407AbhDOSCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:02:50 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 659F440CEB;
        Thu, 15 Apr 2021 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618509747; bh=pudQtWwiYY4YyBlqDBD4h2PoHAIUGXPsYnf4sFfx2mA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=H7jeYmuStriRvJWv43JzFUnj0ajB0HmoslYpx/Y8pzt+0lNKQrupcxyNfMjXP2XbD
         hXKKKe6+52YEbK/ZJHd4LQ9pm3Q98JupSW1m4v04Il5+XubQyEjNZ7N1hpmOyhk+IS
         xp7bKzJ7lpg47ap6YTT8F7tzAC4XTGu0X3pud5aW2yc9gIs5MERCoZQS1CI7JtcgWF
         1G4GF+9Ib+Ofs92STQiZs7ZU9J0N1RTqKTTWMS9Yeo+xdv9phm6RT5RE69t9efyx8V
         pYaomk0wZq/HfqoigTH+YRv6SVChgfZVklqW9bZ5wUSR9vIGJH4fLDaeRbhM4OmWch
         1aQSUz4Ed/yQg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2DA83A00A8;
        Thu, 15 Apr 2021 18:02:27 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2059.outbound.protection.outlook.com [104.47.37.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 70C9A40143;
        Thu, 15 Apr 2021 18:02:26 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="OH5sgOxd";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGVi5aFVhhbTbEVDeOq3umkPGY3r02lmZAKllrOnsB/E6rKk7Vx0E3Zl0OQgOHE54pFra5GMGUmlloMpYiKAs+MUn8tNHPh29W5Zw/CuJ+3WCiuMnU8GdhHbx6AqrT4UQ9ut7hxFKg+SJXo5djNyYcBKVfyv5uzrWWGlyKDBIluBgxEIANI0FZEkwVXfHXtEwj+LJCUSWHUNZ3JhIBdAcxH166LXfaqFrgObcA6651Y4MLJDF54vXdPfl2R71zBkbwiJkcJlBRRNpuvxiq43AZw5KBF5JdCEhiAS0P6C7C5SpUDoYs4MB1P/yjB4mbL5yabme2YrTtpic4NGAxIq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pudQtWwiYY4YyBlqDBD4h2PoHAIUGXPsYnf4sFfx2mA=;
 b=JbVoIIYpiLGV3ZtAGjlN/OdcY5a2LdGNqa3BO+RlD6W7Bz7XwnzFYm/YdQOS9Pb4jaTYxZQzzywbLQy9+GYMTohOCk8AX5xRis/nfJZy4COfosNnH3E4NLPsGH15iG0npVq+FtazjVbLsre9i0MMjaU/1TwWd83vhYI/YlFCnqhejhWCuthHUEwtq6UaqbvBG9EkTnEos7RambMDHilT5yl1d++MXFuGNAVS4q7I+jTYddEa462q7NLQb/6F8yrXbB/zcaiHpvnWgGsBND00nC+BgiF6fFKLcvVQ1yMslDMwetPZdNFbaVVQNoVjPliCRICIP2H1KnWA82GYtMiN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pudQtWwiYY4YyBlqDBD4h2PoHAIUGXPsYnf4sFfx2mA=;
 b=OH5sgOxdYA7KJxiHw84IBEHTeFBYtnex+wnxcarXokKje8Vnqh9jadW+SMn+x/gzxi2+G0Qco9UX5i5EcKI5UILJu5L6KGtZGFULcqndDp/xiHoH06utlrYhCi/O+Akg/x9qgFDXLneH31hCcNnxCU1l4d5fODcVn/3358xg0GY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 15 Apr
 2021 18:02:23 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 18:02:23 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Avoid canceling current request for
 queuing error
Thread-Topic: [PATCH] usb: dwc3: gadget: Avoid canceling current request for
 queuing error
Thread-Index: AQHXMX21njNOe3FucUqaGApnopX6p6q1HZsAgAC/NYCAAAMrAA==
Date:   Thu, 15 Apr 2021 18:02:23 +0000
Message-ID: <2e956314-b3e1-5c0e-104a-7416cf81f3ba@synopsys.com>
References: <1618439388-20427-1-git-send-email-wcheng@codeaurora.org>
 <87mtu0njvj.fsf@kernel.org>
 <677afbd3-6c72-29c0-ca25-88dd1bff335a@codeaurora.org>
In-Reply-To: <677afbd3-6c72-29c0-ca25-88dd1bff335a@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bedf02b-305f-4f20-52bd-08d900389f02
x-ms-traffictypediagnostic: BY5PR12MB4051:
x-microsoft-antispam-prvs: <BY5PR12MB40516E2D064801B3E77A1B5DAA4D9@BY5PR12MB4051.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aYeTDzJ4a/HuZMdtq7OxYEyXmTj0TBsHydnxL4SjIKpvtInLCRzDrdW7zbBLWeaqqYy4Gj7wzVaKbWfzirIHfBidTdtU+MBrq1k/2YlTTSi6DFd/63Rv8hd/c16paEYq9IEaA7x8Z+TWMWrmbfBT5y2jdTh6Vq9aShOfF6K09qjIHiincBSqHw7zoPED5niKo0qaoaFuQGqUtbEvi8ByUmF7Th7HMgOJ/FJo00omBeC8HnHwgb1pI3iNYmxhQBDxko1ZCwjnj91rYy+DvW6qzuR2Qs+0ORSIM5PMGqg9NBVBw8FquJadKKbXG1/2HJYthnXWjg/LPaFTo9pgjJzIEngZuggDjx5gCdjB1+15wiB97622TIYu2ABpk54syKkGY4dH7OHZgKlbbEj05qc1+5/TJ/FMZrAMlSffegVcWMRTqx5Go0P3jVZzP7qrbWK8mVZUlebJOqkyhAj1LOSh8K14AzKs3PA+xOviXnCPoXGf+5wnsEmmfQ5SFIdwz3HR/zUwh8pV/lOdcPkH6JfBo0ch26y1M/gVVzUIPxP+8eQQuIO9ThdLHfCa1dXTipDrmcS9b36zwnzY5YvQtp9CF54+2nnbt+3YVFFYZZA6NV5/6ogjm1iBV0VZ5A4cYQh2KHRxTpwZ8aD7TYDVRNcjfF71eicyb8KiizmRl2897KErPNj5SyBJE8yFizEGljW2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(366004)(39850400004)(478600001)(53546011)(186003)(31686004)(31696002)(4326008)(38100700002)(6506007)(5660300002)(6486002)(26005)(2616005)(36756003)(54906003)(2906002)(66946007)(86362001)(8936002)(66476007)(76116006)(64756008)(66556008)(66446008)(122000001)(110136005)(6512007)(316002)(83380400001)(8676002)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?T3RsYlQxdHYveHpzaGtzK3FoaXArTFNXd05aTCtzcXBPeDcycVoyZ2hUMXdt?=
 =?utf-8?B?a0pROXZnYi9WdWdvamZpL09hRXJpaDhWeFhRU1JwTU8xYVg2cjBmSXRWYUlB?=
 =?utf-8?B?WHFrNXd5bzhSQTYwNUI2S3ZmTE5KdWRrSGV0RGx5dDZYdmd1eUxsRURmQXls?=
 =?utf-8?B?MG96WXdNVXRnN0dGbk9wR3gvM2hCTCt4MzhmQ04wSnhlZTZ3OGhLQWQybmgv?=
 =?utf-8?B?NEZJRXlpOGdiL0w4SHlXLzZseXEyNUtqR0wxbkNzTjVsTE01TzVoRnArTWVH?=
 =?utf-8?B?eFd1NU01bHZ6VHVyYnVzRVIzdDArODBqVkVGY3FKc0xZVlJ6QVFnOVB4cTBm?=
 =?utf-8?B?RzZmVHEyR1ZEQWhYNEM0TGRWWjgwRHNDTm9sZm1yRU12Q3RLc0hZRlo5ZXJm?=
 =?utf-8?B?ZE50V21TSDdwZDFkRmpjV2pDZ3BoR2pMdUtJdkk4bzRMSjUrM3JMcXRrWXpC?=
 =?utf-8?B?QWpUb1FjVjFIMWd4RWFKTWtrK2kzMGlJVU1pbTJGTHpHcEtXNWVpQ21iQ1hp?=
 =?utf-8?B?NEVFUVFENmF5Sy9OeXpPRm9LcGxrdTRyTjNGZnpTZ2NVeWVmNHgzRnZ5dXFX?=
 =?utf-8?B?ZllxQXN3MjNZZXNETzJBdlhreVZ3VTF5OEdnS2VxMUdqT2xUT2tQSWFlSnVu?=
 =?utf-8?B?OFU3dXNrYjVMbE9nbENPazZTOFZrUEZiL3BqMS9tVWVya2VCTk85YktueW5U?=
 =?utf-8?B?QVYvNTk2cUcxRlh5MDJoQzZ5MGdURVpMUHRJejVLMld6UHdObStHZG05amU4?=
 =?utf-8?B?Skdka3h4c0VUWkFGZWxMeWhvMVNxQVJ5eE84akVCaVhkdCtwTlp1MVhrRmVp?=
 =?utf-8?B?RFkyTkVSUVBaVDFaWjY5cE5xRkZyOGppV3NJeUtWZFZ4NmxtMGs3cUpFVmdD?=
 =?utf-8?B?a0c4dzgzc0hoVmloMSswZ0N0RTg1SWFXWDg4N0JFaVgwcFZvSXlka0hQN3J0?=
 =?utf-8?B?M0ZJMlB0dGRRY0VQMFRBZTFNc3NHdk9LV3hxVFRPWUptYnlHdWtIZzUwMjda?=
 =?utf-8?B?MVFOYWpvdmVlL1A0KzVtZDl4djd0UGJpazJCQjlVL1pSVkx6MzhvMG1jRldU?=
 =?utf-8?B?N1BKcmxvcmJzNWI3ZW1odG1IVzZiQ2FQeTBoeDZBN1FVbWhyeWs5SGZFSjVE?=
 =?utf-8?B?OU95N0N6ZCtOWEIrNGV0TEIyY2J5U1orSHZTZGRmeHNPN3BPWmNham84REdh?=
 =?utf-8?B?Z00wWDQrd2F3dHlaZUlVck5pekNxZGF0OGRVTmRDQkFQYXBEOURYTllDV0lR?=
 =?utf-8?B?bGI2TXhQVUtWbE4rNUZkRjFvYUExY05JQmcrd25pcWVPL0p2TjVXQzVPUUg5?=
 =?utf-8?B?SXZMcEg5RnhnRWlDbzVUTEd5d1ZDRmdFZGthSXkycWQ4bmVNSVY5SUJ6MGtz?=
 =?utf-8?B?ZitDSDd3MzVFemJoM0UzbXh0endUYWRUZ293ckxGSUtBMFlXWktXMzIxWnYz?=
 =?utf-8?B?amd3NUd5dHkrK1JKdWlCKzkvaml3UHBtZkFFRERGaFVROGZvU0I0R2lMbnF4?=
 =?utf-8?B?MXh4dmg0RWZrbksyUkJuOElxZFlPRTVyV1JoZ1gyeFZxKzN6aHFPNW1xYVRB?=
 =?utf-8?B?MmxmRWlNQWhxdENUZEJzdXY5cGIzaGtLd1lVUmpWeThIaXFBQ0VVVWFDNzBY?=
 =?utf-8?B?U0FYZnljTmNQQkRkTnpjSnduN3gxbGhBNUxzaW8xaUtGMVd4QWhCVjRwV25y?=
 =?utf-8?B?TVhtdEQ4Mmt4d1NuVEVhdVU5K0dBY3E3NjA4VWRudFRTY0Nja1ZKRjJ2eU9a?=
 =?utf-8?Q?uk8pr/GBCcdX1l0nXT6n1rWTRJFA3cS5HY5ZLEe?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <951632240CCE2349943EE6A3531AB199@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bedf02b-305f-4f20-52bd-08d900389f02
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 18:02:23.4694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5EliPAjdPk3eImGnRZvKYN48p11U5GdD6OtCwzehyGOfF7c34XBWcYR9qZLUSVNLKQRm884U66pLcyrJ2mgZ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiANCj4gDQo+IE9uIDQvMTQvMjAyMSAxMToyNiBQTSwgRmVs
aXBlIEJhbGJpIHdyb3RlOg0KPj4gV2VzbGV5IENoZW5nIDx3Y2hlbmdAY29kZWF1cm9yYS5vcmc+
IHdyaXRlczoNCj4+DQo+Pj4gSWYgYW4gZXJyb3IgaXMgcmVjZWl2ZWQgd2hlbiBpc3N1aW5nIGEg
c3RhcnQgb3IgdXBkYXRlIHRyYW5zZmVyDQo+Pj4gY29tbWFuZCwgdGhlIGVycm9yIGhhbmRsZXIg
d2lsbCBzdG9wIGFsbCBhY3RpdmUgcmVxdWVzdHMgKGluY2x1ZGluZw0KPj4+IHRoZSBjdXJyZW50
IFVTQiByZXF1ZXN0KSwgYW5kIGNhbGwgZHdjM19nYWRnZXRfZ2l2ZWJhY2soKSB0byBub3RpZnkN
Cj4+PiBmdW5jdGlvbiBkcml2ZXJzIG9mIHRoZSByZXF1ZXN0cyB3aGljaCBoYXZlIGJlZW4gc3Rv
cHBlZC4gIEF2b2lkDQo+Pj4gaGF2aW5nIHRvIGNhbmNlbCB0aGUgY3VycmVudCByZXF1ZXN0IHdo
aWNoIGlzIHRyeWluZyB0byBiZSBxdWV1ZWQsIGFzDQo+Pj4gdGhlIGZ1bmN0aW9uIGRyaXZlciB3
aWxsIGhhbmRsZSB0aGUgRVAgcXVldWUgZXJyb3IgYWNjb3JkaW5nbHkuDQo+Pj4gU2ltcGx5IHVu
bWFwIHRoZSByZXF1ZXN0IGFzIGl0IHdhcyBkb25lIGJlZm9yZSwgYW5kIGFsbG93IHByZXZpb3Vz
bHkNCj4+PiBzdGFydGVkIHRyYW5zZmVycyB0byBiZSBjbGVhbmVkIHVwLg0KPj4+DQo+Pj4gU2ln
bmVkLW9mZi1ieTogV2VzbGV5IENoZW5nIDx3Y2hlbmdAY29kZWF1cm9yYS5vcmc+DQo+Pj4gLS0t
DQo+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA1ICsrKysrDQo+Pj4gIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+IGluZGV4IGUx
YjA0Yzk3Li40MjAwNzc1IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0
LmMNCj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4gQEAgLTEzOTksNiAr
MTM5OSwxMSBAQCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfa2lja190cmFuc2ZlcihzdHJ1Y3Qg
ZHdjM19lcCAqZGVwKQ0KPj4+ICAJCWlmIChyZXQgPT0gLUVBR0FJTikNCj4+PiAgCQkJcmV0dXJu
IHJldDsNCj4+PiAgDQo+Pj4gKwkJLyogQXZvaWQgY2FuY2VsaW5nIGN1cnJlbnQgcmVxdWVzdCwg
YXMgaXQgaGFzIG5vdCBiZWVuIHN0YXJ0ZWQgKi8NCj4+PiArCQlpZiAocmVxLT50cmIpDQo+Pj4g
KwkJCW1lbXNldChyZXEtPnRyYiwgMCwgc2l6ZW9mKHN0cnVjdCBkd2MzX3RyYikpOw0KPj4NCj4+
IHdlIGRvbid0IG5lZWQgYSBmdWxsIG1lbXNldC4gSSB0aGluayBlbnN1cmluZyBIV08gYml0IGlz
IHplcm8gaXMgZW5vdWdoLg0KPj4NCj4gSGkgRmVsaXBlLA0KPiANCj4gVGhhbmtzIGZvciB0aGUg
aW5wdXQvcmV2aWV3LCB3aWxsIG1ha2UgdGhpcyBjaGFuZ2UgdG8ganVzdCBjbGVhciB0aGUgSFdP
Lg0KPiANCg0KTWFrZSBzdXJlIHRvIGluY3JlbWVudCB0aGUgZGVxdWV1ZSBwb2ludGVyIGFsc28u
IEkgdGhpbmsgeW91IGNhbiB1c2UNCmR3YzNfZ2FkZ2V0X2VwX3NraXBfdHJicygpLg0KDQpCUiwN
ClRoaW5oDQoNCg==
