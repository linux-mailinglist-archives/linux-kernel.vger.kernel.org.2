Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16C73E07AF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240309AbhHDSek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:34:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240289AbhHDSej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628102065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hlb+xRZV+z9q4u5VqbS/pgDyaJDNtQ939RsvQHMzgbU=;
        b=VtbidKvVOxjgMZAFSUZjIdNMZtEDk39JN/G0yOA5fMBTC430MRKABprLGeKHRbw+Omv4vL
        PfRR88ZfXgtBvrVsNDrJCV1V3pQS1jVM8VhEG2hVQ8fr+rBvihvuyJFc/AfwUK7bNCA1Qp
        vA/ytcxjYt4t/K7YohsSY1NSPU9m9ic=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-Hme70hdnMPG0-ChmzJrBpw-1; Wed, 04 Aug 2021 14:34:22 -0400
X-MC-Unique: Hme70hdnMPG0-ChmzJrBpw-1
Received: by mail-qk1-f197.google.com with SMTP id i15-20020a05620a150fb02903b960837cbfso2582836qkk.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 11:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hlb+xRZV+z9q4u5VqbS/pgDyaJDNtQ939RsvQHMzgbU=;
        b=aDNWEbPbKkRJIZaVri7sHomRDXkBZsYfx1UMoKLnOskdPs5PZzbEoPf/XUxMi0/kl2
         eNNRo2X9sxDLKswxJjojPujIHfEkkj6/OOz2QhM/mnskygvstLjdedaG0mb/UI2A/5Iv
         fRk93n0wMNCe/vim0mO/jAhpPIHvHubxdNv86lHmxkk68oaScwXvd3GztcdWEBCmdhsy
         mRaiu+3q61Ddwp2PyjpTB5bxl+hIQOhYDi7RC1A8fzai8CfAxLxmOjezRNkYS05OKtMt
         QqIu8OBBPQmGqviHENZXyU8wyx2Qj4Rcsx6nkWx3HsGRJ4ElX4ofv5eNlqiidivwwWAH
         3s4w==
X-Gm-Message-State: AOAM533Qw1AHbNxGzRBU+c+mf/FULfRiSQFc6yPdEBIcrwp1/ePr6JXV
        ORZ2PKtLfm5lT+1tML0mggJ8WL0Dv8gNbqpic+e7I9O37GO/aUIyFQzBejJNGvba1cV3KZanjJW
        yZlGXURrUbTazyZWpl0wInLIK
X-Received: by 2002:a05:620a:1913:: with SMTP id bj19mr753126qkb.341.1628102062033;
        Wed, 04 Aug 2021 11:34:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+PwbFy5Egs9sds3sq3/LK8jhuOPC4aazyRm72gTOAQ0jaeZaTEJk9zhhLIOTsTiygYfAhrg==
X-Received: by 2002:a05:620a:1913:: with SMTP id bj19mr753102qkb.341.1628102061816;
        Wed, 04 Aug 2021 11:34:21 -0700 (PDT)
Received: from treble ([68.74.140.199])
        by smtp.gmail.com with ESMTPSA id g13sm1237020qtj.2.2021.08.04.11.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 11:34:21 -0700 (PDT)
Date:   Wed, 4 Aug 2021 11:34:19 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: objtool hang/loop?
Message-ID: <20210804183419.k7p3tvqerwgzxpuz@treble>
References: <be49b820-434f-cebe-0902-3d5177239233@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be49b820-434f-cebe-0902-3d5177239233@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 07:25:21PM -0700, Randy Dunlap wrote:
> Hi Josh & Peter,
> 
> Yesterday (2021-07-27), one of my x86_64 randconfig build ran for
> over 2 hours (it's a slow core i5 laptop and spinning rust media).
> I killed it and reran the .config file today on linux-next-20210728.
> I killed this one after 30 minutes on its last message:
>   OBJTOOL vmlinux.o
> 
> This is a .config with # CONFIG_MODULES is not set.
> vmlinux.o is 253 MB in size.
> I see that using verbose make (V=1) won't help me any here.
> 
> The problematic (if it is a problem: maybe I didn't wait long
> enough?) .config file is attached.  The gzipped vmlinux.o file is at:
>   http://www.infradead.org/~rdunlap/vmlinux.o.gz
> 
> If there is a problem, I can test any patches...

Hi Randy,

I'm guessing your laptop doesn't have a lot of RAM.  I ran

  /usr/bin/time -v tools/objtool/objtool check --noinstr --vmlinux --no-fp --uaccess vmlinux.o

It showed a max RSS of 6.5GB.

Can you try this patch from Peter?  It halves the memory usage.

  https://lkml.kernel.org/r/20210507164925.GC54801@worktop.programming.kicks-ass.net

-- 
Josh

