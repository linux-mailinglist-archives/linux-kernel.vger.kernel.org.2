Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB77F33F6B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhCQRYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhCQRXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:23:45 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D7CC06174A;
        Wed, 17 Mar 2021 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=756FNXh3wyp4iGSQ0Wym7vrkxLt68O2cOQc/8Vzjk1c=; b=NNpm9IemQaBAl+8HACaU0KyN3I
        WRmnx3fKtQde8tT9bxJs5PyL57C6nczzP1tE/JU3CKeiYmfszdwUXqilyDw4QMTsNFchmdxt9ONUl
        8CkA0cY+0wTcnBtmpZ3dlrLlH0T3Xm9yCLWX3uaRrAVviu0FNIIPeND/3Ezc3l+AezxmMZaerbsVY
        czw90vmYIDujsK5DrHFkWHh321EZKuhVHR/JLT4Sbr/Wgymhf/LJvC2RNbc3jv7g3LXMgzFZRvB66
        hqEBoQAYcDl2mBFe5XHSrqZydoKZmRUmjST5MJeHdd0k/7YBjgOCLTgqqqQwXqqKSV9G7Yyn/eAI3
        kDIreCXg==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMZtX-001fOi-RH; Wed, 17 Mar 2021 17:23:44 +0000
Subject: Re: [PATCH V2] parisc: math-emu: Few spelling fixes in the file fpu.h
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210317110014.387321-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b72c28eb-1948-2fe5-06dc-9ea004e1b91c@infradead.org>
Date:   Wed, 17 Mar 2021 10:23:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317110014.387321-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 4:00 AM, Bhaskar Chowdhury wrote:
> s/synopis/synopsis/
> s/differeniate/differentiate/
> s/differeniation/differentiation/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>   Changes from V1:
>   As pointed out by jer, the sentence construction change inducted.
> 
>  arch/parisc/math-emu/fpu.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/parisc/math-emu/fpu.h b/arch/parisc/math-emu/fpu.h
> index 853c19c03828..b83da3d5b6d5 100644
> --- a/arch/parisc/math-emu/fpu.h
> +++ b/arch/parisc/math-emu/fpu.h
> @@ -12,7 +12,7 @@
>   *      @(#)	pa/fp/fpu.h		$Revision: 1.1 $
>   *
>   *  Purpose:
> - *      <<please update with a synopis of the functionality provided by this file>>
> + *      <<please update with a synopsis of the functionality provided by this file>>
>   *
>   *
>   * END_DESC
> @@ -50,9 +50,9 @@
>  #define EMULATION_VERSION 4
> 
>  /*
> - * The only was to differeniate between TIMEX and ROLEX (or PCX-S and PCX-T)
> + * The only change was to differentiate between TIMEX and ROLEX (or PCX-S and PCX-T)
>   * is thorough the potential type field from the PDC_MODEL call.  The

?        through
but the sentence construction is still difficult to read/parse.

> - * following flags are used at assist this differeniation.
> + * following flags are used at assist this differentiation.

                               to assist

>   */
> 
>  #define ROLEX_POTENTIAL_KEY_FLAGS	PDC_MODEL_CPU_KEY_WORD_TO_IO
> --


-- 
~Randy

