Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B046B3E35F4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 16:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhHGOvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 10:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhHGOvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 10:51:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A4CC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 07:50:47 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c16so15045288wrp.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 07:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9hn67tJt2X1HPMWoBjQTop2rYNzqOcgRwZWoGVS2Fr0=;
        b=qQ7q7kbLiOq0y+zSYTXgcu38Vz9+ADTLdxdQTwLWXKFPeZ/iNFjPB5QxKifmwUFS+C
         de8b+cr/cTxcsn2Xcb3JR8iwN05NdMMBsHMmLw5JE6gZxpZtEkkaWwVUBsanjOQcQrR0
         rziijtStCcuyD4bJay/jGhlOd41F5x0AxnmvSeuABsIroukgN8wTxW00fd3r3+Ag+GcN
         wYeVO+PonOy0DL7IZGYbqK6CkbZgG3xXKwyPJllOnuR1/gqW9PFen7dM9JAK+ZwfcwF4
         uDgh5oFidZuRWss38yhWzA4qZpq8RaEalc3ZTw0yuUzTENWuijVz+qYBYq2rAu3nJ1rS
         GZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9hn67tJt2X1HPMWoBjQTop2rYNzqOcgRwZWoGVS2Fr0=;
        b=bbv8QA53/FqSpIW4BNFKylWwqrKLcqRsL1sCtmbWEvowT9rwX30ygTisc6zLI51LCc
         1EIfzFb8Zc/TIYcGzrLs1Om6/kzt1KZhkGzd6ElT87l7xyMxYy7XkSqqPQ6yZ+95ghf8
         ssG2QVmBS/ZxlFeHM2vMA+33aWg/O1u+NtSCsSWJ/WY5RNpr5hph4sIf1qg7Hg4F+QIU
         5bHFFOmLAD7IuUZbW5TG2TBBAifWEc/470Oko1O0pttOmNWv8feadjig6BCLtd8w5/Z9
         fAVz+3Rbw13K+5X/KUaGU8kplLqQ/O6GMEFLdzzvzZ6DtFr1oL89jzME35ooYFDAXoiF
         UsEQ==
X-Gm-Message-State: AOAM532TQ2wpGjpSh9GC0/JlxGKwBPGBRX84dUyeWGLEJ2WwevfLr4tc
        gR2f8zo0W5IhoUvbhTbXTZw=
X-Google-Smtp-Source: ABdhPJznosRzvxBcRhbfL9RupXi4erQbhUVgXv9oQcXlBupwT29tuTt94TfgjfNXC08e6tOThohNyw==
X-Received: by 2002:a5d:684a:: with SMTP id o10mr15912822wrw.384.1628347845701;
        Sat, 07 Aug 2021 07:50:45 -0700 (PDT)
Received: from agape.jhs ([5.171.80.175])
        by smtp.gmail.com with ESMTPSA id e17sm2531296wru.7.2021.08.07.07.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 07:50:45 -0700 (PDT)
Date:   Sat, 7 Aug 2021 16:50:42 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        insafonov@gmail.com, straube.linux@gmail.com, martin@kaiser.cx,
        will+git@drnd.me, dan.carpenter@oracle.com,
        apais@linux.microsoft.com, yashsri421@gmail.com,
        marcocesati@gmail.com, ross.schm.dev@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] staging: rtl8188eu: os_dep: Remove unused variable
Message-ID: <20210807145042.GC1425@agape.jhs>
References: <20210807102232.6674-1-saurav.girepunje@gmail.com>
 <20210807102232.6674-2-saurav.girepunje@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807102232.6674-2-saurav.girepunje@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Saurav,

On Sat, Aug 07, 2021 at 03:52:29PM +0530, Saurav Girepunje wrote:
> Remove unused variable data and data_len from mon_recv_decrypted() in mon.c
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/rtl8188eu/os_dep/mon.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/os_dep/mon.c b/drivers/staging/rtl8188eu/os_dep/mon.c

did you rebase you local tree on current staging-testing?
rtl8188eu has been deleted... now there's r8188eu.

thank you,

fabio
