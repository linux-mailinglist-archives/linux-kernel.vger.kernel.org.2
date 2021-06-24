Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10473B393E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 00:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhFXWf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 18:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhFXWfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 18:35:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB518C061574;
        Thu, 24 Jun 2021 15:33:34 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m15-20020a17090a5a4fb029016f385ffad0so4406275pji.0;
        Thu, 24 Jun 2021 15:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MdFMfW7b64feE5iUw9nFA6KmFUv2MEmfqnn2iFUDPjs=;
        b=WV1KSMHPFFEa873q1vSzoph9SakbOQ+HH9/4+TKXh28497rvPeEDndIYJbDfaeVr44
         p5uy8rEbpVTSn5GFjsDoNl6S8zaQ2ya8N+rpGTtXjMvGKfb31++23J9zV4kCECZRJh78
         MdFhO96K4uWMevdnfpdfyswXnG31j8LjtG5Yw28um4dG6A+4nQh7BMa8L9RlRfM/R2L6
         xScsSxWSYKg7ocEhz5u35Pu4ZnJSEowfdFZ5rkdJcVziRYotSPO7EXxbVEc3/ZlCwgAL
         Pct+LW+hAo8Tit7NLibxDFGqIxHHaApeq2ZwUe8TJJfuPIomelgDe1+5DQ1qGVYJZTcX
         g3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdFMfW7b64feE5iUw9nFA6KmFUv2MEmfqnn2iFUDPjs=;
        b=KHXyteQehycvInET7e0mJ+LSsXA8bwadu0Kj2Wsy2chKbxOD3jx0040ZXSmlwPr/ot
         Z3fpnW51B9qYuizRNB9N2FsyYz3cbE03IsUnalecb2+dF/kt/MLIeeIvlnVifYLBjv/v
         Z8tQOXsbEYF6fK1BgTj3tn2e/Idrhcfv8Tn9s9iNAsjnADTLOT1f7QneooAPwIBjedo2
         UcLS9RhDLlV/jDzBY1tGc0rsPradpKGQajZxdUe/8fxfqYup87HIrJ71Le5Q+R61+tgi
         u0h9hrxWepQffBPS07i86QCRuNWeo0DMDebs+SzBCyKv9cGGfGunZ3f8AgX4IhCJ7mC2
         oLQg==
X-Gm-Message-State: AOAM532H9qJvM97VtwDrWi4vDINcMWFR1Jx8cZ3Tals1wbtwj0ZSyMt6
        +dxr4nkn3yyTO7RudcNvoMw=
X-Google-Smtp-Source: ABdhPJzLmav58dvH84mCQn0JOaXh9sPE/BVndlgQypZ/2teV+4Z8T716g4vdbkksyRtQDiJCfjuHBw==
X-Received: by 2002:a17:90a:7785:: with SMTP id v5mr18296333pjk.20.1624574014323;
        Thu, 24 Jun 2021 15:33:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x190sm3956939pfx.198.2021.06.24.15.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 15:33:33 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivek Unune <npcomplete13@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM: dts: NSP: disable qspi node by default
Date:   Thu, 24 Jun 2021 15:33:25 -0700
Message-Id: <20210624223325.1315301-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210613094639.3242151-1-mnhagan88@gmail.com>
References: <20210613094639.3242151-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jun 2021 10:46:34 +0100, Matthew Hagan <mnhagan88@gmail.com> wrote:
> The QSPI bus is enabled by default, however this may not used on all
> devices. This patch disables by default, requiring it to be explicitly
> enabled where required.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
