Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A6030B1E8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 22:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhBAVLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 16:11:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:21775 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231902AbhBAVLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:11:09 -0500
IronPort-SDR: p8tsT1L9ZwlZNz47yh8Lb0lOoaca1rC1vUvovSISOZkgtOAB3EmmcwM/wM6VrDAIgC6xUrj3kT
 +5GQfjGlFT8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="167859662"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="167859662"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 13:10:28 -0800
IronPort-SDR: JBrvVlYaEPrZ5eMwLvz8utqqcr3uZmtAuXXLZHNag0iQa4y7z6znAth6M837rgpD6XCKI/3wfz
 v2cNV9gHItYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="355923435"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2021 13:10:28 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Feb 2021 13:10:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Feb 2021 13:10:27 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.002;
 Mon, 1 Feb 2021 13:10:27 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@kernel.org>, Aili Yao <yaoaili@kingsoft.com>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        "YANGFENG1@kingsoft.com" <YANGFENG1@kingsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Thread-Topic: [PATCH v2] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Thread-Index: AQHW+HK/MM24JfISB0eCQ1Snk3MNhapEDCKA///AFmA=
Date:   Mon, 1 Feb 2021 21:10:27 +0000
Message-ID: <2908aa061ff1494387a53128c6eadb61@intel.com>
References: <20210201161749.0e8dc212.yaoaili@kingsoft.com>
 <CALCETrWrj0LJaHTdrydH-i_OkjDb1VF76aJrAWpHA5PL2npezg@mail.gmail.com>
In-Reply-To: <CALCETrWrj0LJaHTdrydH-i_OkjDb1VF76aJrAWpHA5PL2npezg@mail.gmail.com>
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

PiBJbiBhbnkgY2FzZSwgdGhpcyBwYXRjaCBuZWVkcyByZWJhc2luZyBvbiB0b3Agb2YgbXkgYmln
IGZhdWx0IHNlcmllcw0KDQpJcyB0aGF0IHNlcmllcyBpbiBzb21lIEdJVCB0cmVlPyBPciBjYW4g
eW91IGdpdmUgYSBsb3JlLmtlcm5lbC5vcmcgbGluaz8NCg0KVGhhbmtzDQoNCi1Ub255DQo=
