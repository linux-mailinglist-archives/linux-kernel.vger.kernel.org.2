Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EBB403162
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 01:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347528AbhIGXHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 19:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347391AbhIGXHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 19:07:15 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B65FC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 16:06:09 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so376712otq.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ssdy/49Y1SfO8KzYgEh8loJoMAipYlwTluSbNq4/9Mw=;
        b=Ch5GvAZLEnqKFOVujGnZnFcH/9qKiEB/1B2j7J27fH6R7fpS8X3NaQL2EcuxeHH3Mg
         CaTghjHIZ0aWaZUhz11vg7yfJW6dNbjSOPpmmvkxwHbk0FZgya+6EVFj0Jfb0Rrke9a+
         32EGy1jinID+/nz85YH4LmVC+V2FrplNbqSHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ssdy/49Y1SfO8KzYgEh8loJoMAipYlwTluSbNq4/9Mw=;
        b=RclXTWbGAH8BmPdJdD1zeS3OBcG9Kfex4RweBveZYoSpgZX33fL+HXswa+Z8gXF+z0
         nfGEFSik4qA69yms7WbsHvBCEC5T+F/Z9inLsMW91Gq0IhvdKGBbCFwi3kYX1/6lhGO1
         6W+A+mMq3wdlFScJcvnoG3uuqR/jV24t5nYewXcMpXXSvgfPQWj6U3RjGdiZXSvGIqca
         jyTDJBUSwTbkYIjz6n33UOztEsowIW4V40IzIcb1sPIxSSmyzyHU4DSeP2xE0jj5c0Rf
         pYzzugkA6YfIF568ShTcLq1tiuvP+TKWCzKmZVMUhuV7UKMWOHjjeWJdMQsuFWTvHlAj
         CeHA==
X-Gm-Message-State: AOAM5313xLB29pX/Mwv4BqMYlkL2DW/lZioNYSwh7pi7Xu7AyFPQ93gW
        QpXJRDa6hLZ4WzfHchmSUwrCmA==
X-Google-Smtp-Source: ABdhPJzeOKRgzSKpfuV5HY2xzJg/+whtqTqin1haumICgX//KgJeXo9laF4OKYeon4fJDuC4bsEfWA==
X-Received: by 2002:a9d:6192:: with SMTP id g18mr661707otk.314.1631055968387;
        Tue, 07 Sep 2021 16:06:08 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id x1sm74198otu.8.2021.09.07.16.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 16:06:07 -0700 (PDT)
Date:   Tue, 7 Sep 2021 18:06:05 -0500
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.14 00/14] 5.14.2-rc1 review
Message-ID: <YTfwXTtNs6yDeJny@fedora64.linuxtx.org>
References: <20210906125448.160263393@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906125448.160263393@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 02:55:46PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.2 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Sep 2021 12:54:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

