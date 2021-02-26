Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C90F32694F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhBZVQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhBZVQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:16:54 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEF7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:16:14 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id k2so5666657ioh.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aEkqz2u+mz0t/VSEBaPY0HHIl5fJzCg4LIHOIOyh/9w=;
        b=XkvlS/0/K8mzVYjc2SkwA1orhL7/IIKO+AlU1wIH6Yw7SKfNfEllTE0zHUERYgRN1k
         alNACxacCD+FKU0qObNNT7n59QnH5+Nx0ATyOZeMJ3PkOqD2hSLHgr8UnENQgyenn06d
         eG8mFZceeK++R9zJ1tRuh4KGxdyJyJZMKp1hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aEkqz2u+mz0t/VSEBaPY0HHIl5fJzCg4LIHOIOyh/9w=;
        b=nD0dNTL0uvzL5WPKcuXF5teusdXRz/Bu50JCWbZOUg4/lUjPaUZZ2kGlfL5LxpgNgj
         PAzsH76wJYm5/eRNbVvOO2LUljdM2LLi8kN1yPVdN1UjfnlR+NIN1HyIUFMSJ0S45uCe
         s188q7IxhC2XkJ97YLmSDsZEPBVuHdv5DdEknNICJwpprRzu5nEpyyDvFtKZKodAp2Vc
         1PbcoDkWdVRAl6IQumnH0ducZfXdWiTzjRMDU/gQhT9EVWSbTDAKvA3TU+rzvQ0BpY8E
         k4IAptIgNVgjSa2HVmlRxncHgiH2FAiYmCQW7ityLgO5flMJ5nr9MRnNJMPLF4fECrwQ
         1l3A==
X-Gm-Message-State: AOAM533hR7T4mhaDWpSGMtSJTET/dk/uezEmSeUV9eGviKM9Ejyb0D0A
        M0Gc/U6IK9QrxuAzGMnaZmbrxw==
X-Google-Smtp-Source: ABdhPJya4CVD+12xGI84DX9yRpBbPixLWbm2kpiFEPOxywzbJ0rPRLUtdkh2MXAsoQVrNpOXNqNePg==
X-Received: by 2002:a05:6602:1799:: with SMTP id y25mr4200492iox.55.1614374173505;
        Fri, 26 Feb 2021 13:16:13 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v8sm5223997ilg.21.2021.02.26.13.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 13:16:13 -0800 (PST)
Subject: Re: [PATCH v2 1/3] lockdep: add lockdep_assert_not_held()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, will@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1614355914.git.skhan@linuxfoundation.org>
 <a40d18bba5a52662ac8fc556e1fce3752ea08472.1614355914.git.skhan@linuxfoundation.org>
 <YDli+H48Ft3F6k9/@hirez.programming.kicks-ass.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0ee409b7-b0d5-43c2-c247-b0482c392dea@linuxfoundation.org>
Date:   Fri, 26 Feb 2021 14:16:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDli+H48Ft3F6k9/@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/21 2:07 PM, Peter Zijlstra wrote:
> On Fri, Feb 26, 2021 at 10:52:13AM -0700, Shuah Khan wrote:
>> +		/* avoid false negative lockdep_assert_not_held()
>> +		 * and lockdep_assert_held()
>> +		 */
> 
> That's a coding style fail.
> 

Checkpatch didn't complain. What's your preference? Does the
following work for you?

/*
  * avoid false negative lockdep_assert_not_held()
  * and lockdep_assert_held()
  */

thanks,
-- Shuah
