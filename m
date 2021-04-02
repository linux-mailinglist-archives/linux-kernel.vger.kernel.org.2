Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667D1352C29
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhDBPL0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Apr 2021 11:11:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:27466 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBPLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:11:23 -0400
IronPort-SDR: VIbJHzIj600z04xqEBnV6sh94IlLTia97pCFb1pdi5fLsRR/p7dMlAH4phchGa3PgECxm8K4aj
 rKjdBC+ohU+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="212756582"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="212756582"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 08:11:21 -0700
IronPort-SDR: fDNVDH0s3pRZwuZZRDpNaxmawZyua+kIM+3N6rO31ooJ3nLmn+J30Tq1KdeHF8HZUg4qx25qdh
 GhlHU9XaBOOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="446822902"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 02 Apr 2021 08:11:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 08:11:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 08:11:21 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Fri, 2 Apr 2021 08:11:21 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>
CC:     =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>
Subject: RE: [PATCH v3] mm,hwpoison: return -EHWPOISON when page already
 poisoned
Thread-Topic: [PATCH v3] mm,hwpoison: return -EHWPOISON when page already
 poisoned
Thread-Index: AQHXJiCcYSfsREicYE+l/w+vDcmt1aqfzHoAgAEYvwCAAHK6QA==
Date:   Fri, 2 Apr 2021 15:11:20 +0000
Message-ID: <a10c7838216e4a10b4fd5ebb0f1108a1@intel.com>
References: <20210305093656.6c262b19@alex-virtual-machine>
        <20210305221143.GA220893@agluck-desk2.amr.corp.intel.com>
        <20210308064558.GA3617@hori.linux.bs1.fc.nec.co.jp>
        <3690ece2101d428fb9067fcd2a423ff8@intel.com>
        <20210308223839.GA21886@hori.linux.bs1.fc.nec.co.jp>
        <20210308225504.GA233893@agluck-desk2.amr.corp.intel.com>
        <20210309100421.3d09b6b1@alex-virtual-machine>
        <20210309060440.GA29668@hori.linux.bs1.fc.nec.co.jp>
        <20210309143534.6c1a8ec5@alex-virtual-machine>
        <20210331192540.2141052f@alex-virtual-machine>
        <20210401153320.GA426964@agluck-desk2.amr.corp.intel.com>
 <20210402091820.04d7c3e0@alex-virtual-machine>
In-Reply-To: <20210402091820.04d7c3e0@alex-virtual-machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Combined with my "mutex" patch (to get rid of races where 2nd process returns
>> early, but first process is still looking for mappings to unmap and tasks
>> to signal) this patch moves forward a bit. But I think it needs an
>> additional change here in kill_me_maybe() to just "return" if there is a
>> EHWPOISON return from memory_failure()
>> 
> Got this, Thanks for your reply!
> I will dig into this!

One problem with this approach is when the first task to find poison
fails to complete actions. Then the poison pages are not unmapped,
and just returning from kill_me_maybe() gets into a loop :-(

-Tony
