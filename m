Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0A942CAB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbhJMUNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:13:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229529AbhJMUNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634155900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OaQ+DDQR+/4l0w6VV1aW9gzFeL4XEYx9BAYZ+Ern77c=;
        b=RnxbVVxXxcaDTPazXdov/BD79wMinQxyAou+Bnp3MwvetpVftKz7c6NIZ6HXl4bqSwMfL4
        lR4k9qDi3NTmONVSQKuujNDF4vNhs1VZZUFQ0wOUp83QchwbvWB8pgVOwH+LbNWpOiEBo5
        0rwVnFhf+Q7SFwhpI4emcUm8qynrC5A=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-2EcT_6kPM6utkRjYggcXhQ-1; Wed, 13 Oct 2021 16:11:38 -0400
X-MC-Unique: 2EcT_6kPM6utkRjYggcXhQ-1
Received: by mail-oi1-f200.google.com with SMTP id v26-20020a056808005a00b00298cc6aac5bso2328957oic.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 13:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OaQ+DDQR+/4l0w6VV1aW9gzFeL4XEYx9BAYZ+Ern77c=;
        b=upI0/NJK7l7YCwPCaIWy3XwXPPBjgScSR09nSvWy08JMOjuYun8qmWDxp7EOHc1D6u
         +f4Id6E16M4V+fsT5Y5ivNm8qZ9NXyjnUt0BIR3M+r/i8EvFK7EcwewYYaLKvdXxTa1P
         wl8RTXo34GD675y/NyJ+Y9Hqk0fsbcfi5ybp4HwnId83L5zLtdH42uo0NnT3k5gf36gS
         J9DBUt2Grrn8n18NewB8cVVM/kqltXu1NqDmlpic+etFIUynvUTWL9IFBYAAgB1gheq2
         oBrN7+yn9HoFfquc1j5ipjVaFAB32fvxuVw1OU3hpS31d+fxBZkGoW0YgXOLpxqHrEOH
         MPKw==
X-Gm-Message-State: AOAM530fRB3cPQAtkCe69/Gz9kGDeiJt7y4gB1hjzlgWcHW5fWf0mP7N
        hzIrLpc5kBBdFN3iqyW0uF/FwoS4hl1fu0f69wAzdnyDUtAg7Vgf8jIkglm7yw8qTqsRgKluHR+
        SKZW47XjsmRsD7NfdQKerZ4CQ
X-Received: by 2002:a9d:4684:: with SMTP id z4mr1158520ote.134.1634155897929;
        Wed, 13 Oct 2021 13:11:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgBiD/NmoTn10E7VwwF9npBCA6LG8tWbOO7KRLrO0pXBx1sCE/A7co61Ptg2BldeN7D3jKJg==
X-Received: by 2002:a9d:4684:: with SMTP id z4mr1158502ote.134.1634155897720;
        Wed, 13 Oct 2021 13:11:37 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id u15sm136258oon.35.2021.10.13.13.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 13:11:37 -0700 (PDT)
Date:   Wed, 13 Oct 2021 13:11:35 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 1/9] objtool,x86: Replace alternatives with
 .retpoline_sites
Message-ID: <20211013201135.ftaztysa4bdjedqd@treble>
References: <20211013122217.304265366@infradead.org>
 <20211013123644.614129149@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013123644.614129149@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:22:18PM +0200, Peter Zijlstra wrote:
> Instead of writing complete alternatives, simply provide a list of all
> the retpoline thunk calls. Then the kernel is free to do with them as
> it pleases. Simpler code all-round.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

+1, let the kernel patch its own damn self ;-)

> +int arch_rewrite_retpolines(struct objtool_file *file)

Guess it shouldn't be called arch_rewrite_retpolines() anymore.  And it
can be moved to check.c next to create_static_call_sections().

Also is it possible to remove the arch_is_retpoline() check in
get_alt_entry()?  I'm having trouble remembering why that was needed in
the first place.

-- 
Josh

