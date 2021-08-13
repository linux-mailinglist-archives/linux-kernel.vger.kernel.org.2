Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5063EB5A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 14:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbhHMMhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 08:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbhHMMgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 08:36:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BE6C0617AE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 05:36:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso6818829wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 05:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OVsoLc8GnI2MJx0koPlkzsYORog3roebBSA9S9Lp1xo=;
        b=egAI5MaCx9xeTeaDTXJ3k5cDg0ZnINbnSaS3tFWQFxO+8aN/v/SDF1W1pqnitQiAnn
         JOdHqGMJiOhw8oNbpX0AUwKa31k8vhYnX+ilDmFTLF/bGvem4ZRyEYTMMo4/Pj4Frz2U
         a7kPYvvhIUpNfKqRAtMWAjrLfm6aekJejIKng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OVsoLc8GnI2MJx0koPlkzsYORog3roebBSA9S9Lp1xo=;
        b=D3tNG26CuQmETWeaY4WEPSWFKsHFv353GCvAqccas0GaRJNH6b/EEUXoSxWap7OdBa
         SEw/tC4Z48U+emYZIkBjpo6kLNwou8nnG/EZB+JbzkQPM/CC3bK8kKLoSqhWzwQLYCr+
         KcMt4QmG/P+sP7LYIZJ6nLlTDZ9FKdR4rFJbeUR+U5L+0ZVV4ybqKtL5/8NNRfBtPNv4
         Mmhk/l5uzJYEWBO6ikmEQmO+amzTk+jaUbSeqCCJWmlyrMsM+Y2u80hC3Y678O99V3Tf
         8sRu7tIngGU6fco8QEmGgbwgYzuW3Bt/WPKZMOqhQKTNUbfmtXoJg0s02ey59mEPX9xS
         iTWw==
X-Gm-Message-State: AOAM530nZkLYCoeBSDA7E2LKYIP8eJNkK9LVhcaViEjqYwz1/Ju6axmW
        sMxkiR2xzhokkYvd/36K1IAebg==
X-Google-Smtp-Source: ABdhPJxeb4QSR91gkUeMJG783tEyeIzpfzA3nquA/DVh4P6/OjdbN0MZIGZVMmA0QRAaQYs8NFvqEg==
X-Received: by 2002:a05:600c:3555:: with SMTP id i21mr2386110wmq.156.1628858162782;
        Fri, 13 Aug 2021 05:36:02 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:fa59:71ff:fe7e:8d21])
        by smtp.gmail.com with ESMTPSA id q5sm1432727wrx.33.2021.08.13.05.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 05:36:02 -0700 (PDT)
Date:   Fri, 13 Aug 2021 13:36:01 +0100
From:   Chris Down <chris@chrisdown.name>
To:     yongw.pur@gmail.com
Cc:     tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, tglx@linutronix.de,
        peterz@infradead.org, shakeelb@google.com, guro@fb.com,
        alexs@kernel.org, richard.weiyang@gmail.com, sh_def@163.com,
        sfr@canb.auug.org.au, wang.yong12@zte.com.cn,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.yang29@zte.com.cn
Subject: Re: [PATCH v1] mm: Add configuration to control whether vmpressure
 notifier is enabled
Message-ID: <YRZnMYCN1ArhM3wE@chrisdown.name>
References: <1628855870-5070-1-git-send-email-wang.yong12@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1628855870-5070-1-git-send-email-wang.yong12@zte.com.cn>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yongw.pur@gmail.com writes:
>From: wangyong <wang.yong12@zte.com.cn>
>Inspired by PSI features, vmpressure inotifier function should also be
>configured to decide whether it is used, because it is an independent
>feature which notifies the user of memory pressure.
>
>Since the vmpressure interface is used in kernel common code, for
>users who do not use the vmpressure function, there will be
>additional overhead.

Could you please demonstrate this additional overhead with profiles or 
demonstrations of other real world effects? Thanks.
