Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830D13C7380
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbhGMPtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbhGMPtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:49:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2C2C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:46:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id me13-20020a17090b17cdb0290173bac8b9c9so1687229pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=88HXaPtHKzXvJfwVkmoFRhzh8ULUchVJgvCgSXMZAEA=;
        b=IMSe346IusRmrX3pn5fJMJ9Kjb0J8qJPIB5Fw4mHBShvol+ZM0iW6AswXxYKFgThp2
         NiUrVqwOW22Ibl7Uo8Irfjyetq41nt5wNmRgY6CbxpMB3wzP3d57Y8uJaIAHG9Mc05Sq
         8YDwgsFnmHQjD4rkzAXRsHb132CuLelWS3qujGuiYxCoW+O4A4bKq8VA85gemw0mEy0r
         +RODPf++g0m9822Bw3VJ/64YIRmde2Bsm0zZ5ECgd1b+z05p2Ky/cL+vMPd30KuLxxcg
         gGlHCVWO8yyLSnXlVB98vCQej203Ql1lhPhZNS+6Mq0cgS10cfsf/lcJJqfvsfEoOzIc
         KNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=88HXaPtHKzXvJfwVkmoFRhzh8ULUchVJgvCgSXMZAEA=;
        b=DIlZ5oRyHF88AlhI6xQA8w3orPzuhY4btCSK41WQu945CEFBR9EfVHk74SeIDlWxvw
         VoXVrpGHYNWg90V2nlPWPdbYCYbKeOVr++0X8w6Cfwbrn/dQsUgDhs1isynXptnlpBQT
         br0zrTvEeCfewocPZd6CUD+k6r/oFsqrkx20WjiaRsfm0Sk5hW5Yhw4ddYVKYhnQDA4v
         ieOFe+ddw6O5TyRjeQIFP8f17vlzHM+mdrMFINHigP+VSdeaQuAkYGr/tI7OQScfGjir
         8lKsuj0dXNhYsJpMDwd6TOYc75iN27KMLqIHcLfN0F+6AgKWuKEYn/rgneDIhW8BsunO
         COLA==
X-Gm-Message-State: AOAM532sob8lTi5x0xoDUz/R6nmWzBvRKcczDQ8cYwI8UC81/rDVow4M
        O+sgjt8ZjXi9X/tPahNXoaqFDw==
X-Google-Smtp-Source: ABdhPJza4OuJ5oLLl2sYrZSHnrhml4tdTkspyGV08RSdzPXDKi8rSdcWd4cuhMJeAVtMgMXK28WI4g==
X-Received: by 2002:a17:902:ed95:b029:ee:aa46:547a with SMTP id e21-20020a170902ed95b02900eeaa46547amr4011323plj.27.1626191169630;
        Tue, 13 Jul 2021 08:46:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id i1sm3257836pjs.31.2021.07.13.08.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 08:46:08 -0700 (PDT)
Date:   Tue, 13 Jul 2021 23:46:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 11/11] perf auxtrace: Add
 compat_auxtrace_mmap__{read_head|write_tail}
Message-ID: <20210713154602.GD748506@leoy-ThinkPad-X240s>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-12-leo.yan@linaro.org>
 <20210712144410.GE22278@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712144410.GE22278@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Mon, Jul 12, 2021 at 03:44:11PM +0100, Russell King (Oracle) wrote:
> On Sun, Jul 11, 2021 at 06:41:05PM +0800, Leo Yan wrote:
> > When perf runs in compat mode (kernel in 64-bit mode and the perf is in
> > 32-bit mode), the 64-bit value atomicity in the user space cannot be
> > assured, E.g. on some architectures, the 64-bit value accessing is split
> > into two instructions, one is for the low 32-bit word accessing and
> > another is for the high 32-bit word.
> 
> Does this apply to 32-bit ARM code on aarch64? I would not have thought
> it would, as the structure member is a __u64 and
> compat_auxtrace_mmap__read_head() doesn't seem to be marking anything
> as packed, so the compiler _should_ be able to use a LDRD instruction
> to load the value.

I think essentially your question is relevant to the memory model.
For 32-bit Arm application on aarch64, in the Armv8 architecture
reference manual ARM DDI 0487F.c, chapter "E2.2.1
Requirements for single-copy atomicity" describes:

"LDM, LDC, LDRD, STM, STC, STRD, PUSH, POP, RFE, SRS, VLDM, VLDR, VSTM,
and VSTR instructions are executed as a sequence of word-aligned word
accesses. Each 32-bit word access is guaranteed to be single-copy
atomic. The architecture does not require subsequences of two or more
word accesses from the sequence to be single-copy atomic."

So I think LDRD/STRD instruction cannot promise the atomicity for
loading or storing two words in 32-bit Arm.

And another thought is the functions compat_auxtrace_mmap__read_head()
is a general function, I avoid to write it with any architecture
specific instructions.

> Is this a problem noticed on non-ARM architectures?

No, actually we just concluded the potential issue based on the analysis
for the weak memory model.

Thanks,
Leo
