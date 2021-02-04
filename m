Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B266310004
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBDWVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:21:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229513AbhBDWV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:21:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42AD664E0F;
        Thu,  4 Feb 2021 22:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612477248;
        bh=srANFyFRjZWUNqLmRWYde2yLB0hjm8XnDjUMhIBivaA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uXKII3KVqIM0KWZWfAoo2nXt1jcb0OXHPDihGTijgToz9tmaCzJhwQcvmlg9BBqM5
         nQR5XjwW4SoF18hpz53DrVO4LNU+OA41fza2i7qi8mnLbtTBe+Zn06vcoOMZ2uWG8f
         bKnL5n2vPCc8dki0w7V3kCAoP7ZYpMKKQql6gtHpYzpEz4KCRO0eIZoUe99+dmX8/M
         8EApnY+PDIg3pcpwMXk1WQE8bXAnp9YRUNrmmJVJV4ADTvW6YR8jms+gujpIragUlf
         OK0iWWkW5CkSXWKxbI3/JEMv1pNYOd6TnRdRUq1Lmn5sPUeMKomjtIca/Sn/NSP5bw
         /mzYm+E1bIOyg==
Subject: Re: [PATCH] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
To:     Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        john.ogness@linutronix.de, akinobu.mita@gmail.com
References: <20210202201846.716915-1-timur@kernel.org>
 <20210204204835.GA7529@amd> <20210204155423.2864bf4f@gandalf.local.home>
 <20210204214944.GA13103@amd>
 <873d7e08-7a70-a1a3-f486-882d1d515965@kernel.org>
 <20210204221143.GB13103@amd> <202102041415.D9093ED6@keescook>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <13fdd006-3070-fb6a-cd99-7f845deb6843@kernel.org>
Date:   Thu, 4 Feb 2021 16:20:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202102041415.D9093ED6@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/21 4:17 PM, Kees Cook wrote:
> It's just semantics. Printing addresses DOES weaken the security of a
> system, especially when we know attackers have and do use stuff from dmesg
> to tune their attacks. How about "reduces the security of your system"?

I think we're bikeshedding now, but I can replace "compromise" with 
"reduce".

"Kernel memory addresses are exposed, which may reduce the security of 
your system."
