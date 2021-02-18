Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C55331F119
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhBRUfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhBRUeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:34:19 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCCCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:33:37 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id t2so2260613pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6GkVg6oPaCbOjN9yHtUy6WgUiMIl+iIxU5q/YySdGqo=;
        b=HWrUIFsIBt63vXlTx9Fi+lqtHfKHvSqunnCmQIjmO0fDJL7GSWvmZlm0BRMwCnJPc3
         gbo6xFLqUPzMMWqkoks6inG87DuOSa9iGf15R8guNkFY5qwVM3JI1b2FqVFPb9ve5TWq
         bJnAFpEzsyLjDChFEZHC8GccBzFB8VDJJpf+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6GkVg6oPaCbOjN9yHtUy6WgUiMIl+iIxU5q/YySdGqo=;
        b=TT+Pmf5XsqIuAIx13kipQ4o5uLp4+NK2s0IUv5aWwDXY7yyO8YAO0WGIZF29c1dEjg
         vOD2pSMMkueVkZGIHoFtaGTQlvwSGJl+sVP5NfYl/1TWnTxkgM/2pv49+46LcrT590Xo
         oOZcPvFg12UyqlnoOkxGzhv9u1F2WUqAiIId3V6oWlj0QpFI2LDgsM32ahkfOJJeONAl
         iKk6/YFqytjec8RtPoZ9tQhpKnUoQ9wbUhM/2VYbGC96XdF9uCN8ymtqJq8iE80D5y+T
         pJXiKYnhnJup+ottnljXpUTAVkO++0VkY3eRlQPUV+0bQotB+HroiGoQE6Gx7RCbembR
         d2eA==
X-Gm-Message-State: AOAM532G5A8Du0pC5ZIFAwODvHpKH++72L3joaeDuztw4QA9Cz5rwuqI
        bHc6lwa7QL8qIhF+W2bULTfbiw==
X-Google-Smtp-Source: ABdhPJxslS5tP12p8hBRmWryZqdHGJ2VYdgG9pkwL3XgJ6NpQfX/68tVqTkWrQNGhYUSC+bBbwvZng==
X-Received: by 2002:a17:90b:806:: with SMTP id bk6mr5614183pjb.16.1613680416959;
        Thu, 18 Feb 2021 12:33:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x20sm6993759pfi.115.2021.02.18.12.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 12:33:36 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Jiri Bohac <jbohac@suse.cz>, Colin Cross <ccross@android.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: pstore: fix compression
Date:   Thu, 18 Feb 2021 12:30:03 -0800
Message-Id: <161368019685.305632.7880211837303066992.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218111547.johvp5klpv3xrpnn@dwarf.suse.cz>
References: <20210218111547.johvp5klpv3xrpnn@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Feb 2021 12:15:47 +0100, Jiri Bohac wrote:
> pstore_compress() and decompress_record() use a mistyped config option
> name ("PSTORE_COMPRESSION" instead of "PSTORE_COMPRESS").
> As a result compression and decompressionm of pstore records is always
> disabled.
> 
> Use the correct config option name.

Eek; thanks for the catch!

Applied to for-next/pstore, thanks!

[1/1] pstore: Fix typo in compression option name
      https://git.kernel.org/kees/c/19d8e9149c27

-- 
Kees Cook

