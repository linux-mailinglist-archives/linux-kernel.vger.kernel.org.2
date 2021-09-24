Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472B5417D66
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 00:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbhIXWDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 18:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344195AbhIXWDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 18:03:20 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572B9C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 15:01:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id dj4so41475426edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pX5YZx2h9TlXbdaicj5FzXug5Eoaczz6tg4zWLgjm1Y=;
        b=o88LMJU4DMw5kbc3cZbqcRKE1X9fvb20ekkXqBJ2Otb0V4teT34iHC2KyhvoFTMu/G
         2/sZKdhaGgnb1UlzaiZNXElWe5wsUEwZX0LrtGRoSIYTC3BizxwmaWCQXnT2zC1P6zNY
         x6gkMPP91ME0DyEkozbfkyJs7GG0mgDTYGJKzAMULvbPYLQ4EA4PAEVlH+9VmxkZg07G
         7TS8JYNggugR2JJt3aQ8ZD94bHi10EYMCGBLtI7hOB4DMhfCyLyHUBUESCUJ83Qw9kFc
         MAIxyKVIRwozbGi1Jt5IQsSUOjKqomrS/QlBJFYVReImbFmfGkQfIyRwbSAvCIRW+Ru3
         7m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pX5YZx2h9TlXbdaicj5FzXug5Eoaczz6tg4zWLgjm1Y=;
        b=ZkjVPpKGOQNxNOVGtKB2VnHDIMafVaopLu6ik+x0zs+/TKjsHvg+ey2rNsKKBrX8sB
         faauY8ccD8YZeN9XMvKFZ5m/dPGdjnA6QbA3j1A2LSIijjl0tR/IaJ3fWpq1rcZfKWpT
         KFZ3UTCUZQ/XVfeJvG4EcNNmydL54qDb5qu4uTscNdzndEfG+j6yjctdvUerbiRvkW1o
         hirCYw2NCv+X/61Zo5VBbFspQMTBhEW0hKRYy7cZJeWD5fuiBaqXaUQf4/T8vX80e2uS
         My0P9ERX9CR3vUZMxtcKWnKoqejpTtXwhe7+WRG65cQkM2NQ2J8HelSnif9yLV0I87uC
         rfGw==
X-Gm-Message-State: AOAM532/B7mMUESoUWxibulqznGa9I/ODelDUKQ/cpK7T0mhfd69mwBe
        axwA42ry5j6aqKXq3BQ9drks93jdDsQ=
X-Google-Smtp-Source: ABdhPJymlDjEsUUVhVDSSnS1jfz9rsmM4qz8IYOILPg1Q+tje7071w3pssdG4j92XYwFFUgN+XbrPg==
X-Received: by 2002:a50:9d44:: with SMTP id j4mr7781803edk.173.1632520904998;
        Fri, 24 Sep 2021 15:01:44 -0700 (PDT)
Received: from tom-desktop (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id v21sm6301520edb.62.2021.09.24.15.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 15:01:44 -0700 (PDT)
Date:   Sat, 25 Sep 2021 00:01:42 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: vt6655: replace camel case port_offset
 instead of PortOffset.
Message-ID: <20210924220142.GA4788@tom-desktop>
References: <20210924210008.106355-1-tomm.merciai@gmail.com>
 <20210924210008.106355-4-tomm.merciai@gmail.com>
 <58c61a30-c368-8e4f-d9c9-1f39cadda869@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c61a30-c368-8e4f-d9c9-1f39cadda869@embeddedor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 04:56:16PM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 9/24/21 16:00, Tommaso Merciai wrote:
> 
> Where is the changelog text? :/
> 
> Sorry but I insist: take a look at this:
> 
> https://kernelnewbies.org/Outreachyfirstpatch
  
  Hi Gustavo,
  You mean the changelog in the cover letter?

  Thanks.
  Tommaso
> 
> Thanks
> --
> Gustavo
> 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
