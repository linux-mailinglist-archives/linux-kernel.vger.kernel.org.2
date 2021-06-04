Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F89439BF20
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhFDRzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDRzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:55:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9D1C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 10:53:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k7so5953388pjf.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tUZidWZXyoOU2eqImr+oJULa1VmSG9mn3/8lfjdEddg=;
        b=h2COCZcGMxJo4ISS7U8SZFogB6IYBs37jmFdKoWdOg3Iuc53GOMtuyi9AedgPKqbHL
         BKaMPiqLzE2/i8dPdRs9Q0g97cM+Dwifj7CHXx/bQM1oSTWRLIsvvOljoyiaYxBj1JiP
         0yZoSZ+3N4BrsZ9L/VsvDXImdL5zNLZQ/4B4oNA9TcrqdvuX+RyKzcPCcuaT5+R461bt
         qOk4RWrh2m1ylXkCTEJ/RbQx9oAaqNwxn4B1Zf2cyBApKqmcneDk6k1/igDBYiH5zuJn
         8ZS352dcXBcAFQeUnWBXYdZ59sv2w71ZhYxYASs/2GexFpKGOmOJn5Y7LUWs7yg2HWyD
         vOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tUZidWZXyoOU2eqImr+oJULa1VmSG9mn3/8lfjdEddg=;
        b=HzlqYSIWsEk5WdE5nnyjS9HIXdfE2GVxMpovWYffQZfthPgRlXlSLAWjyOP0R+mTFM
         W4F1SRWEM1z+LSGkTdI3v5JEoMQTM3YSxRKOB176Beul5DHtfp0mL44qhldK5ajYGwlv
         VB4d4EEl2MyJPCUymoUOagSMznMzQHpGjSsdo9OIMxs1UWAGpyR8dPHXzFbwkGuy6bE2
         Os+7MCxU4PutH2Bhi9bc6yCe9dL6miYmD5tMWPC7fhY0muxEcOtfQQ9CAywNRViY1Vcn
         VJyPZ1nBT4OdXp7llY8POzL2xzHhzEwn2Arb2yRh92j1myoR7aRpNS735/WwfKGUZhg+
         9k8g==
X-Gm-Message-State: AOAM533xTlmHLT4a9D+diZ7+VMxGLPm7RKaN75ZrTBg4c2NINmq91+ov
        29g2YO3RiIim1ixu9vzBZJ4=
X-Google-Smtp-Source: ABdhPJztVaDhcuFKmPXZhqVHq94CxcJy1/whgLq6mkhz9siaVf8W12EhbZkqg4PuheWT8IMnRRJFHA==
X-Received: by 2002:a17:90a:3d0d:: with SMTP id h13mr6255130pjc.20.1622829195856;
        Fri, 04 Jun 2021 10:53:15 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ca6sm5425259pjb.21.2021.06.04.10.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 10:53:15 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Yongqiang Liu <liuyongqiang13@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] soc: bcm: brcmstb: Remove unused variable brcmstb_machine_match.
Date:   Fri,  4 Jun 2021 10:53:14 -0700
Message-Id: <20210604175314.3572805-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210603024426.1124761-1-liuyongqiang13@huawei.com>
References: <20210603024426.1124761-1-liuyongqiang13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 02:44:26 +0000, Yongqiang Liu <liuyongqiang13@huawei.com> wrote:
> Since commit 8b8f095b9076 ("soc: bcm: brcmstb: Remove soc_is_brcmstb()")
> remove the function soc_is_brcmstb(), the global variable
> brcmstb_machine_match is no longer useful. So remove it.
> 
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> ---

Applied to soc/next, thanks!
--
Florian
