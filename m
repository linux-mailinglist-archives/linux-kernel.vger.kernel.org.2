Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1432B6AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 11:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbhCCKca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382689AbhCBW4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:56:02 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818C7C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 14:55:14 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id b21so14905356pgk.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 14:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TzpUTsgKH5OxhHkG6eA7x07tUVhj7iVZ7Jw5z2KPfUs=;
        b=hBTURCh0z5/YZpqXwY2Z8Pc+7K7f0gcOD49C1C8rHpZh7SHn4oz95yNunNRlL3drfW
         A+wRSnEANH9mnquIwrpekIfT+2y4hNjg7kxBF/CC3TrhxtkDA31M1J+PygB3941Z+Uv8
         2AiB9easEjwbCly12NeeBhYlDTtLo39fJgyzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TzpUTsgKH5OxhHkG6eA7x07tUVhj7iVZ7Jw5z2KPfUs=;
        b=hM3MHc4wsTRijVQgx/X724UPy2CYiKdu/likmNI4qcUowms8+fmz0iWf1NQheBZ7vA
         cAowfO5h+HLALBASqD4Xfwofk4gs7oUjIBRIgMBdCfJTByD841OJw63cBpAnvSdVFNzK
         bEG3KtqV2+RgfiVu7fVa97XC5sMyzg//rEhJj78Zjufsb7zHNO9awRp/quSbz/F0n88Y
         OpoyxGgos471MRvofZoHi7nIzqG4KIDiDdZUjms0/YnTlzZyN0k3L9rviLe6sM2C0h+d
         qa/zZ8xuoapkyGIulsX6r/eVxafIivI9iSu1Z5j/4pRTUq1CjGIk57X78N/ajh+7PHRI
         fpWA==
X-Gm-Message-State: AOAM531k4ZwQo7aVNnyYdtUHBhtcSskP2ZGSywXKVXkN1YmueW3Gn50j
        sny52gGdg4yOY3sxRVihTJLA2Q==
X-Google-Smtp-Source: ABdhPJxL3PDqshkuC1AAjV4vXEMzG1xytC8Vgf5zwDQxOhGG0a7xSQlvwwS/wpHTLHJmdUQReHiQBA==
X-Received: by 2002:a62:b515:0:b029:1d6:aba1:e22 with SMTP id y21-20020a62b5150000b02901d6aba10e22mr5201588pfe.47.1614725713983;
        Tue, 02 Mar 2021 14:55:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 21sm3309818pfo.167.2021.03.02.14.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 14:55:12 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jason Yan <yanaijie@huawei.com>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] gcc-plugins: latent_entropy: remove unneeded semicolon
Date:   Tue,  2 Mar 2021 14:54:18 -0800
Message-Id: <161472564886.3871405.9093502047975131970.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200418070521.10931-1-yanaijie@huawei.com>
References: <20200418070521.10931-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Apr 2020 15:05:21 +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> scripts/gcc-plugins/latent_entropy_plugin.c:539:2-3: Unneeded semicolon

Applied to for-next/gcc-plugins, thanks!

[1/1] gcc-plugins: latent_entropy: remove unneeded semicolon
      https://git.kernel.org/kees/c/5477edcacaac

-- 
Kees Cook

