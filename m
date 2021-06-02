Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579BF3992A7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhFBShv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhFBShu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:37:50 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B037AC061574;
        Wed,  2 Jun 2021 11:36:06 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2E2B32E0;
        Wed,  2 Jun 2021 18:36:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2E2B32E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622658966; bh=W/vpT+iI0rchh3VZVeVOnpqOaOwv9O6V0VgVswk0/g0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LSXthPXOmpX/n+ndSxtzyxlCGepQIfoPYYqCN1C+RnIZt9Be1Qb2OL9krezxYXjsW
         6dW0I7ch/FgEoTtrc5jUk6D50PDU8TTYUujLQfTL5p5K24yFUIsC0IrO4FO1IWfOtg
         lZI2L5uk8LkeJilGm73QhKex16dLbZ4dc9EgdjS5bSuvNcizOTuZP6nw5CHgrEiGcO
         QbKTO9zCTsOyeW5MgqFzVqwCEhLlUvlxGvr4p8PHKIfFOYOG3vtpkfrlsaFCas4pnM
         J8EsT0qJ8qsbOEcbvDlNFwTDq3uBjxcyTu9hM8CGqdir2iBAkdRjrbwzw47Eklsge4
         s736sGtw3nVRg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Lepton Wu <ytht.net@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Kitt <steve@sk2.org>, Wang Qing <wangqing@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] docs: accounting: update delay-accounting.rst
 reference
In-Reply-To: <20210602200121.64a828a1@coco.lan>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
 <629b0bd21d02c8faef9a6d17d9eee8ff612715e0.1622648507.git.mchehab+huawei@kernel.org>
 <YLe0BQcrnfRgH1dV@hirez.programming.kicks-ass.net>
 <20210602200121.64a828a1@coco.lan>
Date:   Wed, 02 Jun 2021 12:36:05 -0600
Message-ID: <871r9k6rmy.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> That's said, automarkup.py has a rule to convert Documentation/<foo>.rst
> into :doc:`<foo>`. So, an alternative approach would be to convert
> treewide all :doc:`<foo>` into Documentation/<foo>.rst and add something 
> at checkpatch.pl to recommend to avoid :doc: notation.

That seems like the right approach to me.  We have the automarkup
capability, we might as well make use of it...

Thanks,

jon
