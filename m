Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519E545A23D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 13:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbhKWMOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:14:35 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56315 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234548AbhKWMOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:14:34 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4260F5C0115;
        Tue, 23 Nov 2021 07:11:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 23 Nov 2021 07:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=fSw5aG0aVUln7m0cxL8DCK/TNtz
        9LWAZ0LnI1ZqZ8tg=; b=dHa1eep+aWwq4vNHG+m7z5tF8roq5+4zE3jNky6dO34
        0nYUXL2gQWnmWdGd4GTc3NOeA4TgoBhpGKXUBopOCdArWH3+v36suOinl3YfC7gA
        4jya4Fp/FMi94S1BOXK2n4Pt5WkdaG0srEnXQcmgXEhpb0wnq/8cjYoG27zD29ED
        xn9ZOuigMgbdGQFAjAPf/4zkiCw7vj5xwf+WETV6XI/QuzXxuU6Ay/dcA5JEqTs9
        tuW9505g9B7pj7ABiry11qTDlSFuPk3rawsMDc7Ucl42YlwIc8wF/Cbl9D/gNvNE
        7X9jXneOsJvoiwqjnZitXKf8eNCsCFgFuQXO98cb6nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=fSw5aG
        0aVUln7m0cxL8DCK/TNtz9LWAZ0LnI1ZqZ8tg=; b=PpCO0AqaSoGMPwgfotpE27
        wi8RbmzSjlWrXCXU+c8Fi/KGCDJ/NPKMIhX+CyiQtmrnQKne9uQz381nG/UOzxoF
        lxAXAIYmrcrPTepGsnx9uGhTguzSdkrAcrOtaP5SiqAVZGEwjSEcoJn6pwoXt7St
        ++TnK5U8wEOsi7N2cC4sQfMrqmS58uAOgz4/GOwuSs8+y0Md5S/bV8yepcZSZt3e
        8EdA/g88J2kM65o5rYExxUCpYsRry/0gDX89MmyOVKVXA5usHDRIQjKhJVhO2oPN
        trQfcBD02A8zP6aKKhYGo9Sm83xX/xBdRMnAWUmxYswyZYHpzSjbEwnCi9fgCeWQ
        ==
X-ME-Sender: <xms:btqcYUm4JTe6feMhhyZJtjVUYxL5sN1PzDxm8JLo_etEjMDeX5pUoA>
    <xme:btqcYT0p49cJJE5qitH0Yhhf_GE-ogcoq-DMoL4GzFI86jFkgrlImd9Luy8WythoI
    VOZCQuRJhDVeA>
X-ME-Received: <xmr:btqcYSq1YeRHxjj_DDfgqa-n0u_pJBTWFrPHADAsuaylS2Q-mzrahStuModp02OWD0m3rpMm5pUCDpTO-xihH-AABOMtuJdE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepueelledthe
    ekleethfeludduvdfhffeuvdffudevgeehkeegieffveehgeeftefgnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:btqcYQlL-bl1-9Hcxs0YVpnYw0LbEmti8CDsMBlZWCufUN0i4KfpUg>
    <xmx:btqcYS3NHl-VfajeHVasppOKua82RndXjKN0oOkySO8avYqJ0gWLpQ>
    <xmx:btqcYXtm1tjS71rxO6xgXKrdL8PtVhLZ7Lc6Q7Z5l3kztL_iiK212g>
    <xmx:btqcYcrBhdgBtVw-fC_-amlRUx-XgQhJP_XryXgKMZjbTxRbDLDk1w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Nov 2021 07:11:25 -0500 (EST)
Date:   Tue, 23 Nov 2021 13:11:23 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     stable-commits@vger.kernel.org, rostedt@goodmis.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: Patch "tracing: Add length protection to histogram string
 copies" has been added to the 5.4-stable tree
Message-ID: <YZzaazoMzw8eANyR@kroah.com>
References: <20211121231943.88009-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211121231943.88009-1-sashal@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 06:19:42PM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     tracing: Add length protection to histogram string copies
> 
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      tracing-add-length-protection-to-histogram-string-co.patch
> and it can be found in the queue-5.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 0a0e233a0c25593f817b6d9ed48fb2d2fd080870
> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Date:   Sun Nov 14 13:28:34 2021 -0500
> 
>     tracing: Add length protection to histogram string copies
>     
>     [ Upstream commit 938aa33f14657c9ed9deea348b7d6f14b6d69cb7 ]
>     
>     The string copies to the histogram storage has a max size of 256 bytes
>     (defined by MAX_FILTER_STR_VAL). Only the string size of the event field
>     needs to be copied to the event storage, but no more than what is in the
>     event storage. Although nothing should be bigger than 256 bytes, there's
>     no protection against overwriting of the storage if one day there is.
>     
>     Copy no more than the destination size, and enforce it.
>     
>     Also had to turn MAX_FILTER_STR_VAL into an unsigned int, to keep the
>     min() comparison of the string sizes of comparable types.
>     
>     Link: https://lore.kernel.org/all/CAHk-=wjREUihCGrtRBwfX47y_KrLCGjiq3t6QtoNJpmVrAEb1w@mail.gmail.com/
>     Link: https://lkml.kernel.org/r/20211114132834.183429a4@rorschach.local.home
>     
>     Cc: Ingo Molnar <mingo@kernel.org>
>     Cc: Andrew Morton <akpm@linux-foundation.org>
>     Cc: Tom Zanussi <zanussi@kernel.org>
>     Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>     Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
>     Fixes: 63f84ae6b82b ("tracing/histogram: Do not copy the fixed-size char array field over the field size")
>     Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

This commit causes a bunch of build warnings, so odds are the backport
is incorrect.

I'll drop it from the 5.4.y queue now.

thanks,

greg k-h
