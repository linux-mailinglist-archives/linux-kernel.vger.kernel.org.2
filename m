Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281BB3B76F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 19:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhF2RPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 13:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232222AbhF2RPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 13:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624986762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5q1DT4Lc9AeI8CEQj+XRuoybor7mlo7JZTn1v1UDLfY=;
        b=OjFiMpmkxC3G5vEy44fgn2fjnU5Bok9coMGMGXQeWH29fcpUaKzf7ccA+R6wII94DTZaBT
        R51LZKSVjYHt2uDsrIHoPOlDWxLDKFpzTyA1nf8JZ16Ep+xMxz2chJBmZng0voEwrE6r8r
        TMveT51XeSgPqsgqJaLvecyKPXJInKo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-oWo22q-_N1y-yB6cEWIn-A-1; Tue, 29 Jun 2021 13:12:28 -0400
X-MC-Unique: oWo22q-_N1y-yB6cEWIn-A-1
Received: by mail-pj1-f70.google.com with SMTP id d1-20020a17090ae281b0290170ba1f9948so2001753pjz.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 10:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5q1DT4Lc9AeI8CEQj+XRuoybor7mlo7JZTn1v1UDLfY=;
        b=aj7xAKHmm2L9Afa1bI6Y5B/iWh5wq/m1IVEgCXMUg3/C/tR0X4G6e5+Ms7puBPa9MR
         AkoSyuf71jqhi5OOrc/UrPzDNRMcc9Q3Q3BJA9ZbaWQN6D8X9wJTDKIKbMOyooBCtb3E
         deESPAaM/yjj9NhXRqBTYuGEUr7Y1qp10Afn12Ouxxwu7aIDCnJJR29LcquVvsTi8OXE
         5UExDXwc0HvkRV7baq3RbcqVgNiRnYU8CJqqfYioMWPjX8o6et2LrRCB89Sb9e/cyF9Z
         tZoVb3VCPFkL/d52w9Qk/JEufto1V3Ik+Q5UOT2pYsDAAyRXa4AVRSm6hRvXx5oVvkZD
         lWiQ==
X-Gm-Message-State: AOAM530QJuVtyo5etKDVA0qNe79M+X0P7z1tzFTzg48zLZXj/PDs/eXB
        WXsyr5/hRyBlpvus/fiIMOvYBhqTWQkKo8vOZMGXoRoc//f9qCSLLtlSAP14cGASprMKq++O8cQ
        U/HQ1Dg0Okg4NBqfrYYQZl7CW
X-Received: by 2002:a17:90b:2281:: with SMTP id kx1mr34980357pjb.217.1624986747856;
        Tue, 29 Jun 2021 10:12:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBwodc1vWNld+VUwsbbZiZx7LB1EOuyHMJHdio2zfI6WoBZOd86Zqj/hth97l504LYT0DuJQ==
X-Received: by 2002:a17:90b:2281:: with SMTP id kx1mr34980336pjb.217.1624986747586;
        Tue, 29 Jun 2021 10:12:27 -0700 (PDT)
Received: from treble ([2600:380:8772:6cac:dfb6:1d6c:e068:2f39])
        by smtp.gmail.com with ESMTPSA id x20sm8156748pge.41.2021.06.29.10.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 10:12:27 -0700 (PDT)
Date:   Tue, 29 Jun 2021 12:12:24 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michael Forney <mforney@mforney.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] objtool: Check for gelf_update_rel[a] failures
Message-ID: <20210629171224.jhlqyyb3lus323o3@treble>
References: <20210509000103.11008-1-mforney@mforney.org>
 <CAGw6cBv2NBCDrZb7ZnmAhZOJ_EwgW6tR-8AfY2v=T9OkD=6O8g@mail.gmail.com>
 <YNmHRi+00RAAUmEt@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNmHRi+00RAAUmEt@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 10:24:38AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 28, 2021 at 12:52:07AM -0700, Michael Forney wrote:
> > On 2021-05-08, Michael Forney <mforney@mforney.org> wrote:
> > > Otherwise, if these fail we end up with garbage data in the
> > > .rela.orc_unwind_ip section, leading to errors like
> > >
> > >   ld: fs/squashfs/namei.o: bad reloc symbol index (0x7f16 >= 0x12) for
> > > offset 0x7f16d5c82cc8 in section `.orc_unwind_ip'
> > >
> > > Signed-off-by: Michael Forney <mforney@mforney.org>
> > 
> > Ping on these patches.
> 
> Josh, I forever forget which libelf versions we're supposed to support,
> 
> But these patches do look reasonable to me, wdyt?

Looks ok to me.  Let me run them through some testing.

-- 
Josh

