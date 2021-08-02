Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1243DCEFA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 05:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhHBDud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 23:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhHBDub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 23:50:31 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFF1C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 20:50:21 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id o17-20020a4a64110000b0290263e1ba7ff9so4107815ooc.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 20:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UJdzLFPEPPSSNUSmHlQ5Vfo+J9yTyV4ONJFREZVAKmE=;
        b=FuuyhhdrRTDGqfebyucyzloiFBJjgi1Y/zNGJfvMhJnxVnIxd9msRtGnLmwNGeIhmv
         1s4LcXhEg7OhDaa1v8B0J+RKjBHc9DpxjinKdWo/44DhwG0P9f73x2tKlwq+MhzWUOyS
         rDFOO+gaZcwmRcA+lEI2C9xub+38sCJnV0ND+zsmU/ln6sBH0EAqDOOOWRNIp6vDSiNp
         Xso4yuk7drKlEgXHNPDnF8UIZ25jukg9BOTUL4v8EGe5xz/9KgqQ981K/i/Q4kAtgyns
         RCO/pPjInR/Y7a52e9ZuKX4yDqXDjeefWC8felz8EJ7yP3Iad4qpjixHmp78ujHQOygK
         yNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UJdzLFPEPPSSNUSmHlQ5Vfo+J9yTyV4ONJFREZVAKmE=;
        b=BQFIGqQd1eMxhC39YpIOU+xY/lfnDRoio5Y7czCLWsmGixjwvvEcWHQ9rnz4RVV084
         LMjJXjRyNYL5uc/5LAPj2hIQXbsULx1/8R4PiLynJbcVsDKlkRfEufy5MxTBYzBryT9i
         crm2dg3wcfI7IT1VkQnF5TIi/TBPZILLRWxSRgs67JcLxNWLcM+vPxH+FyBVd3QFpvPq
         A4ZYhv4NaL6dzo/FggQUMXI9kv0w9ZdRoefa/TjfSsqw3qTmc2GaddKtAhKCJNNZSMpE
         qzI796LyP1lKSK9b2uLwFsOoBm/W1KgMcI3jlUjFlkDDTJcTfeoJddtmd7kQuyaWr3xA
         xxZg==
X-Gm-Message-State: AOAM530hGeP1CVHnMvjiAP6ViDGho9kIsqNTZKSux8zXbxK035sPmUo/
        ipEutyyb1JhiBPLLFacFKptGyTEGGMY=
X-Google-Smtp-Source: ABdhPJxCTWScq28eRpXB70MMlTUjEuAyJVv42S8dkvwNGBqNmZE2PksqBYA1VmQzaw1sqxFktSesLw==
X-Received: by 2002:a4a:e589:: with SMTP id o9mr9382116oov.43.1627876220101;
        Sun, 01 Aug 2021 20:50:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 45sm1714664oty.16.2021.08.01.20.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 20:50:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 1 Aug 2021 20:50:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.14-rc4
Message-ID: <20210802035018.GA1851632@roeck-us.net>
References: <CAHk-=whv0g5YqoRXc8oxqJX3r+GP1dN3ia_Qg_V6UTjhi8vg8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whv0g5YqoRXc8oxqJX3r+GP1dN3ia_Qg_V6UTjhi8vg8w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2021 at 05:25:04PM -0700, Linus Torvalds wrote:
> Nothing to see here, entirely normal rc4.  It's mostly a very nice and
> flat diffstat - so small spread out changes - with the exception of a
> couple of blips in selftests and the xfs fixes.
> 
> Mostly drivers, some arch updates, networking, plus tooling and
> selftests. Nothing odd stands out.
> 

Same from the testing side of things.

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 474 pass: 473 fail: 1
Failed tests:
	arm:z2:pxa_defconfig:nodebug:nocd:nofs:nonvme:noscsi:notests:novirt:nofdt:flash8,384k,2:rootfs

Guenter
