Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22068403AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbhIHNlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbhIHNlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:41:12 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15D8C061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 06:40:04 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id s15so1822161qta.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 06:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o02AjA/DkBO4MKiA0z1x+QbupBud7qRnZyGIFZHcYao=;
        b=l4sa+fy6SodMxTIshaKj9PVhrINrHfR0TBUotmfywrtBxkPUctE7ARDVtoLyJzqk0T
         a0DOinLWVb+AL1c/NFBMxMlDmrCGqFKdBRPNUizuq2pjvHcqlsGus/Mgrk/DYkJVvbYI
         US00z4gGu5tSC0R/bourR4g6SDrNv2CwsnYSHyWOwC41g/vE7lSYDbjIVyhiPvuFVH4R
         9CAyW+JIGXraIK5zdOqmQnRWnfO7TBLs+bchKMTdza0KYq4tUA/MPtYD2oP4yGz02NvQ
         gryrj4XHXZLi9N79O+GOV/Yi48cTb7RlsYLruxYLpv2la3dERb+odMaMgOmX2q2yxlen
         2CfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o02AjA/DkBO4MKiA0z1x+QbupBud7qRnZyGIFZHcYao=;
        b=sAKyRIIBNyMx+i7s8O+ra8794kmdnqKPxVt1Di+5JnagGGayhupWzqz4EOT6XaYAcQ
         xdGzorx3QHkHNuqB19V3YohQkIo8ib42zaGNliQalpyq0oNYLlU84rJ92kVRloRKyCgB
         7Inj2Rc2YyC24QSzFYo7BjQDRysmko8wkGbGTyZ1lNictS89C6TXjqh7Py1CN66hQTR2
         XRpcWprHcXoTxAoTLzouHYQ2SwJAvFJGxivLm2zRuehbqORCpJOnE1fZoKo35R4l1WDx
         FJRORULHexsXzXU7JvhPJ4W09pPfZkOg7sZe/TodtHUJlP2LITK1rJ3Hl0afdMxcw1Zl
         KlFw==
X-Gm-Message-State: AOAM530jEUVYYklIqhjOdsfwJ+OlkojC6zp0xnRW4R0GG8k0OLk6xgJj
        FEha/jKutZVV1CF+2Z3+f9V4kg==
X-Google-Smtp-Source: ABdhPJxFxZaUmF03Sxc1z5efe+YPZxyqLjL6I8bqz+6BRmmMEimi1tD3itGgIncPfPurpUBn6jzFMQ==
X-Received: by 2002:ac8:5194:: with SMTP id c20mr3672777qtn.68.1631108403918;
        Wed, 08 Sep 2021 06:40:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 67sm1759261qkl.1.2021.09.08.06.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 06:40:03 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mNxo2-00EWef-D5; Wed, 08 Sep 2021 10:40:02 -0300
Date:   Wed, 8 Sep 2021 10:40:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org,
        Eckert.Florian@googlemail.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm/tpm_i2c_infineon: Fix init endian vendor check
Message-ID: <20210908134002.GY1200268@ziepe.ca>
References: <20210908133416.12408-1-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908133416.12408-1-fe@dev.tdt.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 03:34:16PM +0200, Florian Eckert wrote:
> On my embedded system I use this tpm infineon chip via I2C.
> My system is a MIPS architecture and therefore works in big endian mode.
> 
> The problem is that the chip type is not recognised, because the vendor ID
> is incorrectly stored in memory.
> 
> By converting the vendor ID with ie32_to_cpus() to the correct format,
> the TPM chip is recognised by the driver and works as expected.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  drivers/char/tpm/tpm_i2c_infineon.c | 2 ++
>  1 file changed, 2 insertions(+)

vendor should be marked as a __le32 and so forth 

Jason
