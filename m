Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75B1350D0C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhDAD3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:29:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:1968 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhDAD2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:28:30 -0400
IronPort-SDR: 2MTUcjlbQ4ojpHzQMKpJIHi9fyXm0HVx6iqdb+zM1IJEhlHEwKCsc0mJ/df5Na3+ZcvgJl/Tzr
 eAt0imU0LM+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="179673824"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="179673824"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 20:28:28 -0700
IronPort-SDR: jFzuCrbarKH2l5etqdYvkXLFpiSuobIgylq4Nl/71ddc5yuctmlS/Vdyn/XaFkHh49I7q/bN+K
 N1yaoDAKonmw==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="418984789"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 20:28:28 -0700
Date:   Wed, 31 Mar 2021 20:28:27 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Message-ID: <20210401032827.GI1285835@tassilo.jf.intel.com>
References: <2FE32855-EA5D-44E4-AACC-25E9B1476547@amacapital.net>
 <e62cfd0ae90de435e6819979d9027f76d835a22a.1617224710.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YGTvSvr2T2v3t3XA@google.com>
 <5d961c25-3dee-4a5d-4bba-a97d157a5a49@intel.com>
 <YGTyWUQbxVZeeko+@google.com>
 <d8078f5d-735c-2b0f-98eb-663be2118762@intel.com>
 <ef49222a-8ffc-dacc-4f21-3bd1ef13a2ac@linux.intel.com>
 <b175f08d-2930-158d-8543-fe6a7f6aaf12@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b175f08d-2930-158d-8543-fe6a7f6aaf12@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The hardware (and VMMs and SEAM) have ways of telling the guest kernel
> what is supported: CPUID.  If it screws up, and the guest gets an
> unexpected #VE, so be it.

The main reason for disabling stuff is actually that we don't need
to harden it. All these things are potential attack paths.

> 
> We don't have all kinds of crazy handling in the kernel's #UD handler
> just in case a CPU mis-enumerates a feature and we get a #UD.  We have
> to trust the underlying hardware to be sane.  If it isn't, we die a
> horrible death as fast as possible.  Why should TDX be any different?

That's what the original patch did -- no unnecessary checks -- but reviewers
keep asking for the extra checks, so Sathya added more. We have the not
unusual problem here that reviewers don't agree among themselves.

-Andi
