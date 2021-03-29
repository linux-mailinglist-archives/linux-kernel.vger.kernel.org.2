Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9ECC34D54E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhC2QlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhC2Qkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:40:45 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48481C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:40:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v4so13486633wrp.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i3dCfNY+4sCEsAzr0CQ0LN7wBfZVpK7A0Ceu61hxU1s=;
        b=nBMEVFD3/Yhk0GiCpBp5e86ND6SxMpPkWarNAbzF3+egij9p7cl3HBlV3VA13sVytU
         NpL/Z9X8MCA/6lZXMkcOSv7DWZ2Skj9ZJSMmY7wnc4UeGgqyTpXt3p93lo2VHKovTelu
         YQiNOyJFGbZSESSclRQasDyQ1ZA+izauNy6dCBSKSW4ssNlXmXZFRrTnwNY5PdCwZ0Rb
         KrS1c9FTQYVG+l9vyOEVUxY8z54Cer5BpuZxc8U3RserLJv0A9QWFNKmsCbo/KbBUTRr
         RfcSdAL/23XDU3xA5ARSIVSUqqKGjV26XHV71p0r/YO6RS1f7EsAdX/LOwYkrPBjQ3MB
         nYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i3dCfNY+4sCEsAzr0CQ0LN7wBfZVpK7A0Ceu61hxU1s=;
        b=oOHcLZLCFEE90SX+faE/y4pi79/bMRu+2LBOdjKGkPhfSDMQ678sYKm2UQi47x65Me
         Y65Ar+QDaDtxnXvkm5/HWOKBKGNZ9QfqyUErRGl/gn9gctKaNFG25W4qkGkth3cvznKu
         348gJT8gfLOuHPdzKXg1CRGx3BC/HRudwhwuje+xuYg0NGWXklNC080Zq9sxBjWhL4QO
         1TBYTbErWxjHqG9OshmyzhwsfSAwFP/ryGwMM2dAuc6OtYw8v8xg4KFts+WvfRRgB6xz
         6qD8+QMcWsIkTmHFlgIjnRMAxrbQXBsQLBBGmd7z7BsULKQScAbJCeyd1MdmyPaIT7fU
         PMOg==
X-Gm-Message-State: AOAM530iFHtMtfnTKFh9NYuJn1UCTA+vSuZU0PZCsq73ue0NOic56XhJ
        JL5tUFGJTClAGmx5ZW9j/I+Pzg==
X-Google-Smtp-Source: ABdhPJyubZzeYatu5FH/4lE3y6PY1xRg9bCyoIQqVy+OxXvM+Rz8zu0bSP6MD51bEJyzmWliqaMBBQ==
X-Received: by 2002:adf:e38a:: with SMTP id e10mr29678375wrm.37.1617036043896;
        Mon, 29 Mar 2021 09:40:43 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:755f:9d46:d671:14be])
        by smtp.gmail.com with ESMTPSA id o11sm30017453wrq.74.2021.03.29.09.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:40:43 -0700 (PDT)
Date:   Mon, 29 Mar 2021 18:40:36 +0200
From:   Marco Elver <elver@google.com>
To:     "Sarvela, Tomi P" <tomi.p.sarvela@intel.com>
Cc:     "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: I915 CI-run with kfence enabled, issues found
Message-ID: <YGIDBAboELGgMgXy@elver.google.com>
References: <d60bba0e6f354cbdbd0ae16314edeb9a@intel.com>
 <66f453a79f2541d4b05bcd933204f1c9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66f453a79f2541d4b05bcd933204f1c9@intel.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cc x86 maintainers]

On Mon, Mar 29, 2021 at 11:11AM +0000, Sarvela, Tomi P wrote:
> Hello,
> 
> I'm Tomi Sarvela, maintainer and original creator of linux i915-CI:
> https://intel-gfx-ci.01.org/
> 
> I got a hint from Martin Peres about kfence functionality in kernel, and it looked
> something we'd like to enable in future CI runs so I made a trial run on DRM-Tip.
> We've had regular KASAN-enabled runs, so the expectation was that there
> wouldn't be too many new problems exposed.
> 
> On this run two issues were found, where one is clearly kernel (GUC) issue,
> but another looked a lot like kfence issue on old platforms. Affected
> were IVB, SNB and ILK, with bug signature being:
> 
> <3> [31.556004] BUG: using smp_processor_id() in preemptible [00000000] code: ...
> <4> [31.556070] caller is invalidate_user_asid+0x13/0x50
> 
> I'm not a kernel developer myself, so I can't make hard assertions
> where the issue originates. In comparison to kernel without kfence,
> it looks like the newly enabled code is the cause because the
> "BUG: KFENCE" signature is missing from the trace
> 
> Can someone take a look at the traces and verify if the kfence issue
> exists and is not related to the rest of the kernel? 
> 
> If there is an issue tracker, I can add this information there.
> 
> Example traces:
> https://intel-gfx-ci.01.org/tree/drm-tip/kfence_1/fi-ivb-3770/igt@gem_ctx_create@basic-files.html
> 
> https://intel-gfx-ci.01.org/tree/drm-tip/kfence_1/fi-snb-2520m/igt@gem_ctx_create@basic-files.html
> 
> https://intel-gfx-ci.01.org/tree/drm-tip/kfence_1/fi-ilk-650/igt@gem_exec_create@basic.html
> 
> Kfence-exposed possible GUC issue:
> https://intel-gfx-ci.01.org/tree/drm-tip/kfence_1/fi-kbl-guc/igt@kms_addfb_basic@addfb25-modifier-no-flag.html
> 
> All results can be seen at:
> https://intel-gfx-ci.01.org/tree/drm-tip/kfence_1/index.html
> 
> CI_DRM_9910 is recent DRM-Tip commit without -rc5 pulled in yet.
> kfence_1 is same commit with kfence defaults turned on:
[...]

It looks like the code path from flush_tlb_one_kernel() to
invalidate_user_asid()'s this_cpu_ptr() has several feature checks, so
probably some feature difference between systems where it triggers and
it doesn't.

As far as I'm aware, there is no restriction on where
flush_tlb_one_kernel() is called. We could of course guard it but I
think that's wrong.

Other than that, I hope the x86 maintainers know what's going on here.

Just for reference, the stack traces in the above logs start with:

| <3> [31.556004] BUG: using smp_processor_id() in preemptible [00000000] code: dmesg/1075
| <4> [31.556070] caller is invalidate_user_asid+0x13/0x50
| <4> [31.556078] CPU: 6 PID: 1075 Comm: dmesg Not tainted 5.12.0-rc4-gda4a2b1a5479-kfence_1+ #1
| <4> [31.556081] Hardware name: Hewlett-Packard HP Pro 3500 Series/2ABF, BIOS 8.11 10/24/2012
| <4> [31.556084] Call Trace:
| <4> [31.556088]  dump_stack+0x7f/0xad
| <4> [31.556097]  check_preemption_disabled+0xc8/0xd0
| <4> [31.556104]  invalidate_user_asid+0x13/0x50
| <4> [31.556109]  flush_tlb_one_kernel+0x5/0x20
| <4> [31.556113]  kfence_protect+0x56/0x80
| 	...........

Thanks,
-- Marco
