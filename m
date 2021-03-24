Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B3D347B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbhCXOtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbhCXOsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:48:55 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EBCC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:48:55 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id i3so21022945oik.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4m05knHllxlYOiUEtm6i0GqxjXvWaxPmnC0qiaQBIXQ=;
        b=uJ9gr03d5506TIpVmEt3G6ZsCUSpHLt17k2p8RUcj/SusTk3MfOwsx9jh1TBefkDJM
         10CljZwWsy4zSs0r4n0PPKJNgM6hhrm+EXs48L+/45/jewLU7xZKLzP8RokfrP2/XlUk
         M3iIUXEr+2MVuyz68gCsy4FDGZjWA1jD1vrXq/5W2CqGksZYGUezxs9lJMXeZPlpEDI3
         wUyB9p7tp/bBPw950Q+bORCbiQvpgYNbI0XF5pwUc8rX7V5zTjU9m6zsZuflRfUp4Xx3
         AhTMnGi7m5p3FDTmgYh/xv4ZFvSvajS+ftT7j3y49Nn/9GhbOJTGhHv1RhlvEc40Tm+q
         a7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4m05knHllxlYOiUEtm6i0GqxjXvWaxPmnC0qiaQBIXQ=;
        b=nNokWZE1M+udMLkiA4/B1lZ6x3LwsmFrAr3HlQftgY1iEhdn1YnmeGjZhXAv11yq8H
         HU75y/3KfA0cK3bOH5zi8vR9bve7QAGmonSKcSELm9SgAgHqVyhE2E5yQ+SlAb6oMDDk
         Qyh/uUFAWecsOIImHXadHxwO+6+qA7JAULTbVD4MdfgYoXXzpGJoSX3A2QnGsD/xdKV9
         ty5VRr35HX1rJPc/qnEN50vWapEQMNV6HD5iG5/dWEKnxDllNLDjJmFeUl3HkMG6pu7E
         r/vlGdqKMykFMC2DVSjdswpv5OtRvz1AGfTJEhixh7ky9bh/c5K52n4omBlouRZNDtc4
         FoWw==
X-Gm-Message-State: AOAM530x8eWaPUW93IMlPD8mqVEOWNIRdjYfWCEsBtcoC2RWxySnhpdf
        lK/6ZGs6HEJic1qBBq03a1M=
X-Google-Smtp-Source: ABdhPJxr/n6snlb7YwJBadHcMkMyG5KAakLbLkJiIQMU7giASwTXd8wXtVLn6Hm1gzn9vJfAK7X4kQ==
X-Received: by 2002:aca:4b4d:: with SMTP id y74mr2710648oia.97.1616597334612;
        Wed, 24 Mar 2021 07:48:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a20sm427842oia.49.2021.03.24.07.48.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Mar 2021 07:48:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 24 Mar 2021 07:48:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Message-ID: <20210324144853.GA5718@roeck-us.net>
References: <20210210144409.36ecdaed@xhacker.debian>
 <20210324143407.GA8717@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324143407.GA8717@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 07:34:07AM -0700, Guenter Roeck wrote:
> On Wed, Feb 10, 2021 at 02:44:09PM +0800, Jisheng Zhang wrote:
> > Add tracepoints to retrieve information about the invoke_fn. This would
> > help to measure how many invoke_fn are triggered and how long it takes
> > to complete one invoke_fn call.
> > 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> 
> arm64:defconfig:
> 
> make-arm64 -j drivers/tee/optee/call.o
>   CALL    scripts/atomic/check-atomics.sh
>   CALL    scripts/checksyscalls.sh
>   CC      drivers/tee/optee/call.o
> In file included from drivers/tee/optee/optee_trace.h:67,
>                  from drivers/tee/optee/call.c:18:
> ./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: No such file or directory
>    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>       |                                          ^
> compilation terminated.
> 

The problem also affects arm:imx_v6_v7_defconfig.

Guenter
