Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7DD4198D0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbhI0QZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhI0QZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:25:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62165C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:23:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h12so2464005pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Oayds7d4ph4kWFh1xXZbuusv5h+5AfPdkUy5J5DBr3k=;
        b=kFngBbUxHf6XhO5UqwQdUlSa582oQHs8eZTG3Tr1yUxeaGRzs+isM+yDTOpJ6dbj9Y
         4AIkv+FSAxCtR/bv0WdlIp2ENzyKU2POypc8tBiA81xsbu5jmIeUSqmf4M+hGfsC6zow
         aFMoPZRt42PdgsbdWtCkaOeBzu93qOOb9EIYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oayds7d4ph4kWFh1xXZbuusv5h+5AfPdkUy5J5DBr3k=;
        b=wavSqOHtDy34tgRoySDOcjeC7Cg9CQcIu8qvFCSM9Jdp0uSiMPOTy7BBABb6orTt3J
         wxpK2kUbo0lu0hKlRbneHxXrg/xIc8NQXiFvVnIsLS4XGo09+V4MG8eGmvcHGi/l8a57
         S6hq2HC5N4eLiyqxCxa90rIGdoR2hbqV9jEUhBQlWrTfmo5aXHO4Ia/hoi8Qun/a2VFs
         JKy8DloaUUsGMn1j2pP28Jwm+KCBRHOvjKa6AYc6tofxH/SNxltK6OhUxnK1xSGnUl9X
         efPSagEEgSDMLvB6hS7YUFRF3MKsotpGzlLW4MtZK5S0y2DtTD/KPOs0GX+2WI62YNsn
         r4RQ==
X-Gm-Message-State: AOAM531JpL+WlysCZeCdmkIA2xiV9e5iwEvmFImMCVL6mQfMN54+aMW8
        gfLbuSYKkBSEdkYLi8wt9FN+J1100b4QiQ==
X-Google-Smtp-Source: ABdhPJwmv7Ci0OH7l3eypdXxSkmOIH+P2PUIF4RCr1a9BdV8p7VCvIE8781ivyXZKXK3er/r72B0Dw==
X-Received: by 2002:a17:90b:46c4:: with SMTP id jx4mr14938251pjb.218.1632759801992;
        Mon, 27 Sep 2021 09:23:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mt17sm16388311pjb.38.2021.09.27.09.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:23:21 -0700 (PDT)
Date:   Mon, 27 Sep 2021 09:23:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] ntfs: disable for 64KB because of stack overflow
 risk
Message-ID: <202109270923.7E71FE4F9@keescook>
References: <20210927141815.1711736-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927141815.1711736-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 04:18:03PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On ARM64 randconfig builds, we occasionally get warnings for NTFS:
> 
> fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
> fs/ntfs/aops.c:1328:1: error: the frame size of 2224 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> 
> The problem here is that with 64KB pages, we get two arrays on the
> stack that each have 128 pointers, for a total of 2KB. Before
> the VLA change, this could already happen with 512-byte blocks,
> however in practice NTFS should usually have 4KB blocks and not
> be affected by this (see link).
> 
> Now the stack usage is always > 2KB on any architecture with 64KB
> pages. Since both NTFS and 64KB page support are fairly rare,
> we may get away with just marking the combination as disallowed
> in Kconfig and see if anyone complains before we find a different
> way to address it.
> 
> Fixes: ac4ecf968acb ("ntfs: aops: remove VLA usage")
> Link: https://support.microsoft.com/en-us/help/140365/default-cluster-size-for-ntfs-fat-and-exfat
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

That seems reasonable.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
