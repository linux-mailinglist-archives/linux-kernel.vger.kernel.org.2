Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5499B3A85B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhFOP6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhFOPz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:55:57 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DECC0611F9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 08:50:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id q20so12999301lfo.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 08:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=caPAnGjSd4h6+T+U8kn9IN5DYqDEbeO8s61SWfgGQiU=;
        b=ykPY+pJTDeZbwHvJeaxD6YKg9kCRSQNAo/PnoLbZV1vKr4CisT3mtLmBV26r83KSO0
         a3xTWbXaGu0a0FHS/2TInhTu3zvkcVbvfc1r0tPigWW8QrBt2aSHgMcaANe+2CbYtdco
         1TFnF65IYwDaHEtf4Ozl7DBArc4xfGin8Q4qY/hZAbcBM21rb37EzEJLgdPVj6C4X3jj
         r18qbUCgKWYx1NA5GRdcVQkYIiuLtpldL7UD6y2+BsuaaVXxBi5ZiXDbPQ7/lRMGINf8
         8PH7MQK/1TzKQ8llgfmp81J4k/7hbtNP2q05WWY0iQ/UFc2iqyiBJ4OBuHbMzg0JGVl/
         QApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=caPAnGjSd4h6+T+U8kn9IN5DYqDEbeO8s61SWfgGQiU=;
        b=kCpr5OcMYfiwEvGsL3MYuyylYj9DMszKdjrDSe9KtfIHLi8BO2c49WUMYJKDd4W44I
         DgI+5jJDUOzjXL0UgFyWf8f7w9rdlKSiqtPEcR8Z2zO99yfLW8uV9sAKY8e6WnbIXQAV
         FdmiBYzT0y339qb2yqsHW6BKZD83F8d9iZNbQouCXkvxl8Sq9tvloFQEEKSNHYc7mIbf
         UyoiapIWxTVmwXsHKb2FECL3ZiU4ihnFNwLM5FvfUoUjsqFM8Tf/T8sDIJtZIgfhjOzr
         0KhoN6vRzL65fB8mtA5de0Yh7NT6tLZNZJDXLBoHTxpXHAR+V9ULGtet7CSVu9A3tDxw
         E/OQ==
X-Gm-Message-State: AOAM531B4lo0OTh6r2OBEO7EMXaoSxG9421360GM0fOynYNTbAErFypH
        K3j0yqvkiC/o49wiKtUDsR/f/w==
X-Google-Smtp-Source: ABdhPJwxuB9tOQI6TVdHMSJ9B4bJ0fJNMtpEVn9u2b7PDdYteUCrpcuZd+KI1PPo11tnqSXSokqh0g==
X-Received: by 2002:a05:6512:2206:: with SMTP id h6mr36436lfu.345.1623772235530;
        Tue, 15 Jun 2021 08:50:35 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id x11sm2214844ljh.120.2021.06.15.08.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 08:50:34 -0700 (PDT)
Date:   Tue, 15 Jun 2021 08:41:55 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org, soc@kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] memory: Tegra for v5.14, part two
Message-ID: <20210615154155.GE11724@lx2k>
References: <20210614195200.21657-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614195200.21657-1-krzysztof.kozlowski@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Mon, Jun 14, 2021 at 09:52:00PM +0200, Krzysztof Kozlowski wrote:
> Hi Arnd and Olof,
> 
> Tegra got quite big rework this cycle.  The last piece comes from Thierry,
> however it depends on one patch in Will's tree.  Since the last Thierry's
> patches depend both on that one patch and other memory controller drivers
> changes, they are here.
> 
> Best regards,
> Krzysztof

So, this pull request is a bit weird. It contains a lot more than what the
email indicates:

> The following changes since commit 393d66fd2cacba3e6aa95d7bb38790bfb7b1cc3a:
> 
>   memory: tegra: Implement SID override programming (2021-06-03 21:50:43 +0200)

This seems to be a patch in the middle of the new material in your branch, not
the start of what we already have in our tree.

As a result, the diffstat when we merge looks completely different. While
I generally trust you to not try to squeeze in material under the radar, it's
also unfortunately making it hard to double-check that you didn't accidentally
bring in something you didn't mean to.

So, before I merge this.. can you confirm, or even better generate a full pull
request summary/diffstat/pull request email that shows the full new material?


Thanks!


-Olof

