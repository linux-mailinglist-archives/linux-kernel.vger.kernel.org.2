Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8386B315C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhBJB2N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Feb 2021 20:28:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:21183 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234551AbhBIXPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:15:08 -0500
IronPort-SDR: etAdOsePmAyAf1N/sD47UcewexiXnZFNtt8PULqbh9jWl44ZtHzPaIvgl9/ao5OFtvWxuhdUPi
 NnhnKj5Q4GEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="266811879"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="266811879"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 15:09:33 -0800
IronPort-SDR: 5yzAWkKk+XFlauNT+vDCOmRG0EKcs2UFVztFh0aRO1avF+aMzYYmJwQFU9Ud1DeKpKo2QMaMr4
 qBH3IG8fobPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="420211131"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 09 Feb 2021 15:09:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 15:09:28 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 15:09:28 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2106.002;
 Tue, 9 Feb 2021 15:09:28 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Schofield, Alison" <alison.schofield@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>,
        "brice.goglin@gmail.com" <brice.goglin@gmail.com>
Subject: RE: [PATCH] x86, sched: Allow NUMA nodes to share an LLC on Intel
 platforms
Thread-Topic: [PATCH] x86, sched: Allow NUMA nodes to share an LLC on Intel
 platforms
Thread-Index: AQHW/zSlzL/JNCz2s0ObNbwCfjAg9apQcJ2A
Date:   Tue, 9 Feb 2021 23:09:27 +0000
Message-ID: <af770863e70340d294c324fd7004f658@intel.com>
References: <20210209223943.9834-1-alison.schofield@intel.com>
In-Reply-To: <20210209223943.9834-1-alison.schofield@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define X86_BUG_NUMA_SHARES_LLC		X86_BUG(25) /* CPU may enumerate an LLC shared by multiple NUMA nodes */

During internal review I wondered why this is a "BUG" rather than a "FEATURE" bit.

Apparently, the suggestion for "BUG" came from earlier community discussions.

Historically it may have seemed reasonable to say that a cache cannot span
NUMA domains. But with more and more things moving off the motherboard
and into the socket, this doesn't seem too weird now.

-Tony

