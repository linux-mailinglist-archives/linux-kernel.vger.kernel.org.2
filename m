Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75088315B73
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhBJAlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:41:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:48851 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233874AbhBIVG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 16:06:28 -0500
IronPort-SDR: j4369iXQblB21ETpfHELluBA+yJ4W7zJNOAGnZqDdP59LRMsy4xDd9C9mQjOL2oEocql2th6Vb
 yO+yAPr5khTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="179401861"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="179401861"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 13:03:01 -0800
IronPort-SDR: aeOglqbKjhsOa5I08DiLx/CJW2e8FI23Ty3HojAKAdfdQ44sWcVhfVs3na8rwLeGuw3DygsxOu
 4PwxCSPnHbfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="379268818"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 09 Feb 2021 13:03:00 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 13:02:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 13:02:59 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.002;
 Tue, 9 Feb 2021 13:02:59 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Mukesh Ojha <mojha@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>
Subject: RE: Pstore : Query on using ramoops driver for DDR
Thread-Topic: Pstore : Query on using ramoops driver for DDR
Thread-Index: AQHW/yTDvb2lf+VGD0OzwuNhoo5kBqpQTkDQ
Date:   Tue, 9 Feb 2021 21:02:57 +0000
Message-ID: <e28daeb8a1d74d60a3acb5c582f92123@intel.com>
References: <f71919bd-acd1-843c-3c9b-1d518f0d7b88@codeaurora.org>
In-Reply-To: <f71919bd-acd1-843c-3c9b-1d518f0d7b88@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBDYW4gd2UgdXNlIGV4aXN0aW5nIGJhY2tlbmQgcHN0b3JlIHJhbSBkcml2ZXIgKGZzL3BzdG9y
ZS9yYW0uYykgZm9yIEREUiANCj4gaW5zdGVhZCBvZiBTUkFNID8NCg0KVGhlIGV4cGVjdGF0aW9u
IGZvciBwc3RvcmUgaXMgdGhhdCB0aGUgc3lzdGVtIHdpbGwgZ28gdGhyb3VnaCBhIHJlc2V0IHdo
ZW4gaXQNCmNyYXNoZXMuIE1vc3Qgc3lzdGVtcyBkbyBub3QgcHJlc2VydmUgRERSIGNvbnRlbnRz
IGFjcm9zcyByZXNldC4NCg0KPiBXYXMgdGhlIGN1cnJlbnQgZHJpdmVyIHdyaXR0ZW4gb25seSB0
byBzdXBwb3J0IHBlcnNpc3RhbnQgUkFNIGxpa2UgU1JBTSANCj4gb3IgaXQgY2FuIGFjY2VwdCBm
dXJ0aGVyIGNoYW5nZQ0KDQpMaW51eCBpcyBpbiBhIGNvbnN0YW50IHN0YXRlIG9mIGNoYW5nZSA6
LSkNCg0KPiB0byBzdXBwb3J0IEREUiwgSWYgd2UgaGF2ZSBhIG1lY2hhbmlzbSB0byBjb3B5IHN0
b3JlZCBkYXRhIGZyb20gRERSIHRvIA0KPiBleHRlcm5hbCBkZXZpY2UgYWZ0ZXIgdGhlIGNyYXNo
Lg0KDQpTZWUgYWJvdmUgYWJvdXQgRERSIGNvbnRlbnRzLiAgIEJ1dCBpZiB5b3UgaGF2ZSBhIHBs
YXRmb3JtIHRoYXQgZG9lcyBwcmVzZXJ2ZQ0KRERSIGNvbnRlbnRzIHVudGlsIHlvdXIgIm1lY2hh
bmlzbSIgY2FuIGNvcHkgdGhlIHBzdG9yZSBidWZmZXIsIHRoZW4gcG9zdA0KYSBwYXRjaC4NCg0K
LVRvbnkNCg==
