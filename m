Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB11341E62
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 14:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCSNbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhCSNbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:31:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62122C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:31:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w3so9723659ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=igtfJfMePC2j6HLfLXHW+iGPAvT/VR1xPXkss/PXymM=;
        b=B/CoBEDjYl+Hl/IMFbrkUc3CXlth6hktuGlKeMTkQGN5KZONFtAcNlm+kbgG/N0oaF
         CmVEm/tX5SphsQIj4DwWt9Dc2F/8qid56wUO0AerG0g17PVnGtQhiI3BPas5i35/TT9O
         wXChT7EsWSRUeQq+ERppWYJZSnAJdP/SlJc1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=igtfJfMePC2j6HLfLXHW+iGPAvT/VR1xPXkss/PXymM=;
        b=YL4u21r2OfmfIf2dqLRQ73tbP2kaYv/nSNI2ajnRf5iaIhT0Inl9UMSdmnyc0t8srm
         ctL853UabClR80mTN/gasp9UJ06EwxaRR/cOmmwfacuon5BfXnP4o1yel5bhZ2VMc9Vr
         w/VGFcsfqc4ww5uNwn0ZURLqKKZ90Xryazhj47dqS2amu1Zp80YGPOPmJIJ/vx2Utq4D
         IrR+EO1MxBcQypd5jFoVN7x3b6VpsbtpR1QXZ0LL0thE6GvYoqqGlnK/gx4e/48ql997
         JuMsEubTbW6Ogb/5ky1S9YNZsTBrnCLTEDaPHAZ6SjQT12g4lmN5dMuArf8TqNKnOJ1p
         hspQ==
X-Gm-Message-State: AOAM533cO2O9CCPTj0bbaEZCKS4MkUHvqFt5Ss/TwJ8VSpIXc7PMp+Wt
        r+8GthSwJ3XoRXlj4GfyOjGh8A==
X-Google-Smtp-Source: ABdhPJwhQq5wm5iwt85ywH9EqJVIHyxU6XKYgFRVfUu6XTPymS9Pf0YQOfHUzLyTRshpSPCjjC/Z3A==
X-Received: by 2002:a17:906:53d7:: with SMTP id p23mr4420988ejo.140.1616160682159;
        Fri, 19 Mar 2021 06:31:22 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id e8sm4026595edq.77.2021.03.19.06.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 06:31:21 -0700 (PDT)
Subject: Re: [PATCH 2/3] static_call: Align static_call_is_init() patching
 condition
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, sumit.garg@linaro.org,
        oliver.sang@intel.com, jarkko@kernel.org
References: <20210318113156.407406787@infradead.org>
 <20210318113610.636651340@infradead.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f5ce3975-bda6-0e83-3a59-2fac25cc4f08@rasmusvillemoes.dk>
Date:   Fri, 19 Mar 2021 14:31:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210318113610.636651340@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2021 12.31, Peter Zijlstra wrote:
> The intent is to avoid writing init code after init (because the text
> might have been freed). The code is needlessly different between
> jump_label and static_call and not obviously correct.
> 
> The existing code relies on the fact that the module loader clears the
> init layout, such that within_module_init() always fails, while
> jump_label relies on the module state which is more obvious and
> matches the kernel logic.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/static_call.c |   14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -149,6 +149,7 @@ void __static_call_update(struct static_
>  	};
>  
>  	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
> +		bool init = system_state < SYSTEM_RUNNING;

I recently had occasion to look at whether that would be a suitable
condition for knowing whether __init stuff was gone, but concluded that
it's not. Maybe I'm wrong. init/main.c:

        free_initmem();
        mark_readonly();

        /*
         * Kernel mappings are now finalized - update the userspace
page-table
         * to finalize PTI.
         */
        pti_finalize();

        system_state = SYSTEM_RUNNING;

So ISTM there's window where system_state < SYSTEM_RUNNING but accessing
init stuff is a bad idea. If you're PID1 it's all fine, but I suppose
other kernel threads could end up calling static_call_update. And just
moving the system_state setting up before the *free_initmem() calls
doesn't really solve anything because TOCTOU.

Dunno, probably overkill, but perhaps we could have an atomic_t (or
refcount, whatever) init_ref inited to 1, with init_ref_get() doing an
inc_unless_zero, and iff you get a ref, you're free to call (/patch)
__init functions and access __initdata, but must do init_ref_put(), with
PID1 dropping its initial ref and waiting for it to drop to 0 before
doing the *free_initmem() calls.

Rasmus
