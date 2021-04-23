Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499443693F8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 15:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbhDWNqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 09:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhDWNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:46:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F101C061756
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 06:45:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cq11so13907427edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n5Uhq6jNvjbLhhBE8wTMbQRhY41737IGH9rJTPdv1/s=;
        b=WrUskFpZ/jAkCPqD/Zwfl16X0sAViH9r3hpOIEfZql8ABaNipRa1giywFJBoXADikq
         Kd5wECOip7A0Kbr5iQdNhflL0j5WHIZal7JWtftRvku56+jey4UX+vywjmiOorkSLQy9
         go4eEu/gmFWeyemzpFwLScryfH+2DWy0P8c+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n5Uhq6jNvjbLhhBE8wTMbQRhY41737IGH9rJTPdv1/s=;
        b=ikPWVCC4g3GTgixGFOwGwQ70Y2JZ7LpyutyMnngII+N6Wi4LLfUKinNyda3GyiHBoA
         j/5culfcZ4VdXE2fbmWkrYVCeEbpCIKOcyLw9nnvLgbqcNs9G9t8YkRqyEIqfbLCC50q
         QuH/QhfxmAiO21HC3F+cHPqsKr0cWMb4a7JV++orrbTngmeq4xvJS12cS3U6zb5oHF8b
         lwQ0yApdkb1WPlhv6v+eaqnSJvfXVcFE+VRpc4d+7H1qknTMSZVf9X+mvf7pZ/122XzU
         AnQsrYLTR1ENVW/Z7XmX1EXH0he2ZlIADBSHjCwD1ICDeUKZDqsN8/B/P7jj5JcIfwXt
         qYfw==
X-Gm-Message-State: AOAM5314CHE066nVsYUDs5TA+rVvSmWNJpam8Amht322xNIRJ8Q4SwKM
        elKDzJK7/ThtGCo5BH5QGuvaxg==
X-Google-Smtp-Source: ABdhPJzZIZ5cyXz61PoWuy7G4QErd1/DDp+b7pabjmKRrRu773JRnb2HaHyi6+aCHyzsXud9FjNaMw==
X-Received: by 2002:a05:6402:1741:: with SMTP id v1mr4608739edx.127.1619185557798;
        Fri, 23 Apr 2021 06:45:57 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id e22sm4959971edy.63.2021.04.23.06.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 06:45:57 -0700 (PDT)
Subject: Re: [PATCH v5 05/13] module: Add printk formats to add module build
 ID to stacktraces
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20210420215003.3510247-1-swboyd@chromium.org>
 <20210420215003.3510247-6-swboyd@chromium.org>
 <YIARTVqnN8t/FA/P@smile.fi.intel.com>
 <161913520061.46595.8469966711677906076@swboyd.mtv.corp.google.com>
 <YILKpQ2KsBXCoHlG@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <dabbab72-7534-66e2-21e1-6e0005bdc2d7@rasmusvillemoes.dk>
Date:   Fri, 23 Apr 2021 15:45:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YILKpQ2KsBXCoHlG@smile.fi.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2021 15.24, Andy Shevchenko wrote:
> On Thu, Apr 22, 2021 at 04:46:40PM -0700, Stephen Boyd wrote:

>>>> +#include <linux/kernel.h>
>>>
>>> What do you need this header for?
>>>
>>
>> For typeof_member().
> 
> Argh... We really need to split this and container_of to something else. Having
> entire kernel.h for that is an overkill.
> 

Yeah, we should have a type-macros.h (or type-helpers or whatever) that
doesn't include any other kernel headers, just stddef.h (which is
compiler-provided) for offsetof(), providing

typeof_member
sizeof_member
container_of
same_type
type_min
type_max
is_signed_type
__choose_type

or whatever their names are currently.
