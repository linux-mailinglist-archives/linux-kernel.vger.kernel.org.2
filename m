Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D16413590
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhIUOru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbhIUOrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:47:48 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8C8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:46:20 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id i132so26918399qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g/5wAGdIqDpepTm7AaXMwRb0JTwB/CszwhWs0V5grd8=;
        b=NuHGGC3mqlBsZ+ZpSWNZPC1w/E33K2K8fAaK0xBoRCZMYLE4cjdFvkZs1lYKM8zSDm
         nfhYfdgvaYeX/ricJZ9AOMj7cEHU9VBmCk2nvryu09FbdruGAQHaEXDqb3K4YHlSi0HE
         WSZAq/UdcEkC0uvqZLzbjxQDljFVXZjRjYh8u66PdHZdA4KZfcxIMx9yjQ6VBKQP2QQr
         gJ1FPBrxO3Jvyc2E02pJLiOdhDKCAlxtL02gWZVs0kMSl6ol8rvL8thJPZIjvPp2U9nx
         +g9cw2em/g898qDkK93AFNS6v8lNxIz3uxmCi/1629Xr4TPKlIgdOib1ZSM0rYGTRGiU
         L9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g/5wAGdIqDpepTm7AaXMwRb0JTwB/CszwhWs0V5grd8=;
        b=Lr6CdYdlumbPjJpeap6P00edgT2fuyzf1TlGtoMsNu+GK/cFq6sVQnAGO8Adr/QX7G
         dsQW9qkk/3rzTIYNcObC+OntBy/HzDl4nIlcjANWValdBX9YoHhFj/jotY5iwjAhS7JV
         XGsBK6vH8g22FoTNXiAYez3Why7dWrnZKw1wm/wAR63qXWy4IfsMWZE6M+kl4ljYgo7E
         UQ+4XkYcaU1kSBasuZNBLEC8UF6NPgfwl+6oceCauKVLd+4gX15t7a8EOUqejI0+UGqI
         gRlP8ejTQNVmkohdw32zk8uY1dEnu0U+lzMDeeiu7YEMekC+XGXvB9yqxojKtJSFJ8Ox
         C8wQ==
X-Gm-Message-State: AOAM530lvtdGUUtDpChIp3qZF19JYXzpjmHyAlnmprE8JAQouNhM/08+
        CoSb2EfPF+YU6XFoewe0Ru4HyvwclkRfmA==
X-Google-Smtp-Source: ABdhPJxNONS0+e09ljyIMzt9Ynqr49RIx46nyIbG9/UH6wkZDmaa4KKv66f/2fhbvmqH5MqMcHV3bw==
X-Received: by 2002:a05:620a:1aa5:: with SMTP id bl37mr29154787qkb.84.1632235579371;
        Tue, 21 Sep 2021 07:46:19 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id q14sm13619711qkl.44.2021.09.21.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 07:46:18 -0700 (PDT)
Date:   Tue, 21 Sep 2021 10:48:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yongmei Xie <yongmeixie@hotmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm:vmscan: fix extra adjustment for lruvec's
 nonresident_age in case of reactivation
Message-ID: <YUnwsyE87TViMNMz@cmpxchg.org>
References: <TYCP286MB1108D012DA436CA72029ACA7C5DF9@TYCP286MB1108.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB1108D012DA436CA72029ACA7C5DF9@TYCP286MB1108.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 11:25:09PM +0800, Yongmei Xie wrote:
> Before commit #31d8fcac, VM didn't increase nonresident_age (AKA inactive age for
> file pages) in shrink_page_list. When putback_inactive_pages was converged with
> move_pages_to_lru, both shrink_active_list and shrink_page_list use the same
> function to handle move pages to the appropriate lru under lru lock's protection.
> 
> At those day, VM didn't increase nonresident_age for second chance promotion.
> Commit #31d8fcac fix the problem. Definitely, we should account the activation
> for second chance. But move_pages_to_lru is used in reactivation in active lru
> as well for protecting code section. So I suggest to add another variable to
> tell whether reactivation or not.

This looks incorrect to me. We *should* count reactivations/rotations
on the active list toward nonresident age.

The nonresident age tracks the number of in-memory references in order
to later calculate the (minimum) reuse distance of refaulting pages.

If a page on the active list gets reactivated due to a reference, that
reference contributes to the distance of yet-to-refault pages.
