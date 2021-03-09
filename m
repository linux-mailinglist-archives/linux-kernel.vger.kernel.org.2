Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D593330B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhCIVPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbhCIVPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:15:32 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4FCC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 13:15:32 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e2so2008750pld.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 13:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dnLdM6V19dYuJ5oWXUJHk+YsPLsfZioKwGopMLufT4w=;
        b=RsyKUaD5iS2WQePCyWDtH+L7M3aHuWLu7s+Q/o+EJ5wHgWtebAb5PjPQSJK0/rS85s
         ZP93aCOCPQxWLkUDEBO5CgCHLxYogUsKW48GleN5CDCn5a05zbURHIjTcsxzhb8y8R+T
         +77B8y4sTr0TjHgTNEKthIAF4iiBhL1h91VSl2yux5zH19vo3HYtA08npg6DqQ475Pdn
         VwOLTCeWEDl66DMONuGnnW65+erlBkUTXUpCtYeubdJYxJJczQQ0ixUeqARzY0h1Nzoh
         IyKGsE1mq2G0ujt3SJal7fK0YbvE3Pi5MicUZftDcK8TlXe5YI5y4LUGgNbtxD32pRR4
         lgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dnLdM6V19dYuJ5oWXUJHk+YsPLsfZioKwGopMLufT4w=;
        b=daAdXqbqvxcB0q6kTdwqhNgpAdV2pwpDcdU0Itsrm6WIsfjdJ1wOh+2YpBkvf/4jf5
         cF3lQ2jtOrWS1wX64F/sOZiiMxBNxH+7jM1iQ7SCOFPOV7Cm9yr78PGjSP5CTsLGDim9
         0xqJhYqpBdS9w9rx7gVjnMlbGwsPvxZJQV8aZxHCvoUxsyYVguNtPdgKzuq1gyj2aA6S
         Fkax8iQPBjCJcrtDinE55+xiI3yXdiVTQupGTGjN+j9ygJrO9oYbwgyf8AzdE35EfYCy
         OjcUZU83Br/kyNYpD3+DyuJkBQ0mYF/1VAqLkeEBzUT2aapbxmjqaQSLhV5MNRUSorOl
         e34A==
X-Gm-Message-State: AOAM533gI4auESXb9qiXRYXxDzH0fPMvwDdGUHADeiAC8xClZnERPrmn
        /O72Rr1yZL+F8t/WqCbLmGq7ug==
X-Google-Smtp-Source: ABdhPJxoXav81vfvIgM8zkp5ggAGnMiap5MCh48ZexB2xFcuGhIiCeyQ5sDHMIYX3XLO18knNOCUMw==
X-Received: by 2002:a17:90a:8813:: with SMTP id s19mr6538514pjn.94.1615324531902;
        Tue, 09 Mar 2021 13:15:31 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:e577:9d57:1fab:6e0b])
        by smtp.gmail.com with ESMTPSA id 82sm13602154pfv.19.2021.03.09.13.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:15:31 -0800 (PST)
Date:   Tue, 9 Mar 2021 13:15:27 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH v2 1/2] Makefile: Remove '--gcc-toolchain' flag
Message-ID: <20210309211527.us52fgxdzpf25xzw@google.com>
References: <20210302210646.3044738-1-nathan@kernel.org>
 <20210309205915.2340265-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210309205915.2340265-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-03-09, Nathan Chancellor wrote:
>This flag was originally added to allow clang to find the GNU cross
>tools in commit 785f11aa595b ("kbuild: Add better clang cross build
>support"). This flag was not enough to find the tools at times so
>'--prefix' was added to the list in commit ef8c4ed9db80 ("kbuild: allow
>to use GCC toolchain not in Clang search path") and improved upon in
>commit ca9b31f6bb9c ("Makefile: Fix GCC_TOOLCHAIN_DIR prefix for Clang
>cross compilation"). Now that '--prefix' specifies a full path and
>prefix, '--gcc-toolchain' serves no purpose because the kernel builds
>with '-nostdinc' and '-nostdlib'.
>
>This has been verified with self compiled LLVM 10.0.1 and LLVM 13.0.0 as
>well as a distribution version of LLVM 11.1.0 without binutils in the
>LLVM toolchain locations.
>
>Link: https://reviews.llvm.org/D97902
>Signed-off-by: Nathan Chancellor <nathan@kernel.org>

The wording looks good.

Reviewed-by: Fangrui Song <maskray@google.com>
