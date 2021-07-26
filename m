Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0295E3D5122
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 03:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhGZBGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 21:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhGZBGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 21:06:52 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C435C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 18:47:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso4758022pjo.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 18:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=kRanx6zdiIZx2L0mh1uE63PGEjHt+/w4xPUFYD+g1HM=;
        b=gm9vFCkoUvqsjiaf6Cdl5mV1rCQhdWIGmC+G4CmwqhfiPEp0pZNimiTD5+gl5jguuv
         kIMsRazmzPePVpfByYmnY/Q7VjnZoMire6uZ5B6nN8qNZQ3kHw+jJvmTJ+V7EHWfaLVt
         ZuxEvtH3VHye0OJLxryYJFZAAAOdlre9VFgBnLnTvB3JL7PslMQKFUpaxmLMMZ4m8qQA
         eqGLSuBS0EB6sPcSsx7uYBxowoFwu9ppsKJt9FMTeiSU/PYQSjMcXgfLd9DLrw/PYhYH
         ZaWZUwvlLpxl8ql6JHVCk1vqPFvEQYqAMvLV0Enh+WybIxxRtb+McbNgy79PAMYuGyFt
         +j8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=kRanx6zdiIZx2L0mh1uE63PGEjHt+/w4xPUFYD+g1HM=;
        b=suOEdy0pg/B9aQ5VJhvQ4VVsy7vUYpQpMMVxydl2Wu3dEvpNmuof7aF5z5VJQuEE6U
         8yaj3/dzHJyZpRiAAMmiceQY15oUjw5OQOY3MH4vga+ZJNTBP4kpxfRriv5TeWho95wq
         DbY1pcM0d/7VdKTXZpVxEqgU5dgpKZSTW7MAObCbPCZJjRji5HLWXHOUwiomB+XCpA5H
         7YwlEPN6QfZ6Ua+sIEAKzbwibhxYIelRLio3uhCQ3oVJez+HGtGABcK7bAs06vmwdKlv
         q3Ha/S1LaErhvM0sFZr4ykXMr67+eEPlmXeqnFmrBxxPvmipIh3neuo+uYNJvISpOF9h
         QZ7A==
X-Gm-Message-State: AOAM5334CAXOI5oWIF/51EPtpVgoTfWWTisoPv/RvefV3PsVWys6nYgq
        rS/cWS+Mwyn7ZHvGparg15CPEg==
X-Google-Smtp-Source: ABdhPJyR0Sm06D4XnVwRwy8FIAvgJ2gpbOZ4EzNVPCIjcx7HA1DkEhjwKPphKlw9sDUo5TdiQV1ZJA==
X-Received: by 2002:a17:902:ea09:b029:12b:1dc0:ac74 with SMTP id s9-20020a170902ea09b029012b1dc0ac74mr12451495plg.82.1627264040423;
        Sun, 25 Jul 2021 18:47:20 -0700 (PDT)
Received: from [2620:15c:17:3:ca7d:5de8:9c9:c7c0] ([2620:15c:17:3:ca7d:5de8:9c9:c7c0])
        by smtp.gmail.com with ESMTPSA id k20sm11868208pji.3.2021.07.25.18.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 18:47:19 -0700 (PDT)
Date:   Sun, 25 Jul 2021 18:47:18 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Charan Teja Reddy <charante@codeaurora.org>
cc:     akpm@linux-foundation.org, vbabka@suse.cz, nigupta@nvidia.com,
        khalid.aziz@oracle.com, vinmenon@codeaurora.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] mm: compaction: optimize proactive compaction
 deferrals
In-Reply-To: <1626869599-25412-1-git-send-email-charante@codeaurora.org>
Message-ID: <83f046a3-5afc-fe6d-40dc-d7aee7b7e398@google.com>
References: <1626869599-25412-1-git-send-email-charante@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2021, Charan Teja Reddy wrote:

> Vlastimil Babka figured out that when fragmentation score didn't go down
> across the proactive compaction i.e. when no progress is made, next wake
> up for proactive compaction is deferred for 1 <<
> COMPACT_MAX_DEFER_SHIFT, i.e. 64 times, with each wakeup interval of
> HPAGE_FRAG_CHECK_INTERVAL_MSEC(=500). In each of this wakeup, it just
> decrement 'proactive_defer' counter and goes sleep i.e. it is getting
> woken to just decrement a counter. The same deferral time can also
> achieved by simply doing the HPAGE_FRAG_CHECK_INTERVAL_MSEC <<
> COMPACT_MAX_DEFER_SHIFT thus unnecessary wakeup of kcompact thread is
> avoided thus also removes the need of 'proactive_defer' thread counter.
> 
> Link: https://lore.kernel.org/linux-fsdevel/88abfdb6-2c13-b5a6-5b46-742d12d1c910@suse.cz/
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>

With Andrew's comment fixup:

Acked-by: David Rientjes <rientjes@google.com>

Thanks, Charan.
