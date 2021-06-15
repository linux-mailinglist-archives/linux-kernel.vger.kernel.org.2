Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1E3A8056
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhFONit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhFONin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:38:43 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00F9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 06:36:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so1829490pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2AFaTBkHP+fiyETNPHNRLPn45kJUgrb2oh8W/22IFfs=;
        b=j/Fy6ZBN6qlzdjiBWqbnW+wCteHKu76xMVJEp9DQJuJ4wxVO804Wowa5x5nM926niT
         jzLo7zVMZjyVmFxxBMq5HJbe1b0tLcnoxPh2FvfUikIFgjUxRFfqakrlKjZIbuwEidJb
         FEOOkOuQRbE0HD4gtObijKJoJbFrOOZWXL3f4TlKnl+Pg2nV4zoEhkOr1hilheNPFJDv
         pyUHNRPAeW/aC9eNNPX7SIVkyjiXlPntsnKY22ZFN6V3NC4mwbpMBofU6f/2cUr/HtzF
         ExFo/IINLEzP3geGlzIlztI9H1mRiw0kMhw+IXjV7JF8q0+B76PvCBLCQmFe02PLPBmw
         jPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=2AFaTBkHP+fiyETNPHNRLPn45kJUgrb2oh8W/22IFfs=;
        b=Qw96TO+eN9oYivj4dvP1vL3Y58ipuykBcNgT/L8wjZth1t+AYNwEAuqTVcqeD0QyX9
         +EqCBfwwzmT6Dyow+3L6eXV0O6u4LkXwZQaTh5LloeKCygdS9pMW2LzZ3pUkRXn/l+oV
         /93lobtf6RqJW/eZdWJSZ3R72H+xt6qaINpvmgs37hKnbX06DcnejdJisDocfYafM5tW
         Urh5WZ/ffxOwxDOj5yOMyY11bobg3kw4P6Ht/4VBoexBu2moXkM8jCXtrX9wbed0lnjQ
         UOMf9+QJ66QokwKwqrV3CeW+MROK2jKqTyhjMRQoEbs6YOXKPYW3ZKcCRrJMOaAaiNF6
         UbhA==
X-Gm-Message-State: AOAM531JVkM+gFTXmKxT6S3IfXdxRqlDIuyicqYz7PiNCG12QSMj94eI
        FjKoJ+PPTTj8rBYp3kPE1dMTSFzi/GriJA==
X-Google-Smtp-Source: ABdhPJxp8DDUMiBk+vuKI7BcJTXV0dh80SYDop4A/rYDqRfQjL5KPUAWpbYg9LtSbmGcegKlzw9fmg==
X-Received: by 2002:a17:90a:b795:: with SMTP id m21mr25231412pjr.143.1623764197158;
        Tue, 15 Jun 2021 06:36:37 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id y2sm6668090pfa.195.2021.06.15.06.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 06:36:36 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Move EXPORT_SYMBOL() closer to vprintk definition
References: <20210614235635.887365-1-punitagrawal@gmail.com>
        <8c16059d-6e58-a3e4-25ef-7e2bcabecd86@rasmusvillemoes.dk>
Date:   Tue, 15 Jun 2021 22:36:33 +0900
In-Reply-To: <8c16059d-6e58-a3e4-25ef-7e2bcabecd86@rasmusvillemoes.dk> (Rasmus
        Villemoes's message of "Tue, 15 Jun 2021 08:50:45 +0200")
Message-ID: <87im2ftfku.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

Rasmus Villemoes <linux@rasmusvillemoes.dk> writes:

> On 15/06/2021 01.56, Punit Agrawal wrote:
>> Commit 28e1745b9fa2 ("printk: rename vprintk_func to vprintk") while
>> improving readability by removing vprintk indirection, inadvertently
>> placed the EXPORT_SYMBOL() for the newly renamed function at the end
>> of the file.
>> 
>> For reader sanity, and as is convention move the EXPORT_SYMBOL()
>> declaration just after the end of the function.
>> 
>> Fixes: 28e1745b9fa2 ("printk: rename vprintk_func to vprintk")
>> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
>> --
>> Hi,
>> 
>> The out-of-place EXPORT_SYMBOL() caused an unexpected conflict while
>> attempting to rebase the RT patches onto newer kernels.
>> 
>> Generally I avoid sending trivial changes on their own but this one is
>> a little hard to overlook. Also it felt like an obvious oversight in
>> the original patch.
>
> Yes, indeed, sorry about that, and thanks for fixing it.
>
>> Please consider merging.
>
> Petr, as this is causing trouble for the -rt patchset, please consider
> if this could make it to Linus before v5.13 release.
>
> Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Thanks for the quick response.

Punit
