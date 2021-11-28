Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2420646055A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 09:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356973AbhK1Izz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 03:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhK1Ixz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 03:53:55 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5BDC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 00:50:39 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id b11so11393978qvm.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 00:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i/rgc14+nl9t1mKCsps2mm2eEfnCBTVLhO2reor56kw=;
        b=ebHJPrNhdgTbUa/82G8139REymNUsBg0BQLv/nNpUfBh5zLHflo5VfPXtEsdVoxxhg
         pbgRKNWE8QaGURGLpGpXni9C6I9OV2qFtykypOaXO4L4QFjFKVtN1GkwBRGvxnDSoONI
         H1nPIHIdyiLcLZOvNjH0SnqkPhcFUk3pFaIxPnzv2p2PdNWWIo0YdlwdL7Y2XRC/iWhS
         GjZ5WMB/09T4LZ1F/TDKa9U7t+nO3hidivWGOqyOLJqn1jtvrQjk6G2Q5PK8OoKfQeR9
         LqVzIjR5xUg7irHA8RmvedZK92Jp04UnCwznhm8S6Thc0rnD998ktK/hMtCMvXmkwAs6
         q26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i/rgc14+nl9t1mKCsps2mm2eEfnCBTVLhO2reor56kw=;
        b=gdnlgb/vbSxlwqHwSx9KddT/INi42U0/CwHsJweEB0p7Ev9ZilAU1XMYJ+HrkH7Qg2
         kuegVf642fX9z1Q3XjA71Powc84JB+zWKnBcPOw5VC368EWaK86FcagQEtiikOqgylEq
         lLX7IiCM4uNSU8MYIeXAIsvdiKcwqdY/p/LONhOT7ZTl0FGB3oMvLTeX8FujTHuowzVE
         +h3UMrtnMHk1un3vGnqNp3wt3MALGiIFOqOZXdqfbNch5wbSzUT5D1rZCd/BO1iosbtv
         Wthm21aUFe6POmbQeidmGor8UXNFXJ3OTyOb1JJ1tWvePYj9c1lbBM1kncFKITSaXUFo
         YBYA==
X-Gm-Message-State: AOAM532HRF8DWanYAHxEW3RDUt7qWw93pwqiU2CQH5mvDOrITxv2h9Wj
        73Ezw5Ynblu1V3rfEjRvJHU=
X-Google-Smtp-Source: ABdhPJzuZzEbCDt2rtstTH6e0S0NJAS70+4miRBmM1ff/QLtZOICk8qiGC3Qc9UmXwaaUlEEAkHoQg==
X-Received: by 2002:a05:6214:260d:: with SMTP id gu13mr23908963qvb.89.1638089438559;
        Sun, 28 Nov 2021 00:50:38 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id m19sm6571823qkn.129.2021.11.28.00.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 00:50:37 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id D8FC727C005A;
        Sun, 28 Nov 2021 03:50:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 28 Nov 2021 03:50:36 -0500
X-ME-Sender: <xms:3EKjYY5TUdTzULAbfr4uFnW6h1y2tp-YJSJ96Wz_UUxFmS88VO7XfA>
    <xme:3EKjYZ5DkOqWq6P262rtbippurSphysDit3ejWuJK19xMpB_YivQQ2sYtNTJfSdXF
    X5SKIzBWLKBf5_okw>
X-ME-Received: <xmr:3EKjYXcWNc2m41I3uMEExDXIlfn5AL03K33asoeubbivIx3auSdSX5FlFEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrheehgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:3EKjYdLmYD4chsZRC90oEiDYhC70a0tWPiucoZeuFKWPRgiaTVTZ-Q>
    <xmx:3EKjYcK3fsAskSsXw3fvJ6gzDbyFtDh74mGgwmo7yksb_QzvYcp0og>
    <xmx:3EKjYewly_LfVd1mKVXav9OhmMVf5j5HbuDI4Q0AXaxRW3PCDUaPVg>
    <xmx:3EKjYWg_nhPGm34D2l0C2jd1DSoVE2n1w64LYMbhJDPQelWR6RHkIg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Nov 2021 03:50:35 -0500 (EST)
Date:   Sun, 28 Nov 2021 16:49:41 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, arnd@arndb.de,
        lkp@intel.com, will@kernel.org
Subject: Re: [PATCH] locking/atomic: atomic64: remove unusable atomics
Message-ID: <YaNCpSv67gS6ILEb@boqun-archlinux>
References: <20211126115923.41489-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126115923.41489-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 11:59:23AM +0000, Mark Rutland wrote:
> The generic atomic64 implementation provides:
> 
> * atomic64_and_return()
> * atomic64_or_return()
> * atomic64_xor_return()
> 
> ... but none of these exist in the standard atomic64 API as described by
> scripts/atomic/atomics.tbl, and none of these have prototypes exposed by
> <asm-generic/atomic64.h>.
> 
> The lkp kernel test robot noted this results in warnings when building with
> W=1:
> 
>   lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_and_return' [-Wmissing-prototypes]
> 
>   lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_or_return' [-Wmissing-prototypes]
> 
>   lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_xor_return' [-Wmissing-prototypes]
> 
> This appears to have been a thinko in commit:
> 
>   28aa2bda2211f432 ("locking/atomic: Implement atomic{,64,_long}_fetch_{add,sub,and,andnot,or,xor}{,_relaxed,_acquire,_release}()")
> 
> ... where we grouped add/sub separately from and/ox/xor, so that we could avoid
> implementing _return forms for the latter group, but forgot to remove
> ATOMIC64_OP_RETURN() for that group.
> 
> This doesn't cause any functional problem, but it's pointless to build code
> which cannot be used. Remove the unusable code. This does not affect add/sub,
> for which _return forms will still be built.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/r/202111120712.RtQHZohY-lkp@intel.com
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

FWIW

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>  lib/atomic64.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/lib/atomic64.c b/lib/atomic64.c
> index 3df653994177..caf895789a1e 100644
> --- a/lib/atomic64.c
> +++ b/lib/atomic64.c
> @@ -118,7 +118,6 @@ ATOMIC64_OPS(sub, -=)
>  #undef ATOMIC64_OPS
>  #define ATOMIC64_OPS(op, c_op)						\
>  	ATOMIC64_OP(op, c_op)						\
> -	ATOMIC64_OP_RETURN(op, c_op)					\
>  	ATOMIC64_FETCH_OP(op, c_op)
>  
>  ATOMIC64_OPS(and, &=)
> @@ -127,7 +126,6 @@ ATOMIC64_OPS(xor, ^=)
>  
>  #undef ATOMIC64_OPS
>  #undef ATOMIC64_FETCH_OP
> -#undef ATOMIC64_OP_RETURN
>  #undef ATOMIC64_OP
>  
>  s64 generic_atomic64_dec_if_positive(atomic64_t *v)
> -- 
> 2.30.2
> 
