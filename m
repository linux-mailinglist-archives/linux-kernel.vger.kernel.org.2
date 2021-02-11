Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5143182A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 01:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhBKA3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 19:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhBKA32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 19:29:28 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B17C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 16:28:48 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k22so2217902pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 16:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ZvQcOczii629syVY+34fhm29BJ0h+rgglUGpe4dO6rE=;
        b=eErk/1OK3Ss20WaOTj9PZCH9uvgQfXw4UmH6+N11+bwmRK/yM9sLMEVPGCVK+majgl
         JPZGb9BET1i+6mkoRgdudU+5uLfuzqHJV1E2CAOdJTECETMuMI+glhXnfnbEbOzO+GNs
         ViBi/o6O1l1+vaZI31DX/b4COUHv2MzcE19JDJ2OnWKLUAk2o+CqFxusPgFPnphu9of5
         bzNSoW6eBn7jWptw1Y8CAbXhLsJMm3kjDMzDA+cibGkJcd0GA3uyz0AavLwijNP8l1wW
         G13L/dxbcvrweUc+t3/k27werqCl0vVGiy4lQRcfsBH0jGoScqx39oB0wB2b6kTyAgQc
         gnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ZvQcOczii629syVY+34fhm29BJ0h+rgglUGpe4dO6rE=;
        b=Vdc+SNPE1u1kCDOdUmAsOFxAQjV99QhvM/SBleb6OhBNbWXyBBPTW5qI2kMuBe3oqN
         Yb+i79S6KvvMSNl5U++COXTkc43K97IoqD0gk7i+BiHaS+xWSbDNlOAjHnlvymSUFmWe
         DFEeXkHEsKgj7AidAW6Q1WdvdCPSqswKwU2oGRSAytIIia75BM0O5b9TpNEg5pzELBO2
         J/hfabfZT55UPM8/BLP4HjA1puRCjXGunZ5G8ixp8Fdkhpp8C/djpqun7cNHUVVqArch
         WMpEvgorbom4yaad5DC2lLT81JlOsKCRkIR8ULUhoWYFGivqx8RhVDaPxXCG926ObEsu
         IUIw==
X-Gm-Message-State: AOAM531g77Uvzv4vWyZhb3FlEPxSFh7tSWwny9mQocV0XHUDdg/i9862
        cnUIPXo5xEG5TCGtnvPEA6Jykg==
X-Google-Smtp-Source: ABdhPJzUueKElbX4bUD4On1njk9XtXCoCP7wd7npmfwN45FTiMgxpKMoaxw9HuaTd4VmGmqQXnh2NQ==
X-Received: by 2002:a17:902:a710:b029:e3:b18:7e5b with SMTP id w16-20020a170902a710b02900e30b187e5bmr2717176plq.17.1613003325898;
        Wed, 10 Feb 2021 16:28:45 -0800 (PST)
Received: from [2620:15c:17:3:2904:7145:16e0:9c00] ([2620:15c:17:3:2904:7145:16e0:9c00])
        by smtp.gmail.com with ESMTPSA id y2sm3283697pfe.118.2021.02.10.16.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 16:28:45 -0800 (PST)
Date:   Wed, 10 Feb 2021 16:28:44 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Zhiyuan Dai <daizhiyuan@phytium.com.cn>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: minor coding style tweaks
In-Reply-To: <1612841499-32166-1-git-send-email-daizhiyuan@phytium.com.cn>
Message-ID: <7af3a79a-6dfd-2ac2-80e-f623f47e648@google.com>
References: <1612841499-32166-1-git-send-email-daizhiyuan@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021, Zhiyuan Dai wrote:

> Fixed some coding style issues, improve code reading.
> This patch adds whitespace to clearly separate the parameters.
> 
> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>

Acked-by: David Rientjes <rientjes@google.com>
