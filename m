Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2AB45750B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 18:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhKSRNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhKSRNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:13:04 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378FBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 09:10:02 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x5so9940317pfr.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 09:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uo37clPgdHIV25zsSUbGlKezRRwyXv+oTpxiRTg6/S4=;
        b=oMV8Pa7nGYW6xJoYZYcYGEyMsV/hOfWQhXTubQlT7ZoQ+3lCYHQLc9n9NI8rMDqaMT
         tOEgkNTjw1ayyug/HycNbJJCqQq0r7NXTP0s5J9yHE6KBbbeNnJlZzJlpvHF7oqAkVbG
         46pt8JgDIcsewIMdtnc/AtkDMAaJScQLGaHbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uo37clPgdHIV25zsSUbGlKezRRwyXv+oTpxiRTg6/S4=;
        b=0iTLyyhR9u7SAYqKrdMpE2SEVRDbtl7HKU6MS6NpV35q4qjQLWLXxRDdxBmZPAUQOe
         0WIdtfIEEz0E00k4i/m7yKxgSd8b5XJLpxEU3IpgFSZi3MGAah4xNnx6CBy9AmIS9Ba9
         mjtnt9SfK4K1mS1EXMZLcz+bvfbQyzCd6O0RAzzZGFwtE31FzDytlJ/JWMzqy6LRIPpE
         78FlunrkFJWUEvRZxtRPsc0xSbLLJgAqRgdJ3cD9wK4ToWpJB7o0N+4cKwlW/1wEJUa5
         PWQBvChUjJiWgfMd2iCfUivdtVajr1PqxuVRYq4yYgXRu6ozbXNoFH1kbqHie/aQvFol
         zSaA==
X-Gm-Message-State: AOAM5322jkyplQwZI8D7UgfnqQEcDxU7eVXAFLF4fttO3M7RFTZfEyb6
        F8fvsB3BnQlJL3ZSmcgIexRxTA==
X-Google-Smtp-Source: ABdhPJznKeR1CLdGXzC7PNzjxSQE2Q4Go15y7nepNiv2o/jL9UCpt43FdvPgCuvRJV4YXctNbzrK7A==
X-Received: by 2002:a63:8b4a:: with SMTP id j71mr18297964pge.252.1637341801787;
        Fri, 19 Nov 2021 09:10:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b15sm228220pgb.81.2021.11.19.09.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 09:10:01 -0800 (PST)
Date:   Fri, 19 Nov 2021 09:10:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, mark.rutland@arm.com, will@kernel.org,
        ndesaulniers@google.com
Subject: Re: [PATCH 1/3] x86: Move RETPOLINE*_CFLAGS to arch Makefile
Message-ID: <202111190909.5EB1270C90@keescook>
References: <20211119165023.249607540@infradead.org>
 <20211119165630.219152765@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119165630.219152765@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 05:50:24PM +0100, Peter Zijlstra wrote:
> Currently RETPOLINE*_CFLAGS are defined in the top-level Makefile but
> only x86 makes use of them, move them there. If ever another
> architecture finds the need, we can reconsider.
> 
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
