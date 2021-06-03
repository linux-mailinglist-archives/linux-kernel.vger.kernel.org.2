Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B43339A237
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFCNbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229966AbhFCNbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622727004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yUmT0cP1KZhLluKuQXgcdIZ/sZg0Ji5yoMpxD9gZOmE=;
        b=AZ+7pwlxkUXzK3jN/2NaE9wCCS3UjoFyZrkXh2RIGrQvhL4h1MHtOZBRuqi5C7y8cj+x+O
        inPFEwY3UeNxNL0UU7Y7vzxlw+kopa81KWwtV3lm4P3AHxo2iry1a1jkbF46iwBFS7Wwna
        mSKW9qt3LUI+MvL51bUtNmRTIH4r53U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-cQZ09Qa6NPyjmJdt_jXViA-1; Thu, 03 Jun 2021 09:30:01 -0400
X-MC-Unique: cQZ09Qa6NPyjmJdt_jXViA-1
Received: by mail-qt1-f198.google.com with SMTP id b20-20020ac87fd40000b02901e1370c5e12so3061900qtk.17
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 06:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yUmT0cP1KZhLluKuQXgcdIZ/sZg0Ji5yoMpxD9gZOmE=;
        b=WI1MI/p8Lt2tICD4wLrpu/6VNrwH9imLKPsIOPEQDvzsfin+R9POCd0TWwbkwJ59pt
         FP2mrIGoL3EuCFrpnnKxhM01eBofPEmR6nGvu5UDoJaPSlsO87pyRYqnitPTH5nGwI0a
         v6L/hAYW6wji69KwXZvl2bHBVvhVelIyur9esbR1a4H12Saj8Hs/MbdpFoadupp6AaHl
         azBIDnPpn/dbl1sdou5NTavkwYguJXl8t8aZHt8mmk128bSB6NjqJ+NeVzRcr4MlNaut
         +RgJ5X74nTIo9IyKCngyUdPFazwdHPEIgqrXKExXzrzEloIkVGt/cRb1k9gROyST5WQI
         jiLA==
X-Gm-Message-State: AOAM530NuFjlkuS7ZtZxkonxPOofa99k3PzUxa7jbLZ/2CDwDLE0Vlep
        ZtQ2JM7ClfnD8IgHBntaMXxYlPMUDR30hA0C0SZrz4MmE1BoySLLAnqFil+jA8tXJITGz0cK14s
        KDGDuXMaffI3hDB6sFnnXCXAO
X-Received: by 2002:ad4:4e68:: with SMTP id ec8mr6323417qvb.62.1622727001035;
        Thu, 03 Jun 2021 06:30:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4//VLKqiOaTiRlhKd42kha2+hYrjrINLI8qAfJvPqDSVtHZzeGyL/bYTaeITtP46mKuOIeg==
X-Received: by 2002:ad4:4e68:: with SMTP id ec8mr6323398qvb.62.1622727000836;
        Thu, 03 Jun 2021 06:30:00 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id x5sm1904867qkj.46.2021.06.03.06.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 06:30:00 -0700 (PDT)
Date:   Thu, 3 Jun 2021 08:29:58 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     syzbot <syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, inglorion@google.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in profile_pc
Message-ID: <20210603132958.3es4xagwdijmzpqh@treble>
References: <00000000000030293b05c39afd6f@google.com>
 <20210602230054.vyqama2q3koc4bpo@treble>
 <527ad07e-eec2-a211-03e7-afafe5196100@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <527ad07e-eec2-a211-03e7-afafe5196100@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 04:35:11PM -0700, Andi Kleen wrote:
> 
> > profile_pc() assumes the return address is either directly at regs->sp,
> > or one word adjacent to it due to saved flags, both of which are just
> > completely wrong.  This code has probably never worked with ORC, and
> > nobody noticed apparently.
> 
> I presume it used to work because the lock functions were really simple, but
> that's not true anymore.

Yeah, I figured as much.

> > We could just use ORC to unwind to the next frame.  Though, isn't
> > /proc/profile redundant, compared to all the more sophisticated options
> > nowadays?  Is there still a distinct use case for it or can we just
> > remove it?
> 
> It's still needed for some special cases. For example there is no other
> viable way to profile early boot without a VM
> 
> I would just drop the hack to unwind, at least for the early boot profile
> use case locking profiling is usually not needed.

Ok, I'll just get rid of the hack then.

-- 
Josh

