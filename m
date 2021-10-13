Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC7542C729
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhJMRGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhJMRGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:06:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1998C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:04:11 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 187so3017001pfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qs+5DwWD1Rx+vv/W6o07LrnjErzTT76oQHuQLcyI2hw=;
        b=iyi+jmtEHIugaiDUUT/ucFx2GgoKITe+iiAKP+UeA2kIYn5Oc7iTNmdlUPuAYBXHMg
         4MLWuzuM3NM9E/XDdI5IuqfCDOcalnolG6fHKtDPlXZ8Jr6+9XOFp293MZv1NgS6A/f0
         zc02ms2LlZqelekf9K2K6ljGwUddKjxNnQggwQObUWxssXgDrH8JaVVk2pz40U6x+dYp
         lz3vMXh62wXBRKV7LVxhSV7ojsMuIsJZ6y+S/8cVa8Wgb9Q7PD0wPtaEO9BDYRDOXzDf
         lgMuF5UjeQkAqK91hdmmxLDRcOnVfze/5wOnvYQ3hxxE/PXEzriR+C244xVX7fATAJtr
         /41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qs+5DwWD1Rx+vv/W6o07LrnjErzTT76oQHuQLcyI2hw=;
        b=68vxjoII0ETMTHfag06fN4NbHSfUI9GUNo6PQPRofj/FTdxpsuu0CqVwZQ8R/ULm3I
         keM1Ifk4D928+PWNX2iPK2lIeRmXX0gu8EfRYp6lI2FmBTtn/57/SQOrkLz+ofj0dIYo
         xnmamvOtbhZMUw44LWoMzKzG308R0IfwJIvSWKfxG74aLLuOy0q3LRFsfoB/cVaakw6U
         GsbieGktghxYQqdWW5tKfJsABaYeuqDPv8JzyTl0yFDfMAtk6XrlYuVfYyXuTMilnIMj
         3qAosPocYk41lzHWsqK/2Ewneyl2WBDDZKTQPYAXXw4XzkYhnN80TJbF7tykTk+ly8Pr
         zoMg==
X-Gm-Message-State: AOAM532i6E0o6OhofafUrxVRJn7GYaRRU1EF2ugO3/ZU1q2H4xAgcQ0L
        780MzCx9zJlBieFqSTfia91+0g==
X-Google-Smtp-Source: ABdhPJxkQD+smtf/Sn/mUPp5u5h2BWQFhYFmVSmny/8OgT4A9WVg/lMu0U4st4H9LAK0FzKnJt5kJA==
X-Received: by 2002:a63:1950:: with SMTP id 16mr253698pgz.346.1634144651005;
        Wed, 13 Oct 2021 10:04:11 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t14sm6393455pjl.10.2021.10.13.10.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 10:04:10 -0700 (PDT)
Date:   Wed, 13 Oct 2021 17:04:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part2 v5 37/45] KVM: SVM: Add support to handle MSR based
 Page State Change VMGEXIT
Message-ID: <YWcRhrxLUXfHRig7@google.com>
References: <20210820155918.7518-1-brijesh.singh@amd.com>
 <20210820155918.7518-38-brijesh.singh@amd.com>
 <YWYCrQX4ZzwUVZCe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWYCrQX4ZzwUVZCe@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021, Sean Christopherson wrote:
> If we are unable to root cause and fix the bug, I think a viable workaround would
> be to clear the hardware present bit in unrelated SPTEs, but keep the SPTEs
> themselves.  The idea mostly the same as the ZAPPED_PRIVATE concept from the initial
> TDX RFC.  MMU notifier invalidations, memslot removal, RMP restoration, etc... would
> all continue to work since the SPTEs is still there, and KVM's page fault handler
> could audit any "blocked" SPTE when it's refaulted (I'm pretty sure it'd be
> impossible for the PFN to change, since any PFN change would require a memslot
> update or mmu_notifier invalidation).
> 
> The downside to that approach is that it would require walking all SPTEs to do a
> memslot deletion, i.e. we'd lose the "fast zap" behavior.  If that's a performance
> issue, the behavior could be opt-in (but not for SNP/TDX).

Another option if we introduce private memslots is to preserve private memslots
on unrelated deletions.  The argument being that (a) private memslots are a new
feature so there's no prior uABI to break, and (b) if not zapping private memslot
SPTEs in response to the guest remapping a BAR somehow breaks GPU pass-through,
then the bug is all but guaranteed to be somewhere besides KVM's memslot logic.
