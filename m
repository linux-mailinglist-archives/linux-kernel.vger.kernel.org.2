Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE124300B8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 08:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243725AbhJPHBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 03:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243712AbhJPHBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 03:01:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB543C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 23:59:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a25so46977388edx.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 23:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SHQt8hFsjogNRuVz15k6SyLo2IuU73v5DLEEAwJxV5s=;
        b=hJ/gEuwoFNPehp4JyaaX4DCYodDGwPIxXYA4x6erZQ3yeWC3gcjlFFWvUDjSQYdZMR
         LbNZlhA5M9+eYnH3h5VvdYEBx/dBRD77nnOoNdgWKgNQCxQF0ZMD0dignNrQiSrhT0nr
         eWgx6q8hVhXE/6DTBnUyeFRVZJdwI1oez0/VUtNbXgiasb/vA4HjNwfNBw9Qm6Wg5ioz
         8XfM+aCTPUdsrTa6RTU5lGl8vDQeo0gybEw3ZyzWtBcunCq91OA+UrYB5XTpXbus1wUR
         GEMfwObZdC8EzS2q7rZieQOMYL1mWHQDrV8AhLRiBmBCYckVAoOPeNBLVQ0jrlbNjkFw
         wjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SHQt8hFsjogNRuVz15k6SyLo2IuU73v5DLEEAwJxV5s=;
        b=7OUeE5Jx+SvnJqOmcjBgAc6lvCHWnMLdMyxzV034OSokCOAo/jkXJT94XyypweBluL
         O4OpXarJMZqoPDTNMy3yrV8pRJNi1DsaRSd/4RZ16eTznnxO2i3AHV/49PADm3Beg23J
         azJ6iRGmDpSLZ3kfAkvBI+vRMi4iQSsUsYhs51KWxCRufA6LHBMDJzZQR1M4rOeGqW8l
         udmPZcXql0GpifoDzfcqUv43NoKS5Wt1r5NbqaBpNMfIygmmPUeAHM3PAsa/3RGwt6YH
         Pjdco0pwLe+wmIItaHeuuXxBAl7YoSjlPghleii9hjTiqpTBf3gd4YBEtgeAX9Cuh64m
         kGPA==
X-Gm-Message-State: AOAM5324nwYMYdd1LXxj4R01bnI2+WEzQKMkJm/XbppXGCeKr7zQb940
        nQliZgjXcPfTiM+lFyaT8Hs=
X-Google-Smtp-Source: ABdhPJyTf+7FlIGuWX1Y4Obapq+FYi7LW0FkAHLAe2uM5KX/tbivyWlBPzL3OGvjtHgQ6DfVJ9SkaA==
X-Received: by 2002:a50:ee85:: with SMTP id f5mr21477313edr.302.1634367569839;
        Fri, 15 Oct 2021 23:59:29 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id rv25sm5703063ejb.21.2021.10.15.23.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 23:59:29 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [RFC PATCH] staging: r8188eu: Use completions instead of semaphores
Date:   Sat, 16 Oct 2021 08:59:27 +0200
Message-ID: <5414235.RPW7nLbG7U@localhost.localdomain>
In-Reply-To: <YWm/x56aX+rNOlE0@equinox>
References: <20211015110238.1819-1-fmdefrancesco@gmail.com> <YWm/x56aX+rNOlE0@equinox>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 15, 2021 7:52:07 PM CEST Phillip Potter wrote:
> 
> Dear Fabio,
> 
> Sounds like a good approach to me, nice work.

Dear Phil,

Thanks for the "good job". These words always sound very rewarding :)

Please read my reply to Dan's message. I have decided to go through a 
different approach and make two patches for the semaphores => condition 
variables and a third for removing a duplicate 'if' statement in that  
rtw_cmd_thread() where now we have the semaphores.

As I wrote in that reply, I hope that you and Dan agree with me on this 
different approach to fix rtw_cmd_thread().

Thanks,

Fabio 

> I agree with Dan's
> feedback also - will wait for the final patchset then give it a test for
> you :-) Apologies I've been a little on the quiet side as of late.

P.S.: No need to apologize at all :)

I had noticed that you haven't been around for a while. I would have 
appreciated a review from you (and Larry) on the series of 32 patches that 
Pavel Skripkin and I co-developed and submitted some weeks ago.

However, I am 100% sure that you really had some important reasons for not 
being here.

> 
> Regards,
> Phil
> 




