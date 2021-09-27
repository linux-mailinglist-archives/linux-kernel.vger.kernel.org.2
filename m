Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77F6419461
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhI0MjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbhI0MjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:39:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED33FC061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:37:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b204-20020a1c80d5000000b0030cd967c674so237698wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=guXnrK7D0JoZ+FNV6YGF0sMrXPKV49xy8opMucdOIKs=;
        b=eK8z1ArT1Sm2lu01amNzyfif1NmqSWHC9f8TrecrT704YY7Wa2vHiT0oAMn0B6jZ/H
         88u5+LZUIP194tuwCXMQW59GrF9Ivgq/LV92EsEdOj2A0b36Q9/CEkf74ZWoiaIAcGV1
         EQShRTstqREB4Q54i4+Be/OXiZRiVUxXTqK08bmkWbYIIgBUTtbaXeSASMNpxkZuw3O8
         Gys/o1SYQCy+a/vNPGSYRiIj8UPMLDl52HBNByZVRd0iCRhMkf/7tuVvgikT679aQxj/
         w2NxBWWweEWuCGb/xIArkLDuX56cmu8jOAxgqdbNmi1ZBBFKOGhkWCuNoWvBrgYVtOBX
         Y1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=guXnrK7D0JoZ+FNV6YGF0sMrXPKV49xy8opMucdOIKs=;
        b=I9On0z0hKMA4nuriJI2Wtjd+f1AGiyfSxdDbzAs9QkjWC4m4pHK9W1gYsCByo7uhuw
         6bm31gyPkn5kh78LmIYJhUVtg+DUOOAa2rWQ+wElRo/L2Od0AdWlVPTbKJH4JBV9BWhy
         xuy5Vi59ya53glKb/804BhX5673hoKVn4iq0zK5RRMYtF43l3ZbjwTIwrBdMzvmbynxV
         Zq8Jq/x5k9SMNazONwai1UxB/JIuA5FZEwrp8lwIVhJtY3U6BOtLOhTqmxpHpNerWNWM
         FPP+qsAI8u0Wf/cWvkSzqzuoK3+q0B07fTd/v/M/mU9LbYy51EPyXS/GPiYEQ0VD67Tk
         zCYQ==
X-Gm-Message-State: AOAM5333AqYGku35i7UctaABhMj3vW1iaQCpIi4qti9Rci9DAYocs4L2
        LEn5trpHIAXlbSYmxsw18NLIym14R+txGA==
X-Google-Smtp-Source: ABdhPJxMueQL0W0LtlYQkIb4CN8jZ2/EubCdI9/bVyfdJSTtSblg6X9BZhAjviUcxDV4ooulircWAA==
X-Received: by 2002:a05:600c:2e46:: with SMTP id q6mr15486473wmf.182.1632746241462;
        Mon, 27 Sep 2021 05:37:21 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:410:bb00:d99f:4811:e8ed:bd3c? ([2a01:e0a:410:bb00:d99f:4811:e8ed:bd3c])
        by smtp.gmail.com with ESMTPSA id j21sm17507341wmj.40.2021.09.27.05.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 05:37:21 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: linux-next: Fixes tag needs some work in the ipsec tree
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210927064921.06973f44@canb.auug.org.au>
 <a3680eb9-44d0-efe9-7037-9799a66786f7@6wind.com>
 <20210927111833.GH1407957@gauss3.secunet.de>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <d263cbeb-0a39-5fb3-ca4a-9dedfef24611@6wind.com>
Date:   Mon, 27 Sep 2021 14:37:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210927111833.GH1407957@gauss3.secunet.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27/09/2021 à 13:18, Steffen Klassert a écrit :
> On Mon, Sep 27, 2021 at 09:55:07AM +0200, Nicolas Dichtel wrote:
>> Hi Stephen,
>>
>> Le 26/09/2021 à 22:49, Stephen Rothwell a écrit :
>>> Hi all,
>>>
>>> In commit
>>>
>>>   93ec1320b017 ("xfrm: fix rcu lock in xfrm_notify_userpolicy()")
>>>
>>> Fixes tag
>>>
>>>   Fixes: 703b94b93c19 ("xfrm: notify default policy on update")
>>>
>>> has these problem(s):
>>>
>>>   - Target SHA1 does not exist
>>>
>>> Maybe you meant
>>>
>>> Fixes: 88d0adb5f13b ("xfrm: notify default policy on update")
>>>
>> In fact, the sha1 comes from the ipsec tree, which is regularly rebased.
> 
> The testing branch of the ipsec tree might be rebased if I have
> a bad commit there. The master branch of the ipsec tree will not
> be rebased, as this branch is publicly used.
> 
>> The original patch is only in this tree for now.
>> Steffen, maybe this fix could be squashed with the original commit?
> 
> As said, I never rebased the master branch so far and would only do
> so in case of emergency.
> 
Ok, thanks for the clarification and sorry for this wrong sha1, which probably
comes from my tree.



Regards,
Nicolas
