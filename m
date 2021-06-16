Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6455A3AA39B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhFPSzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhFPSzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:55:10 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1458C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 11:53:03 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x6so264402qvx.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 11:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bi8dbucrJcy0W1D0dg2PU0hOFJEuVy1iH+Z01lR7RNU=;
        b=Po/xUUsHLApF2WJxJQfD/YuH91EnTAYSVD1+At+SSHlxCPOKFaw9xtnwZTdsdk+DFK
         BayPMchZJUB930+dPPSSh6lWVh5oNdEfz0ZlYGrkMYI+kXaq2wTWBOJrrBOC9k4PWSr1
         8hIkaUTo/FBInVYQX6XbTssCK+3z++KEDgkUq5wSDCT9uzsyBZTJsCc3z2wfo0Rp4Gy2
         4cbslr3Il3c2If01RtYElCx2dZ910hiCKH1YNGwB9F2N7sVsv3uHa+qdu+OMxzoNAf87
         opIFJMYgELd/xKzFT3icow5eXFKEouovuysAXmGye9Pr/YeSiYq+hnD5pV2l7lnxmNoA
         Yhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bi8dbucrJcy0W1D0dg2PU0hOFJEuVy1iH+Z01lR7RNU=;
        b=JQG596uWhrPwNLih55b+CB6vwWuz5kX1qD+CaIVAz4XiYSH9/17piaF/CXAWpsSuM+
         lKfv0vTBRMj592JDU2WGy8rAigDr6BsXwIse062CaAIsElQbo2nqfHa8VqdBLRoS9kFT
         xXSi5hmQlDDKzsEMsTcicZuLiKV9X9dJpfTDnY5Elg+LG6tjbYNZQqneZzpMKOICWFpm
         Exivv3aPby9iJBOrDwhqAYclCQxoZQ7UPKNk223osOdukPUm0awdzPMGfw3PMM3vYb84
         d8l2ApdjW/rslEy2DI3V6XFyZhrnTcjnlVftnimPZiv3vANsE5iecq5BJDflVlCxW5lk
         fPMQ==
X-Gm-Message-State: AOAM5308NIusMdoETbkEa13WTj7BVSw/Ue4gqwTv8LPCDgyeBtmF8wIo
        gkCtIrLnkap/N12NsrBJtA9qpA==
X-Google-Smtp-Source: ABdhPJzkiKO6DN9zp2TAQ51SVCuXD9hc0JgggsuuhG7gouo0zcIq4LwmfpdPN8lJmIm+C4xh7+Ci1g==
X-Received: by 2002:a0c:8563:: with SMTP id n90mr1504110qva.41.1623869583161;
        Wed, 16 Jun 2021 11:53:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id i11sm61968qkl.95.2021.06.16.11.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 11:53:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ltaes-007kLT-09; Wed, 16 Jun 2021 15:53:02 -0300
Date:   Wed, 16 Jun 2021 15:53:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>, kernel@axis.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm: Fix tpmrm reference counting
Message-ID: <20210616185301.GV1096940@ziepe.ca>
References: <20210615091410.17007-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615091410.17007-1-vincent.whitchurch@axis.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:14:08AM +0200, Vincent Whitchurch wrote:
> The code added by commit 8979b02aaf1d6de8 ("tpm: Fix reference count to
> main device") tries to take an extra reference to the main device only
> for TPM2 by looking at the flags, but the flags are actually not set
> at the time when tpm_chip_alloc() is called, so no extra reference is
> ever taken, leading to a use-after-free if the TPM modules are removed
> when the tpmrm device is in use.

Please read this

https://lore.kernel.org/linux-integrity/20210205172528.GP4718@ziepe.ca/

Jason
