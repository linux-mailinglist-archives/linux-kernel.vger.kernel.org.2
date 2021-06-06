Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32DB39CBCD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 02:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhFFAIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 20:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhFFAIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 20:08:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9FEC061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 17:06:40 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so8107920pjq.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 17:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=OL0o9SDf4tTsguK9+lcQeIJnwnWOMWcR92PaYoaPkNA=;
        b=JW4x6+7B8oF/XwqryVTu+lXHyuTY8auGs9/MSTukRYJcIKulXtb+wDx1dhonV5dFD4
         +wG//3vGutZRgL08QwM0v0i/0kf0JTPxA4fxNkIhXFOJwoHACCYPa6qni0UW0StI766q
         FTBZ77cVE3AWscBv9riWsfs9xn15BEcHwYZXJvUzFjjiuDng5zHePeVBM4ZniCwRcELF
         t5e0jFD2eRmzIhiOTP10N+mgEQYkdDBW+zN8KgN6ZDl4cejzkFututSj9a30WCXPqdix
         Lf8km9lpj1kUIPenAHr+wQhTHQQvlsubwhVjeQE8rHM8zbM+ZPrYLrMwbGXBWeBzD3Nk
         WoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=OL0o9SDf4tTsguK9+lcQeIJnwnWOMWcR92PaYoaPkNA=;
        b=ULz5pUv5QUfNtCBUtHmlTQ2cQIBHffd6/+2BrcDiRAo9RNevgJmtyWwXc7L/nq+/5o
         mLnExtHIqCW97XuNwsNuPo3px898/cYDPWc0JjcUCZ/LOM+RFesUs/GYZVuYTHxZFwGn
         dwLCYtnYpkGOqECcSuAOW9v/zHyu51SANHqrF5eb3jibUlM8o1A3yDa+vTsLsvStZGCR
         wtpFwWjmbXyZPbCu/4rZhkd4Ddm/BHOTUQy/b2Cz3IUu2qieCvFe3iU2/D7m2lhK1PqF
         PgBYS7WTtHhFgUpzxRsUs4eDaUqfARmHnXc+M9/YeRyP6GA3O3mR26AXkECpnx+WG6Y+
         iw/A==
X-Gm-Message-State: AOAM533YgJ2cRpOwQIhrhGaE6tPSottxtHJqhmMD5lif22JEQvsl5Qp0
        d3dNRA3t+mjxOl4Arw8WLm8ptg==
X-Google-Smtp-Source: ABdhPJwG1GV1q+PHD94wJQTDqJ7SGobVho1lbZGNrf/K7wSVUIm0+wA0zbAggwq49j9+9a7oA5SKfg==
X-Received: by 2002:a17:902:265:b029:fa:9420:d2fd with SMTP id 92-20020a1709020265b02900fa9420d2fdmr10923138plc.39.1622937999871;
        Sat, 05 Jun 2021 17:06:39 -0700 (PDT)
Received: from [2620:15c:17:3:267:22fc:a92a:acf7] ([2620:15c:17:3:267:22fc:a92a:acf7])
        by smtp.gmail.com with ESMTPSA id d15sm4600206pfd.35.2021.06.05.17.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 17:06:38 -0700 (PDT)
Date:   Sat, 5 Jun 2021 17:06:38 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Stephen Boyd <swboyd@chromium.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 3/4] slub: Indicate slab_fix() uses printf formats
In-Reply-To: <20210601182202.3011020-4-swboyd@chromium.org>
Message-ID: <be22734-3091-3a62-a31d-89cf5a6db42a@google.com>
References: <20210601182202.3011020-1-swboyd@chromium.org> <20210601182202.3011020-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021, Stephen Boyd wrote:

> From: Joe Perches <joe@perches.com>
> 
> Ideally, slab_fix() would be marked with __printf and the format here
> would not use \n as that's emitted by the slab_fix(). Make these
> changes.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Acked-by: David Rientjes <rientjes@google.com>
