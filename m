Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611663FFED1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348539AbhICLRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:17:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43394 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348353AbhICLR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:17:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4116A203B3;
        Fri,  3 Sep 2021 11:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630667788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SQ370L2iYUQdkHmIR8ksIxVZX+RkzFDROYt4rIFYKkk=;
        b=ZgbPDYy9VglByp4K7Zfg8M+5pXBM+9eti3i/8GpWUDVJlmcXNU2uqsdG1w9ektaL5/a8tO
        mOdkp1UA/CprdslCa/2QiHAmsAOmHx4JALy8/DjFN4oK/WwsON1BqwMcetYF3EDXOdGsU1
        83h8f9gZNI6mUbku/xrfzbPtxCqck9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630667788;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SQ370L2iYUQdkHmIR8ksIxVZX+RkzFDROYt4rIFYKkk=;
        b=7NEfa0txL6X8ITBe5imd5gMDikPqzA7ugYapfFhhNq0g75/s25h47X19xMie6aD9zz8LRk
        ecTUza4117up+ZCQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2E4AFA3B8B;
        Fri,  3 Sep 2021 11:16:28 +0000 (UTC)
Date:   Fri, 3 Sep 2021 13:16:28 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Andy Lavr <andy.lavr@gmail.com>
Subject: Re: [PATCH v3 0/2] objtool: altinstructions fix and cleanup
In-Reply-To: <20210822225037.54620-1-joe.lawrence@redhat.com>
Message-ID: <alpine.LSU.2.21.2109031316200.7852@pobox.suse.cz>
References: <20210822225037.54620-1-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2021, Joe Lawrence wrote:

> This version won't eat your memory and swap when building the entire
> kernel.  Apologies to Andy who discovered this over the weekend.
> 
> Tested full build and boot w/o problem.  The vmlinux sections, relocs,
> size, etc. all appear to be the same before and after this set.
> External tooling (kpatch-build) is happy, too.
> 
> v3:
> - fix bug introduced in arch_decode_instruction() [andy]
> 
> v2:
> - drop the sec->len update from the first patch [josh]
> - rip out sec->len as suggested [josh]
> 
> 
> Joe Lawrence (2):
>   objtool: make .altinstructions section entry size consistent
>   objtool: remove redundant len value from struct section

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
