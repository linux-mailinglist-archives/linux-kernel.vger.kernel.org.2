Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E4537579D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbhEFPit convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 May 2021 11:38:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:20964 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235926AbhEFPfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:35:50 -0400
IronPort-SDR: 2jj8juM3HyfoQ45CGoGvoEzkLf7jsJSr1h+b1C9lYP7qA8PTh9YTFuBfJUYYkPV5qzCl+0rvCs
 uw8XvkoTTUZg==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="219384801"
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="219384801"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 08:34:50 -0700
IronPort-SDR: NX6RzwNeSAMDp6StW305M+Sd+j+jLrk4wgWenh2fgUMxfDOGbwPNO5RINx2WwaPChKh//xB+t1
 zl9eBy51KnYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="407051744"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 06 May 2021 08:34:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 6 May 2021 08:34:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 6 May 2021 08:34:49 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Thu, 6 May 2021 08:34:49 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "David Hildenbrand" <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yaoaili126@gmail.com" <yaoaili126@gmail.com>
Subject: RE: [PATCH v4 1/2] mm/memory-failure: Use a mutex to avoid
 memory_failure() races
Thread-Topic: [PATCH v4 1/2] mm/memory-failure: Use a mutex to avoid
 memory_failure() races
Thread-Index: AQHXOy7Hy/b3oTVTZEO3lND/F7hluKrWtfmA///ss2A=
Date:   Thu, 6 May 2021 15:34:48 +0000
Message-ID: <e50bbef65855443ba2be457a703ba1a5@intel.com>
References: <20210427062953.2080293-1-nao.horiguchi@gmail.com>
        <20210427062953.2080293-2-nao.horiguchi@gmail.com>
 <20210506173757.586580bd@alex-virtual-machine>
In-Reply-To: <20210506173757.586580bd@alex-virtual-machine>
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

> Sorry to interrupt, I just thought one thing:
>
> This mutex seems not been bind to the error page, will there be some core case
> like test code or multi-poison case whick will break this mutex?

The mutex is a bigger hammer than strictly needed . If there are simultaneous
errors on different pages they could, int theory, proceed in parallel. But this mutex
will serialize the processing.

Is this a problem? Hopefully systems aren't seeing so many uncorrectable/recoverable
errors that this would be a significant bottleneck.

-Tony
 
