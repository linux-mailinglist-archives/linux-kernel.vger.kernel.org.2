Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CB93FF54D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 23:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346554AbhIBVGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 17:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346398AbhIBVGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 17:06:30 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213ABC061760;
        Thu,  2 Sep 2021 14:05:32 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id n18so3311786pgm.12;
        Thu, 02 Sep 2021 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qqhric94Wre6A6FJdzMydZYd/qesIk7MY52nT4Lgiw4=;
        b=a1cNKQXHnSBMrKHK+vihDJTG2VGMMAy6syXHF1hPPo0DnS/rIpRHjqWkDgVPy6fNQD
         PW2sfACO+eH4VhOz2b6IxdNV4bSR+0tzWVnWW+H3Mm8ddyGZ7xNA6uNzqPfdO88Bghmv
         u3yufE4Oi4AtEq2b1/9sUid8Rud192XSBjVXScL/kk0xcvG0pDtTfQ99ayX8SpbM9cVX
         FQCLmc1w9tkWrSyj1w/75VvqwsC3S20ljaIqWEBw6+TKBoz4Bdt+nm8ToStxtJEjo7O+
         IdvfIC2mbo+z4jNB78r9l7K1y/7nisMaaudzMBjzBMjGtiZCKNnGlJWQrGR/cq3rmUjw
         vsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qqhric94Wre6A6FJdzMydZYd/qesIk7MY52nT4Lgiw4=;
        b=oA+waeIR7WqkOKOONfc3yZoLQi3E0jqq6oZVb7LKyfPzMuczpqW0MMe4S86ilbq7zI
         tTyjSuQQ3qa4daaxDywP/tVcyOQKv7bir7WnGO/rr8oaxuaocL8FCjTPbi2BAJpCwfdw
         DqMENaJ8W5CpZT3VqbNJtTC18O9TOB6s/a+u0ibEq34yFPcUuBw/WjlhtSVpkLCmNnWT
         hg40FkCtH7tBTJHhXs7ERyr+X1zNpvxrOoR9LmvEXWy7WqN05Lcz76UgCxKaJiCrhloq
         hk8CMJoG3xRNIQ5/Lnolr1gWZyJj8oi7uO+Y8iSMSkdyJj07j3MHD8Jb1QMErSuuYMcn
         VSHw==
X-Gm-Message-State: AOAM531MGetVKp37YdJLCcClagnmjzDXFQK8tNDwpeV+sTxvB067mJSg
        wbhVjHPtMuZEDDU9LALf8lI=
X-Google-Smtp-Source: ABdhPJwYwDYEtQUDthMhjWdJYxyDGhjsoQczg903NJGN5nLaScwky8l/UNYH17Nf1dtXzXUqQThIKw==
X-Received: by 2002:a63:1902:: with SMTP id z2mr302428pgl.312.1630616731669;
        Thu, 02 Sep 2021 14:05:31 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i24sm3207917pfo.13.2021.09.02.14.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 14:05:31 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ARM: dts: NSP: Fix MDIO mux node names
Date:   Thu,  2 Sep 2021 14:05:29 -0700
Message-Id: <20210902210529.3102969-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829223752.2748091-3-mnhagan88@gmail.com>
References: <20210829223752.2748091-1-mnhagan88@gmail.com> <20210829223752.2748091-3-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2021 22:37:49 +0000, Matthew Hagan <mnhagan88@gmail.com> wrote:
> While functional, the mdio-mux-mmioreg binding does not conform to
> Documentation/devicetree/bindings/net/mdio-mux-mmioreg.yaml in that an
> mdio-mux compatible is also required. Without this the following output
> is observed when running dtbs_check:
> 
> mdio-mux@32000: compatible: ['mdio-mux-mmioreg'] is too short
> 
> This change brings conformance to this requirement and corresponds
> likewise to Rafal Milecki's change to the BCM5301x platform[1].
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20210822191256.3715003-1-f.fainelli@gmail.com/T/
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
