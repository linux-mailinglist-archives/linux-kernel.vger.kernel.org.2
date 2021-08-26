Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19B53F8180
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 06:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhHZELm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 00:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44507 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229566AbhHZELl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 00:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629951054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4xQRAFWBDSaiyZr7T/4Rc+F+/LdK8x5V5G3iTJLNVdU=;
        b=IyOHHinOC9LVEHIoyJpxKRLfo57Y36o0/DzzS995uWE7dK59Eo1KgHr7BEN6c79YIJUfU4
        EVqbTg6vk0sr/WWLgmj96O5Tea6oFzTg4b1GyKu34X52z682/+gepMT4ISeGw1iO2H/DeW
        YHicV3zl5kHsfFW2aCqK7NYWqxv6j0Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-gOPOeoS4N5OZxqSFeTBSQw-1; Thu, 26 Aug 2021 00:10:53 -0400
X-MC-Unique: gOPOeoS4N5OZxqSFeTBSQw-1
Received: by mail-qk1-f200.google.com with SMTP id k12-20020a05620a0b8c00b003d5c8646ec2so840816qkh.20
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 21:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4xQRAFWBDSaiyZr7T/4Rc+F+/LdK8x5V5G3iTJLNVdU=;
        b=r3sfUFjckK6fxgvj5xl+ymPBG1nGkvZDFjw2jlPcfTTIs2XoHHwJQSwaxUCwRlImla
         TlQ1ZYbsSW90wXzYBB4/u2YKXgtbSglqgrgzCTXXt4iRZIzYyn7ej+VAYkAbIq0xqMBH
         JSZ5hoslkEyl/bp5ZXzHV39wTeHD/wBMP7wfZsAhOKWCAOBt6GSh1g80vQ07gNHAxcGV
         xIiiRKW+hs8X+TRY2SCkzy31G12qeBM/O0NWqseCbvCTA9gp3VULKz3n51dRPERj6PE0
         Z/8SnDYxx970vXM/53SE6ed1wXtaPkkdpnBwGhhvq5tacymSesxEzsaSp9PIYX7djV1A
         Si+w==
X-Gm-Message-State: AOAM531QRpqbbCMhqEen4E0Slsan2H3JVLEQtWLPG49yLJBeCKwIqVjk
        Fm0vgcepKr8AuaegD0eCOnoWsbFVjayD8Mbd2IbXU7oT6s2dlApGMBjDUGCEETbk/j9ApD40iir
        VxOXncSRlGcTz9dFPdO8vzROK
X-Received: by 2002:a37:7141:: with SMTP id m62mr1868616qkc.496.1629951052516;
        Wed, 25 Aug 2021 21:10:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+EKbmgJTIccUcLDMDQmNZS1xMjJhLA99e03sMTa1ZS8JG4AvQAeVw6lt3oIoodsZgRSdYiA==
X-Received: by 2002:a37:7141:: with SMTP id m62mr1868597qkc.496.1629951052266;
        Wed, 25 Aug 2021 21:10:52 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::a])
        by smtp.gmail.com with ESMTPSA id 62sm1217595qtg.58.2021.08.25.21.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 21:10:51 -0700 (PDT)
Date:   Wed, 25 Aug 2021 21:10:48 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com, masahiroy@kernel.org, hca@linux.ibm.com,
        nickhu@andestech.com, vgupta@kernel.org
Subject: Re: [PATCH v2 06/24] x86: Always inline
 context_tracking_guest_enter()
Message-ID: <20210826041048.d5524ys6q32fue7w@treble>
References: <20210624094059.886075998@infradead.org>
 <20210624095148.003928226@infradead.org>
 <20210820232203.nmuc3gelzsazyewk@treble>
 <20210820233440.jjzdw6qjnytonlmv@treble>
 <YSY0gSLyTL3kIfP8@hirez.programming.kicks-ass.net>
 <YSZxtBHNJzoUbqdE@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSZxtBHNJzoUbqdE@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 06:37:08PM +0200, Sam Ravnborg wrote:
> Hi Josh,
> 
> On Wed, Aug 25, 2021 at 02:16:01PM +0200, Peter Zijlstra wrote:
> > On Fri, Aug 20, 2021 at 04:34:40PM -0700, Josh Poimboeuf wrote:
> > 
> > > WARNING: This patch may shrink your patch set and improve your sanity.
> > 
> > I'll go rebuild me some kernels to see how many __always_inline things I
> > can drop.
> > 
> > Lets add a few Cc's though.
> > 
> > > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Subject: [PATCH] kbuild: Remove CONFIG_DEBUG_SECTION_MISMATCH
> > > 
> > > So the option isn't actually useful.  It's not even useful for finding
> > > issues on other configs, which might have different inlining decisions,
> > > because with -O2, once-called static functions are always inlined.
> We have following -O possibilities:
> 
>     ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
>     KBUILD_CFLAGS += -O2
>     else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
>     KBUILD_CFLAGS += -O3
>     else ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>     KBUILD_CFLAGS += -Os
>     endif
> 
> We always built with -Os or -O2 (and ARC supports -O3).
> Do we know that gcc and clang will always inline once-called functions
> with -O2 and -Os for the relevant architectures?

Hm, I should have read the GCC manual a little closer:

  -finline-functions-called-once
      Consider all "static" functions called once for inlining into their
      caller even if they are not marked "inline".

So it's not necessarily a guarantee that once-called functions will
always be inlined.  Looking at GCC code, there at least some theoretical
edge cases involving optimization mismatches between caller and callee,
though as a rule the kernel avoids function-specific optimizations.

Still, I think the patch is a net benefit.  I'll update the patch
description and post it again separately since Peter doesn't seem to
need it here.

> If you can answer yes to this with some confidence then you can add my:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Note: I added this option long time ago and is unhappy if this only
> have resulted in useless code changes.

It might have been useful in the days before we had all the automated
build bots doing randconfigs.  Nowadays any __init mismatch issues which
would only be seen in obscure config/compiler combinations will be
rooted out by the bots reporting modpost section mismatch warnings.
 
-- 
Josh

