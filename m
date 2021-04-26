Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C824436B6AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbhDZQXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhDZQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:23:42 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5338DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:23:00 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id r128so62179232lff.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G1oXQ0k3C+TJ3+pK/S1RsiGeYgBqWj1N5rB2o3PFlsA=;
        b=BUxoyU4CiG9iUane0XR67GRpWWSdf87lIDjVSy1iIQhILWMI3zn4M9c/PriB5DLhe+
         xCBtdkuK5mCMtR/TxvOM1X58GqWMn7eIjzEvaRMSdJM2B2pVV/j/QBqA/s81v/XH2oh7
         wa9+RZi580kYMAhvqA+0g0+Gqy/mPDEpEA8DKQvPtgQHIHgBLOWNGb0SHSco3ZpL7RDF
         vZchyLvdNZxR3U+K1AHKxglHyrOtrfmpgU4FCaSnFOVrQIkSJoiLWOtUoZha4RuESPYI
         rUud5LZCVHgWyhQmNsjfHZUIOpPaegPtpUAYlUH+GdSOqCfMHiF5p93zVD6bCkB1Izeu
         tQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1oXQ0k3C+TJ3+pK/S1RsiGeYgBqWj1N5rB2o3PFlsA=;
        b=OnyXJBSjZPnlSqH3XvJ5w5L/YT7eOY6MT5TTx9Ww851q14TaoFX39SZI16bdHIZmVo
         /v21AHt1npH5ku/FE36CwVMSj4Wqfohav0shGR5EQG9QRRBpb66evBqVbEhxueWdz8CU
         wyvjk2ce0mjqkkzXWTH3IF01ekOC0Q67aLe4/MdrahcOoImmn7h4+i8CmXRWpFiWSOaT
         dv4Fud42CCWC0WCQO4lM7TWNd+dfcp/FRNEwov4psKDHDwIENWQpoPMZ8osluHGdfdu6
         wM/E8eRclwfAx5fihLjQHPPgPp4aqCbSb5sWtPepMCahYSBlfdzzMfx5JFWozDCV/8/Z
         rRRg==
X-Gm-Message-State: AOAM5328C70N9Qry4dUmkYwJ/+wjPNNXHHYnlmGdfFEuaGXe42Wdg1VC
        G723sdK7M9x7SLQEJxJ+9Fy7dsjCZ5ctwSXa3zoSOA==
X-Google-Smtp-Source: ABdhPJy8zGcA/ykwOUiguxWU/qb/3p4N5X3nMypcBT7c7yygZlv8Vts+LYzyw0GJzWUDoxVPNpR0HOGw5gOFrmTZtR8=
X-Received: by 2002:a05:6512:3994:: with SMTP id j20mr13410814lfu.549.1619454172306;
 Mon, 26 Apr 2021 09:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <e67f2a95-4b01-9db2-fe47-0b2210f0b138@virtuozzo.com> <722774d8-d46b-f8a6-a88e-3c56b4968622@virtuozzo.com>
In-Reply-To: <722774d8-d46b-f8a6-a88e-3c56b4968622@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 26 Apr 2021 09:22:41 -0700
Message-ID: <CALvZod4odrSHAbizhxZggk3debNawz5gLph50f=xmJWS66iAwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ipc sem: use kvmalloc for sem_undo allocation
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Michal Hocko <mhocko@suse.com>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 3:18 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> size of sem_undo can exceed one page and with the maximum possible
> nsems = 32000 it can grow up to 64Kb. Let's switch its allocation
> to kvmalloc to avoid user-triggered disruptive actions like OOM killer
> in case of high-order memory shortage.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
