Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9561A31223E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 08:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBGHjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 02:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGHjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 02:39:12 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A31DC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 23:38:32 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id my11so8131892pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 23:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LBlVJrHdtvYtBj0sfMBU5d9IOU/AmL+1AaFBRumib+4=;
        b=dziuLnsnUcY5nc1k0Ua43YystHR+I6epVRuiP2nfkSblKYJMYrph9iB+j6wdCL7gBH
         J7cHl9nwD+Xj93i1BUwS1DE+A4L39BVIlPSvwcf/FK79tWOk0zcUdLPf+XZ1kG9dLXcP
         OliSEQga8Io3rUiAJGB7OdGBekzbWpk2NDRtr+PHn9MDxWRjIa8ixSpW2vcz37wP0s3H
         fgOUVnpOVsmm24lzOmOIoJ0t9/YLpKSBijyK6muCKSqmzx9+Hol+lqjHSbW4AdD9YkkT
         I5tqD0BiCfFiSMi2ZRjNaxFuAzborY18ZZImuhu+0MCqbN/r0mANYPAj3aJhfLKxT+eG
         K3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LBlVJrHdtvYtBj0sfMBU5d9IOU/AmL+1AaFBRumib+4=;
        b=gIxENrEOwoeLzy7wC1E/bNksgkjvKJS9KNQhPnn3baBKXUDOqQP5JGjsf+sx/D/3Jj
         LOd+3uigr8LaG757emQ0eiM1Hg0kuFg9RHxmx6rKb7sQTYAeKrocRiPfPatN6c/KPYkU
         QxsgXvUym+A4TDFOcIHh/mR8MMLg77gWs/t4YWi8uhCox+IWcSjiUSlH+vulQvY8lQfk
         sItP485NaPwYso/vUMVGKYXqoeJD74BzM/cFhY9dH6WlI1qv6Q2qfpu35i/XM6CtEJj8
         5bBqTel7+dqsi1DRq1MHcWYgZrsoOMXOhk6pvyKgBXWB8NHDSi79s26Msw7jFCkO/ECj
         oYPA==
X-Gm-Message-State: AOAM533NrHdA2wopWnCHCzJEPrMnxk+HRWFu6phzqLmvvWtkryvgidXE
        NGPvT+XhrjBXvoOCmxLwZOCZjQcQxtk=
X-Google-Smtp-Source: ABdhPJyTikUVV/KubRr3cD37P9PrHPOYYv0KNqBdfGVNJKkfl3yZ8vKeJyaHK2Q2L1BSYtMe+q3c6Q==
X-Received: by 2002:a17:90a:4a94:: with SMTP id f20mr11520527pjh.97.1612683511646;
        Sat, 06 Feb 2021 23:38:31 -0800 (PST)
Received: from localhost ([2402:3a80:11d2:b946:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id e15sm9213835pgr.81.2021.02.06.23.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 23:38:31 -0800 (PST)
Date:   Sun, 7 Feb 2021 13:08:27 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: emxx_udc: Fix incorrectly defined global
Message-ID: <20210207073827.7l7h3475tqgxxfte@apollo>
References: <20210207000030.256592-1-memxor@gmail.com>
 <20210207173441.2902acac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207173441.2902acac@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 12:04:41PM IST, Stephen Rothwell wrote:
> 
> Given that drivers/staging/emxx_udc/emxx_udc.h is only included by
> drivers/staging/emxx_udc/emxx_udc.c, shouldn't these variables just be
> declared static in emxx_udc.c and removed from emxx_udc.h?
>

Either would be correct. I went this way because it was originally trying to
(incorrectly) define a global variable instead. I guess they can be static now
and when more users are added, the linkage can be adjusted as needed.

Here's another version of the patch:

--
From 5835ad916ceeba620c85bc32f52ecd69f21f8dab Mon Sep 17 00:00:00 2001
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 7 Feb 2021 12:53:39 +0530
Subject: [PATCH] staging: emxx_udc: Make incorrectly defined global static

The global gpio_desc pointer and int vbus_irq were defined in the header,
instead put the definitions in the translation unit and make them static as
there's only a single consumer in emxx_udc.c.

This fixes the following sparse warnings for this driver:
drivers/staging/emxx_udc/emxx_udc.c: note: in included file:
drivers/staging/emxx_udc/emxx_udc.h:23:18: warning: symbol 'vbus_gpio' was not
declared. Should it be static?
drivers/staging/emxx_udc/emxx_udc.h:24:5: warning: symbol 'vbus_irq' was not 
declared. Should it be static?

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 3 +++
 drivers/staging/emxx_udc/emxx_udc.h | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index a30b4f5b1..3536c03ff 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -34,6 +34,9 @@
 #define	DRIVER_DESC	"EMXX UDC driver"
 #define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
 
+static struct gpio_desc *vbus_gpio;
+static int vbus_irq;
+
 static const char	driver_name[] = "emxx_udc";
 static const char	driver_desc[] = DRIVER_DESC;
 
diff --git a/drivers/staging/emxx_udc/emxx_udc.h b/drivers/staging/emxx_udc/emxx_udc.h
index bca614d69..c9e37a1b8 100644
--- a/drivers/staging/emxx_udc/emxx_udc.h
+++ b/drivers/staging/emxx_udc/emxx_udc.h
@@ -20,8 +20,6 @@
 /* below hacked up for staging integration */
 #define GPIO_VBUS 0 /* GPIO_P153 on KZM9D */
 #define INT_VBUS 0 /* IRQ for GPIO_P153 */
-struct gpio_desc *vbus_gpio;
-int vbus_irq;
 
 /*------------ Board dependence(Wait) */
 
-- 
2.29.2

-- 
Kartikeya
