Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC223B679C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 19:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhF1R3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 13:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbhF1R3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:29:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE905C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 10:26:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i94so22234875wri.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 10:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LZaQintISlZJCkPYDHZ8cGD5rume+lAMgOMf9rTs6CQ=;
        b=kQBBB27ZYYImzNq5zbtEUc1V6h2xp/UpWHhlDlkkUvn1bYykmALm0dAZDEAFnEPKAH
         kdbURmRaMUj1nDA+BHGPm/xWhDlD85xsKX0HQbFGVFfcxbbrzs3c1HuUkylFtrfHa0Qh
         uxGuDz8PB9llZQcaNioqFW3QscKfQ1mToSdTVKJxcd+RTLzHwvEsRIFjpDjHjzLwzpDg
         mJ1g+r2D964hD33biZoQvT81di67R8eoQHNRg6w3FcJRlBkUJi4IMpb3FbLfpqWe8MbO
         k+FmYNxJtcNjMBQzXAPJD3snkLk44+Z96sTkjl2evWoRnu3v2lIku3gUnNsPip+PtKpn
         btWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LZaQintISlZJCkPYDHZ8cGD5rume+lAMgOMf9rTs6CQ=;
        b=VfalgvDez2+BMcqy/1VC+FGJAqpUGJDQodA9F3hZWSeXVUN9iHoR5/Iy7AOLZbH7+D
         +OUcSTpnzebLGTerfHzMbhpf0gDhrD36lTsX6qSoEm+lvEtpmXmua4foU0T0pWoRSsOn
         8/jTeilqueV5tLFstELdQHyRrrgRWctLPzyhwXsR4TIEfAFhQnpYKkRqAmqtwckNXPiE
         VL9xTByy6OX4H3NJsNFJIG5H799m7qedTfgwiTFoOFeBVNf+UiYGIy0+Dmj/DLVuoLDD
         PLqIxH7eKKPYlHFMZZjckcGk0hAO3Itg9QFGW0SvU0nh7zOuaWbbql8TQvQhHdSyNV9e
         LuYA==
X-Gm-Message-State: AOAM533B/l8yQmUXmxPzTJMcaaJIAhfhReLKetYpxuUNoNuxE5CrNx0A
        K8GNs/IzccW3usb3FRoYk8Ve9Q==
X-Google-Smtp-Source: ABdhPJwD2oqrCgTTPQjPLVYzWq7He5NA2xpzW5IlJeEWJoIn1Y7sg6AR7wCkpSyJak7kcBAaUPgIHQ==
X-Received: by 2002:a5d:46cc:: with SMTP id g12mr12049466wrs.136.1624901194223;
        Mon, 28 Jun 2021 10:26:34 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id b5sm14059741wmj.7.2021.06.28.10.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 10:26:33 -0700 (PDT)
Subject: Re: [PATCH] printk: Add CONFIG_CONSOLE_LOGLEVEL_PANIC
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20210622143350.1105701-1-dima@arista.com>
 <YNWeIks8NC1i2w96@alley> <8e7dae6f-e67c-b961-4986-883e1db0c566@arista.com>
 <YNnD3b1wKfDODKnw@alley>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <335af380-3bb0-c1c4-ddd5-5c9585d12612@arista.com>
Date:   Mon, 28 Jun 2021 18:26:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNnD3b1wKfDODKnw@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 1:43 PM, Petr Mladek wrote:
[..]
> Is it enough to keep the current level during panic()?

Yes.

> It might be
> easier to introduce a commandline option, for example, no_console_verbose_panic.
> It would do:
> 
> static inline void console_verbose_panic(void)
> {
> 	if (!no_console_verbose_panic)
> 		console_verbose();
> }
> 
> It is clear what it does. On the other hand, the logic with particular
> loglevels is not clear. 3 different proposals has already been mentioned
> in this thread:
> 
> 	if (console_loglevel &&
> 	    (CONFIG_CONSOLE_LOGLEVEL_PANIC > console_loglevel)) {
> 		console_loglevel = CONFIG_CONSOLE_LOGLEVEL_PANIC;
> 	}
> 
> vs.
> 
> 	if (console_loglevel)
> 		console_loglevel = CONFIG_CONSOLE_LOGLEVEL_PANIC;
> 
> vs.
> 
> 	if (console_loglevel && CONFIG_CONSOLE_LOGLEVEL_PANIC)
> 		console_loglevel = CONFIG_CONSOLE_LOGLEVEL_PANIC;
> 
> 
> Just imagine that you are a distributor, developer or admin:
> 
>    What value you would choose for CONFIG_CONSOLE_LOGLEVEL_PANIC?
>    What console loglevel will be used at the end?
> 
> The answer depends on the implemented alhorith, console_loglevel,
> and CONFIG_CONSOLE_LOGLEVEL_PANIC.
> 
> The answer would be much easier if "no_verbose_console_panic" is
> used instead.

Thanks for your replies, Petr, I'll send v2 with the function rename
patch and a patch to introduce this boot option, after the merge window
closes. I appreciate your inputs :-)

Thanks,
          Dmitry
