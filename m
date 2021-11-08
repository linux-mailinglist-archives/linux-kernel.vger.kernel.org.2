Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7917B447D26
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbhKHKAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbhKHKAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:00:18 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D35C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 01:57:34 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u18so25774143wrg.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 01:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=kOUbhllrGgmpU45GMJothVqWnhtxz4cIj2zv5C1qMWk=;
        b=oQBdMvS4KhzP9XZLtihtlQjZay5WL9YgNRwpEZsNQ8c5RhtCKzDNkrNUpBHVgJMA8Z
         hdR9qkW/20y/bhNkqFX9pFUpJuVjeicAqADHFJE/cVFJ6CsI2UsRB7+R7qguW9/QerXr
         TEwz24q0kXdt6phkXxkzdS7WBlcG5BkzwUN7hGxzUBSAFneS9A06eQee+Hu+RL1NWB3N
         DE5N/9TEWC2DxsxcBb2HNgdg0ZiO5H+l0YVmryVK/JZVDFjDd8poG3hDeQ4Rqr7G7MAL
         w6JGJuSbaQXdfs0PS1OL7+MWJqE7CJwZeK4b0zCmTOQWqbLofenvbujzq3sGG7ub0T/U
         RTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kOUbhllrGgmpU45GMJothVqWnhtxz4cIj2zv5C1qMWk=;
        b=J6lfEHYpEo70Qwmm3dEyS2evrGdtG81qwMmSuErY+ec0NuTWkihhe6QJp0KxZUI8ra
         QFQn+KFN+BpIBERtyTDnGYwH+xfFxPJvG+bcy/dlyIuqDP4tn8fD9JeqmFwvYkWKJGrI
         S/T5UjgT65XswFdA4J+6fJ3dM7zzy9h4OtMWPDu1u/tyluVyE0SN8q0uV25sv/9Z3qe3
         KOLJMSRQnUG6dhQHER659uiOxV+4E08F9xetvRqwX47nZrVBRcjnYVF2hfU5tZWk72mF
         64g+8c7E8KPwDYj5fFFDd1dx23hDp7WIl6OySP09x7CxWwT+0UdihdPbiwhU49J73Rtf
         p33w==
X-Gm-Message-State: AOAM5306d4idZ0L3uvj/Qr95a4ZQdH78RoVb20vbQxJAffoLq8Zd2OdJ
        4cZXxg2hK17yvwVRmLdnh00=
X-Google-Smtp-Source: ABdhPJxDtSXVBMSAmrvWAmYcT5hvBCAgpVKjqIr6ghNej8nNREokF7CmLVosjHMM7wTvvT8bhUVFMg==
X-Received: by 2002:adf:f787:: with SMTP id q7mr78460918wrp.1.1636365452804;
        Mon, 08 Nov 2021 01:57:32 -0800 (PST)
Received: from ?IPv6:2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62? ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id f6sm15600793wmj.40.2021.11.08.01.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 01:57:32 -0800 (PST)
Message-ID: <0a4c26bdabadd666ddf124bbb767e5cc802af937.camel@gmail.com>
Subject: Re: [PATCH v2 3/8] staging: vt6655: Remove unused `i` increments
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Nov 2021 09:57:25 +0000
In-Reply-To: <20211104133803.GC2794@kadam>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
         <79a4f03c8f2bfa555ea149ddd1c0f938dd431a0b.1635773680.git.karolinadrobnik@gmail.com>
         <20211104133803.GC2794@kadam>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for taking a look at my patches.

On Thu, 2021-11-04 at 16:38 +0300, Dan Carpenter wrote:
> On Mon, Nov 01, 2021 at 02:32:01PM +0000, Karolina Drobnik wrote:
> > Commit c569952d92ba ("staging: vt6655: Use incrementation in
> > `idx`")
> > rendered the incrementation of `i` outside of the loop unnecessary
> > so it can be deleted.
> > 
> 
> That commit hash is something that only exists on your system. 
> Commit hashes are stable once they hit Greg's tree (he only rebases 
> in extremely rarely cases).

Ok, I can rewrite the message but I'm not sure how should I refer to
another patch from my patch set. I followed these guidelines[1] but if
there's a different way of describing it then please let me know.

> This commit is cleaning something that was left in a different patch
> in the same patch set.  Just merge it into the original patch.  Don't
> make a mess and then fix it.

I tried adding more than one logical change per patch some time ago and
Greg asked me to stop doing this.

> It's tricky to know how to break up patches.  My suggestion is:
> patch 1: remove all the unnecesary (unsigned short) casts
> patch 2: merge the rest of patches 1-3 together and send it at once

Sounds good. If Greg is happy with your approach, I can merge these
patches, no problem. 


Thanks,
Karolina

---------------------------------------------------------------
[1] -
https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L106

