Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED75428D89
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbhJKNJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbhJKNJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:09:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5973CC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 06:07:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v17so55981973wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 06:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DTDmXntOGSA3Xd4P+y4+zBs6FGtMnqAxNvN3gSTquro=;
        b=qRVoTKYkKnql0wxTeybXAvUaagl9ZnkCJxXwOQacOJjXWqCh3jCC6DYWUKOtXsHVeW
         onObDNZ1r62xm7Xvvp5UJGapqN4RejjVbAIlSdWV1/JfyoK/UE71JxyjkJCbFtbLt4fU
         SDPbWhaLNML8641Az4DsgUUTV4/kj3DvPSt/YBuKcDpAemGIoe6Y3F3bHQl2HtMnOlMq
         g+io2Ij6ocFztU2UxCq8+8GWJZr54GEhcl1orbS23XBrLQZ2Be1IQehNE/kLPYPA8BLX
         PJfICI9ll8HLygYsuhH/6doVt1Wc4oZa5q5VAoGIg1FeF9Gyl58xwg7h8WCqoiLMm4n3
         HjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DTDmXntOGSA3Xd4P+y4+zBs6FGtMnqAxNvN3gSTquro=;
        b=x/k62aBoryeZVJyYJxstJXYzwxxeVYBqGdzzMMHoh4UEWGKqNxINRTx7WsT8h9PjvK
         g/FutLDqAGHByM+USH4fVZhdlw9MpjT9XTbbAL4Zv8vA5icpTS97yG4lzmeRDfXn9v6a
         NZmpchRdE06ROGs1msHVPs6MAWTFc2FEJigzjkHoB3peh1HG5/3RU05qSREjyudgDQ8x
         oL7qSqDSfnRRF2PmmTznbmlgYqimtxjSYzwRkcq9AlYjtIhQAN4xi3I4oxpy5LtbnX9F
         5AgY881LpjUP4K2Vlq8XbNQ+z3zDnA3iBA/+IlZcPIhWmB31AuArTMz3f8ZBwRK15dNF
         sz7Q==
X-Gm-Message-State: AOAM5312A5rRKMKakgBvvvTehx0FZJUKEBtN4HSiJVqtJdJ0TFUAL//L
        1/kixGzJlXl+rYSWzu8hovyevQ==
X-Google-Smtp-Source: ABdhPJwmpFZoh27kFQoCvaGOimhqUJpXjbsJwyIhjfMpe0JT/YZQMwdj5MuX0zWfYJXLMbUvInpb2w==
X-Received: by 2002:adf:bd8a:: with SMTP id l10mr24179774wrh.159.1633957637860;
        Mon, 11 Oct 2021 06:07:17 -0700 (PDT)
Received: from google.com ([95.148.6.175])
        by smtp.gmail.com with ESMTPSA id d24sm7514801wmb.35.2021.10.11.06.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 06:07:17 -0700 (PDT)
Date:   Mon, 11 Oct 2021 14:07:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, inglorion@google.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, tkjos@google.com
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in profile_pc
Message-ID: <YWQ3AzF+q2xeyQ/p@google.com>
References: <00000000000030293b05c39afd6f@google.com>
 <20210602230054.vyqama2q3koc4bpo@treble>
 <527ad07e-eec2-a211-03e7-afafe5196100@linux.intel.com>
 <YLjZYvXnuPnbXzOm@hirez.programming.kicks-ass.net>
 <20210603133914.j2aeadmvhncnlk5q@treble>
 <0b71d4f9-f707-3d39-c358-7c06c5689a9d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b71d4f9-f707-3d39-c358-7c06c5689a9d@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Jun 2021, Andi Kleen wrote:

> 
> > True, ftrace does have function profiling (function_profile_enabled).
> > 
> > Steve, is there a way to enable that on the kernel cmdline?
> 
> That's not really comparable. function profiling has a lot more overhead.
> Also there is various code which has ftrace instrumentation disabled.
> 
> I don't think why you want to kill the old profiler. It's rarely used, but
> when you need it usually works. It's always good to have simple fall backs.
> And it's not that it's a lot of difficult code.

sysbot is still sending out reports on this:

  https://syzkaller.appspot.com/bug?id=00c965d957410afc0d40cac5343064e0a98b9ecd

Are you guys still planning on sending out a fix?

Is there anything I can do to help?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
