Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F321F371FD2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhECSmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhECSmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:42:02 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91567C061763
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 11:41:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g14so7478637edy.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I/n/q/aelXMf9mgaQMQLtrJKcudG4Wd5KNGsIllPB90=;
        b=Gg9Y3N2Fdb9DyHwiymNwYxOiruKJLzHaTEC41rI3N1IC6KvUtL++MANcceqK2VR90S
         XZs+XpbOIcz5v22bn8WiIRypSN/4WR2AK0HzNE305WZrTTU5j8h72SlE9vXSmtAgos4W
         d1lgJ/G5UT2KvsDmDf05tDhMLWJiNfLOwwwq8IwqzUs2cZkbvIqoqMYPlpMYTZ2nwUqZ
         dwjuOZKkg5JoJBhqf+ZhTpy5zGLDnGn4oc2OprEqiDZ/WaG9UAL+LzLFWcAgelJIl/fX
         83GAWF0aYfTMnQMiqgWop9O4tnuai5PmWSfhFNrC90d2llUsXl3Jxh1RPdwmOIc2MPdp
         1yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I/n/q/aelXMf9mgaQMQLtrJKcudG4Wd5KNGsIllPB90=;
        b=UzYIbVCerG7EL/LuA9fY2M0SHu7Idh8rTTvc4zzWcPIQmf083+GxcApeY8SH6SNmJn
         xloOCz0yp+UNqJGULd2S6hclcUDDLPjkXIXTCTElHC3qbPy65Q6xUP9cqccYVZxUvzxz
         H8V1m/kepP7vs1PnyfdrUMBtyK8r+tGpajm54R4dVF1jV3l8cm9a/NvfRsqTtJCOEVPO
         ePTjUFdiK3Ejv6Jut4qw3Ei7Z9xln1mM03w78QpsbxNL1SWX43MFLelr8ZmRpxXPswb4
         q2hmQd+g39lJBtTM79SAKSFiy+qfqbgTAdRAgvrDyL5Anhvzt5hUb3bba1kCm2NVZthl
         sqKg==
X-Gm-Message-State: AOAM532bQ9ekZvzgz+7YtIWRoFeCnkqhUwXFVdF2TAal33crtmjyn4AG
        NX3ZsZDj0fHgMtGMSLzVqHY=
X-Google-Smtp-Source: ABdhPJyBymSS+DOEhj25VtSpyczjlx/GZKWCAj3qYvY45dyrc3K6vl7VfIlPvi19ijH1G5MonBF3Uw==
X-Received: by 2002:a50:d782:: with SMTP id w2mr21487090edi.346.1620067267238;
        Mon, 03 May 2021 11:41:07 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id rs8sm243938ejb.17.2021.05.03.11.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 11:41:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com,
        David Kershner <david.kershner@unisys.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [Outreachy kernel] [PATCH v5] staging: unisys: visorhba: Convert module from IDR to XArray
Date:   Mon, 03 May 2021 20:41:05 +0200
Message-ID: <2381635.6tjctmx4mM@linux.local>
In-Reply-To: <YJAlWJXDnK9KLg2H@kroah.com>
References: <20210427150719.30841-1-fmdefrancesco@gmail.com> <YJAlWJXDnK9KLg2H@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, May 3, 2021 6:31:20 PM CEST Greg Kroah-Hartman wrote:
> On Tue, Apr 27, 2021 at 05:07:19PM +0200, Fabio M. De Francesco wrote:
> > Converted visorhba from IDR to XArray. The abstract data type XArray is
> > more memory-efficient, parallelisable and cache friendly. It takes
> > advantage of RCU to perform lookups without locking.
> 
> And does any of that affect the runtime of this driver?
>
Unfortunately, I cannot tell. I had cc'ed the maintainer at Unisys but no 
response at all at now.
> 
> I would need this to be tested by the maintainer before I could do
> anything, and a review from willy@ would be also appreciated as I'm
> guessing he asked you to do this?
>
I've contacted willy on #kernel-outreachy and said that you would appreciate a 
review from him. I hope he can find time to see that code.

Thanks,

Fabio
> 
> thanks,
> 
> greg k-h




