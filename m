Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2502D438AA4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 18:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhJXQ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 12:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJXQ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 12:29:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B42C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 09:27:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id u13so8149718edy.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H299UAlRGy5AL6y5+sDSOlxsW1n+KrGZrT/E7k60mw8=;
        b=b1uMKuexLkwut/IeKNYWkAZ78YykWQdo0Mi5j4xoWu+TOwqVfECJVsW4aMwb14PNQg
         UHXybubtZRmLGEb5gxpx3a4sLl32Q5GI4McUqvnEdYLx4/TxBX7fiLKEYdh729OSwyz7
         U5fo8UE7ylu/98ihGy6bBsaCpaSWUDEeV64mNcvIgWVa49e/zTmO7DLiW499PFlnW0E0
         HJ1w/1JGQyh6d705plwYzGBRoB6RBSm8dPz6TATOAS8DdWrZ0n4MLQNQd3EG5qTzMnpJ
         ufPhW0ec89VBWIQGjE21uXHbrMk17kQlTzMHwYX6BGJ+1S2Wp2JsebN5YxbkZplDoEBM
         2K+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H299UAlRGy5AL6y5+sDSOlxsW1n+KrGZrT/E7k60mw8=;
        b=B0zGGWAEZGAeX5VcuZOSYdCkVKoci0Ur35giWiDhP0cqpCbOjQ5T6mHKrNE7wuETDL
         J4ZbknnqX/k5tdPAHHaBmi5D6sZgzC9DEUmnIygB8s+8HvjMe57U3hMFQIaJaYl8vsFK
         Rw1cj1yYkeO4JqTz4LaIXnW3r2KxXlPWvHtw8RFmrqYpK82/sP9miDFffhb68gQWnpNw
         mjxfqmy9HKz32OejP3TumqAl/cUnLzlzlGnip4r0U7iukxrQFIVBc9nf9s7CHHNVYikf
         4HI++C1Ro6cx1h5UQ8rxLOkk892jtuB8hU+RlSmJX+70TYSrOkWKM3vihLoJe0Mj6YE/
         +QRQ==
X-Gm-Message-State: AOAM530heKnHk3TarNuBoEIn/oirRCSFYzdvHR8GrdHvzoPggzFYJetJ
        JlR6GzeNlhrck72rRPfMqeEvXHp5r7U=
X-Google-Smtp-Source: ABdhPJwnfkKlgveo+wCKf2g9qjticT6q79beBtK4asleaxTw/MJguybOiHnFCIhFnMTUhIKHyc8sLA==
X-Received: by 2002:aa7:d34f:: with SMTP id m15mr18999490edr.40.1635092834166;
        Sun, 24 Oct 2021 09:27:14 -0700 (PDT)
Received: from localhost.localdomain (host-80-181-148-119.pool80181.interbusiness.it. [80.181.148.119])
        by smtp.gmail.com with ESMTPSA id h18sm6268333ejt.29.2021.10.24.09.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 09:27:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Remove four unused semaphores
Date:   Sun, 24 Oct 2021 18:27:11 +0200
Message-ID: <2067076.ETZ9WjcDCG@localhost.localdomain>
In-Reply-To: <YXVR06W46mx0EaZU@kroah.com>
References: <20211022113936.7909-1-fmdefrancesco@gmail.com> <YXVR06W46mx0EaZU@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, October 24, 2021 2:30:11 PM CEST Greg Kroah-Hartman wrote:
> On Fri, Oct 22, 2021 at 01:39:36PM +0200, Fabio M. De Francesco wrote:
> > Remove four initialized but unused semaphores.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> What semaphores were removed?  Please be specific.
> 
> And can this be broken up into "one removal per patch?"
> 
> thanks,
> 
> greg k-h
> 
Hi Greg,

With all due respect (I mean it), I must say that I'm not going to split this 
trivial work into four patches of two lines each.

I understand that here you have the last word. After all, yours the tree, 
yours the rules. 

However, I'm used to do only what I can understand. After noticing that you 
can take in one shot the removal of 7000 unnecessary lines (e.g., please see 
commit 7bdedfef085b), I really cannot understand why you cannot take also the 
removal of four initialised but unused variables in one only go.

I'm really sorry but, if you cannot reconsider your decision, please drop 
this patch. I'm pretty sure that someone else is willing to do what you 
required, but not me.

Best regards,

Fabio


