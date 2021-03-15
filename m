Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8E433C92D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 23:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhCOWO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 18:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhCOWOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 18:14:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70FCC06174A;
        Mon, 15 Mar 2021 15:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DuxlI88ydMSiE1+oLoIcGn8qRyIJ4Jnj4s61gHhMILY=; b=Jk+GHmMIUlRHmLm0hsIHbinM8Q
        a9UkwHoxDiyXNHBeTB9IaHHPn30jQbCi52v6ao+zUMcaTjCrweJAlRarHgGGWDZWSnPhbDKDlDKHE
        cSQQZg0ELNSWvuyQU1r4+mPqLs43eQd/ZQkQjR3LOea/hYNQ4NUk1q9C5CDJ9sCEh7Y5E2Nobt2N0
        PaMkUitOIjyHVqV1uzVUS3Sx5GaCipw+LbXW2OwpJtqJBfERpBGVCvuSQuf5LythqQ+LZtAXq9mCw
        7TfhUehNejQIQsDVkRBznUrE9DF+ly7lKi3Q5ZDULBy9zDdfeVzkU+xYb9uTyVaaHDEN6SyLPhtxw
        Ao1CUWrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLvTW-000rpW-J1; Mon, 15 Mar 2021 22:14:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96485304D58;
        Mon, 15 Mar 2021 23:14:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 830B62C089444; Mon, 15 Mar 2021 23:14:09 +0100 (CET)
Date:   Mon, 15 Mar 2021 23:14:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
Message-ID: <YE/cMeO+oC/5JEC6@hirez.programming.kicks-ass.net>
References: <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
 <20210313121541.GC16144@zn.tnic>
 <CA+icZUXrJHHDNOC+DAcr9iw4MXn5cBDj-JrDkxeumk978Gtdcg@mail.gmail.com>
 <20210313124919.GD16144@zn.tnic>
 <CA+icZUWXuknBMdxTQXjJH2JiOgZbWcbk1U=dk6Zp2FgygU5Nyg@mail.gmail.com>
 <20210313132927.GF16144@zn.tnic>
 <CA+icZUWTSo2vkQO_tRggDFvvF_Q6AdzhvhQvmAsNxKnpGXHi0Q@mail.gmail.com>
 <CA+icZUXLyFqq0y_GnKca8MS4wO2kcj4K-D1kBHLa8u_pnLZ7eQ@mail.gmail.com>
 <YE+i/VWITCCb37tD@hirez.programming.kicks-ass.net>
 <CA+icZUWQ1kH6muAQbNuVAPj4Cn=8ssDAJfYLKht8ezAgJKWApA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWQ1kH6muAQbNuVAPj4Cn=8ssDAJfYLKht8ezAgJKWApA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 07:23:29PM +0100, Sedat Dilek wrote:

> You mean something like that ^^?
> 
> - Sedat -
> 
> [1] https://git.zx2c4.com/laptop-kernel/commit/?id=116badbe0a18bc36ba90acb8b80cff41f9ab0686

*shudder*, I was more thinking you'd simply add it to you CFLAGS when
building. I don't see any point in having that in Kconfig.
