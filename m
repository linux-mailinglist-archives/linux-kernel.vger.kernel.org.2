Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC19731C123
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 19:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhBOSHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 13:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhBOSG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:06:59 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71910C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 10:06:17 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id v62so637058wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 10:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CxYS3P9SksRVrceYWOsXjeLu679dqgOchscAR5Fe44=;
        b=aD7TD351QhJiejcXA0i32u7uH2DlfVign9OID+e0dMlErIUZBkJ7E+y/Bd5Xz4bYGe
         +1FIFXfHIzBUX6ScWxsCN8Nwt+S4U2tDMlfYL97bKwP41CsAHM3bWvf4dnZdwyF0lQNf
         +E3EHPZWFxIbHqEdPPFkn2+B0ygaXFI8MbX3eb0oQpkuQ5JhX0h6fuhWEQQH7IQ/L9wo
         k1iyfbpMpPhaRVdB/LmaMLlQkdhqUSDzdZXAv55oqY5t7dSMtENQzPrLkAW3FHzY5DSv
         d1v4z/0qAC9heGkuWH5pOyBUnzDsWF6WrpNYdQT1jEZYNQTs1qP8V5sH69egR4c4rXEX
         3XoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CxYS3P9SksRVrceYWOsXjeLu679dqgOchscAR5Fe44=;
        b=WRj2Zra0K85eciMPu8e7V4n0GJCiFMhde0s9Vx2NoFUErFSfFSKV3aniy0Z0vCtKSw
         kZxlo9rIN5hEZFkwvXBp/dvJzoOGp0G1DJatznsneS6ZuBZZTyPNIizKT2/ehV8sBHXX
         qdvEVkVrslG30SOMUiKR/zRhfkIi20yoi3QEQ0DEC7KiJvtBHafIQA8uqiUzgTtEnau3
         IElYwMYi3NzCUdVZaC6XnOoyN4C1g+VqbtpN32Mk0sFmWErfCy0PtWEy1Y9Zn26s7Q8J
         XK+xB8G9m+F1kIbNx49tFlwAHUr7/OMleT2JVjaqnFFHRjG+DJLM9gL1bA3OqC3SzIEK
         29AQ==
X-Gm-Message-State: AOAM531DxJ3CXn52simVxhYsxv/i3/sFCwfwki/ovfWZ28rjwSwhCqU5
        3oroLQ32hkGKleOF4H2ZDEfsMxMFYF5mjc8PNpaOKA==
X-Google-Smtp-Source: ABdhPJwmxlXY4onTd+md9ptwF42vC3xoX0zilpnQWLOublCpkjBbDIfNLOxkIlp7x4N65OU3xrpj20hFK9JssDDp54k=
X-Received: by 2002:a05:600c:4857:: with SMTP id j23mr90727wmo.31.1613412376258;
 Mon, 15 Feb 2021 10:06:16 -0800 (PST)
MIME-Version: 1.0
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-10-git-send-email-anshuman.khandual@arm.com> <20210128171822.GB29183@gaia>
In-Reply-To: <20210128171822.GB29183@gaia>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 15 Feb 2021 18:06:05 +0000
Message-ID: <CAJ9a7VjBnpEgyhfewFv48Vqrde_XUihdyWMQ9tC5vfxGozMQ_Q@mail.gmail.com>
Subject: Re: [PATCH V3 09/14] arm64: Add TRBE definitions
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linu Cherian <lcherian@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jan 2021 at 17:18, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Jan 27, 2021 at 02:25:33PM +0530, Anshuman Khandual wrote:
> > This adds TRBE related registers and corresponding feature macros.
> >
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Mike Leach <mike.leach@linaro.org>



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
