Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D340933C54A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhCOSK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhCOSKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:10:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48F7C06174A;
        Mon, 15 Mar 2021 11:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2u7R/nEmMLjpbIw1cf7EstUt//SFRpdL2WMEtrso3hQ=; b=AfinbzWr9Gp7wDjUuemJcOVQkZ
        pmr42l1b5SwV4cZXn6dBxVxH1cqhunwgnGOv74lXIcW8xKJN7GQP9tmWIPwktR7PPN9CfjH7JDIOr
        LwJWpNCjS9GeoVgfUYfh8bMqgeh+VokvAyjcFRKuthQu39ZozkTiBH2m7boq6sWJXwVmRXw8YoDIF
        lOv0K/neQrREfoa498UA877YYM86NVeN2QCo8p/Hh3juN1Br0naDTpsmOw0r8BE9gisLcUQiDYJU1
        69HU8BNICzjnWkByI9+XcqiN6Fbn9HGzpfOYfAloLAFRfz0G1h3cUuTrcrcSizI3NHV2+pK1pbLNH
        AzHQ9oag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLrfK-00GeJZ-NU; Mon, 15 Mar 2021 18:10:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DACDB301324;
        Mon, 15 Mar 2021 19:10:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDBFE2BF450C1; Mon, 15 Mar 2021 19:10:05 +0100 (CET)
Date:   Mon, 15 Mar 2021 19:10:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
Message-ID: <YE+i/VWITCCb37tD@hirez.programming.kicks-ass.net>
References: <CA+icZUWSCS6vAQOXoG6nsW+Dbnogivzf+rmegCTMjz5hjE5cKQ@mail.gmail.com>
 <20210313084923.GA16144@zn.tnic>
 <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
 <20210313121541.GC16144@zn.tnic>
 <CA+icZUXrJHHDNOC+DAcr9iw4MXn5cBDj-JrDkxeumk978Gtdcg@mail.gmail.com>
 <20210313124919.GD16144@zn.tnic>
 <CA+icZUWXuknBMdxTQXjJH2JiOgZbWcbk1U=dk6Zp2FgygU5Nyg@mail.gmail.com>
 <20210313132927.GF16144@zn.tnic>
 <CA+icZUWTSo2vkQO_tRggDFvvF_Q6AdzhvhQvmAsNxKnpGXHi0Q@mail.gmail.com>
 <CA+icZUXLyFqq0y_GnKca8MS4wO2kcj4K-D1kBHLa8u_pnLZ7eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXLyFqq0y_GnKca8MS4wO2kcj4K-D1kBHLa8u_pnLZ7eQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 06:04:41PM +0100, Sedat Dilek wrote:

> make V=1 -j4 LLVM=1 LLVM_IAS=1

So for giggles I checked, neither GCC nor LLVM seem to emit prefix NOPs
when building with -march=sandybridge, they always use MOPL.

Furthermore, the kernel explicitly sets: -falign-jumps=1
-falign-loops=1, which, when not specified, default to 16 or so.

This means that your userspace is *littered* with NOPL, even when you
build your entire distro from source with -march=sandybridge.
(arch/gentoo FTW I suppose).

(The only good new is that recent LLVM has a pass to use alternative
instruction encoding in order to grow a basic block in size in order to
minimize the amount of NOP it needs to emit at the end in order to
satisfy the jump/loop alignment.)

So if you *really* deeply care about NOP performance on your SNB, start
by teaching LLVM about prefix NOPs and rebuild your complete userspace.
At that point, you can do some trivial patches to the kernel to make it
use -march=sandybridge and prefix NOPs too.

Until that time, the vast majority of NOPs your CPU will execute will be
NOPL.
