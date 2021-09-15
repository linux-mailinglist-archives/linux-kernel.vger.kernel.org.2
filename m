Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ED940C0A3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbhIOHi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:38:57 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44412
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236528AbhIOHiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:38:54 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1A04440288
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631691455;
        bh=cHrA0t4OvyS9O74tgTKsLCE0NsldZp8H2NvCrYH6FSE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=fS0zPR3i6i1ZKVkF/pAXpBVfMi1V5Z3Cy99NhnjbYecwc3zf3pkey1LxMX3sQpRBA
         TcxQ8d4kJA9b5uxCqvZdg/b98sd/TgoYNbSDfqqcO0E9odOsautb3IRnQbG6Xzyud9
         kn0cM0V+iYQz5ziAoyoU+n/Mh5fnSeXkxl9eAwQ8mD/ienwAd017+VpXMskXi4QeSm
         Pd4OYl1gSCtfnyZPVSLi2k6+izZFUVPNiucE8Fk07Wy+nf/ZXHF9X+98GhLmqRTsg+
         3OJiK3migTR0GTbD/orkmNP3119TLFABMi96L4PQdI6OktuKuav4NOX19iU6JoCzIr
         kHbSAq3rZz06w==
Received: by mail-ed1-f69.google.com with SMTP id e7-20020aa7d7c7000000b003d3e6df477cso1060776eds.20
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 00:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHrA0t4OvyS9O74tgTKsLCE0NsldZp8H2NvCrYH6FSE=;
        b=vfZhRwZkbzH7rpb1lmIiRimscSRHZvqiVj5IbF/pWP+/SbAVcK5k2GAwOo8s0mV9cn
         RrFvBvIy5VSiQjrEzQLs2HyQp1sDzztZhZUOfEJdDsweqwSF30NKmawgW0FyzgFSaZ32
         Tq+Lj0/ixoe/HiUzjUj1/WE0nYJ1zKZt48K2VdpJUfxDWw/DncLoH6dRQUbOZzciQM7x
         nuYjk/kjHLJht548C4m6qzGhTQNsdUEEF6b4ycs8AP0xf0CK9RzCV1W8UcLeHj2R+lP5
         gtMYd708baAV1xO65LraPYPN6BbAeJbFSpE3DJXhsbPdn8n/SWpseLNgEaKjrxva5bpR
         SAUA==
X-Gm-Message-State: AOAM531m5YVquuJKWOcEF6tgWR4B5BvGsAocqveew3F1AR4Dc/soBcot
        nBUXK8wWUwrEwOD5u4TsC/mFh+u4NllNJb/tvLQdbKG1xETq9fYnvlgvDaF6HhlSBibNL4otym0
        wBOjhtTwnwvhzhJoGzdC+hCldOl6SN1GR0AIfMYm1Dw==
X-Received: by 2002:a05:6402:4cd:: with SMTP id n13mr24254862edw.215.1631691454648;
        Wed, 15 Sep 2021 00:37:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMD6sXSY58Em4BfFpuRoLn6u9XwZwLgRmzd1JZFLU/po7hEkeRep9kGZoggT8/YhNM0E/c6g==
X-Received: by 2002:a05:6402:4cd:: with SMTP id n13mr24254849edw.215.1631691454524;
        Wed, 15 Sep 2021 00:37:34 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id d22sm5871832ejk.5.2021.09.15.00.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 00:37:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] memory:tegra30-emc: replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
Date:   Wed, 15 Sep 2021 09:37:25 +0200
Message-Id: <163169144170.13297.7126347319834595881.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210821035223.28282-1-jing.yangyang@zte.com.cn>
References: <20210821035223.28282-1-jing.yangyang@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 20:52:23 -0700, CGEL wrote:
> From: jing yangyang <jing.yangyang@zte.com.cn>
> 
> Fix the following coccicheck warning:
> ./drivers/memory/tegra/tegra30-emc.c:1322:0-23:WARNING:
> tegra_emc_debug_max_rate_fops should be defined
> with DEFINE_DEBUGFS_ATTRIBUTE
> 
> [...]

Applied, thanks!

[1/1] memory:tegra30-emc: replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
      commit: e12bc3540ad79b2cfc0b801ed16c93b13741d32e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
