Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0731C3629EA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344032AbhDPVGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:06:53 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:38789 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343949AbhDPVGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:06:50 -0400
Received: by mail-io1-f54.google.com with SMTP id f15so20247754iob.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ZMwtUn8ISxVk4yLYfxm/bAfidINBvOsGVHhs0Qq4G4=;
        b=rr37XeGkll51WtvfEznwSZ/4rrSYHXkUoHuRv5vuas+eKZaEdPqECtp8XTAjmCwGod
         1HQrL7FLOxj6Jc8po8AgIJeTMIpftJjWSOYShox7i7teZXJzdhGfGSKFAsNWUNo4fu1R
         SfaIVt/oM9TPt8+14Y5vtKT3hF2gp7Ci/3FEtevw0RKcqvyOWNt3EQyjGJ47w2SwFypi
         +oYxvJBni6GEX9PHybUQ6vs5yVp3HW4yzhdS3tktMTUq0vnGcxIHlNn3TGG08TUJbCVp
         2/tQahiSeEuM8uG8K4nj1Yc750F3YJJS81ovsialWTzzx0WqVu7fDsugQTl2MDsGfCl0
         QCBA==
X-Gm-Message-State: AOAM533bUgpQw80OCC2lH2VkhxslGizZNbynzxlNEiMLdPoaMRJpwPRp
        1kkFM+eFH/YQnlyi6UNys1o=
X-Google-Smtp-Source: ABdhPJxYex6qOxFyO/qzC5ltnygdMTBP3vj/7tbKjNNhIBxEOsbAfT5tqbnp16oAPV+26pilMQoU6w==
X-Received: by 2002:a5e:8e41:: with SMTP id r1mr5109605ioo.5.1618607184534;
        Fri, 16 Apr 2021 14:06:24 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id e13sm3082335ioe.0.2021.04.16.14.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:06:24 -0700 (PDT)
Date:   Fri, 16 Apr 2021 21:06:22 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] percpu: fix a comment about the chunks ordering
Message-ID: <YHn8Ti01dAFnZPOd@google.com>
References: <20210408035736.883861-1-guro@fb.com>
 <20210408035736.883861-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408035736.883861-2-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Apr 07, 2021 at 08:57:31PM -0700, Roman Gushchin wrote:
> Since the commit 3e54097beb22 ("percpu: manage chunks based on
> contig_bits instead of free_bytes") chunks are sorted based on the
> size of the biggest continuous free area instead of the total number
> of free bytes. Update the corresponding comment to reflect this.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/percpu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 6596a0a4286e..2f27123bb489 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -99,7 +99,10 @@
>  
>  #include "percpu-internal.h"
>  
> -/* the slots are sorted by free bytes left, 1-31 bytes share the same slot */
> +/*
> + * The slots are sorted by the size of the biggest continuous free area.
> + * 1-31 bytes share the same slot.
> + */
>  #define PCPU_SLOT_BASE_SHIFT		5
>  /* chunks in slots below this are subject to being sidelined on failed alloc */
>  #define PCPU_SLOT_FAIL_THRESHOLD	3
> -- 
> 2.30.2
> 

I've applied this to for-5.14.

Thanks,
Dennis
