Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C3A3DCEE3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 05:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhHBD0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 23:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhHBD0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 23:26:16 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740D4C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 20:26:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k4-20020a17090a5144b02901731c776526so29525133pjm.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 20:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=fY3bTijU6Gb04TFq1RIXd8jCmJsbDrkR6i4HqP4dglU=;
        b=jxL6WshFF20ldGPyHr6Ggzso3E86G1zQekA8y4cpogB+HSpClq7/QP7AyKJeQURLZu
         0DSnvm4Xh+sBMLYx79ogN/gtNN8w6vK7NTCFr/UHlABFj1P8CSM0gTeHAQTSLseoziMt
         4uiBj9FhtwaXnv5t0Q6MjPWt+sI49vw5Lw0rxyaZmB69bGptruBU9CX8SzYChdyt61ch
         tVqjkg7oZ5iCYKlNVzwYeGAiSE3UtBsJDJZyEmq9N9vjXbOfKzoO57tpHmS6NjUV/5dy
         /FWhRSpx4+AfEwtuXmfvAMqKNQ/Pp74L+8irL9kQVN/mCZxIEGwS8ZydQP9VWTkpiM5Q
         EpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=fY3bTijU6Gb04TFq1RIXd8jCmJsbDrkR6i4HqP4dglU=;
        b=YHFU+RbksdR3BxW4VkxKzoIJVHzpsWgkIsuFGC7OaAlJ/096D3UTdYLil5/j4S5m0V
         x6heF3wT5f4GUsAOLbWGYXMuOb94brJVGeNO91MBJyj08mejK7Nssg/TlBaJOtJ+KQUD
         w++heX4zP4N9x34AmQ90LPd4tEiX984XeYShwkt1iwH0DqGU2cmivZFVM6RPGjLdv0OT
         pqn825iqdp0+rf5CJ5VUw0bM1SZb+FqDdefv9FBbaDt0mIpmuuv7hR6H3h7LNXKXUU0B
         XxrZLcZa3/43uS1+Vl8ydJtIbxGv1xib4nnQuoDL5+Hfwo9By4MZ5MXepfW4WpFWDaPS
         xMrw==
X-Gm-Message-State: AOAM531ZFKelpcD4hBCwVifXqfv7IN8IhMaNrS94iwtQAUHz2SfBcQw+
        KpsHINtvvU9P4H0bQEj/OIySbQ==
X-Google-Smtp-Source: ABdhPJyptad5Ewu1xNDCXTUeSSQ+YYElc7yFa+yls2G9a4s19lOkETRV3ni8rtKBZpjfSGp8g3AOzA==
X-Received: by 2002:a63:d34e:: with SMTP id u14mr692880pgi.244.1627874765775;
        Sun, 01 Aug 2021 20:26:05 -0700 (PDT)
Received: from [2620:15c:17:3:f081:306b:20f6:7d15] ([2620:15c:17:3:f081:306b:20f6:7d15])
        by smtp.gmail.com with ESMTPSA id y139sm9460074pfb.107.2021.08.01.20.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 20:26:05 -0700 (PDT)
Date:   Sun, 1 Aug 2021 20:26:04 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Vijayanand Jitta <vjitta@codeaurora.org>, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
Subject: Re: [PATCH] mm: slub: Fix slub_debug disablement for list of slabs
In-Reply-To: <8a3d992a-473a-467b-28a0-4ad2ff60ab82@suse.cz>
Message-ID: <c2d6cbbf-8eaa-3198-9b43-73eb5965fb1f@google.com>
References: <1626176750-13099-1-git-send-email-vjitta@codeaurora.org> <bf2a8571-325c-6d94-0d5a-f6df71ae0c4f@suse.cz> <e0442add-dcf0-57d7-2298-3459136673af@codeaurora.org> <8a3d992a-473a-467b-28a0-4ad2ff60ab82@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2021, Vlastimil Babka wrote:

> From 81a225fe31e53701902bb4caa9ab1524eb044cbc Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 13 Jul 2021 17:15:50 +0530
> Subject: [PATCH] mm: slub: fix slub_debug disabling for list of slabs
> 
> Vijayanand Jitta reports:
> 
>   Consider the scenario where CONFIG_SLUB_DEBUG_ON is set
>   and we would want to disable slub_debug for few slabs.
>   Using boot parameter with slub_debug=-,slab_name syntax
>   doesn't work as expected i.e; only disabling debugging for
>   the specified list of slabs. Instead it disables debugging
>   for all slabs, which is wrong.
> 
> This patch fixes it by delaying the moment when the global slub_debug flags
> variable is updated. In case a "slub_debug=-,slab_name" has been passed, the
> global flags remain as initialized (depending on CONFIG_SLUB_DEBUG_ON enabled
> or disabled) and are not simply reset to 0.
> 
> Reported-by: Vijayanand Jitta <vjitta@codeaurora.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Vijayanand Jitta <vjitta@codeaurora.org>

Acked-by: David Rientjes <rientjes@google.com>

Looks better, thanks!
