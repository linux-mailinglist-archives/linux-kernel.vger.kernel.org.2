Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A81443853F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 22:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhJWUcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 16:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhJWUcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 16:32:23 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC39C061714
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 13:30:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id oa4so5308928pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=u8fb+wH2NugqB0P0dy0KwRekwdYMOc1cKowuVaNB8zU=;
        b=BYzi+ijedWYHIbvvonMnqO6xMeE600lzFCc1izpDmST8aT3E+1hLvZ9JPMLhSHjGLm
         UbrJpn+tPQYlDAj9grHsXlAu1Z+Vbp6rfrW/wVtpJEsvGR3YPi4RJMLIocne1DV0yazD
         FLtKiJGo1dOj6Dy62rH3HiK+ggp3RMeJP8CqXiS+sketcokQ0KPLvkbT3o4G+2x6Dce2
         Tlu2nOXva7mQ6H3YlrFuCwwMh8bTclIT/Dk9KZBBwE2uBZqkGzoksVBd2n69sy5wHnu8
         UtW8VjlIvr+olpt2mBO/fMAyLySuubKrxuZnHYW51pvStOtbbSqGC3kqkfbht11XMpaR
         zxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=u8fb+wH2NugqB0P0dy0KwRekwdYMOc1cKowuVaNB8zU=;
        b=zKjLjMS0QOC0GFcLZfeJ7ckSdRDrcANIUpPO4GdcvP2OU5y4fu4njN5Jkt/6NAfqSh
         OLJRVEf6I231zEzoR97N5qlpBKQn/Z5Kpvr+PE+IJhIPvNwFCPqxFA8O0zMATFbZM2GH
         atR8xatXYhPcN4WpMMnd1Cd29sllb7pJv5cy8HBTZZnE9TM9Z2sIorwdQ/Z5w+i+MY6k
         tipfFbzDEg82ZzXR7xOc0nxD7nLNi6RI660uPPIxJFUtBx6oP+5NBZRKEtAvNvBHvgaw
         L75oano2ZNlFfws6Kz3kSrni6j4Hn8H+3obT1ZuhzT5nUE5bkAkxOalHRX3D50CA+ONu
         y+/w==
X-Gm-Message-State: AOAM530VoUPMcCwaty4kbwurgQHp9PfUl6ZMwaXJcTQLs+bFggdPjFhc
        YfLKUR5R2f0CJdg0HlT4igoj44c2OX5R0A==
X-Google-Smtp-Source: ABdhPJyqTSjW0oaeNA/j9VV5Rk31/sFw4dzBMlR9+7/U0TrUbIhO5h4Hg+7BUC2wxRJ6NBAmLjM2ug==
X-Received: by 2002:a17:902:6b4a:b0:13f:8e99:2149 with SMTP id g10-20020a1709026b4a00b0013f8e992149mr7692407plt.87.1635021003104;
        Sat, 23 Oct 2021 13:30:03 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w11sm12276589pge.48.2021.10.23.13.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 13:30:02 -0700 (PDT)
Date:   Sat, 23 Oct 2021 13:30:02 -0700 (PDT)
X-Google-Original-Date: Sat, 23 Oct 2021 13:29:35 PDT (-0700)
Subject:     Re: [PATCH] riscv: cacheinfo: fix typo of homogenous
In-Reply-To: <20211008205628.3073014-1-georgedanielmangum@gmail.com>
Message-ID: <mhng-51275835-4c34-4099-85f5-13c6dbef4e19@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
CC:     georgedanielmangum@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        peterz@infradead.org, wangkefeng.wang@huawei.com, will@kernel.org,
        tglx@linutronix.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     georgedanielmangum@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Oct 2021 13:56:25 PDT (-0700), georgedanielmangum@gmail.com wrote:
> Updates 'homonogenous' to 'homogenous' in comment.

I don't really know spelling that well, but checkpatch says

    WARNING: 'homogenous' may be misspelled - perhaps 'homogeneous'?

when applying this.  It looks like they're both words, but "homogeneous" 
is the right one?

>
> Signed-off-by: hasheddan <georgedanielmangum@gmail.com>
> ---
>  arch/riscv/kernel/cacheinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 90deabfe63ea..ff98546b1152 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -29,7 +29,7 @@ static struct cacheinfo *get_cacheinfo(u32 level, enum cache_type type)
>  	/*
>  	 * Using raw_smp_processor_id() elides a preemptability check, but this
>  	 * is really indicative of a larger problem: the cacheinfo UABI assumes
> -	 * that cores have a homonogenous view of the cache hierarchy.  That
> +	 * that cores have a homogenous view of the cache hierarchy.  That
>  	 * happens to be the case for the current set of RISC-V systems, but
>  	 * likely won't be true in general.  Since there's no way to provide
>  	 * correct information for these systems via the current UABI we're
