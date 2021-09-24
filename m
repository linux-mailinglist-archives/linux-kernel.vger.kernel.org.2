Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A93417B16
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 20:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345455AbhIXSaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 14:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345018AbhIXSaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 14:30:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21A5C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 11:28:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k23so7584525pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rf/DQgWol+2Qie0FLxwIYbvWdB4cIMthZm0XYX74FbA=;
        b=Q5OxGHQnN0WJ53D+/Vug4mK0zCYikMbYR5c6DETs6XRyLR89IY9hAyU9C/8bsaUmUO
         SufGaEWG+dKh8E5VUehdI90UMK5F9DiGJkczDVyCj02E8akUKR7KtwCjvHAE7VXzJ1yK
         JUeNJv4G0uydoLVZsqO1qV9hqAeXUSmih3iTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rf/DQgWol+2Qie0FLxwIYbvWdB4cIMthZm0XYX74FbA=;
        b=CEnvz0Lia1Jl2xY/QkFv+QIxvoe0aJGeCK5+1ZfcfdXXeIv0cmlFJ2goRA6B+P9T77
         xbBXfG3P9EiGZ3x04YDb8z3tAHEgg5htqeCzPvu+UzkxlEa83dABuqP6QQXw3gbBfBop
         kpdo2/ZMLlmy/1I1KaMYrLaln73XbKV3EpMDFgxnyScjf7Ys5+67EP9+Ycvegnz5bhlc
         f/xzX99f91kP4IevetInG+EZXzGcMRS3v1P7mWe/UQbVdgE3yoOGkP7SgmURmpiTG+1z
         HZOf5pAMc6NEU+CoK25a9VYWpbb5RImoB1jUZCQ9IFQWBLnoW0acvuQslRvdii1mm4/e
         ANgg==
X-Gm-Message-State: AOAM533qRUEqdNx7uWhiw85UT3JXPwATgoKsN0z1bXPPqGh1F4ySatrl
        0Ot/x20xPLkMVtuWaBW2HpX+IQ==
X-Google-Smtp-Source: ABdhPJxTCHnGUVkViNa5KY33kmg5e4iRbJOF121ZYSZL9Supg5zTiqqhyYVktyqOlcYmBCQxVe4vAQ==
X-Received: by 2002:a17:90a:9285:: with SMTP id n5mr3900885pjo.29.1632508116320;
        Fri, 24 Sep 2021 11:28:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x21sm9818136pfa.186.2021.09.24.11.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 11:28:35 -0700 (PDT)
Date:   Fri, 24 Sep 2021 11:28:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org
Subject: Re: [PATCH 4/6] exit: Factor coredump_exit_mm out of exit_mm
Message-ID: <202109241128.E0A915F@keescook>
References: <87v92qx2c6.fsf@disp2133>
 <87a6k2x277.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6k2x277.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 07:11:08PM -0500, Eric W. Biederman wrote:
> 
> Separate the coredump logic from the ordinary exit_mm logic
> by moving the coredump logic out of exit_mm into it's own
> function coredump_exit_mm.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Yup -- mechanical refactoring looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
