Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8E944A6C9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 07:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243152AbhKIG0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 01:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhKIG0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 01:26:39 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E28C061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 22:23:54 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id g19so12502167pfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 22:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=LOtwJehnAZEQdODws1H/4hicAl69cBcZmemszXkR6A8=;
        b=pPvXkt6qpQ2prIqpYuyCE3QK7sJAP52+7Qt4B+uYqhY8z8gC2jOs3SJEicQ4gJkSpX
         XEUjAgt5DwhocDUGEQFNGYxxVIGaX2LJ0QOVUFbXBmGGFDiYvwAm+nVd/o+MrzbNF7X4
         KYdzSatuq4nLqPrVT5J3nKUz8U+dULAlXcOE4rJX4cfMe9yy7TDSwqefVoSxikC39ukt
         523vrqGclwbuj7zEwoOYLxsS4IE4LaJ4maO8l6ElOxkfyWP3yRcliTEVd1KgRNS4xe1G
         oP87jzGSaz6HjVrwweIc0RkwHV2S9YNq6w1stuMEHOxcwiWwcc7jolr+o1WIQlyqS23b
         EOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LOtwJehnAZEQdODws1H/4hicAl69cBcZmemszXkR6A8=;
        b=bdPsAmt9Vf/RPDKagahKDmHbLj3W4kDixWLcWUPiasq6ieGmLvxWO1u/l5gIUR74a+
         TkhA7YDK04l0UFYZAUamolre/JhCfSRndZtt5fkTovK1V+fSz1LrPyfsRe1yAVWd6yIX
         tg6OeVds+7X+XsSx6jn3dh0BKP/xnzjx/tLutEXw5E4boc5NokYyCK/0kreCMmvMM+0L
         aVtX6+42urP5tRf7NxOa+XjC9uuw3vPuyPRrnyqLwpcU7hb7Gcp8p7/gQSDPJ3hNSxhk
         picBXJcqi5uT0eKPp9xpqER2vrvMZUXVCEU7mg1hcuFcbYqVeLR255INCQLGXheOFpSI
         8CCA==
X-Gm-Message-State: AOAM532DxAqpwJhzb/5rbFfC7t6QCYwqOeFtl8BIdzxKr16pOuCg/eGf
        m3dbnAhenENjtU2Lk0e85Pg=
X-Google-Smtp-Source: ABdhPJw7TKjsRkUk6UfUap34xA5BAyFh0KRzyJST1/V2eA2xdEz7ekDNYBC2Z28TwglPzwe5bmesKw==
X-Received: by 2002:a63:8c5c:: with SMTP id q28mr4110197pgn.244.1636439033488;
        Mon, 08 Nov 2021 22:23:53 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:578:468f:d592:ff78:ffa9:3df7])
        by smtp.gmail.com with ESMTPSA id x33sm6856718pfh.133.2021.11.08.22.23.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Nov 2021 22:23:52 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, allen_lin@richtek.com
Subject: [PATCH 0/2] ASoC: rt9120: Fix settings and add rt9120s compatibility
Date:   Tue,  9 Nov 2021 14:23:42 +0800
Message-Id: <1636439024-15877-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series is to fix settings and add rt9120s compatibility

ChiYuan Huang (2):
  ASoC: rt9120: Update internal setting and fix auto sync problem
  ASoC: rt9120: Add the compatibility with rt9120s

 sound/soc/codecs/rt9120.c | 59 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 10 deletions(-)

-- 
2.7.4

