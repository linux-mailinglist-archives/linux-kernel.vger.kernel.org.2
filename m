Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB4734BC7D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 15:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhC1NQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 09:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhC1NPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 09:15:44 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C63C061762
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 06:15:43 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e8so10071006iok.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 06:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7f9lINj7Zb84PEBx5/s6SJ7bMjYd51eHMw/VCObSs0I=;
        b=y/e/rmKZI3kXKPBfagsj35ZiD1Tc2KwtURWlyEfxa7JjeQXom+ZUThDB7FsHjCx1UF
         vkSYh4Dvk9XokuIdUbfrQC3hjVQ+N9z66BDZIRCAukxa1x9vfSgBVRVFPN5BdZ2jBFor
         2HAKducLgw1muaZdGFZYomROeB9jY8f8XxL+kX3iah/f27P38PShVX7JRA117xXzRCsE
         PcHg1tpHXeqlqAcaU4L+ct8InXm/ylEIejsyDbXlUT3n2h2pZN4nPoMnzeZ+hzrpJs1R
         1MhcSwGeVEyQh5UVZDStl4vxgi8pyUKHY3fT6LPhH4oWM4gkz18ZB8ejJFpsprN7nZG5
         XuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7f9lINj7Zb84PEBx5/s6SJ7bMjYd51eHMw/VCObSs0I=;
        b=RA6PZU3c3Y/td6LDKVxrON3bobnDoMiZBo4mCTb0S7NQrH/yaQcocofAb4CARf5mg6
         i02aL1WO2W4z4sxk6kKqhKg/rEsywmxUenUnK+tkZWypG8xr6JTzC19Rgtt22eE+MHQf
         vvF2WpTDeJfZbESkYSp9WEeWrDK9r4Zr6pJ0j0jtJfJKJIgR8kZ091+cpYWIYVGk7yHD
         rKy7cg7DcWj4P4bakhj/qGukpKfEhS0kIpBYajrJXJVJmXlPBADjTq6oF3EhJH5O1Wjb
         NuIXE4UVsOoFWy2L1DQxmIHsEgznlZUTaLZvCbcnLAWpIHZLW2XgNz7VbqaA8KGywSqe
         +8nA==
X-Gm-Message-State: AOAM532BXmw3Du4KxiHb8hKKk11s673PhH69RbfTFsARrlezhZwrMDXQ
        k3AiR2VN8467hTTjZdUT2yJZngJM8sa1F8yS
X-Google-Smtp-Source: ABdhPJypK5uH4UWw65iuIHu1+FexGB5LavaKtQMoRThHhcstU/TXBp8G0bf3qHRiZv6xG8s7sh7sJw==
X-Received: by 2002:a05:6638:614:: with SMTP id g20mr19593882jar.85.1616937343049;
        Sun, 28 Mar 2021 06:15:43 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id x3sm3659149ilg.2.2021.03.28.06.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 06:15:42 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH] greybus: remove stray nul byte in
 apb_log_enable_read output
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20210326152254.733066-1-linux@rasmusvillemoes.dk>
 <3a04ad94-f8c3-4d2e-c6a2-d498ac3cbeb0@linaro.org>
 <bca9a507-0cfb-936c-5fce-a5fa3f05b0cd@rasmusvillemoes.dk>
From:   Alex Elder <elder@linaro.org>
Message-ID: <ee323aff-64fd-68cd-c1e7-647612327fd5@linaro.org>
Date:   Sun, 28 Mar 2021 08:15:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <bca9a507-0cfb-936c-5fce-a5fa3f05b0cd@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 12:05 PM, Rasmus Villemoes wrote:
> On 26/03/2021 17.31, Alex Elder wrote:
>> On 3/26/21 10:22 AM, Rasmus Villemoes wrote:
>>> Including a nul byte in the otherwise human-readable ascii output
>>> from this debugfs file is probably not intended.
>>
>> Looking only at the comments above simple_read_from_buffer(),
>> the last argument is the size of the buffer (tmp_buf in this
>> case).  So "3" is proper.
> 
> The size of the buffer is 3 because that's what sprintf() is gonna need
> to print one digit, '\n' and a nul byte. That doesn't necessarily imply
> that the entire buffer is meant to be sent to userspace.
> 
>> But looking at callers, it seems that the trailing NUL is
>> often excluded this way.
>>
>> I don't really have a problem with your patch, but could
>> you explain why having the NUL byte included is an actual
>> problem?  A short statement about that would provide better
>> context than just "probably not intended."

My point was really that you should have provided a better
explanation in your description.

At this point it's been discussed enough so I won't ask you
to post version 2.

Acked-by: Alex Elder <elder@linaro.org>

> 
> debugfs files are AFAIK intended to be used with simple "cat foo", "echo
> 1 > foo" in shell (scripts and interactive). Having non-printable
> characters returned from that "cat foo" is odd (and can sometimes break
> scripts that e.g. "grep 1 foo/*/*/bar" when grep stops because it thinks
> one of the files is binary, or when the output of that is further piped
> somewhere).
> 
> At the very least, it's inconsistent for this one, those in
> greybus/svc.c do just return the ascii digits and the newline (and if
> one followed your argument above and let those pass 16 instead of desc
> one would leak a few bytes of uninitialized kernel stack to userspace).
> 
> I said "probably not intended" because for all I know, it might be
> intentional. I just doubt it.
> 
> Rasmus
> 

