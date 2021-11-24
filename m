Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9A745CF30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 22:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351709AbhKXVk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 16:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345236AbhKXVkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 16:40:20 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B38C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 13:37:09 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id a11so5187089qkh.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 13:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PDpAUClRISPaqjyDiS/RNBX5RTYaG7TkRPK4Gm1mZss=;
        b=QQKmwN1f0b9ElZBMcGD2e9/nw9t7oiH/45g3kCuEtZBepxzZJSaw19OVhZPnTERfRy
         /5/53O7yHTWTGZQZ+5vtN+ZWtVwWdqewSt9wTHT2SfYgUJk6PPllXk/ewdIXQbux3S2B
         hZtOu2GppXGlkqPJ2RimaihvTaY5/R+x/SptktA2MgEtAm6DUIeE1S60XIIZ9zhboisN
         DYKalBnpKt52CUxfiLXXt1ukvSCUuQ9LsrWqVujGljLIvW8GRNYC2Lr3BDEVehAMey17
         dTOmyJ8GELC5DhOO8bwy7A92mvbiHMGhwjZg6J+O0a3T6YLWY6Y44NC9ZiDEvWqrax+E
         LKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PDpAUClRISPaqjyDiS/RNBX5RTYaG7TkRPK4Gm1mZss=;
        b=XfpHkP5xfcJRrBziKieDBjuXG0Aoeg0iF9ej//d7yALUi6noyIt81VeSVn2qpsDCUR
         0AOMuFvWNymAGeyNtLis2e7iHXO0bOHWHXUGCYzEJkiM1Tzomnq2TPOuROH6HDIhMPTF
         vPFhxsxTfRDHkf35dDttKDpJUU8SdrcA6gYLybycKgbziVC4DyaVu1QgcHZ1lawMRZdd
         XyC8xEMzQHD8+nT1kpU+nj+UJ5P/MA3iTU2/Swl7FOhJkvpxoLxSMybsTzGEwGZWkgm9
         pzJfSLjVKj0kjMPwKrDzpWMoJLpakK8BZbYvZSFYa3pUoQuGqsLJJWpht7L9vwVxnED5
         YQcQ==
X-Gm-Message-State: AOAM533dxjNh/k1/MVUtzIaRw5WZsWbt1OnR4mGJa7miXLMx2mHxarjf
        2zKDyBt2os//ilUhhfZECjPQFg==
X-Google-Smtp-Source: ABdhPJyqU1t6Y63xsf9kE/jd2e91PtTUftZ8PGSVRmaOXDKXaYwtE70W7SZPZu2R6gq+UJWAJpbz6w==
X-Received: by 2002:a37:8945:: with SMTP id l66mr1620277qkd.776.1637789828853;
        Wed, 24 Nov 2021 13:37:08 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id e20sm544451qty.14.2021.11.24.13.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 13:37:08 -0800 (PST)
Date:   Wed, 24 Nov 2021 16:37:07 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        dave.hansen@linux.intel.com, vbabka@suse.cz,
        mgorman@techsingularity.net, corbet@lwn.net, yi.zhang@huawei.com,
        xi.fengfei@h3c.com, rppt@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/1] sysctl: change watermark_scale_factor max limit to
 30%
Message-ID: <YZ6wg9A5p5WUy7+k@cmpxchg.org>
References: <20211124193604.2758863-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124193604.2758863-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 11:36:04AM -0800, Suren Baghdasaryan wrote:
> For embedded systems with low total memory, having to run applications
> with relatively large memory requirements, 10% max limitation for
> watermark_scale_factor poses an issue of triggering direct reclaim
> every time such application is started. This results in slow application
> startup times and bad end-user experience.
> By increasing watermark_scale_factor max limit we allow vendors more
> flexibility to choose the right level of kswapd aggressiveness for
> their device and workload requirements.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

No objection from me as this limit was always totally arbitrary. But I
have to say I'm a bit surprised: The current maximum setting will wake
kswapd when free memory drops below 10% and have it reclaim until
20%. This seems like quite a lot? Are there applications that really
want kswapd to wake at 30% and target 60% of memory free?
