Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2990E4226AB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhJEMcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbhJEMcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:32:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0878BC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 05:31:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633437057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ClrkHpxeJ2vrGOGoxNsVWG6LPS4ZmVM+He32WeK4u+U=;
        b=uPejHUkNLPlpqT7Ho9gkIo/3XKS0oWeNAY2vYjTEVBl/5tPDE/OARncRPCf31lx/R1w/ca
        ePv4E0gYlWuqe1clzh8cpX4nHPrL1vemvxKLtxfJOgzF1eNnyOD779qu4pKpzAclMWPajE
        M9bZYEW2QBFqehegXiz2KOUq4Igecto59z7e58LiQsAPhFC025sV6DQol2L6+4u/o5GAgr
        eGovn2uWz9JH+hsN7BrvKWnp+7H+g+hD6+xNoAfKuhMAHaZBWt74dZyrCZNHxRdABX9U0Z
        gD2Vvr188EktRCUIz/erxvf4PhXD/U4Yfbu2k77lrIGzfbGavz9T+dE5zWufFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633437057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ClrkHpxeJ2vrGOGoxNsVWG6LPS4ZmVM+He32WeK4u+U=;
        b=W2+epc98dd4BKqD/YsgrlWAyzMS1JpWSNCoD3wl5uaQ/IDQ+uab007q1RfrHhSYI2hmbbR
        U9mEI2DCFb1OqXBg==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v11 16/29] x86/fpu/xstate: Support both legacy and
 expanded signal XSTATE size
In-Reply-To: <20211001223728.9309-17-chang.seok.bae@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
 <20211001223728.9309-17-chang.seok.bae@intel.com>
Date:   Tue, 05 Oct 2021 14:30:57 +0200
Message-ID: <875yubfybi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01 2021 at 15:37, Chang S. Bae wrote:
>  static int
>  do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
>  		size_t min_ss_size)
> @@ -4187,6 +4192,9 @@ do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
>  				return -ENOMEM;
>  		}
>  
> +		if (!arch_enough_sigaltstack(t, ss_size))
> +			return -EINVAL;
> +

How is this even remotely correct?

sigaltstack(2):

  To disable an existing stack, specify ss.ss_flags as SS_DISABLE.  In
  this case, the kernel ignores any other flags in ss.ss_flags and the
  remaining fields in ss.

So for SS_DISABLE ss_size can be legitimately 0 or any other random
number smaller than the required stack.

The min_ss_minsize check is conditional for this very reason.

Thanks,

        tglx


