Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3535348131
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbhCXTEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbhCXTEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:04:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3E5C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:04:31 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y5so18062968pfn.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=QYn7+gAny9N0L7YNODXpZhVJB6CGOGCCHqKX1jMm/is=;
        b=J2b5faBOM2PIY5xtJ7yxYAVq0CQQ6j6bHm31aUAT01btGkAxh6Vf0xXx3q87cLf9OT
         7txDqdVNGFqO/A6RwrQNX7Bc8wtXnB+deAHgHH1BNE26ECiOD136jiLZPgbv3+KsI9hh
         g4Hk/umj2Jse7nkvDUD5bl9iNGKg/hilCKTfVBY0HZ4CixlRaQGnra4ABGS5fCqX7BNk
         oWw1mgbMKMs4LWiLPjLFW3QHfrc4EphkXWol/HqYT+CoZhw7l2OVd6TWVqKXqz3ys/Hg
         0gq0RJPrxkL90GoiejiB5AOlLz1+CnDybM0YjGbnBxXzhyCzywJOH35d3d5nVPeyuFD4
         RGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=QYn7+gAny9N0L7YNODXpZhVJB6CGOGCCHqKX1jMm/is=;
        b=S5bNWIr8qeLrkaWnG4LGhbNMmnzCS1j7EOuo2Dp6jHpn2RqUC6uFI/cFzEgh7sSCwE
         6u3tSm0VhXD3A4poIhh8TsfonEo8MCxRx2shhrMYslAndEfUBzqsGLk2dP5hSGdMP7HH
         ejQNNotBqUKDIy4oLpmPtvRKQFSlbTvWMMVv1qPHj+PY2aChhvIPUyTSPnq6rpxF2EsF
         ZL72HNB1QKlPizoQUKgG65f/z5Pn64pn4aDe4cMvukeqbnopL4ApGG31/gZgjMcdfkU1
         8piD++kPnlO40WteMfcSkrgD3lKK/YvIF7sVpNSdYp+Y/tmWvZ2x0VW7lji8aSmZFwYl
         tFwg==
X-Gm-Message-State: AOAM530QFL5YEVFuiJKoHHbcgRgw9XfeaukRfidLedOAOADbp4LPDNhF
        lOKRYhz/taYOaNm+Lb1RRIkJsQ==
X-Google-Smtp-Source: ABdhPJycB/AL3pfUTofUhdLYLDP9Vzxp+dnQ0lDrUOT1Upp/nn5+ScS4JXLoTRDUJhygMWWGFIAyAQ==
X-Received: by 2002:a17:902:7407:b029:e4:9b2c:528b with SMTP id g7-20020a1709027407b02900e49b2c528bmr5129381pll.6.1616612670564;
        Wed, 24 Mar 2021 12:04:30 -0700 (PDT)
Received: from [2620:15c:17:3:4192:718f:4827:be5] ([2620:15c:17:3:4192:718f:4827:be5])
        by smtp.gmail.com with ESMTPSA id m1sm3316599pjf.8.2021.03.24.12.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 12:04:29 -0700 (PDT)
Date:   Wed, 24 Mar 2021 12:04:29 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Uladzislau Rezki <urezki@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 2/4] mm/util: Add kvmalloc_node_caller
In-Reply-To: <20210324150518.2734402-3-willy@infradead.org>
Message-ID: <64ad8d1-78df-3c8-99a8-ffeb10e9484c@google.com>
References: <20210324150518.2734402-1-willy@infradead.org> <20210324150518.2734402-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021, Matthew Wilcox (Oracle) wrote:

> Allow the caller of kvmalloc to specify who counts as the allocator
> of the memory instead of assuming it's the immediate caller.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: David Rientjes <rientjes@google.com>
