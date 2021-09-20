Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57D0412B45
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344158AbhIUCMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241623AbhIUCCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 22:02:15 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F0AC12D67C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:11:51 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id ay33so45575302qkb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nUORpWYgvQsdEmTsqcLhxS3LYAuuNxmU2qeGvSjqHnw=;
        b=PDIdI/Bd3YiqDRRvwTItN8ctv612ph/5NrCbKQHyYGpliaaUHBu9xoHYUVEua3Q+iV
         smKqm1ri+0FVwMB9Xz+Bs1em5iAh5YTFqKr+mDnArGjob8zzCz/kKxgfzZD4G5gFwWRy
         sB53CtBmvrNkAF8bxCuzNsteMrAgI+ypRXIpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nUORpWYgvQsdEmTsqcLhxS3LYAuuNxmU2qeGvSjqHnw=;
        b=PKC1v1nudrCT/S9L3bb1Y1dURsGO81MfOmEIiExGvUFl39oweXddRmetnuNqW6Be7W
         OFLVLl73eDaiGA9C/tKXRW78wBGDzHpi4roj0RcxYgggFvfn9zSsdGt94Dc7pkO5FTL8
         71PuExf2d9nD2eVqKqO+lDO5u7SArzJUVu/kV7yKIG4Nu3HSl/4Q4eQTk5+HgbPFDrsP
         qeE0TxDY8N1HoNkRArdH44Q+PG2DajPsSJ3owb93mOgn39LvYrai1W2p8vAHfAoCAdas
         Og8V80Wmo5TmMAH/Eutu6XL5NZ1LlCunuq0T9Gt95R94cX4TS6d8ml4XKUePRvQb31FI
         H87A==
X-Gm-Message-State: AOAM533BS6wQHaRT4tYuUw1a3L+4AaVkHwL59SUjmuEmp6wntOlx2UJq
        3oYGRpySqpFQCvFDYsGGIRB/bLPjeGLaMIuRFmzDYpzxAS+Inw==
X-Google-Smtp-Source: ABdhPJxEG9v/aaNLEG8u35+7Iyd5AXH98QBASp/agrbqOwT/fKHFzbiP6UG4x2z59icV4vp5v+b7PRLh7qXyUi/1gjs=
X-Received: by 2002:a37:c42:: with SMTP id 63mr13501119qkm.104.1632161510337;
 Mon, 20 Sep 2021 11:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210920163915.757887582@linuxfoundation.org> <20210920163919.680890632@linuxfoundation.org>
In-Reply-To: <20210920163919.680890632@linuxfoundation.org>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Mon, 20 Sep 2021 11:11:39 -0700
Message-ID: <CACKFLi=a_5Qhr1rRq2gKqmO1su-pwxt3845K1AVjVqq5iOXJ5A@mail.gmail.com>
Subject: Re: [PATCH 5.10 118/122] bnxt_en: Fix possible unintended driver
 initiated error recovery
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Edwin Peer <edwin.peer@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 10:28 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Michael Chan <michael.chan@broadcom.com>
>
> [ Upstream commit 1b2b91831983aeac3adcbb469aa8b0dc71453f89 ]
>

Please include this patch as well:

eca4cf12acda bnxt_en: Fix error recovery regression

Otherwise, it can cause a regression.  Thanks.
