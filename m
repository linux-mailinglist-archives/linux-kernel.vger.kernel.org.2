Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD1E398D9C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhFBPBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230482AbhFBPBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622646002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+tyWsmFJ1Km9F7N+hZyqQ4T+xLeAXHNhyln3Rs50ZQ=;
        b=B/GivPnKbnUs6OIwVvVD8MY2TfeB53/Q4Mbhb8oeaXGXho/BfIi7+/p0t3j8Qy/MmuGLLR
        sHw+Pa+F6A88/YPe6/uYbuBRI2nLA+brw9kDJgVHsXaXg6iR0UO+Kp/l11Ng+gRs3OTiHL
        Pv19dUwipq0jZqt3gIsihngV51rTfVI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-ZL2KUF0qOdWizvXoCaNuHg-1; Wed, 02 Jun 2021 11:00:01 -0400
X-MC-Unique: ZL2KUF0qOdWizvXoCaNuHg-1
Received: by mail-qk1-f199.google.com with SMTP id s4-20020a3790040000b02902fa7aa987e8so1807998qkd.14
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 08:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R+tyWsmFJ1Km9F7N+hZyqQ4T+xLeAXHNhyln3Rs50ZQ=;
        b=Cw07l3zod+1rMSXw1tO/HJIbD+oR87V34tmgcSq8HLARdircXa8tRiY3xEZSXrwzXp
         VhNbuE5U8zcur1ePJizMfX3+Dg+wL9CPHqipoSsKJ7iyMb2iUwPGv3GncAfMfT1vnofx
         vaNp4OaQS3iPgBSrs6VF6ASLi1B6RujqwQpj0I4gNy/Rjv0Y9/eNFgDqMxJF1/T4j3XQ
         J4xR6kEm951fWs/Iu5rPFGX8lt7eURYJuiqI6n6nElZsTBvfQ/BU+5LcLxQCJcWCV2yL
         LvyYaD4JjEfWtzg9YQLp9zuhe5EQdpcV8rzTAXbQ7KNRprmlKhXRiTMrh0oqJWjXzn2j
         I5fQ==
X-Gm-Message-State: AOAM531hSfUp0qFX+xF6cAxj4OhZQ+yQrxOlH97w8g91a7+tWF2mFtwq
        7ONWgggwDDcngE9YFH0LLcyGefmWxbHRbjFR5H+cBLx0UAR6yXpg3EI2rLIsofj5PzyXlL1PMIX
        azIE3RuB6AN0co2eagwiVa+lu
X-Received: by 2002:a05:620a:40c7:: with SMTP id g7mr28049511qko.365.1622646000724;
        Wed, 02 Jun 2021 08:00:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypRWZtw6N4jInlLEvM/V8Xz4Qm73OYJN+yfXmZ+SBFlinbVFk1qXOn76wHIC8j5H0stKkxbQ==
X-Received: by 2002:a05:620a:40c7:: with SMTP id g7mr28049488qko.365.1622646000527;
        Wed, 02 Jun 2021 08:00:00 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id c23sm12599595qtq.87.2021.06.02.07.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 08:00:00 -0700 (PDT)
Date:   Wed, 2 Jun 2021 09:59:58 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Guenter Roeck <groeck@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] sched/debug: remove obsolete init_schedstats()
Message-ID: <20210602145958.k5232rngg2labzmm@treble>
References: <20210602112108.1709635-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602112108.1709635-1-eric.dumazet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 04:21:08AM -0700, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> Revert "sched/debug: Fix 'schedstats=enable' cmdline option"
> 
> This reverts commit 4698f88c06b893f2acc0b443004a53bf490fde7c.
> 
> After commit 6041186a3258 ("init: initialize jump labels before command
> line option parsing") we can rely on jump label infra being ready for use
> when setup_schedstats() is called.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Guenter Roeck <groeck@google.com>
> Cc: Kees Cook <keescook@chromium.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

