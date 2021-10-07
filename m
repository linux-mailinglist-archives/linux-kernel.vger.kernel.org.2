Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DDB425B10
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhJGSpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:45:14 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38658
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243709AbhJGSpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:45:12 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EF82040015
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 18:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633632197;
        bh=vfsKCtHamD4S3RgzBMbdALXMRfkICpF4yk/yRZF5360=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=hgUTj7vEJQ37fd4FxdS+Kwnub5Bq3LWyMt+O7ucxgeV+5gmtJ9R+gSsgC6nAG+BG5
         cqL2RaADGwupQMGSmEMHwcUiuzXpXMwZGdO6yO3B4zVaQ5/kMRyZNDP306iNHRD/FJ
         UvvXdkALH7tT6Ui2Mum6G+Pt+b0sGRDnzuUQ7+Red9YWdpUVYyw4nqyCS0+MW1oIDw
         fNHNoH9yJ85+5pZHEpzQYd7HIhsKXWVjbj3yfqAu5jm/Z8Zea+FoWH0sskqY+0jjrl
         EC9nM2/MiBaCXN7BqP0ZBsvlauTrSjjcWMKL14gRT1iVMxLv2fQXo6NaMHvPnYzjBP
         6TXBL91Euj3WQ==
Received: by mail-ed1-f72.google.com with SMTP id c30-20020a50f61e000000b003daf3955d5aso6797738edn.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 11:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfsKCtHamD4S3RgzBMbdALXMRfkICpF4yk/yRZF5360=;
        b=j+IvBTQTHsQk5S3NjkNYwm49RGrIKHMwqA2MsbwA90c0V8e8HP1PWwd63MEzQIwBp+
         KhupOdaFKbQd/Pq6K+InKkepEZ+ct5GkvyyHzlFWZXe2ZHQkbzFGQdYEYly1XCZf/WUl
         bL73k/8QZ2O3ZwzZUw844k/XdlEzZUkGkuDUs2vy5G9mNFfUSGk0cWEQCKO/IDeF2NGp
         OUixnjuqt+3/W55xJNxgh3B4aC79vdAcrtFtQHMqynccdMn6K0m3htwVRvmIaGQ62jFC
         GrEFJqS3GQi+OMoFogp2yMEADwjhg70Dc670DAFSPtvAPQ2tEj2k3QriSEGXVWP2v+N1
         OrWA==
X-Gm-Message-State: AOAM533bkgrxcKk6XCG/xX30lgvLcDZ8iq9IM/cyOWjogFqPq+0DmR45
        /8fWF2rDXPzLahxPf8nhtebdD2t0jl4xoyhLPQrgv5RNbhfg573qco2eOUu5KjTuQVn+TluPCXJ
        hDzmXimy+qyfH1leJzk1vTYu6llnntkjRv6Xpee2Xzg==
X-Received: by 2002:a17:906:1510:: with SMTP id b16mr7881125ejd.332.1633632197307;
        Thu, 07 Oct 2021 11:43:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4kY+mbxK6ilTZrzFtN+OPqz5dEOJWYNcxVplXkKWB4WtY+GQCCkJjPtV4yihXgAFBEC9pMw==
X-Received: by 2002:a17:906:1510:: with SMTP id b16mr7881100ejd.332.1633632197145;
        Thu, 07 Oct 2021 11:43:17 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id t19sm70612ejb.115.2021.10.07.11.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:43:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Kai Song <songkai01@inspur.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, thierry.reding@gmail.com
Subject: Re: [PATCH] memory: tegra210-emc: replace DEFINE_SIMPLE_ATTRIBUTE with
Date:   Thu,  7 Oct 2021 20:42:45 +0200
Message-Id: <163363216363.76978.16578482171279957424.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005043514.9650-1-songkai01@inspur.com>
References: <20211005043514.9650-1-songkai01@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 12:35:14 +0800, Kai Song wrote:
> fix debugfs_simple_attr.cocci warning:
> drivers/memory/tegra/tegra210-emc-core.c:1665:0-23: WARNING:tegra210_emc_debug_min_rate_fops
> should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> 
> Fixes: 6fc5f1adf5a1 ("memory: tegra210-emc: replace DEFINE_SIMPLE_ATTRIBUTE
> with DEFINE_DEBUGFS_ATTRIBUTE"):It reports the same warning, but didn't
> fix all matches in this file at once.
> 
> [...]

Applied, thanks!

[1/1] memory: tegra210-emc: replace DEFINE_SIMPLE_ATTRIBUTE with
      commit: 31b88d85f0432e1c0738fe0714191e8504f505c3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
