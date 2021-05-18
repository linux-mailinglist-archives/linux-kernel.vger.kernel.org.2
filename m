Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9E6387B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhEROo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbhEROo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:44:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450EFC061756
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:43:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g24so5621168pji.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PDDjAQxR5YHDKeoXEoU6CBD/UdRBnwhueJQ+IO7Oa+c=;
        b=BeagsnSWZ3B+AFYGz0mTpWBDbs5hk1PNAI5gKYREw9w4Uv0kSnfsG/PXa2YLJi7YKm
         C2PD+R5KeVMeBXAuuatnXPfghphlcGR/vf5IKUkcE32iH8qZ/PvHCQjfQVgRwkpg2ShG
         RMgnuXKLKy7JZ60Kn4zNwnSTSPMnf19YqPheU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PDDjAQxR5YHDKeoXEoU6CBD/UdRBnwhueJQ+IO7Oa+c=;
        b=Zj8km8rBwk0uhDq+EVR3IyPHoBw+eYYhF3PpTZ/wOl0nB6BkGiRx43r6IDioMVjz1h
         JKQpyfVdMLCRnGn06/CB5lw6K0YxqRr1JXWo3CTKCdixTHLerQeB+ZGODefNVrw2+SM+
         r8zo60xY/PBETUZ04DT7bSIwNeYclUMOogywzsj6OoiZpZQciTafMd4vQgEqeV22Rlqr
         AuR/mvypVVieeV4OBRMNEGX+S9dLyxc3do+opAHrJARf1OD+alkmP7ht+EXlruLxNrjk
         nw3CFCupoDIn3F0dl2pJwxsdv7CqwgiQiVAm+GLyiyQgTdQI+lUmz2Sy5huDmMgAf3I8
         r2gw==
X-Gm-Message-State: AOAM530HAUKNL++nKvkAP3Vuh4ESiuMK/+O9utIFRU8F5awaTUDu5Dpx
        nwIYDbprRCkGZNbwfegSOFD78pwDxrDNd0wP4Zo=
X-Google-Smtp-Source: ABdhPJyjsCiUrz25zqnCbsfCy6jzEVS99dsbelq4TUGjGEr+RAB7ZdHcFrzUSNMQHUnDYCc7lQAoxw==
X-Received: by 2002:a17:90a:6446:: with SMTP id y6mr4229405pjm.135.1621348989821;
        Tue, 18 May 2021 07:43:09 -0700 (PDT)
Received: from e07e318d3c06 (110-175-118-133.tpgi.com.au. [110.175.118.133])
        by smtp.gmail.com with ESMTPSA id y190sm13610030pgd.24.2021.05.18.07.43.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 May 2021 07:43:09 -0700 (PDT)
Date:   Tue, 18 May 2021 14:43:02 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.12 000/363] 5.12.5-rc2 review
Message-ID: <20210518144257.GA41@e07e318d3c06>
References: <20210518135831.445321364@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518135831.445321364@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 03:59:03PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.5 release.
> There are 363 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 20 May 2021 13:57:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On Tiger Lake x86_64 kernel:
- tested ok.

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
-- 
Rudi
