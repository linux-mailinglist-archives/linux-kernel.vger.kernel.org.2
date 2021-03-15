Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63CA33B479
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCONa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhCONaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:30:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A2CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 06:30:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d139-20020a1c1d910000b029010b895cb6f2so19440215wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0miAOGjAR1C6iF8/eiRPqA31iLArqFNozG79V381SB8=;
        b=Z1V3W7zK/6Y5Oh2ChxweDDxyqyX9CYoZFeViAt9BgR4GQ9nVZAGJ+O7BW9pz/OcD/K
         GvVF35A3fuyMC63aQLjswYjWAMgahmE4uMjX29lh+SsGFb56syTsANgAhOvJpyfQHTlO
         h8lBlO9IDPtbuhUxCdeXrOqnKQLy10A4UksAigAlK+Zp0TXWhZTQmxD8IblsSwz9M4UH
         ehFTFs1EkU3yMMo9b3QTcMZC98hW3wc3RoZG9B0LVDORUKKyGmgtvMGeTbH41tS74iXC
         6HFfNAimBU7A/Vcu1JJYedLIAwB+ZeQIl8VCoylhmER7zSM/HLJOXDGPorriige6jwCB
         XynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0miAOGjAR1C6iF8/eiRPqA31iLArqFNozG79V381SB8=;
        b=WnYDOah98S8DimK51Pv7phW0xbT1vK+Ur7jtbV4zu+wHMfmkOYfaGsxWDb4j+Lnhvw
         6TB25n1P7+bRxX3PSp7HsJ/z+CMRQpnHLdN/9nhJqKA+dDyeip9LsHfJEsm4dzKgjJNk
         ShakTSGnczQMS/x5NKBuk+2V5wSLeOGG8pT6FD6RcGt1oX0ZAEoNrFknIRznR0Lkqbpe
         fIux1FseNkZXp+tCHiapZ2FB9onCgpGHs7EiXx/o8qLnI+P1gWDQLBn2vs+W8O9oYvlP
         xaju0zbnQ0/A8v0wA3JYXWtfSXT+9za5fvuxNjRmuZWIy//SWHuFcc8CWyH76qajI9t9
         LmqQ==
X-Gm-Message-State: AOAM530lrRzZ6LJSc3uTbLTAnk57LH4CMA/kXgxecQMsXu7wNuvtdviE
        tOvzkQoJ/ONClRV69XTv0R6e/xQcYg==
X-Google-Smtp-Source: ABdhPJz5rFDOm82nzhBaA/5JkzVrDqaMRizfkgyNqlKhjItzgHz4EDWL3beEk4yl8Fl6CaAacdXxHw==
X-Received: by 2002:a05:600c:378c:: with SMTP id o12mr3113233wmr.69.1615815016518;
        Mon, 15 Mar 2021 06:30:16 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.123])
        by smtp.gmail.com with ESMTPSA id u63sm12399580wmg.24.2021.03.15.06.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 06:30:16 -0700 (PDT)
Date:   Mon, 15 Mar 2021 16:30:14 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        gorcunov@openvz.org, security@kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] prctl: fix PR_SET_MM_AUXV kernel stack leak
Message-ID: <YE9hZtUSWovMDili@localhost.localdomain>
References: <YE53QiJuxsCUeoiu@localhost.localdomain>
 <20210315102901.GP21246@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210315102901.GP21246@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 01:29:02PM +0300, Dan Carpenter wrote:
> On Sun, Mar 14, 2021 at 11:51:14PM +0300, Alexey Dobriyan wrote:
> > 	prctl(PR_SET_MM, PR_SET_MM_AUXV, addr, 1);
> > 
> > will copy 1 byte from userspace to (quite big) on-stack array
> > and then stash everything to mm->saved_auxv.
> 
> What?  It won't save everything, only the 1 byte.  What am I not seeing?

It does copy 1 byte. How embarassing of me.

I was confused by another way of setting auxv data:

	        if (prctl_map.auxv_size)
	                memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));

This does full array copy but the array is fully initialised so there is
no problem.

Stop the presses!

> kernel/sys.c
>   2073  static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
>   2074                            unsigned long len)
>   2075  {
>   2076          /*
>   2077           * This doesn't move the auxiliary vector itself since it's pinned to
>   2078           * mm_struct, but it permits filling the vector with new values.  It's
>   2079           * up to the caller to provide sane values here, otherwise userspace
>   2080           * tools which use this vector might be unhappy.
>   2081           */
>   2082          unsigned long user_auxv[AT_VECTOR_SIZE] = {};
>   2083  
>   2084          if (len > sizeof(user_auxv))
>   2085                  return -EINVAL;
>   2086  
>   2087          if (copy_from_user(user_auxv, (const void __user *)addr, len))
>                                    ^^^^^^^^^                             ^^^
> Copies one byte from user space.
> 
>   2088                  return -EFAULT;
>   2089  
>   2090          /* Make sure the last entry is always AT_NULL */
>   2091          user_auxv[AT_VECTOR_SIZE - 2] = 0;
>   2092          user_auxv[AT_VECTOR_SIZE - 1] = 0;
>   2093  
>   2094          BUILD_BUG_ON(sizeof(user_auxv) != sizeof(mm->saved_auxv));
>   2095  
>   2096          task_lock(current);
>   2097          memcpy(mm->saved_auxv, user_auxv, len);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Saves one byte to mm->saved_auxv.
> 
>   2098          task_unlock(current);
>   2099  
>   2100          return 0;
>   2101  }
> 
> regards,
> dan carpenter
> 
