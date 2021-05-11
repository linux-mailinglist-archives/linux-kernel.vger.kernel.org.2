Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5790337ACAB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhEKRIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:08:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:28322 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhEKRI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:08:29 -0400
IronPort-SDR: 6SY2a8gniQ5+PYMG/Oc3v3DhIUGgKdPyQ8p7qaQLcWdJeGtgV1yTSKmpw2ixyIyNhp40LNv5BV
 6fLvtDSuNBGw==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="186630991"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="186630991"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 10:06:04 -0700
IronPort-SDR: weymawFcanMxkM6LY4sr8WB9ZE8k5jsqr5i1HbyWA8RJwWYBl3PL6utJRuiyppqhJRw5gGLrX0
 1icAVvzumQIQ==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="434688159"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.131.161]) ([10.212.131.161])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 10:06:03 -0700
Subject: Re: [RFC v2 16/32] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d6ca05720290060e909c1f4d12858f900f1be0e7.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jGmhkrd+Zr4RNcZ5qfXkYO-416Bw2_idVbrgij41yvYg@mail.gmail.com>
 <0e577692-101e-38f7-ebe2-2e7222016a9f@linux.intel.com>
 <CAPcyv4jLMA=jehxdFi=A-xtjSRQ_v7XxSVYrZPAU3XKC39qWRA@mail.gmail.com>
 <43e0a5cc-721a-04f1-50b6-b1319da10bac@intel.com>
 <CAPcyv4gEROpgvf+3Drgso1O6ENQ=2xBoKHqC6d4fWvdDNVSNjA@mail.gmail.com>
 <01b0e007-6af6-ca2e-2a0d-7ff4ca2a2927@linux.intel.com>
 <4456b0d0-c392-4691-2963-c349369158c3@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <497d9293-9111-5d2e-2d19-7343467ff9cd@linux.intel.com>
Date:   Tue, 11 May 2021 10:06:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <4456b0d0-c392-4691-2963-c349369158c3@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


need anything else than what #GP already does.

> How do these end up in practice?  Do they still say "general protection
> fault..."?

Yes, but there's a #VE specific message before it that prints the exit 
reason.


>
> Isn't that really mean for anyone that goes trying to figure out what
> caused these?  If they see a "general protection fault" from WBINVD and
> go digging in the SDM for how a #GP can come from WBINVD, won't they be
> sorely disappointed?

They'll see both the message and also that it isn't a true #VE in the 
backtrace.


-Andi


