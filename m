Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC7E3A8868
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhFOSVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229983AbhFOSVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:21:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7485F613C2;
        Tue, 15 Jun 2021 18:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623781186;
        bh=zX9gjVzIQE5Qg60Ct1IlcDZSonPE99+/879tzBFpf3Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=khqI4M72AOcjdsYzso3OSIFKdpfKVV6MuuN+ntEtY2MWFzX/PVVYGax/Fz4CBTlOL
         69UMl/niMRKuLHbBu9aqHR/5P/Lpc1FYaNxokCPo6vriTVPo0noVc1Igjl24tNnunH
         wf4yo2VWmfkVKAbrjQfA4Y164M8qpwoRzEPEud8mQiIrAgLSde3pyxDXJ9REB9127a
         DEJwMVfPLCMF1tKZXCOMpWN4blGKiq9O3HRArf9Tlz+wLKxKDYR5mQeVHgfRLcqQK6
         FxRjgrVg24WpX13lPhNEyMRWhU4hZlLd4K68mkrlPDCszlBpj4aHtS7HrKJWGADPCG
         XKr+RATBHnHxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 41BDD5C00F7; Tue, 15 Jun 2021 11:19:46 -0700 (PDT)
Date:   Tue, 15 Jun 2021 11:19:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marco Elver <elver@google.com>, boqun.feng@gmail.com,
        will@kernel.org, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] kcsan: Introduce CONFIG_KCSAN_PERMISSIVE
Message-ID: <20210615181946.GA2727668@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210607125653.1388091-1-elver@google.com>
 <20210609123810.GA37375@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609123810.GA37375@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 01:38:10PM +0100, Mark Rutland wrote:
> Hi Marco,
> 
> On Mon, Jun 07, 2021 at 02:56:46PM +0200, Marco Elver wrote:
> > While investigating a number of data races, we've encountered data-racy
> > accesses on flags variables to be very common. The typical pattern is a
> > reader masking all but one bit, and the writer setting/clearing only 1
> > bit (current->flags being a frequently encountered case; mm/sl[au]b.c
> > disables KCSAN for this reason currently).
> 
> As a heads up, I just sent out the series I promised for
> thread_info::flags, at:
> 
>   https://lore.kernel.org/lkml/20210609122001.18277-1-mark.rutland@arm.com/T/#t
> 
> ... which I think is complementary to this (IIUC it should help with the
> multi-bit cases you mention below), and may help to make the checks more
> stringent in future.
> 
> FWIW, for this series:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Queued and pushed for v5.15, thank you both!

I also queued the following patch making use of CONFIG_KCSAN_STRICT, and I
figured that I should run it past you guys to make check my understanding.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 023f1604e373575be6335f85abf36fd475d78da3
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Jun 15 11:14:19 2021 -0700

    torture: Apply CONFIG_KCSAN_STRICT to kvm.sh --kcsan argument
    
    Currently, the --kcsan argument to kvm.sh applies a laundry list of
    Kconfig options.  Now that KCSAN provides the CONFIG_KCSAN_STRICT Kconfig
    option, this commit reduces the laundry list to this one option.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index b4ac4ee33222..f2bd80391999 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -184,7 +184,7 @@ do
 		TORTURE_KCONFIG_KASAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KASAN=y"; export TORTURE_KCONFIG_KASAN_ARG
 		;;
 	--kcsan)
-		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_INTERRUPT_WATCHER=y CONFIG_KCSAN_VERBOSE=y CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"; export TORTURE_KCONFIG_KCSAN_ARG
+		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_STRICT=y CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"; export TORTURE_KCONFIG_KCSAN_ARG
 		;;
 	--kmake-arg|--kmake-args)
 		checkarg --kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
