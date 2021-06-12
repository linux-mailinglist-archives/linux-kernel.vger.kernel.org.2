Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925913A4FF0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 19:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhFLRl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 13:41:57 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:36543 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFLRl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 13:41:56 -0400
Received: by mail-wr1-f45.google.com with SMTP id n7so3359012wri.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 10:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zc5UZZSa3ySEXVarFqXVRJeSGls1BBSSN2jPWTbN13I=;
        b=SELjJCU4h+/WZ7uorJ6FiJQw00/Gn4ivVL05A8YIpfCs/+p0MiR4MhdDDQFsjzKGJw
         f2WrHtm02jmT3E/5BIgNwf/vUTsmrSmQfyJXhMvj/3iuDm+PseaFRbXpJlH0LD3nQL/9
         c8eeLK+43U4DGqxIKqE/J4R8SwP6zSZBLdXtp59GGmpXc2R/95MKHSLds8vZodZx1Hic
         4Z+pk2UBn29nxUjTuO76IJ7b38CqsKBig9GAuJFCzQiKTtjZ1Vk4vY4TGGoLFGT5MHaY
         oN32MRn0B2UAbBs/Afyp+HymBCLX4D0ecMJ1On+00OPJDrZjfyk7RYGu2mrD0kJ2qfwV
         Z0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zc5UZZSa3ySEXVarFqXVRJeSGls1BBSSN2jPWTbN13I=;
        b=KZFtoZ+2K8nHAv0GDek7SmInmtgiAyIiSd9/5iFCF0JS2OZYQSeVivS+nzQoARj+a9
         37CtFWBDFCECjMs9Y5eiIgJTiq30dz/HwE2lPywltgafQRtGEADSa71iS1OrYEsXcrod
         +E5IN9DjMmenQN7LCVOqlinJTRxm9hXBNlLyhDnahJBLglQurwQxe9VtxyWj768kM0bt
         Km4eyfzannToO6dMIqX6vfjJYuwcXTlm0OfND2Eh7EXYeDijVXfalm8GC+tDhnGHq4Q1
         2XdGOeFiFvPzaB+g8rxUMhzRP8CCyGmhyWuXeCCHWORdcugAJfqkzgE0kjpdW9tYbYMY
         T3bA==
X-Gm-Message-State: AOAM533DQluWcLMxUPRlJEIihxgmtHxD5KxyuJrI12yXIr+M4vsZK2YK
        qRt6joeS2PhEQETK1x5dGwkf8Q==
X-Google-Smtp-Source: ABdhPJy8Yurr0n1n8na2fQmGEgZjA/cbHa4Zd88YONWWQl7/0D6AamPpruinTzfk3sL7NoG9qJ7YyQ==
X-Received: by 2002:a5d:4c4b:: with SMTP id n11mr10246432wrt.269.1623519536413;
        Sat, 12 Jun 2021 10:38:56 -0700 (PDT)
Received: from KernelVM (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id a12sm9152006wmj.36.2021.06.12.10.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 10:38:56 -0700 (PDT)
Date:   Sat, 12 Jun 2021 18:38:54 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, kaixuxia@tencent.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        liushixin2@huawei.com, unixbhaskar@gmail.com,
        gustavoars@kernel.org, bkkarthik@pesu.pes.edu
Subject: Re: [PATCH 0/6] staging: rtl8188eu: remove hal/odm_debug.h
Message-ID: <YMTxLsrbzr6iPYsx@KernelVM>
References: <20210611002504.166405-1-phil@philpotter.co.uk>
 <20210611091010.GE10983@kadam>
 <20210611153550.7p2deovau37rlpju@viti.kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611153550.7p2deovau37rlpju@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 05:35:50PM +0200, Martin Kaiser wrote:
> Thus wrote Dan Carpenter (dan.carpenter@oracle.com):
> 
> > On Fri, Jun 11, 2021 at 01:24:58AM +0100, Phillip Potter wrote:
> > > This series removes hal/odm_debug.h, which contains various preprocessor
> > > definitions, as well as an unwieldy ODM_RT_TRACE macro which is not best
> > > practice. It also removes all uses of this macro, and the associated
> > > fields in struct odm_dm_struct which are only used by this macro.
> 
> > > This makes the code cleaner, thus moving it closer to getting out of
> > > staging.
> 
> > Looks good.
> 
> > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> same here: looks ok and doesn't break anything
> 
> Reviewed-by: Martin Kaiser <martin@kaiser.cx>
> Tested-by: Martin Kaiser <martin@kaiser.cx>
> 
> Best regards,
> 
>    Martin

Dear Martin,

Thank you for reviewing and testing.

Regards,
Phil
