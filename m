Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C1F32298D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 12:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhBWLgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 06:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhBWLgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:36:20 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E2AC061574;
        Tue, 23 Feb 2021 03:35:40 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o38so12171418pgm.9;
        Tue, 23 Feb 2021 03:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZXknYZa22rU4H1Kyhm91bekSW7PvKMTDIpqNkOqobg0=;
        b=CVmm/41qEVa8VkqYO/9hoDhX1BID2L/663fz5V7U+F4AZkVdnGavR376wsVaYXywWv
         GwaxEEG7ONNBS3a2yM1x56LTm3nuDPq1uFXJjz0zHD7LJfVpMhzcT/0am1a+pSHHe8fp
         DMdjnmnXYq/+FU0IzTGSoyNWULwftomnuO9VsI7U2rVxA8toBCTlAb/uEHd2CHyVKwdy
         yAF6dHL5Tz+nkNM+q84Fg82BhD42/Q6znMcw1086F25m89CGXK5YgSGhwwpzwIqGJLs9
         HBg/GBQ4EU49gd5yXsMj3njGJKQrWmLmha8gigkWuwTDoxh9iAUlhW91D7SmlKhP//CT
         3C6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZXknYZa22rU4H1Kyhm91bekSW7PvKMTDIpqNkOqobg0=;
        b=s0eSH+p+9tCk6X2x1VwQG85UfWlUjmB/bfAJsrt6fdyrB1BJ2Wug4Nz1taGSCMmTlG
         yjEzg7umUpMr2Fl5Y0NLazQfIpTc8owKVvxhubd7E8oGnI2y6HTdQ92g1HnEL7ROPYZb
         +NNu2iyST9u+Qq3NlUoNczio+MslAe4ebqsfYVdWNqRcpv0jxgu5kjKCYwiZENc9X2zc
         WwfOZ9ZBA9dF6g7/jgTTMY1nGBrPgDkEAZ3N06iEdfzCPs85/k7nziP8rTllWgYOxflW
         p7j7aa0ct1P9ei0Gw48TBAme6aAdoH9f38+TwM2YbuY6WMp3stfbkm6LI/LgpvOVbyhm
         TnXA==
X-Gm-Message-State: AOAM533gdijYW0Q1bUHIie0finOVXyLK8bL1x8fm4EUv7eb6o1bu6Qh0
        PSCmUycBM6sx83CKhrX3hqa+aIvgKdRMNA==
X-Google-Smtp-Source: ABdhPJx9a0hukooQl+z13/uQEycH7Ffx7KnAqyXf1sCpbyl4sm/4sgSImvbkUxroEOUNSBqVplDsIw==
X-Received: by 2002:a63:f953:: with SMTP id q19mr3171093pgk.125.1614080139936;
        Tue, 23 Feb 2021 03:35:39 -0800 (PST)
Received: from ?IPv6:2405:201:600d:a089:71c8:9c21:1a6d:84ab? ([2405:201:600d:a089:71c8:9c21:1a6d:84ab])
        by smtp.gmail.com with ESMTPSA id b7sm21630037pfp.139.2021.02.23.03.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 03:35:39 -0800 (PST)
Subject: Re: [RFC] scripts: kernel-doc: fix array element capture in
 pointer-to-func parsing
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20210217145625.14006-1-yashsri421@gmail.com>
 <878s7flrdf.fsf@meer.lwn.net>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <1e4c4108-feb4-9ab6-7c1c-13200658470c@gmail.com>
Date:   Tue, 23 Feb 2021 17:05:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <878s7flrdf.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/2/21 3:03 am, Jonathan Corbet wrote:
> Aditya Srivastava <yashsri421@gmail.com> writes:
> 
>> Currently, kernel-doc causes an unexpected error when array element (i.e.,
>> "type (*foo[bar])(args)") is present as pointer parameter in
>> pointer-to-function parsing.
>>
>> For e.g., running kernel-doc -none on kernel/gcov/gcc_4_7.c causes this
>> error:
>> "Use of uninitialized value $param in regexp compilation at ...", in
>> combination with:
>> "warning: Function parameter or member '' not described in 'gcov_info'"
> 
> In the future, please quote error messages from the kernel verbatim.
> You can trim irrelevant stuff before or after, but please do not edit
> them in this way.  That helps me to understand what you are fixing, and
> is also useful for anybody else who might be searching for a solution to
> the same problem.
> 
>> Here, the parameter parsing does not take into account the presence of
>> array element (i.e. square brackets) in $param.
>>
>> Provide a simple fix by adding square brackets in the regex, responsible
[]
>> -- 
> 
> ...meanwhile, I have applied this one, thanks.
> 

Thanks Jonathan! Will keep this in mind..

Thanks
Aditya
