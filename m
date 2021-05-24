Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC4438E09B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 07:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhEXFNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 01:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbhEXFNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 01:13:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05722C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 22:12:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k5so14155184pjj.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 22:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=JebLWMT0Go/+c6aGerW7majYGlYeWtVwcKAWlcwxf8I=;
        b=s1qIj6Cq17y3CG1QhE7tI+l3duc+Z9YA8QhJqG0LiWlmzy3AA/Q/rROtpXfT2u02iU
         C4vrzM/L3jPDEsXFl0zrEkHSt0Q/SJ3tHaGIJofGBwcTQ4scFQNk3FHYpYKi6KTqIy45
         BB7uOjJP69bh7kLCtMUB/6hYmBcRZ3g7IE5+NvRXaGQ+n6pQXRBzttr6ai+aUYuyebsw
         tsf3AJWYkN3r0dFKWaG2ctPv9D2pUOOp6INrxDFZbvgsFZhYiE+t1ZdWczug0ThC6Xh5
         6lVghk9Z7Fhl/bdufS5xVfxONO8YC2dLg/LvPVhfVwIBDavWeyoQqBPZHfX48JRBjD2A
         0KTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=JebLWMT0Go/+c6aGerW7majYGlYeWtVwcKAWlcwxf8I=;
        b=ojc//71aeXITMe3rDgOmB1VvSgfeswg7mbY0fEmY+li8cyXJfS3C5ZpX3j5pGUHU1I
         hj2iiExprs+MPoHmy+aaDoI9Zk52j987HBZHdCcYbSvXsk833qrP/c7WXkbgPuGHbmXX
         QlBZwWNuP9TipFkCvHrMlaVFySq3/KFpN4f7Eylwy8J59pCSiz1m/QuzRCaPTuS/wZbI
         NgoxTy58z6Yy+hIusuS6giitlNlUlcub/qufoXjV18wtv1RRrAE44OQMfgMREAGUND0R
         FJEFUdwFaL/zWjhHuNbGliYPaZOedtxIxnxoHp5tEBBbCNpvY5NLA9anA/n5o2Ank0zH
         GMLQ==
X-Gm-Message-State: AOAM532cKcwgy1QeKY1g01OhAKf2OP1XP3uGdLvolH3xoMhL8Oaie5ZO
        BdfGYlram7CDVbGc9IXEt8KMng==
X-Google-Smtp-Source: ABdhPJyOeAfObOCV2tOeUqcW3AWSKvZL71x3qCe3JZiyC93/O47MXppqvIjlwwJvuxeeXH+vf5WNaw==
X-Received: by 2002:a17:90a:b78d:: with SMTP id m13mr23571087pjr.177.1621833132465;
        Sun, 23 May 2021 22:12:12 -0700 (PDT)
Received: from [2620:15c:17:3:9016:8a6d:7de4:aa23] ([2620:15c:17:3:9016:8a6d:7de4:aa23])
        by smtp.gmail.com with ESMTPSA id s2sm11141816pjz.41.2021.05.23.22.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 22:12:11 -0700 (PDT)
Date:   Sun, 23 May 2021 22:12:11 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Stephen Boyd <swboyd@chromium.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] slub: Actually use 'message' in restore_bytes()
In-Reply-To: <20210520013539.3733631-4-swboyd@chromium.org>
Message-ID: <f4da67db-a53b-a710-947d-474be7aad07@google.com>
References: <20210520013539.3733631-1-swboyd@chromium.org> <20210520013539.3733631-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021, Stephen Boyd wrote:

> The message argument isn't used here. Let's pass the string to the
> printk message so that the developer can figure out what's happening,
> instead of guessing that a redzone is being restored, etc.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Acked-by: David Rientjes <rientjes@google.com>
