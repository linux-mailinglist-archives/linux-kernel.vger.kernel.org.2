Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D97E38D056
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 23:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhEUVzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 17:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEUVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 17:55:28 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B20C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:54:04 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so8178469otk.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kpSHAlmTyjqKXjNreeX4RJ0R5RIyCqOKxM6y2NS9SAs=;
        b=VVaU9yY6bmYNivZITKipdcM5HIYIvQljL5VXEGt4jw1uQL7iqpraXxJ5ogFhgee5GO
         NtnH4rIelCYDSLW5V0MHEfFop8ZmvInuc8IfFYoWqc0/Q8BBKj8pT+EJ6aLucswemQdT
         kPkxv1qK65KjNLbc2M3O9bDlAU1ERET2RfAUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kpSHAlmTyjqKXjNreeX4RJ0R5RIyCqOKxM6y2NS9SAs=;
        b=ojOUwBpKff9QWeL8F4JQzHpS9XnbsrVNY7RFwf6zX/TYVbuTRNkfo+5Udr4sR7dXJ7
         RZjM379dIx6GH+rlqKsxmBVWtjrmtBftrgEeIiI/I8FYP4DV7oVjTCzbJEk/kKR0A06B
         P4B2S6/6d3xvAHuy5nKfdWlbQOUzQ2rOYrHgRtSvL/u8Mik1StivWb6a/kFwZltXxTI0
         XXohxEtXSl4l+LBYnf1dOwxIgqlWl7whp9Oa2gNmXQm51eAKVXWuMnMw5n+31dlYzB4G
         CDfAD3wJbsiPZ8yNAObyRtGf8YhRLCkhljvCz3LquA+qtwOvalDSdi+rKwEFOLQymfjg
         M39Q==
X-Gm-Message-State: AOAM532WE5ggtVTEmZRLbcJscot7wAgEAaF9absXT7unScBFJlBIF14b
        nxnvt/EoGJTdav44FD4oRc0xI6JEiRD5abjd+rA=
X-Google-Smtp-Source: ABdhPJxbIZJIy8DuURbkyPXiN2n+KRgE3x9INfSMsUnZICAfbdLyfhXsmbHUS1vhSkWsRIhzW/t0Uw==
X-Received: by 2002:a9d:7e99:: with SMTP id m25mr10151099otp.37.1621634043496;
        Fri, 21 May 2021 14:54:03 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id z15sm1559562otp.20.2021.05.21.14.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:54:02 -0700 (PDT)
Date:   Fri, 21 May 2021 16:54:01 -0500
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.12 00/43] 5.12.6-rc2 review
Message-ID: <YKgr+bK+sWypjxS/@fedora64.linuxtx.org>
References: <20210520152254.218537944@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520152254.218537944@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 05:23:29PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.6 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 May 2021 15:22:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.6-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Tested rc2 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
