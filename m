Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DFF3D6DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhG0EqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhG0EqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:46:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2D2C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:46:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d17so14336325plh.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQui5Bn1AetwvRytXDb4JDYFQOZL+N4GRQAdei53URs=;
        b=Th5t3G/Ufa2Ob7SpZUUyIAqxOzwb4tOZFM+k1JoB0DhM88V1pL4Yr0MkoWzKCRp8OS
         tqH8uIZnwJTKC1IkFWUfKxGxMcqRPyUn6Tqb4bCPhxgQgSaqQuyODZ7itTLs/L8/O/AD
         F6uVySNBTaE7l2hLFTzeKgys751X40fDx1XBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQui5Bn1AetwvRytXDb4JDYFQOZL+N4GRQAdei53URs=;
        b=M1+EQQAZZSahzYcfDz0/qXm6ZVd0P+MIe/YgbV+SfU37KI6JbXSsf6ip+BTsdh3Wh4
         gBGR+zQjc90LQ95OwRVD6F6JxDJw0wu1nO8YhsG31EEONxV3AzPtPUeddKKMysRQ0HmJ
         4kSiA4KqGZtPvDoBSG7GcKVBOUHgDErUOmpcn4g1OovMDd4XUBcTEK77emBzJ9RCOB/A
         HJam7pCRcX5iBzIm7jqv/6dtAbVWQ9cGNS8zXBJf7lHayVKWjXKOhcVRlwG+f34aQ9yS
         r7eVTmmlCJkbIWQzP6dZHkWq7qWhl0+dcDeza2zfzK1xEkpbPTXut0pRkMNSULP12KjA
         batQ==
X-Gm-Message-State: AOAM530GCswngbmRyPQ4nsTRFMjnDLHv7ubr9LdY9Hio6cBNmGCJ/0wV
        +A1MrO50GM3fJJIrNGv4kuLWX3n/AB/h0CuBanN10Q==
X-Google-Smtp-Source: ABdhPJyHwFZ5Iqv3unP+z+8lBwV8+TrKOxTRo0U3vA0SXeGCBVMXgm55Ilu8NwejZFEDdz1+OD/t38J49y/2dvAffKs=
X-Received: by 2002:a17:90b:2251:: with SMTP id hk17mr2395627pjb.126.1627361167866;
 Mon, 26 Jul 2021 21:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-19-chun-jie.chen@mediatek.com>
In-Reply-To: <20210726105719.15793-19-chun-jie.chen@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 27 Jul 2021 12:45:57 +0800
Message-ID: <CAATdQgDeXHhFQY8ktOYTaeZGUTuNrJOSuPSC5kuBASS7_8hsgw@mail.gmail.com>
Subject: Re: [v14 18/21] clk: mediatek: Add MT8192 msdc clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 7:00 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8192 msdc and msdc top clock providers
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

(snip)
