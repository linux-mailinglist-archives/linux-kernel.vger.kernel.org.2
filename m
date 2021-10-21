Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D35436D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 00:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhJUWYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 18:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhJUWYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 18:24:30 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896C6C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 15:22:14 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h2so2263468ili.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 15:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlOT9vEpyp3am7LKzo0YSiTUrikAkQARB3bdoFfSeew=;
        b=aXEo24yPj01ReWr0DVEQfsj79C3aMpAA6La+UMJyGY6OJJo8tI/Dh3bs/7waDCW6Sh
         fHsVGYMow101/SP9mBGvi11MDbayOnidmhk4xH7XpE8ECrGHdHDjf5epeCNVTb+2PZXs
         Qa9GVBcrVooAFHuQ23W1uEbRzm3yH9BLAlcOGhfPfM5e9zgXACe2ICWhHmVK3rFWDEBb
         LxijWSW1F4+tsr8YXjez6ckdKvxvsWCc3KCEAbAJJshSe9p6cQvIO5uq80YfUwnw4dqh
         uayoU5DC7pPIDyRuIvCtq0QtC5UzlS6XJGnkQOZu4g3/CfTr9MsBAs/ic7no1a7azeaw
         1/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlOT9vEpyp3am7LKzo0YSiTUrikAkQARB3bdoFfSeew=;
        b=yBTFWbeEIAPQqrdUBmiKe6nXUG0MoqoN4dHwKEyFnEkOjUup63caEG31f6AF6zFlO7
         AdjPcpi+j5SIcKWaPmfY8dDcpW+uB2qauY6IHA/ZZoPCElb32+4k/NWZ+qnUn8hDnlSI
         iA2ZsTZJ3jm7TPIGwXyGqhIdB1t4yqnQqSr2qV2o1TzAfAdT8orF/6KH5bM/uN/eS5kY
         92kh/z6VF4cu/Qp3G6Mbz1+EKR26hdawiqvLA73gM5Z8vxCfuKLFGBwP/MNAEamFLcn5
         gDr4qsbyIvsmnaaTC4Ea6QhSVUZpzne/R9IvV0ZjxFFYj4mIh3uCmHCJaKnZYws/LlqM
         /Ngw==
X-Gm-Message-State: AOAM530z7kN0PnKgfmAiuSP3nhoZS+3pCw8NVC6h7noNLnukjE5k6Gv7
        JXASXNwZymnMsX3r2QbyrU0jh/k81Gr5OjtlwgI=
X-Google-Smtp-Source: ABdhPJz3LfX1tUCbRvyPnlIEl/aeR7LVq1QkxchE/7hze+S3j2rzGV+2JZOCZT9mVqRFLjbzvlCTrtq0++M4U5YVYq4=
X-Received: by 2002:a05:6e02:188c:: with SMTP id o12mr5213208ilu.321.1634854934014;
 Thu, 21 Oct 2021 15:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <01bc16af8d37fc1d8adb0cc350d5c7f00bacbbfe.1628672164.git.geert@linux-m68k.org>
In-Reply-To: <01bc16af8d37fc1d8adb0cc350d5c7f00bacbbfe.1628672164.git.geert@linux-m68k.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 22 Oct 2021 00:22:03 +0200
Message-ID: <CANiq72n+Fii9Wk7JFt6ckS2mM__rP88HsDM+vnBVZq0SP-KU3A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add DT Bindings for Auxiliary Display Drivers
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 10:57 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> The "AUXILIARY DISPLAY DRIVERS" section lacks the related DT bindings.
> Add them.

Applied, thanks!

Cheers,
Miguel
