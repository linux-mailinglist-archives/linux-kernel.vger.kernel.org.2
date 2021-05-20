Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741FC389D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 07:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhETFa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 01:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhETFa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 01:30:58 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82468C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 22:29:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b13-20020a17090a8c8db029015cd97baea9so4706678pjo.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 22:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=03CafkfXLEnTUzsbYB0mlqsT3bt8omYZAMedXzm00hs=;
        b=fWWCb/vvC9x/i/5U+eqRoBgdk4TMvsd99mMS+l1F2K0d4Ee+XfPdfqaB3NMLpU1wCW
         ECPt6enxTJ6f0V3wbsEpGKI5T8jJVy00NX5o9ILbDvicm0wCnUpY119og7ygNKuEQYky
         DBOtJIzQxA9UQbvXXzScutGxRY4j6ndVlAcxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=03CafkfXLEnTUzsbYB0mlqsT3bt8omYZAMedXzm00hs=;
        b=r85gr2hBFxtN27rrKuajsdsezjbht2LlDrPVxtj+j+4nwBllJEHdhGUp4I6JxSheVl
         9YnCIILlYsN9S3Ab1WQ4ql0xawo/VWyqpv7juRIxXNxmk0kgsQr02jW8i45l6x36AZCW
         5hXngurCtuoxSvcZFP1WZBcWftU9/zQcSp1SlMRXGtdij2c1QPsYAs6t/Ew6gteJtCEx
         TtDrCXvKIOdsLjA1X6fqeL7xGIbatEj486EEOK2bQalNF5BapT1Th+jhLtmNFHvx8lcH
         hkxMyx4vk41unWZ0rfMzkWHx8DvnhPd1qg/SaBHOB7RfIfcaovVhEcALev4mF24JT/Vr
         0qzw==
X-Gm-Message-State: AOAM530nivtCdPl+Yis3EwnZA6snWNk+jBx2hnaiKRfc7gEUxbpS3d+U
        +laOqeE4gR1thU2BP09buzrI2g==
X-Google-Smtp-Source: ABdhPJwqZtRUU0nsIsV0zek7NdysBejQDUTfhKjFgiDG1EKjsMY2/ZhgfYZ2KoBPAVEDH9VcXMamHw==
X-Received: by 2002:a17:90a:bd8a:: with SMTP id z10mr3233667pjr.203.1621488576054;
        Wed, 19 May 2021 22:29:36 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:48db:abf:343e:b4f7])
        by smtp.gmail.com with ESMTPSA id t14sm828344pfg.168.2021.05.19.22.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 22:29:35 -0700 (PDT)
Date:   Thu, 20 May 2021 14:29:31 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: Reliable handling of timestamps
Message-ID: <YKXzuy336Fmrcz1s@google.com>
References: <20210517140612.222750-1-senozhatsky@chromium.org>
 <YKPfDQoN5hToB9nk@alley>
 <YKT55gw+RZfyoFf7@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKT55gw+RZfyoFf7@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/19 13:43), Petr Mladek wrote:
> 
> The commit 9bf3bc949f8aeefeacea4b ("watchdog: cleanup handling of false
> positives") tried to handle a virtual host stopped by the host a more
> straightforward and cleaner way.
> 
> But it introduced a risk of false softlockup reports. The virtual host
> might be stopped at any time, for example between
> kvm_check_and_clear_guest_paused() and is_softlockup().
> As a result, is_softlockup() might read the updated jiffies
> are detects softlockup.
> 
> A solution might be to put back kvm_check_and_clear_guest_paused()
> after is_softlockup() and detect it. But it would put back
> the cycle that complicates the logic.
> 
> In fact, the handling of all the timestamps is not reliable.
> The code does not guarantee when and how many times the timestamps
> are read. For example, "period_ts" might be touched anytime also
> from NMI and re-read in is_softlockup(). It works just by chance.
> 
> Fix all the problems by making the code even more explicit.
> 
> 1. Make sure that "now" and "period_ts" timestamps are read only
>    once. They might be changed at anytime by NMI or when the virtual
>    guest is stopped by the host. Note that "now" timestamp does
>    this implicitly because "jiffies" is marked volatile.
> 
> 2. "now" time must be read first. The state of "period_ts" will decide
>    whether it will be used or the period will get restarted.
> 
> 3. kvm_check_and_clear_guest_paused() must be called before reading
>    "period_ts". It touches the variable when the guest was
>    stopped.
> 
> As a result, "now" timestamp is used only when the watchdog was
> not touched and the guest not stopped in the meantime. "period_ts"
> is restarted in all other situations.
> 
> Fixes: 9bf3bc949f8aeefeacea4b ("watchdog: cleanup handling of false positives")
> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
