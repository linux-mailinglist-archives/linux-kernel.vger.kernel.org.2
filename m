Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998FE41354D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhIUO3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhIUO3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:29:53 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85557C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:28:24 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id d207so29799332qkg.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ML7arBHhpiOLgbzf0mlgusDukvs4IpHsLOPP9an2EcY=;
        b=8PcY0Jw2Zw2rvyeXJCUs183afxf9IsAmbA1SRcYydwror2+1VObYrZ+hbztfcDvURU
         KigJm/p06XVGB3jvk1QCg72iYnc5u6ICalT6a4RGjlimxUcTmcGTebDPIa8p+X83Xvso
         LDrclc1sc9zJCRvoNU/cWuBQM+DNzdVxHoOXU0wLOoJaEZxV9A+JSavxXB2W5JjIovVL
         9blgqt/6UTyM4pmD+s8YC9qijtwJcT7IH2DUrU41pFivUOUxSUr5b9kxpTNDnI8fDqiX
         x554fAz2kqidBaPgPKYokC+g0/oGTy/PJBxLXve9/cIH4IRhuVzAqpOtoa8si59L34E+
         kAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ML7arBHhpiOLgbzf0mlgusDukvs4IpHsLOPP9an2EcY=;
        b=Sd/KzZspRmMcTm3nFLaoGi5jFuw5mH7NXdn6I9ievLe+ROGgdgdoFkudMKaRUu+j/T
         F4V59g10Nc7vAD/oFbRNQiDAzyk9bjSpWlqFQRA2MkaghmXY+VF1hOcdfRUdTvG/R1GT
         PM6cutOZo/pKIf5Ydrn9eRUxYfXMxWQOb2NbSbLroO9EaNeP157pkvDrfHq/AkerpiAC
         gr3JDFEW7hdPi7cuN5nV9ahQKdH2BfXNnNxpY1nDd49nvBm3kgo65GrHSxDJLhYRvlpt
         Xxk+/i/VE+jMwYdpGbpYv8urFF/rkfGTxUvk4DYTb1bH++cQIoL/NVHya3vG7Q1RFsDE
         PR1g==
X-Gm-Message-State: AOAM533pPkypmdSkCDoeNyHTb4DkXEsYl58HRrdW0ICJoBAQK1DDfjCu
        I7SDpYdmQH53d+lJEEkN6bTPEEa+x/77rg==
X-Google-Smtp-Source: ABdhPJwHUrn9zZF4CVJhPqGlKDf5Cnzph8nTB6QQkqVU7xxqGfixYUonqbkrUQ5WqFyNpgnCFtNstw==
X-Received: by 2002:a05:620a:29c4:: with SMTP id s4mr27703811qkp.3.1632234501259;
        Tue, 21 Sep 2021 07:28:21 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id z186sm14056056qke.59.2021.09.21.07.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 07:28:20 -0700 (PDT)
Date:   Tue, 21 Sep 2021 10:30:21 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yongmei Xie <yongmeixie@hotmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm:vmscan remove unnecessary lru lock unlock/lock pair
Message-ID: <YUnsfagAWWPeDnsy@cmpxchg.org>
References: <TYCP286MB110836FA8100F06A50DA8362C5DF9@TYCP286MB1108.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB110836FA8100F06A50DA8362C5DF9@TYCP286MB1108.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yongmei,

On Sun, Sep 19, 2021 at 11:24:30PM +0800, Yongmei Xie wrote:
> There's code redundant in move_pages_to_lru. When there're multiple of mlocked pages
> or compound pages, the original implementation tries to unlock and then lock to handle
> some exceptional case.
> 
> Signed-off-by: Yongmei Xie <yongmeixie@hotmail.com>
> ---
>  mm/vmscan.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)

Is the lock cycling creating actual problems for you?

The locks aren't batched because we expect those situations to be
rare: mlock or truncate/munmap racing with reclaim isolation. And in
fact, you're adding an unconditional lock cycle and more branches to
the hot path to deal with it. It's more code overall.

Without data, the patch isn't very compelling. If you do have data, it
would be good to include it in the changelog.

Thanks!
