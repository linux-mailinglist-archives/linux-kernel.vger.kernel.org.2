Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE93A38B4E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhETRIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhETRIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:08:41 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10922C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:07:20 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g8so5792292qtp.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=osvvf+q8LQse5/3VhNbzmRp9V7XQZTF1W41c/FjQvXk=;
        b=geA8+r9rTUCGAXeg3BZRgUWP0D3y8t64juZ3veGY88v9oJz0oDWREr59tHIcG3GkYh
         57q3nRdpD/9sogxj7y+DWRfJZAqx7z+T19o5UalMgxfphAv6mB4uMOIfZpjecxA6DamK
         JVDA4iexfVgYG4V4GM1/j1RkfY8cBsvws7Cnm+qpr7wxQR0W3y4Skf/M/MkN3VGNBeJB
         xZGcxnSDajVwl64jLgJSehvoRGt/gqrColferxFG0ITodjFU5eYyz+ZaehhtcWGxCYsu
         KZP0V9AorsY91fGzUULw/qlu6EU8V/2zCz+n3xcEnaRhe7tAqNueKfZWzy13/V3dCw6u
         4cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=osvvf+q8LQse5/3VhNbzmRp9V7XQZTF1W41c/FjQvXk=;
        b=IxaxJXilhiPc+FTvhhwnwJQdtHL7cWRnkxWrKpM7LQXOs/LCNKLElysPbFx2H0+0sG
         0GmAecGmSoqtWR23SHEOBVgE85JWdiAsevw42yYlSsUc0Ccb3rTT+n5Bs4GRnIfq3RrQ
         w+DhZl7AWfvwTy5iQWGP79KSQaTiJV2TlR7v1HBGOvajOGSfcr/nUIs3fSpr1CWJEDZR
         uvVUHAKV/bhktyJX5g6oiVRPKppTAESTZm7CIoGC+EHKyJR9oybEKrHDR141bsrtcDjr
         Vx/v99i0sFVmfjkV5hbN4v+SYc7hhUtlWDgjobE22mHLDx+nOlH1dCshXpsUwn7oZwws
         Kynw==
X-Gm-Message-State: AOAM532Di8rjXKtDphHm+GijeHivhEOvqpGb6AIazQKD8PvPwVpIhRV6
        atPrqQAq76KkYOj2QaacuSY=
X-Google-Smtp-Source: ABdhPJxnHwlSxmlwYjun2x8z2O7hvVNaDmKru46nG535/XexVx/vRyyV//ePCLmCpYfWlnzjKfrl7w==
X-Received: by 2002:a05:622a:1cd:: with SMTP id t13mr5985792qtw.243.1621530439204;
        Thu, 20 May 2021 10:07:19 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id r10sm2625527qke.9.2021.05.20.10.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 10:07:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 May 2021 13:07:17 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH] blk-throttle: fix race between submitter and throttler
 thread
Message-ID: <YKaXRaJJOeOgMaGq@slm.duckdns.org>
References: <20210513082827.1818-1-dmtrmonakhov@yandex-team.ru>
 <YKZ5i5P8fL8bgq7G@slm.duckdns.org>
 <1394051621530051@iva4-92c901fae84c.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1394051621530051@iva4-92c901fae84c.qloud-c.yandex.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dmitry.

On Thu, May 20, 2021 at 08:00:51PM +0300, Dmitry Monakhov wrote:
> >> + BUG_ON(!bio_flagged(parent, BIO_CHAIN));
> > 
> > Let's do WARN_ON_ONCE().
> If we hit this point when this mean that  ->bio_end_io  will be called for parent bio.
> Which likely result in use-after-free for that bio and silent data corruption for bio's pages
> So IMHO BUG_ON is more appropriate here. What do you think?

I see. That makes sense. Can you add a comment explaining the above?

Thanks.

-- 
tejun
