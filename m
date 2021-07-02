Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404B93B9E52
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 11:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhGBJkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 05:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhGBJkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:40:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97212C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 02:37:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t6so1779094wrm.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 02:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zmw3iGewZOSDs+c1/yw4f6lr9XV4A3V9IcDrAGu7EUY=;
        b=seJWsMXt7a9DQs5DTguOn4v7czLJozx50c2KMxvJ4ChgjdtfcJyFCrU/niutcOA+17
         6X6qQ+SHlKgbMtZkwaOwkt6RLhr9yuf9/tsn0WWkDbQaxS+ki4At8iFVOqMCU5a19yCe
         tm69GcfqmEfa8fMZdN8F6lEiHga/q9OMHvemh8fDmy/MS2BX3A6lrVZV7dm0VphoYvy7
         LEYAh/Y1/GZSaqOlINaCz/lyXL10VRCFUnLYhH7fkrYSsNOI+ZSemuqX9QPy13tNcqwd
         zhMMfns1XnzlKyfTOnGCPyXQcIn8JrwxNCXGEBWdW/JHoevLDs1QDlIB2D/Y3mbA1SX4
         AJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zmw3iGewZOSDs+c1/yw4f6lr9XV4A3V9IcDrAGu7EUY=;
        b=TzTUihwK7/TQApx+BBZn1RLUO62WRUQUbaJC4md4nKBRWP6aNj17TYvzeNw2ZP83Wf
         uv6V8PhcVwAOL4/VNFccVS4KaXABmDBNwIDIlT3Loi23LWTzW80BtsqQOfby893MnSop
         s+l+0rITQyMuWllxBf+ul54S9bkoBBYTeDpVyMqAWHm0actvc8T0TOsdV1wx5kspuWdq
         Jwzk9uwhverVimuGrw9NNuSfaFEsH8O9nwlaiJOQK5sFesvXFoq/FWi6NU13eqaCY4dG
         EMXvkvpD4WWLvZfOudbAMbZBg2wmIdQ0AFzy5Z4jBmY54mL44ll4SzfTv3Y6OinfWTcU
         cm+Q==
X-Gm-Message-State: AOAM532QmAaCst8aMF7mMljB1EvYtt6Bd/D2rekWN3rnQ/8RSh2xBBFS
        X8eQ89uO1W+Gzs2Q6qrYiipEVA==
X-Google-Smtp-Source: ABdhPJwVYrqppuZ9dDMO5GSgWooXxasPLeNPUlx9D0W1HifuqLwAmdYA1yAtMT4Xr+2+B5Xz11IQIQ==
X-Received: by 2002:a05:6000:18af:: with SMTP id b15mr4769198wri.252.1625218662074;
        Fri, 02 Jul 2021 02:37:42 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:212e:6681:cd1c:caef])
        by smtp.gmail.com with ESMTPSA id n18sm6583605wms.3.2021.07.02.02.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 02:37:41 -0700 (PDT)
Date:   Fri, 2 Jul 2021 11:37:34 +0200
From:   Marco Elver <elver@google.com>
To:     yee.lee@mediatek.com
Cc:     andreyknvl@gmail.com, wsd_upstream@mediatek.com,
        nicholas.Tang@mediatek.com, Kuan-Ying.lee@mediatek.com,
        chinwen.chang@mediatek.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v4 2/2] kasan: Add memzero int for unaligned size at DEBUG
Message-ID: <YN7eXr30zVH7nLhQ@elver.google.com>
References: <20210702085422.10092-1-yee.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702085422.10092-1-yee.lee@mediatek.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 04:54PM +0800, yee.lee@mediatek.com wrote:
> From: Yee Lee <yee.lee@mediatek.com>
> 
> Issue: when SLUB debug is on, hwtag kasan_unpoison() would overwrite
> the redzone of object with unaligned size.
> 
> An additional memzero_explicit() path is added to replacing init by
> hwtag instruction for those unaligned size at SLUB debug mode.
> 
> The penalty is acceptable since they are only enabled in debug mode,
> not production builds. A block of comment is added for explanation.
> 
> ---
>  v4:
>  - Add "slab.h" header
>  - Use slub_debug_enabled_unlikely() to replace IS_ENABLED
>  - Refine the comment block

^^ this changelog ...
 
> ---

^^  this '---' is wrong unfortunately.

> Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> Suggested-by: Marco Elver <elver@google.com>
> Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>


... should come after the tags.


git am removes anything between the first '---' and the actual patch
from the commit message.

The typical convention is to place the changelog after a '---' _after_
the tags, so that it is removed from the final commit message.

I think the code looks fine now, so please go ahead and send v5.

Thanks,
-- Marco
