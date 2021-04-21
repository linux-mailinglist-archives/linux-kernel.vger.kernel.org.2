Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931FC366C99
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242481AbhDUNUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243230AbhDUNQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:16:51 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A179C06138C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:14:30 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z2so5704072qkb.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FLAsc1Z4dnOJhx9j49BuieXWeT6WZBtSOA3VkyjkMZQ=;
        b=tYHXF8gJ/FEVyhoKy/hhOJwu/VaLnvRGbOIB5eeuv8kIKp8Pk2sG4k5RLU8Iy+QtqC
         MjeVHJzHDtoyQen+75eQEu/9qKW4nXnFaTaQ7xBZy/5kcx617yBMSlWl1Bmy9PGw3EXT
         Dm/mf7S/cP4Bt4nf19WbXp37/ATGJsvlukWTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FLAsc1Z4dnOJhx9j49BuieXWeT6WZBtSOA3VkyjkMZQ=;
        b=C+wWFm56QHgoTvcrVt8cK3K8Za71Xop+XYUeZ+p6BKrIafOdAEDHY4SZDovkmDySCY
         wDZjWSX6N4er25kikmh4pQLPHD86SGFJfA3XrxCvc14RneZOXkhcpj7xKMw/Pdrc1MYZ
         /l40c3jH8AKaN9Ru57Kw3gkLJm29BSfGjuQ7LxLk+/+Y7cLeaQj1dCfOLcKTXsyDYKGa
         pq2vBs0jTW0fC0Ayccl3MSv/KaGSHB4BzPEQq0wt8ociIh5kOW2lUqgtqCQ0CrD/o9j7
         WbnVNnBidI9XKR+YX1neZeRHqOrp2bwCPn3F524S59PzvMGgpLdf+VvtceiGDUGgXLW9
         6Ynw==
X-Gm-Message-State: AOAM532KKwCWEYk72dj8iHReIUwb0/lbZLnhEbRWw4ncCe+W0uo300Eu
        Anww3FRFQXPdUrn+2r67Pm56Gg==
X-Google-Smtp-Source: ABdhPJyrCovHI6nCGiVuL5uqRt/CDEiOpg01AhJt58tMF8UGDQRXsusGnnMkSaW+/XFwmu30AGdzrw==
X-Received: by 2002:ae9:c014:: with SMTP id u20mr17669678qkk.55.1619010869338;
        Wed, 21 Apr 2021 06:14:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:92c9])
        by smtp.gmail.com with ESMTPSA id 1sm2340371qkr.102.2021.04.21.06.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 06:14:28 -0700 (PDT)
Date:   Wed, 21 Apr 2021 14:14:27 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YIAlM2jXadciFfGW@chrisdown.name>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
 <YFDAfPCnS204jiD5@chrisdown.name>
 <YFHAdUB4lu4mJ9Ar@alley>
 <5ea3b634-5467-35cf-dd08-1001f878b569@rasmusvillemoes.dk>
 <YFMvfawY+0CncS8G@alley>
 <YHmXi303WxVZzVwI@chrisdown.name>
 <e9f74575-1ba0-0c06-b370-59d151c72ed6@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e9f74575-1ba0-0c06-b370-59d151c72ed6@rasmusvillemoes.dk>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Villemoes writes:
>> One (ugly) way to handle this would be to have a new "level" field in
>> the printk index entry, with semantics that if it's some sentinel value,
>> look at the format itself for the format, otherwise if it's some other
>> value, the level field itself is the level.
>>
>> This will work, but it's pretty ugly. Any better suggestions? :-)
>
>Well, that was more or less exactly what I suggested when I wrote
>
>> One could also record the function a format is being used with - without
>> that, the display probably can't show a reasonable <level> for those
>> dev_* function.
>
>But, I think the real question is, why are we/you interested in the
>level at all? Isn't the format string itself enough for the purpose of
>tracking which printks have come and gone? IOW, what about, on the
>display side, simply skipping over some KERN_* prefix if present?

Hmm, as Petr suggested, it's largely so that we can determine whether it will 
be emitted at the current console loglevel. Otherwise, even if the printk site 
is present, it might not ever get emitted. To that extent I am pretty convinced 
it's necessary to reliably achieve the goals in the changelog.

Judging by the conversation there's no immediately obvious better way, so 
unless you or Petr object, I'll send a patch in the v6 series which implements 
the "ugly" way with dev_printk support as the first user. That should make it 
easier to add other printk-likes in future as needed.
