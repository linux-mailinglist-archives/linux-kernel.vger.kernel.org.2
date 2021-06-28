Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5EF3B6B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 00:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbhF1W40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 18:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbhF1W4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 18:56:23 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A37C061760
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 15:53:57 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id b2so21565828oiy.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 15:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rr1bcrOTj/SNH6tziyoMD6z6w0IADqp9gXAqYDjQMg4=;
        b=DCTBseaeSLHE7th2AlqqpTk0Lt7zBLWwXPEKXHpu+OTlBYaVozbD0bvZ/4z/pB6L1F
         swUruEVE7K5Ekqwyoj0j3IydXYPVu9u9SJ5b0F5orzaZUCoRze07tDHz1f3Qkx8dgLHn
         D77UyL88llWptPiEgjri3kvJyXHTBsxZmNLTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rr1bcrOTj/SNH6tziyoMD6z6w0IADqp9gXAqYDjQMg4=;
        b=OpFtTNrBM2Zz0aP5y95n6kjg8xFXsmH9dmJCJBjqNtKGylekDtiMeGshI6B/nPJOjb
         UFleJdezfeCcU6tfaE7v0AWbihD3fjcytEbgrFUr/kmOZ84A3kST04guAc80ASHTXuMv
         hCSjt7k1fc9+e2ObdofYR2b6by9TMY5A8/3E/A5ClH/06oKJq6E2dAz7ugRB5D2A5LfM
         y07vfhp6tXOy16lnKgaJhpl6n4EdoT8JSx5ChwRhxCD+QD7cWKN9Yhm6QRKU7Npk5xf8
         eCi7XYIyccmrQTf6BeXa9WEi6RU7RLwRQXWzyPmIHM/Gwjn+GcFHG/ckoTqidMYH5v7O
         hecg==
X-Gm-Message-State: AOAM531v7LTKM9sdL/E4BpX3MtoXAMN9bdkrSZudIOzU8KncYOBir8wU
        6RebAxkt/VGpAL9CD7kQySmmZg==
X-Google-Smtp-Source: ABdhPJwT8+NjGN2iAbfQFM+IsXjjmrnIy+ka72R2OpyVEshq2TmRGm2zuOKkPXxvbzHHxMWw4/AYKA==
X-Received: by 2002:aca:fc57:: with SMTP id a84mr5462646oii.50.1624920836492;
        Mon, 28 Jun 2021 15:53:56 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id 186sm3224149ooe.28.2021.06.28.15.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 15:53:56 -0700 (PDT)
Date:   Mon, 28 Jun 2021 17:53:54 -0500
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org
Subject: Re: [PATCH 5.12 000/110] 5.12.14-rc1 review
Message-ID: <YNpTAlyLP4wbixpF@fedora64.linuxtx.org>
References: <20210628141828.31757-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628141828.31757-1-sashal@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 10:16:38AM -0400, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.12.14 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 30 Jun 2021 02:18:05 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.12.y&id2=v5.12.13
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
