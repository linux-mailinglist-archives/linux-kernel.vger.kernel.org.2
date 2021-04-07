Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF02356BB3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351980AbhDGMCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbhDGMCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:02:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FFFC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 05:02:37 -0700 (PDT)
Received: from zn.tnic (p200300ec2f08fb0043d828d1ba5b6809.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:fb00:43d8:28d1:ba5b:6809])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9BD981EC0288;
        Wed,  7 Apr 2021 14:02:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617796955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FH2Q5rVpM1/neojk900lZ6GLJs64ZVvXVp6ndMfzNog=;
        b=YZ+sDJ/z1K0fJ5REDh2DL0vcqBn6Lk5oCgjRL1KmEwsi94Eq8kadvB99WZkhUWmYY2trMw
        a9T8IDUhW4h6gxQ8P6lyZ114uKQ6n9iYvT81dy3rRoSy/4wr8DQ5dZgR7xcYg7E3kmHeWd
        0MZZRnvkKwYwwg1fP6zwqp0VT6Qe2FY=
Date:   Wed, 7 Apr 2021 14:02:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86/kernel: remove unneeded dead-store initialization
Message-ID: <20210407120239.GD25319@zn.tnic>
References: <1617177624-24670-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1617177624-24670-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 04:00:24PM +0800, Yang Li wrote:
> make clang-analyzer on x86_64 defconfig caught my attention with:

I can't trigger this here using:

make CC=clang-11 -j16 clang-analyzer

I get all kinds of missing python scripts:

multiprocessing.pool.RemoteTraceback:
"""
Traceback (most recent call last):
  File "/usr/lib/python3.9/multiprocessing/pool.py", line 125, in worker
    result = (True, func(*args, **kwds))
  File "/usr/lib/python3.9/multiprocessing/pool.py", line 48, in mapstar
    return list(map(*args))
  File "/mnt/kernel/kernel/linux/./scripts/clang-tools/run-clang-tools.py", line 54, in run_analysis
    p = subprocess.run(["clang-tidy", "-p", args.path, checks, entry["file"]],
  File "/usr/lib/python3.9/subprocess.py", line 501, in run
    with Popen(*popenargs, **kwargs) as process:
  File "/usr/lib/python3.9/subprocess.py", line 947, in __init__
    self._execute_child(args, executable, preexec_fn, close_fds,
  File "/usr/lib/python3.9/subprocess.py", line 1819, in _execute_child
    raise child_exception_type(errno_num, err_msg, err_filename)
FileNotFoundError: [Errno 2] No such file or directory: 'clang-tidy'
"""

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/mnt/kernel/kernel/linux/./scripts/clang-tools/run-clang-tools.py", line 74, in <module>
    main()
  File "/mnt/kernel/kernel/linux/./scripts/clang-tools/run-clang-tools.py", line 70, in main
    pool.map(run_analysis, datastore)
  File "/usr/lib/python3.9/multiprocessing/pool.py", line 364, in map
    return self._map_async(func, iterable, mapstar, chunksize).get()
  File "/usr/lib/python3.9/multiprocessing/pool.py", line 771, in get
    raise self._value
FileNotFoundError: [Errno 2] No such file or directory: 'clang-tidy'
make: *** [Makefile:1914: clang-analyzer] Error 1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
