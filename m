Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14630352FC4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 21:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhDBTae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 15:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBTaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:30:30 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6037C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 12:30:28 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k8so4120034pgf.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mI2VwoucIGtwJkYw4jcbD6VsEjZ7aBO9iaogKVD4nI4=;
        b=KK2Kxxc4pkTexwVVGgJh/v3IhjphLvlaQKCImf4D6lAGS/OdKWcPPWAI+eTtnLJTeh
         nvX2apmNv/KMyLksk6sFFf2ztsd60zapv+9zdIcqjg1Z1Aa/fXESufNKsqtjIke5WQHt
         M0aG3TYe5f329OkBh/5aRwpQxCZRm57zZCvNnVVD/5SLohli1J+RMMmFCKU/pw3iLYAQ
         eHlZZjHe6dIwkHctw7SAmhSLbimCLbQgXdw9D0j+vDyLgO0zRXqUWTxLjE6wGz5k5GGV
         RGVxOAen6cBUcfr72E2gb1xq0kxs41Oio01KmGwmrzqQyIw0Ycu+FzgY/iJOTTSRrHFU
         fAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mI2VwoucIGtwJkYw4jcbD6VsEjZ7aBO9iaogKVD4nI4=;
        b=Kz4PDcxKHQ+qON68RUCEDvXoZVXUg3RkQpI1yX+DXUxPogqIDPJwMrnp2K0T7ujQiz
         qclNA07nd1Uw9jvCDs+eGHg6G9ZZuYuR6uBmBCamjqzOc1Xq0MGzM2rGBv7LHp1lk5U1
         +bUOSw9I5TVU9a7ceq/fPqHXRdyXrVYwYlI9sxi+OjfUf9VP6d4f0F1IQSfTzGv7b1kK
         AUS0VP6h0xgkUeXxYuIB3s0+/PkQ9bQId+9rSD9qFRTCoEpZ1yII8U9tQ3CfG3sEFLQc
         7zr0eagbfC4dPwPyXSg3e4A8CYgpEnaBzZJDJDhtr4pR8D9er52jBTKxeiCxSIGE1jCJ
         BCXw==
X-Gm-Message-State: AOAM530oms36SNX6E2vWH6vPjM13BTWFg4ouUOR8VeYDfbFhH4aTVTWU
        WR/s2lNpBo6BoWQ9RvcuMiDkQw==
X-Google-Smtp-Source: ABdhPJz+IwEe6kNxDW16gUdkP1UiHKndPYJHb24Xo12t7nWY35muI9rAeFyqM0+2dx4Uv3yTO8KcnA==
X-Received: by 2002:aa7:8d8a:0:b029:1f8:aa27:7203 with SMTP id i10-20020aa78d8a0000b02901f8aa277203mr13370981pfr.64.1617391828115;
        Fri, 02 Apr 2021 12:30:28 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id s8sm8799796pjg.29.2021.04.02.12.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 12:30:27 -0700 (PDT)
Date:   Fri, 2 Apr 2021 19:30:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kai Huang <kai.huang@intel.com>, kvm@vger.kernel.org,
        linux-sgx@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, jarkko@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, rick.p.edgecombe@intel.com,
        haitao.huang@intel.com, pbonzini@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Subject: Re: [PATCH v3 07/25] x86/sgx: Initialize virtual EPC driver even
 when SGX driver is disabled
Message-ID: <YGdwzzvsKTXJeioa@google.com>
References: <cover.1616136307.git.kai.huang@intel.com>
 <d35d17a02bbf8feef83a536cec8b43746d4ea557.1616136308.git.kai.huang@intel.com>
 <20210402094816.GC28499@zn.tnic>
 <YGc7ezLWEu/ZvUOu@google.com>
 <20210402191946.GL28499@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402191946.GL28499@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021, Borislav Petkov wrote:
> On Fri, Apr 02, 2021 at 03:42:51PM +0000, Sean Christopherson wrote:
> > Nope!  That's wrong, as sgx_epc_init() will not be called if sgx_drv_init()
> > succeeds.  And writing it as "if (sgx_drv_init() || sgx_vepc_init())" is also
> > wrong since that would kill SGX when one of the drivers is alive and well.
> 
> Bah, right you are.
> 
> How about:
> 
> 	/* Error out only if both fail to initialize. */
>         ret = sgx_drv_init();
> 
>         if (sgx_vepc_init() && ret)
>                 goto err_kthread;

Heh, that's what I had originally and used for literally years.  IIRC, I
suggested the "!! & !!" abomination after internal review complained about the
oddness of the above.

FWIW, I think the above is far less likely to be misread, even though I love the
cleverness of the bitwise AND.

> 
> And yah, this looks strange so it needs the comment to explain what's
> going on here.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
