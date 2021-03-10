Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1516334B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhCJWcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhCJWb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:31:58 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6658BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:31:58 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t85so7844984pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=hFim9dkS8C3QxvTFiRW3MvtmWdJpYNlf+TdshQOA3p8=;
        b=oNx1F/ZXBU5DoNZi0gi9oZs+OUtq0c5CiwIvx2Xtgg8JIFKhJIWoHXNV0rxwVWOqGp
         xgF5c6B7APykTL9Jevyb/W2pkPzn9YoA3iptUjmraTsuT3CbEJtyzPA8zCg8qrXnofaf
         3aPCAiWoL6makbA9cZ/wcQgklPSblzmO2HoOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hFim9dkS8C3QxvTFiRW3MvtmWdJpYNlf+TdshQOA3p8=;
        b=eBdHUmEJHKNlPec+kAkxjlWthcM6jrVEZ9DjbloOl3M+r6jYSsNBA9SCt7mdhzfsxf
         VwSIHAObw8LcR4drg+4I1WMyN5JkJR81wa1uuOvzWejGPAP36zeyDwS2a1U76eZJnQlf
         s+Yzu+JaiCEW6VR7ZptYzV3VS4FHk4UYGEGseA122LF1ILzAm8X/Gs8SOal58Ol1OCrz
         MVcXJmHmwn28lBAbxvc9+quOIj/+RCF6F0zjazpJMlrw3vWNP0rh6aRCjeooea5hnCe9
         0HLCC6HKO0ZbcDOUM3g0BDyDU6OMrCMXhn36VBMVYqcd5aRjGxnH/f56GxzQW+7BcB6x
         Iykw==
X-Gm-Message-State: AOAM531n9+l2BzvNaCcrU2foC+NjEbMGr1iwZa1LTQniGEHwYaiIidLR
        3V3EIaRA7+Cj875Uj0Ob8vHHwQ==
X-Google-Smtp-Source: ABdhPJzh7LdOpcpB5ryAVE/3HXNh9RhypK5KTZN9NrdH90NdTRRG1v0rMGaSsKbFryjsERtgjSaNLg==
X-Received: by 2002:a63:db57:: with SMTP id x23mr4596264pgi.432.1615415517703;
        Wed, 10 Mar 2021 14:31:57 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-0e28-c46d-f4e0-67e7.static.ipv6.internode.on.net. [2001:44b8:1113:6700:e28:c46d:f4e0:67e7])
        by smtp.gmail.com with ESMTPSA id s22sm448845pgv.94.2021.03.10.14.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:31:57 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] powerpc/align: Convert emulate_spe() to user_access_begin
In-Reply-To: <0ad4629c2d222019e82fcdfccc70d372beb4adf9.1615398265.git.christophe.leroy@csgroup.eu>
References: <cover.1615398265.git.christophe.leroy@csgroup.eu> <0ad4629c2d222019e82fcdfccc70d372beb4adf9.1615398265.git.christophe.leroy@csgroup.eu>
Date:   Thu, 11 Mar 2021 09:31:54 +1100
Message-ID: <8735x2d4it.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

> This patch converts emulate_spe() to using user_access_being
s/being/begin/ :)
> logic.
>
> Since commit 662bbcb2747c ("mm, sched: Allow uaccess in atomic with
> pagefault_disable()"), might_fault() doesn't fire when called from
> sections where pagefaults are disabled, which must be the case
> when using _inatomic variants of __get_user and __put_user. So
> the might_fault() in user_access_begin() is not a problem.
(likewise with the might_fault() in __get_user_nocheck, called from
unsafe_get_user())

> There was a verification of user_mode() together with the access_ok(),
> but the function returns in case !user_mode() immediately after
> the access_ok() verification, so removing that test has no effect.

I agree that removing the test is safe.

> -	/* Verify the address of the operand */
> -	if (unlikely(user_mode(regs) &&
> -		     !access_ok(addr, nb)))
> -		return -EFAULT;
> -

I found the reasoning a bit confusing: I think it's safe to remove
because:

 - we have the usermode check immediately following it:

>  	/* userland only */
>  	if (unlikely(!user_mode(regs)))
>  		return 0;

 - and then we have the access_ok() check as part of
   user_read_access_begin later on in the function:

> +		if (!user_read_access_begin(addr, nb))
> +			return -EFAULT;
> +


>  		switch (nb) {
>  		case 8:
> -			ret |= __get_user_inatomic(temp.v[0], p++);
> -			ret |= __get_user_inatomic(temp.v[1], p++);
> -			ret |= __get_user_inatomic(temp.v[2], p++);
> -			ret |= __get_user_inatomic(temp.v[3], p++);
> +			unsafe_get_user(temp.v[0], p++, Efault_read);
> +			unsafe_get_user(temp.v[1], p++, Efault_read);
> +			unsafe_get_user(temp.v[2], p++, Efault_read);
> +			unsafe_get_user(temp.v[3], p++, Efault_read);

This will bail early rather than trying every possible read. I think
that's OK. I can't think of a situation where we could fail to read the
first byte and then successfully read later bytes, for example. Also I
can't think of a sane way userspace could depend on that behaviour. So I
agree with this change (and the change to the write path).

>  			fallthrough;
>  		case 4:
> -			ret |= __get_user_inatomic(temp.v[4], p++);
> -			ret |= __get_user_inatomic(temp.v[5], p++);
> +			unsafe_get_user(temp.v[4], p++, Efault_read);
> +			unsafe_get_user(temp.v[5], p++, Efault_read);
>  			fallthrough;
>  		case 2:
> -			ret |= __get_user_inatomic(temp.v[6], p++);
> -			ret |= __get_user_inatomic(temp.v[7], p++);
> -			if (unlikely(ret))
> -				return -EFAULT;
> +			unsafe_get_user(temp.v[6], p++, Efault_read);
> +			unsafe_get_user(temp.v[7], p++, Efault_read);
>  		}
> +		user_read_access_end();
>  
>  		switch (instr) {
>  		case EVLDD:
> @@ -255,31 +250,41 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
>  
>  	/* Store result to memory or update registers */
>  	if (flags & ST) {
> -		ret = 0;
>  		p = addr;
> +
> +		if (!user_read_access_begin(addr, nb))

That should be a user_write_access_begin.

> +			return -EFAULT;
> +


>  
>  	return 1;
> +
> +Efault_read:

Checkpatch complains that this is CamelCase, which seems like a
checkpatch problem. Efault_{read,write} seem like good labels to me.

(You don't need to change anything, I just like to check the checkpatch
results when reviewing a patch.)

> +	user_read_access_end();
> +	return -EFAULT;
> +
> +Efault_write:
> +	user_write_access_end();
> +	return -EFAULT;
>  }
>  #endif /* CONFIG_SPE */
>

With the user_write_access_begin change:
  Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel
