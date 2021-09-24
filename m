Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91233417CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346929AbhIXVMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhIXVMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:12:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C115FC061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:11:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y89so30195115ede.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SWyL9sRLfKILLLYkOpvWuNZ4UiouYeFP+XTEBgYJz58=;
        b=PvE/vKEsVzSZiCjcyj2XjpudW1mrvzcYeLM4TwudoTkypf3o6mGCwC/12vVo5j+UMc
         SZGnP9Vr7AQPzVtWjoCY9YQIrol9RTJYEeu+cs5ehB5/jvn+mPLlqyAgAlU5SvmQTHzZ
         5WQqK9+/g7Bm1lHC1mU6orp8Leh16wZegj0GbiAd6/XjW3+gx4AldFh8JEo0S6OLnPoM
         J+5/q+0CT8jprLZ6csW8wDQMCYzTJVZdd8C4zArn2k5jDdFRWneFRRO0h1jpNl5QCtW7
         CVtS0Rf82i6P7lu7LSfVekW8egIQuaX+8/Rnq9P9LsKB6f6Nto8F6imMi9lc37uM7KqP
         B03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SWyL9sRLfKILLLYkOpvWuNZ4UiouYeFP+XTEBgYJz58=;
        b=xtcu3KA1tEVxiP34lN0GCQ+MLaqoXseFD+DigUnkapSUwEmxpxaadq6glWFMw8uSb/
         mH79xGsYvhOmARuMnsvw9fvYLqkyui1JRWrmlmgU2dW8yRl/qW3itMLUU6cQRZMRD76X
         HAXRbKHQb3EFSV9U6ZPhM2AaWXyjmGHG2OAJm9csyGq2bSrhH7sCcefG1S2fyZWk7IR5
         cAV1aJ1h17cU3LLFbdEuEwJ1PQ28MuOGYlwRQzHbzXF2fypISmfb7Ju6m20jpCigXAoH
         bKVyEqXTspBQ8laeIT+GpiELZ8SwoCGRnoc448fNnGu+vkQthdmXj4iDI4Kd+Gcmq8L2
         Q4+w==
X-Gm-Message-State: AOAM530EjYVIDajc/9XuDc21VC5L3rvL2JSBjVhgUDxahJg1QjmqTSQ5
        YiEohp98CvpkPZbbx8W+0VI=
X-Google-Smtp-Source: ABdhPJzeOUN3lM/Ehrb2uAyM0sgvesnAVvpem7nXgakPmm8/bMWlyC3BbemOBpR3g0CxFd3CU6G/hg==
X-Received: by 2002:a17:906:158f:: with SMTP id k15mr13923966ejd.241.1632517870456;
        Fri, 24 Sep 2021 14:11:10 -0700 (PDT)
Received: from tom-desktop (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id ez2sm418027ejc.108.2021.09.24.14.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 14:11:10 -0700 (PDT)
Date:   Fri, 24 Sep 2021 23:11:07 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: Replace camel case variable name
Message-ID: <20210924211107.GB10906@tom-desktop>
References: <20210922225756.694409-1-tomm.merciai@gmail.com>
 <20210923083018.GB2048@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923083018.GB2048@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 11:30:19AM +0300, Dan Carpenter wrote:
> You sent about 10 patches with exact same subject.
> 
> On Thu, Sep 23, 2021 at 12:57:52AM +0200, Tommaso Merciai wrote:
> > Work in progress: replace camel case variables
> 
> Leave out the "work in progress".  We're only interested in what this
> specific patch, not other patches.
  
  Thanks for the tip. Resend V2.

  Tommaso
> 
> regards,
> dan carpenter
> 
