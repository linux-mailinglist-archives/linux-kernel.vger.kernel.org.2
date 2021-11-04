Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370A5445788
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhKDQxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbhKDQw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:52:59 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE98C061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 09:50:20 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x10so4262780qta.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TkFrygNOhC+S0dvhMl10NP4GzK5uobTcnOTyzmKcV+g=;
        b=tlMy1mumNDk211O1th1j1VnnbL8fLRgoALOwYrZ3o+qUFCsUleImemQWI1juX3pIdx
         Sd25wh5Op7RXzrcodT8i+3jwIhaMuO4QZ2MHYS7tIc3PhLBJJzXoWokHE2wKzHlC6rGY
         Yk8hsBlAbAiGFxhD/DJCOBxiJqgSCWOdE+oU62dO558m0AoA1FVQoZis99F9dm+VZEag
         RN81aHpxYzG1pbSMfLmwXoM5iVlTwmgDayncSrSHNKyW6tP8WxedB8724+uAqhYSHIOS
         zYEUCgZUrTVIhMdREEB5dSyOYIunJzfP/PF8dU+aaikKitdf5JxvmcLgpecYfbwqefNG
         MS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TkFrygNOhC+S0dvhMl10NP4GzK5uobTcnOTyzmKcV+g=;
        b=OM0nmoxrevUlT0IW46IsBZ9TpsW1872E8ezKR7b6z6Eo50DedLHR1JWOaugOwvIhrq
         yGbOCrlmhJzNbojF7C+kHVq1x3aV267InQZSeNw0AzAVpJpbr7Qv/964ITBXfU/bvrlF
         j8BANXqMvjBO/Z14scGa3OnpWP2Ervzmoz6eER1EkiG1u+bbQXIKTG/4oW/8VgS5eHd1
         9HbzGcVf66tf79kiRc/dsu7E8WtP0QwmW2WD+l3ss65phjakkHTR8wTwQSA08tWVqCgs
         grEpFcfYt134j9iZexhF6fvw7G3JOKcU722EDCo3RdB54+5iX3eGMW6aMkyRi7vxklOZ
         n2dw==
X-Gm-Message-State: AOAM532I113T8F7tw2McB39cz5fyCAhIRR5Vlc3uynJdihU37cXIcxzA
        lAQnT8Z2EAfP/peyyRtXOcPFBA==
X-Google-Smtp-Source: ABdhPJxgH2d73ZN9tYkgVIUZDqOMli13iAi56KQ3WrMjUt1XMWIq5vyGahsnSzbo5Xzy4RTxbSGgiw==
X-Received: by 2002:ac8:5cc5:: with SMTP id s5mr56481579qta.347.1636044620129;
        Thu, 04 Nov 2021 09:50:20 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id q13sm4129010qtx.80.2021.11.04.09.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:50:19 -0700 (PDT)
Date:   Thu, 4 Nov 2021 12:50:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, zhouchengming@bytedance.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] psi: Add a missing SPDX license header
Message-ID: <YYQPSiUoxwvpmwUH@cmpxchg.org>
References: <1635133586-84611-1-git-send-email-liuxp11@chinatelecom.cn>
 <1635133586-84611-2-git-send-email-liuxp11@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635133586-84611-2-git-send-email-liuxp11@chinatelecom.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 11:46:26AM +0800, Liu Xinpeng wrote:
> Add the missing SPDX license header to
> include/linux/psi.h
> include/linux/psi_types.h
> kernel/sched/psi.c
> 
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> ---
>  include/linux/psi.h       | 1 +
>  include/linux/psi_types.h | 1 +
>  kernel/sched/psi.c        | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/include/linux/psi.h b/include/linux/psi.h
> index 65eb147..a70ca83 100644
> --- a/include/linux/psi.h
> +++ b/include/linux/psi.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef _LINUX_PSI_H
>  #define _LINUX_PSI_H
>  
> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index 0a23300..bf50068 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef _LINUX_PSI_TYPES_H
>  #define _LINUX_PSI_TYPES_H
>  
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 526af84..3397fa0 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Pressure stall information for CPU, memory and IO
>   *
> -- 
> 1.8.3.1
