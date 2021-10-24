Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D7D438C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 01:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhJXXqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 19:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhJXXqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 19:46:07 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A23EC061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 16:43:46 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id w23so4909117lje.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 16:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYURh8RyNr1ckN0vFdaCCBvNFLm+aoJl9EOOW5L0bjo=;
        b=Dub+HLKftT8qLgrVIy5NVEmLS8CfCo7rREnppHnZ5zdkjXpOcGo47y6pwcCDWrVKLO
         Q8xh60qhUlDB/QvRFGrYQoB9VqyErt/kcaXTfW+gH/tgWmN+9mfqiClGYEL15Y1Ue2wL
         8C/TFfrnRwftNAvzcmslqGkvHT72IflKyUcZKxzApkJZtI1KGArCXckIJ9JuaO2tSNrN
         /h8cojO1Nnprls0S38qNlzsSf6dovWQwjnx1czgyKu5NeL9egcALRKXf+S5P8oPEcpSw
         H8hmHIEPTSw5d15ChljfFNhwOe8PWULuIKQn32eyHTTmPnaqOFSuU0pHE7At5ykFStSQ
         TY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYURh8RyNr1ckN0vFdaCCBvNFLm+aoJl9EOOW5L0bjo=;
        b=UG6f6Xf6Ih6Fh6PqogvKgO7IW1bLziIHHRQ08Sy/RVrRYwQ9sl9r9yllJJ2BzbLVXl
         zL/eBO7nCMkOUsONKVWG/HzVhFF6VblXGqUvP1ETQMi2zPUz4accskM9iOt+fpZ4OLE/
         BC1eLCCPPpt338BRn/XYieI8Qa4oj/+kPhdSBBxXcPN3Nr1LrvzesT4Ezg3PZZMsOxcu
         /ic1Lto5enE+bi+Vu6hQLAw9i9mULx7V+NUfxUbyYPXNJnKpwAkSSaUfPvoUJWK0fcv9
         QHleG6mKJUZ2Vt9l49htIj3JgnWkqyxZ83tGrGELOVz5vscDHW/d548hU6u4PpG0WlP6
         EwkA==
X-Gm-Message-State: AOAM53307k9hQX+L9WkjgJIxt1tf2iTrEcl+0W8vAMViR14bka/AWIe2
        ctixS9+/EF9M5MmhPFEIXrQpu3XMgFXT+fWxVjSXbw==
X-Google-Smtp-Source: ABdhPJztsLhfPlIDXOWbtCLEN2eSmWIpJybl/IJoG/laFGPQUMT5dyD7xL28cKG/c8UTZ2WmLn4HesOiz1QICojDPys=
X-Received: by 2002:a2e:9d48:: with SMTP id y8mr15608833ljj.19.1635119024432;
 Sun, 24 Oct 2021 16:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211022014323.1156924-1-yangyingliang@huawei.com>
In-Reply-To: <20211022014323.1156924-1-yangyingliang@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Oct 2021 01:43:33 +0200
Message-ID: <CACRpkdY07ciT_0FCOuWGV3dbfcsyDpAqy4Aon_WN1gA8QS6a-A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: core: fix possible memory leak in pinctrl_enable()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 3:36 AM Yang Yingliang <yangyingliang@huawei.com> wrote:

> I got memory leak as follows when doing fault injection test:
>
> unreferenced object 0xffff888020a7a680 (size 64):
>   comm "i2c-mcp23018-41", pid 23090, jiffies 4295160544 (age 8.680s)
>   hex dump (first 32 bytes):
>     00 48 d3 1e 80 88 ff ff 00 1a 56 c1 ff ff ff ff  .H........V.....
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000083c79b35>] kmem_cache_alloc_trace+0x16d/0x360
>     [<0000000051803c95>] pinctrl_init_controller+0x6ed/0xb70
>     [<0000000064346707>] pinctrl_register+0x27/0x80
>     [<0000000029b0e186>] devm_pinctrl_register+0x5b/0xe0
>     [<00000000391f5a3e>] mcp23s08_probe_one+0x968/0x118a [pinctrl_mcp23s08]
>     [<000000006112c039>] mcp230xx_probe+0x266/0x560 [pinctrl_mcp23s08_i2c]
>
> If pinctrl_claim_hogs() fails, the 'pindesc' allocated in pinctrl_register_one_pin()
> need be freed.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 950b0d91dc10 ("pinctrl: core: Fix regression caused by delayed work for hogs")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Excellent find and fix!

Thanks so much Yang!

Patch applied and tagged for stable.

Yours,
Linus Walleij
