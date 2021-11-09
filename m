Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF4F44B494
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 22:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245038AbhKIVYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 16:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239453AbhKIVYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 16:24:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCAEC061764;
        Tue,  9 Nov 2021 13:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WjjHKRQzAPClRG+YAWkb8c4biTijnDdG5vi8nhBZI38=; b=hbvIdNjM1G/p7mGCbtWMFU9nIx
        ewsSWakSjhYXPcdz3Hue0OcATuuvrIbE/bcwyBqvR+BtdziTWzUP49qeA//9p+7lpyat49Sho2T2A
        uBy1IDkPwrJkddMJhSshNlGBDynSJMfI2EAp5gS5ra8SnkCHyN+WtbT3sqt8/zInFuRbbxbtrf9mg
        y9ICYkVcce1yCPqQ2ibFnTPnDeC/WqPpmuRJhqC+qQuGkisASbeAu9V4IevAV1BZo6HE4uWshhUSO
        PEo1GbhP0ed99g8hpceaTu23CKGVLPxg6JWy6uev01VoqzOTb4ExXjWvjHZEC39EuTKEN+pCynb4S
        4qlrdLxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkYYP-00F8gf-Jm; Tue, 09 Nov 2021 21:21:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EA0A985A2A; Tue,  9 Nov 2021 22:21:16 +0100 (CET)
Date:   Tue, 9 Nov 2021 22:21:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz, llvm@lists.linux.dev,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
Message-ID: <20211109212116.GW174703@worktop.programming.kicks-ass.net>
References: <20211105171023.989862879@infradead.org>
 <20211105171821.654356149@infradead.org>
 <20211108164711.mr2cqdcvedin2lvx@treble>
 <YYlshkTmf5zdvf1Q@hirez.programming.kicks-ass.net>
 <CAKwvOdkFZ4PSN0GGmKMmoCrcp7_VVNjau_b0sNRm3MuqVi8yow@mail.gmail.com>
 <YYov8SVHk/ZpFsUn@hirez.programming.kicks-ass.net>
 <CAKwvOdn8yrRopXyfd299=SwZS9TAPfPj4apYgdCnzPb20knhbg@mail.gmail.com>
 <CAGG=3QVecQroYbJ05AGk2f0pe=QOtWuZHyQowzG0i7os8E9fdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QVecQroYbJ05AGk2f0pe=QOtWuZHyQowzG0i7os8E9fdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 12:59:12PM -0800, Bill Wendling wrote:
> 
> Adding attributes to labels shouldn't be difficult, as you mention. In
> the case of cold/hot, it's adjusting some of the metadata that already
> exists on some basic blocks. It might be enough to allow the normal
> block placement algorithms to move the hot and cold blocks around for
> us. The question becomes how many attributes does GCC allow on labels?

I'm aware of 3: unused, hot, cold. Also:

  https://gcc.gnu.org/onlinedocs/gcc/Label-Attributes.html
