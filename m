Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C151542EB2C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhJOINa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbhJOINZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:13:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F383C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:11:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j21so38773584lfe.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JRDPxtfCq50zpyNDk7SIx0iGGT8HaQBw5rSfPbd7iTQ=;
        b=QNsjF+pJTWOMZhjw7rFcipU7+h2s5KpOHgBrwm6lH/lqGMk7OaZ2hTRTKef3yg0Py5
         aRoWZeR6BPcNBmWvduX/SdxCL2fe7yZzctVtpd+8igSsQ9oQ9QeEn4vOtP9nNF0j3Tai
         hYuIzFUkRVI4QOmnPsStgrRgLrxmQ6ob6x8cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JRDPxtfCq50zpyNDk7SIx0iGGT8HaQBw5rSfPbd7iTQ=;
        b=u/1woTOhJgecWE1SvXgrngpLLHAWowf2aMgdcuoVsLjfMJI5KUhArCfEW+agU8Luwc
         nhZpdn1LAU5g2SFeU1OoOj8lh/T6RVW3iG5wZRrTK+6mBsqLUuIIqRpG7jM22/UUvFzX
         mPawadHn/f5pddNSgPa/Vh9HAnprDtupuApZczsFJkub9rgcNfkGo7zIlvDVai1bzsL1
         cAJV3pnNBQ+Ni6TACn+NoXWo5J09ulWJh5mHtSXMViuzGojRiFtOa8wDltApmLXZ9O+1
         qCKx2gL7MwMkUobikS+aFwXqEpE99U403tbdFt+V9N/txWfAiJ6mbjQoZBldAxiS2aqe
         eeQA==
X-Gm-Message-State: AOAM533ebB1nRW+a50i9TJbpNEI+xUDdCKXnwv9meIqRPMkFm0mxNznA
        ZLbYcaHkc/dSZ91TgAM0TW6eVw==
X-Google-Smtp-Source: ABdhPJzQn7X944scb3wsOleSNv4N/ilxR7afsW+PZ7Qx7j1bzP8X26noc9+mXwwjYASdZLAcuR/gqQ==
X-Received: by 2002:ac2:57db:: with SMTP id k27mr10179209lfo.674.1634285477914;
        Fri, 15 Oct 2021 01:11:17 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m27sm437151lfc.178.2021.10.15.01.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 01:11:17 -0700 (PDT)
Subject: Re: [PATCH] compiler_types: mark __compiletime_assert failure as
 __noreturn
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20211014132331.GA4811@kernel.org>
 <YWhGQLHnA9BIVBpr@hirez.programming.kicks-ass.net>
 <CAKwvOdnkDUfRKzmLThQGW02Ew6x=KM0MQyHge7=kc673NYxo2g@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d1c957c4-a2df-935c-2992-3540f05fb110@rasmusvillemoes.dk>
Date:   Fri, 15 Oct 2021 10:11:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnkDUfRKzmLThQGW02Ew6x=KM0MQyHge7=kc673NYxo2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2021 19.48, Nick Desaulniers wrote:
> On Thu, Oct 14, 2021 at 8:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>

> I'm not sure how worthwhile that yakshave would be, 

A yakshave that would be worthwhile is to kill off the macro
compiletime_assert() completely - three is a crowd. It sounds like it
would be implemented in terms of _Static_assert, but it's actually
__attribute__(error). We can fold the definition of compiletime_assert
into BUILD_BUG_ON_MSG.

The users in rwonce.h should just be changed to static_assert, and then
there are very few random users left, which can either be static_assert
or BUILD_BUG_ON_MSG.

Why do we even have a no-op version if !__OPTIMIZE__? AFAIK there's no
CONFIG_O0 option, and such a build wouldn't be interesting at all - it
can't be expected to boot, and it would likely throw warnings left and
right.

Rasmus
