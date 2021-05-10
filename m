Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D6C37907C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbhEJOUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbhEJORr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:17:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A27C061376
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:53:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o6-20020a05600c4fc6b029015ec06d5269so2554398wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KRbn9Co6BAj/ELHOTzhIdqY0Fo6rGq0pnb6CnZ+fuLw=;
        b=Co8E1ItR1mt8bRNskveWoJzDVvks2uOIGa6FImnYO90p6S1BcBIk4yghrUqBSWMGph
         Fm1Fn0AK0gXmTHwf1OMLglsSQudJ/Y3j23XThvP1f0YRgCdtUq3wODfy0e5PnAxiyQWQ
         tP8a2TVFUgrtrPjMu45cuJiwK1LhCeQpfAWl1OoJ3CSTbxp2aBSUMs0mVY1yMGW0CS54
         8NFlCi3gI4uwpUsOqcyQgpyn54ag3H5TrGy03hqGSLxmkPvmYvkv7JllY2l4d+dSHOCO
         uaPr4Me4cOh4ziwYm94jc2/J53IG7L/5jZOY/SNs2oHjEPjdnWLZZv7PtQVq5YEZPZEt
         ABpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KRbn9Co6BAj/ELHOTzhIdqY0Fo6rGq0pnb6CnZ+fuLw=;
        b=ael+XMBkaSHj9d8xinSXg4d0FLB+33ELO8mRmF8WNYY02IB4N+dyvis4D9+O/JvY0z
         xRIhTNUlelIVbUk0txXEwaab4gegdD0vG/wyuIEbWNxB2Yc3MDAMfYhgKA+Ydl8w1tZz
         Kac6xRjCW4zcLtPYT2vsGzKi50IZnGYHkBehhkr6hVNyU7nLd7Bo8BLK1lersm8VrwfB
         tL29QFOV0RA+OY9c4oRMEzhpVd5m09chhQSrDwSoWmEsk6ouXZmJAgFght3xoh2wjmcp
         ZVCn+/HtFOoLpKLvd4GuHUEt3eNu8Pn9SnyahP7DOI9W+Hi1g9eUdDJre/OiPAlpCjAK
         Ub4A==
X-Gm-Message-State: AOAM533sKG5r1zR/5FxgD2TahA2maER4FKuCc2/lt+pK7GnmFKxo8pft
        kkaAUwPnMBZ9lIiqA2wO0HkWq3ubvCRxbA==
X-Google-Smtp-Source: ABdhPJxKFSRfiuFi6EOtBi3OxWRKn8G4M/c+HNXcTzMzwJbsEJBaUftnNnJy+KMZ63v0bUD7ov3eUQ==
X-Received: by 2002:a05:600c:3388:: with SMTP id o8mr37316393wmp.101.1620654821148;
        Mon, 10 May 2021 06:53:41 -0700 (PDT)
Received: from agape.jhs ([5.171.73.3])
        by smtp.gmail.com with ESMTPSA id 3sm19797790wms.30.2021.05.10.06.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 06:53:40 -0700 (PDT)
Date:   Mon, 10 May 2021 15:53:38 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] staging: rtl8723bs: replace private CRC-32
 routines with in-kernel ones
Message-ID: <20210510135338.GC4434@agape.jhs>
References: <cover.1620652505.git.fabioaiuto83@gmail.com>
 <cdd9bc521b7119a9c2787b46109eb76f94bd295a.1620652505.git.fabioaiuto83@gmail.com>
 <29938747c82e4cf1837be5f1cdb803b7@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29938747c82e4cf1837be5f1cdb803b7@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Mon, May 10, 2021 at 01:38:49PM +0000, David Laight wrote:
> > replace private CRC-32 routines with in-kernel ones.
> 
> Have you verified that they compute the same CRC?

thank you, I forgot to write in the cover letter that
it is not tested. I don't know how could I test it without
having the hardware...
Maybe is it reliable enough writing a small standalone program
using both procedures and compare the results?

> 
> There are all sorts of subtle reasons why the outputs can differ.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

thank you,

fabio
