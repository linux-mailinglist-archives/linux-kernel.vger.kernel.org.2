Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38C444EDDB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 21:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhKLUZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 15:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhKLUZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 15:25:10 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C482C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 12:22:19 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c4so17525554wrd.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 12:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=W0zH8OiTHGAxAnGVVdOKIHrQfR0Wun9xK3Ethxqbz6Y=;
        b=pZCga+eLwofBx0VUiUmCPLbm+Q+cvQyze7gVvvpOBme6fX7v22wihb6WybVXJ6XXqJ
         i6ULqTxbE1Wrq4T/ISFZUkzEwMaJfEkV8LZNowkv46Nf41Q6JPtRO5jHxGbRW3uRcbfZ
         9qB6zOy/9BSuPtXnhhqG2aunixJjuIgXXXT8zQmyycLkw+ld8p6wcJUUur9v/bfsWKhZ
         Li4ZaVs87EmsQMaybyJZ7g8ztPXpO8HwTInlsH//BZQc/Xqi2nHN8x5/HeFNo8eLEQRk
         PJ9HLfgLvo/GW90TPooihqHpGedy3PEGJYyvGjmfgmN1vhQu+jq99wudWOygtYJXx53K
         SLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=W0zH8OiTHGAxAnGVVdOKIHrQfR0Wun9xK3Ethxqbz6Y=;
        b=wI+p/1rHydMvMu2mdWcibnw82OzLA3QykuD3NQpatNTgmDh5y8i4I039NSM4yqxVy5
         +OaYTz8ijnAdxj4dQtl6j0h6o2CZ9AUnG/E8uMTU1urLUsEaebCTq5KfxXHU4p6MQ59i
         nmwi7hT9CAU4ZTiQsknfifQeLmkFHYsTf4kqSR3Lnpj3x9c3t8L8o/koDqGHYgRDKC6U
         XOK5o/2NdBtnYvr82vD4AxmWcf57+Acnr2PhImHz3/tLN3kZ6pvJ+kfvUfytwtw9CA1c
         +o68y4fyHHyNMMmHieXEDjGgDSeB1yhkZYHvXb1VxVo4Iuvu4PFVLYtzXTbyKGi/z3wB
         pnYQ==
X-Gm-Message-State: AOAM530WRFBsRBWENOkjqJ+uQwB6ez2UrapdFUWkJ4TWKuZjpfRXA+mn
        x+3x1gz71xLC37o3mB7kEbY=
X-Google-Smtp-Source: ABdhPJzK+js5lOwqD8E6HkSiOMZz+Ab4hZXD9OseSnCy+Nji12qPQESoIIo3CBo+TlhnVcuFyhF5JQ==
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr21209354wrs.81.1636748538061;
        Fri, 12 Nov 2021 12:22:18 -0800 (PST)
Received: from [10.168.10.170] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id q26sm6536794wrc.39.2021.11.12.12.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 12:22:17 -0800 (PST)
Message-ID: <3b458eb5-42c2-50b2-cd42-ea9aba68210a@gmail.com>
Date:   Fri, 12 Nov 2021 21:22:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [Bug 214873] man 2 fsync implies possibility to return early
Content-Language: en-US
To:     bugzilla-daemon@bugzilla.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <bug-214873-216477@https.bugzilla.kernel.org/>
 <bug-214873-216477-ofhoomEwvw@https.bugzilla.kernel.org/>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <bug-214873-216477-ofhoomEwvw@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Add CCs]

Hi Jens,

On 11/8/21 00:24, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=214873
> 
> sworddragon2@gmail.com changed:
> 
>             What    |Removed                     |Added
> ----------------------------------------------------------------------------
>               Status|RESOLVED                    |REOPENED
>           Resolution|INVALID                     |---
> 
> --- Comment #5 from sworddragon2@gmail.com ---
> This ticket was closed pretty fast after comment #2 so I could not write
> comment #4 before closing this ticket and now it seems due to it being closed
> it does not receive attention anymore. Thus I'm reopening this ticket so that
> comment #4 can be evaluated if this makes changes to the manpage valid.
> 
> But if you think there is really nothing that needs to be changed feel free to
> close this ticket again as I then won't bother about it here anymore.
> 

That comment (and the previous) was directed to you, but since you're 
not CCd in this bugzilla issue, you didn't receive it.  Could you please 
have a look at it.

I also CCd the same other emails as in my previous email, since some of 
them may want to have a look at it too.

Thanks,
Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; http://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
