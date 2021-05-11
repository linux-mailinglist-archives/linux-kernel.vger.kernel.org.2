Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F9237AB23
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhEKPvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhEKPvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:51:47 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F263FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:50:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c22so23450734edn.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YH6YgAVkTiXbdfOcXF2vDZOin/cgaMlrHhCUoByOUzM=;
        b=KAVJuYtXoVccS7Mz6+WwXrwBzBNXVBJiXvHcQFoDhJKBjMBnBuHojuygaSnyjBFh2J
         juvXeZVJwPDRy+v2a+HBWLFfu29TOD989MaKVyZz7XHcJ3O1A+Sq/ZsrpqhPqO/vtNRs
         tJZM/jFTyvjuzNJj8uIiI+6Kk760+lBL2FSbujpXDN7b+nWSdhwY+pFNdwhyfj5J9ham
         7/I4tKLzDZSH0mCw0oAdxkvaK8TYCEKmaKeJTfHtZBbJ4C8xUaObZxvd7rsKV6EQlFSQ
         bFExTo11KTR4WHN2uubvLiG/0eTzRbmZatHF7ZTdlD1HfviACmmHmsQPpJuo+LdICeQt
         dgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YH6YgAVkTiXbdfOcXF2vDZOin/cgaMlrHhCUoByOUzM=;
        b=DAHdEYt/kq6DJzdmQvZbAzSAPoMnuO/MzmCm342s7QFjoJ+tJQZE3k8/QsWuD7xij0
         pS6KVhkipIf+lhSJiVKcrG07/m4N0Q1SQM71XWZohOYsUYm3paF1Cfv8rcfBMmmDaDX6
         JbIu1CurL5iA0wJojNabpPHY60mjZoWRT7T1Ms2JWuPV6G3oPkIr6UpFGU3vALpiJoSS
         Iv47tRCrDaUMWhHY03+TGIyCI8lhi0Ggq9ZF/8Seo4xdQH0iA7Qg9UigRAzHq6SJtXwm
         QEuDudMs951O35fqLUsJP/UOQFlQzjvFS4HegqEbAPMUZwFlcJgtEFcEnOOtQ6Y8mmZM
         cUcg==
X-Gm-Message-State: AOAM53199i6mbXi9YzHkj0iOCzrwT3rBkUse0CS4MZ9pKBLGGpovxL6D
        iI7kzjfSaBZ+VBpAEAYZR2KyHSKmnA4imp8aUlSJqg==
X-Google-Smtp-Source: ABdhPJxOYtRFndI12nE8eH+qHElDO270/uoKY+1bJzD1DPvDmH+0jqCQqkMrfS0r0UZK3DgA/+LD12UEaft2TeZhjZ4=
X-Received: by 2002:a50:f0d6:: with SMTP id a22mr37973492edm.354.1620748239760;
 Tue, 11 May 2021 08:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d6ca05720290060e909c1f4d12858f900f1be0e7.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jGmhkrd+Zr4RNcZ5qfXkYO-416Bw2_idVbrgij41yvYg@mail.gmail.com>
 <0e577692-101e-38f7-ebe2-2e7222016a9f@linux.intel.com> <CAPcyv4jLMA=jehxdFi=A-xtjSRQ_v7XxSVYrZPAU3XKC39qWRA@mail.gmail.com>
 <43e0a5cc-721a-04f1-50b6-b1319da10bac@intel.com>
In-Reply-To: <43e0a5cc-721a-04f1-50b6-b1319da10bac@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 May 2021 08:50:29 -0700
Message-ID: <CAPcyv4gEROpgvf+3Drgso1O6ENQ=2xBoKHqC6d4fWvdDNVSNjA@mail.gmail.com>
Subject: Re: [RFC v2 16/32] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 8:45 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/11/21 8:37 AM, Dan Williams wrote:
> >> I disagree. We already spent a lot of cycles on this. WBINVD makes never
> >> sense in current TDX and all the code will be disabled.
> > Why not just drop the patch if it continues to cause people to spend
> > cycles on it and it addresses a problem that will never happen?
>
> If someone calls WBINVD, we have a bug.  Not a little bug, either.  It
> probably means there's some horribly confused kernel code that's now
> facing broken cache coherency.  To me, it's a textbook place to use
> BUG_ON().
>
> This also doesn't "address" the problem, it just helps produce a more
> coherent warning message.  It's why we have OOPS messages in the page
> fault handler: it never makes any sense to dereference a NULL pointer,
> yet we have code to make debugging them easier.  It's well worth the ~20
> lines of code that this costs us for ease of debugging.

The 'default' case in this 'switch' prints the exit reason and faults,
can't that also trigger a backtrace that dumps the exception stack and
the faulting instruction? In other words shouldn't this just fail with
a common way to provide better debug on any unhandled #VE and not try
to continue running past something that "can't" happen?
