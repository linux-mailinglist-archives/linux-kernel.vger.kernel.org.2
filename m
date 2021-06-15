Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149F53A8ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhFOVMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFOVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:12:20 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AFAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:10:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso405817wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0lptI6mxMVXNr9ldiINhSrP9hdrEvGc4RX7GvmEwDJI=;
        b=LAyi4WXCq8ky86HrZv1w1WUWI7uW3W+9mr4ehI5wyHMHm2SyQ7hZBTnz5vaI0OR5kF
         2LElWftztzV2Qmziv7KOp/kUcIJt4tkQgH4KuPtzoSetfINkZixPhyz6p/pV5RZevM9S
         Al0J/elq84i4oP80b19jpUvpyzsymSH01tcOC35hkr9t8f0DHJEEwb+H0vFNtW4kyRBf
         Cl1PtlqhOEN7kvJHBPzUoVyr1wOkmRAQhY+JWVAE98EkfGnJ+EE7beIVSi/U1g+WqFKi
         bJTGWuRuF6RZepsjo/ZK5r0G3kDiHaX6z8FfttZ/TDo2A+uquUHweJr3C8slD9a6TUYS
         ZYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0lptI6mxMVXNr9ldiINhSrP9hdrEvGc4RX7GvmEwDJI=;
        b=JNye7I5l9pA65/11Ko9mMsI/YBIxQFG2H9LWFAnNF3Pt0fpemaY/DqWfr9X8VGfGy8
         +71t5sj600Mg/J4zAM4dEqubjU7XbZfA6+bqG2komh390k6K+eQnHOW/iI12rz0FSIrj
         mwi1kS7XwnS7ad11N373WWTj2YsKERjUHNZboTO5Mh1+IMkBuNy+PyLMyHGKXWXWcjQ+
         iWBO7t5sU5CdAg9vvjBgAt0PuLuAphQp/Ud9qWvoWMBNeUBMKolqn4CcWpnbYrKFIbHO
         qX01LJt1ehuYKeRiO1DG+Og02tLgcFWVXF+HRIkdz6N8MQInUfkc7AOUixf4EIpKyS9A
         KL3w==
X-Gm-Message-State: AOAM533CQjmMSRrcWHHnLrryppPDqKljYlW52L9dZwTXQmVMBGvagGIj
        3yb1XWHznsgx9mfu9GyomStMsw==
X-Google-Smtp-Source: ABdhPJy5Ebwdwf7oaK5xFM9vknd5Nljt7U9AMNm4IU5RBPoQsXpslmAzC4ci7LZlwglr5JR7Y1WYwg==
X-Received: by 2002:a7b:c396:: with SMTP id s22mr1286756wmj.131.1623791414001;
        Tue, 15 Jun 2021 14:10:14 -0700 (PDT)
Received: from KernelVM (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id f12sm74202wru.81.2021.06.15.14.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 14:10:13 -0700 (PDT)
Date:   Tue, 15 Jun 2021 22:10:11 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 00/28] staging: rtl8188eu: remove DBG_88E callers and
 macro
Message-ID: <YMkXM3/IHaouqgAR@KernelVM>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
 <20210615125125.GC1861@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615125125.GC1861@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 03:51:25PM +0300, Dan Carpenter wrote:
> Looks good.
> 
> The future is vast and unknowable but I feel pretty confident we will
> never miss these at all.  :P
> 
> regards,
> dan carpenter
> 

Dear Dan,

Thanks, felt good removing that much code! I will get started on the
other macros in include/rtw_debug.h shortly :-)

Regards,
Phil
