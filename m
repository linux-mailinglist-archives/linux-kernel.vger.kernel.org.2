Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6207D3F7426
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbhHYLMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbhHYLMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:12:35 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4856BC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:11:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r19so36317488eds.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drTM0WfZLehebID8ZvXHYymXTQAeWPGMCig2l0ICemA=;
        b=a8Wr/lZ79NHuj3dA7FHdltJZF+rpS+aL4IoHN+k3ICoK5ZnIuoFL+WOty0TyEXSHWh
         UPPPJ7nYVS4Kvpzh8T4Phhy0yC1zhuem92ffi1ETpGu+XL9rkYGGJ1SQ3ildBnx8WoZY
         vP4k3RKO4Wif7INJQgSyI+TychQ65m4eOz7gV+2jgpTJpXQbUPGzrpGpTdK2LV9UQ6fa
         SWnV21UuIE2+Z+jVP9Y6dX3lNnTueqkSXA1VT0MrrhCYd5xMIt/5EvddIhbfKRIF1bqc
         WdagNlB9WRnea23SqkmXK6U0sq8+Czf/22sVaY+6ou9Z05KaqZpXHYN0/a7xtbEJv4/h
         EsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drTM0WfZLehebID8ZvXHYymXTQAeWPGMCig2l0ICemA=;
        b=Wnna4TvaMR+kjSNBQfDzEc4ZcpdOCGRXL3r2LwrghOudB08f/A25dwHEJEQlPyxa3g
         OnCbrFv5p7MOmlF85ZlAYO/CU5hoel20DWZkZQw+Jl0BYwe5Oe7n4uxuvN/SKEPmMOZz
         c176ZMrhtboLYnQvMXM5P0vSBifRxIJcQNsbDXJHrR7ycpmNhFiwj/XljaOVnn0F8mI1
         nEIT4J6Lo/KoHbOUIWfjMFkUjDdv5HgdLv6YkFePxyLfIGvdk29E8vVlM43w+5Fkbj4j
         /7HuHWHbDrj3LvIwy5Icbbir9OVHUbb13bfh/fpKX6wddu0/Vax8qnUU3Jh+l6UIQdfl
         WICQ==
X-Gm-Message-State: AOAM532LyFv539VWCmklsnID2nJi7dyEsB1vsqn9QdKMr+aMzN/4kEgM
        mUwzgzW98ZhURJvgXoAcNas=
X-Google-Smtp-Source: ABdhPJz+ZP8qmqPd1rI+TIpI1Nnyzsf5AAkvTpuifTdBOvrpR5F8zH9OEfJV6cRM6ERapuz29lpK7Q==
X-Received: by 2002:aa7:dd12:: with SMTP id i18mr6700248edv.368.1629889908967;
        Wed, 25 Aug 2021 04:11:48 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id b5sm10897790ejq.56.2021.08.25.04.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 04:11:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] staging: r8188eu: add error handling of rtw_read16
Date:   Wed, 25 Aug 2021 13:11:47 +0200
Message-ID: <1656520.BsXvRA5gNX@localhost.localdomain>
In-Reply-To: <3494498.825kMHXWDN@localhost.localdomain>
References: <cover.1629789580.git.paskripkin@gmail.com> <20210825103802.GS7722@kadam> <3494498.825kMHXWDN@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 25, 2021 1:06:40 PM CEST Fabio M. De Francesco wrote:
> On Wednesday, August 25, 2021 12:38:02 PM CEST Dan Carpenter wrote:

> > That's a bug then.  The patch should be rejected.  You're not allowed to
> > break the code.
> 
> Sorry Dan, I disagree. It's not a bug. No one intend to break the code. 
> How could anyone know that someone else is working simultaneously on 
> some code that is not compatible with the work of the other developer?
> 
> Pavel and I worked simultaneously on code based on the current Greg's tree.
> 
> We incidentally got to know that mine breaks his.
> 
> I suppose that Greg will take Pavel's work first, because it was submitted few 
> hours before mine and then will ask me to take into account Pavel's patches, 
> rebase, fix and resend mine.
> 
> Each series is self contained and does not introduce bugs to the current tree.
> The bugs will arise when Greg will have applied one of the two series as usually 
> in a FIFO order.
> 
> There's no practical means to know who is working to what just by reading all 
> the messages of the lists. Who reads all the messages before deciding to work 
> on something? This issue will be solved a way or the other, I really don't think it 
> is a big problem, it's unavoidable when a lot of people work on the same 
> driver or subsystem.
> 
> Regards,
> 
> Fabio  

For sake of completeness I want to say that when Pavel had only submitted RFC v2
my code didn't break his. It was only with his v3 that the bug went out. But v3 was 
submitted just few hours before mine.

Fabio


