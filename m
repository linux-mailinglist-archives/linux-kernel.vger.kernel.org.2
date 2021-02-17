Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8204B31DCCB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhBQP5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbhBQP5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:57:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E617BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:56:40 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b3so17924189wrj.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CUD/qkEdRQMqVMl09PT+Tu7UX/cxWMQto0OUC6zfk9w=;
        b=Q5PydiK1ZqRUGf7r4lW9z+qGripuuLxKo/lBqj+fKgFVr/+MA52ufZGNNXYbn7I5xK
         A5wdPvXgG8T2P3pka/m9+NLPI2stryOCJmsH47AjFZQFIugXhlnBnsJ4qj7STyP+2yw3
         Zq1wNVGQHu/ZzcK/j3kjWGF2scJRWytv/WGtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CUD/qkEdRQMqVMl09PT+Tu7UX/cxWMQto0OUC6zfk9w=;
        b=F0ZEFA7z/NP3tGVfyG9qiXHWC8cLL/0vlKwNvTs3D9h9EGMAn/dCSsz/J4EkK19oEZ
         EHkVINjdRc4h/DGM0wjtvYZSmlNXGKwa8TMJoqmmJhpgcU9iUEVHZsnadYtUvUioOVOn
         t0CF9GWldQlFwOIZQRB+HD6bqdH0Z6uk2N0WiC+874WcCXOS3H1asTNSjzQgrThqH8U2
         xv//GKuQXWw6YEBBT6PgvBUFrCwh8ss1uS8se16beWBc62S7VpobIqE1YU95I5VkHNVd
         RX3YPhI6aUrCuAdXAwgT1wRIegftvUxb+s0ahuR/56GJziR13NIFmeqHwjjl+v674x1t
         UNqQ==
X-Gm-Message-State: AOAM532OHPWc+H33esml+nLvzrBjgnaC/4E6snpzs2Y1IOckIUazRhYU
        Gi3/x7fmEDiSjpDo9oQwtCLX3w==
X-Google-Smtp-Source: ABdhPJxUCdI0ADHAgZvrUn7+5qC3CT1r7CnzQcAFbOHFianQP7Vswa7xW5uaWeqDPWnSZoQr7hBHBA==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr4554499wrn.20.1613577399471;
        Wed, 17 Feb 2021 07:56:39 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:76fd])
        by smtp.gmail.com with ESMTPSA id m17sm3457344wmq.5.2021.02.17.07.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 07:56:38 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:56:38 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: code style: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YC08tgirtDsZumkK@chrisdown.name>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCv9Xb7ePnDy9xRf@alley>
 <YCwAbGoVuZJspcx5@chrisdown.name>
 <YCwycC8hPsPD7ArU@cmpxchg.org>
 <YCwzrLTaE9PwNihj@chrisdown.name>
 <YC06LyPGmytXJ8Iu@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YC06LyPGmytXJ8Iu@alley>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>> > How about config PRINTK_INDEX?
>>
>> Ah yes, I also like that. PRINTK_INDEX is fine from my perspective and is
>> more straightforward than "enumeration", thanks.
>
>It is better than enumeration. But there is still the same
>problem. The word "index" is used neither in the code
>nor in the debugfs interface. It is like enabling cars and
>seeing apples.
>
>What about CONFIG_PRINTK_DEBUGFS?
>
>It seems that various subsystems use CONFIG_<SUBSYSTEM>_DEBUGFS
>pattern when they expose some internals in debugfs.

The thing I don't like about that is that it describes a largely
inconsequential implementation detail rather than the semantic intent of the
config change, which is what the person deciding what to include in their
config is likely to care about.  Often when I see "XXX debug interface" when
doing `make oldconfig` I think to myself "yes, but what does the debugfs
interface _do_?".

If someone else was writing this patch, and I saw "CONFIG_PRINTK_DEBUGFS"
appear in my prod kernel, I'd probably say N, because I don't need printk
debugging information. On the other hand, if I saw "CONFIG_PRINTK_INDEX", I'd
immediately understand that it's probably applicable to me.

I'm happy to rename the debugfs structure as <debugfs>/printk/fmt_index if it
helps, but personally I really feel CONFIG_PRINTK_{INDEX,ENUMERATION,CATALOGUE}
is a lot more descriptive than just saying "it has a debugfs interface" in the
config name for that reason.
