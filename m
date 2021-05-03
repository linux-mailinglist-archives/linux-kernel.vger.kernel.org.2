Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBD2371126
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 07:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhECFHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 01:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhECFHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 01:07:05 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650B8C061760
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 22:06:13 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x7-20020a17090a5307b02901589d39576eso509444pjh.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 22:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/FKJGJCQ2WFjnbO5YcetVVfi3vvMJqoARGeLl89eC8=;
        b=lh4za3xaTooJfbOeXMng1u3MjSxWc2HhVsNObUs5jj06JlvMqZu/IWYTVsv7WRr8Yq
         +RD6LF67WLbpj674PvIqT1c+mm/V/E9Y6qS42OeH3AGU8J9qCH45dPp4UrrKawDocPCT
         TLlIKznAvXBe2BdyTkRGmnyhLxR8OoTvpJe8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/FKJGJCQ2WFjnbO5YcetVVfi3vvMJqoARGeLl89eC8=;
        b=sSXg3haziQ6ozSDT+tktATqkQNl3bIqGZ4cgrvvcpTG8l3nTBPgzoj3LV2xlT2bnhb
         OC4Bl1RqOJl44YfDGhAgeHwYV/f00n0W/NRFBipdA2BCB29lEcAi16WskTsaTiKqsPsz
         6cmdbbJmouLD0yta3N2m6q/By9sU3tj4EMoc/pJQFGfRzEpS+vNFeCoUfIKrUYv2iw5w
         jXbthEHggHhifIzXdk/3lsu5givpkfSjA3zp2A4BRQdDf5JtEOxn2PHWO9K7iFunqvhi
         sI1jkIBvs5oDKvl7cGEwdGzH7l7nv0A3c9UC6asVuIR0YxMQDnPgKUSI2r46XcaFVUja
         ewkw==
X-Gm-Message-State: AOAM531hGf0IZQT9KP3wHGZ0AA0waAp9hDKRn2OtlbYtt89fM8gJExQH
        gLeqqufvLT7DFkQRQntmVZZ/qg==
X-Google-Smtp-Source: ABdhPJzK7f9E96uhGaYj9Z8XDC4clhUq0a6o0CReg/QOI2eaar9BmY6biZNhpeflByLUdzTTvNXTMg==
X-Received: by 2002:a17:902:a58b:b029:ee:d13a:2642 with SMTP id az11-20020a170902a58bb02900eed13a2642mr5016303plb.35.1620018373006;
        Sun, 02 May 2021 22:06:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q128sm7743860pfb.67.2021.05.02.22.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 22:06:11 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Erhard F." <erhard_f@mailbox.org>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] drm/radeon: Fix off-by-one power_state index heap overwrite
Date:   Sun,  2 May 2021 22:06:06 -0700
Message-Id: <20210503050608.2158996-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an attempt at fixing a bug[1] uncovered by the relocation of
the slab freelist pointer offset, as well as some related clean-ups.

I don't have hardware to do runtime testing, but it builds. ;)

-Kees

[1] https://bugzilla.kernel.org/show_bug.cgi?id=211537

Kees Cook (2):
  drm/radeon: Fix off-by-one power_state index heap overwrite
  drm/radeon: Avoid power table parsing memory leaks

 drivers/gpu/drm/radeon/radeon_atombios.c | 26 ++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

-- 
2.25.1

