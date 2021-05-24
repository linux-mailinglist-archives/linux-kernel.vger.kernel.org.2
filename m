Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EC738E09A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 07:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhEXFNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 01:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhEXFNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 01:13:13 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFABC061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 22:11:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso9709571pjx.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 22:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=VYgkSO1QOilH4tihg3ZR34MzpSjXjbw2irZ5ucgu9AA=;
        b=ZVgbJJduEM91pWnTfpnigtw7jutUqce9GcKX3wqxvKRDPsIkpQ2wHBdQH5Z6ctO5Up
         fvHLZJ4HvdUoruMnZbFEE/PJYGFRNWcBkbXlZ/rzGnncVcNhADnxKXvmcl76IK9PC81D
         dMRAdCJQHBwR2QjRDgXrCX/8hNSHzEnZhNO6rodrh0umxJADLF1y6NJbk2wySco5/Pqe
         TipFieroRotKm1MOoq9WNbBvWAN6kxLd6s2o9zh6cH162SWVu/5ZQoZtzZEy0OB1G1JY
         DbcRUkcH0l0JHSWm5xmd6f+CZul9kZEZSfahYRnp7SJ/8ZCjGaVJtGXWokmDVJkRdCAv
         cVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=VYgkSO1QOilH4tihg3ZR34MzpSjXjbw2irZ5ucgu9AA=;
        b=AzJeKsyLxLV+W/asZG3kyiFEVAAZ5EIWcoqYX3fd7W/aXRK4br0ZCJ50peQVIA91Tf
         aWid35yN2yHe32Msi4rQnOXsyw8A6rRrEdPkHHffbRbg3BJAmY0L9Vo321DQoA1ZTPsX
         axFd697QBelnssXCdx3fySqb37e+e11B7PWvxR89oXTU7MxwNbbz5CTftW7am+/gKtt0
         BhkC7PG3m2oW/m4q9ZEI+QcW+Rgidf+ysaOWv27hX+socYG4obV7X3dGmqDAeJPMLvw/
         ROibqy4Unl1AhFOCHSc51RxsF5SlQG+tG8BQqXKhP+nlJXHxeMVDQvXBvjuRUYoLxwFQ
         VuIA==
X-Gm-Message-State: AOAM533Il0zdQkR6OTQN897RbxghQqsaZAn0RHSmMrOWB3AEtTAR4+9G
        E8/IwbSxI6OKOG2FV852Ip6WxQ==
X-Google-Smtp-Source: ABdhPJxJGV7WvIyJpnLRo/GiSN9/Xp3n+kmc0WQs7fq8cg5bCUZ5hMBYYzDtUAaMqnwXPvUQQ/v/+g==
X-Received: by 2002:a17:902:9f90:b029:f7:9001:a59b with SMTP id g16-20020a1709029f90b02900f79001a59bmr13647947plq.16.1621833095254;
        Sun, 23 May 2021 22:11:35 -0700 (PDT)
Received: from [2620:15c:17:3:9016:8a6d:7de4:aa23] ([2620:15c:17:3:9016:8a6d:7de4:aa23])
        by smtp.gmail.com with ESMTPSA id p65sm9749679pfb.62.2021.05.23.22.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 22:11:34 -0700 (PDT)
Date:   Sun, 23 May 2021 22:11:33 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Stephen Boyd <swboyd@chromium.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] lib/hexdump: Add a raw pointer printing format for
 slub debugging
In-Reply-To: <20210520013539.3733631-2-swboyd@chromium.org>
Message-ID: <74aa7ebb-38a9-259-1492-5ad22fe6cad4@google.com>
References: <20210520013539.3733631-1-swboyd@chromium.org> <20210520013539.3733631-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021, Stephen Boyd wrote:

> We want to get actual pointer addresses when we're looking at slub
> debugging reports. Add another prefix format specifier that says we want
> raw pointer addresses, i.e. %px, in the printk format.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Acked-by: David Rientjes <rientjes@google.com>
