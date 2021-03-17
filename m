Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A75133E864
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 05:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhCQEVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 00:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCQEVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 00:21:09 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4139DC061760
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 21:21:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c204so227618pfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 21:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=tqygHtIF9C1t29D6guUTjM28SV0efTFg8Sgvi9tq11E=;
        b=J0Ymz3qqRL/XDEColeHiskhkUudo7yCDzTrMfSli/8EJ0MyWbKw0dmPrQV15VgoqrN
         z6cmsFBhCAZ1vpXc4gbFeIRLPpmOPNtDesOJwKVKM3JJrPseT+t7CX1mhofT01A/pSW5
         reO1Wd4CHcxUuPrs+fKjk2FvCWrA/Z3oFSdiIkbjAs9QbQ+AXppXNIFTibNw/oWe4ZVo
         7p/l/nfJEvu4yslpm6sj6CRpHfKaLkIZFQBqxcUzsKfOnw7X4gd/vJtaBHuyyvsfBiOB
         0VNSZuQtmJl+RMoQ49XacSpRl46sV46eGn4NFy37zXgBTLTR+q6oI9lOIR96CY734DRK
         Mi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=tqygHtIF9C1t29D6guUTjM28SV0efTFg8Sgvi9tq11E=;
        b=q+Vkdp0G0nvVDUbXZU3Tsf65IxDMyiS9PaQ8mvsySJQZy7ks129HX7kFyMkNReZXZ3
         JoQQfij1yQiomi03LQ7eBY89vmkPqBAG0SUht/h78e7eU/B0hjmjeA7jtR331+H4qC7l
         Qw/WkGh7H8iL4TXRFep/2na9dKsAvA3f/3yHiOU8gU2rGxDKqgOIScUHU1NyRvfeSosR
         kmzgp19znbbKIrhHX+fJdvxcJ4WlqXxDwtYxbJKEOW27DAzXvIxHF3qRIxUOgFeyoYaS
         JaD3Al8vPL+QnRTfpJELh7TN8V/xD+tN2GE4nYzxhlcfvwZP3tZaxtyU8FE/xOB02ZWa
         SD3A==
X-Gm-Message-State: AOAM532vX6+OIt+UYCeXOkmi0voyxSlGGxCJRs90x9EPHPC3u5+7Qlj6
        9jyo13hxL8UzFBqLlzZS8ftH3g==
X-Google-Smtp-Source: ABdhPJyesXfARSvCLvmz8y7QSMQQJ0byeO/pyhC6hJcjwk2HlOZbgELJgKE99SMicIv/QiBfvRGBuA==
X-Received: by 2002:aa7:9ecf:0:b029:1f4:f737:12d6 with SMTP id r15-20020aa79ecf0000b02901f4f73712d6mr2614833pfq.8.1615954868646;
        Tue, 16 Mar 2021 21:21:08 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s22sm835188pjs.42.2021.03.16.21.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 21:21:08 -0700 (PDT)
Date:   Tue, 16 Mar 2021 21:21:08 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Mar 2021 21:19:54 PDT (-0700)
Subject:     Re: [PATCH] ftrace: Fix spelling mistake "disabed" -> "disabled"
In-Reply-To: <20210311094022.5978-1-colin.king@canonical.com>
CC:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, rostedt@goodmis.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     colin.king@canonical.com
Message-ID: <mhng-9cd288c7-8f95-4e86-9b2b-bb405e3f74fe@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 01:40:22 PST (-0800), colin.king@canonical.com wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a comment, fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  arch/csky/kernel/probes/ftrace.c  | 2 +-
>  arch/riscv/kernel/probes/ftrace.c | 2 +-
>  arch/x86/kernel/kprobes/ftrace.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
> index ae2b1c7b3b5c..ef2bb9bd9605 100644
> --- a/arch/csky/kernel/probes/ftrace.c
> +++ b/arch/csky/kernel/probes/ftrace.c
> @@ -9,7 +9,7 @@ int arch_check_ftrace_location(struct kprobe *p)
>  	return 0;
>  }
>
> -/* Ftrace callback handler for kprobes -- called under preepmt disabed */
> +/* Ftrace callback handler for kprobes -- called under preepmt disabled */
>  void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
>  {
> diff --git a/arch/riscv/kernel/probes/ftrace.c b/arch/riscv/kernel/probes/ftrace.c
> index 2dfb33fdac74..17ca5e923bb0 100644
> --- a/arch/riscv/kernel/probes/ftrace.c
> +++ b/arch/riscv/kernel/probes/ftrace.c
> @@ -2,7 +2,7 @@
>
>  #include <linux/kprobes.h>
>
> -/* Ftrace callback handler for kprobes -- called under preepmt disabed */
> +/* Ftrace callback handler for kprobes -- called under preepmt disabled */
>  void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
>  {
> diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
> index 373e5fa3ce1f..51c7f5271aee 100644
> --- a/arch/x86/kernel/kprobes/ftrace.c
> +++ b/arch/x86/kernel/kprobes/ftrace.c
> @@ -12,7 +12,7 @@
>
>  #include "common.h"
>
> -/* Ftrace callback handler for kprobes -- called under preepmt disabed */
> +/* Ftrace callback handler for kprobes -- called under preepmt disabled */
>  void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
>  {

Thanks, this is on fixes.
