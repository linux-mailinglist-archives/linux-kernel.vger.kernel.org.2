Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A733E5A27
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 14:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbhHJMmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 08:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238812AbhHJMmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 08:42:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8718FC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 05:41:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so4124742pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=jEv32BiVnu7fQqSnvPGcx5ruZj5V0HnF2prfpKqxjn4=;
        b=0mjhlmrZSBz51JqUD9OH0DhuZBRxI34vxDlxoSVsklAlLVx+DB4RYGu4wXSCPJo6bE
         0Rj1Ffse8Rzx2ep4AxTlkweNF25Z6t+4LZO9PAdFTLPcQXwbra9BkRNXLHiVKaTsNc0S
         +ixAQQ2i6aJthqyAUcHvnh8fjB5XaFTimMRxJcK8KBdSEvIxfGKjYcbv5RpgW2yA029b
         ZfALDvV0HR4/2en03DYTmB2UEgKkjXlvfeQd+NIYlDc4ILWvxdqWUoEG+deW7Q3HdAV6
         XilWTUU3kgXGlUtEyArDUU12hOt0M0ah1oK3apBp/eiU70CaaFA9B1cMk20hy53/fqj7
         I6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=jEv32BiVnu7fQqSnvPGcx5ruZj5V0HnF2prfpKqxjn4=;
        b=IwjaRkPxcS/is6JCEDC/RlWeR0AdlYNnJtpEsaU0t/yt90f100izAUrHYcwJLW04e+
         kV3+soAgB1pWMrGbXXbhpIdRiz1P0RGCQU5zv/D14mZQGdvQrdFshS88A7La9UX21pkC
         +rwd5oYDddLCucqXYUEOcBu1BxoVodc2tdPvFa6BUiZw/X3/clNRdUvUWYG1j/JnIHH/
         YjRgVxNe1gy+j9YDexPciEG5DjZDRW/XIYiGF5tHgfWLOPi9BivbPKZ5CAA/Yy9Hppvu
         TahbDjIAZyGw0z14YPJU4c2yA6IkI6wUFCSQAYOaqzLoQIouXC83up+Iejpma8F1RRQd
         lvGg==
X-Gm-Message-State: AOAM532Q04KVvz/cCCpfikqBo/A7sxDyPvnjj5gj7sxo7VdmbrweUgpO
        wQWDkn8Y+sPK3cFN2Xk55klSFA==
X-Google-Smtp-Source: ABdhPJxAEsdQRashpCRGsGTtR9hGQpKEX2bQMXc4GZMfve1VZFx9ipQvlCg0rOzK62MK+kdtLSnIMw==
X-Received: by 2002:a65:55c6:: with SMTP id k6mr188593pgs.129.1628599305051;
        Tue, 10 Aug 2021 05:41:45 -0700 (PDT)
Received: from ubuntu.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id y12sm23851561pfr.68.2021.08.10.05.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 05:41:44 -0700 (PDT)
From:   xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To:     pihsun@chromium.org, drinkcat@google.com, marcheu@chromium.org,
        jitao.shi@mediatek.com, thierry.reding@gmail.com, sam@ravnborg.org,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: Add inx Himax8279d MIPI-DSI LCD panel driver
Date:   Tue, 10 Aug 2021 20:41:40 +0800
Message-Id: <20210810124140.16937-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210412080134.24598-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20210412080134.24598-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

could you help to review this patch? This patch has been applied to our devices which use

INX 2081101qfh032011-53g 1200x1920 video panel and it works well.

thanks.
