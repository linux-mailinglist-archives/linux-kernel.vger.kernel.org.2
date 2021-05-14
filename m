Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2861B381265
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhENVDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:03:01 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:46635 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhENVBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:01:49 -0400
Received: by mail-il1-f180.google.com with SMTP id w7so855171ilg.13;
        Fri, 14 May 2021 14:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TeLhWehijG54mouce8ikq7VtYZj7/i4EvjKXhny3Jfo=;
        b=eDgF07Og/uBtIlYHqpy7GvWKrGo4e4BNwsZbKMQ1YXaA76hDYocd6reY/B07KsdCvX
         voTGlr44LTrZvEcUjPIu28itJ9wTyfcCeYtkoFg2DXZ/IkiK2lh6KS3x1B+jNi8WFV0C
         yo7UNL3i9r0727TlVXthzcF7jCwU0Gg2X1AACfKDHVEMAP4lU14/+viWFvyn1apY+OD0
         YLbWTfngy2fklHBc5L5hb1KTFqLw5wexT8vK0zg09kyianJHJ/EGZxjzuXZN4N9Q4qcp
         nmQeAmOMgGOrfjJgNabpiSP7g1r9X3P0S0KtjrNua+ztDp6APhvhz+LfOZluHVe0cfwx
         FVdg==
X-Gm-Message-State: AOAM531MC9K2t1aTof8KB+nGgLXNW0hWXdjqPACtepOYVbzv+q8aNdHR
        LqZ84AbJQc7LL4m6o0Knf/w=
X-Google-Smtp-Source: ABdhPJyXHLR18z9BtQ5R8acjjU7PO+hmO2IzJ2vd1o3DUpSbN0+MoCAa3c70t6m0+yZfR8ehgrRZsw==
X-Received: by 2002:a92:510:: with SMTP id q16mr28805400ile.41.1621026037202;
        Fri, 14 May 2021 14:00:37 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id s14sm3560458ilj.14.2021.05.14.14.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 14:00:36 -0700 (PDT)
Date:   Fri, 14 May 2021 21:00:35 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] percpu: make symbol 'pcpu_free_slot' static
Message-ID: <YJ7k8zWAOoDA5i3t@google.com>
References: <20210514063952.3240527-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514063952.3240527-1-weiyongjun1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, May 14, 2021 at 06:39:52AM +0000, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> mm/percpu.c:138:5: warning:
>  symbol 'pcpu_free_slot' was not declared. Should it be static?
> 
> This symbol is not used outside of percpu.c, so marks it static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  mm/percpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index a257c3efdf18..73c249f3b6a3 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -135,7 +135,7 @@ static int pcpu_unit_size __ro_after_init;
>  static int pcpu_nr_units __ro_after_init;
>  static int pcpu_atom_size __ro_after_init;
>  int pcpu_nr_slots __ro_after_init;
> -int pcpu_free_slot __ro_after_init;
> +static int pcpu_free_slot __ro_after_init;
>  int pcpu_sidelined_slot __ro_after_init;
>  int pcpu_to_depopulate_slot __ro_after_init;
>  static size_t pcpu_chunk_struct_size __ro_after_init;
> 

Ah that's my bad. I've applied this for-5.14.

Thanks,
Dennis
