Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5551434DDF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhC3CEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:04:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:38808 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhC3CEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:04:08 -0400
IronPort-SDR: OBUcBiJnfnNScAAnNS3sPCv91E4r7nzNdKY7E07RNI9KPokzIl4eSF/ArsX43M1QcyNdDEEGDu
 64owa4qZWy6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="191764287"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="191764287"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 19:04:08 -0700
IronPort-SDR: STOyxYvmQZKD8zSewJFsmefO6zTHcWJQyS4oLP4oVCt27zjYr8gtww/1YKD1okWY88AyEmxOFx
 QBje56trmUHQ==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="595287916"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 19:04:08 -0700
Date:   Mon, 29 Mar 2021 19:04:03 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Message-ID: <20210330020403.GA1285835@tassilo.jf.intel.com>
References: <837afe840f5826bf7fcba07a5e483d7e2283db34.1617059703.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <377A7B0B-9959-4AFC-A575-7AC20FEE6077@amacapital.net>
 <10834a17-cae4-d0e3-c82b-f69da7f9141a@linux.intel.com>
 <YGJl93hlKngWLGwz@google.com>
 <CALCETrVzdq7eQu6RfJd0+yuJ+Q9Q6NykVb+x_jiNwLW2-mrh0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVzdq7eQu6RfJd0+yuJ+Q9Q6NykVb+x_jiNwLW2-mrh0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > No, if these instructions take a #VE then they were executed at CPL=0.  MONITOR
> > and MWAIT will #UD without VM-Exit->#VE.  Same for WBINVD, s/#UD/#GP.
> 
> Dare I ask about XSETBV?

XGETBV does not cause a #VE, it just works normally. The guest has full
AVX capabilities.

-Andi

