Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DC034AAAB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCZO7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhCZO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:58:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7C3C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:58:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ce10so8864387ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CfALI4Jjk9ExTBAv2QTg2oMERYIeKnf63ev+al3XN+o=;
        b=Kac1k/Osslvkk1RN01fULSfgmf2XB5KK3ha5BO1hap3ZCuVFcqj9wW5aBBtmtgUGr3
         uEE3tHyQtJiax7A1ahlBd0ZMf8sU5dp4lw6BqnJKYzgwo6VvJVno8YJ0MgzjEOQTNPhw
         5szOHfFB32XpbYT4uk0Mm8XPAfOEwnHcp/swI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CfALI4Jjk9ExTBAv2QTg2oMERYIeKnf63ev+al3XN+o=;
        b=Qoxi7+bCO+VSZJG9A8qt0fIbXvdJEA598/jcydMigd5cuj2RdU6SHWltL7NkJAXMIZ
         JyZHekSce0a7rIv0q+o20wL05knOaVJfYYrMiklqiyvbMZUNT0AKh1WGI0qwIexpwrQj
         CJj3Ut5V6LU+vD/E2AQv/7hn4fe7LBF0DJ/WQVq/P6zbCkZcg5VGFR1of0Vb2c7AyhYj
         zumdfYFcSNlHbXODWTegADZiRJPe+PKg4Vxdjo84wauZ0su4N5GtAxqxH4x/L/U2xHND
         fS1v94FJvAdwf9rlqrxX3Mzkiju3nLwSKn6hZ9Z2Ap/iILGcOin91HApYBaXuT9CpmuZ
         N62w==
X-Gm-Message-State: AOAM530YftD+j2lq7fokwI2Gs9EALQZKfO6Gkf8Mwk0OpDWwdT0Q70AV
        SYZ/Q39Qwsm3A67Xddsy2DrQGiISQzn7EZFK
X-Google-Smtp-Source: ABdhPJx1oimfvqUpbBIo2oWjqp8cQ20I/tqqM35MCT9tgfRXIk1FJCQXol9RFyR9qPSXsXfwuOFI0w==
X-Received: by 2002:a17:907:211b:: with SMTP id qn27mr15721468ejb.203.1616770719224;
        Fri, 26 Mar 2021 07:58:39 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id d5sm3931066ejc.98.2021.03.26.07.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 07:58:38 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] debugfs: Implement debugfs_create_str()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg KH <greg@kroah.com>, mingo@kernel.org, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org> <YF2/41K4xs3ZOQdV@kroah.com>
 <YF3DF+T8nPRgt7Ao@hirez.programming.kicks-ass.net>
 <YF3F0JbbEpeSGzW6@kroah.com>
 <YF3Hv5zXb/6lauzs@hirez.programming.kicks-ass.net>
 <70594935-18e6-0791-52f9-0448adf37155@rasmusvillemoes.dk>
 <20210326142230.GJ4746@worktop.programming.kicks-ass.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <c1be3728-40e7-f200-ece0-cd3f11349f65@rasmusvillemoes.dk>
Date:   Fri, 26 Mar 2021 15:58:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210326142230.GJ4746@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2021 15.22, Peter Zijlstra wrote:
> On Fri, Mar 26, 2021 at 01:53:59PM +0100, Rasmus Villemoes wrote:
>> On 26/03/2021 12.38, Peter Zijlstra wrote:
> 
>>> +
>>> +again:
>>> +	rcu_read_lock();
>>> +	str = rcu_dereference(*(char **)file->private_data);
>>> +	len = strlen(str) + 1;
>>> +
>>> +	if (!copy || copy_len < len) {
>>> +		rcu_read_unlock();
>>> +		kfree(copy);
>>> +		copy = kmalloc(len + 1, GFP_KERNEL);
>>> +		if (!copy) {
>>> +			debugfs_file_put(dentry);
>>> +			return -ENOMEM;
>>> +		}
>>> +		copy_len = len;
>>> +		goto again;
>>> +	}
>>> +
>>> +	strncpy(copy, str, len);
>>> +	copy[len] = '\n';
>>> +	copy[len+1] = '\0';
>>> +	rcu_read_unlock();
>>
>> As noted (accidentally off-list), this is broken. I think you want this
>> on top
>>
>> - len = strlen(str) + 1;
>> + len = strlen(str);
> 
>   kmalloc(len + 2, ...);

No, because nul-terminating the stuff you pass to
simple_read_from_buffer is pointless cargo-culting. Yeah, read_file_bool
does it, but that's just bogus.

>> - strncpy(copy, str, len);
>> + memcpy(copy, str, len);
>>   copy[len] = '\n';
>> - copy[len+1] = '\0';
> 
> I'll go with strscpy() I tihnk, something like:
> 
> 	len = strscpy(copy, str, len);
> 	if (len < 0)
> 		return len;

To what end? The only way that could possibly return -EFOO is if the
nul-terminator in str vanished between the strlen() and here, and in
that case you have bigger problems.

> 	copy[len] = '\n';
> 	copy[len + 1] = '\0';
> 
>>> +EXPORT_SYMBOL_GPL(debugfs_read_file_str);
>>
>> Why?
> 
> Copy-pasta from debugfs_*_bool(). This thing seems to export everything
> and I figured I'd go along with that.

I thought the convention was not to export anything until the kernel
itself had a (modular) user. But I can't find that stated under
Documentation/ anywhere - but it does say "Every function that is
exported to loadable modules using
``EXPORT_SYMBOL`` or ``EXPORT_SYMBOL_GPL`` should have a kernel-doc
comment.". Anyway, the *_bool stuff doesn't seem to be something to be
copy-pasted.

Rasmus
