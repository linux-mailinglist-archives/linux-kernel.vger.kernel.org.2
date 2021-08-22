Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0586A3F410D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 21:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhHVTIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 15:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhHVTID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 15:08:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D257CC061575;
        Sun, 22 Aug 2021 12:07:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so320346pjt.0;
        Sun, 22 Aug 2021 12:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zxXXhh0DEqjiPk1bf4TGcus3ngVBbA5mFl/MCDhfwBQ=;
        b=MLptEgfw0gVbD2H1/ibOdWn1rw3SMv+6nXCsV+5RBRBP2zY/bq2myNmj+tNlYHZK4n
         Cu2Yk8jFsHhhZFaYzuTf4yuq/Lj3lNiIiDPCRTr/hS/FhsTLtRQPFrfP512rkeqmpIJJ
         WrJ+1l2/43sZei+NGQtCnkLh2sEQe2tGdfOILUy3A1/f0tZBv6go1Fmbx/l38VyuIFoy
         ygYfJaVI68vmPzPfG1GxNw+88nmTIiIBU+dakSy6PqipHMi+cgEsswbuPl2CklJV6w4M
         COcG9RN6jlI4I0iw5FXFu4Wcg7oBKKF4S8nRyRjvkUQ0NY+DxJf/eJsRqjqALD+Ry1Di
         6nKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxXXhh0DEqjiPk1bf4TGcus3ngVBbA5mFl/MCDhfwBQ=;
        b=E4qnXSjrpqDAjQf3AqW9tIkU1CHj5LYUxR87gu5fCGHBYlB6sMSPMi9jDGAbwOCSaU
         oJv9eoBZuadA7vWGhpPg3QAFC4/IQtscPykW1mRxQ7ZvUXuYwTNC5y6XzEylFBXmco+o
         YkCqMi3UcmjLDkUuhXN1LSjklxafQX8lguVa6s+mUDTP9IqJUBN9fIZVdFvFrujkzJe7
         e+HZHnQ/uMFqPC3i6dhqAdhPqM5VO5ihdMIhyfLsQZvpUUzSG9qq4fN3G9cGGjDda2If
         GnHS+rDmkrroc7x/kOWxXF1lgyl1tzbRdfn51QUTDUvs7ykmxJ8gcCt7F9EjBM61dK4o
         femQ==
X-Gm-Message-State: AOAM531RP6DSqC6PzQvXA184fzZuF4Q6VGcNXShtJ0cG6hI2wMw6WawM
        EG05fJ8W9efPBPmhTvGVo/o=
X-Google-Smtp-Source: ABdhPJwVjTddJ7AzPTybQWZeiR2U0S6mCXyGLOYG0JqbA7fWLv9Nco4FHAB1gSqfjAeO0hPkCXE2Rw==
X-Received: by 2002:a17:902:ce8e:b0:12d:ab00:2518 with SMTP id f14-20020a170902ce8e00b0012dab002518mr25396743plg.58.1629659241414;
        Sun, 22 Aug 2021 12:07:21 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b20sm12962871pfl.9.2021.08.22.12.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 12:07:20 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/5] ARM: dts: NSP: Add Ax stepping modifications
Date:   Sun, 22 Aug 2021 12:07:11 -0700
Message-Id: <20210822190711.3714024-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806204446.2981299-3-mnhagan88@gmail.com>
References: <20210806204446.2981299-1-mnhagan88@gmail.com> <20210806204446.2981299-3-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Aug 2021 21:44:33 +0100, Matthew Hagan <mnhagan88@gmail.com> wrote:
> While uncommon, some Ax NSP SoCs exist in the wild. This stepping
> requires a modified secondary CPU boot-reg and removal of DMA coherency
> properties. Without these modifications, the secondary CPU will be
> inactive and many peripherals will exhibit undefined behaviour.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/master, thanks!
--
Florian
