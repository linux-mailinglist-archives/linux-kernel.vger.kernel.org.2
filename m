Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C303DE726
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 09:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhHCHVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 03:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbhHCHVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 03:21:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEE9C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 00:21:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hw6so20987549ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 00:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zk0yCGi4r/e9LLvJfBDttH3vA3pT29iC5wtMDHsFnhI=;
        b=Gu/y1gR/N5bVT2sjUnGBnBISedvSaO8jO1zbORVDt+181l16GoiDJRNb3almtafKxf
         prS7kDlPqtoTqmapvgc/t6MEl3BrgTJz1MYLX2u5R2KInDMX6x9mFVXI0rzHv+ijgYER
         RKVvaTla/ARDSgLG9t1ggTNoXCJrkP9hCPmvZhD/fGc4Qj6WmGOqmD+7Bh3qpJL4ThFn
         hxfYHf6xtAOXTcytYClzpuXskwYmLWzeWUImmVJ+tNJvEa6N6bqFm2DSeHWFoU2SobWu
         f1PLD0sYwGjfFVd9I78iZOp0010oD4g7gVgLmtN1kNISiGZrSnZTuo9B5YxtYa1lDdVA
         q9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zk0yCGi4r/e9LLvJfBDttH3vA3pT29iC5wtMDHsFnhI=;
        b=l0gH/eXzOnmjtfEzcS0OR+YLStMgYmLcBosnOQPzH5zT9RdltYYAnbWmviRXnpshnm
         vjoQKG6/Vgk2AM1PKfRKeAODs3Jw03gEBx8rjdk+ggxy2Xe0AQmjWQXWE36K/OBgFR37
         rgJ8f1uIldlc8KKIPIAPnvDfIg9+fEx4EDyOU8lgJ/AROBRrdic6p+mGX6OLPMIn++gN
         kXPiRHWiqxDArmv2db8Eg45Nw4BuYggU+5qUPZfgdLhdahXn//GuYBD9tG6bXR2YGWtJ
         AXsXZtQkWQHPjePfK2/HTfo8dbqYCOmjf6ej9tCupAUCD382i8VH6Fw/5tH26xnMEaVk
         oxKw==
X-Gm-Message-State: AOAM531eETloPtLY/FsFzadtwf+pF4Okfu0fmyxak5qEyL3DPBcRapf6
        oZWtQ3Dz5RauSDrSnumUoSY=
X-Google-Smtp-Source: ABdhPJyJp6pv1N3arKVhJ2ltXsGX2o4Aoxf7YbAcMHytQpVOJpFMwTDLyoNtSFlWMI/3bfdtTxUwww==
X-Received: by 2002:a17:906:b794:: with SMTP id dt20mr18676491ejb.363.1627975292930;
        Tue, 03 Aug 2021 00:21:32 -0700 (PDT)
Received: from agape.jhs ([5.171.72.207])
        by smtp.gmail.com with ESMTPSA id mc11sm5280061ejb.110.2021.08.03.00.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 00:21:32 -0700 (PDT)
Date:   Tue, 3 Aug 2021 09:21:30 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: commit c7e88ecbe328 ("staging: r8188eu: remove rtw_buf_free()
 function")
Message-ID: <20210803072129.GA1422@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

I followed the discussion about the bug that was
introduced by commit c7e88ecbe328. But I can't
understand why this patch introduced such a bug.
In the changelog of the revert patch you wrote
that you forgot how pointers work (:-D), but
I think I forgot either (if ever known :P).

Do you have any idea of what happened? This
topic could give us all deeper understanding
of kernel memory management.

Thank you in advance,

fabio
