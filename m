Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB7334A7D6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 14:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhCZNKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 09:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhCZNKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 09:10:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F368C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 06:10:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l4so8293098ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VOKjl/3v3ErqSbOWpr9g/HwyTdgxANvzHYKscwdWoMM=;
        b=f8yqDWUkgrxRd03LbhJhxoBWrjrGCi8HpA7psIRlITgiUOxCfeYsb4e4GAILUJeOcE
         R/9zsTsr9ecu5sPnV9ac424kvTRXY8CLtOhAQaF5PyEcboKYLPzbD1fuafB1HLKJoiXY
         zsnTpX7HtWDYpK3jaSvNMtt0NR382gx9c3e/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VOKjl/3v3ErqSbOWpr9g/HwyTdgxANvzHYKscwdWoMM=;
        b=U61mUPmxCTAf1dEGO4GKuC/dRtnGizT/QpnInsL9fsrjCLKgaSXOm5JwH3L+r0CYb2
         ckCGlGsqthQW/ylS0hLl2zbmax7wwCmP+n6/GdDQ5jtD/HBv8adTb0RMFUN9/PuUeoPR
         kM270mOILTobcVkjaugAK3iDOB0fR2P6dPv/NkcV/rPx2+fon++mEPPUUWHxz8Q2Pilo
         zjMG6V0F8EmR9SmyagObarKMEIDo7p5jFWFrK/cW3Qkp1JlG9OgNiCV/dKGQngOIv8yy
         zchiJE9eeVq3wXEZiTqoHCDxnDxCZt8OTlSQM3+2+m8BabGsydl+MageFNcVz04vSjDq
         VfXQ==
X-Gm-Message-State: AOAM533syEb0myPH9NcswnPipPutKbfyi+1j/tV9QKOkouFRCNjqkKrx
        mpm7WutcyMZPUIw2/gXEAQOCtrwukS9O776P
X-Google-Smtp-Source: ABdhPJxNc7mbaMlv/Wlk8wc7UqyiLKaWxRXwJrYBvP3FlLDhra/vUVvjOjMkfnRZzeWFenH+6rBzAQ==
X-Received: by 2002:a17:906:414e:: with SMTP id l14mr14631976ejk.406.1616764243528;
        Fri, 26 Mar 2021 06:10:43 -0700 (PDT)
Received: from [172.16.11.38] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s20sm4243724edu.93.2021.03.26.06.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 06:10:43 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] debugfs: Implement debugfs_create_str()
To:     Greg KH <greg@kroah.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        mgorman@suse.de, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org> <YF2/41K4xs3ZOQdV@kroah.com>
 <YF3DF+T8nPRgt7Ao@hirez.programming.kicks-ass.net>
 <YF3F0JbbEpeSGzW6@kroah.com>
 <YF3Hv5zXb/6lauzs@hirez.programming.kicks-ass.net>
 <70594935-18e6-0791-52f9-0448adf37155@rasmusvillemoes.dk>
 <YF3aSJ7OYiCpWsl8@kroah.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1da9e61c-6973-2e0e-d898-7bf92ac5b1c4@rasmusvillemoes.dk>
Date:   Fri, 26 Mar 2021 14:10:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YF3aSJ7OYiCpWsl8@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2021 13.57, Greg KH wrote:
> On Fri, Mar 26, 2021 at 01:53:59PM +0100, Rasmus Villemoes wrote:
>> On 26/03/2021 12.38, Peter Zijlstra wrote:
>>
>>> Implement debugfs_create_str() to easily display names and such in
>>> debugfs.
>>
>> Patches 7-9 don't seem to add any users of this. What's it for precisely?
> 
> It's used in patch 7, look close :)

Ah, macrology. But the write capability doesn't seem used, and I (still)
fail to see how that could be useful.

>>> +EXPORT_SYMBOL_GPL(debugfs_read_file_str);
>>
>> Why?
> 
> Because there is a user of it?  Yes, it's not in a module, but to make
> it easy, might as well export it now.

No, I was asking why the individual read (and write) methods would need
to be exported. They have even less reason then debugfs_create_str() -
which I also think shouldn't be exported until a modular user shows up.

Rasmus
