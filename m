Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F5A3CF7DE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 12:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbhGTJsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 05:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbhGTJqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 05:46:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164DCC061766;
        Tue, 20 Jul 2021 03:25:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626776735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=+xpqngTIUgxv1UEWJ1OWvAaLIjyEHedyk69p/tlpXWY=;
        b=GdW9jiCWyXn2GaLt0HJfYEbCIYVdu7V7oD9mVrRGADzZVXMTmycWMUW5v6UMDl4ZpDpBod
        wZa8gOEubvRk82TN9kRDM2z7LrwH0riZCkSAWDhmGBZVFokj+riRbpqpavamyp5QiykSTC
        12kHshDFjAk55R4qutX9kDF73USi6FIXkku1Y1E4xYlo5xwo1F8reuBThYhGZjzYoNmHo6
        mkOGUyjuCpusN0TExKM0l3f81r1fIKrHaPsiV9CtTA7a7vyfXhzR1kKsBsmoXQe+3xC3BU
        27Gs9MYYC+C0Rn4XGfjbNj3vH3wEqW58PlJjOJ8K+1FgecaKjiQxt/UBBVD6AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626776735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=+xpqngTIUgxv1UEWJ1OWvAaLIjyEHedyk69p/tlpXWY=;
        b=SP1oOJZlIY/+oHNJ5gKu8T7Y0PlZI9lnXdr3kB7YJljktJCKDz4xGeErsjqrflN5fOOadV
        fLops3m+vh94k4Ag==
To:     Like Xu <like.xu.linux@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 0001-perf-x86-amd-Do-not-touch-the-AMD64_EVENTSEL_HOSTONL.patchFrom 9f724a38754d3f99a1b332c11e72e9dd213289d7 Mon Sep 17 00:00:00 2001
In-Reply-To: <38c206c9-ffc2-95f1-8590-5f14b7cdcfcf@gmail.com>
Date:   Tue, 20 Jul 2021 12:25:35 +0200
Message-ID: <87fsw9e0yo.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20 2021 at 11:28, Like Xu wrote:

> The subject should be:
>
> "perf/x86: Do not touch AMD64_EVENTSEL_HOSTONLY bit inside the guest"
>
> Sorry for the noise.

Please resend proper.

Thanks,

        tglx
