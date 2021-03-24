Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0D3347CC4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbhCXPfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:35:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:6915 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236629AbhCXPfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:35:05 -0400
IronPort-SDR: GLBuNMQKnEite8bpbcIFgbpV1EucRfqNss+HTZvsdxS48IPENU/mrQ1HXOWCsKhXPJWzVNT+io
 9SqnvENmEfrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="177846322"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="177846322"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 08:35:04 -0700
IronPort-SDR: u88QPQP9OqThtSCWmlBumzh8Ily4n5DsBwOciDJ/LVBkU/p/by/3yXpi6gxcLVwDqmg7kDJM1t
 auTRLm+JOr9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="408900965"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 24 Mar 2021 08:35:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 24 Mar 2021 08:35:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 24 Mar 2021 08:35:03 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Wed, 24 Mar 2021 08:35:03 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Song, Youquan" <youquan.song@intel.com>
Subject: RE: [PATCH] x86/mce: Add Skylake quirk for patrol scrub reported
 errors
Thread-Topic: [PATCH] x86/mce: Add Skylake quirk for patrol scrub reported
 errors
Thread-Index: AQHXH2vrxdAXwArxf0GPI/vTElW+BqqTsz4A//+TlNA=
Date:   Wed, 24 Mar 2021 15:35:03 +0000
Message-ID: <5dfbe1167e2f4978a8add0c84e3fb064@intel.com>
References: <20210322223710.307123-1-tony.luck@intel.com>
 <20210324150004.GG5010@zn.tnic>
In-Reply-To: <20210324150004.GG5010@zn.tnic>
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

PiBZZWFoLCBpbnRvDQo+IA0KPiBmZDI1OGRjNDQ0MmMgKCJ4ODYvbWNlOiBBZGQgU2t5bGFrZSBx
dWlyayBmb3IgcGF0cm9sIHNjcnViIHJlcG9ydGVkIGVycm9ycyIpDQoNClRoYW5rcyAuLi4gbXkg
bWVtb3J5IGlzIGZhaWxpbmcsIGFuZCBJIGZvcmdvdCB0aGF0IHRoZSBwYXRjaCBoYWQgYmVlbiBp
bXByb3ZlZCBhbmQNCm1vdmVkIGZyb20gY29yZS5jICh3aGVyZSBJIGxvb2tlZCBmb3IgaXQpIGlu
dG8gc2V2ZXJpdHkuYw0KDQotVG9ueQ0KDQo=
