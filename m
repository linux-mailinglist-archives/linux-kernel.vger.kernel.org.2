Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED2433FCA1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 02:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCRBWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 21:22:51 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55691 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCRBW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 21:22:29 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12I1L4CG0017885, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs02.realtek.com.tw[172.21.6.95])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12I1L4CG0017885
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Mar 2021 09:21:04 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 09:21:03 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::6caa:5fa6:24e2:bbef]) by
 RTEXMBS01.realtek.com.tw ([fe80::6caa:5fa6:24e2:bbef%7]) with mapi id
 15.01.2106.013; Thu, 18 Mar 2021 09:21:03 +0800
From:   Jack Yu <jack.yu@realtek.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        =?utf-8?B?a2VudF9jaGVuQHJlYWx0ZWsuY29tIFvpmbPlu7rlro9d?= 
        <kent_chen@realtek.com>
CC:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Libin Yang <libin.yang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Dharageswari R <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] ASoC: Intel: sof_rt5682: Add ALC1015Q-VB speaker amp support
Thread-Topic: [PATCH v3] ASoC: Intel: sof_rt5682: Add ALC1015Q-VB speaker amp
 support
Thread-Index: AQHXGzY5g4Pry5OlPUKQGENVoO6uRKqI8mXQ
Date:   Thu, 18 Mar 2021 01:21:03 +0000
Message-ID: <7f91482a93aa4d429ee574d730eeca6a@realtek.com>
References: <20210317110824.20814-1-brent.lu@intel.com>
 <af990f6f-3a8b-3a1e-a02a-3bfe96e4d80a@linux.intel.com>
In-Reply-To: <af990f6f-3a8b-3a1e-a02a-3bfe96e4d80a@linux.intel.com>
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

PiA+IFRoaXMgcGF0Y2ggYWRkcyBqc2xfcnQ1NjgyX3J0MTAxNXAgd2hpY2ggc3VwcG9ydHMgdGhl
IFJUNTY4MiBoZWFkc2V0DQo+ID4gY29kZWMgYW5kIEFMQzEwMTVRLVZCIHNwZWFrZXIgYW1wbGlm
aWVyIGNvbWJpbmF0aW9uIG9uIEphc3Blckxha2UNCj4gPiBwbGF0Zm9ybS4NCj4gPg0KPiA+IFRo
aXMgZHJpdmVyIGFsc28gc3VwcG9ydHMgQUxDMTAxNVEtQ0cgaWYgcnVubmluZyBpbiBhdXRvLW1v
ZGUuDQo+ID4gRm9sbG93aW5nIHRhYmxlIHNob3dzIHRoZSBhdWRpbyBpbnRlcmZhY2Ugc3VwcG9y
dCBvZiB0aGUgdHdvDQo+ID4gYW1wbGlmaWVycy4NCj4gPg0KPiA+ICAgICAgICAgICAgfCBBTEMx
MDE1US1DRyB8IEFMQzEwMTVRLVZCDQo+ID4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KPiA+IEkyQyAgICAgICB8IFllcyAgICAgICAgIHwgTm8NCj4gPiBBdXRvLW1vZGUg
fCA0OEssIDY0ZnMgICB8IDE2aywgMzJmcw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICB8
IDQ4aywgMzJmcw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDQ4aywgNjRmcw0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogQnJlbnQgTHUgPGJyZW50Lmx1QGludGVsLmNvbT4NCj4gDQo+
IFRoZSBjb2RlIGlzIGxvb2tzIGZpbmUsIGJ1dCBKYWNrIFl1IGFkZGVkIGEgc2VwYXJhdGUgcGF0
Y2ggdGhhdCBtYWtlcw0KPiBSVEwxMDE5IGVxdWl2YWxlbnQgdG8gUlRMMTAxNSwgc28gc2hvdWxk
IHRoaXMgcGF0Y2ggYWxzbyBoYW5kbGUgdGhlDQo+IFJUTDEwMTkgY2FzZT8NCj4gDQpGb3IgcnQx
MDE5IG5vbi1pMmMgbW9kZSAoYXV0byBtb2RlKSwgaXQgdXNlcyB0aGUgc2RiIHBpbiB0byBlbmFi
bGUgYW1wLCB0aGUgc2FtZSBhcyBydDEwMTUgbm9uLWkyYyBtb2RlLA0KdGhlcmVmb3JlIHdlIHBy
b3Bvc2UgcnQxMDE5KGF1dG8gbW9kZSkgdG8gdXNlIHJ0MTAxNXAgaW5zdGVhZCBvZiBhZGRpbmcg
YSBuZXcgZHJpdmVyIGZvciBpdC4NCg==
