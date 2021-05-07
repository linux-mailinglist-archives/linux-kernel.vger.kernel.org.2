Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8900B375F34
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 05:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhEGDih convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 May 2021 23:38:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:56341 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhEGDid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 23:38:33 -0400
IronPort-SDR: 7UkBPj4RSztBsGXCu6rFnoXN00aChrYZT/mdeWoDRgYPt0+r02By0y+OIEfh1ZBllaK/b1WzQY
 BB/ecmjUbk0g==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="219534430"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="219534430"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 20:37:09 -0700
IronPort-SDR: cfN6Sy07CfqCatK41hnuA7++xRgh/JFuZAkP50YGi2BgMUxK8u15H5GdTDRgKxczfaxPG45k5b
 iifFInFc/cRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="428842951"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 06 May 2021 20:37:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 6 May 2021 20:37:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 6 May 2021 20:37:08 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Thu, 6 May 2021 20:37:08 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Aili Yao <yaoaili@kingsoft.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/3] mm,hwpoison: fix sending SIGBUS for Action
 Required MCE
Thread-Topic: [PATCH v3 0/3] mm,hwpoison: fix sending SIGBUS for Action
 Required MCE
Thread-Index: AQHXNklUtDziI1+1ZUqZsXGvSliLyarXX3UAgAAW4VA=
Date:   Fri, 7 May 2021 03:37:07 +0000
Message-ID: <87ba79daaba1416589b203118be096cb@intel.com>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
 <d09f178272df4c82b8c090ba79d222b5@intel.com>
In-Reply-To: <d09f178272df4c82b8c090ba79d222b5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I updated the series based on previous feedbacks/discussions.
>
> Tested-by: Tony Luck <tony.luck@intel.com>

Maybe this series should get a "Cc: stable" tag too?

I don't have a specific commit to provide for Fixes:, but it deals
with an issue where sometimes processes return from the machine
check handler and hit the same machine check again.

It's hard[1] to hit in v5.8, but somehow gets progressively easier in
newer versions.

-Tony

[1] Initially I thought it didn't happen at all in v5.8. Then wasted a bunch
of time trying to bisect. But my "git bisect good" responses turned out to
be randomly assigned when I just hadn't tried enough times to make the
problem show up.
