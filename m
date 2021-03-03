Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32AA32C224
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387794AbhCCTdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhCCTTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:19:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4A2C061760
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 11:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xNHVvSOiwu0gdh2AIWAUrU6rrldyiQSnTyaZvWwrYoQ=; b=daiARPK0qkkWAlz5XQ0llvwfbe
        h/Yzg+cSBJ/hXnYBGvYcrQFTwWcYKWg25aedsth+JJHLKbQM/w5TqlFvMeEFuJ6gByKC7Iea+7nAV
        4MWulAC+7W830hcKEplMoBOrSqRpiV7xyo2jMpGEFAwhUnjdXEykff0wudYv4qstmLCz8FG+JR1r7
        o/ySBooksd2n1/DDc2s6B7998cUBINFyEl/t7piQJvaltjays7e/0gTekd4zOhq3C3OxiIChYWITb
        M52kMLmUSRJkm1RIRe6brbr97ZIXheZa+4OlF8shznxtQEVBkBtlct2DqdF0Dis5P3DSVivp5SAJ6
        hiRQwNgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lHX0D-006B1E-BZ; Wed, 03 Mar 2021 19:17:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 83D953017B7;
        Wed,  3 Mar 2021 20:17:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4336B23662BF9; Wed,  3 Mar 2021 20:17:44 +0100 (CET)
Date:   Wed, 3 Mar 2021 20:17:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, jpoimboe@redhat.com,
        ycote@redhat.com
Subject: Re: [RFC PATCH v2 00/13] objtool: add base support for arm64
Message-ID: <YD/g2G3Yi8o99f7H@hirez.programming.kicks-ass.net>
References: <20210303170932.1838634-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303170932.1838634-1-jthierry@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 06:09:19PM +0100, Julien Thierry wrote:
> Hi,
> 
> This series enables objtool to start doing stack validation on arm64
> kernel builds. 

> -->
> 
> Julien Thierry (12):
>   tools: Add some generic functions and headers
>   tools: arm64: Make aarch64 instruction decoder available to tools
>   tools: bug: Remove duplicate definition
>   objtool: arm64: Add base definition for arm64 backend
>   objtool: arm64: Decode add/sub instructions
>   objtool: arm64: Decode jump and call related instructions
>   objtool: arm64: Decode other system instructions
>   objtool: arm64: Decode load/store instructions
>   objtool: arm64: Decode LDR instructions
>   objtool: arm64: Accept padding in code sections
>   objtool: arm64: Handle supported relocations in alternatives
>   objtool: arm64: Ignore replacement section for alternative callback
> 
> Raphael Gault (1):
>   objtool: arm64: Enable stack validation for arm64


These patches look very reasonable to me,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>


One selfish thing, would it make sense to have a make target that builds
all supported srcarch targets?

This might be useful when hacking on objtool to make sure everything
builds.
