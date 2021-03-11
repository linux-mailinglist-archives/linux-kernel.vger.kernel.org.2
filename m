Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE0337FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhCKV5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:57:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:47734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhCKV5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:57:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7B4164F6E;
        Thu, 11 Mar 2021 21:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615499853;
        bh=rC15oV0fbK8A5ObAa2CpTtMWW4MIKdxs15W9uBiS6+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qKg7T68CNkgdxXLkqz8b9eqMlWGpFqhgcyixcu6qS43Ytn4rWikpLMgOd+beraSFB
         DR+a+S1d53ajyOvIkieO0EL53FqTQrozxlAIoIFReEwkgO0wkta1ywB8zV5Xr7/PYf
         hapTvx5P8ljpTzt9J3bcHSU3DHZaeEAUw/LH2ooE=
Date:   Thu, 11 Mar 2021 13:57:31 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     walken@google.com, hannes@cmpxchg.org, louhongxiang@huawei.com,
        linmiaohe@huawei.com, shakeelb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/rmap: convert anon_vma.refcount from atomic_t to
 refcount_t
Message-Id: <20210311135731.b0ce4c346aa8ade64fb9b5fc@linux-foundation.org>
In-Reply-To: <20210311055615.4461-1-yejune.deng@gmail.com>
References: <20210311055615.4461-1-yejune.deng@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 13:56:15 +0800 Yejune Deng <yejune.deng@gmail.com> wrote:

> refcount_t type should be used instead of atomic_t when the variable
> is used as a reference counter. This is because the implementation of
> refcount_t can prevent overflows and detect possible use-after-free.

The use of refcount_t comes at a cost:

q:/usr/src/25> size mm/rmap.o
   text    data     bss     dec     hex filename
  31114    2147      32   33293    820d mm/rmap.o
  31558    2147      32   33737    83c9 mm/rmap.o

That's a bunch more instructions to execute on some fairly hot
code paths.

I guess the debugging/checking features are nice, but this is pretty
mature code.  I'm quite unsure that this tradeoff is a favorable one.

