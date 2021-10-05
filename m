Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D2E422F91
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 20:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhJESD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 14:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhJESDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 14:03:55 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EEAC06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 11:02:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id p11so2016025edy.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8soODRKahVCrtRlGdz3itpTz6efHriNTM+iAlgAUdyU=;
        b=bYv7DnuO0RwkyA+l2MKeegZst/fh5ECeydJbnQ9QG8NQQ8b2dDTFDpxbhrFgAtrWcO
         PNfl0qr8UxOX9DiiorStolrwbPL57AOAtego0kcSajMSiwv3CSlTuVg3egOK6yxfa4Sw
         MEz6Stdn1nAyy5hLsBb1h69M0tzHD+xBqEThU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8soODRKahVCrtRlGdz3itpTz6efHriNTM+iAlgAUdyU=;
        b=tJXsOkp0inHbPHPrNt0ZigeSXM2Q7s5rN/bEB3k9fH9J56wcbPdli0ogXu5ZPfx6bS
         kc2lTw0BpVMz3Zzs/HiT4U2XKEbGaLCoYfm6cP/mqThwOhYqtmYSouNjlvTLzPpM5Uz/
         /dJSTvmHa6g1P3pzRii/df7Qk/i/EPaEXddFNAhK5j2frvjSHY3WFQtE+ro6o+dhdQlf
         uC1OmbL2Ot6ATn9xtZGAQmwreW/5VnJa01gcgZ77JcUmuF9VMRVfZFntIi6SIljcaIky
         PO/c8LX8b3oqTdgCdz/mbnPCmFT8+Nunj5jfwbg7keF8CTlvUdNsd+YFyfbnGS+7OvKB
         r2QQ==
X-Gm-Message-State: AOAM531fPJRvRswKd7RQ1CN016liLg+9QeoKDZHZIVIeoqWQ4nmYYFEi
        Wbho1RyfBphI9pDWxcQt/uG2Wg==
X-Google-Smtp-Source: ABdhPJztLA+4bqrgciuGWV2Utz46byIwXyxUhs5Eyhx9lSWiXnu0KLr/rnzC3xlvcwqMkfGmPec67Q==
X-Received: by 2002:a17:906:c317:: with SMTP id s23mr23300124ejz.127.1633456922542;
        Tue, 05 Oct 2021 11:02:02 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.69.72])
        by smtp.gmail.com with ESMTPSA id e7sm9799784edk.3.2021.10.05.11.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 11:02:02 -0700 (PDT)
Subject: Re: [RFC][PATCH] rcu: Use typeof(p) instead of typeof(*p) *
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, rcu@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
References: <20211005094728.203ecef2@gandalf.local.home>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ef5b1654-1f75-da82-cab8-248319efbe3f@rasmusvillemoes.dk>
Date:   Tue, 5 Oct 2021 20:01:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005094728.203ecef2@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2021 15.47, Steven Rostedt wrote:

> That is, instead of declaring: typeof(*p) *_p; just do:
>  typeof(p) _p;
> 
> Also had to update a lot of the function pointer initialization in the
> networking code, as a function address must be passed as an argument in
> RCU_INIT_POINTER() 

I would think that one could avoid that churn by saying

  typeof((p) + 0)

instead of just "typeof(p)", to force the decay to a pointer.

Rasmus
