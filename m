Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D29424696
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbhJFTTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229926AbhJFTTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633547842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ju+4npszLsLXt5h9lPZcIr9LRIwfaE+9WGCDzWatXz4=;
        b=Z8+Z+LqA7Oq2inoL/U+1FGlITtA/n1OpyPW42IozDVkuvKqhWjAN0kLbbKDjhGg9PgMfK3
        ljdtm5wuU0EREDDo2IBEDdfbpGLgSyLq22T+jM/V5UfbaKQguHLbG0/bPAdms+md/AH5Sf
        sRrormyGkteODqtpW15vkey/60k9iPw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-r-CqxG1sPmWvIaUkFTMtdQ-1; Wed, 06 Oct 2021 15:17:21 -0400
X-MC-Unique: r-CqxG1sPmWvIaUkFTMtdQ-1
Received: by mail-ot1-f72.google.com with SMTP id k30-20020a9d4b9e000000b005472033f04cso2072161otf.16
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 12:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ju+4npszLsLXt5h9lPZcIr9LRIwfaE+9WGCDzWatXz4=;
        b=iz5TK7twLREzKN/9s2CpUuw2lhCFYmPd+KNDPnAP/aSbiYNeHix1SOUTJH1X+IR6Ww
         HuLh8uWmPpG35b2LuK6V1A487w8WAXVKjdzFZAHYJmWBCaeBgOzwdcR3wNUxseMKQCki
         5oO4oWH+T311Z89vqbHm0Hh/VrNoJ82yiy2rnSsgOTWdmcSkO9DdiGu2N7fvK/P2n50G
         oSltdboDa1RnaFgIo9zeq3IjOtRPYdoNlnu15WmK9T18qypmC+jqDSNtNtjsNBXNc28h
         JnO8T0FZnPwNnlA9XFvn5gh5kheZmancKFKmqKPkwxwI6Wx84R78ROA+jpjSo0nVzf/M
         EPBA==
X-Gm-Message-State: AOAM533SDVPW+rXsbcMtw8/1sXe1XgS/VGwdQvzCjOdVI8o+huM6zsnZ
        BysrxyA3osmXAarG1/POQDzhbfQsO4+AAiXPd6Ig2+zjqzMAAqwXj3rXFYTUt2KYCG4kDUx6yHr
        MLeHJWzINuKdmgSRZ6SuejUll
X-Received: by 2002:a05:6830:4411:: with SMTP id q17mr382020otv.67.1633547840210;
        Wed, 06 Oct 2021 12:17:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvtjb5elBfDVATVrh4cwUv2lJML3DJeMUoTgIjt3zKmlvKrrN5suZnmCAvNWJmfxkV6KNWSg==
X-Received: by 2002:a05:6830:4411:: with SMTP id q17mr382007otv.67.1633547839972;
        Wed, 06 Oct 2021 12:17:19 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id e2sm4426489otk.46.2021.10.06.12.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 12:17:19 -0700 (PDT)
Date:   Wed, 6 Oct 2021 12:17:16 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 07/11] x86/tdx: Add HLT support for TDX guest
Message-ID: <20211006191716.pyhwbgfyqugoupmg@treble>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-8-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005025205.1784480-8-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:52:01PM -0700, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> +	 * Emulate HLT operation via hypercall. More info about ABI
> +	 * can be found in TDX Guest-Host-Communication Interface
> +	 * (GHCI), sec 3.8 TDG.VP.VMCALL<Instruction.HLT>.
> +	 *
> +	 * The VMM uses the "IRQ disabled" param to understand IRQ
> +	 * enabled status (RFLAGS.IF) of TD guest and determine
> +	 * whether or not it should schedule the halted vCPU if an
> +	 * IRQ becomes pending. E.g. if IRQs are disabled the VMM
> +	 * can keep the vCPU in virtual HLT, even if an IRQ is
> +	 * pending, without hanging/breaking the guest.
> +	 *
> +	 * do_sti parameter is used by __tdx_hypercall() to decide
> +	 * whether to call STI instruction before executing TDCALL
> +	 * instruction.
> +	 */
> +	ret = _tdx_hypercall(EXIT_REASON_HLT, irq_disabled, 0, 0, do_sti, NULL);
> +
> +	/*
> +	 * Use WARN_ONCE() to report the failure. Since tdx_*halt() calls
> +	 * are also used in pv_ops, #VE error handler cannot be used to
> +	 * report the failure.
> +	 */
> +	WARN_ONCE(ret, "HLT instruction emulation failed\n");

I'm having trouble following this last comment, does it mean there's no
way to return the error back to the #VE handler when this is called in
#VE context?  Seems like that would be any easy problem to solve by
shuffling the functions a bit.

-- 
Josh

