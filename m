Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD31341FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCSOlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhCSOkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:40:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126D2C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:40:49 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id t18so10091997ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PsrnI48ySMteNGZy7QIyyURu5S7qa7kJDmOkJNl11Cw=;
        b=IkcC4qr2yTWUlfbmTP2MjPqskcRrXhgdHOF6uBuoXHQVEFWcFrI9rDetVMmA/9lZyX
         /zP6zimoQzPpUU2ncWnO1VDjCp0S3wtlWx2YufmEE3ns6Jm/fdymPxfRhkDdC4C15Rep
         Px2QRwKMca5rAG5Za8fSVLqWDTR59u7eNL9B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PsrnI48ySMteNGZy7QIyyURu5S7qa7kJDmOkJNl11Cw=;
        b=SWqT7pPlmwGUVqtm19tAJcwkLDCLmZwnc9oYpfMbdqoYrZoZ80Zu3ApGHx31NrdPIU
         Ztrypqpx2fLYjQT+cmnkEsiZ2MImFvyVC82XMtA4jEPm/93jyYp0wPtzHkmL/TEsrBx8
         tm8h1kb2VpKVdhjbu3H4PQXnfwoScPbcO1LzI3qVlKEUKrpAoszz7fAXY7PqCHFgNNCm
         pa7sWZtMx8rCKt47np4VYPD6+bCrMFd7zNkfM9Qm2q0brkRBJVceg62MxRj5I8PU+WIg
         VGjPjsNhZyLb2T8CW7sRG7bqdvriY/HHOBFLTqL96yvmv5Nmz7tuHPt6pDp/xpwjbgxy
         hvnA==
X-Gm-Message-State: AOAM5320YieETDOpTUkNuHIm+fZoU2nl1dtxsWH7XcxDVxDsinF01zKM
        OcY0XuXxzLgYIyLbTvbjEjiuQQ==
X-Google-Smtp-Source: ABdhPJzHzB6EA1bmog3TArH1N6/9x3z2Y7umLsmKy+00vRx/4sSdCTXrPxdItH3dF/5ow/Yuol+R5Q==
X-Received: by 2002:a17:906:3f8c:: with SMTP id b12mr4846664ejj.340.1616164847771;
        Fri, 19 Mar 2021 07:40:47 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id gt37sm3694510ejc.12.2021.03.19.07.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 07:40:47 -0700 (PDT)
Subject: Re: [PATCH 2/3] static_call: Align static_call_is_init() patching
 condition
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org
References: <20210318113156.407406787@infradead.org>
 <20210318113610.636651340@infradead.org>
 <f5ce3975-bda6-0e83-3a59-2fac25cc4f08@rasmusvillemoes.dk>
 <YFSxorIVeuA2zCXt@hirez.programming.kicks-ass.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <c4e9dfdf-c83a-3314-8c55-5b2371a56ec8@rasmusvillemoes.dk>
Date:   Fri, 19 Mar 2021 15:40:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFSxorIVeuA2zCXt@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2021 15.13, Peter Zijlstra wrote:

>> Dunno, probably overkill, but perhaps we could have an atomic_t (or
>> refcount, whatever) init_ref inited to 1, with init_ref_get() doing an
>> inc_unless_zero, and iff you get a ref, you're free to call (/patch)
>> __init functions and access __initdata, but must do init_ref_put(), with
>> PID1 dropping its initial ref and waiting for it to drop to 0 before
>> doing the *free_initmem() calls.
> 
> I'd as soon simply add another SYSTEM state. That way we don't have to
> worry about who else looks at RUNNING for what etc..

I don't understand. How would that solve the

PID1                           PIDX
                               ok = system_state < INIT_MEM_GONE;
system_state = INIT_MEM_GONE;
free_initmem();
system_state = RUNNING;
                               if (ok)
                                   poke init mem

race? I really don't see any way arbitrary threads can reliably check
how far PID1 has progressed at one point in time and use that
information (a few lines) later to access init memory without
synchronizing with PID1.

AFAICT, having an atomic_t object representing the init memory and a
"no, you can't have a new reference" would guarantee correctness of the
jump_label/static_call patching: If we get a reference, we do the
patching just as for the rest of the kernel .text. If we don't, i.e.
observe atomic_load(init_ref)==0, that may not necessarily mean that
PID1 has actually discarded the memory yet, but no thread can currently
or in the future actually run __init code, so it need not be patched.

Rasmus
