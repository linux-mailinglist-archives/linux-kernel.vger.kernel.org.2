Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DD8342830
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhCSVuv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 Mar 2021 17:50:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:49877 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231309AbhCSVuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:50:32 -0400
IronPort-SDR: slgycP9JjrSWWfT4RzCKqzIQyPYA38jqZXVEPEgkrAXGkygF7WMIjXMyCug1Eo99+WU38OFscW
 C/cc17/BvHOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="186633584"
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="186633584"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 14:50:31 -0700
IronPort-SDR: CNwXtSKiJkw/F513dEuiCtf/E79SGA8JLcTe2SLgFWibqUVgK9g1c6BEvxxzr3fnQM5+NREffN
 rwsQfJOZIA7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="523776678"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 19 Mar 2021 14:50:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 14:50:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 14:50:02 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Fri, 19 Mar 2021 14:50:02 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH v5 2/3] x86/bus_lock: Handle #DB for bus lock
Thread-Topic: [PATCH v5 2/3] x86/bus_lock: Handle #DB for bus lock
Thread-Index: AQHXF8yg1hQlE2i5UEO0ZXKRbxGfv6qMVAMA//+NqvA=
Date:   Fri, 19 Mar 2021 21:50:02 +0000
Message-ID: <d98d86f9f5824573b2441089e0c2ae91@intel.com>
References: <20210313054910.2503968-1-fenghua.yu@intel.com>
 <20210313054910.2503968-3-fenghua.yu@intel.com>
 <871rca6dbp.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rca6dbp.fsf@nanos.tec.linutronix.de>
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

>  What is the justifucation for making this rate limit per UID and not
>  per task, per process or systemwide?

The concern is that a malicious user is running a workload that loops
obtaining the buslock. This brings the whole system to its knees.

Limiting per task doesn't help. The user can just fork(2) a whole bunch
of tasks for a distributed buslock attack..

Systemwide might be an interesting alternative. Downside would be accidental
rate limit of non-malicious tasks that happen to grab a bus lock periodically
but in the same window with other buslocks from other users.

Do you think that a risk worth taking to make the code simpler?

-Tony
