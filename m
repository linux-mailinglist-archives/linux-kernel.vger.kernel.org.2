Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652684498A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 16:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241038AbhKHPor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 10:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238676AbhKHPoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 10:44:46 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB737C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 07:42:01 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id p8so14159129pgh.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 07:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tkf6PGyOQlZx2ICkVSDHZ38vJjzwurGO2FLSUZQU4ns=;
        b=sj+dlPf6g1fLuoG/VAQy+s4CYTN6lyY9D/CRsFIkAsVfdFIn+yM2OMXbYtbm4Ke8Yk
         ZI+SdxbKg+aMkKrFPtqrOGBxKaggpET8BKIWEBcwYyI5ezoUdiMkXlXkoExh1Ver2Agq
         BOg0C7KYPvj7mKVQKwjjNOZ/deP+5LMFHdNhnlHv8xfd9xJMJdAZxnrjN4Hmm9xnk0tG
         EiTO8ShYyVf6unmaOiWqRKEfdPWme0Ri3X/3xLViRE88QkXqZzQ6rkog6a3wyN7OTcKA
         mcmQw3uU+XgXvk+72U94Udey1w7nq0m5ux5I0NcnhcSBayJu0HEv+VK95pxvOsSIy5G6
         OVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tkf6PGyOQlZx2ICkVSDHZ38vJjzwurGO2FLSUZQU4ns=;
        b=Y9kOxn37pB80jBckEWHWDTMOekMWqu8SMwfRGXq+dtAGCroQyiQyptQijNrXwhYBm/
         J8qwGlPiAvixkrj+QoTTV3mFPMSNQ68x6/N2skEQRH7TBbcX8ZbQ6SYEybmuhKYBfySY
         FZYpB7CypkEpPhMI5ErVbcT5gSExfjxzqfv4gvrysS6I0XJWcIEMZG3Q4htFyswnyIPC
         0wQwSCPnakxynLmpxzmsjorArFSbewDU8OHwyT8zkA9OzbbGt9hICCRdWoDPzJ1bYWJd
         wkqVAxTLUx/u5/gYN+kEaF3UoR4dEw34/nlY6KBbe3N8HtYIxrbbr9ViESoup1nXUk8L
         vu7A==
X-Gm-Message-State: AOAM5321fGfOOuk2+zP4iJC7P/stgqMYq9g+bYkSqySVbmwOUoLHl+Ru
        dh7mvEUuYlAYXGEAj1qKBszohg==
X-Google-Smtp-Source: ABdhPJz1XukECJyfvwju3z+TcJoscgwooHz5EfI7crhE78qQ86H7GEjfPFjwc4HpVy8Fp9kmWsDe+g==
X-Received: by 2002:a05:6a00:188a:b0:481:2c54:4ace with SMTP id x10-20020a056a00188a00b004812c544acemr396943pfh.20.1636386121209;
        Mon, 08 Nov 2021 07:42:01 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w11sm13067870pge.48.2021.11.08.07.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 07:42:00 -0800 (PST)
Date:   Mon, 8 Nov 2021 15:41:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] KVM: x86: Introduce definitions to support static
 calls for kvm_pmu_ops
Message-ID: <YYlFRBkrgu/iYR/b@google.com>
References: <20211103070310.43380-1-likexu@tencent.com>
 <20211103070310.43380-3-likexu@tencent.com>
 <YYVSW4Jr75oJ6MhC@google.com>
 <47734f2c-5588-1c22-ddcf-c486ceab0d34@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47734f2c-5588-1c22-ddcf-c486ceab0d34@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021, Like Xu wrote:
> On 5/11/2021 11:48 pm, Sean Christopherson wrote:
> > On Wed, Nov 03, 2021, Like Xu wrote:
> > > diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > > index 0db1887137d9..b6f08c719125 100644
> > > --- a/arch/x86/kvm/pmu.c
> > > +++ b/arch/x86/kvm/pmu.c
> > > @@ -50,6 +50,13 @@
> > >   struct kvm_pmu_ops kvm_pmu_ops __read_mostly;
> > >   EXPORT_SYMBOL_GPL(kvm_pmu_ops);
> > > +#define	KVM_X86_PMU_OP(func)	\
> > > +	DEFINE_STATIC_CALL_NULL(kvm_x86_pmu_##func,	\
> > > +				*(((struct kvm_pmu_ops *)0)->func))
> > > +#define	KVM_X86_PMU_OP_NULL	KVM_X86_PMU_OP
> > 
> > More of a question for the existing code, what's the point of KVM_X86_OP_NULL?
> 
> The comment says:
> 
>  * KVM_X86_OP_NULL() can leave a NULL definition for the
>  * case where there is no definition or a function name that
>  * doesn't match the typical naming convention is supplied.
> 
> Does it help ?

No.  I understand the original intent of KVM_X86_OP_NULL, but unless there's some
form of enforcement, it does more harm than good because it can very easily become
stale, e.g. see get_cs_db_l_bits().  I guess "what's the point of KVM_X86_OP_NULL?"
was somewhat of a rhetorical question.

> > AFAICT, it always resolves to KVM_X86_OP.  Unless there's some magic I'm missing,
> > I vote we remove KVM_X86_OP_NULL and then not introduce KVM_X86_PMU_OP_NULL.
> > And I'm pretty sure it's useless, e.g. get_cs_db_l_bits is defined with the NULL

