Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C7C3A6FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbhFNT60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:58:26 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:38414 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbhFNT6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:58:20 -0400
Received: by mail-oi1-f181.google.com with SMTP id q10so11396260oij.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BdsuCVLPpNnrbfSL5g/fk2xq3euV/Wu/9eio50TshnE=;
        b=T/oPQiiell2DPwIJdWKES1xG++hgYrUOK81mrtGVnRXUz5VdsezVRq8PBMkWrGKbkg
         xorhUMkXhM3F8qt1XVUPc6ut7wVFm3FHpwbOJpORMKi2dMjBobIsKo0iuUdtD1f04zs0
         uuusL7lDevVzbUbDLvXemhhrRTAyyRD45Td2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BdsuCVLPpNnrbfSL5g/fk2xq3euV/Wu/9eio50TshnE=;
        b=fzyuqH3FLmEWJkttOYMY+OgsQvzxq1TcHpyqy5PErPLZOWv7xwW7vg8ojyy+Rxl2YF
         rvtT74WrIX2Y1ohaXd6U3HLcz5aAR5LU8vK9pm/w3Rz4F7Dj0DXe+mF9t38so9V7wWqB
         HcSC2G3sWLzFyFRf+KD9gKH6WtCkeIa87dmrmVIkKikqQtiKj9s1qymeJgRybYNB+6/k
         ZZGzaX7lRLv5bacrgY0lZ0zY39W4cGyspwh42zxXPJNc5MIM64UdX74usbuh3P25lNds
         6tv5Dqew4uUwDeQPOEuNvHbiSgEIHCocAPVJXaLgfmBhXZ6C41jPFPq4uvQheYujUHa5
         n7+w==
X-Gm-Message-State: AOAM530Lhg1c7IUvaMlIviUxSbLv1ev8dodVzWAvnjo9xqogyDR8yCab
        HDJh23NTdSK0nMCVWt6gegUNDA==
X-Google-Smtp-Source: ABdhPJzSK1Kj3WDX6aM3YbJOM/qfoCE81ZytiUducyHuOzTNvHGdtvc8kSPsBdS9ntylqPc9SG+FTw==
X-Received: by 2002:a05:6808:1287:: with SMTP id a7mr7641701oiw.88.1623700517132;
        Mon, 14 Jun 2021 12:55:17 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id a74sm3121182oib.21.2021.06.14.12.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 12:55:16 -0700 (PDT)
Date:   Mon, 14 Jun 2021 14:55:14 -0500
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.12 000/173] 5.12.11-rc1 review
Message-ID: <YMe0IqfoComs9ok6@fedora64.linuxtx.org>
References: <20210614102658.137943264@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614102658.137943264@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 12:25:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.11 release.
> There are 173 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Jun 2021 10:26:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.11-rc1.gz
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
