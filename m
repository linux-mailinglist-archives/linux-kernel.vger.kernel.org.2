Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41A9363023
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbhDQNCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 09:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbhDQNCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 09:02:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D344FC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 06:01:54 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id s7so29162462wru.6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 06:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+v8KSkqN0pv8xQKlIzIRV3KVCzjduD2sMPQGi6ecTqs=;
        b=iSHsdL+1b5IJMiBkkyJ43fDzFp4eqt2VC/FIVFd35ffURyzH/YtSsNwcshHwZmgr4i
         +wbr7XqE+qLBi8tgYX5V7UembUxWa693Y0AXLicpkEwM+1d+X2J16gVN73vXeyG7Opfi
         yWT2TkeqOpuLE1PZkXrlTMug5YrcR/bCF0sHEuKlJc8r2Qc01UMk2MKs7HCrkryabifH
         SrI8vuyKaBvMsSR91M9H+F77FUfzO1DfEq/r5SOATctwqbLXNcc9bCKMIq/JfBDlrsws
         OmW1Ip6Bg5SHikFLsQ+gg8JavMR+rNzEZ7/TGTURN9Cbw9c7XNrni3h4BPd13QLrtDh/
         Tsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+v8KSkqN0pv8xQKlIzIRV3KVCzjduD2sMPQGi6ecTqs=;
        b=R6M43Y4aaPU5yQOlMNG0k9dKvPxw5YbCd/9rmeFCNZ7C/kzMOZOMtD0BaNB2is6jwL
         lixVO6zmSW3yzTTqsumXdMQ3/X6ESUW3QG2bPWPdD9zYbbWjUPivuyPNbs2TM2e91m2Z
         unBPvikw7NUNtTTkFY/KBXzfx4ieKiG1ZEowlYZxJXo3Ha4m+81Y3/15OL5Su+SzPgNW
         Oxej0HBjQVmKyShYPsIrqPi/fNxcpSIx7wwc0tQn3sNNa3nvLs/S/WAyAE6ru7zdQcOr
         o0d70gH9DXdxWpqUwYCVIxVmYCExfWhIE9Pi5VWTZALTQEF0FR7Es3Tu9vvTKTGI11Dw
         E8Ig==
X-Gm-Message-State: AOAM532QaIHtfZuMO/OOYHg3Jmpd82wOqtD3BW9boehcELTTEnMx2bMM
        OAYm3faEUpTlDWuIeSeaTXBb
X-Google-Smtp-Source: ABdhPJyDfR4fjAMTEqH2LV4RuPCRUIXQBxsqKNB76GScQRsrULmyLXoLGb7y/HQhJapPFyholtlnGA==
X-Received: by 2002:a05:6000:1449:: with SMTP id v9mr4307725wrx.295.1618664513253;
        Sat, 17 Apr 2021 06:01:53 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:209:3c1c:8462:b77e:21a4])
        by smtp.gmail.com with ESMTPSA id l9sm14433449wrz.7.2021.04.17.06.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 06:01:52 -0700 (PDT)
Date:   Sat, 17 Apr 2021 14:01:48 +0100
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Peter Zijlstra' <peterz@infradead.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] [RFC] Rust support
Message-ID: <YHrcPOLJBq593z6P@google.com>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <YHlz54rd1YQHsOA/@hirez.programming.kicks-ass.net>
 <YHmMJWmzz2vZ3qQH@google.com>
 <YHmc2+bKQJ/XAATF@hirez.programming.kicks-ass.net>
 <39b8cbb2cfba4a5ba913311cb2448f50@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b8cbb2cfba4a5ba913311cb2448f50@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 12:41:23PM +0000, David Laight wrote:
> Or the cases where the locks are released in the 'wrong' order.
> Typically for:
> 	lock(table)
> 	item = lookup(table, key)
> 	lock(item)
> 	unlock(table)
> 	...
> 	unlock(item)

This is expressible in Rust with something like:

    table = table_mutex.lock()
    item = table.lookup(key).lock()
    drop(table)
    ...
    // item will be unlocked when it goes out of scope or on drop(item)

The added bonus here from Rust is that table is not accessible after
drop(table), so a developer cannot accidentally access fields after unlocking
it.

> 
> (In the kernel the table lock might be RCU.)
> 
> Or, with similar data:
> 	write_lock(table);
> 	foreach(item, table)
> 		lock(item)
> 		unlock(item)
> 	/* No items can be locked until we release the write_lock.
> 	...
> 	unlock(table)

I think I'm missing something here. Would you help me understand what part is
out of the ordinary in the code above? It would be expressible in Rust with
something like:

    table = table_mutex.write();
    for (item_mutex in table)
        item = item_mutex.lock
        // item is unlocked at the end of the loop iteration (out of scope)
    // table gets unlocked when it goes out of scope

Cheers,
-Wedson
