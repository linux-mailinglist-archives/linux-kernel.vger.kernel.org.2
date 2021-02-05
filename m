Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75968310FE4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhBEQqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:46:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233294AbhBEQnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:43:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62B4D64E4D;
        Fri,  5 Feb 2021 18:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612549524;
        bh=hb309p839a18x47275kXH8RdkKDWYDg5Qa7e2tIfzIU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=PP/2qv0ejvMgDlya0fseiY1tFEzYeNhIgoz2v+eezRT1XWzBYyjXcEICJm8sun0kQ
         aSi59nceGXXXGoj4w4mG4ZYipqkso3wM8Wpb9AOeGReZI+iP9cz73lozokotMkju6f
         mkcnrMgEhT9vuowqgW8VHdUByJb+SOMtWCcYTdTu6RSEYHZutHEr2wEaGl63bnkefa
         cAHibiZPqBznjlN6ge11tK2orMz+XjWsUerZswaMzxDb9+YRMkh9qHfSOzVDQMOjOf
         Yh8Unu4ucUnxv6cEJ4SleeSrWn1cgwOFVv6mbh2veyyaKljuXo6SI6z4W9oJP8TVKR
         0HK075rWG8bkA==
Subject: Re: [PATCH][RESEND] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
To:     Vlastimil Babka <vbabka@suse.cz>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        akinobu.mita@gmail.com
References: <20210202213633.755469-1-timur@kernel.org>
 <3baace45-38af-a59b-c376-9a4c39a17b2d@suse.cz>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <d6223371-a5e7-28ac-704c-0e3d5b7ea713@kernel.org>
Date:   Fri, 5 Feb 2021 12:25:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3baace45-38af-a59b-c376-9a4c39a17b2d@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/21 4:59 AM, Vlastimil Babka wrote:
> Thanks a lot. Should this also affect %pK though? IIUC, there's currently no way
> to achieve non-mangled %pK in all cases, even with the most permissive
> kptr_restrict=1 setting:
> - in IRQ, there's "pK-error" instead
> - in a context of non-CAP_SYSLOG process, nulls are printed

Hmmm..  I thought %pK prints an unhashed pointer when the user is root, 
at least in situations where the user can be known (e.g. during an ioctl 
call).

> Yes, neither should matter if %pK were only used for prints that generate
> content of some kind of /proc file read by a CAP_SYSLOG process, but that
> doesn't seem to be the case and there are %pK used for printing to dmesg too...

I thought about that.  On one hand, people who use %pK probably really 
wanted a hashed pointer printed.  On the other hand, I agree that %pK 
should not be used for dmesg prints.

I get the feeling that some (most?) people who use %pK don't really 
understand how it's supposed to be used.

I can extend make-printk-non-secret to %pK if everyone agrees.
