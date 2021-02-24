Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EEB32385E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhBXIMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbhBXILj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:11:39 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2B2C061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:10:58 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id u4so1381773ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iaNQ0/x4wJABaIxpOlTlMzY4E0tMtNEPzTAE22Eqw1c=;
        b=RIrvGMvDbAEOIa9mCIYpti7ebILOp4DFAIBw8a7xY0r2+jv2Nim+K2cH9KtYBOa6bz
         0gyHVWEyffWKl5HgNzFzEpzX518d3ZEU+J21zi7tFcJPUG8DeK9rH0NoSKYX320r1gHC
         jJnSyJ2l7J+zdQWTGzGYtRzFLMT1ClFdzMTp3+odi8eSTweXJX/vKHoBuwmqdvZeiLF7
         KTUAMx3XksO9XCnB7P6N9cUEYOeS59DKD2StqaCdmotcspuhL7KqU6o2a8ra8L8qxBOn
         NKgS7n0e7EorYloxyd1rtvsvaiJnTR5+gYGS/1jK0H3dqSvQsUdoF0KWMNW2sQhlLUMS
         SpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iaNQ0/x4wJABaIxpOlTlMzY4E0tMtNEPzTAE22Eqw1c=;
        b=RonaNyZkLrpZQs558Z5YXOz+voZT53feqtKt8VyAeartFPnVi45VR5ThaD80PG+jMY
         Z2cPvCmoE9qABKDD9z61oGbD1410D2D21J/Dr5a9vbO1ieOajWqqlL/t8K49wgIbc3zk
         QflF3O7twkI1m9rj9uUQEoMB8GwhQ6IrEm6LUHo11wq6bbrbLtq/qOVUCtW/qQNhIvdy
         4VLN1R6RqyB2YDKpCmX/W2iYaCsVzk3oyhpoiMTsXRpJ5NtWTctrUuGZ6DqNhyvtgYi8
         Ig+rCdZLNWmz+Equk1DKS2NYrTiF6vg3UZ9L/P1cmTx/7fLVyZWA9ORXcHSiU5Z5ZcdC
         SCYg==
X-Gm-Message-State: AOAM530WfLvPVDYfRKfdK8dspFiSiS1c/4fFlhqVCqOEr4nYAjc76rJs
        zZ5G4lV923UO458rCutXmRqErQ==
X-Google-Smtp-Source: ABdhPJxe41qfIAQ3R0LAzRwzVqwdgecZz2yhwQIK1ccJyvmIyUo934mlNbW08qNB94n5jqhlFgnLWw==
X-Received: by 2002:a2e:5412:: with SMTP id i18mr9138650ljb.186.1614154257274;
        Wed, 24 Feb 2021 00:10:57 -0800 (PST)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id r28sm276804ljd.107.2021.02.24.00.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 00:10:56 -0800 (PST)
Date:   Wed, 24 Feb 2021 09:10:54 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Message-ID: <20210224081054.GA2653493@jade>
References: <20210210144409.36ecdaed@xhacker.debian>
 <CAHUa44E-_czjhRxr2JjggYu0sDCsRvOA3Uc=hqp7j5Cmtb9q0w@mail.gmail.com>
 <20210223184026.22c86356@xhacker.debian>
 <20210223131124.GA2303918@jade>
 <20210223091936.5b390f35@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210223091936.5b390f35@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 09:19:36AM -0500, Steven Rostedt wrote:
> On Tue, 23 Feb 2021 14:11:24 +0100
> Jens Wiklander <jens.wiklander@linaro.org> wrote:
> 
> > I used the -strict option.
> > 
> > ./scripts/checkpatch.pl -strict 0001-tee-optee-add-invoke_fn-tracepoints.patch
> > WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> > #44: 
> > new file mode 100644
> 
> The above is just asking for someone to take maintainership of the new file.
> 
> > 
> > CHECK: Alignment should match open parenthesis
> > #68: FILE: drivers/tee/optee/optee_trace.h:20:
> > +TRACE_EVENT(optee_invoke_fn_begin,
> > +	TP_PROTO(struct optee_rpc_param *param),
> > 
> > CHECK: Lines should not end with a '('
> > #71: FILE: drivers/tee/optee/optee_trace.h:23:
> > +	TP_STRUCT__entry(
> > 
> > CHECK: Lines should not end with a '('
> > #76: FILE: drivers/tee/optee/optee_trace.h:28:
> > +	TP_fast_assign(
> > 
> > CHECK: Alignment should match open parenthesis
> > #89: FILE: drivers/tee/optee/optee_trace.h:41:
> > +TRACE_EVENT(optee_invoke_fn_end,
> > +	TP_PROTO(struct optee_rpc_param *param, struct arm_smccc_res *res),
> > 
> > CHECK: Lines should not end with a '('
> > #92: FILE: drivers/tee/optee/optee_trace.h:44:
> > +	TP_STRUCT__entry(
> > 
> > CHECK: Lines should not end with a '('
> > #97: FILE: drivers/tee/optee/optee_trace.h:49:
> > +	TP_fast_assign(
> 
> The TRACE_EVENT() macro is "special", and checkpatch notoriously stumbles
> over it. I usually recommend that people ignore the checkpatch warnings on
> TRACE_EVENT() macros.

Makes sense. I'll pick this up as it is.

Thanks,
Jens
