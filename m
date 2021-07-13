Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95B73C730B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbhGMPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbhGMPXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:23:19 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42230C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:20:29 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id i26-20020a4ad39a0000b02902554d87361cso5468963oos.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OXTxS64td+dRNaJgiQPyWrtNdiO2Nyfn3UIfH5CG+aY=;
        b=KmlZrEqjmHz0HYCUzNqlGeXcHOK+W7Beh7xVg0u8zsVrqyQbtjeL7wsJJRamIHSGOD
         hlDNVT9ybaReEmHh/SlEncdB/qorI5iD+Frj2I0N2yjCnQltT8zeTRUQ5s34P2mmWsAD
         RAEFoptcxgZOAXSHQV0m5EWbTJvJEdFPLB+S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OXTxS64td+dRNaJgiQPyWrtNdiO2Nyfn3UIfH5CG+aY=;
        b=pW9gXa6HD1XyAGjPUmptE/vHzHu+F1WaYuSCFoL95DXwyLPR7UcJPYXzVxa988/pQe
         o+3hYgdXTaJDA6ko800p8KX4FOelJFQTS5ynwzxGMceIXoCZhz0mN6FKAQcWWMGU/o9k
         GLEB/vUw6f2kFe2Dw9P9x24x1i7fDbUkWbLwTntUlha+CD0p+CupvfxLy8tubRkAXO+X
         CYO3UlKiq8p5GRL55hMMy4BtGQGx0qFcFiHVzx7Yxisz+Pc4eeYiVlK/0wfoRwLQurdj
         T3CI5qpGb6ceD92JJBwlnGXMrH9jd4LY+x2lnKUbKlYQmIGYYa9m9ySRjuw+vXfJHp9H
         mrTA==
X-Gm-Message-State: AOAM532ErjyXbjclLb4rH/qMgFSxC6xo/9T4ekiJRjlxa7/iurVGmuF7
        dOs0xRPGI5/0Ob4AWzhkNdNgHg==
X-Google-Smtp-Source: ABdhPJzU7ivJvNTSSeTqRwFO8f5nWRaWa0fPaGzACr5C33EAUlzVAwG9cNOBPt7qm/gR+CdWTgb92w==
X-Received: by 2002:a4a:8544:: with SMTP id l4mr3947801ooh.5.1626189628446;
        Tue, 13 Jul 2021 08:20:28 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id k2sm2252469otr.52.2021.07.13.08.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 08:20:27 -0700 (PDT)
Date:   Tue, 13 Jul 2021 10:20:26 -0500
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.12 000/700] 5.12.17-rc1 review
Message-ID: <YO2vOogREHCBrQS1@fedora64.linuxtx.org>
References: <20210712060924.797321836@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712060924.797321836@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 08:01:23AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.17 release.
> There are 700 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jul 2021 06:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.17-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Tested rc1 minus the offending patch against the Fedora build system
(aarch64, armv7, ppc64le, s390x, x86_64), and boot tested x86_64. No
regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

