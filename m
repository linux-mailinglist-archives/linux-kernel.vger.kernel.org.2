Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF4033FD29
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCRCUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:20:13 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37880 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhCRCUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:20:06 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12I2JJ460004207, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12I2JJ460004207
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Mar 2021 10:19:19 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 10:19:19 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 10:19:19 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::6caa:5fa6:24e2:bbef]) by
 RTEXMBS01.realtek.com.tw ([fe80::6caa:5fa6:24e2:bbef%7]) with mapi id
 15.01.2106.013; Thu, 18 Mar 2021 10:19:19 +0800
From:   =?utf-8?B?a2VudF9jaGVuQHJlYWx0ZWsuY29tIFvpmbPlu7rlro9d?= 
        <kent_chen@realtek.com>
To:     Jack Yu <jack.yu@realtek.com>, "Lu, Brent" <brent.lu@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "Jie Yang" <yang.jie@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        Libin Yang <libin.yang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] ASoC: Intel: sof_rt5682: Add ALC1015Q-VB speaker amp support
Thread-Topic: [PATCH v3] ASoC: Intel: sof_rt5682: Add ALC1015Q-VB speaker amp
 support
Thread-Index: AQHXGzY5g4Pry5OlPUKQGENVoO6uRKqHynaAgAEpDaCAAA4VgA==
Date:   Thu, 18 Mar 2021 02:19:19 +0000
Message-ID: <d306b9a317f644b8becd1185093696ba@realtek.com>
References: <20210317110824.20814-1-brent.lu@intel.com>
 <af990f6f-3a8b-3a1e-a02a-3bfe96e4d80a@linux.intel.com>
 <DM6PR11MB364290806B23636B6D0618DF976A9@DM6PR11MB3642.namprd11.prod.outlook.com>
 <5c750391ceb349d2aaf403f038fc7394@realtek.com>
In-Reply-To: <5c750391ceb349d2aaf403f038fc7394@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.237.21]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXBkYXRlIG1vcmUgQUxDMTAxOSBzYW1wbGUgcmF0ZQ0KMTZLLzQ0LjFLLzQ4Sy85NksNCjMyZnMv
NjRmcw0KSTJTIGZvcm1hdA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFj
ayBZdSA8amFjay55dUByZWFsdGVrLmNvbT4gDQpTZW50OiBUaHVyc2RheSwgTWFyY2ggMTgsIDIw
MjEgOToyMiBBTQ0KVG86IEx1LCBCcmVudCA8YnJlbnQubHVAaW50ZWwuY29tPjsgUGllcnJlLUxv
dWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbT47IGFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsga2VudF9jaGVuQHJlYWx0ZWsuY29tIFvpmbPlu7rlro9d
IDxrZW50X2NoZW5AcmVhbHRlay5jb20+DQpDYzogT2RlciBDaGlvdSA8b2Rlcl9jaGlvdUByZWFs
dGVrLmNvbT47IExpYW0gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFpbC5jb20+OyBNYXJrIEJyb3du
IDxicm9vbmllQGtlcm5lbC5vcmc+OyBKYXJvc2xhdiBLeXNlbGEgPHBlcmV4QHBlcmV4LmN6Pjsg
VGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmNvbT47IFJvamV3c2tpLCBDZXphcnkgPGNlemFyeS5y
b2pld3NraUBpbnRlbC5jb20+OyBKaWUgWWFuZyA8eWFuZy5qaWVAbGludXguaW50ZWwuY29tPjsg
S2FpIFZlaG1hbmVuIDxrYWkudmVobWFuZW5AbGludXguaW50ZWwuY29tPjsgR3Vlbm5hZGkgTGlh
a2hvdmV0c2tpIDxndWVubmFkaS5saWFraG92ZXRza2lAbGludXguaW50ZWwuY29tPjsgUmFuZGVy
IFdhbmcgPHJhbmRlci53YW5nQGxpbnV4LmludGVsLmNvbT47IFpoaSwgWW9uZyA8eW9uZy56aGlA
aW50ZWwuY29tPjsgTGliaW4gWWFuZyA8bGliaW4ueWFuZ0BsaW51eC5pbnRlbC5jb20+OyBSYW5q
YW5pIFNyaWRoYXJhbiA8cmFuamFuaS5zcmlkaGFyYW5AbGludXguaW50ZWwuY29tPjsgTnVqZWxs
YSwgU2F0aHlhbmFyYXlhbmEgPHNhdGh5YW5hcmF5YW5hLm51amVsbGFAaW50ZWwuY29tPjsgUiwg
RGhhcmFnZXN3YXJpIDxkaGFyYWdlc3dhcmkuckBpbnRlbC5jb20+OyBLdW5pbm9yaSBNb3JpbW90
byA8a3VuaW5vcmkubW9yaW1vdG8uZ3hAcmVuZXNhcy5jb20+OyBGcmVkIE9oIDxmcmVkLm9oQGxp
bnV4LmludGVsLmNvbT47IFR6dW5nLUJpIFNoaWggPHR6dW5nYmlAZ29vZ2xlLmNvbT47IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJFOiBbUEFUQ0ggdjNdIEFTb0M6IElu
dGVsOiBzb2ZfcnQ1NjgyOiBBZGQgQUxDMTAxNVEtVkIgc3BlYWtlciBhbXAgc3VwcG9ydA0KDQo+
ID4gVGhlIGNvZGUgaXMgbG9va3MgZmluZSwgYnV0IEphY2sgWXUgYWRkZWQgYSBzZXBhcmF0ZSBw
YXRjaCB0aGF0IA0KPiA+IG1ha2VzDQo+ID4gUlRMMTAxOSBlcXVpdmFsZW50IHRvIFJUTDEwMTUs
IHNvIHNob3VsZCB0aGlzIHBhdGNoIGFsc28gaGFuZGxlIHRoZQ0KPiA+IFJUTDEwMTkgY2FzZT8N
Cj4gDQo+IFRoZSB0b3BvbG9neSB1c2VkIGJ5IHRoaXMgbWFjaGluZSBkcml2ZXIgaXMgdXNpbmcg
NDhrLCA2NGZzIEkyUyBmb3JtYXQuDQo+IFJUMTAxOSBuZWVkcyB0byBzdXBwb3J0IHRoaXMgY29u
ZmlndXJhdGlvbi4gTm90IHN1cmUgaWYgUlQxMDE5IGNvdWxkIA0KPiBzdXBwb3J0IHRoYXQuDQo+
IA0KDQpZZXMsIFJUMTAxOSBzdXBwb3J0cyA0OGssIDY0ZnMgSTJTIGZvcm1hdC4NCg==
