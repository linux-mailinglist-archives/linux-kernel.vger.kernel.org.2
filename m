Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6BD3F3E1D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 08:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhHVGZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 02:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhHVGZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 02:25:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B33C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 23:25:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cq23so20702577edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 23:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mx/gZXnqeR0rM9Ir+nV0y5jx3IPjC/daeOqVGnYhRrY=;
        b=c/DORD6bwzpQxHnRX/Oym75rlynRtl8ksnf3DfJu0SPXsh/Vk43beGVbmzBGThMrsh
         BJ1yOm4ct1IWXq1mveqE1uG2nwYtB04YoYb+AuPYJ2Mj/qtcznqEXjxzWQu/x9YKaSj7
         mdhlk8o9bYtKayShXaAc1G509Jep/OSpxDQbCkH4RzFaHrGJp6wTmP+3VhK067maKf8D
         Vgq0voGB8xy0K+gAqEcgH/IGxUbWCig2YvqiF2KkSNsAIAReXr6Vsj2UCoGJmfsRpbNw
         thJsRhL3U8WdDdFhtGZzDJpZQZZdLagIZFUvi8Ni6lK7e45/7okWb3QZtAVy4WoOM+SP
         IgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mx/gZXnqeR0rM9Ir+nV0y5jx3IPjC/daeOqVGnYhRrY=;
        b=BXlsDThUEZ3IA2T8+6uUIpZBx5kPz0JgK9jI2XM71/g92Z+vONaJSvSVinQIcXxWcL
         Hzds4mJH3dgo48peTySRGGpIS+Kl1f18tYJ9Y74HL6eUiNKG+kSHPiK4nEo5ZM2H6D+5
         MPVG7vk+YqoaJxLk7qM/i6r7iD63fWZl1kE1FTY5T74TcCcpt3yNdI5oJcfFo05E9Oe5
         7msUMRj3ki2DmcYY74jgtN97fRGQOlGLF1k/lRQQS8CWvOWXzB10pHZRqnDDaUH+qNeW
         RN0rfjJVuNC2EZuhY210Q/X+dals9uGDle+Zv/U1Y92knNuIiChTk8LXsSKQZZd9GPIh
         2z3w==
X-Gm-Message-State: AOAM5304o/eJGA41g6u5mSFsrlfTnCzY0TVRbdW2a0b49pJjVEE4+Wd7
        svSexRStAXxgLwwVbx54NZY=
X-Google-Smtp-Source: ABdhPJwu+SWeKv6ve36LjaS49PGof+FJMOUFdFWIjJ5rydi3ruY7H3Z6E84b1g4mV1HFZAgbzgNeag==
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr29786161eds.108.1629613508113;
        Sat, 21 Aug 2021 23:25:08 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id rv4sm5319224ejb.23.2021.08.21.23.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 23:25:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] staging: rtl8723bs: remove sdio_read_mem()
Date:   Sun, 22 Aug 2021 08:25:05 +0200
Message-ID: <2537053.yL3VPc0Jk4@localhost.localdomain>
In-Reply-To: <20210821235456.2502681-3-hello@bryanbrattlof.com>
References: <20210821235456.2502681-3-hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 22, 2021 1:55:29 AM CEST Bryan Brattlof wrote:
> The sdio_read_mem() function is unused. We can remove it.
> 
> Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
> ---
>  drivers/staging/rtl8723bs/hal/sdio_ops.c   | 11 -----------
>  drivers/staging/rtl8723bs/include/rtw_io.h |  2 --
>  2 files changed, 13 deletions(-)

This change adds a build warning, which is not allowed.

Please merge this, and the 4/6 patch into a single change, so that it
all is removed together, causing no build warnings at any point in time.

thanks,

Fabio



