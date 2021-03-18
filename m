Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D496933FF11
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhCRFtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhCRFtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:49:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2D5C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:49:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t18so2330273pjs.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/IGZVuweRu6CPPw463C/ZxJu8oJGSzsf9afcHvnBJbo=;
        b=kkUCdYFXfa12B6BvXLlo0LOabXx2k0J0Cd0fL/lFLZnQqDr0eNdHOsnGkxs51cKXQo
         w0sgaKhjaB8PdvZalUU8In0B8HXRkgkThJpbdk0D1MQG11k1dqFL7N6qByfXRsCUtb2b
         OHRKQofIfe8E4jAGeGs+qWnWWPDBZiQwB1DDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/IGZVuweRu6CPPw463C/ZxJu8oJGSzsf9afcHvnBJbo=;
        b=quWvAzGwGVOxBf5+agb/EnXgoD3jlHs0ZqdoGQVTgjYfsposuPwm3j//x5oLkoDHEO
         rxDh4xIrkIDxXblUqoQ/RzAr7f8wtI07BbIl9gll07b5xe99ljkHDWpH4LVz80Yn+ULG
         5ELXHrupaa9rVAMYiNqEf2mhPCHS8+6zVpJcIuK8iYNUK8+xL/CoraSaIboFRCNY1NLI
         opY3QAGUtAuzmTd/bxW6wvYWzQSf+bTDU30FHrVa/Gv3vAhli+sw71OFKyoRJQuFEi1n
         +YNW8GU0AAnAJvV4wXqPohLMOJ0s/5aQb+SM91Dfvj4e9HtLflHqPDY647lPQSox+GdF
         MQMQ==
X-Gm-Message-State: AOAM531qqAXEOIFl6olBEryRAu2kkW9JH6Z2uG0ZdzLFCkpyMJWQDIGs
        0PUTl0SjpCLwleqKC2po4ZrJtQ==
X-Google-Smtp-Source: ABdhPJxwOia9xLbDgqEHN0e3SfA53aZUhmK7jqQInSgOgFKW9c3RVpCSuua+thzc48IZ5KBPXMsxWg==
X-Received: by 2002:a17:90b:4c4d:: with SMTP id np13mr2573124pjb.81.1616046539924;
        Wed, 17 Mar 2021 22:48:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o9sm969136pfh.47.2021.03.17.22.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 22:48:59 -0700 (PDT)
Date:   Wed, 17 Mar 2021 22:48:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Add slub_debug option to panic on memory
 corruption
Message-ID: <202103172244.D5ADB06A96@keescook>
References: <20210309134720.29052-1-georgi.djakov@linaro.org>
 <390d8a2f-ead9-48a9-99eb-65c73bd18422@suse.cz>
 <6bfebf01-5f52-49bd-380b-04785c474c81@linaro.org>
 <8fd43de6-71e4-cfe7-8208-32753cf1c363@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fd43de6-71e4-cfe7-8208-32753cf1c363@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 07:18:32PM +0100, Vlastimil Babka wrote:
> On 3/9/21 7:14 PM, Georgi Djakov wrote:
> > Hi Vlastimil,
> > 
> > Thanks for the comment!
> > 
> > On 3/9/21 17:09, Vlastimil Babka wrote:
> >> On 3/9/21 2:47 PM, Georgi Djakov wrote:
> >>> Being able to stop the system immediately when a memory corruption
> >>> is detected is crucial to finding the source of it. This is very
> >>> useful when the memory can be inspected with kdump or other tools.
> >>
> >> Is this in some testing scenarios where you would also use e.g. panic_on_warn?
> >> We could hook to that. If not, we could introduce a new
> >> panic_on_memory_corruption that would apply also for debug_pagealloc and whatnot?
> > 
> > I would prefer that we not tie it with panic_on_warn - there might be lots of
> > new code in multiple subsystems, so hitting some WARNing while testing is not
> > something unexpected.
> > 
> > Introducing an additional panic_on_memory_corruption would work, but i noticed
> > that we already have slub_debug and thought to re-use that. But indeed, аdding
> > an option to panic in for example bad_page() sounds also useful, if that's what
> > you suggest.
> 
> Yes, that would be another example.
> Also CCing Kees for input, as besides the "kdump ASAP for debugging" case, I can
> imagine security hardening folks could be interested in the "somebody might have
> just failed to pwn the kernel, better panic than let them continue" angle. But
> I'm naive wrt security, so it might be a stupid idea :)

I've really wanted such things, but Linus has been pretty adamant about
not wanting to provide new "panic" paths (or even BUG usage[1]). It
seems that panic_on_warn remains the way to get this behavior,
with the understanding that WARN should only be produced on
expected-to-be-impossible situations[1].

Hitting a WARN while testing should result in either finding and fixing
a real bug, or removing the WARN in favor of pr_warn(). :)

-Kees

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on

-- 
Kees Cook
