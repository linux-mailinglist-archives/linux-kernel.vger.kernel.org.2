Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD2938BDD7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 07:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhEUFUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 01:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhEUFUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 01:20:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C867CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 22:19:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ne24-20020a17090b3758b029015f2dafecb0so5368432pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 22:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Anzvua3gZ/WWb98e8ACLU3DCYFYybww4J2rxqQnW93s=;
        b=YQktW8dPbSyzkLCTyo36PDdzleOReUUvFHSjAsMUL6JrqCKoROfNVpwasliZ9K4bNW
         qe0PfpV4Hi67Z7O/oL+pFRgx/X7dw0PDD5OVKm/omRnPWDrIf9Ptuwj7iBq/FUJ7t83P
         hTp40dmgH+MHzQYXpfQ/tCGRZA2ueO7xLEjy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Anzvua3gZ/WWb98e8ACLU3DCYFYybww4J2rxqQnW93s=;
        b=DKlSN5U9K4RK4nrDdtvBApveoVyF0KeUby6su4hFKxNfUn7tl6EOPGBuFANXHL5tXm
         l4AwfhBVhPnP1IJTSWggp0RdsohI2Lvz0rzMr3tE8bn9Cp1CVYx54BG4/1psyzpmgohR
         e4nCOgcNrJmt93RZzq60em+GFM4GulEmBksYahRE3e5nzcZ8beQMl49KEK3aaxv7Ujk9
         F846EFiEVU2Zl8MK6ZWYl+ADmUjsHDDOzGhOqtg0oXTCIsUcY2ZRCB9L8Vp0CnyU4f9B
         TKJRUVIVddAW5YgEPWJbkAvb6gWmLjHn/8qaw1pDyvc2fdQdOvwoE8zdM6u40vrIXO/6
         WEnw==
X-Gm-Message-State: AOAM532j8qpDLRsBqmFc/ANy+8VQBtFEzlGwuFVAwozfOQKpCNHAjeXW
        yWzXV1DminFvxDjQ/bgFE2yrGg==
X-Google-Smtp-Source: ABdhPJyKp4zesPZNjZcrt/9ethc3DB4HpA8JqISKYdC4e2YbCYVeBj7rbeoI384OEJewHfNRkfYHAQ==
X-Received: by 2002:a17:902:da86:b029:ef:70fa:7b39 with SMTP id j6-20020a170902da86b02900ef70fa7b39mr10031727plx.81.1621574350285;
        Thu, 20 May 2021 22:19:10 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:245d:3890:fa95:996e])
        by smtp.gmail.com with ESMTPSA id s6sm7654947pjo.38.2021.05.20.22.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 22:19:09 -0700 (PDT)
Date:   Fri, 21 May 2021 14:19:05 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [rcu:dev.2021.05.18a 19/26]
 arch/powerpc/include/asm/kvm_para.h:27:40: error: 'KVM_HC_FEATURES'
 undeclared
Message-ID: <YKdCyQWqMVChz3Is@google.com>
References: <202105211023.BuU7Y7IQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105211023.BuU7Y7IQ-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/21 10:35), kernel test robot wrote:
> 
>    In file included from arch/powerpc/include/asm/epapr_hcalls.h:53,
>                     from arch/powerpc/include/uapi/asm/kvm_para.h:82,
>                     from arch/powerpc/include/asm/kvm_para.h:13,
>                     from kernel/rcu/tree_stall.h:10,
>                     from kernel/rcu/tree.c:4783:

I think I #include wrong header.

It should be

#include <linux/kvm_para.h>

not

#include <asm/kvm_para.h>
