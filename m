Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8F4453ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 21:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhKPUPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 15:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhKPUPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 15:15:43 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56080C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 12:12:46 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so3246787pja.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 12:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hPUDmE4iqUVbfnpnjy6JZAd5PXVFUlLHYstHCTZX1/g=;
        b=szeTrShUjcCHEnJSzmHXNo5NwaUaT2peWqbdfIzVJXkzsdKO6lbDb36U+UJo6QU+VC
         aaA2ItHvFdq/g1BBdhVcBUAoPj483RJBksMnbgk+Bvv7acqLMg/jvhASq9v2Rmte79F7
         LiZnsrhqkYb2PKaOMraSv+a5aote70df0l2VpwmTiV7UXbcy088uh3+CHONZO9y4+A4s
         UHB7mbHx62a4A+QmwuFnzzYBCJbvZVvDCtyBYvhfxFkNwC0lVSauAbA2xd+P+tFTDDNO
         EBp1AntSApoEcNUxgUhsnf/GHcp+FAMND6hbsPndB+ulawrbuyL487QH4l/UADG6PWqY
         Az/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hPUDmE4iqUVbfnpnjy6JZAd5PXVFUlLHYstHCTZX1/g=;
        b=NxlBnl/IA1AtEzLzNDjBPoG1R4AleVTWKTmtP+OIc47O2nysqxr377pPawXPSisgYO
         Q00IZ9lDWEZhhIXAQ8vQd+quG9DB4PiIHNVZSA92Xbc/vS1iiyzYIG+MCRGR+Y4LQ0MV
         w8v7TvhMGG3miXWDsmlM1MYk9xolzWJ3GqaLCdXwIJVZ5X6Pb0tCGr1FagQ7TJEwYtIo
         FgHaUYjlj5gMlPIpZPYCBujxMjDNJdLaBtLBYtNmL791oerxwrim2qbekOVBVowxoLjK
         wAXhYNDA17Xuz23hJ5Y/8cTyHsx6DNetGgHo/SHLGCwdPqxdx+lcingY5kWYKiXpAlRO
         ZgEQ==
X-Gm-Message-State: AOAM5336ZJtQcLmwy8cgAn5fnK4LjXKI0ICjOfCkwMCiRN4d+TXq/MSv
        EyUjS4tSv8IIt9ntRhJeekFyig==
X-Google-Smtp-Source: ABdhPJyA8KiYciUTHY85AmIpEqEfSQYYTJ6DX1SXKH+4SCUH4jwtRLz4BeBJMZS15GB54WjD7k2VsQ==
X-Received: by 2002:a17:90a:ce14:: with SMTP id f20mr2193681pju.121.1637093565555;
        Tue, 16 Nov 2021 12:12:45 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g1sm19179071pfm.25.2021.11.16.12.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 12:12:45 -0800 (PST)
Date:   Tue, 16 Nov 2021 20:12:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Liu, Jing2" <jing2.liu@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jing Liu <jing2.liu@linux.intel.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Subject: Re: Thoughts of AMX KVM support based on latest kernel
Message-ID: <YZQQuQDWPhcJG6pM@google.com>
References: <BYAPR11MB325685AB8E3DFD245846F854A9939@BYAPR11MB3256.namprd11.prod.outlook.com>
 <87k0h85m65.ffs@tglx>
 <YZPWsICdDTZ02UDu@google.com>
 <87ee7g53rp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee7g53rp.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021, Thomas Gleixner wrote:
> Now you could argue that the interrupt/softirq XSAVES should also read
> the XFD MSR and save it in guest_fpstate.xfd. Same in schedule()
> and kvm_put_guest_fpu(), i.e:
> 
>       XSAVES
>       if (fpstate->is_guest) {
>             rdmsrl(XFD, xfd);
>             fpstate->xfd = xfd;
>             __this_cpu_write(..., xfd);
>       }
> 
> We can do that, but I'm unhappy about this conditional in schedule(). So
> I was asking for doing a simple KVM only solution first:

Ah, the schedule() conditional is the part I was missing.  Thanks!
