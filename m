Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E1C30F6F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbhBDP40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbhBDPyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:54:39 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01715C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 07:53:57 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g15so2378856pgu.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 07:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=12TvnDbFoHozjXEBq3jhYOc5BE9nWZn0P3eT299I/9M=;
        b=NinYrz5HwaCb0qq/rEnNwOPx6QmtQi63UUzFzsXFLnUBHeZC1H0vd4gdNitL8ljpn7
         JgbnHSKWmW8zBYdCVeLnOw62uOaK2xAOYM5qaGXVX2cObM96tsJwsghylpKX5J2JmCEp
         zRZWWXLSEb3bhPr4fAPlOfAWOKx0lAIs3W3L/cAwvOWXKLWBeEF8oDrsB5jh89QZs1ha
         zUttQr9P5McciU0O78xQjpF+8TJWdQuJSktoRmHxX2bKbS+oXsw9MGpdGrIvcgmuK6J6
         /DcDhIkd+cjexFi1QS9deq9KnoqL3e7307opKt+JWr3j7i+Ax6lbN3bP3zMbx4Lso8hf
         HEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=12TvnDbFoHozjXEBq3jhYOc5BE9nWZn0P3eT299I/9M=;
        b=avJcqbX7mpItl9MJO7cQgANciTANN6N5u9Hs/eVPOytbrT4/RLE17YMWynY1pp1wEp
         34c9Lici2yBakh1Aw8gkYYT7JBiTlhH6TdNCAw5b+YTY47siOVsKBFbxdwUIEsj5IJIC
         WzaV4zkbr/kW9d6i+YDsqzucVJlU89KeIaTE5T2GusjkpVgRJQBy+K9AmycY2Mr1o+7E
         joSEC96I8ZiE0DXbe0MwOArjoGcFDcdIvovjfVlIMzjQZmocQ45q0vcQbLXij2z6rKMl
         O7cQeBeHxcG+p0YvKU+fGvo/+SOUh0Yecw3eDmQhqP/z6nd+9Fv6a64C5x/W9wib3W//
         kO9Q==
X-Gm-Message-State: AOAM533AnBKSa4y71kmgT+DkrEfZd3g6bGPBmXmhJ6tWPCqEtsX4dAAM
        by4xon+PA2TcbnTjo3OhKlA=
X-Google-Smtp-Source: ABdhPJxBXdR4q9H553UCiCPpdlcKwZ6b4yXIEmQNTn2cfq/9NXQmnXeoTexpuI1RuIEGOoKpWIvuPw==
X-Received: by 2002:a63:105e:: with SMTP id 30mr9541231pgq.24.1612454036561;
        Thu, 04 Feb 2021 07:53:56 -0800 (PST)
Received: from localhost.localdomain (61-230-45-44.dynamic-ip.hinet.net. [61.230.45.44])
        by smtp.gmail.com with ESMTPSA id 16sm5580890pjc.28.2021.02.04.07.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 07:53:55 -0800 (PST)
From:   Lecopzer Chen <lecopzer@gmail.com>
To:     will@kernel.org
Cc:     akpm@linux-foundation.org, andreyknvl@google.com, ardb@kernel.org,
        aryabinin@virtuozzo.com, broonie@kernel.org,
        catalin.marinas@arm.com, dan.j.williams@intel.com,
        dvyukov@google.com, glider@google.com, gustavoars@kernel.org,
        kasan-dev@googlegroups.com, lecopzer.chen@mediatek.com,
        lecopzer@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mm@kvack.org, linux@roeck-us.net, robin.murphy@arm.com,
        rppt@kernel.org, tyhicks@linux.microsoft.com,
        vincenzo.frascino@arm.com, yj.chiang@mediatek.com
Subject: Re: [PATCH v2 0/4] arm64: kasan: support CONFIG_KASAN_VMALLOC
Date:   Thu,  4 Feb 2021 23:53:46 +0800
Message-Id: <20210204155346.88028-1-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204124914.GC20468@willie-the-truck>
References: <20210204124914.GC20468@willie-the-truck>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Jan 09, 2021 at 06:32:48PM +0800, Lecopzer Chen wrote:
> > Linux supports KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> > ("kasan: support backing vmalloc space with real shadow memory")
> > 
> > Acroding to how x86 ported it [1], they early allocated p4d and pgd,
> > but in arm64 I just simulate how KAsan supports MODULES_VADDR in arm64
> > by not to populate the vmalloc area except for kimg address.
> 
> The one thing I've failed to grok from your series is how you deal with
> vmalloc allocations where the shadow overlaps with the shadow which has
> already been allocated for the kernel image. Please can you explain?


The most key point is we don't map anything in the vmalloc shadow address.
So we don't care where the kernel image locate inside vmalloc area.

  kasan_map_populate(kimg_shadow_start, kimg_shadow_end,...)

Kernel image was populated with real mapping in its shadow address.
I `bypass' the whole shadow of vmalloc area, the only place you can find
about vmalloc_shadow is
	kasan_populate_early_shadow((void *)vmalloc_shadow_end,
			(void *)KASAN_SHADOW_END);

	-----------  vmalloc_shadow_start
 |           |
 |           | 
 |           | <= non-mapping
 |           |
 |           |
 |-----------|
 |///////////|<- kimage shadow with page table mapping.
 |-----------|
 |           |
 |           | <= non-mapping
 |           |
 ------------- vmalloc_shadow_end
 |00000000000|
 |00000000000| <= Zero shadow
 |00000000000|
 ------------- KASAN_SHADOW_END

vmalloc shadow will be mapped 'ondemend', see kasan_populate_vmalloc()
in mm/vmalloc.c in detail.
So the shadow of vmalloc will be allocated later if anyone use its va.


BRs,
Lecopzer


