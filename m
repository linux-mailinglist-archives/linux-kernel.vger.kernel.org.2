Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4231A3F3743
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 01:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbhHTXWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 19:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230211AbhHTXWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 19:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629501729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+1Nmb4ovMdE8v9GU397J2/FhLYDa9oeBcw+TIfdVZG0=;
        b=QL34EQZVkHclDD6drAqaYJCVuoyxCpiKrJ7F60tfieuCM8x1xs5uXGYLrNGzxErHLANoOP
        gY7tBXfG4vzzKGTC+Xbv/UolEiraMHg7kFa77KObp9ZAh+SfydnMUc2DQogC4ZHeEP93YA
        PU0C7I6TCkCIbGCP1JyzWkOy8vf/fV8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-43TbXpImNQ65TxaO4z1rsw-1; Fri, 20 Aug 2021 19:22:07 -0400
X-MC-Unique: 43TbXpImNQ65TxaO4z1rsw-1
Received: by mail-qk1-f198.google.com with SMTP id k12-20020a05620a0b8c00b003d5c8646ec2so917601qkh.20
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 16:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+1Nmb4ovMdE8v9GU397J2/FhLYDa9oeBcw+TIfdVZG0=;
        b=eh0nXgAwR5QflEZsYr2qy/fIoUSHdufd3omr9fEuVDWgYaPro5mJFn2r58cU6PNHLq
         krwamqx17nzEzgpR+iJi0WXR58cQlWOKNV85G87oDWf+H0IysiwyCGLki2TKjYpyvZAa
         ZxNO0yuU1BC6VzigAZo78tbuKU8s/4nKr/hq95s7GbxzzBtD4TvkMoIxLD2+whgVqeJb
         2QyhxkShYcmDjmAtBZ+1H1Le8W84VouumtZo21WExPajYyx0m4CbPJlInGD3b2VzrifI
         IY9Shysv7kHN/cMfB+ynBbpKz/U0dc3FH5ByQ7WDJkiAy+h0tdi18ayqXppwIFQnPTX8
         AOoA==
X-Gm-Message-State: AOAM5328a4vsDC7oKAbLosMi9ZZzOy+dxdRMM8leMkQzeCg5m5hyDh3I
        qTtTSu9LsG6kDrwwGgK0XQjuYC1h5ZvsF738VeCgDTiPfkixv+y2gi+NCBdGshlGROBZOMNkqKp
        2ukKUWodXbhFdrMBygkMkwhj8
X-Received: by 2002:ac8:5d42:: with SMTP id g2mr19975703qtx.141.1629501727378;
        Fri, 20 Aug 2021 16:22:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrH+o6JrolD6tUFvs8HlYOMF59XSObf9hdWqgxFz/6dQ3C4aTwBfHOPn9BOH0HUt8eSLH/8A==
X-Received: by 2002:ac8:5d42:: with SMTP id g2mr19975691qtx.141.1629501727133;
        Fri, 20 Aug 2021 16:22:07 -0700 (PDT)
Received: from treble ([68.74.140.199])
        by smtp.gmail.com with ESMTPSA id d129sm3931008qkf.136.2021.08.20.16.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 16:22:06 -0700 (PDT)
Date:   Fri, 20 Aug 2021 16:22:03 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com
Subject: Re: [PATCH v2 06/24] x86: Always inline
 context_tracking_guest_enter()
Message-ID: <20210820232203.nmuc3gelzsazyewk@treble>
References: <20210624094059.886075998@infradead.org>
 <20210624095148.003928226@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210624095148.003928226@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 11:41:05AM +0200, Peter Zijlstra wrote:
> Yes, it really did out-of-line this....
> 
> vmlinux.o: warning: objtool: vmx_vcpu_enter_exit()+0x31: call to context_tracking_guest_enter() leaves .noinstr.text section
> 
> 000000000019f660 <context_tracking_guest_enter>:
>   19f660:	e8 00 00 00 00       	callq  19f665 <context_tracking_guest_enter+0x5>	19f661: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
>   19f665:	31 c0                	xor    %eax,%eax
>   19f667:	c3                   	retq   
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Ha.  I'm guessing this was from CONFIG_DEBUG_SECTION_MISMATCH, which is
only good for triggering a lot of these useless __always_inline patches.

I have a patch somewhere to get rid of it.

-- 
Josh

