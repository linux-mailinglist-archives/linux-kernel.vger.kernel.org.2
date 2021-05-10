Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FD53797EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 21:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhEJTud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 15:50:33 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:52958 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230002AbhEJTua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 15:50:30 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CD903401D6;
        Mon, 10 May 2021 19:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1620676165; bh=OYB4pdHk2wMg2NkGAXwLhfFgvR8ApmxO6EXFfnAu4R0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=UpkcjfC3bQSwdDRthw7fBgFA95ssHc9lIpzvBqOz01fmX6EEN3zIyCesQaUE/itnc
         PeyxjuNYqheAjIFRSYwABdwv802TTXHAZYMu7WsK4duUHj7Hz3Rx8K68h2VrXmBZX4
         kOkCcFov3Bq7h6eYlEt4sDqgnVD0ymhcYx+VPsH7ovTHSEF4iUShyNbl+RG5HeO3YW
         5A4l6hokXDMHGvX7cjNJ4/FY4qoYJYM4efFjGY5DlLWkaaEnXIg9yVddNIUABntr92
         DPO+tYUjKwpbFoELDJveQG4iLBAdwgDx4XWBHb3NMny9gS7d1owLkEce6rhVPgHJh9
         ElPyFGUSo8VIg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 43DD3A0079;
        Mon, 10 May 2021 19:49:09 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id AA980400BA;
        Mon, 10 May 2021 19:49:00 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="l4HwUujv";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsb4HWK8d5TAJTchAaDvZc9TtcmGL+rfa/wWosasRCB88pwdL16WO477qRgW1jIly0B77IAnsEn5mPq61DF0KSZsCU13ZNrxBmhbzhfjhSuau5gb7/ZMfoQmNWBMYPi2vuNbMh7kWjA/1HHdwkkXpamhqUIqqMBAvmO4uzth0h+8vvCjGWOcF2Bbqc0f1d4aTpn6uOgLnGBZmoAeO1hrE6xUCEuP0krelR51Q/v09mdlS3lUUtEmXwFAdAM/ETLsFfbb87KOdBR7jsXdQhXHSp/w0POBC+Z03jhZDBQ3ka6c/upnlAD/PIjofq38Ez8ee8JM1DdSDU8SWx79VyOx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYB4pdHk2wMg2NkGAXwLhfFgvR8ApmxO6EXFfnAu4R0=;
 b=IkBd6bp5Xg258MZ9ijq5tG4tN1FEHGHJQ0zqNX+7v/MCkORNwrQ0sNlPoUbR08b2Nv8p28SsWoFFsP49u3N9nbsitz+fu7rC/wSCm3En9zRVDI0QS9/+JpD9jZq4pi+E4NbJb8DrL/KsFW1PQEUps6UgErtbHc3Uj7jP8Ul88mOKX3had8q7a4hkQ2NsvswOLVtFfSa5lus78XrACCL+r7o5vdjE+NQPJfqMmWYdU0kVGb8sLm8ZxbVuukCjJ/1KdPwkyR4i0dZsECA9m9RPjGxINKpLy2670+nEDl6A0XyeXPmtq0QdI72lyWSZQg3W12sx9MotvNofHdy0b9iM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYB4pdHk2wMg2NkGAXwLhfFgvR8ApmxO6EXFfnAu4R0=;
 b=l4HwUujvWqvW4VkQWWKi0L+nwGHMfVjbUqaIJZrFpKB+RbmudB47BVivk9EIEbM9adzwSmnqVS3ZdO+1nGijhQVJultTAQo61K4E4Mwhdo9/UxaepwECLuCl+5t0FagpaO/rBIHqjaCKd9JvY+BPldY1hPYVRb0YXNmP2I8uD8M=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3301.namprd12.prod.outlook.com (2603:10b6:a03:130::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 19:48:58 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 19:48:58 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bcain@codeaurora.org" <bcain@codeaurora.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "chris@zankel.net" <chris@zankel.net>,
        "dalias@libc.org" <dalias@libc.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "jonas@southpole.se" <jonas@southpole.se>,
        "ley.foon.tan@intel.com" <ley.foon.tan@intel.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "nickhu@andestech.com" <nickhu@andestech.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "rth@twiddle.net" <rth@twiddle.net>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "stefan.kristiansson@saunalahti.fi" 
        <stefan.kristiansson@saunalahti.fi>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 14/33] locking/atomic: arc: move to ARCH_ATOMIC
Thread-Topic: [PATCH 14/33] locking/atomic: arc: move to ARCH_ATOMIC
Thread-Index: AQHXRYCbGoHjSahYnE+0haoAn83hG6rczrqAgABRTIA=
Date:   Mon, 10 May 2021 19:48:58 +0000
Message-ID: <0d173b5f-a9cb-a158-a578-30a33517dda7@synopsys.com>
References: <20210510093753.40683-1-mark.rutland@arm.com>
 <20210510093753.40683-15-mark.rutland@arm.com>
 <20210510145759.GB92897@C02TD0UTHF1T.local>
In-Reply-To: <20210510145759.GB92897@C02TD0UTHF1T.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 778666cf-caaf-4926-21fa-08d913eca738
x-ms-traffictypediagnostic: BYAPR12MB3301:
x-microsoft-antispam-prvs: <BYAPR12MB3301CD525E9617070ACF7F4BB6549@BYAPR12MB3301.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FJBx6glj0KuF+ZrwzYF611EuTIOuS6VeF5h8jXp474jM3GiCCkljaXRei99JOQ17F7oeB1o8ma5k8hP4hdJzq3Rm6bLSq/wAfybW3HFKc7uHLVOoQ0n19hLElDjOyraQw3QX/YKjV4Dp1MM3YL6HLL9fnK24yD2Y7N2ndDRThY7t5lq7XPw99zJoLhuRIz6UPSZei8RxzeiPAiMrtQrGnnKIDj7mScpc+usrHcoLBkn1D7FAnGt87XdJHPyIunNXZ6Gkf6yvMtBdhFb19rNzbLxVc6C/dkGQtfE97ENStmIoghXlrcBbx1kq4eYEeG8nrcetXYDk4BByIuReE8owf23Lq1kKTWeaMg9GiDiV6ulx72KZrfSH27e8amjG5UvvFcgdiyodWCkVLPjU7J95t2Z6VDFeVgAhj71KeYkRgGdarzneiGAJGgyYyGGt7etzrYf0mFWmAzq0ubPtxh7Un4pIP4zXGFBBfQOhxbWSGA+5i9WmPm/+EixBHeeKRlkyRRaQECGHd5yRbbqqQdSPJ8J0nkSt5liQ1JkvFhIhiCMxrd+oRduKYGYWh1sS2MCndxv2Et3DQqznEVCipUBI26ko/cqnqSlHmOcrqNxK6TlPHfZIHuQ2tnDgl3lLOFcLxpXLdKDhr4NlneJUe43xj96gtb4/d9EMABPceywuKerLMlpq3vwtPHd8LOaxLFRH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(396003)(39860400002)(53546011)(54906003)(110136005)(6506007)(2616005)(478600001)(4326008)(186003)(122000001)(8676002)(6486002)(2906002)(83380400001)(71200400001)(26005)(64756008)(76116006)(38100700002)(66556008)(6512007)(5660300002)(7416002)(316002)(8936002)(86362001)(7406005)(36756003)(31696002)(31686004)(66476007)(66446008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aDNFdE1zZ1hxQW5KZURLQ0d5NXc5Mk1YSTV2c0dDVmtXSmJ4aEtlZlBzeVl2?=
 =?utf-8?B?d3VrNFRYVXF6My9MTVh4cCtjbUVIbXh6c2xRc2NaVWJaaTFNRlRVdDRybFAy?=
 =?utf-8?B?NDJtamt2OHhzdEwwTngyRFFBM1F2WUpXbTFodkF2QnBpNzY1TFUvTkZGVXFW?=
 =?utf-8?B?a0cva2Y2V2JaOGx0aXpBL0pRdHY1Sk5vR3pFRmYvL0UyU1ZiNWQ2ZjdZSVJo?=
 =?utf-8?B?SWFJYnFXNlYyT2ozS0k4b01uWDRZV1VjRlVaTktPSXlsN2gwU3JXSm5JdnJq?=
 =?utf-8?B?OWxWdStLcnFZVWFVa1ZtbUNLSWh1Q1RGbFNUcHorRUkzQWFGMk8wMVhJcklk?=
 =?utf-8?B?TzdPeTIwRmFhWnBIZzhJaHV3K21Va29XR0ZiNHV4Tm82TmprRnhpR3YwYVo5?=
 =?utf-8?B?MVBmcGZFOTAycWRnK2dnTHd4S2NqKzlVcWVTODZoTW1uZHBNZU13a1hocndT?=
 =?utf-8?B?QzU4b1RjbjhiSGYzdnk2OU5jSFdITkRZdjlmS3NDMGNrVEU4WFdYVzEvamVY?=
 =?utf-8?B?dFZScXF5N2xJQkorQzR5UFh4WEJjMU5LR0NUOGIwNHlvdCs2QUtHUGc0eEk3?=
 =?utf-8?B?ZHB4UFRIdkN6K2JqWlMvN3ByUkhSK0picGhabjVMK01KSzU0ai9CN1lUS290?=
 =?utf-8?B?R1Y1RE03Wlo1QXd2K2xRVWhwT3l3Yjc3K3NXc2JoaUY3a2ZGZEEzWGo3VWxG?=
 =?utf-8?B?ZUl2b2RoRi9vV2NHbjBobnVBUlhJTi9lZDlJL2xqRjczV29uOFVuYmk3ellv?=
 =?utf-8?B?Y1ExTmY3dlI3Nkx0VTF6RlhtYzNtV2JvYzNxSDdWTThZZnF5TGpHQWxiSHhy?=
 =?utf-8?B?RlVxWUd0MlVTeS9tb0doU1ZPc2ZHVTV4RU9nNWVmRUFmZ0pVOUZQeFhmYmNu?=
 =?utf-8?B?dzVjb1FIblMvMFNiMC9GZHBQWlpxUTNNcGthOEt2OWpRNFFYZ2Y3SGh0dXJz?=
 =?utf-8?B?S3NyRS9UZXJFT2M0YnhkZE9ScE9mdDBZVFdRSUpZemRYR2FHT3Z3UDAraGs4?=
 =?utf-8?B?eEV3NmlhbGtOZ0dHUUt6em0vZ1JSQW84STNqMjJpZFYxU0tsT3YrbDg4NXQy?=
 =?utf-8?B?dk9uSkUrc1JIMDZENDdjclczVVZka0ppU0Q4blhEZjhuc1hHcnF3c1pyT1Ar?=
 =?utf-8?B?Yk54WVBjbXU2MGxFY01xNERCRGQ0d005WVk0bFVOQ3EvVjVVbmpMR05KSWow?=
 =?utf-8?B?TDJYUVFEZ0loaFZkdEJYMlo3Q1gzTDNrcnZsUFpBTGk5a2ViY1QzcnBiZUI0?=
 =?utf-8?B?Yzg4SUV2Sys0ai9XMGV1a21mOFo1RmhJMTV4cWIxWC9MVW1CWk9lWmxpNmxZ?=
 =?utf-8?B?UnBHaDJiWWthVHNwVXFLS2kwaCtCcG9GaGpEQ21ETkFWNFNHMWFJNGhPSWpi?=
 =?utf-8?B?QzlQalpqcWlMWldSa1JPbmxKM1U4djY5VG9nZGRNMXRzaEdIcHVWTEw0NkJl?=
 =?utf-8?B?ZmpwUVRYUEp1MWJZSzNjNTZ3Ni9aSWc5SW80RXEzelFURGpYcjdGWDBqWDVo?=
 =?utf-8?B?SUJLR2ZRdWhpK0ZMRkFlTTVaZHoralg3dlcvM2JMeHlaSUNHbkVNVUhFVURK?=
 =?utf-8?B?c2t2WWRTVUtaaUpBQjYxUkxITWI0bDJGR0FBdjk3MXhRbGMzT3lFWXZUcWg1?=
 =?utf-8?B?OXJ1bVpRTWlTMFBXZ1BMUmZXNkhFRkU5ZzlGZzBTMnpMZFNTMHNvbllFOVFG?=
 =?utf-8?B?RzBTa3RsdzhQUnhNSG1SSGFRWS8rVHg1aTJPU08ydDFwTUY3UVd0azI5ZEFQ?=
 =?utf-8?Q?0h11+yU6L8odcxaULg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF7CAF1F5440F243962CA201FB9203AB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778666cf-caaf-4926-21fa-08d913eca738
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 19:48:58.6550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cITZTd5SmF3j9ehyEY2vI4/lBZahm5Aog45xj7gr8GKbB7TVlOHpctknXhckYIQjRyfsfImdPR1BxTmSZ16Bfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3301
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8xMC8yMSA3OjU3IEFNLCBNYXJrIFJ1dGxhbmQgd3JvdGU6DQo+IE9uIE1vbiwgTWF5IDEw
LCAyMDIxIGF0IDEwOjM3OjM0QU0gKzAxMDAsIE1hcmsgUnV0bGFuZCB3cm90ZToNCj4+IFdlJ2Qg
bGlrZSBhbGwgYXJjaGl0ZWN0dXJlcyB0byBjb252ZXJ0IHRvIEFSQ0hfQVRPTUlDLCBhcyBvbmNl
IGFsbA0KPj4gYXJjaGl0ZWN0dXJlcyBhcmUgY29udmVydGVkIGl0IHdpbGwgYmUgcG9zc2libGUg
dG8gbWFrZSBzaWduaWZpY2FudA0KPj4gY2xlYW51cHMgdG8gdGhlIGF0b21pY3MgaGVhZGVycywg
YW5kIHRoaXMgd2lsbCBtYWtlIGl0IG11Y2ggZWFzaWVyIHRvDQo+PiBnZW5lcmljYWxseSBlbmFi
bGUgYXRvbWljIGZ1bmN0aW9uYWxpdHkgKGUuZy4gZGVidWcgbG9naWMgaW4gdGhlDQo+PiBpbnN0
cnVtZW50ZWQgd3JhcHBlcnMpLg0KPj4NCj4+IEFzIGEgc3RlcCB0b3dhcmRzIHRoYXQsIHRoaXMg
cGF0Y2ggbWlncmF0ZXMgYXJjIHRvIEFSQ0hfQVRPTUlDLiBUaGUgYXJjaA0KPj4gY29kZSBwcm92
aWRlcyBhcmNoX3thdG9taWMsYXRvbWljNjQseGNoZyxjbXB4Y2hnfSooKSwgYW5kIGNvbW1vbiBj
b2RlDQo+PiB3cmFwcyB0aGVzZSB3aXRoIG9wdGlvbmFsIGluc3RydW1lbnRhdGlvbiB0byBwcm92
aWRlIHRoZSByZWd1bGFyDQo+PiBmdW5jdGlvbnMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTWFy
ayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4NCj4+IENjOiBCb3F1biBGZW5nIDxib3F1
bi5mZW5nQGdtYWlsLmNvbT4NCj4+IENjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVh
ZC5vcmc+DQo+PiBDYzogVmluZWV0IEd1cHRhIDx2Z3VwdGFAc3lub3BzeXMuY29tPg0KPj4gQ2M6
IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQoNCkFja2VkLWJ5OiBWaW5lZXQgR3VwdGEg
PHZndXB0YUBzeW5vcHN5cyxjb20+wqDCoMKgICNhcmNoL2FyYw0KDQpGV0lXLCBJIGRvIGhhdmUg
YSBidW5jaCBvZiBBUkMgc3BlY2lmaWMgY2xlYW51cHMgYW5kIHVwZGF0ZXMgZm9yIA0KYXRvbWlj
cy9iaXRvcHMvY21weGNoZyBmcm9tIG15IGFyYzY0IHdvcmssIHdoaWNoIEknbSBwbGFubmluZyB0
byBzZW5kIA0Kb3V0IHNvb24uIFRoYXQgd2lsbCBiZSBpbmRlcGVuZGVudCBvZiB0aGlzIGNoYW5n
ZXNldCBmb3Igbm93LCBidXQgd2UnbGwgDQpoYXZlIHRoaXMgb25lIG1lcmdlIGZpcnN0Lg0KDQpU
aHggZm9yIGRvaW5nIHRoaXMuDQotVmluZWV0DQoNCj4+IC0tLQ0KPj4gICBhcmNoL2FyYy9LY29u
ZmlnICAgICAgICAgICAgICAgfCAgMSArDQo+PiAgIGFyY2gvYXJjL2luY2x1ZGUvYXNtL2F0b21p
Yy5oICB8IDU2ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4g
ICBhcmNoL2FyYy9pbmNsdWRlL2FzbS9jbXB4Y2hnLmggfCAgOCArKystLS0NCj4+ICAgMyBmaWxl
cyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAzMiBkZWxldGlvbnMoLSkNCj4gSSBldmlkZW50
bHkgbWlzc2VkIGF0b21pY194Y2hnKCkgaW4gYXNtL2NtcHhjaGcuaCwgc28gdGhlIGZpeHVwIGJl
bG93IGlzDQo+IG5lZWRlZC4gSSd2ZSBwdXNoZWQgdGhhdCB0byBteSBicmFuY2ggb24ga2VybmVs
Lm9yZyBmb3Igbm93Lg0KPg0KPiBNYXJrLg0KPg0KPiAtLS0tPjgtLS0tDQo+IGRpZmYgLS1naXQg
YS9hcmNoL2FyYy9pbmNsdWRlL2FzbS9jbXB4Y2hnLmggYi9hcmNoL2FyYy9pbmNsdWRlL2FzbS9j
bXB4Y2hnLmgNCj4gaW5kZXggODc2NjY5ODBiNzhhLi5kMTc4MWJkZjY1MjcgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvYXJjL2luY2x1ZGUvYXNtL2NtcHhjaGcuaA0KPiArKysgYi9hcmNoL2FyYy9pbmNs
dWRlL2FzbS9jbXB4Y2hnLmgNCj4gQEAgLTE1Myw2ICsxNTMsNiBAQCBzdGF0aWMgaW5saW5lIHVu
c2lnbmVkIGxvbmcgX194Y2hnKHVuc2lnbmVkIGxvbmcgdmFsLCB2b2xhdGlsZSB2b2lkICpwdHIs
DQo+ICAgICogICAgICAgICBjYW4ndCBiZSBjbG9iYmVyZWQgYnkgb3RoZXJzLiBUaHVzIG5vIHNl
cmlhbGl6YXRpb24gcmVxdWlyZWQgd2hlbg0KPiAgICAqICAgICAgICAgYXRvbWljX3hjaGcgaXMg
aW52b2x2ZWQuDQo+ICAgICovDQo+IC0jZGVmaW5lIGF0b21pY194Y2hnKHYsIG5ldykgKHhjaGco
JigodiktPmNvdW50ZXIpLCBuZXcpKQ0KPiArI2RlZmluZSBhcmNoX2F0b21pY194Y2hnKHYsIG5l
dykgKGFyY2hfeGNoZygmKCh2KS0+Y291bnRlciksIG5ldykpDQo+ICAgDQo+ICAgI2VuZGlmDQoN
Cg==
