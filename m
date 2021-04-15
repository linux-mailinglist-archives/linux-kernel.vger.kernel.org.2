Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDB6361363
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 22:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhDOUVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 16:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234701AbhDOUVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 16:21:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F39716101C;
        Thu, 15 Apr 2021 20:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618518046;
        bh=sEHTvEBWPeRgAzpSQ47g5PZ7ItNHh1f48TH7cljWUTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UOsmaKNIFQZ+8SgBzCWq3jFMbaUG5iZwPZvvQfjdkan2B+u1euJ5cPnZqYimm0O6P
         3A25lXNexEZZI/Dbg4pOb/itoF4PhEeWkQTxq+CHcwOHv9jT14pPd5u9SdfDePRRJU
         EYgopLcxoV48K1F2Ro//o6+/ZkL1TFmWW9H3cI3nUDxY9rqw2QIlMZC/Ggz3+Q1hFX
         zlCa+f7F5bhTu79KSV33q77yVXS2boVP5h0qbjPefvWzEHx1oP4BO1c/kazEQCxz1x
         NzvmAQ9o4baPRqGVOby5EjhKDc0PoH6sZHkW1VOpvsEdf5wJK3Yh/Cc90oilJXiXtm
         xK/6RWi0DssYQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ED8FF40647; Thu, 15 Apr 2021 17:20:42 -0300 (-03)
Date:   Thu, 15 Apr 2021 17:20:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: Re: [PATCH v8 2/4] libperf: Add evsel mmap support
Message-ID: <YHigGiII9wo33Q+Q@kernel.org>
References: <20210414155412.3697605-1-robh@kernel.org>
 <20210414155412.3697605-2-robh@kernel.org>
 <CAM9d7cibppJUQuqcxEO9gU-KcHJNsoMJQw=1+_Fw3oXXHEKUCA@mail.gmail.com>
 <YHcuIKjNDkOUCupx@kernel.org>
 <YHczIzjv6Kt3cxI7@kernel.org>
 <CAM9d7chYYa5B-QR6xNJG5NeLb0ENv5inLdLMqT_e+8jkRZZCJA@mail.gmail.com>
 <YHiV5vqSD3TmUspL@kernel.org>
 <CAL_JsqKv2rpMrbYu4Dzq9jsmUGiZyJHzi8MOJMqbRnRbzcrc9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKv2rpMrbYu4Dzq9jsmUGiZyJHzi8MOJMqbRnRbzcrc9w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 15, 2021 at 03:09:28PM -0500, Rob Herring escreveu:
> On Thu, Apr 15, 2021 at 2:37 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Ok, b4 failed on it, probably some missing Reply to, so I'll apply it by
> > hand:
> 
> That's my fault. A duplicate message-id is the issue. git-send-email
> died after patch 1/4 (can't say I've ever had that happen). So in my
> attempt to manually resend 2-4, I was off by 1 in the message-id and
> duplicated patch 1's message-id. I should have just resent the whole
> thing.

No problem, it is already in, just letting you know to fix your scripts
:-)

- Arnaldo
