Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997613505B5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 19:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbhCaRr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 13:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbhCaRrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 13:47:41 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B705C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 10:47:41 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h8so8290122plt.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nsx3KrQ1iXBWGMZ3l6vXrmCtQmBGgQUn9ruxNhjQYio=;
        b=JEdVefuWbawvRM2xDGC1T8kDJTK4ExwalZ1xKx1awHgIOiWhTA1me7Rg12OC2T8nG0
         no+8M03nYLG1i7t8LjpZzQHMEX/0jP/kQpOYiWPg/zKKIevUhig0dloCHp8L0WoL+ce9
         snYWBFK+/NMStD/MqPS8mt+Dr1SeCw5aoBQaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nsx3KrQ1iXBWGMZ3l6vXrmCtQmBGgQUn9ruxNhjQYio=;
        b=Kh+uS2ykLfqtQbTzb9If6/QXvl4EsMwPF4h1teBuga1qEatdWvweJPDaOKCck4Myfe
         9vTkpN494JHDPAH0LbwbeW+dwjhTdEwvHKz9p3frF4myigvDI5VI4hbvDxHiOPucMxE8
         XGGEpYveCY6F81Mz4UfstpBtD5BRGS5eQ/UF4O72as5dtrw/qdMygdZjcHxzGYZg/55M
         xhp68ah1gQZQkHzuhqfHsALJLOYO3EJ/rx3EzMuWaglwbJDCnZBC5+IO8bzGvPWHiczW
         l2vNJ5Q4kIw3zO9mg079AfYNlQW2j8zqTSzIsrMpf7F5jh+xAGDQfbu1+uhI95BZ5hQG
         MOOA==
X-Gm-Message-State: AOAM532Q/CE821v7pM6hawaMsuLh4WLXoUNJUXRbh6tdy/Ocvq8aEQm4
        wBz/P/7fKZajK7zJUG6/hp3ctw==
X-Google-Smtp-Source: ABdhPJwp/wD4D3YAu/8vufyC5qC+hiD0LBjfUZrhsGmW1khFIL23zoPDvc7CHtr4oKfF+FdLwp4qAQ==
X-Received: by 2002:a17:90a:f0c9:: with SMTP id fa9mr4605098pjb.39.1617212861030;
        Wed, 31 Mar 2021 10:47:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p17sm2769690pjv.49.2021.03.31.10.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 10:47:40 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, Mukesh Ojha <mojha@codeaurora.org>
Cc:     Kees Cook <keescook@chromium.org>, ccross@android.com,
        tony.luck@intel.com, anton@enomsg.org
Subject: Re: [PATCH v3] pstore: Add mem_type property DT parsing support
Date:   Wed, 31 Mar 2021 10:47:37 -0700
Message-Id: <161721285524.1710134.18079016969330535532.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1616438537-13719-1-git-send-email-mojha@codeaurora.org>
References: <1616438537-13719-1-git-send-email-mojha@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 00:12:17 +0530, Mukesh Ojha wrote:
> There could be a scenario where we define some region
> in normal memory and use them store to logs which is later
> retrieved by bootloader during warm reset.
> 
> In this scenario, we wanted to treat this memory as normal
> cacheable memory instead of default behaviour which
> is an overhead. Making it cacheable could improve
> performance.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore: Add mem_type property DT parsing support
      https://git.kernel.org/kees/c/9d843e8fafc7

-- 
Kees Cook

