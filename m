Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7356235E926
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 00:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245719AbhDMWmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 18:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244005AbhDMWmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:42:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FC9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 15:42:13 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t22so8706067ply.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cgaYXSZOTsyuI2WQc1xYtFXeTOnpeK93EKkn9K0IUZM=;
        b=NHIvJLjZvj2yheXBL2MqUjNQkNY6Uy6WHGfb4g/3dEzh4TtbeUyH5d6KDvP/WGzgJc
         ffs9qn6MA654xYGiq/7HyT1k000QhAyXejXNBqy0fa0DtjAp/YdEgaxNMznM0IIv5Gxi
         ve2QWYQ00T2YjJT8IxxW9fS4mMqqF/S+7z65yB2XSiwa6npHuGlax3v7Q/OafRxcolOb
         iKoSJfABpJYpj8M74t+Hk2tL6mPhongynPs1tGlKiQpaWLTMCn3ywjgS1BCJbQbKMwTL
         +rZMzeDdauSTD9udmKrZ/5fHXJpVcm26j0c3jwGmSOgMqZsz5K6Q1aQQg1dcGFBiqqo7
         ruqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgaYXSZOTsyuI2WQc1xYtFXeTOnpeK93EKkn9K0IUZM=;
        b=ib/Nic2oJPQcvMC2cGAwuYDwg+meQNVtNnql9nxu3wWFsuiR8F6mlQzzsZBk72+0hP
         2/+5tx/ucAKpF4gOtbSAPvwPH9YIZ9E2ZtYF32dDPlCvR6d3o5bTBVwCE3pOFl3hD6Me
         AUB5KfILplkUp8GA3zeJqKkzCLmbb2gyKFEaD8tKSD4hZRcdUsjDxvM5WHiGiTqvumRH
         2H7WPkfQPMRzTgCmAeAbnaXQFfVtdsDp9muz+GTK+9cDSqImAetdJXNz99I7xwhHKVJw
         XtEWCvnw1gzqDB7lu+b1rBytW2Y4E9MNpytoqLxpENqFf/k7HmEmmQA/rzKZoHQyJovc
         xo9Q==
X-Gm-Message-State: AOAM532RLwadHfPh+wOXCwh57zHJzH7dz+K/LMysTgHBgoBCDWmlF0CT
        Xz0DmwCnD2QIeza3Gi7MCrRb/Q==
X-Google-Smtp-Source: ABdhPJyxb5q2GZ1mmHMGL3ezR77APOp1QJYh0z5peMbiSCu3uKwrKSFnHn7ItND/dn+v9f4YWSdmuw==
X-Received: by 2002:a17:90a:5998:: with SMTP id l24mr45539pji.76.1618353732705;
        Tue, 13 Apr 2021 15:42:12 -0700 (PDT)
Received: from hermes.local (76-14-218-44.or.wavecable.com. [76.14.218.44])
        by smtp.gmail.com with ESMTPSA id e190sm13244357pfe.3.2021.04.13.15.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 15:42:12 -0700 (PDT)
Date:   Tue, 13 Apr 2021 15:42:04 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: Space: remove hp100 probe
Message-ID: <20210413154204.1ae59d6a@hermes.local>
In-Reply-To: <20210413141627.2414092-1-arnd@kernel.org>
References: <20210413141627.2414092-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2021 16:16:17 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver was removed last year, but the static initialization got left
> behind by accident.
> 
> Fixes: a10079c66290 ("staging: remove hp100 driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/Space.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/Space.c b/drivers/net/Space.c
> index 7bb699d7c422..a61cc7b26a87 100644
> --- a/drivers/net/Space.c
> +++ b/drivers/net/Space.c
> @@ -59,9 +59,6 @@ static int __init probe_list2(int unit, struct devprobe2 *p, int autoprobe)
>   * look for EISA/PCI cards in addition to ISA cards).
>   */
>  static struct devprobe2 isa_probes[] __initdata = {
> -#if defined(CONFIG_HP100) && defined(CONFIG_ISA)	/* ISA, EISA */
> -	{hp100_probe, 0},
> -#endif
>  #ifdef CONFIG_3C515
>  	{tc515_probe, 0},
>  #endif

Thanks, do we even need to have the static initialization anymore?
