Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD3838C85D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbhEUNju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbhEUNjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:39:31 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F294C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:38:08 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id g11so14235872ilq.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enWZHbTX+1ralsrB94tU0j8mRNIc2ViVpX6p57Tm5zE=;
        b=sTqvwAiaNQ4KCzK/vupskNveTsjdzDadubdftpH4LLYWoPKuaOdUIo9U1xR5EVxbfJ
         TRLkx3c8jK0PiM4IdWMl2eV+ZvnlcRKceTqZyBzMfE3/Fr/m83BxCdXZW81oUsRMgN9Y
         NXxToywYDx+qZi956HpmR30FEbygoENjpDxQ+uBBvk+G//rz5LQIPbiqGenaIeIpQJXN
         36IGvQRdFdKQx1P7EzP+Sz9hHYxU4fXiyCP5vJshd3WlG6nBK5zk/c3xjwov/fazOHBv
         IS8AM5XuSQqsdhzx8I43U/SEY2vhO66Se9s8PSKLbPqPqbxfceokm87MEZGIv6GMPNQ9
         x9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enWZHbTX+1ralsrB94tU0j8mRNIc2ViVpX6p57Tm5zE=;
        b=CJvbOMd+xQqaIDwEpEbW2+Unw+CoXubHAM2DW9fyJ2ozwjoEMyuILISgGfV3TFAL7h
         LnsWkV96HKK30Ssi/d5amg2Jdnw+lRF2SoSArcwIQza0JPpcSz2ZGU1XnMWIDlw0CG9T
         Qby5AapKVktIKYgqRclFru4OCQe28mwxMooSXibHWFgrx/YkdYeUHktKaCRemEMkw0rG
         QrZC2wfK95wHG+qiAKU+7wMXB+DfOfNyT/cvxerPA8gGFbv+Odu2dMl5vc9DcfA/JbY6
         IwNG66hfobNvRpnzjGWSWYuCQwP+CfzcRUISkO27lRJMmD/rGS8hE/rdrikBTGTALYXX
         RSjw==
X-Gm-Message-State: AOAM533HDhWZk79b8b7c1GkAHYnO2aZvn3sVQQaIZu9YIe1Lj4Tpa6Kb
        e+Q9aE2u7RMM0qFUtYcfBZR/8ZkMDUchOYeOEyqpyA==
X-Google-Smtp-Source: ABdhPJyaUbZvDwXtgI8l9+6HZmWpDoF/OCiE7D7LSvdnS5+eKPt7Yahz2r1YfmK06EAv4U7WFj6Zg7fgKtIaomcv92Y=
X-Received: by 2002:a92:cdac:: with SMTP id g12mr11540753ild.72.1621604287338;
 Fri, 21 May 2021 06:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143011.1175546-1-acourbot@chromium.org> <20210519143011.1175546-10-acourbot@chromium.org>
In-Reply-To: <20210519143011.1175546-10-acourbot@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 21 May 2021 21:37:56 +0800
Message-ID: <CA+Px+wUXfT-agqaHB99nabLXeGxP5UCNRt0nV+wx+=vF=YcXAg@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] media: add Mediatek's MM21 format
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:31 PM Alexandre Courbot
<acourbot@chromium.org> wrote:
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
