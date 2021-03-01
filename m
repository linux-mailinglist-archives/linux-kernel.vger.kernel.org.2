Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C9632774F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 06:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhCAF6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 00:58:49 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:35664 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232096AbhCAF6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 00:58:12 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C0FF7C00D3;
        Mon,  1 Mar 2021 05:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1614578226; bh=uK05i1WJvVKvqFdINao3hFvpFUJQvZLIS+GaF8boAzQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=aIzBeZfKj5ZJa5dhmtAW47AXAGiQP60cLs+jIDMcISIWbn3PeTku/Je8n2iNIBIWc
         q3GVPYoRMPHaPYAIEsu23zkP+GHFLEYDEkaHs0iVFq9FGbugMkYN1f+4E59cquzlDy
         uea/k4CpUZ4if9ngmCs0r1RjVkRMK7xGBCnVfzUlPHPV2AgAleIAqES9mGq1z0NEmW
         8RdnSZBCsySfUMlwQ8mmtC//e7sJIS9+PLv240YzKFJb86haPh+K7wimezG1h3VR+R
         7v/FdBlCuFI/+csO0IF3d01zG74l87Ubbn9fj1DOT6udCWvZmw6tRME7ZaufkqGopw
         DByTzmH3I5AvQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4A8F7A007D;
        Mon,  1 Mar 2021 05:57:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E85D24009B;
        Mon,  1 Mar 2021 05:57:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="P7TI69+a";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z16cNK5L9YTZl1X8E498k/WWZvClwulzPmLNkjoDtcmGuqfXrqXi8XFgzo8uLW8zHt+4n/xP4+bMa97u+CfECzpqZRdxuDBhnzWUCyAecrQwGWnWsKrlaq3g9DrheuOZc2B3Hq+FEr1lMH6CK0UlLOuscP5vr3Nzv34ungOIV45NzHyPdVkrB+FSHFtGiCVxy4xtZlRias5MOXFw5pypnuw5vXja52Rbc2zOVdKMhj3uBWa4wjaSkamWsWoYJort2fHLYztJtgVFyx+k54fMgjHHh3oez3lN3c1x0TOjrPq4dfgGMUAnIf9XvCbE1jVXBod4aJFDA7n8AMN6yuw/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK05i1WJvVKvqFdINao3hFvpFUJQvZLIS+GaF8boAzQ=;
 b=ZHUOliDAOfNo1/cppE2G0mrDMgYrw3084Zr/K1BTOQ57Vx5Deofi05FPQONuRPRXNl72LNl462ZKb8EL0zkIovyKUsbH3KWl4AsoWjTjfX/8PnDvanbPuEWGwRHRr9IynvRjxf9T34/GBWkvy3ZvmWIbXPt+QyfxvfGu42WIwbOokSqG9CJbY0Rl1DkVWJy8DUFWN7sNVPNf1JP0yXlC20Cx+3Z+yc8eRcekdIumtsjrtH7gU7pGH+URDQ4Vx200pzTfslvQEJDrq6IXgYhlcaVjJlGZlKlbUHv43H6sYVa+wucK6dVGphVAUeMQRhfkQi7nMtwmkgNYcOkvf0cDFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK05i1WJvVKvqFdINao3hFvpFUJQvZLIS+GaF8boAzQ=;
 b=P7TI69+aX5NsW2ts6E+r2DZZJZktuiEdAoBBkPGO+sE1FgwtbhdYaqiRSQ0fzWdqRlvsRqYNefJd77nIXKePh+krzPzLR+S1ldFv7W82BcmmwSyqaZHzDTebwomTVcOM1WH5XwedVMUrEyQNdCxFIkwsY9fsAkdyXMeuWuFTq2k=
Received: from BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14)
 by BY5PR12MB4803.namprd12.prod.outlook.com (2603:10b6:a03:1b0::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25; Mon, 1 Mar
 2021 05:57:00 +0000
Received: from BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::5c50:c1e:336e:f538]) by BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::5c50:c1e:336e:f538%2]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 05:57:00 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Martin Devera <devik@eaxlabs.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: Add STM32 related debugfs entries
Thread-Topic: [PATCH] usb: dwc2: Add STM32 related debugfs entries
Thread-Index: AQHXDVNOv1rn3qrgH0ayt5q1YO+MvapupLuA
Date:   Mon, 1 Mar 2021 05:57:00 +0000
Message-ID: <c6b585d9-ff97-38e7-d0f2-11d739ec74d2@synopsys.com>
References: <20210227215528.12752-1-devik@eaxlabs.cz>
In-Reply-To: <20210227215528.12752-1-devik@eaxlabs.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: eaxlabs.cz; dkim=none (message not signed)
 header.d=none;eaxlabs.cz; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.95.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84973200-a36e-4d6f-d06e-08d8dc76d498
x-ms-traffictypediagnostic: BY5PR12MB4803:
x-microsoft-antispam-prvs: <BY5PR12MB48036891A27649147C38A867A79A9@BY5PR12MB4803.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:133;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hLhiv1e6rBRbuyxJygselHF2wd/np7eWfld8ccRG42h1HbafnK5YBkAFQ8mgTgBJUvXdrn4fEDfNRniq/NTtP3yZYT48OKNGIqDaSLJk6W1oGEz69C83lc3Fz4DS3ISlVQIeK0NcJlveAeIJDiIHPB01hqAIC0w8Bc7sg8ZGNYgX8TmcDayave8DN1ucZez9DWLlXin0mzJbCdF18Hb79Vo8AniZLtzqbpcPMujViG9LwTYvqZd3NS+9p21n1T8plfJG7YJA/qivLzy7Pq8wTu8Hy48X5TLZfHpB+ZtHAvKWd7xVRlpzmUzmz6iquD5f/GHgoNAtBLtfqeVxZFM6bwo3iQDGHAx+1t4ikTCi40Mp1kPhOr5lAAClYYonPcp2etk10gc8oOjSTJFX1vZRQ5GZh6XiYtaA4S1cTrssxjh4UC/iZSNfHLuog5giC1xqkFm8O/so8ky1rR1Kak2ct+qMf1v0ubssOPJT3svxt+JHfJuQYdxhtikpGEK+2QFr4D8I3kKJ9qxteaNKAryVck4vLl3JDNuTC9pRi68hWOdoyXHi1V1XXLH4CNxkt6Sq/cEIheDyc2PYelgMN/OGNfeTkMHevEeDitHKzppaV4M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3777.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(136003)(346002)(396003)(376002)(5660300002)(2906002)(6506007)(53546011)(6486002)(8936002)(66446008)(76116006)(91956017)(64756008)(66476007)(66556008)(66946007)(83380400001)(8676002)(2616005)(71200400001)(478600001)(186003)(110136005)(31696002)(54906003)(36756003)(26005)(316002)(31686004)(4744005)(4326008)(86362001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eHgveUs3eUZHQVdNalgvcnFJR1N3MW42azFhR090VTMrb3FDdW9EMUg1TzRp?=
 =?utf-8?B?bWQ1aHJMUXl3UTZudjZ1eEROOXhSbUU4Qzk5Y3AxNkJQWUl6T3lLMXdoSFIr?=
 =?utf-8?B?VVN5L3RGdUZLNXBYWDJkQVlLRCtudmg3Wnl4bm93Q3dpZEwwN0lvdCtrU2NR?=
 =?utf-8?B?ZFR3bHJIc1BacGMwaE1jUng2NjNwNkR5VjQ0dHFYWUk1NlZsVEJuaTE0azVs?=
 =?utf-8?B?UkFBdGhEYmEzcWJ6TjhOMEc0WjVZdDJyYXRlVVhpOU5qb3JWN1BSZ0xiVy82?=
 =?utf-8?B?dzBXRnE5N0VrRUhHV1p2aHR5OGQ2TWZJRVFyNDdMdW5FN21kWU9EV2dySnNk?=
 =?utf-8?B?UXI1RmtoNGYyQmZZQUlvSVBRTUQ5T2dwSXA2aXhwY0hKRmc4ZWIwNlZoSkgr?=
 =?utf-8?B?MWZ3WERiOGZDWlNROEtOOWdpOHIyaEZSaFJrY2EyZE9WNHhTS3BUbHRsYmdB?=
 =?utf-8?B?QkZxVkdEZ1JxT0NCb2tmOVNXYnpDdzlEOW9vb21UMVZwd1hLc0RUcFByaG51?=
 =?utf-8?B?SFBtaXFsMk1BbTZnT0dmbzVqRlFXcWxIWE1IWURoYkZxYWNmWUZpeTJ0azF1?=
 =?utf-8?B?TmUxeWtXMXJNaEhyWXlVcTVMZFJGbkIrNVNWWmxUK01WQVNNYm1hSEZYTFp2?=
 =?utf-8?B?ZE9ONjZOVFh2T0ZIMkRWeGlqMlB0S0JFcVZxZ0NWbXRKdzJSbVIzRlF2dmYr?=
 =?utf-8?B?VjNGOCs5RU9wQmFOQjVvY1BIU3RWSG1WTlF2M0R3emY2WDA2WE5uTHV3RnE3?=
 =?utf-8?B?bHhiWEtmNHV6ZGZ5SGZIRG5jVjNsK3QrMEU4d2V2bnFFQ0ZSbk5FNGcrL0Vm?=
 =?utf-8?B?cURZVmc5MXlHK29tQmlKSHhDRFZ3cHVNVVZjd3VaWlRTdW9oMHdpVXgzbSt5?=
 =?utf-8?B?RXBUTkFJMGUybldYbDNueno5ZTdzdXFzOGRyWlVPSUNkb29PdlNJODNZT2hM?=
 =?utf-8?B?Uk9YNS9kb2l6UlU1WitCQ0MxQTA4K1RHdmpZNlY5WXFXTkU5THZQNENabDVm?=
 =?utf-8?B?VHlIQmk3akJ2UE96M3lOYlhUWmRlamJoK0JCWk9RWXkwOVJVTmZPWm5ldG8w?=
 =?utf-8?B?RUFlQmZvWEZjTTVnc1ZyaUV2RXFTT0FPdmkxdnpPVmhlU0VGTEJBM1ZYOFlX?=
 =?utf-8?B?T2l2VmV4WUE3UTRVVUk4cEpnTjgyVEV5K2lUSWVvUmtpNlBIM3YrVG9YSzBR?=
 =?utf-8?B?RkQ0SXZRZVBQZmRJT1RnUzVFV3B4R0JYNWMzRjhDQk0vS1QrYkxpQ2lSL1hD?=
 =?utf-8?B?TG5NUEhjeHhDVzQ1VVVBREZ2VHk5TVRRMlhQVmJYdTJLUkswUUZVWERNSmdq?=
 =?utf-8?B?WnNHakVvU05jMFR5M09XUlRqRG9qNHRRT01ndHZ2SEdrbHd2cEdyQ1N4N0xM?=
 =?utf-8?B?eUZmdFBuMGxpWWQ3cEw2b3hMMXFWTjNIazFSaS9Da0ZhMmRrNnFTN291SWlV?=
 =?utf-8?B?QnlrSFQzMVhpWUNTK0dERmN4K0w3R3JpejF3My90N3g0cHhCaE84MXBnQ0l5?=
 =?utf-8?B?RUs5bEozcHZScU9BT3BMNUYxamdtUytHMjdublZmb0QrNjNBNCsrQVZ1UEZm?=
 =?utf-8?B?STZPTDg2dlF4d290MWZ4WkVQdFJ0MDJPbzhkb0VWNVY4Ty9jU3dSd2V6TEY2?=
 =?utf-8?B?SGx3K2RQclJkR0tXT05JU3liMG5IQ0l5WjJIdTl0elgzdG9qRHFQaENFWjNH?=
 =?utf-8?B?VElOZlJ0N1RzR2ZyWWJyT1k1Y1BWdW1TQ05mU0d5d0g0V0JEUHZ3U1BUeEdY?=
 =?utf-8?Q?dVd5nLWSZEdO8M8+2o=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <91F5869DB0863F4DAE2FBE2BE2E54DF8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84973200-a36e-4d6f-d06e-08d8dc76d498
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 05:57:00.2522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AvWiWI3xSxMEuvlik6z6zhXp2Ss5Bml+IOjDl86KkqSihcve6w6NmCu+1/JK+xWDfK68OwltriQOV/t+992tig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4803
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yOC8yMDIxIDE6NTUgQU0sIE1hcnRpbiBEZXZlcmEgd3JvdGU6DQo+IFRoZXNlIGFyZSBl
bnRyaWVzIHJlbGF0ZWQgdG8gU1RNMzJNUDEgUEhZIGNvbnRyb2wuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBNYXJ0aW4gRGV2ZXJhIDxkZXZpa0BlYXhsYWJzLmN6Pg0KDQpBY2tlZC1ieTogTWluYXMg
SGFydXR5dW55YW4gPGhtaW5hc0BzeW5vcHN5cy5jb20+DQoNCj4gLS0tDQo+ICAgZHJpdmVycy91
c2IvZHdjMi9kZWJ1Z2ZzLmMgfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzIvZGVidWdmcy5jIGIvZHJp
dmVycy91c2IvZHdjMi9kZWJ1Z2ZzLmMNCj4gaW5kZXggYWFhZmQ0NjNkNzJhLi5mMTNlZWQ0MjMx
ZTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvZGVidWdmcy5jDQo+ICsrKyBiL2Ry
aXZlcnMvdXNiL2R3YzIvZGVidWdmcy5jDQo+IEBAIC02OTEsNiArNjkxLDggQEAgc3RhdGljIGlu
dCBwYXJhbXNfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSwgdm9pZCAqdikNCj4gICAJcHJpbnRf
cGFyYW0oc2VxLCBwLCB1bHBpX2ZzX2xzKTsNCj4gICAJcHJpbnRfcGFyYW0oc2VxLCBwLCBob3N0
X3N1cHBvcnRfZnNfbHNfbG93X3Bvd2VyKTsNCj4gICAJcHJpbnRfcGFyYW0oc2VxLCBwLCBob3N0
X2xzX2xvd19wb3dlcl9waHlfY2xrKTsNCj4gKwlwcmludF9wYXJhbShzZXEsIHAsIGFjdGl2YXRl
X3N0bV9mc190cmFuc2NlaXZlcik7DQo+ICsJcHJpbnRfcGFyYW0oc2VxLCBwLCBhY3RpdmF0ZV9z
dG1faWRfdmJfZGV0ZWN0aW9uKTsNCj4gICAJcHJpbnRfcGFyYW0oc2VxLCBwLCB0c19kbGluZSk7
DQo+ICAgCXByaW50X3BhcmFtKHNlcSwgcCwgcmVsb2FkX2N0bCk7DQo+ICAgCXByaW50X3BhcmFt
X2hleChzZXEsIHAsIGFoYmNmZyk7DQo+IA0KDQo=
