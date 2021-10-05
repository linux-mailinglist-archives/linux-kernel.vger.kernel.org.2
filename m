Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B554F422C34
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhJEPVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhJEPU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:20:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAC9C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 08:19:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633447145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F0jteui4C6o0n+swDYTpF6sOj/mmEYS1bk4mq9FjiP4=;
        b=DeUb9vQkV0wiNp495ETKeWOcKBMgsVqpWPJzT9DjdZXjWhYTT1NuI6wX5zuRdSVVkPZcD6
        vahBakH5S/DndLIPfTDbDkEvyRwj305Uvt44uT32CPVAtJFm+ECJO1YDGA8hRKK8cgOkMs
        XjdLT65kf7IYrKEHG0sDkXdLoWwofKZbowZeqCONfqd3hCqH4BRbWSlN2HRkD6WYk0+wnc
        e6MCTOrW28hk51oS8Ld/EiSBbzyddo1vH5ZO9lkrHKmGNhbr+7laFVHk2N2ohvtoCmU7cn
        eRfLwESRSRIu9QeQ82RkNPjVUvJ8g7l/UiD2sGsIDoR+uyi6V/AUPKevzf08pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633447145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F0jteui4C6o0n+swDYTpF6sOj/mmEYS1bk4mq9FjiP4=;
        b=CjNa9TDULa5Nb1xmArNOlDqsBkhq6px6YRQX+tyjs3PDcPsONW8G/pd9MBejSa/enhgihl
        yW+3ERdzphUdkzAw==
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
Date:   Tue, 05 Oct 2021 17:19:04 +0200
Message-ID: <87zgrnebyv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01 2021 at 15:37, Chang S. Bae wrote:
> @@ -1252,6 +1267,13 @@ long do_arch_prctl_state(struct task_struct *tsk, int option, unsigned long arg2
>  		if (!state_perm)
>  			return 0;
>  
> +		/*
> +		 * Disallow when sigaltstack is not enough for the
> +		 * AT_MINSIGSTKSZ value.
> +		 */
> +		if (tsk->sas_ss_size > 0 && tsk->sas_ss_size < get_sigframe_size())
> +			return -EPERM;

This is not enough:

T1
sigaltstack(minsize)
...
                            T2
                            libinit()
                            prctl(....) --> success
                            enable_amx()

libfunc()         
  if (amx_enabled())
       AMXINSN
       -->#NM --> success

handle_signal()
   die(because altstack too small);

Thanks,

        tglx
