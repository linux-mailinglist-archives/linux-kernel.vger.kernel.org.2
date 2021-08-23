Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D65A3F452B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 08:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhHWGoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 02:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhHWGoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 02:44:01 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD11C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 23:43:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id l18so22021046lji.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 23:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X9FMR7iIGm8hwjI0Az1jlgXDZnDlEXK88Ri4nJkOnvk=;
        b=Ib8+qMiGcXJO6i+tGA0QmqhxNKex0iZSpxnHBbWhdc8YTalcCTQtXxGESavmAvSMiz
         LawPT0nO36Y8V8IW5DQHRJG7KMZT/g84kVe462xfXjK16NvgfoTNOwPk9UgMcNkgkw0N
         hyGP/X5KsS6NSbNy6vLDYdhz2Nz7P8vBB99nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X9FMR7iIGm8hwjI0Az1jlgXDZnDlEXK88Ri4nJkOnvk=;
        b=q0dykuDnY6FhAKCybXm7Lb/oSc9YkZRPRe3VYkrN++hHVUk1BxhNHLbmHgRj/NlmOP
         OYhF96GjmzdWBH/6uwHlnezcA06Z1L6cBTjP972zLIGB4QJNHoEEnKreud6chCFZ4+A5
         0UYxtoQaktaYQoU8pf1agD2TB30GwGzMmC/QM2Ac6gnL2uuaN17j9wLwxdYDx5W4PVRV
         qQ651S0WUPvr+Wha6FOX0po4OR7NXAqcC+8GkQabhkF3tolk6Ib/m5fwS/VQzPoMnkco
         eh6cxsGL8NrWRdkFWEXru69RfcM9GFPFoSOxgxoR0+4TmNJMod3KJu14V7+9NNFj4TRk
         oQkA==
X-Gm-Message-State: AOAM533hZy6Mytkm7iJ5NtgHmGBBvZBB32UT2iRUkQ0aoXPJ4beYTblD
        YVivmdRv8tayIMz6Xos0G2bKWw==
X-Google-Smtp-Source: ABdhPJxLCvVCTMjiT6xh9Cgw7aGYl/Ohc3/GyHUBoc2jnxiqiG5LQ/per7MxAtf+WsIn33ffeeTGNg==
X-Received: by 2002:a2e:9999:: with SMTP id w25mr26140028lji.359.1629700997604;
        Sun, 22 Aug 2021 23:43:17 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r20sm1359329lff.93.2021.08.22.23.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 23:43:17 -0700 (PDT)
Subject: Re: [PATCH for-next 13/25] compiler_types.h: Remove
 __compiletime_object_size()
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
References: <20210822075122.864511-1-keescook@chromium.org>
 <20210822075122.864511-14-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4fff1f46-ab10-317b-8cf0-05871e4a9d71@rasmusvillemoes.dk>
Date:   Mon, 23 Aug 2021 08:43:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210822075122.864511-14-keescook@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2021 09.51, Kees Cook wrote:

> -	int sz = __compiletime_object_size(addr);
> +	int sz = __builtin_object_size(addr, 0);

Not directly related to this patch, but seeing this I wonder if there
would be some value in introducing names for those magic 0/1/2/3 that
are used with __b_o_s. Every time I stumble on code using that I have to
go to the gcc docs, and even then it takes me a while to grok what

     TYPE is an integer constant from 0 to 3.  If the least significant
     bit is clear, objects are whole variables, if it is set, a closest
     surrounding subobject is considered the object a pointer points to.
     The second bit determines if maximum or minimum of remaining bytes
     is computed.

means. The names don't need to be too verbose, just having a few
#defines in-tree with the above quoted above them makes it a lot easier
to figure out what they mean.

Rasmus
