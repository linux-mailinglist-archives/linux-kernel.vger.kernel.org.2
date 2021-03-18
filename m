Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A159B33FCA7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 02:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCRBX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 21:23:26 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55743 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhCRBXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 21:23:04 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12I1LkGY2017919, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs03.realtek.com.tw[172.21.6.96])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12I1LkGY2017919
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Mar 2021 09:21:46 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 09:21:46 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 09:21:45 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::6caa:5fa6:24e2:bbef]) by
 RTEXMBS01.realtek.com.tw ([fe80::6caa:5fa6:24e2:bbef%7]) with mapi id
 15.01.2106.013; Thu, 18 Mar 2021 09:21:45 +0800
From:   Jack Yu <jack.yu@realtek.com>
To:     "Lu, Brent" <brent.lu@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        =?utf-8?B?a2VudF9jaGVuQHJlYWx0ZWsuY29tIFvpmbPlu7rlro9d?= 
        <kent_chen@realtek.com>
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
Thread-Index: AQHXGzY5g4Pry5OlPUKQGENVoO6uRKqHynaAgAEpDaA=
Date:   Thu, 18 Mar 2021 01:21:45 +0000
Message-ID: <5c750391ceb349d2aaf403f038fc7394@realtek.com>
References: <20210317110824.20814-1-brent.lu@intel.com>
 <af990f6f-3a8b-3a1e-a02a-3bfe96e4d80a@linux.intel.com>
 <DM6PR11MB364290806B23636B6D0618DF976A9@DM6PR11MB3642.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB364290806B23636B6D0618DF976A9@DM6PR11MB3642.namprd11.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.102.167]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFRoZSBjb2RlIGlzIGxvb2tzIGZpbmUsIGJ1dCBKYWNrIFl1IGFkZGVkIGEgc2VwYXJhdGUg
cGF0Y2ggdGhhdCBtYWtlcw0KPiA+IFJUTDEwMTkgZXF1aXZhbGVudCB0byBSVEwxMDE1LCBzbyBz
aG91bGQgdGhpcyBwYXRjaCBhbHNvIGhhbmRsZSB0aGUNCj4gPiBSVEwxMDE5IGNhc2U/DQo+IA0K
PiBUaGUgdG9wb2xvZ3kgdXNlZCBieSB0aGlzIG1hY2hpbmUgZHJpdmVyIGlzIHVzaW5nIDQ4aywg
NjRmcyBJMlMgZm9ybWF0Lg0KPiBSVDEwMTkgbmVlZHMgdG8gc3VwcG9ydCB0aGlzIGNvbmZpZ3Vy
YXRpb24uIE5vdCBzdXJlIGlmIFJUMTAxOSBjb3VsZCBzdXBwb3J0DQo+IHRoYXQuDQo+IA0KDQpZ
ZXMsIFJUMTAxOSBzdXBwb3J0cyA0OGssIDY0ZnMgSTJTIGZvcm1hdC4NCg==
