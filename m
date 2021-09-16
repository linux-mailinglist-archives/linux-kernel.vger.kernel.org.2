Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B29440DD73
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbhIPPDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbhIPPDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:03:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79C9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:02:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so7735550pjc.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M5gCAPaE/nHrIFIMvVnMeDjexAdTXhnPwO4CaUldM2U=;
        b=AXPEzyMsoeKkXnIeuO3aKLdV380ynzj0wjkkBcMKa64PWMTFGgcd4SAuB4RindvZef
         gWMqJKMhSivUCnLc/SliE8Cgmk5gga5ZBQX7XyhbhJXgXhlbqZH2f6jjOfjP9SFsxrrH
         GBlVMUuAKUUmtMvc9MUtcYb2zvS6lHpK3TFwMXgc0N9bqlcYEGqVwmHdmC7N+CBCpTUw
         GxPK4P4Ex0CLNokyvtPtjSZ/iddeXO1QfMTfdKOSEtIVu4VXBHP2VlKZNbAVpxu093a2
         MnkGfiezqroQGVmGQEBRokgaFHmw+hcjbnMvbMtPi2ZtjzZYC99Vrj0aaYm5Dp7w/zyj
         Lyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M5gCAPaE/nHrIFIMvVnMeDjexAdTXhnPwO4CaUldM2U=;
        b=5n/oTu2eW4H/KI8/DAHFcC8nvalX/GHuY4TniLTNHc4u6CdaChVBcNCn2Uc3TgaQoJ
         wRLb+3zwSsj9d2zNUzhz6dT/SjH6xVdd6tnl/GiPGrtuvn/UhSpPY6RIYz1I+90DmyQx
         UU5k/OhIqUKn23SlVh6JeYJHPg+tNG7LmMs+FKzFU0N6ehZnipNV2pUFHN4j3NsJCQRX
         A0zCl1mIp5uG+zyT28Xmy6tsn/ET70dcpXdwyZW5QDLhMFTLEFUNYSCBRMj3cojsNwUJ
         8BnwXfbHTwdoywEqIW3QsWy80RXv1SFmSFFZJmtJ4EMC2FjNpDKN2amDW07d7IafoDCk
         simQ==
X-Gm-Message-State: AOAM531aW1ovG8rvTK3fxatvC/L8XSEVsQpFeHLWegak4UUR8lgQie12
        PSwz7eNSc8riDYnvhPn8JofAdg==
X-Google-Smtp-Source: ABdhPJzuO8ZoSlxjBw3iUE+pOwMT7sUg3TGSN+4o07O+LFuejXU6WahFODS1gxWoLYIMPP/5Byevrg==
X-Received: by 2002:a17:902:6848:b0:13a:4ffd:202e with SMTP id f8-20020a170902684800b0013a4ffd202emr5105920pln.79.1631804521218;
        Thu, 16 Sep 2021 08:02:01 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id p4sm3286640pjb.11.2021.09.16.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 08:02:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mQsti-001mPG-QU; Thu, 16 Sep 2021 12:01:58 -0300
Date:   Thu, 16 Sep 2021 12:01:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: Build regressions/improvements in v5.15-rc1
Message-ID: <20210916150158.GM3544071@ziepe.ca>
References: <20210913070906.1941147-1-geert@linux-m68k.org>
 <CAMuHMdWHDOC2WedHfgYh2nwijEsqnb3+LXgHwST29TaLugiTdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWHDOC2WedHfgYh2nwijEsqnb3+LXgHwST29TaLugiTdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 09:20:44AM +0200, Geert Uytterhoeven wrote:
> On Mon, Sep 13, 2021 at 9:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v5.15-rc1[1] compared to v5.14[2].
> >
> > Summarized:
> >   - build errors: +62/-12
> 
> >   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1859' declared with attribute error: FIELD_PREP: value too large for the field:  => 322:38
> >   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1866' declared with attribute error: FIELD_PREP: value too large for the field:  => 322:38
> 
> Actual error in drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> 
> arm64-gcc5.4/arm64-allmodconfig
> arm64-gcc8/arm64-allmodconfig

This happens with v5.14 too, so it isn't a new error..

I've got a patch

Jason
