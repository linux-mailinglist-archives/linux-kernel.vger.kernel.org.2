Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561C33AA68B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhFPWUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhFPWUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:20:35 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A403C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 15:18:27 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id x22-20020a4a62160000b0290245cf6b7feeso1079335ooc.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 15:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tflQamYotEMMY4iyVpYnVixyOMyvyVjPnxacDH10P44=;
        b=TkgGrXS3is93kbsdDGEq1rdddVweZIk2GFi0kzkIqrmNGT8TGE3iMTgCnZUXCgNA2k
         SpSE1gOtOTZEh2NtB4ZolEyjSFZ7qSDL7XZ5sVGomU1HCQk+oFjcKalBxV6bv8BKz9rP
         U9xn4M8A/NWzWzn5zJgdXw6carq1kxdR+vhwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tflQamYotEMMY4iyVpYnVixyOMyvyVjPnxacDH10P44=;
        b=WpfJoU6CXvg39HfRCroMW201VKVaCsnb0+sIjcputCYXZ19fSTX50tOzO4OBbOi82X
         2SnCvBA46NOQb/qKTMd8fYFI4rlLN/EeogjcmWfzYFl6pFFYsld1v4ERmiLcwp2vHeXZ
         vwW+dz0EV0k6qvcLuTpf0/XZXF2lNy/4toVNu6LedLr5GZdGk1CE7r4+s1KynCIYhqn8
         nJBVvynmYm3wUu3Y05IN7NXj9LiJFvxj4ZJT7FDYcOvP/dYjK0ZmoKcRlARKLAaFR+HW
         kOJqj7Iy/NTBhaRrxspjPBGS/9JX53GMhaa/AGKNoQIuvlaH7BT8G51JGX4HLwuQhMOM
         jrHw==
X-Gm-Message-State: AOAM532v16TqjQjmvyWyg1IkirTmPm5ijJdmAa9tfOMxuLajiKmSMvjr
        07693pw9DrFkTLfQ7eehBsV4Wn6kZAkWYMNX5j4=
X-Google-Smtp-Source: ABdhPJxyxw2TQ+fTBSNsIXpKOWzzM3SBBJJwgolQz9B0ChaT4gL2wen7bUQ4mAGwO/PWV7ASDEH+Ng==
X-Received: by 2002:a4a:e6c7:: with SMTP id v7mr1830336oot.86.1623881906711;
        Wed, 16 Jun 2021 15:18:26 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id p7sm850944otq.9.2021.06.16.15.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 15:18:26 -0700 (PDT)
Date:   Wed, 16 Jun 2021 17:18:24 -0500
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.12 00/48] 5.12.12-rc1 review
Message-ID: <YMp4sEJHQfcXiY2t@fedora64.linuxtx.org>
References: <20210616152836.655643420@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616152836.655643420@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 05:33:10PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.12 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 18 Jun 2021 15:28:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
