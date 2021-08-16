Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E233ED1C6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbhHPKQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhHPKQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:16:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22169C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 03:16:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cq23so8237209edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVW6kIMO+vANMX1HgjohnPiDWRD88704SfiqfsvGvrY=;
        b=DKz7kaaWh76EEz1NKm98fpj3E8kOJxDG5IeUBcDQLsm2STIJvj735JLGQS2y3G/e0V
         rEAcZt9v/mcJJi0DVLXvYQmpWrSBl/OqG6/nj1yG66Wfjtz1yjMa5iPlfFH1zRfdZYFm
         p7PekcV43teXYUHSNw+mp2j1bMbSV2ppHYzycFloWd145F95/J8ic3mDq0Ct3J9E9/vE
         CB914QCPyZYZG5JKPxcYvUTAcpCQHNjWIGZtbbRJASUlmX8ULCvy/Y6RwCroAPTbFAd2
         3rEpc8f7gIg1i5i77RSWR3L/OcvZc9XM1NV75/mIyc+T0jUeIix5AfmGqduMFD7Hjgiw
         VVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVW6kIMO+vANMX1HgjohnPiDWRD88704SfiqfsvGvrY=;
        b=aH8i0/fAzPhO1p+pFTfBALrUSf2mVNuNruNI9yOkR3LqS/I5Y/JxRKE3kLWSWKQGpT
         Hit4E/QCWvFQ69ZoenmAgc4SW655TR3FBnlejPJtih9ixTaucZg73qGd5IlKdYXJPpbc
         gBON5JDZacW+iJxdXl7M9vb4BiipVU/FiKTde3S/zYzd0XMS/OSyyUGRpj4tZ8hBLApZ
         NxMiHhpbSV+PfmmcKhuQdqquPQ7RuJ4NKv3QKcjshA9jI2l+JUFf1D7N/U9/eke0MCrl
         uEXriueeJ4kdR+tgvkz8P/wBQh8PXR2jAZTfFkrptzI8G4Z8zloXC+b/WiAP4KnCkhGZ
         oxfQ==
X-Gm-Message-State: AOAM532oceIkSh824DiNc2icJm1gZdOi4dHakPb/sai2uYIsBi+Ljq5q
        wK4zTSrGiDiDwVhjDD607Bk=
X-Google-Smtp-Source: ABdhPJwfnPxjfAlAZQiaFxupJ1zR+gDxTOptzvKSjgISupqccAu/LHyFh0HidZe5RxxVkcfKu3CCGA==
X-Received: by 2002:a05:6402:3485:: with SMTP id v5mr2683605edc.205.1629108958744;
        Mon, 16 Aug 2021 03:15:58 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id be23sm4602202edb.68.2021.08.16.03.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 03:15:58 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Remove unnecessary ret variable in rtw_drv_init()
Date:   Mon, 16 Aug 2021 12:15:56 +0200
Message-ID: <2121129.EM0CHCvl88@localhost.localdomain>
In-Reply-To: <20210816090500.GG1931@kadam>
References: <20210813201418.4018631-1-nathan@kernel.org> <20210816090500.GG1931@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 16, 2021 11:05:00 AM CEST Dan Carpenter wrote:
> To be honest, I prefered the original.
> 
> 	foo = alloc();
> 	if (!foo) {
> 		ret = -EWHATEVER;
> 		goto free_last_thing;
> 	}
> 
> I like this style of error handling because all the information is
> there.  You don't need to scroll down.
> 
Thinking deeper about this style of error handling, I find that Dan is quite 
right in preferring readability over removal of (technically unnecessary) 
temporary variables. Perhaps the trade-off between brevity and readability 
should (in general) favor the latter. 

Furthermore, those temporary variables make the code easily adaptable/
extensible in cases where, in future revisions of the code, there will be more 
different errors to handle.

However, it's mainly a matter of style, so...
>
> I don't really care about this specific patch at all.  It's a small
> thing.  But we had someone come through who was sort of obsessed with
> removing these sorts of variables.  Just because you can remove a
> variable doesn't necessarily make the code more readable.
> 
> If you're doing the work and maintaining the driver you get to choose
> your own style to some extent.
>
I agree: choose your own style (to some extent).

Thanks,

Fabio
>
> But I don't want to encourage people to
> start sending these sort of patches more generally.
> 
> regards,
> dan carpenter




