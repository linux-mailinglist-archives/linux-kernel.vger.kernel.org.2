Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA484454D53
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbhKQSpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240139AbhKQSpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:45:30 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D97C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:42:31 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id n12so13166274lfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HfMlVQj/b/ItsrHiY5LHVXy3Fn9KXtVbV9FK+lbwcIQ=;
        b=iRbB+3Qbw4iLpYL83sTx1BCy8qg9s3S4Y9izzD9sSNwupZ6aIw6HzqXRe1moYU235o
         9RD7XBS9Kv52fUvdkMKGwarBaSx2DOqH54zRP1VC+1h4UNF33kf9d/DVxcyhwGnxGfqH
         Vt8gBjQ3yOKi1R4DjoczNP2E8D7DqJM+At0Lqa2gUSO64JGGdo+FDHvN/PpgrDnmd6nb
         +McnF3XhoEs5gQgYE7eYp0QNW/Y/po9zqXG1jmOCV+qfs0YxBkTK7AFtagEm85oCJVz3
         0BS+hd9kCCv4rc7Hc6MI5kDT7FxQfBvQafYA0NVnTMGQn4s9PDhen5mb+NjxO2WOh8nZ
         3d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HfMlVQj/b/ItsrHiY5LHVXy3Fn9KXtVbV9FK+lbwcIQ=;
        b=l5N9uT7ytAONqwF2D3hK6V1KXPgHjIolaTKwjq2tDtN7TO/oymQCFiyOHKAOG/Db8h
         uRqFVkrzfo9CL25KmcfWr3zttoMx+Ws+5OfwJ0Ix8JjCtBMyAcU/8MJFuXwZfIut3lx3
         0uHyt8PRGhWAx8b7JEprnKLM5UNtBN8j1rRrIowSgORqy7X0XJo6l9KFMuIzw/fSiEwf
         4uvkO04UPyjmwEcNzrRTrwA7Zmkyvd4zbr3ZfI2xJtCxWD7bjOMvD0tGEmmvPJTOG45a
         0FLSr2tz7pSlcAAMiH9oM6lfgxU7ghsZUSaBwjJoPz52kT1SPZCZp+MdopME+8ZNT3QS
         lzAw==
X-Gm-Message-State: AOAM531V41Ri10dXlmYvDwrrAUh6kPMUxhr4h5dVzDGH9mmfZURAPTpN
        lW9iIisn9BVoT8LRPYrFh+z3KXkP/dP/HMOi
X-Google-Smtp-Source: ABdhPJwoQv2k94M2Z+aUt6nQE/hf5CcENNGR0Ll4pCUUNMKDMdINSGcKugN7cL4ksljF7ocxoMp6iw==
X-Received: by 2002:a05:6512:332f:: with SMTP id l15mr16884857lfe.309.1637174550041;
        Wed, 17 Nov 2021 10:42:30 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m8sm63903lfg.140.2021.11.17.10.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 10:42:29 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id CD884103139; Wed, 17 Nov 2021 21:42:25 +0300 (+03)
Date:   Wed, 17 Nov 2021 21:42:25 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
Message-ID: <20211117184225.6e257nfpdd2qhrj4@box.shutemov.name>
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
 <YZVLVfd5E6d6YQig@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZVLVfd5E6d6YQig@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 07:35:01PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 17, 2021 at 09:14:39PM +0300, Kirill A. Shutemov wrote:
> > TDX is going to use CONFIG_PARAVIRT_XXL
> 
> *AARGGHHH*. srlsy? We were trying to cut back on that insanity, not
> proliferate it.

It is a way to minimize amount of changes needed for getting TDX
functinal. We will remove the dependency later on.

-- 
 Kirill A. Shutemov
