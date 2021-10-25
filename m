Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9AF43A6C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 00:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhJYWp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 18:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbhJYWp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 18:45:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4782BC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 15:43:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c4so5031332plg.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 15:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9dtMhbuSIysj6diw4zMqJoEHPjXJLlusGYlVV0o/QwE=;
        b=Osd0NSgC1pcBMCS15+zN/gdtj7yePPzh+HndQ77zNZkpsLdMfoQuAIXBeodIVNEWLk
         PznPXgY+MHZcYYYT1JPuvHEFjO0WX861MtVJwxtJjDw/c3pJLGBs9R5r3yRwJFkR+fpw
         oeMvYKTdbbxHQle4O7DBZvJW99bx676XOo/Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9dtMhbuSIysj6diw4zMqJoEHPjXJLlusGYlVV0o/QwE=;
        b=J4+RxxbQ50LA4zC8hAgW2vjB9Lop9oXVQbGDKS+5+95HcTaBNB1E9OEiE3msrd1G4h
         0cwOZv1jnXb9EKj9FXyGrymWQA3QZAMWUOUDtoI++czXObBi7MQ1P2XhVvpRiIabw/Bv
         gFS5XiWtWHnqMteWtsVEQvTY08GLotDCzZku7DYo+yHb6+A2qIn0nWsb3V7lrHwRoOs0
         58oPvOl1bLxIQA/rDcnWOp8aoaLjRH1abiC1qgDcpA2IPCtWgmXthM9y7FYiCo6/LzfG
         lRkcNTCaOLRxUCQktg5L2lIpDfC8MC9zLmu4ZKDaRCjM6Q2EDno+fMKHwZT2yMKtIACh
         WqAA==
X-Gm-Message-State: AOAM533GMsK4KBCJMs9GJAYCcwMTzt65evHbXOVIFvsnpyUgjsMzQimU
        Qefm2KH4SzAdAGzu+pN1cUcIHQ==
X-Google-Smtp-Source: ABdhPJzefObLbgVGgmk2ZjsW2/mnBC6utxGsG3p2cPD+nYeoyk1eFuzgkPnzNJvQdLnYDVkshJt0NQ==
X-Received: by 2002:a17:90b:84:: with SMTP id bb4mr25775233pjb.2.1635201783745;
        Mon, 25 Oct 2021 15:43:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r25sm16576281pge.61.2021.10.25.15.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:43:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] fortify: Avoid shadowing previous locals
Date:   Mon, 25 Oct 2021 15:42:36 -0700
Message-Id: <163520175414.1020299.2890966678849139996.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025210528.261643-1-quic_qiancai@quicinc.com>
References: <20211025210528.261643-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 17:05:28 -0400, Qian Cai wrote:
> __compiletime_strlen macro expansion will shadow p_size and p_len local
> variables. Just rename those in __compiletime_strlen.

I've adjusted the changelog a bit to have more detail.

Applied to for-next/overflow, thanks!

[1/1] fortify: Avoid shadowing previous locals
      https://git.kernel.org/kees/c/95cadae320be

-- 
Kees Cook

