Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AED315C17
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhBJBUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:20:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233478AbhBIWQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:16:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EDD364E56;
        Tue,  9 Feb 2021 22:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612908926;
        bh=0/Nk2UkuxA+ITAZU8i4aiVofSUv2nNvX1ns749mDVdU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=or3bF4mZbUon8GBxxqUQDPJmS4jdw95al2dE5CQxoFPMU6gRPZRfNTrJb8LY9ddaq
         3C5hnV+T2CJJN9glfhmapD2ikVa3z1LTfImVtnihe2MpMSdKj+VZV8hABXOqWyTVpJ
         fHy30qvSV227DtmZB2SxzNQ852WHNT6kRJrdfIfIocRR4h40XsgMC7w5zWZVwCQmBZ
         NTlSgJNQbtAJfGBneGdNTITWtmhUvNtU53vvZZbOImHAQYP+QYGvXIJDudF11VMic4
         gWctk8srlXLQKemh8TYpQMb8cZxVKtr69vA/rnRK/bcol4n+WSIzA8NeplAKnLM4oj
         rWm6IIC1p0vGQ==
Subject: Re: [PATCH][RESEND] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
To:     Marco Elver <elver@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        akinobu.mita@gmail.com, glider@google.com, andreyknvl@google.com
References: <20210202213633.755469-1-timur@kernel.org>
 <YCMFzCz8ootub9pH@elver.google.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <2de3a189-adca-4954-e2a3-c79fbe3eee96@kernel.org>
Date:   Tue, 9 Feb 2021 16:15:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YCMFzCz8ootub9pH@elver.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/21 3:59 PM, Marco Elver wrote:
> Would it be reasonable to make this non-static? Or somehow make it
> possible to get this flag from other subsystems?
> 
> There are other places in the kernel that dump sensitive data such as
> registers. We'd like to be able to use 'debug_never_hash_pointers' to
> decide if our debugging tools can dump registers etc. What we really
> need is info if the kernel is in debug mode and we can dump all kinds of
> sensitive info; debug_never_hash_pointers is would be a good enough
> proxy for that.

The next version of my patch (coming soon) will export the symbol.  It's 
intended for test_printf, but if you think it can be used by others, so 
much the better.

