Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F677347AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbhCXOe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhCXOeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:34:10 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F34FC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:34:10 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so22921785otb.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TptIxkMgYJEZZgplyoNi5Dy1Qcvn+0c8XyFseFgq3iw=;
        b=InmNUdu3/mfHxE4kPs1mMoGmMtmlBF95pScGfZvkKYBB4S3K4yfx4Bvkiuvy8JDp1O
         yhjKULxfVeaOitCyy5puKiBfFhQcpsddorwtzs0zHXsbh3CaCRCnVNe/Jx57ksmeAeFH
         R/NgK6kmhSBVYAXMp0P+4K9p5gqbCBWZoVERzpPvZKLB/ABkHihoCM5yINhPBmeqQJlV
         ByYycjQbA3wfBaZTI9nviFO2VKLYF0c+wkJ4QtiOOcAzU3TabwstbXJmsJ8kqM6H4FMn
         mdrwbpGv6PHZeKBGpQXfKm4xTSGSQN+0asGZaMFdTHw1zxSog7uUYmNc/ArbMbOtVBZ+
         eaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TptIxkMgYJEZZgplyoNi5Dy1Qcvn+0c8XyFseFgq3iw=;
        b=W6S1VMSc8CdrTNuFBLvCeJrDVsFxH+0GuNScTP358uC21ziKwCfIfO6OKvQHyMdF94
         ld5j8FjZ1wuBtJKtrjm+e6MazxtaV1LEsfTwQcnV+mPJuDQCYAmBtzqj07971riLISv6
         3SZcbK474nvfEkcEM4pl5jnwk9MgCSpuRrboCMsgWOFSGxINgJmYpgpQabvlvAeY/lGn
         ArzD+T+ju+JtOq82je1omFPRugKr8zagqEpzxirEHt8DK+tskX3Epk6AYzcPyPjnKRTK
         amAe20Nc/ZZO7vOXmWFuuqXtopPoLBOUBfenGpXfcLLmUBDXSr5YBQizyc3rNr1PzkRC
         n2zw==
X-Gm-Message-State: AOAM5310lVbtF8FpfUJZrrB99k7+/Qr8IBAUBhy5fWBxgTbKamz1UC+D
        80EecIn3o28EmQS2/hyj2qQ=
X-Google-Smtp-Source: ABdhPJxj3Sbdb53r3OaQh6xaw42I6+QZifS6ryL6Ww9d6Hq5Tyn4r2qSar7F/Hq+tGRlJsirwVhZrg==
X-Received: by 2002:a9d:788:: with SMTP id 8mr3619852oto.197.1616596449980;
        Wed, 24 Mar 2021 07:34:09 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n10sm311665otj.36.2021.03.24.07.34.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Mar 2021 07:34:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 24 Mar 2021 07:34:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Message-ID: <20210324143407.GA8717@roeck-us.net>
References: <20210210144409.36ecdaed@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210144409.36ecdaed@xhacker.debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 02:44:09PM +0800, Jisheng Zhang wrote:
> Add tracepoints to retrieve information about the invoke_fn. This would
> help to measure how many invoke_fn are triggered and how long it takes
> to complete one invoke_fn call.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

arm64:defconfig:

make-arm64 -j drivers/tee/optee/call.o
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CC      drivers/tee/optee/call.o
In file included from drivers/tee/optee/optee_trace.h:67,
                 from drivers/tee/optee/call.c:18:
./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: No such file or directory
   95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
      |                                          ^
compilation terminated.

Guenter
