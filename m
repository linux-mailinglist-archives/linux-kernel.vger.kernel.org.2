Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC90325763
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhBYUPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbhBYUPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:15:17 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0737C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:14:36 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id l7so162119pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zdmrTvdyCX0Y7fege27eT+Ei6fSHtu549VnzR/+8VsE=;
        b=jI4IfZWpkZMecfmOkoHM1sDBamKCnyhZAjeDxWo+rANJ7GdjTcSH5W7eBatc/2j6gw
         wocgFPVWBccNrS2n8ZwuGp9JJoQZq7I6dfk/7KWyQpKVT0g4iVZQXJWoK/G73m20Pi8D
         GT2Itn+ybPPpezCQrWTd+fHX7QpAojDJ184l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zdmrTvdyCX0Y7fege27eT+Ei6fSHtu549VnzR/+8VsE=;
        b=myoksuaHjrOirN+91qJjL9pZgzmMFEE2+Ku20MakDdRUpEF06QAWtUcV7sIGcSqA0M
         xfI1uPYZD/B4T/mHdN6NoxXtMynHrCR906X+r1IJTfBzDfAWsUZ+ES5G5UceXXmFvBDT
         ZD7I8abpPB4CF0MCaNjg5t9mLq3tnSqPxpjjpAwVmgKFvng1cR3qU8UEp0rueYkFGkWx
         MBO3xciAFtHkEnaNsZs8D61SxkGhJWGHDSP+HXA231JOK9fyVmo7xsoH/PLTDCzYI456
         gt6I75OiCZyrDnx8r2Ohg07pWgy0ZSAhinNM0eSLVMFWOy8WUFdgteV5KG89XsZmwiJI
         oiQA==
X-Gm-Message-State: AOAM533QyojaPXQ1t+gBL+Q+5ESRjF25s7jSdL2PRKMahAZn01ng3i7D
        372aglET6YC4CNCxYjTY76w/WQ==
X-Google-Smtp-Source: ABdhPJybewo9PBjpkHnhHiTD+UEzDtD2a4vw8RMiqGlZyxuXP8K3WZtyuQGrpy2dmyBGJevA7jzpxw==
X-Received: by 2002:a63:fd01:: with SMTP id d1mr4347459pgh.319.1614284076558;
        Thu, 25 Feb 2021 12:14:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p11sm6631697pjb.31.2021.02.25.12.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 12:14:36 -0800 (PST)
Date:   Thu, 25 Feb 2021 12:14:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: lto: add _mcount to list of used symbols
Message-ID: <202102251214.4CCD3FF13@keescook>
References: <20210225143456.3829513-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225143456.3829513-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 03:34:49PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Some randconfig builds fail with undefined references to _mcount
> when CONFIG_TRIM_UNUSED_KSYMS is set:
> 
> ERROR: modpost: "_mcount" [drivers/tee/optee/optee.ko] undefined!
> ERROR: modpost: "_mcount" [drivers/fsi/fsi-occ.ko] undefined!
> ERROR: modpost: "_mcount" [drivers/fpga/dfl-pci.ko] undefined!
> 
> Since there is already a list of symbols that get generated at link
> time, add this one as well.
> 
> Fixes: fbe078d397b4 ("kbuild: lto: add a default list of used symbols")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
