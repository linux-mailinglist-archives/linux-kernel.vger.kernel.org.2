Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0DC3A7760
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 08:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFOGw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 02:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhFOGww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:52:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694A8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 23:50:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g18so47636887edq.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 23:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XiBpXEQV/jtPOVHF+9E1iztsI24wyA4vFp/2KFQcCf0=;
        b=WtAAidMy9F4exzDJfO7hneU+2cqQD+fK+fGYY17fEvCuQy22+ch9mJ0RW/COiZu6Tm
         toaHRA8IFtvUnBEzX64Mly/FVR26T2Z6VPcrk/cgUBR2F4pw2YXgTkV2vkbOBabvD2Qv
         LhrbCB4b7u9sC4W19XEZFle7B7mFSBMcyo438=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XiBpXEQV/jtPOVHF+9E1iztsI24wyA4vFp/2KFQcCf0=;
        b=f6KmrVU4vV46W/nMTGBeKsVP4ZQzmD4tKnazkkQw8nvvQ8zUcFYWr8yUdxSSOB7Ve/
         1eJtJIVQtpBx/4d4KD/YuAi8z1c9XAwzKkxhhGn6CxYCodWbbTJSkKvG9UHKdmziumVK
         y8vXmMj4AKyU0QOnklIPlVf4LOOPsOZqt1r8SG3PC67EuqkX40OYW6jYxSt2ktbj9UBz
         CPa79MJfCRGJJ0eY4HxOjqms+eVpJnBNbCE5g0mz1daLFgFaoWHayFJsCj20pvPKf4I/
         i0hBtLtrO0Ysy1kxHchGsUMhf3kaezdJ1HxMOmppxpZqRAjZX18lrsWdIdmRmPokzlx3
         payg==
X-Gm-Message-State: AOAM531W2qq8yMCVy0UmZp6W3kT8NjJFldeSieRnHxtZVQlUYf3rY1Ln
        0GSPVP5iR4cPCJ6DKhLyYk/cS+dYprZ3w61C
X-Google-Smtp-Source: ABdhPJwC2mr97QCTGnSccli6U5fr9wKWG0cXkuUnB8GvBvbikVXnacMRr2rvxXsepdx+aN1bu0fhmA==
X-Received: by 2002:a05:6402:c8:: with SMTP id i8mr21524215edu.380.1623739846726;
        Mon, 14 Jun 2021 23:50:46 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id h24sm9152788ejy.35.2021.06.14.23.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 23:50:46 -0700 (PDT)
Subject: Re: [PATCH] printk: Move EXPORT_SYMBOL() closer to vprintk definition
To:     Punit Agrawal <punitagrawal@gmail.com>, pmladek@suse.com,
        senozhatsky@chromium.org
Cc:     rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org
References: <20210614235635.887365-1-punitagrawal@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8c16059d-6e58-a3e4-25ef-7e2bcabecd86@rasmusvillemoes.dk>
Date:   Tue, 15 Jun 2021 08:50:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210614235635.887365-1-punitagrawal@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2021 01.56, Punit Agrawal wrote:
> Commit 28e1745b9fa2 ("printk: rename vprintk_func to vprintk") while
> improving readability by removing vprintk indirection, inadvertently
> placed the EXPORT_SYMBOL() for the newly renamed function at the end
> of the file.
> 
> For reader sanity, and as is convention move the EXPORT_SYMBOL()
> declaration just after the end of the function.
> 
> Fixes: 28e1745b9fa2 ("printk: rename vprintk_func to vprintk")
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> --
> Hi,
> 
> The out-of-place EXPORT_SYMBOL() caused an unexpected conflict while
> attempting to rebase the RT patches onto newer kernels.
> 
> Generally I avoid sending trivial changes on their own but this one is
> a little hard to overlook. Also it felt like an obvious oversight in
> the original patch.

Yes, indeed, sorry about that, and thanks for fixing it.

> Please consider merging.

Petr, as this is causing trouble for the -rt patchset, please consider
if this could make it to Linus before v5.13 release.

Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Rasmus
