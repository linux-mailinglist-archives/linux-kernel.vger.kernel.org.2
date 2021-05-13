Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3A837F793
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhEMMNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbhEMMJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:09:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30063C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:08:35 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l19so328191plk.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sVnivwLRcHTqSxs/WG/AhUa/B+NdTuMddEhJxIh+SwA=;
        b=UwxoaNjRk5TrUDc8tcbVayy4CxfDV6w7YQHC+zsc4FgjWtPKcEOaOs2skd6mmkD+bO
         DMGSpRoMwGSxUEemHLJ53X2ShnF9je/6t+pVEJsUMkutb37ZO1FnHTEOmlLRbC+NQE0X
         6M2nhZ4raBFmOE8TTQ7+rjP7aKazw7Aigen60qNfcnLJaw8FJE8wccW++Gy4HAPyV56c
         er4UJ9bV23boDQSlNnn1iZM1ncy46cqR/+YqYuPC/gC9wnU9iOtZfDOj5mR64JprS0ys
         aVNeo/tyUmqc24QqjGRVChXTmYZDc+jmqjFyONjkGxjl0uIMmCw/EUZYLk+jgBMn7h0K
         RdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sVnivwLRcHTqSxs/WG/AhUa/B+NdTuMddEhJxIh+SwA=;
        b=cVqttV1DWzEySle6HroI/WEEASU+2VWhZ6QQ//BO6mp99r+D5jVpumirLuKD29aWqW
         bT93ClamL2KptatxawPSagghvNdI1SEGH54KEWM3wSWVfasWJ3F48u9HXSAFyjjgu2KQ
         SfN3JKwFQ52J9zHqJiTJSO9wMX57jPR0xL214Fk3Koh+rpwtZgvkS6JM24BFIerPhMyH
         O+erUGUevjri3CLGm0uIQZNE5MNy90YIQ230MmJREegkKITEgvSxnbsWjbsAMxXE9U0s
         Nu+uEC7e8ckv8y1bXcQmTvccPtpRQRVx5pbcZyRacqrCyGoYO4n42lCt5B8DTyQsKoSF
         S1Lg==
X-Gm-Message-State: AOAM530X6bZ+6p6y7jaHFx8BR3ZXN72KHznJNrmc+7A4HU15cXHfcFGD
        4g4yPWWZUWa6Tbo0C9XL98g=
X-Google-Smtp-Source: ABdhPJx0neFySWzDApzUx7fLwhrl3Dr0Twva/8qryeM25HooUFoLAxklS8gvGahug+hAkYx86JBx7g==
X-Received: by 2002:a17:903:208a:b029:ef:9465:ad10 with SMTP id d10-20020a170903208ab02900ef9465ad10mr4558335plc.53.1620907714670;
        Thu, 13 May 2021 05:08:34 -0700 (PDT)
Received: from hyeyoo ([121.135.181.35])
        by smtp.gmail.com with ESMTPSA id c201sm1991044pfc.38.2021.05.13.05.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:08:34 -0700 (PDT)
Date:   Thu, 13 May 2021 21:08:29 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        42.hyeyoo@gmail.com
Subject: Re: [PATCH v3] mm, slub: change run-time assertion in
 kmalloc_index() to compile-time
Message-ID: <20210513120829.GB772931@hyeyoo>
References: <20210511173448.GA54466@hyeyoo>
 <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
 <20210513031220.GA133011@hyeyoo>
 <20210512204024.401ff3de38649d7d0f5a45e8@linux-foundation.org>
 <20210513062809.GA319973@hyeyoo>
 <a36ab9a1-f07a-42ca-bb11-5bd0c70660bb@suse.cz>
 <YJ0ACtMpasnoZdUp@elver.google.com>
 <90c1b2ae-a5c1-07d1-b056-5b3699b6cc77@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90c1b2ae-a5c1-07d1-b056-5b3699b6cc77@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 01:37:38PM +0200, Vlastimil Babka wrote:
> > See my suggestion below that builds on Andrew's size_is_constant but
> > would retain the old interface and support testing.
> 
> I can accept that, but please also modify/expand the newly added comment. Now
> it's *normally* evaluated in compile-time. And there should be warning that
> anyone calling it with size_is_constant == false should do that only in context
> where performance (and code bloat, most likely too) doesn't matter, such as unit
> test.
> 
> Thanks, Vlastimil
> 
> > Thanks,

I completely agree on what Vlastimil said. there should be comment
saying that generally you should not use kmalloc_index with
size_is_const == true.

and the caller MUST guarantee that size_is_const is correct.
if not, it would be so confusing.
