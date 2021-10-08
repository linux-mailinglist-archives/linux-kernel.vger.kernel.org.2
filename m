Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E003B426F30
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhJHQlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229525AbhJHQlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633711151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5k9004A0Dw5Y6pFFXFdakqN76EXWAOVqyO0Xd4OT5XU=;
        b=RqxQXL/5RWUN8xOIG/Qt3ZNOWG5NdPLfIJAm663AjiwIY1jQFRWTPF2ya/kXgoOINWuLt3
        k991Lb/WI84v3V0gVOcFJBTRQ4DHo/jcmXgXAMKeFp1g0dSmz7nd/HXVEnB1iip0pwn3JI
        bu95Nhc1nEfrp+Y5uAIf0MzXG5m4Nsk=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-OvatNSiEOoOxDsTP-WKyFw-1; Fri, 08 Oct 2021 12:39:10 -0400
X-MC-Unique: OvatNSiEOoOxDsTP-WKyFw-1
Received: by mail-oo1-f71.google.com with SMTP id n2-20020a4a3442000000b002b63faf0fbbso5814770oof.16
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 09:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5k9004A0Dw5Y6pFFXFdakqN76EXWAOVqyO0Xd4OT5XU=;
        b=aLy9wjINAREzoMq3Tj/A6XcSyczORT8VfVl6XlGtPXweNpwSMtAjaVC3hq4CGemBrh
         mPcZMgsFq8qH1ilMOSx0KcU+mjGZM8g/iyAq+lmktuPJJWx01oeQisSTWzPoFS+q6n8Q
         40D+mCQ3b9rgct8KEm8bBtqpfJUY0U5fcPyjYeYWeNxEx2hi8qnlPrBK9Qybx4p73VrF
         ymqD2o/wREm8aMkzoZcr7UrboHrRtR5jQ2z7QutW1eVfZn4hmLRpITsOIt8DEEOSeYTe
         Lk8GvBdbXxfITIs85CUKspiKy7XAlW6W4qKJpskLhv/9bHbrwIl76HE0RcrXXvYh97xR
         jMyA==
X-Gm-Message-State: AOAM5307FGoCYvQQeGYVuS64ANziY2Frx/2X6ehEwY/E/9j95dSrssyo
        dhAyvLmAgB/DMRxNTnFYve7y9Aj0IB4hbqiyw2GwJzMX8rbVg8VlH1M4HfhYSVL7S8UaThFcb1X
        2PyEBQsq2N2aVqm3r7pHaMeXf
X-Received: by 2002:a4a:b994:: with SMTP id e20mr8631700oop.50.1633711149526;
        Fri, 08 Oct 2021 09:39:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyd0lFqeZetflYlmVXSuaqgL8ChrqUO5ydYJ8PTrIhSeKmyxFg1twvbVH1Ab5o3MA7QMtTTg==
X-Received: by 2002:a4a:b994:: with SMTP id e20mr8631685oop.50.1633711149334;
        Fri, 08 Oct 2021 09:39:09 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::48])
        by smtp.gmail.com with ESMTPSA id d26sm740078oij.49.2021.10.08.09.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 09:39:08 -0700 (PDT)
Date:   Fri, 8 Oct 2021 09:39:06 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 2/2] objtool: Optimize/fix retpoline alternative
 generation
Message-ID: <20211008163906.e5kbzwi2slldk6gh@treble>
References: <20211007212211.366874577@infradead.org>
 <20211007212627.008917519@infradead.org>
 <20211008072325.4qujedsjtjqbvzrd@treble>
 <YWAe7RSvYqdpbABf@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWAe7RSvYqdpbABf@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 12:35:25PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 08, 2021 at 12:23:25AM -0700, Josh Poimboeuf wrote:
> > On Thu, Oct 07, 2021 at 11:22:13PM +0200, Peter Zijlstra wrote:
> > > When re-running objtool it will generate alterantives for all
> > 
> > "alternatives"
> > 
> > > retpoline hunks, even if they are already present.
> > > 
> > > Discard the retpoline alternatives later so we can mark the
> > 
> > Discard? or mark as ignored?
> 
> I used 'discard' since we don't actually generate insn->alts entries.

I still don't like 'discard', it sounds like you're removing the
existing ALTERNATIVE from the file.

> > BTW, this "re-running objtool" thing is probably a bigger problem that
> > can be handled more broadly.  When writing an object, we could write a
> > dummy discard section ".discard.objtool_wuz_here" which tells it not to
> > touch it a second time as weird things could happen.
> 
> Section can't work, since we run the first pass on individual
> translations units, so if we get the wuz_here tag from one TU we can't
> tell if we perhaps forgot to run on another.
> 
> Better detecting if there's actual work to do seems safer to me.

I *really* don't like writing an ITU and then later writing it again as
part of bigger a linked object.  It's just going to introduce a lot of
bugs and a lot of individual "did I do this yet?" checks that we'll
forget to do half the time.

If we "perhaps forgot to run on another", and if that's a problem, then
shouldn't it be a warning when we detect it?

What specific scenarios were you thinking about?

> What I actually did yesterday was hack up --noinstr to WARN if there was
> an elf modification done, I could turn that into a --ro flag or
> something, which we can set on vmlinux if it's supposed to be a pure
> validation pass.

That might be useful, --dry-run or so.  Also useful for re-running
objtool with --backtrace to get more details about a warning.

> Subject: objtool: Optimize retpoline alternative generation
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Oct 7 23:15:34 CEST 2021
> 
> When re-running objtool it will generate alternatives for all
> retpoline hunks, even if they are already present.
> 
> Instead of early discarding the retpoline alterantives, hang onto them

s/alterantives/alternatives/

> @@ -1477,6 +1477,17 @@ static int add_special_section_alts(stru
>  				ret = -1;
>  				goto out;
>  			}
> +
> +			/*
> +			 * Don't generate alternative instruction streams
> +			 * (insn->alts) but instead mark the retpoline call as
> +			 * already having an alternative, so that we can avoid
> +			 * generating another instance.
> +			 */

But this also means that branch validation will get skipped on this alt,
right?  Can you mention that here, and why it's not a problem?

> +			if (new_insn->func && arch_is_retpoline(new_insn->func)) {
> +				orig_insn->ignore_alts = true;
> +				continue;
> +			}

-- 
Josh

