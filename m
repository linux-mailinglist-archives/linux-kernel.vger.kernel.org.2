Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7187A3DBD61
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 18:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhG3QyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 12:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhG3Qx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 12:53:59 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5754C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 09:53:54 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 48-20020a9d0bb30000b02904cd671b911bso10192078oth.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/zz8SlCDjP/5EQCBECZsztr338jbNBe1TGYsR7QJMKI=;
        b=H2+fZMiUKFckMowCPbbNdkkTnbf+DqEQ2E7LMQHDSzMS/LM7xqhmaTLGbvBpVP6Avy
         Sm6DSNPHfTMLatbrXLneDunGFY19kbi69fX3hc8mwxZgAt3g9heVtXmSqJD8upr0rKDP
         PVnFPnpygQocQIjWrFHxpPWU2qT9xRwxnY3Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/zz8SlCDjP/5EQCBECZsztr338jbNBe1TGYsR7QJMKI=;
        b=Q9uVnfVNVRbF0rD6IrSI4I0Er/tJZO/dOkcqrtemtXQouFFiw0tyXW4bGGt6TZJ9vN
         LfeOA+8MDXzzL3TxVKF2RTc8UQXQJdrt1ysPK91f77LNk4cziw5fFXD2YrUE4vTa9WPt
         BRsuK4PdLvSQwpnlnaFtjfRo0WFUHs1PisPJrkTAm1KGj4TivoVEBs7i7rS76ojMsvpy
         wxSh2DjMDdTs1BMQ3rVHZFW2iAAVegdJCOIXF8WIAXwQRwba0mNt5wqMXhG0j4bj0zFH
         84VdGJvoZdVRkkcYdDvveSPaAHWsLn+4xElK/N7SpfTthLCuWS89iwE+MhbRot5YrPx0
         B8IQ==
X-Gm-Message-State: AOAM532Udtz50Y90r9MRB42AQm99lP5gHw3Dk6bDwWMU0IjA5ou//s2f
        uRkN5k68lIv1y1M80ffnwJh0Kw==
X-Google-Smtp-Source: ABdhPJwkjqlRmT9N9mjzp7K74H0hjjP+/6LGfLhSwRRdMevLvjjU2udtdo7p3yCMPqpFk+ppVh8dug==
X-Received: by 2002:a9d:628:: with SMTP id 37mr2343240otn.126.1627664034228;
        Fri, 30 Jul 2021 09:53:54 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id x14sm374703oiv.4.2021.07.30.09.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 09:53:53 -0700 (PDT)
Date:   Fri, 30 Jul 2021 11:53:52 -0500
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.13 00/22] 5.13.7-rc1 review
Message-ID: <YQQuoEHcxtZdxWLT@fedora64.linuxtx.org>
References: <20210729135137.336097792@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729135137.336097792@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 03:54:31PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.13.7 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 31 Jul 2021 13:51:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.13.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

