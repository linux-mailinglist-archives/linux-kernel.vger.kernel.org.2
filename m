Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931B7416639
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbhIWTz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242955AbhIWTz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:55:56 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC34CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:54:24 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id dj4so27222985edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKmFgNVdybOzZnx4iX+AR6da3akZcPfP3E2Urr+BIck=;
        b=HNQJJEy5MhdJJVqV79vO8IEuMfPm5ukO96/sXz8Vv0hlPzk/brpakD0LsWDOV7zXG7
         l3reXPbQ0roEO6DzncmkQE05eiVSBwQdQ/BPQuBhe7m1OS21PlWX8Uf5rMKdu6OsA4Fw
         wNkB6pcPetDZtFWos/x8V/yzraSpKibBafOPyqtiz0APpHX4D/cNSwbP8OCEHbttg56h
         qZgWqfGndEx0Oc6r1Bqjj9fqsuAExJN1Y21beKGumUNQk4fbAvz+5pqRHoEmWN9VVv63
         USM1Rbb8GXZVqgAkM6yL2DN4DPfmc7ZdKLSN/r8yvj1f2LOr9yxlbz0znwpl31fb5F5R
         +h6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKmFgNVdybOzZnx4iX+AR6da3akZcPfP3E2Urr+BIck=;
        b=FJD0+wHwzx+Wszaz5erhw7qlNlw+3g2YxlFS1+LLR2b+hGIvUE0iGoC72CkgXknEsk
         i8a3Rs0ZRadIrGsldbvuXpHjz6qBzdO6z+Y6nUKY1bwM6XlRnTge6SKpOQ5jrD8h7s4E
         hcb4WqtzyanQ3kyR4iFSK2mE07Hw6Dzk4lvp/Y7nO9DHoZC7n7hkFH5/kF1fFGPhLvSt
         NPKaYvNd3IWYGHQdXkRpRyQkm/C7Q0Y+CRxF32OiifIUx8FWMVzWXaPVd4sOjPbYcrlw
         TIiieBAQj07pQ4dnnLGzXAlYhzfGoZTQzsZyj9whPftoCWHinjOvJjj6Wxy6Hdxh6by5
         eKJA==
X-Gm-Message-State: AOAM531fAoy6K4+Ul/ieCO0HOXmLLcpb32SpInk3RAO4dLIq8jJLsafc
        lppnteOfXiMf3MNGjIKR+AI=
X-Google-Smtp-Source: ABdhPJzWtq4GnWY/CSMvR8joZTq24QwlFIYA3fjYSgKxNqzvLi52FxKDqAJ8yfTr9FkfAio1h4lL3Q==
X-Received: by 2002:a50:ba84:: with SMTP id x4mr698433ede.376.1632426863162;
        Thu, 23 Sep 2021 12:54:23 -0700 (PDT)
Received: from localhost.localdomain (host-212-171-30-160.pool212171.interbusiness.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id m13sm3621003ejn.3.2021.09.23.12.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:54:22 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: vt6655: Replace camel case variable name
Date:   Thu, 23 Sep 2021 21:54:12 +0200
Message-ID: <4972337.8pBPQsAWaL@localhost.localdomain>
In-Reply-To: <20210922220802.584952-1-tomm.merciai@gmail.com>
References: <20210922220802.584952-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 23, 2021 12:07:49 AM CEST Tommaso Merciai wrote:
> Work in progress: replace camel case variables
> 
> PortOffset -> port_off_set
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>  drivers/staging/vt6655/baseband.c    |   6 +-
>  drivers/staging/vt6655/card.c        |  88 ++++++++--------
>  drivers/staging/vt6655/channel.c     |  10 +-
>  drivers/staging/vt6655/device.h      |   2 +-
>  drivers/staging/vt6655/device_main.c | 144 +++++++++++++--------------
>  drivers/staging/vt6655/mac.c         |  46 ++++-----
>  drivers/staging/vt6655/power.c       |  24 ++---
>  drivers/staging/vt6655/rf.c          |  12 +--
>  drivers/staging/vt6655/rxtx.c        |  12 +--
>  9 files changed, 172 insertions(+), 172 deletions(-)

If you split "Offset" into "Off set", you convey the message that something 
is "Off the set". Probably that's not what you want to express.

Regards,

Fabio


