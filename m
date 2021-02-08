Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2419931409E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhBHUht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:37:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50820 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233739AbhBHTTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:19:43 -0500
Received: from zn.tnic (p200300ec2f073f00132389f64ded89c1.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:3f00:1323:89f6:4ded:89c1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 02C901EC0512;
        Mon,  8 Feb 2021 20:19:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612811941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LQn+pWHGqbtgPfnM9tOWZS6wPqkEaJHJhfGUBzfOF9g=;
        b=Z6Q6mo8K9istjRAkkYQ538h7wPEI3jtW7N6FMqezZQHRnYiJsTialCjpyPuwKT/Qk1VLij
        ENVlQdlDfEG0qVWoyxU7Im+qpvn3dwOn46AmEokEW2wA7Mwd5/mwHYls+jN/RHA0hFAMhe
        W+cS105iEZeD22ufo7i8DVx2zyTKHu8=
Date:   Mon, 8 Feb 2021 20:19:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org,
        acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 02/49] x86/cpu: Describe hybrid CPUs in cpuinfo_x86
Message-ID: <20210208191902.GG18227@zn.tnic>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <1612797946-18784-3-git-send-email-kan.liang@linux.intel.com>
 <20210208175640.GD18227@zn.tnic>
 <cddc013c-5b48-f792-058c-009e43cfe547@linux.intel.com>
 <20210208191018.GA86425@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210208191018.GA86425@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 11:10:18AM -0800, Luck, Tony wrote:
> > +u32 x86_read_hybrid_type(void)
> > +{
> > +	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> > +		return cpuid_eax(0x0000001a);
> > +
> > +	return 0;
> > +}
> 
> Machine check logging will want to include this in "struct mce".
> 
> But ok to pick it up with a function like you describe above.

Sure, that looks ok.

We can always lift it up into cpuinfo_x86 later, when it is needed on
the majority of machines but right now it is only a small subset of
machines which have this.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
