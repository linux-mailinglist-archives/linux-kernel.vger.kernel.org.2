Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06557393343
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbhE0QNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbhE0QNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:13:33 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9DBC061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 09:11:59 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c20so1173390qkm.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1DCYsxPcwgz6wGBXKddPfgeFqjOqmPMV5wFOCxRJ+3A=;
        b=PngmZ1AInSHpKNoMvNBtIfyeQ/6Llk/gXeRI9Pd0xGn54rwNOD/XdwequEEpKUbM53
         6VlYrgeQs1Wi1y9TNmxlBivIkc8Si+ODQGVBXt+Ie0XI6nBRrOqUSTLPB2U83Sk0pWju
         4Rzy6Q6+G5uqk1pkzlP2nb9SxHeLPmPRRS2IsmZT/Yg/cCbcMzATIstA5PS9jp/YNwFb
         kfvokaxjIB6487ZnmGgCD2xOLe54oPJmjKTpqFjrBnf6WMAhBE3kXD7F6XmsGPQlXIik
         VmLapHyeddMc5C2ybH8Jcd/IrWAI3N8u6eOXcKxlYY1qIaFgqRT/MiFqZQmMOGuJWA9U
         zGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1DCYsxPcwgz6wGBXKddPfgeFqjOqmPMV5wFOCxRJ+3A=;
        b=ublDK9bOQRehtBtki5QcAwYv+L6/DNaxpYyuzJ6dv/xOs/l3Zdn1awhps7tMurqJDQ
         bk4byesqJSznx2GeRMp25vi2tSnKJyYzQo17RbPsqZz+r0ap41gAzOpswVmLhMIf4ZaV
         nTHYBhwmt8z4y9DvBjX+U/urJdhZ7F5M0ycEAl4KIOfrlrDNMeHhdMBYr78KWWNEh24R
         mB0vRPMlVcWrF6xrM9ZbPC2lToGweb2b+FjwV5uXuyYfhX1eLEbHJMEBXDbHM3TccVqi
         H5EBRkHrzHJDw8bkWO/5daHrbpCRqUbpflhXi3TWR0BgMVMT+cdKE39QBzjgtwvPQsAE
         faHA==
X-Gm-Message-State: AOAM531d9VqjWLGoM5hBMCxB7tPxsLHuvwBzkQRgB481psVSL4uoGNnq
        +dma1wqpZ7G2vGzkEsGnMgPwvULAGHy8NA==
X-Google-Smtp-Source: ABdhPJxSGGCq2RcvTVfyqdH4MeLuYORIVug/LGCAqFWth8scx61JtGxD+Zd0VUKM5Xo7RbDMK1wHOQ==
X-Received: by 2002:a37:6645:: with SMTP id a66mr4272666qkc.314.1622131918489;
        Thu, 27 May 2021 09:11:58 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id x9sm1587665qto.33.2021.05.27.09.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 09:11:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lmIc0-00Fc4q-Ni; Thu, 27 May 2021 13:11:56 -0300
Date:   Thu, 27 May 2021 13:11:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Wellbrock <a.wellbrock@mailbox.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_spi: add missing SPI device ID entries
Message-ID: <20210527161156.GH1096940@ziepe.ca>
References: <20210527152352.3835076-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527152352.3835076-1-javierm@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 05:23:52PM +0200, Javier Martinez Canillas wrote:
> The SPI core always reports a "MODALIAS=spi:<foo>", even if the device was
> registered via OF. This means that this module won't auto-load if a DT has
> for example has a node with a compatible "infineon,slb9670" string.

Really? Then why do we have of_tis_spi_match and why does spi have an
of_match_table?

Jason
