Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C913F7C01
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 20:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhHYSFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 14:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhHYSF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 14:05:29 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01134C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 11:04:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i28so796003lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 11:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9wrLUVOsTqglV2Xzx4erL5Og3Y1IS5KOd0x84apt/WE=;
        b=k3mApXxLneXt/o1Z4H2Gv2Tu808fcXf4gz96j9KDvDbqAiwSFX6cxJzxNlhErtFz9f
         2py309ewVYe/DQi+nTV4h2d2MX+S59XastHYweQxuzG5jkANV7HBlg/7hWrMUjcYMIlA
         FP8u72S1t5648NphnrxPlY+BHTLLf0IKLX5uaWLJDgUZ1OL3YIvGj8gW69C28+39lHQT
         Rl+SjuCyCi0AcmaOls5g1MVvk6YJYeJaGxRx4EClM4c/OU5z+ozIpmka3u8+Q9Z1vRfO
         MOyZ7OUnc8C247aX2mbXC6htSfFImtGU9d72bBBE69wzYbVjUZAWbbmIxu+bUMtS6IOg
         V7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9wrLUVOsTqglV2Xzx4erL5Og3Y1IS5KOd0x84apt/WE=;
        b=kQj4pWoFk6QWqt4bHmTCc2MUIJEfo3Aoa2OvqnLlKd6NrGejejqCjBov8HyYkUHKFQ
         BRRCItJkD8LP7EzYlbElsO/GHvEbk47oSYNJ6lrY9odnqgeox4gJva+ILOKik/bvx6D7
         vhbTuKQ0B+tdivpxnfwq2J6zkBXhU6dPcT3714rUHLuST9YbpIakWVviG/nlW3Q9TiDO
         iho3btwR8HG8Mzmqy6HW/4+fUXMFMHAk/5+OKGg+h/wpMmtJjpkK1nR7yuHJVTGwyjt2
         FBanWOFoIF+qUWv3RrDWop4ePA8cEgnojlSPE/e4Xngh0He4qWt8QGQ693/MFuBghPu6
         xrBw==
X-Gm-Message-State: AOAM530JOHs3RwQ1NSDvWSHB3z+dASWOIYcR7fnPOuSyKA7pdfJj9mMZ
        pHFtmSQ3lM0lko7rIVp0zGo=
X-Google-Smtp-Source: ABdhPJxqBMSmPh5+PnIFzk8Oa0lxdZwudEQWpWnL+IlGEQJXuoTrL52iH6ntMsgoQkw6+T4mxQD/ew==
X-Received: by 2002:a05:6512:ac7:: with SMTP id n7mr34446858lfu.479.1629914681355;
        Wed, 25 Aug 2021 11:04:41 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id z13sm75946ljo.37.2021.08.25.11.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 11:04:40 -0700 (PDT)
Date:   Wed, 25 Aug 2021 21:04:39 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: Use kernel ALIGN macros over driver specific
Message-ID: <20210825180439.ctyxdhykrqtl55rj@kari-VirtualBox>
References: <20210824182059.1007387-1-kari.argillander@gmail.com>
 <20210825043715.GP7722@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825043715.GP7722@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 07:37:15AM +0300, Dan Carpenter wrote:
> On Tue, Aug 24, 2021 at 09:20:59PM +0300, Kari Argillander wrote:
> > Prefer built in ALIGN macros over special made ones. This can be
> > helpful for some static analyzing tools.
> > 
> 
> The patch is fine but the commit message is not clear that this fixes
> a runtime bug.

Is below better? Will send V2 if this is ok to you.


fs/ntfs3: Use kernel ALIGN macros over driver specific

The static checkers (Smatch) were complaining because QuadAlign() was
buggy.  If you try to align something higher than UINT_MAX it got
truncated to a u32.

Smatch warning was:
	fs/ntfs3/attrib.c:383 attr_set_size_res()
	warn: was expecting a 64 bit value instead of '~7'

So that this will not happen again we will change all these macros to
kernel made ones. This can also help some other static analyzing tools
to give us better warnings.

Patch was generated with Coccinelle script and after that some style
issue was hand fixed.

<insert coccinelle script >

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kari Argillander <kari.argillander@gmail.com>


> 
> The static checkers (Smatch) were complaining because QuadAlign() was
> buggy.  If you try to align something higher than UINT_MAX it got
> truncated to a u32.
> 
> regards,
> dan carpenter
