Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C6C30CED3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbhBBW1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235107AbhBBWUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:20:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52F0F64EDA;
        Tue,  2 Feb 2021 22:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612304362;
        bh=sqKuQs7jQgfFKC1Q1g879kjxuInD33WZU6Kyi8Egc/s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZHIzuLiLZYUnhnmDOcDkihUadtik/Hl9/62tXeZxuBIZgmOeS5F6w2tafqAP9+RSZ
         6tWnZR37PWEVFo9PFkg1HgUWpn5JNwQDPvox5Agspa/bGIPaDin7dCYN3Cv7KUqX1z
         uRwiO1hUPHlwldfUNapMM+0VrhDzAtJJBbauqoEVSaT6BvR1W91fn8/nBjuex7dy2P
         WMEzO80pm1v98Zx1ZthQcdGieCx5WpkeDVKrhsnfEbTssOqX5Ydjur1svvVpPrx2Zi
         KgTid3VeyZx7fqVuxizToCDvnnvlbPUQKvghI1RCaky/X3JbrZ7w3xuyEh+0o1jWh9
         Joo9Jikwe236Q==
Subject: Re: [PATCH] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
To:     Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        john.ogness@linutronix.de, akinobu.mita@gmail.com
References: <20210202201846.716915-1-timur@kernel.org>
 <202102021351.AEDE896AB3@keescook>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <9ce56a1c-9ea6-996b-84c6-cfde908c2ecd@kernel.org>
Date:   Tue, 2 Feb 2021 16:19:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202102021351.AEDE896AB3@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 3:52 PM, Kees Cook wrote:
>> A large warning message is displayed if this option is enabled,
>> because unhashed addresses, while useful for debugging, exposes
>> kernel addresses which can be a security risk.

> Linus has expressly said "no" to things like this in the past:
> https://lore.kernel.org/lkml/CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com/
Maybe I misunderstood, but I thought this is what Vlastimil, Petr, 
Sergey, John, and Steven asked for.
