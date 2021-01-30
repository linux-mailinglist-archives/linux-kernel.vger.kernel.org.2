Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1252030961E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 16:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhA3O4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 09:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbhA3OvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 09:51:05 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC02C0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 06:50:22 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 2so5982746qvd.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 06:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yaerobi-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CW/F06AVJFUTvuLKKSGAi/rzJobDHkRkV5w1mLI/Gdo=;
        b=ffso8FpE3hSmTAiXXmzJpkpDQj4OTXWkL9TsdjDQc1/XMgM2T6nFkXDljYPRwy2qGP
         /z95ABv/S7xmFunK0BzlXW35aPmvShFulP6Fve0xhYVptsIt1QmMHXhEPRuLk/Eodo6F
         MmWPb8bHNt+DJyrBlirkf/CvdGfMrhQYgeHNPub4fXOLQ4WuZrawwlnk/zm39M4Skxsq
         /WqYsM5L/uGvgEI19v3AmjsIvv+BjzYTFwsRJkOw8lP/d3tNNATjE/BAlgYiMwgSllS7
         pVjYBoa4X9SiSAo6uc9AqbSeNtdcigXDLhv51S2Oy9nk5J/YHzomVUnxr1tiZFc5pfeQ
         pUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CW/F06AVJFUTvuLKKSGAi/rzJobDHkRkV5w1mLI/Gdo=;
        b=PPWDlEVmvzDNF5IIdWWU7bc8xckAz/ve0Vn+ObQOxmWUQNQKde7FmbtYOpQD+Jpo4X
         hyjasNi5ekRaSBr4y5HcglHyacF7qESUhpC8VpcDq9QdMIN8ujCDXq/wo68Uvk45W3tP
         Fi9cdl4xrSLi8YYe6bP4BNdW2AGSufJ7KwHRAA0WO/4acZ1cWSRuUABYVDUU8JeGKPEb
         Q5flf3LJG4dkCZeAG6Juf06MTWoEqv0UBFUQJ1JjP4S6qcTihWyhcdW/cjC4iZniHO51
         DjExapgZCAUG33ps/oNQ/Xj+ANA8hkpxdzP7tGCRNwQKp+YOoZki7Fnnt5zOcCJHvSRe
         n3oQ==
X-Gm-Message-State: AOAM532HlvXTuVBa8kLpXvMkpzGm7fgUhOpEuwoempfQCYTs+aGHS75R
        N9c/pyuTH3sw9oiHahR/Ep4Hnw==
X-Google-Smtp-Source: ABdhPJxrnESdmE1m6PCli3OT5InLB/0y+LkfIgYQI1cUPU4kSrxh8OMpqzFlVhVqvpkL30TE9EzFGg==
X-Received: by 2002:a05:6214:1703:: with SMTP id db3mr8235225qvb.43.1612018221413;
        Sat, 30 Jan 2021 06:50:21 -0800 (PST)
Received: from debian (host15.190-136-155.telecom.net.ar. [190.136.155.15])
        by smtp.gmail.com with ESMTPSA id c20sm8322111qtj.29.2021.01.30.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 06:50:20 -0800 (PST)
Date:   Sat, 30 Jan 2021 11:50:15 -0300
From:   Emmanuel Arias <eamanu@yaerobi.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     m.tretter@pengutronix.de, kernel@pengutronix.de,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: allegro-dvt: Use __packed sentence
Message-ID: <YBVyJylm6qek7WvL@debian>
References: <YBRpstkOi685uHef@debian>
 <YBUeG38fOvMkYgIp@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBUeG38fOvMkYgIp@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> Spelling check please?
> 
> And _why_ are you making this change, what does this do "better" than
> the original?
>
Actually, I'm really new here, and this is my first patch. I run the
checkpatch.pl, and give me that recommendation. 

I would like to look the David comments.

Thanks!
eamanu

> thanks,
> 
> greg k-h
