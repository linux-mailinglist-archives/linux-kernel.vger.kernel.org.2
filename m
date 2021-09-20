Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6729F4118D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbhITQGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:06:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:58493 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238046AbhITQGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:06:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="223200297"
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="223200297"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 09:04:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="612592589"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 20 Sep 2021 09:04:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 20 Sep 2021 09:04:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 20 Sep 2021 09:04:35 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Mon, 20 Sep 2021 09:04:35 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] x86/mce: Get rid of machine_check_vector
Thread-Topic: [PATCH 2/4] x86/mce: Get rid of machine_check_vector
Thread-Index: AQHXq7JZqQ9bryoS2UW7jIyiI+uv+ausYIyAgACsBICAAAwU4A==
Date:   Mon, 20 Sep 2021 16:04:35 +0000
Message-ID: <d090a19ce8f74b0ea557f180d185df3e@intel.com>
References: <20210917105355.2368-1-bp@alien8.de>
 <20210917105355.2368-3-bp@alien8.de>
 <YUgUpXHciLMn4X20@agluck-desk2.amr.corp.intel.com> <YUhCg/dQLEeaYM+T@zn.tnic>
In-Reply-To: <YUhCg/dQLEeaYM+T@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJdCBpcyB0aGVyZSB0byB0ZWxsIHlvdSBob3cgbWFueSBiaXRzIHlvdSBoYXZlIGxlZnQgc28g
dGhhdCB5b3UgZG9uJ3QNCj4gaGF2ZSB0byBjb3VudCBlYWNoIHRpbWUuIEFuZCB1cGRhdGluZyBp
dCBlYWNoIHRpbWUgaXMgc2ltcGx5IEN0cmwteCBpbg0KPiB2aW0uDQoNCllvdSB3YW50IHRvIGtu
b3cgaG93IG1hbnkgYml0IGFyZSBsZWZ0IGZvciBzb21lIHJlYXNvbj8gIElzIHRoZXJlIHNvbWUN
CnVzZXIgQVBJIHRoYXQgd2lsbCBicmVhayBpZiB3ZSBvdmVyZmxvdyBhbmQgc3RhcnQgYWxsb2Nh
dGluZyBiaXRzIGZyb20gdGhlIG5leHQNCjY0LWJpdCB3b3JkPyBPciBpcyB0aGlzIGp1c3QgdGhl
IGNvdW50ZG93biBmb3Igd2hlbiB5b3UgYW5kIEkgYm90aCBoYXZlIGEgbmVydm91cw0KYnJlYWtk
b3duIHRyeWluZyB0byBrZWVwIHRyYWNrIG9mIHRoYXQgbWFueSBkaWZmZXJlbnQgb3B0aW9uIHBh
dGhzIHRocm91Z2ggdGhlDQptYWNoaW5lIGNoZWNrIGNvZGUgOi0pDQoNClRoYW5rcyBmb3IgdGhl
IHRpcCBhYm91dCBDdHJsLXggdG8gZGVjcmVtZW50IGEgbnVtYmVyIGluIHZpbSAoR29vZ2xlDQp0
ZWxsIG1lIEN0cmwtYSBpbmNyZW1lbnRzKS4gTGVhcm5lZCBzb21ldGhpbmcgbmV3IHRvZGF5IDot
KQ0KDQotVG9ueQ0K
