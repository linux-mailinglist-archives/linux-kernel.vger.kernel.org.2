Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B3038B25D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhETPCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 11:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhETPBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:01:52 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EA4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 08:00:30 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 76so16388422qkn.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XxKfrCNjdoHQIFo5FLrtWEdDAaISE6as6A1vrDobN2g=;
        b=YyREt896434zXvvyngjbfM8v4C5mWzOrTr6n4eQmrtoSizzjWOsh6r07Vbx4A4GsaO
         2e0NowVS/JT/AIFUAzP6us70wwTH5NWituLpfZZjRc0figD1yKto0NA60bH1BAWykS3s
         1AVk0NPkQmmSddWkbCaopyw8eeLQ2JbuoTSzLoZfC57xgjDOItvEtK0UezxRllNf/T7T
         37M0r24B0Ke+PEtZ7xZvUz632tQScWGyjtPHQQb7EaEbSa6mDP/YHiGbNNkr3Bc2z4gg
         8gRbBVe+0YKagx11NkPqphG+o/+epsyunfFSLsTv2Ev3kOMz/tiY33jer0a7BEYl3ji1
         pHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XxKfrCNjdoHQIFo5FLrtWEdDAaISE6as6A1vrDobN2g=;
        b=kWHeKYcgfhyLV3ZJqu0IJ42yNzQ+fASIOFkHcfEhhdIPKjIbgycbw8Cwk/dSJZKJHw
         b763Pt7bIDn4iZh5KVfBAZGi2ARC4wAiutiyVXxQ+Gx/ATTxleRRSZClLd0JC0uYtS9m
         oxVgapnvgvdJCKeuBqhvXhIvX+3Hd5ft+x34IlH5hl434wIveAYvfSTYq3domJstSC7J
         DPqvhLkvETMfIiGlTR1JpfsLoEI/P4aTFQuP/r1I78+T46AcFppfydtvJYc7cZrqWgEE
         IF1pEot8gOvnd38K7/CbmNf/21dpKh9As0nmmgsOkjzUmDVFBNdwWWHURrsfkEi485O+
         auaA==
X-Gm-Message-State: AOAM530h9iLax909lnUeErFWSmaAg4HBfjE1/o1pWEikbXb8Oxfp1BMA
        ppGCsTniRrVslj9nTVTQab8=
X-Google-Smtp-Source: ABdhPJyajtC6h/0qDEjxTgF/OJNEdt5+v8kC+KlCs1b/eObK/ZZ8+HV26v7g+zbBZ+8VsFnZ07uwLw==
X-Received: by 2002:ae9:e842:: with SMTP id a63mr5628227qkg.121.1621522829620;
        Thu, 20 May 2021 08:00:29 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id c23sm2152451qtq.87.2021.05.20.08.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:00:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 May 2021 11:00:27 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH] blk-throttle: fix race between submitter and throttler
 thread
Message-ID: <YKZ5i5P8fL8bgq7G@slm.duckdns.org>
References: <20210513082827.1818-1-dmtrmonakhov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513082827.1818-1-dmtrmonakhov@yandex-team.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dmitry.

This generally looks good to me. A couple nits below.

> @@ -277,6 +277,8 @@ static struct bio *__bio_chain_endio(struct bio *bio)
>  {
>  	struct bio *parent = bio->bi_private;
>  
> +	BUG_ON(!bio_flagged(parent, BIO_CHAIN));

Let's do WARN_ON_ONCE().

> @@ -2270,6 +2285,8 @@ bool blk_throtl_bio(struct bio *bio)
>  
>  	td->nr_queued[rw]++;
>  	throtl_add_bio_tg(bio, qn, tg);

Can you add some comment here explaining how now that the bio is added for
throttling, there are two accessors of it and the bio must not be modified
without holding the lock?

Thank you.

-- 
tejun
