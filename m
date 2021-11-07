Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9819F4472C5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 12:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhKGLqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 06:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhKGLqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 06:46:39 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4FDC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 03:43:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ee33so51056281edb.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 03:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=50Soiq3WEOeOybtuOq6WlDjJGXBsxR//U/Oh1dfjGCU=;
        b=adp6bYt0EZU+RH4YpNCvDLuW7gdNxTdgKZJqGc+daBuy1Q7hFQZYck0btWdxOK/2Ez
         jIr8iUKU95yWSXuYImoRxcvMTDskn36e9OUbx5xmI0icWsnaEzWBQHYHeVduNXl9I7Mr
         vUdaTKhn3k/vJ5DuW8Ym7IMHdHxMOWbo773bnvtL8Nk+LNBv+bLp+VZivGYniITlUbwO
         cxd+IMsY+IJnvo7ODTyHC53mpyE0QrQbfAZ1sA5968m2QO7cZtBDuWa7Ak3cseqlnrDK
         /LhvR3Gh4RxWJOALNOZbtlJQ2SE33sNr086rep6OGO1UeLpF/V8fW0E9Wp5b/oVH6Yw+
         tXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=50Soiq3WEOeOybtuOq6WlDjJGXBsxR//U/Oh1dfjGCU=;
        b=ZgiKqRIA5/2BRR+e/Hms3ZzlOPHBFGCiAsyXbLXNcSpQ1fXlJOfsvjBNqLBd0e8U8F
         fInGi36NkS1SyNoNOQL7UUa7WTwdklUMjBNUL5OMIDB8+N+Bl2eZKoLQj9mOoPbjclFV
         rDCta5hkDuvxC45vkNsgoqLA5xo7iA8JvJatU9Z192HXiDoesU+4xlOgvhC+SncK56DF
         tYxcTgh+2oqUaHeSDChcWvbm7/0paCk80dsfBqj3xDFf9N1cz9YQkbQ9osAEGyixnwLN
         ku2ITaBz6TJSvcTgq85TIdDufamEXGTCmGakIlqHag5yUYP3iFuz1qKm5m/h1rzvvQq/
         zv2A==
X-Gm-Message-State: AOAM533p+LNS5GjjxkQIal3wQ4GiK3bhQ+bcCjc66FlWsefCJVmxas50
        1DTeArf6xKStANJw8nXUgQY=
X-Google-Smtp-Source: ABdhPJzmmYxqw3r568g0TavATRuEAtcQy04qcstjy29cKGw5WNQGpVte6eo0ZhXfC2ZpUmxMt2JWZQ==
X-Received: by 2002:a17:907:6d82:: with SMTP id sb2mr70287541ejc.440.1636285434930;
        Sun, 07 Nov 2021 03:43:54 -0800 (PST)
Received: from localhost.localdomain (host-79-56-54-101.retail.telecomitalia.it. [79.56.54.101])
        by smtp.gmail.com with ESMTPSA id hd15sm6907701ejc.69.2021.11.07.03.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 03:43:54 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context
Date:   Sun, 07 Nov 2021 12:43:51 +0100
Message-ID: <2389191.WthrnW1hFq@localhost.localdomain>
In-Reply-To: <20211101191847.6749-1-fmdefrancesco@gmail.com>
References: <20211101191847.6749-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 1, 2021 8:18:47 PM CET Fabio M. De Francesco wrote:
> Use the GFP_ATOMIC flag of kzalloc() with two memory allocation in
> report_del_sta_event(). This function is called while holding spinlocks,
> therefore it is not allowed to sleep. With the GFP_ATOMIC type flag, the
> allocation is high priority and must not sleep.
> 
> This issue is detected by Smatch which emits the following warning:
> "drivers/staging/r8188eu/core/rtw_mlme_ext.c:6848 report_del_sta_event()
> warn: sleeping in atomic context".
> 
> After the change, the post-commit hook output the following message:
> "CHECK: Prefer kzalloc(sizeof(*pcmd_obj)...) over
> kzalloc(sizeof(struct cmd_obj)...)".
> 
> According to the above "CHECK", use the preferred style in the first
> kzalloc().
> 
> Fixes: 79f712ea994d ("staging: r8188eu: Remove wrappers for kalloc() and 
kzalloc()")
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v2->v3: Add the "Fixes:" tag, as requested by Greg Kroah-Hartman.
> 
> v1->v2: Fix an error that I introduced with an incorrect copy-paste
>         of the sizeof() operator.
> 
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Hello Greg,

I've noticed that you have already applied recent changes to drivers/staging  
up to the patches of November 6th, but my patch is not among them. 

This patch has already been acked by Larry and I'm not sure if I should send 
a v4 with his "Acked-by" tag or if you can add it by yourself when applying 
to your tree.

Please let me know if there is something that prevents this patch to be 
applied. I have no problem in changing / adding whatever it is needed.

Thanks,

Fabio M. De Francesco


