Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9889C3A3825
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFJX7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:59:50 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:46986 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhFJX7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:59:48 -0400
Received: by mail-pf1-f180.google.com with SMTP id u126so2935255pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 16:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lexgNWKD+GrwedYrNyIr+8VQl79Jux5mczugGGcvcEI=;
        b=kziLZY1w3m2hJfVWJOCacMUB2zEiy6reAKeMbqP4OJTDSS6u0FF9LEEFCm/YMy+iyL
         HlnQGjYdgsrVsfbWY7AR2G3zzZl1rvMjVJRWwkqhCD1NaXx+24gZPC6o5O6ejV/OBvVq
         ydOUBu/y/o1pRC0od8l0/kMfmNBidBVHxo/tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lexgNWKD+GrwedYrNyIr+8VQl79Jux5mczugGGcvcEI=;
        b=NzOn2Y9dEHfyO3jDUVmq+QmsKs7S4j2p6OmEhuOAR7WhdUQm63XTMWUHW6M3QLOWwh
         9YVxyokAgG+VXhezO4tdoqrKaWlW1ZttG2xK5SetzYArNSE9vrPTFKlqCoZhXhA/ROaB
         XE8jQQEn7u9K5o68Bfa5/LdA23i19ukHnA/Q6ace7Uro38+19c3lZBXmdx+AF9MbYr1P
         xxSzphtKZNWbgZFl19cg6aniD2qH1TKyE0o6MEEK5qplEMiRu5KPB/EEL8Rmi5iM9jR8
         jRC9xI6bzi6efK1FboH6RZ6XqZ5N06D+xXOeMjkBXyyKHhgrlQXwEoCrqU2Wvzh79Y92
         GXOg==
X-Gm-Message-State: AOAM530UpUF4WdzsMxrO1k7TznL/8eqRTcklGdwxCzkFJJ5caGCQhIXl
        dQdRqXoNzrq2H39sFp/3MIHcug==
X-Google-Smtp-Source: ABdhPJz8xaiotblriOaDK72bhdHZGRRJLw3W8/YM7a9jgrhttzY5ZOHMu4xhe0nUb5MrxEhTOwjIoQ==
X-Received: by 2002:a62:77d0:0:b029:2e9:a7ca:9c50 with SMTP id s199-20020a6277d00000b02902e9a7ca9c50mr5410193pfc.5.1623369401822;
        Thu, 10 Jun 2021 16:56:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c21sm3311683pfi.44.2021.06.10.16.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 16:56:41 -0700 (PDT)
Date:   Thu, 10 Jun 2021 16:56:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Subject: Re: [PATCH] ARC: fix CONFIG_HARDENED_USERCOPY
Message-ID: <202106101656.C79AEC493@keescook>
References: <20210609221211.2457203-1-vgupta@synopsys.com>
 <202106101001.C736237@keescook>
 <53daee07-9c5b-9cf9-f08a-524afaee762a@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53daee07-9c5b-9cf9-f08a-524afaee762a@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 06:56:48PM +0000, Vineet Gupta wrote:
> On 6/10/21 10:02 AM, Kees Cook wrote:
> > On Wed, Jun 09, 2021 at 03:12:11PM -0700, Vineet Gupta wrote:
> >> Currently enabling this triggers a warning
> >>
> >> | usercopy: Kernel memory overwrite attempt detected to kernel text (offset 155633, size 11)!
> >> | usercopy: BUG: failure at mm/usercopy.c:99/usercopy_abort()!
> >> |
> >> |gcc generated __builtin_trap
> >> |Path: /bin/busybox
> >> |CPU: 0 PID: 84 Comm: init Not tainted 5.4.22
> >> |
> >> |[ECR ]: 0x00090005 => gcc generated __builtin_trap
> >> |[EFA ]: 0x9024fcaa
> >> |[BLINK ]: usercopy_abort+0x8a/0x8c
> >> |[ERET ]: memfd_fcntl+0x0/0x470
> >> |[STAT32]: 0x80080802 : IE K
> >> |BTA: 0x901ba38c SP: 0xbe161ecc FP: 0xbf9fe950
> >> |LPS: 0x90677408 LPE: 0x9067740c LPC: 0x00000000
> >> |r00: 0x0000003c r01: 0xbf0ed280 r02: 0x00000000
> >> |r03: 0xbe15fa30 r04: 0x00d2803e r05: 0x00000000
> >> |r06: 0x675d7000 r07: 0x00000000 r08: 0x675d9c00
> >> |r09: 0x00000000 r10: 0x0000035c r11: 0x61206572
> >> |r12: 0x9024fcaa r13: 0x0000000b r14: 0x0000000b
> >> |r15: 0x00000000 r16: 0x90169ffc r17: 0x90168000
> >> |r18: 0x00000000 r19: 0xbf092010 r20: 0x00000001
> >> |r21: 0x00000011 r22: 0x5ffffff1 r23: 0x90169ff1
> >> |r24: 0xbe196c00 r25: 0xbf0ed280
> >> |
> >> |Stack Trace:
> >> | memfd_fcntl+0x0/0x470
> >> | usercopy_abort+0x8a/0x8c
> >> | __check_object_size+0x10e/0x138
> >> | copy_strings+0x1f4/0x38c
> >> | __do_execve_file+0x352/0x848
> >> | EV_Trap+0xcc/0xd0
> > What was the root cause here? Was it that the init section gets freed
> > and reused for kmalloc?
> 
> Right. ARC _stext was encompassing the init section (to cover the init 
> code) so when init gets freed and used by kmalloc, 
> check_kernel_text_object() trips as it thinks the allocated pointer is 
> in kernel .text. Actually I should have added this to changelog.

Great! Yeah, if you respin it with that added, please consider it:

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-- 
Kees Cook
