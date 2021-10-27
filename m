Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C886343D184
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 21:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbhJ0TTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 15:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbhJ0TTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 15:19:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B81C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 12:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=PFxJclxC4gkSujS9yQI/UoJfTtbUkvazOvEzKPW8tGc=; b=w523WTUABZTDkSAhIutc/cgd4C
        sVTd9M8fsZHOUl9h4rTeYls9csjdTiDa2IHsC19pBZC+h71VRpEk+e0W6Wf/crM8XGgliYARGB7M6
        wDZFqCLY+//UiE/hd0r+HDWQ4AeKdsmw0yT4LtCeC9FsVggwYFWTZVtSTCV3JCgVw9XoNuCIMOiLv
        jZYcwfXo1d/x8JB736GJPxA/lSkkfILkDwIKYOYfWiEXHSSa36pbLSKp5aQP8HX5mYhJ/Z7XeMYlD
        46avI1wUE/ulHC7GOEYp4rV0J8ZeQ3cKBKNuQHLhN1ZgeMAYYCCNjWTOr+yHuOckDDLBPUDZVgPNN
        6rtBWG7g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfoPn-005qzr-Tf; Wed, 27 Oct 2021 19:16:48 +0000
Subject: Re: [PATCH] nds32: ftrace: fix pointer comparison warning
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zong Li <zong@andestech.com>, Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>
References: <20211027055554.19372-1-rdunlap@infradead.org>
 <20211027075936.7fd3e7a5@gandalf.local.home>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5aa76c29-833e-8899-12d7-7db59a795240@infradead.org>
Date:   Wed, 27 Oct 2021 12:16:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211027075936.7fd3e7a5@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/21 4:59 AM, Steven Rostedt wrote:
> On Tue, 26 Oct 2021 22:55:54 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> GCC 11.1.0 for nds32 (nds32le if it matters) complains:
>>
>> ../arch/nds32/kernel/ftrace.c: In function '_mcount':
>> ../arch/nds32/kernel/ftrace.c:24:35: error: comparison of distinct pointer types lacks a cast [-Werror]
>>     24 |         if (ftrace_trace_function != ftrace_stub)
>>        |                                   ^~
>>
>> Cast the second function (pointer) to (void *) to avoid the warning.
>>
>> Fixes: a18082575c66 ("nds32/ftrace: Support static function tracer")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> To: Greentime Hu <green.hu@gmail.com>
>> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Zong Li <zong@andestech.com>
>> Cc: Nick Hu <nickhu@andestech.com>
>> Cc: Vincent Chen <deanbo422@gmail.com>
>> ---
>>   arch/nds32/kernel/ftrace.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-next-20211026.orig/arch/nds32/kernel/ftrace.c
>> +++ linux-next-20211026/arch/nds32/kernel/ftrace.c
>> @@ -21,7 +21,7 @@ noinline void _mcount(unsigned long pare
>>   
>>   	unsigned long ip = (unsigned long)__builtin_return_address(0);
>>   
>> -	if (ftrace_trace_function != ftrace_stub)
>> +	if (ftrace_trace_function != (void *)ftrace_stub)
>>   		ftrace_trace_function(ip - MCOUNT_INSN_SIZE, parent_ip,
>>   				      NULL, NULL);
>>   
> 
> Or update ftrace_trace_function prototype that was missed when ftrace_stub
> prototype was updated.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> diff --git a/arch/nds32/kernel/ftrace.c b/arch/nds32/kernel/ftrace.c
> index f0ef4842d191..711bc8cd186d 100644
> --- a/arch/nds32/kernel/ftrace.c
> +++ b/arch/nds32/kernel/ftrace.c
> @@ -6,7 +6,7 @@
>   
>   #ifndef CONFIG_DYNAMIC_FTRACE
>   extern void (*ftrace_trace_function)(unsigned long, unsigned long,
> -				     struct ftrace_ops*, struct pt_regs*);
> +				     struct ftrace_ops*, struct ftrace_regs*);
>   extern void ftrace_graph_caller(void);
>   
>   noinline void __naked ftrace_stub(unsigned long ip, unsigned long parent_ip,
> 

OK, looks good.

Thanks.

-- 
~Randy
