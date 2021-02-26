Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DAA326542
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBZQHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBZQHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:07:20 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DA7C061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 08:06:37 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gt32so4174678ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 08:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LRtnaW8ESBx8mz0zl8Zlp4mDQWaA0l9/JAzTiZqdgXo=;
        b=TENfYMN3K/60bIA9hdk3HBlrwOStMfGzsOtvoq7XAxQeKlmCq3EZFj6JcjTN9FnvzI
         hbTMXnNvqi3qCjsoE2+VCWPPZs/PCLINjLXoeiUsUXR52XGAMMSsFibwKVtn+MUvD01J
         XmFAVmk+a4Rg4Nq+vuZLgueKB0VqjjEWLrwMtBGtTkj7XGi0Fu4R7qFYb4pNA4MM1+nR
         UgwzubE3myh0lDe00ntrCG2HdWUiq59J6r23xVyEnTEAp2wv7Z7NbuYC0SAlWuJaX618
         xI9/Sy4pn9p1jj+P4gYnrdakH91m156WS2bX3gbO+VC3fOhh1ubvRSlLE/PQ4S5FxQej
         8XqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LRtnaW8ESBx8mz0zl8Zlp4mDQWaA0l9/JAzTiZqdgXo=;
        b=VawCE5ewY84x3JcSZgpu6LE2cPjEPCL7Cb+RSdMqQ6sNJpix8oYtJWPHjNFXoITqad
         72fBxWbv6W9bTuS29he7aSltRq8K5Pm3GGWQwsVDM4GXLEDdfMAwW3Ow7DeNsaVKz4M4
         hHVY1uQk/hI5kLny2R6PNcqqmNdDbq74WgH29iwSdwX0mfQ3/EgHudO8oNG2ayt5RyAz
         Dr4vowYlMhfYDywrQuwXm0iFt0ukhdM0Fad/qcFVCB2N4sgoc7thaSaOKL2ujpWzw2ZX
         TRN/E87XmnWRrO+akmaCStKH8DC2sDq5Hwq54P4ynBu8t3GQMJ3X4KqTbCeVLw7okTMD
         4zOw==
X-Gm-Message-State: AOAM532xpZKnOMyLaZTk9HonM2o2TdQZEULBzhYptWYRPAAwLuS2fUiy
        A9C+snTF4QOJ2RD4tezdqZsHdw==
X-Google-Smtp-Source: ABdhPJzPASwOH1/L5cfRhRSmmbBBOdEh6Z5POERmP8AIhGA/aSqJOugV71tljV1IaKta0nSPjb/jAQ==
X-Received: by 2002:a17:906:d0d2:: with SMTP id bq18mr4127007ejb.109.1614355596393;
        Fri, 26 Feb 2021 08:06:36 -0800 (PST)
Received: from google.com ([2a00:79e0:2:11:d0b1:99e6:bf05:21bb])
        by smtp.gmail.com with ESMTPSA id ap14sm5666473ejc.13.2021.02.26.08.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 08:06:35 -0800 (PST)
Date:   Fri, 26 Feb 2021 17:06:29 +0100
From:   Piotr Figiel <figiel@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Florian Weimer <fweimer@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>, emmir <emmir@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
Message-ID: <YDkchUnCe5ctDwYB@google.com>
References: <20210226135156.1081606-1-figiel@google.com>
 <192824546.8190.1614353555831.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <192824546.8190.1614353555831.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 26, 2021 at 10:32:35AM -0500, Mathieu Desnoyers wrote:
> > +static long ptrace_get_rseq_configuration(struct task_struct *task,
> > +					  unsigned long size, void __user *data)
> > +{
> > +	struct ptrace_rseq_configuration conf = {
> > +		.rseq_abi_pointer = (u64)(uintptr_t)task->rseq,
> > +		.rseq_abi_size = sizeof(*task->rseq),
> > +		.signature = task->rseq_sig,
> > +		.flags = 0,
> > +	};
> > +
> > +	size = min_t(unsigned long, size, sizeof(conf));
> > +	if (copy_to_user(data, &conf, size))
> > +		return -EFAULT;
> > +	return sizeof(conf);
> > +}
> 
> I think what Florian was after would be:
> 
> struct ptrace_rseq_configuration {
> 	__u32 size;  /* size of struct ptrace_rseq_configuration */
> 	__u32 flags;
> 	__u64 rseq_abi_pointer;
> 	__u32 signature;
> 	__u32 pad;
> };
> 
> where:
> 
>     .size = sizeof(struct ptrace_rseq_configuration),
> 
> This way, the configuration structure can be expanded in the future. The
> rseq ABI structure is by definition fixed-size, so there is no point in
> having its size here.

Still rseq syscall accepts the rseq ABI structure size as a paremeter.
I think this way the information returned from ptrace is consistent with
the userspace view of the rseq state and allows expansion in case the
ABI structure would have to be extended (in spite of it's current
definition).

The configuration structure still can be expanded as its size is
reported to userspace as return value from the request (in line with
Dmitry's comments).

Best regards, Piotr.
