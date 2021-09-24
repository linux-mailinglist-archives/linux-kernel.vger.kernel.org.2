Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FC4416919
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 02:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243685AbhIXA5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 20:57:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40881 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232143AbhIXA5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 20:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632444946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mg9KP+cx438j5wC5hpIXMnDuPlwL4JuEjwLmUyo/e+c=;
        b=LOL66o13Ukc81+svZ1x9GrMlYPWhjz+o6BZnOX/zbFzdOzv9tBsmwdI5rOTProRVrAU9L7
        rrPEwLXe8YmPkjYpsdVmX3hFFZt5JfDP75+cVhQ85z260NFYae1CqFRD8PGs1T2FvX3jg8
        VBFfTzIWResC4AYS9f333yg9DDUiEQs=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-G8C96YNaObO11MRFno3n1A-1; Thu, 23 Sep 2021 20:55:44 -0400
X-MC-Unique: G8C96YNaObO11MRFno3n1A-1
Received: by mail-pf1-f199.google.com with SMTP id 3-20020a620603000000b0042aea40c2ddso5100296pfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 17:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mg9KP+cx438j5wC5hpIXMnDuPlwL4JuEjwLmUyo/e+c=;
        b=MSqcBUGzC96pfFGlbPoavPKq8fNTibkQtfN2HYebiMTWEMdmOlRPbj2NkS5wEXJteB
         YpHw/IQpkR6+Ws+uxZSteLAZEuYh4CNBbmO/9uMPWu407PRFb3mZJqFM4TzL3BCmqMY/
         4pU53oDTqs3Y9CGBShC8aEO+kUNPuEfpW0K8gwVML0VQLeSQtKef0ANVy7YN5Qo68mZb
         fjhUvMONb56/sa27L7JLbYgLXsN/vORUXHO55bg6ycQoxGG7HkteAUvILWAVt4ZStmWp
         TIyKuUGpaspaeAwZYqA4BNUP4t3MqHzHQqQoJfXPvEgR/jmoczJHtPqhMkCEdfFno7Rp
         UYww==
X-Gm-Message-State: AOAM531FTByKOVRXUt9djbN6a6OzKqKVLfzMoPh0pp6gtKjwW307ZwuC
        VyWOxIlyI7yrN1+Rk7a46s0GXLjRUOUm7VU3dK0fr2Mgk6edRkL2xOBFyFI5WSiY6TpTpB2H1Ym
        y3G+oCbxm/QRuM34Fef2Rs4Cu
X-Received: by 2002:a17:90a:cb84:: with SMTP id a4mr8794386pju.137.1632444943559;
        Thu, 23 Sep 2021 17:55:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyW0w8hKU+ZiQxzdVApOFafHdkV0+crvkHEidtTlEIsVkstLZwGWrB5bzXHvaiYkJe4KeySrQ==
X-Received: by 2002:a17:90a:cb84:: with SMTP id a4mr8794357pju.137.1632444943271;
        Thu, 23 Sep 2021 17:55:43 -0700 (PDT)
Received: from treble ([50.231.97.170])
        by smtp.gmail.com with ESMTPSA id b11sm7822920pge.57.2021.09.23.17.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 17:55:42 -0700 (PDT)
Date:   Thu, 23 Sep 2021 17:55:40 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] tools/objtool: Check for use of the ENQCMD
 instruction in the kernel
Message-ID: <20210924005540.kunsfif7hdta6dlp@treble>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-8-fenghua.yu@intel.com>
 <20210922210343.GU4323@worktop.programming.kicks-ass.net>
 <YUu/6YPYwvaDwthy@otcwcpicx3.sc.intel.com>
 <YUwp7VkjApRQr/pb@hirez.programming.kicks-ass.net>
 <YUycliX+lPSMhWfR@otcwcpicx3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUycliX+lPSMhWfR@otcwcpicx3.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 03:26:14PM +0000, Fenghua Yu wrote:
> > > +		} else if (op2 == 0x38 && op3 == 0xf8) {
> > > +			if (insn.prefixes.nbytes == 1 &&
> > > +			    insn.prefixes.bytes[0] == 0xf2) {
> > > +				/* ENQCMD cannot be used in the kernel. */
> > > +				WARN("ENQCMD instruction at %s:%lx", sec->name,
> > > +				     offset);
> > > +
> > > +				return -1;
> > > +			}
> > 
> > The only concern here is if we want it to be fatal or not. But otherwise
> > this seems to be all that's required.
> 
> objtool doesn't fail kernel build on this fatal warning.
> 
> Returning -1 here stops checking the rest of the file and won't report any
> further warnings unless this ENQCMD warning is fixed. Not returning -1
> continues checking the rest of the file and may report more warnings.
> Seems that's the only difference b/w them.
> 
> Should I keep this "return -1" or not? Please advice.

I'd say remove the "return -1" since it's not a fatal-type analysis
error and there's nothing to prevent objtool from analyzing the rest of
the file.

-- 
Josh

