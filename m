Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3605F4300BB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 09:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbhJPHCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 03:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243732AbhJPHCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 03:02:44 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AC0C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 00:00:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n11so7784293plf.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 00:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lMEFPqH1XlcrQLclXfoWUZvVtlxAhYuA7jM+7gecrs0=;
        b=kFBx6J0X4vJVZN9EcNTc/xZ6BDB7V4AH2wxwj+jC6Oog/fw5n6Z2+alVGaXBP7Bxi4
         tUDKVlKLD1+6hF/BP6A7FveZAjvuSRdjqWY3zbxLW6ZfmIB8Iw4XthwO78iY4+Owbx1v
         +qFrn+QaUdxcTLtAWS8cZnJTcRzRZl+FA8FnO6a8nUcGD320pUWDn9/uXeVoffA4sU6H
         /HP4C2Klv+aXl0EMsGxp6i05zivQuwRvI+PCkYbYiMaJmxvgdsyzaEUxjB7HtzsVh3LF
         hY4vy9lJo26LCCNokZukCfulxsDf8tFmu0hqX5e7cUCGgkOU5jdxleVfn0o/tIcbkm3d
         N2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lMEFPqH1XlcrQLclXfoWUZvVtlxAhYuA7jM+7gecrs0=;
        b=6eoS//6/+hTeepLsjFqE4kHmu8lJpAkQcR52IfKkpGLJWKnsZkrFioKvRfO+QeqCHp
         rNtVhbFmcUp6NfwypQhoaFL2akXCg+mkjva/D+MUfJvdYPFuYAPFsbv0SjP8zYKdaOXS
         W+jwgZ2rDRL25XGlOkij0E+RBEPvx7USaPmByjM9AZnhLnVgakJQJ82YvduinrA3Kudz
         YZOC3VwSL/EbGC16t576W5JAQNdE0jz9zliWxQJt3SbkwPA8qs1iEJZNvm1nwCwxPaZ4
         1ZwrF/DdNeSWXjW0R2YZVps78KLx+CXt0/TYKQ8xEuU0du4rftD+bi7Z3FU45fXkpCXQ
         VmeQ==
X-Gm-Message-State: AOAM533uDwD79KfQUh52ajKfgDFcT9erxC725eh7d/egZki7YKffQEoI
        D4nYrwWfMeg7TeN59FUebq1s
X-Google-Smtp-Source: ABdhPJzHLCxUCh6kG+C8mbPngdevFkS4xm+5wcgywkZaD5/grXGOtrSQ9CSxzAYm4HrAx/djuQJxMg==
X-Received: by 2002:a17:90b:4b10:: with SMTP id lx16mr18778829pjb.217.1634367636537;
        Sat, 16 Oct 2021 00:00:36 -0700 (PDT)
Received: from thinkpad ([117.202.185.237])
        by smtp.gmail.com with ESMTPSA id j7sm6529767pfh.168.2021.10.16.00.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 00:00:36 -0700 (PDT)
Date:   Sat, 16 Oct 2021 12:30:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        loic.poulain@linaro.org, wangqing@vivo.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] MHI patches for v5.16
Message-ID: <20211016070031.GB23491@thinkpad>
References: <20211016065734.28802-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016065734.28802-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 12:27:31PM +0530, Manivannan Sadhasivam wrote:
> Hi Greg,
> 
> Here is the small series of MHI patches for v5.16 with summary below:
> 
> 1. MHI got a dedicated mailing list in subspace server. Hence, updated the
> MAINTAINERS entry adding it as the primary list.
> 

Missed to mention that now Hemant is a dedicated reviewer since he is not
handling any of the maintainership duties.

Thanks,
Mani

> 2. A leftover patch from 5.15 PR that adds a dedicated flag to the MHI client
> transfer APIs for inbound buffer allocation by the MHI stack. This is required
> for some downlink channels like QRTR that depends on pre-allocated buffers.
> Since the patch modifies the MHI client drivers under "net/", Ack has been
> collected from the netdev maintainer.
> 
> 3. Fixed up the coccicheck warning by using sysfs_emit instead of snprintf.
> 
> Please consider merging!
> 
> Thanks,
> Mani
> 
> Loic Poulain (1):
>   bus: mhi: Add inbound buffers allocation flag
> 
> Manivannan Sadhasivam (1):
>   MAINTAINERS: Update the entry for MHI bus
> 
> Qing Wang (1):
>   bus: mhi: replace snprintf in show functions with sysfs_emit
> 
>  MAINTAINERS                      | 3 ++-
>  drivers/bus/mhi/core/init.c      | 2 +-
>  drivers/bus/mhi/core/internal.h  | 2 +-
>  drivers/bus/mhi/core/main.c      | 9 ++++++---
>  drivers/net/mhi_net.c            | 2 +-
>  drivers/net/wwan/mhi_wwan_ctrl.c | 2 +-
>  include/linux/mhi.h              | 7 ++++++-
>  net/qrtr/mhi.c                   | 2 +-
>  8 files changed, 19 insertions(+), 10 deletions(-)
> 
> -- 
> 2.25.1
> 
