Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E9E30623B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343950AbhA0RkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344039AbhA0Rhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:37:31 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18683C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:36:51 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id s15so1426410plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=isivwn8cdsIwyt1Tmy6+7rtPlDEzmvkImAxSkCpBXXM=;
        b=bgQk6fGYWWb1g2M8jicaCTQiEvlx5Sy81QbUjYUp19SL7gmVcDWoc7teagPn0saha/
         xyaVNe8VCa/LpSSotK1B5YTVd9pfKFqYvhQ99jy0wVwgxOyw93bwGG60CrlFkRhbWyf3
         wPqYlEhPH1Jm7yUgD1Pxqqic3kRUQmEIr82p8r4GEVWXZaoCh+9G8AI03MyTznIe6mG3
         F5k6yfQJ0aYvwpGNMFKlnFUe+s0ahiyxMsN5CqqIxxdYteFk9tCYC3E8tQOPaQC3z3zT
         giU3QIFWFsBPzpcwemALbdHlpIg2OoUdc/CMK+z16xyVubn3IjQuT/Fd+mgbjhGscYoQ
         lhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=isivwn8cdsIwyt1Tmy6+7rtPlDEzmvkImAxSkCpBXXM=;
        b=CZp3vMIF+APKVBZaBdeCG2sLxGT9phR/9mwMNGxRLxhDwkZXrJ0WOkgLtMZ5sbd6FH
         I7KanPu0rtZGHV4y80euoUMHVYdbx1xqO7HL3PNQi/rc7VPULKlIs+zBts0lOKYNuthF
         BJRUJLMs1gmpBe1/nuUnQ/Jxw7GQCdCuAAOzvSy2Yv1mpHW8NCIVkUubryTNOsWLkQN7
         BK42ROeb57kBMi0MxfJI4sBo296KZhewg1IYkSmFyB1naKkWmgd2UZwW6jlUcHz+D5Yl
         i5YchcNb8ezlx/2FEzDsKsA+DhU/Sakl4bTRyyELjX1LJj604LGHOzsV9Ukl89XdFLjc
         Rc1w==
X-Gm-Message-State: AOAM531tmMBJfDJbT+5ZIVgB/hPpOq9awl0MKCQ36jFiTu7ezCJ24muS
        cd17ddjlHE4Az3vFfomuJyE3pJQPoCc=
X-Google-Smtp-Source: ABdhPJwevMyNkY4tT21RGrNkpzS5x3MkFKCyeDJ5FWFM4Th1fQth64z0iNZjdJoevvXgxX5VhYs62A==
X-Received: by 2002:a17:90a:b78a:: with SMTP id m10mr6718622pjr.164.1611769010558;
        Wed, 27 Jan 2021 09:36:50 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b206sm3101675pfb.73.2021.01.27.09.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 09:36:49 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: bcm: brcmstb: Remove soc_is_brcmstb()
Date:   Wed, 27 Jan 2021 09:36:44 -0800
Message-Id: <20210127173644.1297984-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120193414.2588790-1-f.fainelli@gmail.com>
References: <20210120193414.2588790-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 11:34:07 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> We have no in tree or out of tree users of this function, remove it and
> the header providing its prototype.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to drivers/next, thanks!
--
Florian
