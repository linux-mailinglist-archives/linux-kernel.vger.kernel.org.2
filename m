Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E423C9EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 14:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhGOMgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:36:03 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:50809 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhGOMgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:36:01 -0400
Received: by mail-wm1-f41.google.com with SMTP id l6so3653933wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 05:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wcDqw/N3e7J5nfLH5cF0Skbpc7vHSRgpyIPNTllWAWs=;
        b=t5g2ca9rkvLfUxgGQtglEIhdC28YjHLYyc7Uxhx6Wh6eAO4QB1pUMrBIFZ6gAXqiZG
         UIsHF9yrRLyppeLXew0yit9jeRk8Ay1scdJoTxbP68Pw0lOsYIV2o3oLn2gm4bmwUV8n
         DdSO36lCJzOA9OwMHMAZQULBQSoA5ujvCela8WTSfDDX3QUARsBIlyLBiz4/WWdm3txD
         Lwk/PzO/kBxBQuH4rGXPLB+4ubDTD86PR9gKOaxsQDClKPbEngFpH1soRIfm7YOSe9fK
         XAQHwq06600Jj6NOhfaxNx2jdPGzL5CfZCf8Ck5AOMkIMAf2sA2gRMyuYDN++399Z7zq
         QI7A==
X-Gm-Message-State: AOAM530KsgcDoXXSZ6MtXR4NPc/+gU6C+vIOoIcD973ZyZD29uc29CS0
        3KwYpGxq9WWPd9dfGnYD0O4=
X-Google-Smtp-Source: ABdhPJzI7lmODjTFGlC2kC5J5/Q0S5SFEXXHfnV/p8EScZYBPWojG+IpBYLVOeTIBrPwq8QBgSSfvA==
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr10104904wmc.43.1626352386916;
        Thu, 15 Jul 2021 05:33:06 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s1sm8337793wmj.8.2021.07.15.05.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 05:33:06 -0700 (PDT)
Date:   Thu, 15 Jul 2021 12:33:04 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Sonia Sharma <sosha@linux.microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, wei.liu@kernel.org,
        Dexuan Cui <decui@microsoft.com>, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hyperv: Remove unused inline functions in hyperv.h
Message-ID: <20210715123304.a7qgu5op4cymaj6b@liuwe-devbox-debian-v2>
References: <1626294034-6061-1-git-send-email-sosha@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626294034-6061-1-git-send-email-sosha@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sonia

On Wed, Jul 14, 2021 at 01:20:34PM -0700, Sonia Sharma wrote:
[...]
> -static inline void set_channel_affinity_state(struct vmbus_channel *c,
> -					      enum hv_numa_policy policy)
> -{
> -	c->affinity_policy = policy;
> -}
> -

This function was removed in 8ef4c4abbbc which was committed more than a
year ago.

The other three indeed have no users in tree.

For uptream development please base your changes on the hyperv-next
branch (new features, improvements) or hyperv-fixes branch (bug fixes).

See https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/ .

Wei.
