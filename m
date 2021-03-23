Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3879346620
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhCWRQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhCWRQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:16:42 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7E7C061764
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:16:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ha17so10394661pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BW5ADJ+bowjKJAIcC8Or2wh2BR2bwjdresRzdjKOAkg=;
        b=fNQXQltOXQTQJMOUBmrPh5EfoS1rGVWrLUxFZ6nFynpA1G9tFwTMmFtmQHx4gLuZwf
         vQkC+UiD9bCMikl6zH39kb3fZDgiWx0HUZK3MmPHNhxod2DbUxEbGcpn6wNwgptiKiQY
         dYOOOmNNsBLe/mUMcV7VYVKI/fT99mvrUvLx+GKwISYT+6iU8tzz3tgE5Sqw/htCx+eW
         zeJyT+hUsEJ6EnJSf77nUP3SuTlYxozqUnjkfnPdTpTT1Revzpal4QShdxpv9bcxd3oN
         eEHvNZzaYWwJ3HP2ZZ+OLMzKvZmLlbiwTvfBqVo7m6tR2oghWkZ8qkdr4BFQrzfz7O+R
         uHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BW5ADJ+bowjKJAIcC8Or2wh2BR2bwjdresRzdjKOAkg=;
        b=maMsXIGJwgYoCTJ2ASIqfPzlxRLS78Qqmd0ohNE0/AN1x+QCRFBJ0DsuoQka4gxYjX
         xnerAAcnVUKMKEfCY99O2guJPaWABWJomO9zqdJ61AwmINikru2P9q+fpHp/D1mkwisJ
         8gGWxSJ+OH9IpMSU2ta9tr1hcSFx8ObsIhxJXsOeakj0hIjaG2laF2KnIDUI9ejVjgKR
         lLLDiUnEzORUOvyohF28yMNwiaT39mBVBd8LW9CK2kCEU/cDfG7lao+MqYlhkaQ4mgHd
         iMDsiELbhN7a09KXjJA5YCo1gUjXWUi4KnCZ4CCmaYwLpzvkOUN5lz35oG3KXnf6qUfd
         jdTw==
X-Gm-Message-State: AOAM531v4YY+BbdJ3wGG3G2hgFh4u93amIlPaFfsefa1XPKQtziUrkxA
        u+/sBBI4bTcexkrnJkOnllgmWw==
X-Google-Smtp-Source: ABdhPJzT3THas/wgdKylXMKwWDFYARFa2UYxugyIkQRopChDKtopuHEeTbMBRgkFeJmgcVXBVMiWEg==
X-Received: by 2002:a17:90a:ad87:: with SMTP id s7mr5703868pjq.20.1616519801668;
        Tue, 23 Mar 2021 10:16:41 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id k127sm18247070pfd.63.2021.03.23.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 10:16:41 -0700 (PDT)
Date:   Tue, 23 Mar 2021 17:16:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, Kai Huang <kai.huang@intel.com>,
        kvm@vger.kernel.org, x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, rick.p.edgecombe@intel.com,
        haitao.huang@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com
Subject: Re: [PATCH v3 03/25] x86/sgx: Wipe out EREMOVE from
 sgx_free_epc_page()
Message-ID: <YFoiddwNHPGd5OIP@google.com>
References: <YFjx3vixDURClgcb@google.com>
 <20210322210645.GI6481@zn.tnic>
 <20210323110643.f29e214ebe8ec7a4a3d0bc2e@intel.com>
 <20210322223726.GJ6481@zn.tnic>
 <20210323121643.e06403a1bc7819bab7c15d95@intel.com>
 <YFoNCvBYS2lIYjjc@google.com>
 <20210323160604.GB4729@zn.tnic>
 <41dd6e78-5fe4-259e-cd0b-209de452a760@redhat.com>
 <YFofNRLPGpEWoKtH@google.com>
 <5d5eacef-b43b-529f-1425-0ec27b60e6ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d5eacef-b43b-529f-1425-0ec27b60e6ad@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021, Paolo Bonzini wrote:
> On 23/03/21 18:02, Sean Christopherson wrote:
> > > That's important, but it's even more important *to developers* that the
> > > commit message spells out why this would be a kernel bug more often than
> > > not.  I for one do not understand it, and I suspect I'm not alone.
> > > 
> > > Maybe (optimistically) once we see that explanation we decide that the
> > > documentation is not important.  Sean, Kai, can you explain it?
> > 
> > Thought of a good analogy that can be used for the changelog and/or docs:
> > 
> > This is effectively a kernel use-after-free of EPC, and due to the way SGX works,
> > the bug is detected at freeing.  Rather than add the page back to the pool of
> > available EPC, the kernel intentionally leaks the page to avoid additional
> > errors in the future.
> > 
> > Does that help?
> 
> Very much, and for me this also settles the question of documentation.
> Borislav or Kai, can you add it to the commit message?

One last thought.  This error/WARN doesn't guarantee that a conflict hasn't
already occurred, e.g. the EPC page was prematurely put back on the list and
already handed out to a second enclave.  In that case there will undoubtedly be
a slew of WARNs/errors leading up to this one, I just wanted to clarify that
intentionally leaking the page doesn't magically cure _all_ use-after-free or
double-use bugs.
