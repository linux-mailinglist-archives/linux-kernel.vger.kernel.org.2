Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597B344EFF5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 00:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhKLXPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 18:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbhKLXPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 18:15:22 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31559C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 15:12:31 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso8810202pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 15:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=YN0gzQIJL08vzHcPeLEA4tfqqEc6asHK/4BMIe2BKNc=;
        b=FEajFmA/aBOXJRoP3vDCAhWw3jkkoXif6pQ1WdVLqEgBvEisui6TTXl/sow3VHj8Tv
         yOlkZSuL//dwcJlt0uyn3Xmq1V7HVJ7KuMhvPAwhAt8hDuMLkDueFUNxSvoNr60wWn1Z
         DjDO/b7Flwha8P8ycD6mibOYVhDuQz+7VrOjo99sqsDhIHwDgkUyHRGp/885vBef+vjv
         0Ps3ZcOAdUOReCbTJ7Qynx9I+MzADrmYbTrGDBxoo66m40tZJvmOZyMHSkjYEtb5sYKy
         UxRRiV5HU6z1rOSnSRl6yWPWs/5BwzxqchPtq/++YHONvJBRDy0v/WBxnk5bSs1BB7P1
         fOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=YN0gzQIJL08vzHcPeLEA4tfqqEc6asHK/4BMIe2BKNc=;
        b=pL9LR7s2Cepmmmj5mR5pULZZRSMbDB3aLkYZymwupEeigBRK6/8nlJxCxpxdJSMQIG
         CAtQRlsOC5lRlrvEJpk5UUW8XCETFPd2OE5jlRMKo7GPqoyzPPKnCSvN5FhkfPMIZYuz
         i/+FbomsfBzeVouG751grqcj0D4Vup2L0ZoQA3tkkGKbU7OuzyNvJe9TCjox+HFvqH+I
         yqe6/42mDh55XYc2aiZFThcWrr5nDvaRC58xhURHiU9hwOJsPpzxf7xNmSyRjAJvFYMt
         MNaolUjGD9mg7ghSimg6fJrufXfxcW6csFNJtNxGxE6BikdG5D3oZpSFKGhEgINuIDEU
         xhig==
X-Gm-Message-State: AOAM53119gHDJbrXmj6NwvwN11ADEA1yJ9bwz+Y7ghTNgGko05rFyNco
        unrhLRjmHMx0Rs447Pfxf15rDQ==
X-Google-Smtp-Source: ABdhPJxWiwrcloi7si8eaFR6sCnPnQxXQFhUG+k2OUwKTF+/eZqlwvfk+H/9ArZZhXnJPac+y8JdTw==
X-Received: by 2002:a17:902:b28b:b0:142:4abc:ac20 with SMTP id u11-20020a170902b28b00b001424abcac20mr12236925plr.88.1636758750688;
        Fri, 12 Nov 2021 15:12:30 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x125sm7422624pfd.105.2021.11.12.15.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 15:12:30 -0800 (PST)
Date:   Fri, 12 Nov 2021 15:12:30 -0800 (PST)
X-Google-Original-Date: Fri, 12 Nov 2021 15:12:29 PST (-0800)
Subject:     Re: [GIT PULL] RISC-V Patches for the 5.16 Merge Window, Part 1
In-Reply-To: <87mtm9rp35.fsf@igel.home>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     schwab@linux-m68k.org
Message-ID: <mhng-6cc11053-b031-4ee5-875f-fa18095839db@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 14:22:54 PST (-0800), schwab@linux-m68k.org wrote:
> On Nov 12 2021, Palmer Dabbelt wrote:
>
>> I wasn't planning on sending anything else for the merge window.
>
> Not even the KBUILD_EXTMOD build fix?

Sorry, I hadn't seen that one.  I found some bugs in my test suite when 
getting it to run on the new machines so I've got some new failures I'm 
working through, which is sort of blocking up everything right now.  
Everything in this PR was tested the old way so I'm confident in it, but 
I usually do a merge with Linus' tree and test that before sending a PR.  
In hindsight it might have been better to skip that this time around, 
given all the headaches getting things up and running, but it's too late 
for that now.

I'd like to get back on a more solid footing before trying to pick up 
more stuff -- I guess that's a pretty trivial fix, but anything in the 
build system can run into wrinkles (also looks like it was broken in 
5.15, so it'll have to get backported).
