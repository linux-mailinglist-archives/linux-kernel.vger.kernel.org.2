Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4361324C46
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 09:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhBYIyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 03:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbhBYIya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 03:54:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8B5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 00:53:50 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r3so4388047wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 00:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/yTwC3eBlpkhsEJCLy6pLPRMsGtFs8+S1DpDqKfd+OE=;
        b=dlAVL0r9MBoIQBYa49UhDWU27DfXME1eQ/Fa/fCbYvey6CrNsPdx7TLzis8Q+sKUsH
         UV1CuXgi6+yrdsoa58M921U5ah7THkccwNBg3SKTVNze4YxqF7i+FhCNJxPqXO9OdsVG
         ue0em9OYfCAgr9R6BsezsZag8023XCo/Qja0gaKMSAxo8FeO6ZUxFCg4nWyD+kcMootH
         FbQA7qc7oDslp9b1GB/04GE/kHPim1oTW4nw3DztnodI4lnRQY3ZCY2vcxMDmWF9TtIL
         AggMm1lyfxtsIpLz9SYB5Edv4freHK7pNKiZ6URJSigjHK+n6//JFfRX9bQzHab0gpaQ
         kipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/yTwC3eBlpkhsEJCLy6pLPRMsGtFs8+S1DpDqKfd+OE=;
        b=I73UJ3OWnnfIQnSsMUklcVFmusmfGLj7BO09peSXEJuYHTTKFr6EWG+Qome13Tab0a
         M7QgG+2Jl3NyYM22ltV81BdKy8QCuAWLYhaOSp9f7RsEDbp4O2/i142Q/nRLpA53lJ3e
         b492kYFe+daHj5Xat5AroNtWbVzNSYdo9D1+rjlci7dSLjXgAwH7poW+R7DnP2pMymfo
         NGKDmgwQ1UVIJAPHqp9BYShqcvGgnGapHTe3vwJhxPV4Ur+tJgxIA/GdIxfrrUd9ssyS
         NAH1+Hai0cysh0GmJ5som9cvAJKkEC+rMFy8rdGG8IZer+sb857T6ne5/O0pdsU9g5yK
         RnUw==
X-Gm-Message-State: AOAM532oXUI6n67JOfg0vAvE+IJQBIRS09ESEmUX3yh1L3BZ28QxI+tq
        OmtYf/Mpe6HGaaY4Qfa/b9JdoQ==
X-Google-Smtp-Source: ABdhPJyzEwZEaYW2lPzUxwymTmf05pz4IeWzFyeoAcoKTpmEsH+eG4ZGohNT+qLOfIfX0JS8EATE0A==
X-Received: by 2002:a5d:6cab:: with SMTP id a11mr2283730wra.419.1614243228787;
        Thu, 25 Feb 2021 00:53:48 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id w25sm6276170wmc.42.2021.02.25.00.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 00:53:48 -0800 (PST)
Date:   Thu, 25 Feb 2021 08:53:45 +0000
From:   Quentin Perret <qperret@google.com>
To:     vincent.donnefort@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH v2 2/2] sched/fair: use lsub_positive in cpu_util_next()
Message-ID: <YDdlmUrBiHgXMJTm@google.com>
References: <20210225083612.1113823-1-vincent.donnefort@arm.com>
 <20210225083612.1113823-3-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225083612.1113823-3-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 Feb 2021 at 08:36:12 (+0000), vincent.donnefort@arm.com wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> The sub_positive local version is saving an explicit load-store and is
> enough for the cpu_util_next() usage.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
