Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0069342EE4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 19:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhCTSVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 14:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCTSUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:20:49 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A760C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 11:20:48 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g15so6442617qkl.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qjtwcm8fTgfE4yO/PEWWKlgJq9PQJ431uqNdo6ZHTRY=;
        b=aZGqiNkBU3FtTfzXguJ9fM7L8HsQEHbXBrYDTTOBhAgcYWpmDKpuUDo7cu1Gbqgh7G
         FcXBdR53mDAQN/h32tYE/Rz+4atVPwNmiQIro/WjSVG+o+3n6IjAYFhUBUaXHy5neHtC
         y/n6XT5Cpm0m/obhRuZLVuHoYzSTXy6u3Tu6bhwSyKODrrwIApx6sPIMQ4xB9DI8qE+f
         RACbb/Ktf+M6dj9zT1VwcqY9b4h0cQpzwWRR84BNS814G2P5Khwv/glKsPLUfmd0o/LQ
         oPPRxm7HCuanYMA0eDvrxSxAYWeM/Le8Iql4GnTBiYj/hOxF5Nd/FUhtBYhnJWeJldLZ
         B7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qjtwcm8fTgfE4yO/PEWWKlgJq9PQJ431uqNdo6ZHTRY=;
        b=nDW12ftJKid/hJdiTvOb6Lw3sXrO/rP6zctb6iHH0wvgfrRzmVH548AJmf3lZga05z
         CDlSzuWbwPwlx3PqxdCS8C/EJ+9m90B2XAxWOV3KNqRb5PYNqQ7em/ajp15CmtUqY4CQ
         eULYOVjEmeXDjpvfTUmXbbcIMUYZNNg5nFnTkj58jujP5MsPI6Npbu2jeUKzgXLFKV0W
         zkUDEpND/CyfsHdqGRDGtI0MYUZc7sSaNx0Lkp1/ZIUcQVmCGioV3lq+6B8ZzNvalhu6
         kr+hKhABuU/nxtoj6VcfOY3XFfsF4sVNPP3onNyh8PUybyTsQXpopNozvZ4QEp9U6pCi
         emIQ==
X-Gm-Message-State: AOAM531J9lsm3g3TXYtKYOuLJdV0aAozQeEelv3PHnaFojbLumfskcMn
        +TJMB3n017rl/Uch2WHzKtA=
X-Google-Smtp-Source: ABdhPJx7mQ6YjoT/7LdEReVD4sPb2YAM1LxG7u47Y/V+0uV3uircrrsB9wj+nC7+a8kuY0RJIpW2pg==
X-Received: by 2002:a37:408:: with SMTP id 8mr3963942qke.406.1616264447660;
        Sat, 20 Mar 2021 11:20:47 -0700 (PDT)
Received: from localhost (2603-7000-9602-8233-06d4-c4ff-fe48-9d05.res6.spectrum.com. [2603:7000:9602:8233:6d4:c4ff:fe48:9d05])
        by smtp.gmail.com with ESMTPSA id y8sm6305723qtn.68.2021.03.20.11.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 11:20:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 20 Mar 2021 14:20:46 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andrey Ignatov <rdna@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] workqueue: watchdog: update wq_watchdog_touched for
 unbound lockup checking
Message-ID: <YFY8/u0Bmf8TpJTS@slm.duckdns.org>
References: <1616140838-24222-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616140838-24222-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 04:00:36PM +0800, Wang Qing wrote:
> When touch_softlockup_watchdog() is called, only wq_watchdog_touched_cpu 
> updated, while the unbound worker_pool running on its core uses 
> wq_watchdog_touched to determine whether locked up. This may be mischecked.

Can you please elaborate here, preferably with a concrete scenario where the
new code is better?

Thanks.

-- 
tejun
