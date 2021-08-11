Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BB23E9966
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 22:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhHKULD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 16:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKULC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:11:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D18C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:10:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so11440482pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hZRR3KbThFnNJYUDfRkki0dEGff2LS9+I9PdbQL0MA8=;
        b=Wzyx1Y0L8r1Jt66tvpbEFeO18N8SDEIH4Kdx5HNC/xp1AyIqwmj+1piwMrT6W8Gk6o
         Mdwrl5t8Bvb2PFPkQyMbfmnUVv3ptp4sk+vl5/omH4qUu3e7B87YM/b21EyWlVUOkei6
         mrrQJ2WUFQHjOWoni4SNg+oErCVDyQGsemtUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hZRR3KbThFnNJYUDfRkki0dEGff2LS9+I9PdbQL0MA8=;
        b=OZ2rNvu0BJ4et6weh7uO/A4xj+G0NbZarrwTtIIojYcwtahQ0r3IzFa7/mID0vY/xa
         92YrBa40CyBwB2NdTaxntivZDWqld2HizXupus0U9aRzwDDzDZ0q/ZWnN2bDryoZS5+6
         GtnwzQs5Xu5dpAHc04P60T88y0jqnLvRPEnNtBsDZpmRnPRelh2jeZGgUwuizrBVL4PB
         lRNTCJNgWu3zRZ7LiT/DcMNZYrLatnGRUTVTw5QPtJCLY22xIoVJpOkCrky9jt9D3cmj
         0L7ak3lCaVOa/xHYfNrVH7+KzEGIh+phFp3nGYr75ke3w+SDbLEs6jRmPoIZPVChsJUV
         0Agw==
X-Gm-Message-State: AOAM530L9LxzS0Rp5yNbgeKoVh8pvlW1RmgJCITLQSTePK5yG/bhl1q3
        eOaQ00e17kyZST/j1uYMjGAZBA==
X-Google-Smtp-Source: ABdhPJxmyg1h9DKqWJ+EwyXYBn1yzs6AKuJmcCk2R0eO5h3KlCfZakOp8eSCRFpns/ZbcAIVgVrMDQ==
X-Received: by 2002:a17:902:d487:b029:12d:4209:a72 with SMTP id c7-20020a170902d487b029012d42090a72mr587922plg.8.1628712637800;
        Wed, 11 Aug 2021 13:10:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v16sm7844849pje.24.2021.08.11.13.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 13:10:37 -0700 (PDT)
Date:   Wed, 11 Aug 2021 13:10:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Jinlong Mao <jinlmao@codeaurora.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH 1/1] cfi: Use rcu_read_{un}lock_sched_notrace
Message-ID: <202108111306.527943F39@keescook>
References: <20210811155914.19550-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210811155914.19550-1-quic_eberman@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 08:59:14AM -0700, Elliot Berman wrote:
> If rcu_read_lock_sched tracing is enabled, the tracing subsystem can
> perform a jump which needs to be checked by CFI. For example, stm_ftrace
> source is enabled as a module and hooks into enabled ftrace events. This
> can cause an recursive loop where find_shadow_check_fn ->
> rcu_read_lock_sched -> (call to stm_ftrace generates cfi slowpath) ->
> find_shadow_check_fn -> rcu_read_lock_sched -> ...
> 
> To avoid the recursion, either the ftrace codes needs to be marked with
> __no_cfi or CFI should not trace. Use the "_notrace" in CFI to avoid
> tracing so that CFI can guard ftrace.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Thanks for this patch! While applying it I noticed that the DKIM
signature failed. This is actually even visible in the lore archive:
https://lore.kernel.org/lkml/20210811155914.19550-1-quic_eberman@quicinc.com/raw
(DKIM_INVALID)

$ b4 am -tls https://lore.kernel.org/lkml/20210811155914.19550-1-quic_eberman@quicinc.com/
Grabbing thread from lore.kernel.org/lkml/20210811155914.19550-1-quic_eberman%40quicinc.com/t.mbox.gz
Analyzing 2 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✗ [PATCH 1/1] cfi: Use rcu_read_{un}lock_sched_notrace
    + Reviewed-by: Sami Tolvanen <samitolvanen@google.com> (✓ DKIM/google.com)
    + Signed-off-by: Kees Cook <keescook@chromium.org>
    + Link: https://lore.kernel.org/r/20210811155914.19550-1-quic_eberman@quicinc.com
  ---
  ✗ BADSIG: DKIM/quicinc.com



Do you know if qualcomm is mangling outbound emails? (i.e. was the
trailing body suffix added after calculating the DKIM signature?)

Thanks!

-Kees

-- 
Kees Cook
