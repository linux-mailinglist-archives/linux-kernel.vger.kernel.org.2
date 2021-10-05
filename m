Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1448542305B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 20:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbhJESun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 14:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhJESuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 14:50:37 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2F3C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 11:48:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d8so342785edx.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 11:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A2NgxD1/eVKF5aA/6vOIKBsVzYpDnTEprcND7FDOo0M=;
        b=fFls5kf51lCIVFfkvGfs/xBe5XimbcYmLquWrEgTuzI0E86OeuXyL7p0wYGBeMKXp6
         n2zUmaPptcJGf4ySWE3LboQxkcw2GdxkxT8U487eGeQ/OELckpICsePkKJ7Jb5gQzOMp
         DHouSPks6GOygmlOmWexqYsjUFUsR5vaYJxuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A2NgxD1/eVKF5aA/6vOIKBsVzYpDnTEprcND7FDOo0M=;
        b=WqcosJ1yYOJt2VDeThX6U0lU+SEZfFnXFOR89sIjuga1ItYq0234cDgiR5ejXmA6WV
         aCsCaheIIOyHesVKJfGTxCJEt6Nvcb1D4A4zOWUxoAO1XaAhkVOZWkhZOwQmVV2+iuL/
         NwogGuY3b/toXJ0BNVcuIp9OEWZuH0BU3HCbOrE7oN5FY+HoOL9RYQjcBB9nHwjz7kq8
         yxq+IINKX9OUGIE5suwGZbJDLvR/8Bpvb3/2ZeUuH/us+pJD0QKZXMBTABaWBcVFt3dA
         XAp7o/8MJSBQyLNrudC/+3djtzGLzH6j7HBTSwUTrG/1DSTZz+JzLiYJGtZAdu3lza6S
         yVLw==
X-Gm-Message-State: AOAM530OiCbNrl5jx5ei9SGXV7WrxfKviiGDAML1cliy4D6T2AVDqOMW
        rga53A/WnwdHUaEnszDEwL2+Eg==
X-Google-Smtp-Source: ABdhPJz9jeqHDl8O0imLWpCr8HeJ8hr/QY2yL6Y9H94zZ/C0athk4E1x91ecMziaL8KCw9LmdzYAMQ==
X-Received: by 2002:a17:906:cec6:: with SMTP id si6mr2070177ejb.270.1633459724617;
        Tue, 05 Oct 2021 11:48:44 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.69.72])
        by smtp.gmail.com with ESMTPSA id lb20sm8091267ejc.40.2021.10.05.11.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 11:48:44 -0700 (PDT)
Subject: Re: [RFC][PATCH] rcu: Use typeof(p) instead of typeof(*p) *
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, rcu <rcu@vger.kernel.org>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        coreteam <coreteam@netfilter.org>,
        netdev <netdev@vger.kernel.org>
References: <20211005094728.203ecef2@gandalf.local.home>
 <ef5b1654-1f75-da82-cab8-248319efbe3f@rasmusvillemoes.dk>
 <639278914.2878.1633457192964.JavaMail.zimbra@efficios.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ed3b6265-b073-bab2-4a05-d7a8acf7763d@rasmusvillemoes.dk>
Date:   Tue, 5 Oct 2021 20:48:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <639278914.2878.1633457192964.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2021 20.06, Mathieu Desnoyers wrote:
> ----- On Oct 5, 2021, at 2:01 PM, Rasmus Villemoes linux@rasmusvillemoes.dk wrote:
> 
>> I would think that one could avoid that churn by saying
>>
>>  typeof((p) + 0)
>>
>> instead of just "typeof(p)", to force the decay to a pointer.
> 
> Also, AFAIU, the compiler wants to know the sizeof(p) in order to evaluate
> (p + 0). Steven's goal is to hide the structure declaration, so that would
> not work either.

Gah, you're right. I was hoping the frontend would see that +0 could be
optimized away and only affect the type of the expression, but it does
give 'error: invalid use of undefined type ‘struct abc’'. Sorry for the
noise.

Rasmus
