Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74274468CB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 20:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhKETUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 15:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhKETUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 15:20:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8B0C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 12:17:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u141so1755718pfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yiw+jYjlyqxiRII7rGLvmKOfRcEy8XDkrEAV5Oat8/s=;
        b=BU3XXOa2flKN3yDy+6VjIsgreEc8PRVVsOYGPIP+JZxUR9qb9sv8YVFMWyPGQODRGF
         r3Lj7BoJimMGCktPpZ87Yj+m3+yk/wzm0kt4XG6E44bAW9a623fYHsZO9V96xwuDtuqY
         9AG0RVrEn6MHFbTU5Vmebo3Iha798QDJz7oHoP5mH34OqyNJDbFL5asUvbJ76L7x8gr8
         eYhXy002NmmjzuJmrimtEvEybpsUpcQm7ogKn1fo9tbYjyLGiASDupTWcjlLXInOcsmi
         7kkPJugBQNugrM7sC+uPfiudUvGt9Ajs4F4yyXGOmNuSb3xQD8JIVJ2sPy2/imI9imYv
         RM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yiw+jYjlyqxiRII7rGLvmKOfRcEy8XDkrEAV5Oat8/s=;
        b=KBacEz4Ija0UPobqp0xkd04SYaXgjhH0ZelPz34wLfi4BXR21ogPZ8DI5W6cWXwmEp
         XNKDMbleRjHIP3DpYESKzPgxUx7Iu5yPi8H4BiufLx40vph3NXDOpVaKzC/DKL6I6Ka1
         OoF7RsV8HLSwd4qMPWEuX9geHTMjY/eFWph6Y+Dugp85T4g/wFZxBNt16zdCUSSTXzob
         KUlm4/rsa6VP8zIsba/5E+71Y2GW2DxkNvn3pwu1TBuhUFUEKSVu7b/Xsa+4DsL7aQiv
         e5kX+JVzDbzxLRfba1c/nqLpczdvccqUOEi9jr+STS3tsfuieveCfEajxTZFzeMujHIL
         UFcA==
X-Gm-Message-State: AOAM533hgtZjkFW0c6B4yMtIuMmNDhrSlpJY+FUQUpU99M76qHbAV9ZD
        hfC1wGEbtRqMfsbJceqwjd5Fl2DaudPr/w==
X-Google-Smtp-Source: ABdhPJwSi69qdLSMwP1kOhvn8e/+qf4CBQ3KvIuT6HHBTbWRgr+DeU8+w/XJ0JNOWSo4j3gBSc0epw==
X-Received: by 2002:a62:4e92:0:b0:498:298d:fbb3 with SMTP id c140-20020a624e92000000b00498298dfbb3mr9354983pfb.69.1636139844298;
        Fri, 05 Nov 2021 12:17:24 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e12sm6708263pgv.82.2021.11.05.12.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 12:17:23 -0700 (PDT)
Date:   Fri, 5 Nov 2021 19:17:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 07/22] x86,extable: Extend extable functionality
Message-ID: <YYWDQO3ugarMcKmH@google.com>
References: <20211104164729.226550532@infradead.org>
 <20211104165524.925401847@infradead.org>
 <YYVqnr+gql9RpL4C@google.com>
 <20211105184556.GN174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105184556.GN174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021, Peter Zijlstra wrote:
> On Fri, Nov 05, 2021 at 05:32:14PM +0000, Sean Christopherson wrote:
> 
> > > +#define EX_IMM_MASK	0xFFFF0000
> 
> > > +	imm  = FIELD_GET(EX_IMM_MASK,  e->type);
> > 
> > FIELD_GET casts the result based on the type of the mask, but doesn't explicitly
> > sign extend the masked field, i.e. there's no intermediate cast to tell the compiler
> > that the imm is a 16-bit value that should be sign extended.
> > 
> > Modifying FIELD_GET to sign extended is probably a bad idea as I'm guessing the
> > vast, vast majority of use cases don't want that behavior.  I'm not sure how that
> > would even work with masks that are e.g. 5 bits or so.
> 
> So the way I was reading it was that typeof(_mask) is 'int', e->type is
> also 'int', we mask out the top bits, and since it's all 'int' we do an
> arith shift right (ie. preserves sign).
> 
> Where did that reading go wrong?

Hmm, C99 standard says that right shift with a negative value is implementation
specific:

  E1 has a signed type and a negative value, the resulting value is implementation-defined.

gcc-10 generates a bare "shr", i.e. doesn't special case negative values, and "shr"
is explicitly defined as an unsigned divide.
