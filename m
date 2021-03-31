Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974A73509CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhCaVx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhCaVxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:53:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8111DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:53:18 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id w10so249202pgh.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MM0j2oe36X//rQQ8+GyI9vMxc0vf6Nwq2VgkiW4HgEw=;
        b=eiEMv4/PuzRRpwJGs4ojsw2qXKVA+nsWHdR/jJo8hrb977VXco2X0B5pJTRZngZvI3
         mj+E2o1JLGDQ7ePxR1DzidIkcOWf6HpuTaTbOkvCxVanOg7kssWTRzyJ+mq8+JF6R8bS
         a7doki5tC3wTAMlO3vi4fNjPWeRN5Eb45UOI+quwVBHfrS4VnPKxKKON9nTfFXG871c5
         GQFkXfw/PFnAeCso4esXRCMAxBNw1toz0booDEaSZ/55+91axgNUd47cTjH5O6+t45aN
         IwpZC48V92xTnQiiaS8fZpgqmrdwA6lqAgUOE1pm5rBzBFfMZR2Xuz2aZCoRAseLOgiD
         5Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MM0j2oe36X//rQQ8+GyI9vMxc0vf6Nwq2VgkiW4HgEw=;
        b=QS9gjFLva/4kkhpxq5L/rNjTYBwKIRdo76cWT3DuT7JamWWcAA0SITfkjPYr+3/T0s
         xGlv7JE7i45DG4HhsfQYKzaBxxo6qtK3lSxfFm7N0s8wJN8deRFIolmL4HUo4yHU/NyS
         buZwBO5SG9o0zsaqY9zBHTHSjvsoxowI8BjzlP8WYCp/XJlHUBqgCDLjQOsU34diib+A
         Hc8yFABTzFJdJG3jvVIg3q9hHOP8AbkkxoT9MmMK0IyN0t5FhBlcKqaIqeeS3vd8aUcz
         JHRgGL/2/nVK2vuMUD+UI1wpZNU7EXw5iYCZaMIK2F48K9ngx6lavVV7iDqjeeewOiA0
         GHFw==
X-Gm-Message-State: AOAM532LNnPc6zReE82iq2O3lS1HWi00pBhP8ICLK0l8pH1kWE9AhXBu
        TAxItWylE61qGQ/r86EumzzeGQ==
X-Google-Smtp-Source: ABdhPJzxk3OvWmDbPosHgkRyAsP6nvxaf+fnOjHVCqb5cNwnBuDUp1zakhvQzQOhTHLpnCqXFcMjJQ==
X-Received: by 2002:a62:7f45:0:b029:205:9617:a819 with SMTP id a66-20020a627f450000b02902059617a819mr4681004pfd.17.1617227598227;
        Wed, 31 Mar 2021 14:53:18 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id s22sm3172807pfe.150.2021.03.31.14.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 14:53:17 -0700 (PDT)
Date:   Wed, 31 Mar 2021 21:53:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Message-ID: <YGTvSvr2T2v3t3XA@google.com>
References: <2FE32855-EA5D-44E4-AACC-25E9B1476547@amacapital.net>
 <e62cfd0ae90de435e6819979d9027f76d835a22a.1617224710.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e62cfd0ae90de435e6819979d9027f76d835a22a.1617224710.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021, Kuppuswamy Sathyanarayanan wrote:
> Changes since v3:
>  * WARN user if SEAM does not disable MONITOR/MWAIT instruction.

Why bother?  There are a whole pile of features that are dictated by the TDX
module spec.  MONITOR/MWAIT is about as uninteresting as it gets, e.g. absolute
worst case scenario is the guest kernel crashes, whereas a lot of spec violations
would compromise the security of the guest.

> +	case EXIT_REASON_MONITOR_INSTRUCTION:
> +	case EXIT_REASON_MWAIT_INSTRUCTION:
> +		/*
> +		 * MWAIT/MONITOR features are disabled by TDX Module (SEAM)
> +		 * and also re-suppressed in kernel by clearing
> +		 * X86_FEATURE_MWAIT CPU feature flag in tdx_early_init(). So
> +		 * if TD guest still executes MWAIT/MONITOR instruction with
> +		 * above suppression, it needs user attention.
> +		 */
> +		WARN(1, "TD Guest used unsupported MWAIT/MONITOR instruction\n");

Why not just WARN_ONCE and call it good?

> +		break;
>  	default:
>  		pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
>  		return -EFAULT;
> -- 
> 2.25.1
> 
