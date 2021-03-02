Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC2B32A894
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351934AbhCBRul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574580AbhCBPQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:16:43 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC74C0611C2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:15:54 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k66so3126363wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=58mM+iNIpmtGx0uHuLvmdthTB7Yp3r3FASJT+Kdp9fU=;
        b=I970pbnExNgljvwoPCZHsr/iXTJJV5dc3Ck/R3Df5L/UTmmzkv2ipxFNF2Uo9+asZV
         F2ZS3fiXavIcgQaQmt2zqiPFnzd2DVReeRUr64eWVMMvEzA2/qEpyEl0vJwBTKlP2fI6
         uTUv1bxSHDrqeYCRB6dalKcmn78tqIx9rUhJm4KneVcEn1gsEyFIizAEfdMFoyPvObXy
         dY5HQ/FhWOwGcEoE03bH5dbOupUnaFM+Y2eFC7rkoVir7EP/sGBCIxZBKPT7sdp5/NtK
         CZtT2txJSX0bnseZZ3iHznGbe6K9JqfPddeecmQLYvfThDePGW3KIXb9GayBk/wGCDYW
         R1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=58mM+iNIpmtGx0uHuLvmdthTB7Yp3r3FASJT+Kdp9fU=;
        b=EwwwTcQCkWGIUIYg+qnGZlga5T+WxKsgrZpYJcVKS1w9ofqTT8OTrt8DEBCVDcz060
         hy2zVOoypwcIZfVT/+oNnhR+VDXIr7p3TUZx4WhOieECj17pyPTsuhVBaRHMbcPwjL/Q
         1PcahDWIN0WDWh3FMjT3zuA59dpbz9aQVMqx476or/QbyqNboYC/Qswg1Pj1SlTc4roh
         CwTF8/1mx6o6J4IhUiRJCPqVsnLrEJO/1mld9EO0aSkrmQec6mxY9k43/uYF3vMIbmoE
         c+ypZXpW9OlRrtJvnRpzei/gZruuenx99NrPuAOUDnrT7F5sd8Hl3aKIkga5J78heEQC
         xkmA==
X-Gm-Message-State: AOAM5329FQ7cQa9Hmi5sJBTHjaW9T5VYrSNahNPd5clJ8CAuy0gKRhVc
        jy0AERJPjN7+i7/NnGuAug==
X-Google-Smtp-Source: ABdhPJz5zmy5GeQo7ONi4+1Wpwcs7UdpR1DaPXw0WBFTxebI8BlU7CQ+gn/ekVTQu7oLukszsAf3yQ==
X-Received: by 2002:a1c:6a12:: with SMTP id f18mr4650223wmc.31.1614698153729;
        Tue, 02 Mar 2021 07:15:53 -0800 (PST)
Received: from localhost.localdomain ([46.53.254.123])
        by smtp.gmail.com with ESMTPSA id j30sm11690839wrj.62.2021.03.02.07.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 07:15:53 -0800 (PST)
Date:   Tue, 2 Mar 2021 18:15:51 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/11] pragma once: convert arch/arm/tools/gen-mach-types
Message-ID: <YD5Wp/ok7aFY7Ff7@localhost.localdomain>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
 <YDvL5H9BLnLYuI2q@localhost.localdomain>
 <20210301101950.GV1463@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210301101950.GV1463@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 10:19:50AM +0000, Russell King - ARM Linux admin wrote:
> On Sun, Feb 28, 2021 at 07:59:16PM +0300, Alexey Dobriyan wrote:
> > From 72842f89ae91a4d02ea29604f87c373052bd3f64 Mon Sep 17 00:00:00 2001
> > From: Alexey Dobriyan <adobriyan@gmail.com>
> > Date: Tue, 9 Feb 2021 14:37:40 +0300
> > Subject: [PATCH 02/11] pragma once: convert arch/arm/tools/gen-mach-types
> > 
> > Generate arch/arm/include/generated/asm/mach-types.h without include
> > guard.
> 
> The fundamental question of "why" is missing from this commit message.
> Are we making this change to all kernel headers?

Apparently, no. Linus doesn't like it.
