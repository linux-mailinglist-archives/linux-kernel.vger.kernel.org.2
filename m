Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BF331EB65
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 16:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhBRPRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 10:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhBRMXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:23:33 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B7BC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 04:21:58 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id t11so5160402ejx.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 04:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2jntTY6KjrXzGhj4wQ8ErItvzH/dYtJsdj3IZjK14aA=;
        b=xNILjLMKtpGQpmfZrj0WxmAi5N2HXaWpV9UtS+plRZxlLUDMSy/RfRYROetankfVrg
         p3LEotiu2MjtLEOAKK0XZFhBxuD2oHBcskippngfaDDwA0LMG6HQPI04eDA1c9JH1Y1a
         V6AX155VYFHHMBKVJMidIlIpX7gTbka+Irfr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2jntTY6KjrXzGhj4wQ8ErItvzH/dYtJsdj3IZjK14aA=;
        b=HMuMGlQI+52wSBT1ueLHfWD4lszCda7M9vKixyEy5wxbRj1QZSK/QW2OPwmOpcybDh
         5oMpHdUZB7Il8GPE80aMJgoJCUK7bWEzA6wb10ERVXj5B+wyndH+8+uAQhgJB+tnqtx/
         J05fXAb8FDcOschEOaA4DSTKscKtaAg3nNWlSz4uoj4PC+obg+iMN/NUM9Q77uWI+lDO
         DIovQyjoSbcA9Oj7q0SpW1YA4MtZH486tYrnz+fOA+rTKWN3kc3bzWGbFa6MtYzoDhZt
         qTiwWM232p7F5YC/o6WXrrdFz+u3MnO4mnY2GgW+v5K/nOINNIeASwv85rc7Fq42wS2f
         MiFw==
X-Gm-Message-State: AOAM531wtJ8QBMKcCnKr67fUQQFcQSzaw3m55Hqwy8XSyQ835wjhTxps
        aZlvCPhUIPum6GFAFEEEep9DBJ/JFbRO/za1
X-Google-Smtp-Source: ABdhPJzd9C3+00/Cpfa9vGeNmoTvsCeKiiAP+oNZ5VVdoIBFauUJbk5V8/vp3up38Lb38lvx8/GrWA==
X-Received: by 2002:a17:906:1944:: with SMTP id b4mr3723494eje.342.1613650916905;
        Thu, 18 Feb 2021 04:21:56 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:f7e9])
        by smtp.gmail.com with ESMTPSA id an10sm2318681ejc.106.2021.02.18.04.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 04:21:56 -0800 (PST)
Date:   Thu, 18 Feb 2021 12:21:55 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v4] printk: Userspace format enumeration support
Message-ID: <YC5b4+hTjrGwG22o@chrisdown.name>
References: <YCafCKg2bAlOw08H@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YCafCKg2bAlOw08H@chrisdown.name>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all your feedback, Petr and Steven. :-)

Petr, I believe this is a comprehensive checklist of everything we discussed 
for v5 -- any chance you could double check I'm not missing anything you folks 
wanted? Thanks!

- Use seq_file iterator again instead of simple_open + size
- Remove debugfs file first to avoid ENOENT
- Tear down datastructures if debugfs fails
- Human readable output format
- Display file/line
- Rename to CONFIG_PRINTK_INDEX, or... something
- Move to another file, kernel/printk/debug_formats.c or similar
- Use `struct module *mod` instead of calling it module
- Add documentation for printk_fmt_sec (or whatever it will be called)
- Rename things to pf_, pi_, or something
- See if it's safe to pass a printk_fmt_sec to seq_file instead of a module
- Handle cont + level
- Don't expose level/KERN_SOH directly
