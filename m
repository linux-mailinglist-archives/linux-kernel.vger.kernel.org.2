Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0B542FCF7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 22:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242451AbhJOU0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 16:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbhJOU0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 16:26:21 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D92DC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 13:24:14 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so5078939ote.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BL7U1pxKQ1P/Y+0bevmH2mhx87DdSXQSXmhQt0mxhns=;
        b=IXwypPzlEZXLpnlAWC45zlWGXU/izQQzhW14UKov9bYsg9qkLIjhyYM6HlyrafUIPB
         Hdm3WWF8zK0KY4rZfrhMiKzTr0a5AuJC/R40V+9irfacZHm82kMm7KX/IQMJx+37OuOI
         X2l5BsGextKLtCYAaiGJlkgp9dkRcGbaWS5uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BL7U1pxKQ1P/Y+0bevmH2mhx87DdSXQSXmhQt0mxhns=;
        b=tvQafTrFP397Xsf+1r9VAy8qCTwcKeAYP02YY0SRWhKTBT1zJbiJuTZNyn8ENefgj9
         bcCVi05cnPmu/slJNPJwImvozz036Y9GDsZQqPMcqX1dyrAwBxOtj717LdIdHQUJ4yL7
         DggwGAJohGutmn0YvzIaBNRSB0NacF5l5pB9eq8XEBuN6ef5WMSeJhOY6d+G25SMRK7b
         X0vp7GqEMEYilrN0jJ5zFlQVoVrq97/r3OJctN2DzP98IdhsQmPJgUE0UILdYeCdlh0I
         1SPh3XOJkha5UuQMlgdF76EkhyfAL5bzMpDg2nDm4GyMFDoU5HHny0+8xlqLKDCst+yS
         Iekg==
X-Gm-Message-State: AOAM532TcuDvA2t8n9uWLBDI6GFdn/mOF9heNAvsrm122uAgGxGCwVMT
        ydfsm9eUe0/3uiAz/s1ubOSqfQ==
X-Google-Smtp-Source: ABdhPJzLYjCdvnPQgpS3/OlN4s6myAfrvaU61VZL6iYP/jZD9LoFIYtZZCGqi5/QFLyzNG/gGyMRkg==
X-Received: by 2002:a9d:72d8:: with SMTP id d24mr9341913otk.149.1634329452511;
        Fri, 15 Oct 2021 13:24:12 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id o80sm1419803ota.68.2021.10.15.13.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 13:24:12 -0700 (PDT)
Date:   Fri, 15 Oct 2021 15:24:09 -0500
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.14 00/30] 5.14.13-rc1 review
Message-ID: <YWnjaWkA0rbViQJ5@fedora64.linuxtx.org>
References: <20211014145209.520017940@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014145209.520017940@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 04:54:05PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.13 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 16 Oct 2021 14:51:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.13-rc1.gz
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
