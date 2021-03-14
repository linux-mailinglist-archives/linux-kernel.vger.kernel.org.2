Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA65133A882
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 23:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCNWYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 18:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhCNWYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 18:24:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6CDC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:24:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q25so53919732lfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vuviw/xeXz4M9EOE7r6Ns6IR0sHJQAyhHidVziz3nr8=;
        b=L7hYglNZ7R0mQvHawJF+BD9zW+OiyrLD/ZZHQ2ZfzJc52myghki1+D+5anfrAyjB8l
         YQVJGp/8lwRMpEphDwrhBnsoJQZs1TWtTXoAr33hhm0PM58Y1EN3M5tk/qH0w7NKBa4c
         sf/A1WhR9uY5TKlehYAYAbLcWCKCEFDcYH6TMFf4wzDW9ZxCToTg3YPfoZoh4ZpEclsW
         ZE08pzWhyUq3Ryfy3TWrShl+MOgul3qjiyRdX6KS+Yd5cVGEvYaMrhjscOC78nmPA9Tx
         ermJz51rVhMzCtLfgH1xTzKQu3o2xF3xJQ6gDHvU7f3Mymo7jk7OdEWEsI3v8vAblrXd
         UccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vuviw/xeXz4M9EOE7r6Ns6IR0sHJQAyhHidVziz3nr8=;
        b=A0JL6nZ3GiLro/ojjK6NMhGlwKSCbabqjX6YgJ4Qa/HWLKawPdaA7HURTW6MnGWmOQ
         pe3wuVVmm1aBEvkJkzIyEq3zDZjdNlgYYYdbLiCCSRneGukSbqF5TjjBl9ZUzhFteRm1
         jlUiggDz1/9BsuvJElfEbLrR8lKKVRwudZSYYorUZKM1Fq4DVCLne8eQ5vJBDVIz0kaz
         y0XtyDwEk1hmkwzOPGUCcNZjFGbsMXaSO/d5wzR7AzgSvH/Z05hUZ/q71yVRhsdfvswt
         UHQBnIxH2iGm7Zq4r7UwldsY6v/OFZDzhJaO02vQhvqfE/4fv/jYP3kFv6A4Yito+Kzg
         gB4Q==
X-Gm-Message-State: AOAM530O0D3X4zH76VpilObBoz3qTs9LUuMK90Ud+74t84B+y8LqWted
        Lc8Z3hsY2YyLXs424Hfa8IVv7v2mF3k=
X-Google-Smtp-Source: ABdhPJyXUaOKepQ3fiY1O4MxB0pcidubxyVLTZHMCrpmgcMjnG5Y1Xmi+lPUXOFaBtWOxWsFfogtKA==
X-Received: by 2002:a05:6512:2254:: with SMTP id i20mr6256833lfu.534.1615760676318;
        Sun, 14 Mar 2021 15:24:36 -0700 (PDT)
Received: from grain.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id b80sm2446942lfd.209.2021.03.14.15.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 15:24:35 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 5302E5601D9; Mon, 15 Mar 2021 01:24:34 +0300 (MSK)
Date:   Mon, 15 Mar 2021 01:24:34 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Security Officers <security@kernel.org>
Subject: Re: [PATCH] prctl: fix PR_SET_MM_AUXV kernel stack leak
Message-ID: <YE6NIraVjV1kSfkx@grain>
References: <YE53QiJuxsCUeoiu@localhost.localdomain>
 <CAHk-=wgMm=PG3uxfpmYpkX-GaDAR09pej=t3nD6hHDNCYCyaRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMm=PG3uxfpmYpkX-GaDAR09pej=t3nD6hHDNCYCyaRQ@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 02:40:05PM -0700, Linus Torvalds wrote:
> Applied directly, since I'm just about to tag rc3 and was just looking
> that there were no last-minute pull requests.
> 
> Andrew, no need to pick it up into your queue.
> 
> Side note: I think we should return -EINVAL more aggressively: right
> now we fill up potentially all of user_auxv[] and return success, but
> we will have always cleared that last auxv pointer pair.
> 
> So we actually return "success" even when the user supplies us with
> more data than we then really accept.

Yes, this is somehow weird and probably we should start complaining
if last two elements in the user array is not AT_NULL but I fear
this might break backward compatibility? Dunno if someone relies
on kernel to setup last two entries unconditionally.

> 
> IOW, tightening that up might be worth it (maybe actually check that
> they are valid user pointers at the same time).
> 
> That's a separate issue, and I can't find it in myself to care (and
> nobody has ever complained), but I thought I'd mention it.
