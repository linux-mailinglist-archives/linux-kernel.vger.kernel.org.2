Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04032391633
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 13:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhEZLeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 07:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbhEZLeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 07:34:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CE3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 04:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t3wfYQo8ds7blzgeJlDFz97NdAygc2YIvJa9fG56uds=; b=HW1MpYnblh1qShE9d22boELrld
        mDI4jp3DX2tdlAMJitUFU1CayMdtCqNcECzyJkUPuVs3ZFBZ9unhxs1Ef2H89F+5HqnFpOxpf4e3n
        Fguaajj86ex/P6razwbS1qfQZrss6mwDjQ3LAOPAw4MGFlC3KlRTjEGn/iTqxaYzg/kHbzFOY25oi
        Iz2SpdA6m9/LMt2ZzXXQ2DtUOwnxSjwZbKNvqhvq/OqCSPTxCQEfYRwnDD4VPyVW/riR3Y1X0VVPU
        Z4YNGNoQ4eJGvHA32lexFGfAzamdL5PgquBe3TfnDrMi78JdHzVW/Su0oFsKPf/Sp6eIpCqmmb6x+
        ywXTViaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llrjw-004Sz8-8g; Wed, 26 May 2021 11:30:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B497A30022C;
        Wed, 26 May 2021 13:30:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88046201FF89F; Wed, 26 May 2021 13:30:11 +0200 (CEST)
Date:   Wed, 26 May 2021 13:30:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        boqun.feng@gmail.com, aou@eecs.berkeley.edu, arnd@arndb.de,
        bcain@codeaurora.org, benh@kernel.crashing.org, chris@zankel.net,
        dalias@libc.org, davem@davemloft.net, deanbo422@gmail.com,
        deller@gmx.de, geert@linux-m68k.org, gerg@linux-m68k.org,
        green.hu@gmail.com, guoren@kernel.org, ink@jurassic.park.msu.ru,
        James.Bottomley@hansenpartnership.com, jcmvbkbc@gmail.com,
        jonas@southpole.se, ley.foon.tan@intel.com, linux@armlinux.org.uk,
        mattst88@gmail.com, monstr@monstr.eu, mpe@ellerman.id.au,
        nickhu@andestech.com, palmerdabbelt@google.com, paulus@samba.org,
        paul.walmsley@sifive.com, rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tsbogend@alpha.franken.de,
        vgupta@synopsys.com, ysato@users.sourceforge.jp, junio@pobox.com
Subject: Re: [PATCH v2 00/33] locking/atomic: convert all architectures to
 ARCH_ATOMIC
Message-ID: <YK4xQ/BtB4rItRr1@hirez.programming.kicks-ass.net>
References: <20210525140232.53872-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525140232.53872-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 03:01:59PM +0100, Mark Rutland wrote:
> This series (based on v5.13-rc2) converts all architectures to
> ARCH_ATOMIC. This will allow the use of instrumented atomics on all
> architectures (e.g. for KASAN and similar), and simplifies the core
> atomic code (which should allow for easier rework of the fallbacks and
> other bits in future).
> 
> I'm hoping that we can queue this via the tip tree for v5.14.
> 
> I've build-tested this with the kernel.org crosstool GCC 10.3.0 binaries
> (all arches except hexagon), and I haven't seen issues with the configs
> I tried, so I'm fairly confident this is solid now. I'd like to get this
> into linux-next ASAP to flush out any remaining issues.
> 
> The series is split into three parts:
> 
> 1) Some preparatory work is done to prepare architectures and common
>    code for the conversion. In this phase h8300 and microblaze are
>    converted to use the asm-generic atomics exclusively, and the
>    asm-generic implementations are made to function with or without
>    ARCH_ATOMIC.
> 
> 2) Architectures are converted one-by-one to use the ARCH_ATOMIC
>    interface. I've converted each architecture with its own patch (even
>    where the conversion is trivial) to make review and bisection easier.
> 
> 3) The code handling !ARCH_ATOMIC is removed.
> 
> Note: I've generated the patches with:
> 
>   git format-patch -C -M -D
> 
> ... so the preimage of include/linux/atomic-fallback.h is not included
> in the diff when it is deleted.

So because I need the Link tag and things, I had to use b4 (or my own
scripts) and git-am, but that's incapable of digesting these patches.

I strongly feel that git-apply must be able to accept anything
git-format-patch generates, so I fixed it, see below.

With that; I could do:

  $ b4 am -slo - 20210525140232.53872-1-mark.rutland@arm.com | git am -D


Junio; can we get something like the below sorted?

---
diff --git a/apply.c b/apply.c
index 853d3ed385a6..20c3c8c5eddd 100644
--- a/apply.c
+++ b/apply.c
@@ -3650,7 +3650,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 	add_to_fn_table(state, patch);
 	free(image.line_allocated);
 
-	if (0 < patch->is_delete && patch->resultsize)
+	if (0 < patch->is_delete && patch->resultsize && !state->force_delete)
 		return error(_("removal patch leaves file contents"));
 
 	return 0;
@@ -5059,6 +5059,7 @@ int apply_parse_options(int argc, const char **argv,
 		OPT_CALLBACK(0, "directory", state, N_("root"),
 			N_("prepend <root> to all filenames"),
 			apply_option_parse_directory),
+		OPT_BOOL('D', "irreversible-delete", &state->force_delete, N_("DWIW")),
 		OPT_END()
 	};
 
diff --git a/apply.h b/apply.h
index da3d95fa5098..73819110387b 100644
--- a/apply.h
+++ b/apply.h
@@ -66,6 +66,7 @@ struct apply_state {
 	int threeway;
 	int unidiff_zero;
 	int unsafe_paths;
+	int force_delete;
 
 	/* Other non boolean parameters */
 	struct repository *repo;
diff --git a/builtin/am.c b/builtin/am.c
index 0b2d886c81b7..4776a42d5312 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2323,6 +2323,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_PASSTHRU_ARGV(0, "reject", &state.git_apply_opts, NULL,
 			N_("pass it through git-apply"),
 			PARSE_OPT_NOARG),
+		OPT_PASSTHRU_ARGV('D', "irreversible-delete", &state.git_apply_opts, NULL,
+			N_("pass it through git-apply"),
+			PARSE_OPT_NOARG),
 		OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
 			N_("override error message when patch failure occurs")),
 		OPT_CMDMODE(0, "continue", &resume.mode,
