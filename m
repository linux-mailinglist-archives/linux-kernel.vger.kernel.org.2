Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5053638FC16
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhEYIJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhEYIC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:02:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753D8C06134B
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 01:00:39 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so12690932pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gchEmDe+oRb5ftX56FYGhtL1CvMT7RWbmjwlMqhvjpU=;
        b=Bi7XQPY7lQeZ1QeotVdNrHHmJLkgHfcPqD9lmKjLdCUm/nxRHTqSWYG3RsDvFHxx0E
         Lm27iXNs/aKXKr+vV6Qro6rEn8XRMyXirp2LEgmycG8kNfzwLaOHgFyVCmMrnXv9pc5w
         DdDmIcrm+iByZDuLXIL3hjAiVrAjRrNM9S1gFbzXuW1Dl8PJRvOH29SsQsIZ4MSilB07
         +Swy/7dXSJbSDqK2Q5WE6tp+mhyeDtdoJkCxBTw8D+KPbLDBzhvXRBjn7SS4QGjrGx3+
         DZwlPtBCijqVJQukA5nPxjWBj85w50LgtamyBkPtIX+nnAzUyK8lQLPeA3eN/uzO69VC
         rhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gchEmDe+oRb5ftX56FYGhtL1CvMT7RWbmjwlMqhvjpU=;
        b=lT3mipxl19m2yhv2FORcRT1QLMwzVhZVUYX3RjDqh5mj6EveKn8EqtXE4ot7GV8ncz
         cbm7c7s5a/qU61lCtYfxjDtxM/cjdq3lX69Xx5gzKUcm3XLO/3K3wQJNEnuQxAQkwvX+
         vhNa0NAuBx4KAKvaWZfUbd1zN6Bzzj+r47LYNrgp5umiM/MJNiadiwa8RcNCXVKbnXcH
         h9A6zNrXp/e4koxWBCMKnyBf2ELdl0AoOpWLBlu5I43GKXAIr8PQwwFvcpSaLRXDM5hp
         Z0ly0N4AI+W5PqolyzcOzTf8P8+Ru7uOq+m/oWS4t2NEBSTnHER/wrsT/FCoPnrWW3CU
         rozQ==
X-Gm-Message-State: AOAM531PVqcR2/u0SVqK8rpw3pT9vyXH74dz/r5F/ioE1f38yLc0gB5E
        YmgJniR0irWYxMVV7kSN1Yk=
X-Google-Smtp-Source: ABdhPJx73Fq00enLr2aONG1g9uC31io/Xz1z6wNY0U7uPc9dCIWSZYNTtyEJF8LTaSHfc8H32cRQMA==
X-Received: by 2002:a17:902:7795:b029:f2:63cb:ab16 with SMTP id o21-20020a1709027795b02900f263cbab16mr29180113pll.7.1621929639029;
        Tue, 25 May 2021 01:00:39 -0700 (PDT)
Received: from hyeyoo ([121.135.181.35])
        by smtp.gmail.com with ESMTPSA id b21sm9699790pfo.47.2021.05.25.01.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 01:00:38 -0700 (PDT)
Date:   Tue, 25 May 2021 17:00:33 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: line6: Improve poor error handling in
 line6_init_cap_control
Message-ID: <20210525080033.GA13895@hyeyoo>
References: <20210524173644.GA116662@hyeyoo>
 <s5hh7ire1jq.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hh7ire1jq.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 09:05:13AM +0200, Takashi Iwai wrote:
> Those resources are freed in the common destructor of the card
> instance, line6_destruct(),

Oh my god, I missed line6_destruct.

> at disconnect callback, so it's redundant
> to release them here; even worse, since you haven't re-initialize with
> NULL, this change would lead to double-free.

Yes then it can cause double-free..

>
>
> thanks,
>
> Takashi

I made a mistake, I'm so sorry to take your time...

Thanks,
Hyeonggon
