Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0973BB59E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 05:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhGEDhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 23:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhGEDhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 23:37:52 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAEEC061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 20:35:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 145so1567001pfv.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 20:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sA97bCXCaIAhWnb+YR7vIrZrUHxT70DILRled1e98Wg=;
        b=inDJBS2brM1eymEMmYzx86mblKrDCQWOtb4pAT0+UbL1Hz2kRNeRgeAEEXaacfirwd
         Qyy1TfBOPXNsUzot1HcfIekVmbqCck2CHWNfXMf8iA32i/BjNgtHw8sKvjcQr5BbCLpu
         dHbKcowD6sxCe+RNxUAoW0dVlL82a/nXhDD2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sA97bCXCaIAhWnb+YR7vIrZrUHxT70DILRled1e98Wg=;
        b=Lj9Gzoz1ZBkQN+YMqUalJkYC+91iznxbQo3i05sfKA5puuiE240wyxHW479ZxssvDK
         L6HzfeMqrZDn/0KtW1CsmmyFF8C7ahhEBNrQhE1j7xAvCf1/Kc04EElX3jfHlrAqH48X
         bwRlXHXJmgXEukKEtyE4sckwmyHHUI++HlkqI6381XPkBLrZwM8Yy6j2jJSUgdR7UIdZ
         505R14HBvQ7O2Vt52PopToc1u5KmSx/ioU4UvPnadNPajP7EkYyqPmn/DfqptGLS/pCl
         ccvz7A1PsDX+LOHFeDvM40P1221WxI7+1OWtVn7Vtfu1ytwH6fjFYEAiP2zQcvmBZLs5
         0gZw==
X-Gm-Message-State: AOAM533TpqAflUlCjIHB/kRlQy+sQ6kPdQjImgmYzcli0AfsqFoe4iiB
        nFCr0fdNYe36arWFt5BeGUBUiA==
X-Google-Smtp-Source: ABdhPJzONfFCHFfgTqGGbW5wyh0ciobtJX/MJXb1ZXF3mpgRlAezjYI1jkwDW4EcJKVlbDqJgSqLNg==
X-Received: by 2002:a63:fa11:: with SMTP id y17mr13613461pgh.128.1625456114410;
        Sun, 04 Jul 2021 20:35:14 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:7a3a:c0d1:8813:add3])
        by smtp.gmail.com with ESMTPSA id r15sm6254176pje.12.2021.07.04.20.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 20:35:14 -0700 (PDT)
Date:   Mon, 5 Jul 2021 12:35:09 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 2/9] kallsyms: Fix address-checks for kernel related range
Message-ID: <YOJ97ewJYK/O1OYS@google.com>
References: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
 <20210626073439.150586-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626073439.150586-3-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/06/26 15:34), Kefeng Wang wrote:
> The is_kernel_inittext/is_kernel_text/is_kernel function should not
> include the end address(the labels _einittext, _etext and _end) when
> check the address range.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Fixes: 04b8eb7a4ccd ("symbol lookup: introduce dereference_symbol_descriptor()")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
