Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F953530C7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 23:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbhDBVcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 17:32:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:26210 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231577AbhDBVcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 17:32:23 -0400
IronPort-SDR: RKpoHlX0iX+CgIZ+UKJsyMIF7Xm1/M5Zb0VMoX7u9kCEcwHH6x7KfKUtsRnRjzgQ+UuH6OHFC/
 l0yNGq3gYFOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="192640760"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="192640760"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 14:32:21 -0700
IronPort-SDR: vwzfe4oGMKxq040CuMrVtAUkUSOXaHDWevG0dFNC0y11lb4NDsxJ0TtTrFxMi6QoyZpBbnY6C9
 LyR+bZ5n9T/Q==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="456574638"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 14:32:21 -0700
Date:   Fri, 2 Apr 2021 14:32:19 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 00/26] Add TDX Guest Support
Message-ID: <20210402213219.GM1285835@tassilo.jf.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <95e97456-478b-c6a2-f851-3b19ce794262@intel.com>
 <20210402024852.GK1285835@tassilo.jf.intel.com>
 <9bfa74a5-6a56-a2e0-7432-d35766099d54@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bfa74a5-6a56-a2e0-7432-d35766099d54@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If we go this route, what are the rules and restrictions?  Do we have to
> say "no MMIO in #VE"?

All we have to say is "No MMIO in #VE before getting thd TDVEINFO arguments"
After that it can nest without problems.

If you nest before that the TDX will cause a triple fault.

The code that cannot do it is a few lines in the early handler which
runs with interrupts off.

The TDX module also makes sure to not inject NMIs while we're in
that region, so NMIs are of no concern.

That was the whole point of avoiding the system call gap problem. We don't
need to make it IST, so it can nest.

I'm not aware of any other special rules.

> Which brings up another related point: How do you debug TD guests?  Does
> earlyprintk work?

Today it works actually because serial ports are allowed. But I expect it to
be closed eventually because serial code is a lot of code to audit. 
But you can always disable the filtering with a command line option and
then it will always work for debugging.

-Andi
