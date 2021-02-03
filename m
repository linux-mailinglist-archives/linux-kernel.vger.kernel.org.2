Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B81330D22D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 04:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhBCDcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 22:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhBCDbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 22:31:02 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D751AC0617AA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 19:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=qwvCwcChuxtahpY7NTqPCpmTFzPp7YMpsonMHOpWMJs=; b=v0LWgPEVfKiboGCZFhUvlemZX2
        3SKMqGZFjp378WH+F8vozQGEWbrjScFkTP1F1N1iCOHknl28nj3/VeyIRwNJ8OEwdJ6KbhLNJqE5h
        +uCFW+BdTB5gL5SIhY8Zg2X0KYN3hdDxJ85Dk57Jbin7KaJaTw/V3pCFXRGoaWhrJPS2PqJislbYa
        10SuJFausicUvheoY/yH/LVHKopcTtbpC7X+WXfw9uUb2FDP+JR1g/wGGNxMONnudIl/GCWMx+i9d
        u5iaj8XcMRNq+AjPx2+JJBNqrSKGMqy47M8kb6KhZKtm2nmD7/1TPPgMC0AieE85XCoMjnf7sEBzh
        nnXKieWQ==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l78s9-0001XB-I1; Wed, 03 Feb 2021 03:30:29 +0000
Subject: Re: [PATCH][RESEND] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Timur Tabi <timur@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        akinobu.mita@gmail.com
References: <20210202213633.755469-1-timur@kernel.org>
 <YBoXUxGBcG97BvML@jagdpanzerIV.localdomain>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <702f6f68-7455-337b-e0f3-6947a51c142e@infradead.org>
Date:   Tue, 2 Feb 2021 19:30:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <YBoXUxGBcG97BvML@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 7:24 PM, Sergey Senozhatsky wrote:
> On (21/02/02 15:36), Timur Tabi wrote:
>> If the make-printk-non-secret command-line parameter is set, then
>> printk("%p") will print addresses as unhashed.  This is useful for
>> debugging purposes.
>>
>> A large warning message is displayed if this option is enabled,
>> because unhashed addresses, while useful for debugging, exposes
>> kernel addresses which can be a security risk.
>>
>> Signed-off-by: Timur Tabi <timur@kernel.org>
> 
> Looks good to me.
> 
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> 	-ss

Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
