Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4430141D006
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 01:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347588AbhI2XgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 19:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbhI2XgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 19:36:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ABEC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:34:41 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t4so2691343plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s50PiUE0GZ0ZQQyDE7urYqyC+XXAehvlB01y0urqqec=;
        b=jHod2IEAOYSVMk4eJ9KFe66IDNul71zOAQnH7GZhxrEAYN54b/WprrgAWaMqj8wppk
         8PVbfnmuUnkaOZzQI2ceK0mpoApel9aQ8+U6aXrn+KimynTOOm9yJbupVhbBtY7U9mE3
         ir91XMap1ANGFfr6e5w+czRSC3G48rSuncKp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s50PiUE0GZ0ZQQyDE7urYqyC+XXAehvlB01y0urqqec=;
        b=FpAg6S5APR33c90/G7B0P0Bd/d9yZzhpkgJfynWvCblvoZdgpBwiugiyQrHme0baek
         YsVySzNJZxzAjb9YmKruutFC4MRSSWSLIWIxzVgxYT5sj9HzBXRWJTkpA9BddUx1SNro
         iyZHK3ukcLOSFT7NQ5/p+absCRZCf8z7vupMyJ1OOadmP/5NVBFrFDCPs1J08ug7+hhq
         9LBrwZ8Fpg74Eba+cO5nlGWtLeCyTiAwQvoYf2Z5sa4F+oJZFgm6VGYQ+Mdi8v7jP51B
         jQu63Tt6FvLRWPqtnpmGFfqUIBbsfgbTXZdm6weh6kLR0I++W4VMtQO8AaIvCFmgb7jk
         +ZyA==
X-Gm-Message-State: AOAM531a/FBf7qZ7H9B91vYH6oqc1dG4pJeRjzaLDxfmZLgC/WywI7HE
        UYDndUPI6h8d6tIsQsA+DtCQ5w==
X-Google-Smtp-Source: ABdhPJxe5v97/gfWltea1abaN/1MdcuCha0nNqWTUiqPt0CdOhwDAm3vef6xuKBgecmbNsijHEo/ow==
X-Received: by 2002:a17:90a:a78f:: with SMTP id f15mr2783279pjq.106.1632958481050;
        Wed, 29 Sep 2021 16:34:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v12sm631373pgt.94.2021.09.29.16.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 16:34:40 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:34:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     jeyu@kernel.org, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: Re: [PATCH v5] kallsyms: new /proc/kallmodsyms with builtin modules
Message-ID: <202109291629.81106C83D@keescook>
References: <20210929215154.300692-1-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929215154.300692-1-nick.alcock@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 10:51:47PM +0100, Nick Alcock wrote:
> It would be useful if there were a mapping between kernel symbol and module
> name that only changed when the kernel source code is changed.  This mapping
> should not change simply because a module becomes built into the kernel.
> 
> It might also be useful if there were reliable symbol size information to
> determine whether an address is within a symbol or outside it, especially
> given that there could be huge gaps between symbols.

This is a pretty cool series, but I'm left wondering "for what reason?" :)
Perhaps I missed the specific rationale; there was a lot to run. ;)

It would be useful, sure, but is there something that does, in fact,
need this, or would like this if it were available? Since this provides
a userspace API, what would be consuming that API? For example, when
Syscall User Dispatch was added, it was clear it was for Wine[1].

-Kees

[1] https://lore.kernel.org/lkml/160690190770.3364.5119373826178425644.tip-bot2@tip-bot2/

-- 
Kees Cook
