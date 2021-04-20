Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FD5365FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhDTS6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbhDTS6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:58:08 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F33C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 11:57:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id z16so27269242pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aJNASscqBfquE4O0//zrlUl4LCxQAwrFtI6OJ95T4sM=;
        b=ciQKLLqrqwm3gYpnIJ0rD+l6a7vXWj9kDF0MBS8Zk7kCYCDJRuA+2atjqPD7Arq2Ei
         YhUbzsLQpQ+/dCjfvgCFU46qCLD9wOewiUGhT2MMLGO+hHUxhdXsEHGWwyxZij8KNJem
         7+g0p+b1lpCWAISl5HIt9MqomKKhLWOnHMT34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aJNASscqBfquE4O0//zrlUl4LCxQAwrFtI6OJ95T4sM=;
        b=JeFYOFYtcY3i9mjvEAlSPTuruUdNNR6j72dOjyA4VuBkyJ1RGSizSf9sCi+RuAFKRs
         KwNYXG/rEKmnF2rK5ec9MonZVp26d14ChZ4OhXiNZNSuv5Q84fWjAhYzXYu9YEtiLMDF
         6P1YXjrz+bFfAP1n+2ziBfbe8hgnfOIuojU4MBowzGNU4TCGUJCDpeB6TsSgS6hOU9aQ
         yLHG/I23Oi63k7jwq7cc7fPPfLHPYjvE1X8s9KAKmP4wHe5Ac4AfnKzK7aAQkvHa7Jsd
         oI4yFApU4V4bm6KwGE7NH+PS4VncTSwomQ38sv4f/jtY6iVFJ9HybeL/nYQAeSJbJbyt
         mIkQ==
X-Gm-Message-State: AOAM532AmoxqP9whhuf/4OPsOPiXevcMTAMHnFxTqSXcWMO3kmBbkSl+
        0YO0GK6snuYb/d5fNjBRG5gLAQ==
X-Google-Smtp-Source: ABdhPJwzPw9WgPd1b0BnTvBKtnZVgFjUnho9It1XusGE5vA9f88k54H5Zj6z7088FePKoKC7aibJfw==
X-Received: by 2002:a62:5e86:0:b029:25d:eb5c:5a2e with SMTP id s128-20020a625e860000b029025deb5c5a2emr14167257pfb.56.1618945056543;
        Tue, 20 Apr 2021 11:57:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lt11sm3094776pjb.23.2021.04.20.11.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:57:35 -0700 (PDT)
Date:   Tue, 20 Apr 2021 11:57:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Show three registers per line
Message-ID: <202104201157.71854FD6@keescook>
References: <20210420172245.3679077-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420172245.3679077-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 06:22:45PM +0100, Matthew Wilcox (Oracle) wrote:
> Displaying two registers per line takes 15 lines.  That improves to just
> 10 lines if we display three registers per line, which reduces the amount
> of information lost when oopses are cut off.  It stays within 80 columns
> and matches x86-64.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
