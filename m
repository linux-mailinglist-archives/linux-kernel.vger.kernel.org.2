Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9FD3AC5F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 10:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhFRI0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbhFRI0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:26:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99749C061760
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 01:23:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v9so9778865wrx.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 01:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rmQ6WBzoGVhtUeA3zz6XybkQWUIie1tVypqrqYDVKQA=;
        b=EGZzsFlkLoWIi5ibSrG+GHza3c8d6tzKH08N/+1SAj20rpjh8y/ms2qSTM65IISQuD
         PdZAp01iW5y25lsTkqok+e7Kjx4DIbYy4FyspANDB1AoqJEoPekMN5UygjhdlK9Ol/4g
         NfqAF37g+lrUoCK4I1tyhu0gemIJx/zWJTGZjNdKIjkc8ZNPSDO092NOmCcHcwO82YAC
         vzmjHyVyTfz+GzVqh6m3vEAOuHqno+KDm3g5JCOnIov4xYcFAUR7CDDeQp6k/dHXAVVH
         M+PURuJtO50NYasWUoBFqAtiKR9y+rQlYP+C/R+IsdUnSNTu04zjbn/6n+d228V1E8tY
         rm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rmQ6WBzoGVhtUeA3zz6XybkQWUIie1tVypqrqYDVKQA=;
        b=uJoWphJdGohFhm4KpftIkZ7/8OdGDvSdVaNJjqx/WRdxx2SFSJgWmOkjrDY8f87mXj
         NGu9uUIsC4DOMp5j55IcbRPr0UyN+V4bDd95CscphZuI1WVKZL8SUrokqMX+vOcz0AfX
         WU7S7rizi2LTarUTawyHdPgI8go7A/PZJoEbLfObH7yzJbXaEWXQ242iOE1Vt+TmeuY+
         oIpM1BDYomXKfbVQ4UHPKeQUVRqZ+hR78DWJha6vW69vw5RDvTHxJTKFeyaELPNWYNt8
         8XcO5Zu5X/kT7y1JvVZtnbcmbH8XpdNlXjOivlzzosoar5aeOOrSqz6GoJq5+7uFe7xR
         RGUQ==
X-Gm-Message-State: AOAM533knXhApub73fR0wtD4qck+HX6ah4V5S4WM4K938xrSW1XwdHQP
        HGClcVtczqWFEjWmHq8ZF4KwtQ==
X-Google-Smtp-Source: ABdhPJwwv4MjlcpmpDwK5BWwm6nCOzQ2kfK3F9vK09ohlA10+038mjZpaNDZsUJpJmscpesPur8ltQ==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr10989472wrt.209.1624004631254;
        Fri, 18 Jun 2021 01:23:51 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id n7sm9758380wmq.37.2021.06.18.01.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 01:23:50 -0700 (PDT)
Date:   Fri, 18 Jun 2021 09:23:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: KVM: Bump debugging information print down to
 KERN_DEBUG
Message-ID: <YMxYFbuC4Ka1PNDb@dell>
References: <20210617073059.315542-1-lee.jones@linaro.org>
 <162396615830.1467937.16143448603491809431.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <162396615830.1467937.16143448603491809431.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021, Will Deacon wrote:

> On Thu, 17 Jun 2021 08:30:59 +0100, Lee Jones wrote:
> > This sort of information is only generally useful when debugging.
> > 
> > No need to have these sprinkled through the kernel log otherwise.
> 
> Not sure why this has "KVM" in the subject, so I replaced it with "smp".

Mea culpa.  Looks like I stole it from the wrong:

  `git log --oneline -- arch/arm64/kernel/smp.c`

> Applied to arm64 (for-next/misc), thanks!
> 
> [1/1] arm64: smp: Bump debugging information print down to KERN_DEBUG
>       https://git.kernel.org/arm64/c/cf814bcfa1e6
> 
> Cheers,

Thanking you.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
