Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5832E3733B0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 04:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhEECEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 22:04:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:30446 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229694AbhEECEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 22:04:49 -0400
IronPort-SDR: CZouSr/MHCQXzfhxgjf/85Y+DKrA6ZhYFQlqTD1fR76BZt9Fgne261mL5DretI6WEFzlgiQ/wd
 P6Kf0J5P0ezA==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="218952840"
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="218952840"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 19:03:54 -0700
IronPort-SDR: qmaz3lgwLJOIwgqsyrLKcWH5vSggMksDOP+oksXCm5BbW9SHf3O50ZGo68GJ2/kJ9Eakkp/MM5
 +XVO/SvgJHAw==
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="621741505"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 19:03:53 -0700
Date:   Tue, 4 May 2021 19:03:53 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rppt@kernel.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/9] PKS write protected page tables
Message-ID: <20210505020353.GE1904484@iweiny-DESK2.sc.intel.com>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 05:30:23PM -0700, Rick Edgecombe wrote:
> 
> This is based on V6 [1] of the core PKS infrastructure patches. PKS 
> infrastructure follow-on’s are planned to enable keys to be set to the same 
> permissions globally. Since this usage needs a key to be set globally 
> read-only by default, a small temporary solution is hacked up in patch 8. Long 
> term, PKS protected page tables would use a better and more generic solution 
> to achieve this.

Before you send this out I've been thinking about this more and I think I would
prefer you not call this 'globally' setting the key.  Because you don't really
want to be able to update the key globally like I originally suggested for
kmap().  What is required is to set a different default for the key which gets
used by all threads by 'default'.

What is really missing is how to get the default changed after it may have been
used by some threads...  thus the 'global' nature...  Perhaps I am picking nits
here but I think it may go over better with Thomas and the maintainers.  Or
maybe not...  :-)

Would it be too much trouble to call this a 'default' change?  Because that is
really what you implement?

Ira
