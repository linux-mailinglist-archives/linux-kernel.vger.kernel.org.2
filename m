Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BA13F0B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 20:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhHRS3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 14:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhHRS3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 14:29:51 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF65C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 11:29:16 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Gqbyf5wZdzQkj1;
        Wed, 18 Aug 2021 20:29:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received; s=mail20150812; t=
        1629311351; bh=8yFvBMUga1EVpv+SYC9LNVr5Eqe0h/P1ceZIwCgztko=; b=H
        hs1DQWIWzQpPNrWc4uZDBALlXRB2UfeUCeS7pwpRXEXQ4v12/XxQe1ob8fGvZRIx
        swsVdx0M5ZTYYYZEHcU1dxxM0/+W0cIK7GN0OUVXpvkMD+Dlhr5xWXUMtRPtJ17J
        B8Q5fE7ErRU4szS4z03dqKtxB/XWJH5ZmX50zNG1AESKmT9eSeT6NnTwTpdWNxse
        iGjTj7HlHUaWjRZnEFHqIpNMlxhSWwiYdQ7icJiudtBxidqPIw6NEvgum+oPwtOQ
        1tzc4tPHwnEsbHI01Yj5k8vfMU2+OvToSYhRCM6x/uHtOiOFUkspzzEM0yCTOI36
        ETI2+S9z6ss4zbBLPQTkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1629311353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w5sdReL5aVMcQw1mZdSVeTxvGoot/SnqNO7EPVVP9pM=;
        b=KsPfb/oJRLypSlQq1BqBLXOXbp2JrqappFzk0Aq6wYVUZWzm+lGDV21sNMsU5cbHM7qc7w
        dioyCpdCcpN7OWRevU2s+b6kjNyYXQ5IO72um0YkhhatVTU08S06zs4M3nCTOSQFK9+Il/
        Apm4e/Ghs5icspd1fpISLEHK8pf7p1S2nzU0VFbblGMawNzpyHhEME56qQMGpJhQqqYUgw
        hNBoNBXEemZSHRIMo1bUxWn7RCchZ5Lbrjp7UNQ9n4vZmeC8tYkUj4nCl1tnR4Q+AnxAjI
        ufC5J4g51WB9eot+zddTi2t00DI5snCkK/GikrpLb5qfeJMOea9/3cyvpDj+hQ==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id VlfYjx7ppfLM; Wed, 18 Aug 2021 20:29:11 +0200 (CEST)
Subject: Re: [PATCH 2/2] x86, Makefile: Add new generic x86-64 settings
 v2/v3/v4
To:     Borislav Petkov <bp@alien8.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "graysky@archlinux.us" <graysky@archlinux.us>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
References: <269701460.117528.1629210189833@office.mailbox.org>
 <796036867.117557.1629210288168@office.mailbox.org>
 <YRwBs89eogLJEiRn@zn.tnic>
 <1708009975.124311.1629299321026@office.mailbox.org>
 <YR1KDD/azm1IDr9u@zn.tnic>
From:   Tor Vic <torvic9@mailbox.org>
Message-ID: <25f1e81a-84f7-e63c-2989-cd4fddd695e7@mailbox.org>
Date:   Wed, 18 Aug 2021 18:28:47 +0000
MIME-Version: 1.0
In-Reply-To: <YR1KDD/azm1IDr9u@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DC5BD1813
X-Rspamd-UID: 643fc7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.08.21 17:59, Borislav Petkov wrote:
> On Wed, Aug 18, 2021 at 05:08:40PM +0200, torvic9@mailbox.org wrote:
>> I ran some quick checks and benchmarks, and your doubts seem to be
>> justified. A 5.14-rc6 kernel compiled with the default 'generic' and
>> one built with 'x86-64-v3' even have the exact same uncompressed file
>> size. Benchmarks were inconclusive as well.
> 
> Lemme preface this with a IMHO:
> 
> Yeah, those -march machine-specific compiler switches don't really
> show any perf improvements for kernels because, well, if you look at
> the instruction stream a kernel executes, there's not really a whole
> lot left to optimize after -O2.
> 
> Also, the percentage of time a machine spends in the kernel should be a
> lot smaller (orders of magnitude) than in userspace - the operative word
> being *should* here :-) - so there really isn't anything to optimize.
> 
> Not to say that there aren't a gazillion other places in the kernel that
> could use more eyes and testing. ^Hint hint^

That's something I'd like to help with, hence my (not very good)
submissions.
You're one of the kernel colonels, so I'm happy to get some *useful*
feedback which enables noobs like me to get a better understanding of
the kernel stuff.
Also, credits to graysky because this is actually based on his work.

> 
> Thx.
> 
