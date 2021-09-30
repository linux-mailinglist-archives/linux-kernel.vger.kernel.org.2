Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9116241E060
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 19:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352879AbhI3RzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 13:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352811AbhI3RzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 13:55:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED10C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:53:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n2so4573334plk.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J6VIPDiBHcPnVlaHOu28w6KMKmQgitpe9uIbK84dAaQ=;
        b=PDptof/eTySr76xQi6B/6Uyh3LTGJReNLguHgH+tmgMGtzvk8KnfDqrrtJcxjHSMwr
         QJ6Bg2VuVk70d3B/C6IL2mp4K9YRHci8VLvlzJeSko+B5vwYBpLWs9e0TX5qHbFc36kr
         K9+EUxdJtfkxJyuPbaAwjCod5bYZiEBVs4oBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J6VIPDiBHcPnVlaHOu28w6KMKmQgitpe9uIbK84dAaQ=;
        b=SajQX/3FfA4zni0Y/7kcGFSffdLLpOYM0Yzq8Loxbdof97pFybEmGuy5dQxvZfixPc
         yWmYFClrUEM8Mud6OmI+r3KuTCeRd2DYGYM0LGCcNqPZa0OJvyFzB1jliyf3hkTtQ/ws
         8ZYbZRlO/ide/Sz/PVDaBZ0D5HusPMlXiYGPGuVGeYDHmCICYzSR/IzUBRXv7B8vdEMr
         erxEkqlsC95TubPkd/OIwQUsxzo3FXjz6MAcvn1+waG53bQEmtlYjN2NSdiIMZ394F4F
         V+0f2Hahpt56NDOUv7dEbB/iX0gVJUFHrg/Now+kuX3mWJ3oSM/aqbV6EIiom2B9WToq
         Xjfg==
X-Gm-Message-State: AOAM533dIWLddHUHVZEFxrZ8pw405GiVndiZpuzWTwE/83wav3yOT4WK
        qljsM39kGYZk7ud+6pIiSs355g==
X-Google-Smtp-Source: ABdhPJwZdhveQPGbtdaFQHFIyqhRm+zaWg1TcdnLx+j93ohHMtpl/eCyuMVRVTSPcrq/nvakaNAUlw==
X-Received: by 2002:a17:90a:ead1:: with SMTP id ev17mr14731713pjb.158.1633024417242;
        Thu, 30 Sep 2021 10:53:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a7sm2982557pfn.150.2021.09.30.10.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 10:53:36 -0700 (PDT)
Date:   Thu, 30 Sep 2021 10:53:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     jeyu@kernel.org, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: Re: [PATCH v5] kallsyms: new /proc/kallmodsyms with builtin modules
Message-ID: <202109301051.DDD8B5F27@keescook>
References: <20210929215154.300692-1-nick.alcock@oracle.com>
 <202109291629.81106C83D@keescook>
 <875yui0ymc.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yui0ymc.fsf@esperi.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 06:19:55PM +0100, Nick Alcock wrote:
> On 30 Sep 2021, Kees Cook said:
> > On Wed, Sep 29, 2021 at 10:51:47PM +0100, Nick Alcock wrote:
> >> It would be useful if there were a mapping between kernel symbol and module
> >> name that only changed when the kernel source code is changed.  This mapping
> >> should not change simply because a module becomes built into the kernel.
> >> 
> >> It might also be useful if there were reliable symbol size information to
> >> determine whether an address is within a symbol or outside it, especially
> >> given that there could be huge gaps between symbols.
> >> [...]
> > [...]
> > It would be useful, sure, but is there something that does, in fact,
> > need this, or would like this if it were available? Since this provides
> > a userspace API, what would be consuming that API? For example, when
> > Syscall User Dispatch was added, it was clear it was for Wine[1].
> 
> We have a long-term consumer in DTrace (e.g.
> <https://github.com/oracle/dtrace-utils/blob/dev/libdtrace/dt_module.c#L1323>).
> (But since we control this consumer we are quite happy to change the
> format of kallmodsyms, integrate it with kallsyms so that kallsyms just
> provides the same information if the file format break were acceptable,
> or whatever you think most sensible. We just want this information
> somehow. :) e.g. the code there doesn't yet handle the
> symbol-in-multiple-modules case: I'll have to add that.)

Ah-ha, excellent. That works for me. :) (If there is a v5, maybe add a
note about DTrace to help show the specific need.)

Thanks!

-Kees

-- 
Kees Cook
