Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B633F410F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 21:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhHVTI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 15:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhHVTI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 15:08:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6C9C061575;
        Sun, 22 Aug 2021 12:07:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so17244085pjr.1;
        Sun, 22 Aug 2021 12:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=feHXKMgHM6nYe6wa8RO2hvQpcDXnS++8l8lp6sQROGc=;
        b=Xl98lYIggRtOCv1ckeczoKeUIxykxz/JHPJoBZagg1FuCw0CwY4t+xMfhLDijyK9/r
         V1q6xQ8vKMMLT+msfufsXQlLRuJrH3zP4evso6GfY4iM5iOl//A0uYD0iB1qvXvxiMUR
         t4rhgYLqymNG+xmk35xwynK1IJ0Tb56+Cx7sWuRT6ZejjlRYMutK7m5EIOdTzhiq3jBJ
         lIJhIb1gol5OOYlvybhGhwXQIP0ScYi3r0sXpSTb+wucLTjJzNcH4PvR/ueuDwwF0N28
         wbNdMxwRQLVqDVyi7WdZ0G/TSNzbbzdNqBCDNpPKyO4sphWn+s0DssG46QRZA9BMMCw0
         MYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=feHXKMgHM6nYe6wa8RO2hvQpcDXnS++8l8lp6sQROGc=;
        b=OoLzh44/z19z0ZsK6HqD28C7u4ZjLIw3qZiaf8NphnlZFy8TC89tu70Y397/btDvPa
         2St9IG2QqEbAEAYZAjY+bTK50Y99+fJXSTQHmvC0ZbbytxQpQ+Ost/ET8YOMGuNHsirM
         pOhM+uPf7Tih77wUZ3tyP237HQx7dZEf929zWah3mYIvr4/pkK56Z/1/xndTRQcC3Eab
         WX1I3vXHJtT3bYqUwR2VUUc6kr6aYbnTQdgNT19AjoIRB76g+oFMgLcppo9IPPQSSuZe
         V9ldMt2AN/4Z8n/AJmJ0MAiUOtkVJIYVAI0/xn8J6KchImrBCeyaH4g/1du2175D1zft
         KEIw==
X-Gm-Message-State: AOAM530XYhLdBaioZPVWDCCD/P4zNxkqTZbXWh0JZXTwo/cZ3vj+n/vu
        zPCtuiXfXAUkiuGTpePCVPQ=
X-Google-Smtp-Source: ABdhPJz65Y2dES7lBGoxVxSz5Wx2FGiSa75pqG5UphJ1tSbo7IL/TeuCNVFCXhvGXYv7lt348umixg==
X-Received: by 2002:a17:902:b102:b0:134:a329:c2f8 with SMTP id q2-20020a170902b10200b00134a329c2f8mr727569plr.71.1629659264718;
        Sun, 22 Aug 2021 12:07:44 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x42sm13212111pfh.205.2021.08.22.12.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 12:07:44 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/5] ARM: dts: NSP: Add DT files for Meraki MX64 series
Date:   Sun, 22 Aug 2021 12:07:34 -0700
Message-Id: <20210822190734.3714140-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806204446.2981299-4-mnhagan88@gmail.com>
References: <20210806204446.2981299-1-mnhagan88@gmail.com> <20210806204446.2981299-4-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Aug 2021 21:44:34 +0100, Matthew Hagan <mnhagan88@gmail.com> wrote:
> MX64 & MX64W Hardware info:
>   - CPU: Broadcom BCM58625 Cortex A9 @ 1200Mhz
>   - RAM: 2 GB (4 x 4Gb SK Hynix H5TC4G83CFR)
>   - Storage: 1 GB (Micron MT29F8G08ABACA)
>   - Networking: BCM58625 internal switch (5x 1GbE ports)
>   - USB: 1x USB2.0
>   - Serial: Internal header
>   - WLAN(MX64W only): 2x Broadcom BCM43520KMLG on the PCI bus
> 
> This patch adds the Meraki MX64 series-specific bindings. Since some
> devices make use of the older A0 SoC, changes need to be made to
> accommodate this case, including removal of coherency options and
> modification to the secondary-boot-reg.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/master, thanks!
--
Florian
