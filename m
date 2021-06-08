Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC273A0761
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 01:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhFHXGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 19:06:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:27960 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234272AbhFHXGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:06:12 -0400
IronPort-SDR: JpGLqXTU1Gfl/T5OT6Tgq+iaZ6J4OlIm3JC9cY8WiqfhfOtjReWrVvwFBWSG0BnWHy2+IhrUFl
 nnHxiwVTjB7w==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="204987143"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="204987143"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 16:04:15 -0700
IronPort-SDR: y+jf4MsneXEhz5dOtrIJYmxCrdYwxLGl+5p/59UCktIZN50v2nXozynnc5d34SJmtDv5VNpmd8
 GrIOn/OVA7aA==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="551775952"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.24.11]) ([10.209.24.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 16:04:15 -0700
Subject: Re: [RFC v2-fix-v3 1/1] x86/tdx: Skip WBINVD instruction for TDX
 guest
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <CAPcyv4jQ=Fcga3jyUzthjPW9O962vhy3L5XUM6jqR5Z_Zq83LQ@mail.gmail.com>
 <20210608213527.739474-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <ec55256c-3a44-5265-fea8-018a229e92da@intel.com>
 <bc41d48e-b001-f870-e421-7c5cbc6ec1c4@linux.intel.com>
 <d28a4ece-744e-1d43-90c8-e8c36def9be6@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <b5a8773b-92af-73ab-ddf1-2467053a8832@linux.intel.com>
Date:   Tue, 8 Jun 2021 16:04:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <d28a4ece-744e-1d43-90c8-e8c36def9be6@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

\
> A kernel driver using WBINVD will "sigfault"?  I'm not sure what that
> means.  How does the kernel "sigfault"?

It panics. Please, you know exactly what Sathya meant because you've 
read the code.

>
> Here's what I want to see: a list of all of the unique call sites for
> WBINVD in the kernel.  I want a written down methodology for how the
> list of call sites was generated.  I want to see an item-by-item list of
> why those call sites are unreachable with the TDX guest code.  It might
> be because they've been patched in this patch, or the driver has been
> disabled, or because the TDX architecture spec would somehow prohibit
> the situation where it might be needed.  But, there needs to be a list,
> and you have to show your work.  If you refer to code from this series
> as helping to prevent WBINVD, then it has to be earlier in this series,
> not in some other series and not later in this series.

Sorry this is ridiculous. We're not in a make-work project here. We're 
about practical engineering  not make out life artificially complicated.

If that is what is required then the change requests to NOT ignore but 
patch every site were just not practical.

>
> Just eyeballing it, there are ~50 places in the kernel that need auditing.
>
> Right now, we mostly have indiscriminate hand-waving about this not
> being a problem.  It's a hard NAK from me on this patch until this audit
> is in place.


Okay then we just go back to ignore like the rest of the KVM world.

That's what we had originally and it it's fine because it's exactly what 
KVM does, which is all we want.

It was the sane thing to do and it's still the sane thing to do because 
it has been always done this way.

-And

