Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A43353481
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 17:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbhDCPVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 11:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbhDCPVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 11:21:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521F6C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 08:21:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 12so3740520wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sfd8DudOIuGyL5rc9egOme31BdENe1jWkpbRM3j4vK4=;
        b=jEDVz8cl2My814T63UzgroWd+kp0KmVUAkA7sgDtHGXGaNzmczXBRY8so0VSq3gC9I
         TmXIUH6O+6g+HjLMoEP3uevChHVfWFlg21/wVlOEf/Hx6yReHEyK8NQO9x4egfSVi0X7
         BpLJ3QDDJaDxzNYAoLPhKUbkfDwFExlsrWbmzGrKcThu2BGgCKy2HGYYJ2ehgIJRAxdv
         jxk3bgzC10GmReX/E0wkq5fpYR1D3erjJ0MwgWyABxQxKfK+Nd0i5liGJbQZQPB008H6
         5fz4ecQQ3U907EIZQx+0cDNxzKc4aKPvi5/xGR1DpU8GDkOlhN+/jqSWWweEthKZzi63
         zMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sfd8DudOIuGyL5rc9egOme31BdENe1jWkpbRM3j4vK4=;
        b=YhJZCaCZVh6FyuNNRQfs5KPosoYp2459fznbXGX1J8+HOifxOQnNxndF2tOzV1u0U9
         tZZ24mlTv50iRfu5xrU2sOHMb5n7TVsHzPGYhj5JHfprL/d9JollpDsmhh8WPYLiteif
         DAlTgYVdt5nNln59qzmcsflsENJ2NorXXWNwh9XH0zBXSh7CFKBkZVPOkmdSSwjOuoy4
         IkJVLMZkx+vdBZG6iG5BGiB94XaOJR+agyh4JBeepq3IPc71qU9Y+NfPoYhFFbV7HaSU
         DOGJFqi+MvifaKKklptYRIek4XQDnruBmitLbM+VrXRnliITbxEVRBI9qKemBjU1DxKZ
         xOSA==
X-Gm-Message-State: AOAM531F5Ui6BvXpch9OSaPUc5FE/q58llxDVssgk/eENvcqGiLDYN7M
        aDlDEWbL4IX7TfIbG+GIKtbE3BSAD+yeGw==
X-Google-Smtp-Source: ABdhPJwAEt0LVv6M0lFMPoOMwzxS7AjYpuF6d6KzLlofSUyjl/EAkv4Q1L4Kd3MPDM90iid9t3LZiA==
X-Received: by 2002:a1c:a958:: with SMTP id s85mr18137514wme.4.1617463307078;
        Sat, 03 Apr 2021 08:21:47 -0700 (PDT)
Received: from agape.jhs ([5.171.80.6])
        by smtp.gmail.com with ESMTPSA id v18sm20291660wru.85.2021.04.03.08.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 08:21:46 -0700 (PDT)
Date:   Sat, 3 Apr 2021 17:21:44 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/30] staging: rtl8723bs: remove RT_TRACE logs in
 core/*
Message-ID: <20210403152143.GA1403@agape.jhs>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
 <1cd79d781cdcccf621ce8e104a9cdf1e90e7f803.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd79d781cdcccf621ce8e104a9cdf1e90e7f803.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2021 at 08:02:25AM -0700, Joe Perches wrote:
> On Sat, 2021-04-03 at 11:13 +0200, Fabio Aiuto wrote:
> > This patchset removes all RT_TRACE usages in core/ files.
> 
> and hal and include and os_dep

Hi, 

I was just about to send the second patchset relative to hal/ files.
The whole has been split up in directories in order to reduce the
number of patch per patchset

> 
> > 
> > This is the first of a series aimed at removing RT_TRACE macro.
> > 
> > The whole private tracing system is not tied to a configuration
> > symbol and the default behaviour is _trace nothing_. It's verbose
> > and relies on a private log level tracing doomed to be
> > removed.
> 
> It's nice, but individual patches per file done by hand are difficult
> to review because you are interleaving removal patches with cleanup
> patches.
> 
> I believe this should be a patch series with a single patch to remove
> all RT_TRACE macro uses using coccinelle and then use separate patches
> to do whatever cleanups around these removals you want to do.

It's a good idea, but the patches relative to RT_TRACE removal
could be huge

> 
> All of these below should be done for all files in drivers/staging/rtl8723bs
> at once instead of submitting per-file patches.
> 
> IMO something like:
> 
> Cover-letter: Explain why you are doing this
> Patch 1 of N: Remove all RT_TRACE macro uses using a coccinelle script
>               and include the coccinelle script in the commit message
> Patch 2 of N: Remove commented out RT_TRACE uses
> Patch 3 of N: Remove RT_TRACE macro definition
> Patch 4 of N: Cleanup coccinelle generated {} uses, if/else braces and
>               the now unnecessary if tests around the RT_TRACE removals
> Patch 5 of N: Cleanup whitespace
> Patcn x of N: Whatever else related to these RT_TRACE sites...
> 
> https://lore.kernel.org/lkml/c845d8ea7d0d8e7a613471edb53d780d660142a9.camel@perches.com/
> 
> Using a sequence like the above would be much easier to review and
> would be a significant shorter patch set.
> 

moreover every non RT_TRACE deletion patch (clean up patch) is near 
to the contextual deletion patch (parent patch or grand-parent)

but I do not have experience in code reviewing, so I will do like you
say. Maybe I wait for other opinions, but what you say is good and
elegant.

thank you,

fabio
