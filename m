Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07903436FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhJVCME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhJVCMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:12:03 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9524C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:09:46 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q187so1980592pgq.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PFGsuLal6rnfa1SPhGOuGktWo/AG5wMXOXb/yT4fb9o=;
        b=tEBX+PRGGc6vjjpkMGy1jlMeTMjq6o5Dnqsz6EqPIO9DMIXMVpLprp+zPrPJ81G5hV
         nC0sHedgEsp/LPx0m7v0fDpMcaTscRGlSbJYkTNGW8A9E/xsWkXekFe36ymRp1/lv39F
         99FKi+LAMyRACejGd0ZtKdoMmGmPql8WN9a1TpQABI94UlWEdwCJxD/8mfVTiRDVgqpJ
         X1DQoB90YIwejvLWIDzvm4KNduzWm1uDKEaeRqn/3LZPqIukjirxgyiVDYzhWlyBhJNp
         6U0wcDJzfyk+8OAdRTU3zy5UYPT+KtZBnzCsOLiC+yMiOcXdx7YNDGVujbK7Eodzngwt
         EYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PFGsuLal6rnfa1SPhGOuGktWo/AG5wMXOXb/yT4fb9o=;
        b=lQRa3xLAciC9lBcQT3loDle/Jzib/dHnQ1oCLJYB08U66bydDarggViyeRTvvF94DT
         9kzdF4LUJEr9LHDWN8hitptrU7v5cOnaFPlIWXo/vkjeM4PVJr/ho0yvgzgCkJX/etUa
         hEfFz70ks8zRgPHvV3/mXOj4n6xTRDecpNv/wtKxaD5S9Qe3jh/M++YeQ7lVEJsslfZu
         WfaVA3LTl7sfXRZM0yCB+GmP3LBJxydjjhww4b0NIazGsRnP95wlFQRwgRhw0y2Upe7A
         sY7j5lDYyuuwzKlfHeXKCKO79otQvTMf1yskz7lqhKZj5gt1IOYF0/EW5kM31NGqEzTt
         jByQ==
X-Gm-Message-State: AOAM532zYq3TX4KowmmLZGPa5e/6homoMkCSgZ6hmYo22taMa323iVYm
        l2S83B4A6G1ZT2ScZQ3UYGRIjA==
X-Google-Smtp-Source: ABdhPJzsH227lOfiJON1+9Zk0eX5p4y2hobelEjoZ1Xqu/4ZVmubEPuI3aYcjAvyYwQijiKC76dQuQ==
X-Received: by 2002:a05:6a00:1488:b0:44d:25b2:f80b with SMTP id v8-20020a056a00148800b0044d25b2f80bmr9698788pfu.20.1634868586039;
        Thu, 21 Oct 2021 19:09:46 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id oo9sm7919695pjb.53.2021.10.21.19.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 19:09:45 -0700 (PDT)
Date:   Fri, 22 Oct 2021 10:09:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv1 4/4] perf: arm_spe: Dynamically switch PID tracing to
 contextidr
Message-ID: <20211022020935.GB213960@leoy-ThinkPad-X240s>
References: <20211021134530.206216-1-leo.yan@linaro.org>
 <20211021134530.206216-5-leo.yan@linaro.org>
 <202110210848.35971643C6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110210848.35971643C6@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Thu, Oct 21, 2021 at 08:49:46AM -0700, Kees Cook wrote:
> On Thu, Oct 21, 2021 at 09:45:30PM +0800, Leo Yan wrote:
> > Now Arm64 provides API for enabling and disable PID tracing, Arm SPE
> > driver invokes these functions to dynamically enable it during
> > profiling when the program runs in root PID name space, and disable PID
> > tracing when the perf event is stopped.
> > 
> > Device drivers should not depend on CONFIG_PID_IN_CONTEXTIDR for PID
> > tracing, so this patch uses the consistent condition for setting bit
> > EL1_CX for PMSCR.
> 
> My own preference here would be to not bother with the new
> enable/disable helpers, but just open code it right here. (Save a patch
> and is the only user.) But I defer to the taste of arm64 maintainers. :)

Yes, with your reminding I recognize that we can avoid the new helpers.
Just remind, tracing PID in contextidr is not only used by Arm SPE
driver, it will be used in Arm CoreSight driver as well.  I plan to use
a separate patch set to address Arm CoreSight (CoreSight driver misses
to checking root PID namespace so need firstly fix that issue).

Just give more info, so you and arm64 maintainers could judge we
should use helpers or directly access static key.

Thanks for your review!

Leo
