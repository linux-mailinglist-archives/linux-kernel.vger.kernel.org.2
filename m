Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320E234633D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhCWPpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhCWPpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:45:19 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2398BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:45:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e33so12117660pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=snhOtPXQe2J1ZAWrEwjkykkapTRBCKFqiae/8n9YpYs=;
        b=NGiRtGP2lrC/aCXhBKYGix0CG8zR5dTTCeZcJOZytUJrR57spr46P98rg4u6LC5gJx
         sEjRXAUZWwI37whFuI3rFdBSgDKuO6XTjK0FfgXBuSKz7qw46lWQMohyZmeSyoKnX2rI
         y0qm0/KujODkhbnn6vJquE+Yh4PatGizvIGrjsi6aD9tMq7JBDCkk5i5RcY1fGTx7a0K
         83ZhGp6a+Mxv8oNa3a0AouQtpCRPXEAdvahbogDySt+Xzy/3QuF3DzdWR+AO8XYnUyPU
         rPEW1+Tk8EoldDdWCeKoFIryKRLtvhEplc9jBIb62YeM7whs36+VxxYwDqgEpQh78vPJ
         Q/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=snhOtPXQe2J1ZAWrEwjkykkapTRBCKFqiae/8n9YpYs=;
        b=qpEUW/L/jdpeYjjLCOCdnodLUfJUFegaTa5mLL7L8YXa2OBcTV8sCRjdgQwMm+u69M
         EYXmv9HUUroSCkiZBiuleDZoT6UqU+pIPOroYBPyDmBmuBZ54qWoO5YMxPvMHomdm+pf
         ZoT+ySGmFHhYlPSfvJVeFpk0SyvNkTm3FhyP4kKmK9RlQGqbLNEi0cacpmo7OYmw65Bk
         +FkVi7m9/nVfGLh6QhqI0KUiD+DT+N3NqDApaH8d+c0JAHdbGVFL49dR859DBctJ7bmr
         Hc39NEvKGBTTut2KQj9/iSsumOy1RgW5RHUvdOdqGdo2bS7pMfjNXtFKmiOAdixzLWTT
         ojjA==
X-Gm-Message-State: AOAM530PnYXAJsVDpyp0NF78tBoqCE2uS1ASHHn+vGBmm7e6Zl3dKVvi
        TLeDV29vzATCvk1cr9m87XGn9A==
X-Google-Smtp-Source: ABdhPJxVpVQfzozgZX/lg4XhHyyD8ED7FqtBYCxj4KUELDnV/dy+o6fdX0pKOqoShlkqz5H3J6XOYg==
X-Received: by 2002:a63:3744:: with SMTP id g4mr4398884pgn.387.1616514318486;
        Tue, 23 Mar 2021 08:45:18 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id k5sm17452049pfg.215.2021.03.23.08.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 08:45:17 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:45:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org,
        x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, rick.p.edgecombe@intel.com,
        haitao.huang@intel.com, pbonzini@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Subject: Re: [PATCH v3 03/25] x86/sgx: Wipe out EREMOVE from
 sgx_free_epc_page()
Message-ID: <YFoNCvBYS2lIYjjc@google.com>
References: <cover.1616136307.git.kai.huang@intel.com>
 <062acb801926b2ade2f9fe1672afb7113453a741.1616136308.git.kai.huang@intel.com>
 <20210322181646.GG6481@zn.tnic>
 <YFjoZQwB7e3oQW8l@google.com>
 <20210322191540.GH6481@zn.tnic>
 <YFjx3vixDURClgcb@google.com>
 <20210322210645.GI6481@zn.tnic>
 <20210323110643.f29e214ebe8ec7a4a3d0bc2e@intel.com>
 <20210322223726.GJ6481@zn.tnic>
 <20210323121643.e06403a1bc7819bab7c15d95@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323121643.e06403a1bc7819bab7c15d95@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021, Kai Huang wrote:
> On Mon, 22 Mar 2021 23:37:26 +0100 Borislav Petkov wrote:
> > "The instruction fails if the operand is not properly aligned or does
> > not refer to an EPC page or the page is in use by another thread, or
> > other threads are running in the enclave to which the page belongs. In
> > addition the instruction fails if the operand refers to an SECS with
> > associations."
> > 
> > And I guess those conditions will become more in the future.

Yep, IME these types of bugs rarely, if ever, lead to isolated failures.

> > Now, let's play. I'm the cloud admin and you're cloud OS customer
> > support. I say:
> > 
> > "I got this scary error message while running enclaves on my server
> > 
> > "EREMOVE returned ... .  EPC page leaked.  Reboot required to retrieve leaked pages."
> > 
> > but I cannot reboot that machine because there are guests running on it
> > and I'm getting paid for those guests and I might get sued if I do?"
> > 
> > Your turn, go wild.
> 
> I suppose admin can migrate those VMs, and then engineers can analyse the root
> cause of such failure, and then fix it.

That's more than likely what will happen, though there are a lot of "ifs" and
"buts" in any answer, e.g. things will go downhill fast if the majority of
systems in the fleet are running the buggy kernel and are triggering the error.

Practically speaking, "basic" deployments of SGX VMs will be insulated from
this bug.  KVM doesn't support EPC oversubscription, so even if all EPC is
exhausted, new VMs will fail to launch, but existing VMs will continue to chug
along with no ill effects.  There are again caveats, e.g. if EPC is being lazily
allocated for VMs, then running VMs will be affected if a VM starts using SGX
after the leak in the host occurs.  But, IMO doing lazy allocation _and_ running
enclaves in the host falls firmly into the "advanced" bucket; anyone going that
route had better do their homework to understand the various EPC interactions.
