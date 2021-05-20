Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF74C38B4D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbhETRBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbhETRAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:00:35 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CEEC06138C
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:59:10 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id u33so8949487qvf.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5BNLluTPcpkr8B4gIUADQZy/9CuaYtTWeWTH5QovX+s=;
        b=URFz5RSgPPV/kvOGMsVL6l2dntqBGNJf3Y8pmFmuSfDqseNkAsiHUFxv/3ls17MO/E
         rio/jp+21iMGgpc1dU/NrdDM+lcCkQpGn0sMYMkcM/fDFagR3QmrcjqFzPTMVSTzmEUQ
         XnbWrNLpKUVDB2zBvvs/IDKQ+Y9TX1il2WrNZiAzo7rzjI+MAo7SKScJ4Qk+WiJHoUwg
         lCf0rGcMN+EBHumAdH2bCzPzrRnjzm/o+irbR2Sgkx6KkDh3SE+fGiBgbInkOOyDdD1L
         qRSec19A716uMhBkgaXD6lgBino8RfWGJhkSsbqxg108L7EwUH4rWNYzOTjWWVfr1t7A
         rDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5BNLluTPcpkr8B4gIUADQZy/9CuaYtTWeWTH5QovX+s=;
        b=mGXiob46HIVz+69maSycvy1xrqb5sUFsgcHJ097ZXA5rFBNgBFSfjJp2R1JmOwBhyh
         YVtpUaRJdv7EImkonXLu/RyE7orj0qCtCV2YSZa70zdwcqg7f5zNLYInXBrgVrlpaooO
         0CYkeL9e+sQKrnK7qY8zoS6rLkoSgXRFc7MWvIEoMaF7utGQISlgQuay+7kQVKtn5O6P
         do76Y1wxdfnIfsmO9scur9H5WqmuKV8AH44G7PxqANvYCSe1v/CL1BrffLMcnhLAYEWs
         vLXfsrg30rlLuf1k2daFTlHxtZoK6YPB04La/RGpHMxMiFQdFhBx8rP0y3IaAgDMiP9l
         FKeg==
X-Gm-Message-State: AOAM531Gh0PF36SX6pBhE5uNOm0C1aFH0z3W+MAYjrIKdx6RQf3BB6VR
        E5s4nlKsgAb6sYgWpN/VfoY=
X-Google-Smtp-Source: ABdhPJwliv8blUAUbcICceFtO9VG/0CZHjyIfJNtxoF2L0OtgJBVK6I9uRxoK5xucgC1rDohuIchOw==
X-Received: by 2002:a0c:ca0c:: with SMTP id c12mr6854939qvk.47.1621529948974;
        Thu, 20 May 2021 09:59:08 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id h8sm2128602qtp.46.2021.05.20.09.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 09:59:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 May 2021 12:59:07 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH] wq: handle VM suspension in stall detection
Message-ID: <YKaVW0WVu317LP7L@slm.duckdns.org>
References: <20210520101422.660054-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520101422.660054-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 07:14:22PM +0900, Sergey Senozhatsky wrote:
> If VCPU is suspended (VM suspend) in wq_watchdog_timer_fn() then
> once this VCPU resumes it will see the new jiffies value, while it
> may take a while before IRQ detects PVCLOCK_GUEST_STOPPED on this
> VCPU and updates all the watchdogs via pvclock_touch_watchdogs().
> There is a small chance of misreported WQ stalls in the meantime,
> because new jiffies is time_after() old 'ts + thresh'.
> 
> wq_watchdog_timer_fn()
> {
> 	for_each_pool(pool, pi) {
> 		if (time_after(jiffies, ts + thresh)) {
> 			pr_emerg("BUG: workqueue lockup - pool");
> 		}
> 	}
> }
> 
> Save jiffies at the beginning of this function and use that value
> for stall detection. If VM gets suspended then we continue using
> "old" jiffies value and old WQ touch timestamps. If IRQ at some
> point restarts the stall detection cycle (pvclock_touch_watchdogs())
> then old jiffies will always be before new 'ts + thresh'.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Applied to wq/for-5.13-fixes.

Thanks.

-- 
tejun
