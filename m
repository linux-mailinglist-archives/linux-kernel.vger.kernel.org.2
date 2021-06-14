Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2272A3A6D48
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 19:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhFNRjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 13:39:06 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:41848 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbhFNRjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 13:39:04 -0400
Received: by mail-pl1-f170.google.com with SMTP id e1so6954086plh.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=jFxOJ2sNlaTP2oY/1tOoZt+pjnC/fp0BF0cd3UacWKs=;
        b=PBufRmGAhMtuvaAA3A9gVrHkgFthtx5a9k9CdTuC7Zk6bWxhjqsUwjSkCMgQYLqD6D
         D/Cb+nXpHp4ofir1Yx0TZ/W1PfpzP3535b+toBTglbx4ind/t2CkaBO07RwSXL84pzH8
         QmxQO+YJ/ooTDsUWzgyvJ2rKRGieHBzxIWWPdlvUUsipsA/0E+e9ZCnNe0JkRtIeL0qp
         JkuxERee00bdtOznIBuNfwWcL0P3JNRsjDT1R2MEW4NKhDAic+VM0/KekJLmc4OMCfDi
         nPEDFQh4tnCU9soyFaFR/JpatLgo+QaGqzTVxCU6Z+7H+TOA1qjHCZfs6MvDDgDduaHn
         u5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jFxOJ2sNlaTP2oY/1tOoZt+pjnC/fp0BF0cd3UacWKs=;
        b=jLIFeVW3j6vdaOYjMDf7RanqFebpxP8V38HLJC4gVm1qJ5uSHUIro933DDAipQc9vn
         3FDX4AIEAOaKauwSPqpoQKT0FNYIgm1Zgz4IQshdPd2BA/Zd3OGHBD1GwoUCyzUdhZx9
         OQZ2dUm9l+JYH/Xf20M35J1JCwxPOlbF+ZkPX8G65okPz2eyF1ypokN/8EZZyNXwx1He
         u9yaZjCYW1Sy3+b5SREDul/2Xk3jhM6olwQ3iila9OadD2tw7fH+/NOxB2v2NuO3YozJ
         0HpcedolSZuDiQdQAeZGVOdPUP+07mqSRWamqgjncGFtLF/hz0sgoQt8kupTFV92bWFC
         Tlsw==
X-Gm-Message-State: AOAM532QZSCt+qFYUHqTeIoBU5BdLUanvCZnXtZ0N9wYtHUCM/CZL8hJ
        qZ7PeMO0038yOR0IAowxgcgJ7w==
X-Google-Smtp-Source: ABdhPJznWNeTiit7/SGu60G684FYkuKoY8YSsBjZc3t8NAngrtT4QqDdIbNZcZWdN8/t0QD2Z9vO8Q==
X-Received: by 2002:a17:90a:3801:: with SMTP id w1mr258363pjb.138.1623692161330;
        Mon, 14 Jun 2021 10:36:01 -0700 (PDT)
Received: from localhost ([2601:602:9200:1465:3410:5b3a:5eb6:9380])
        by smtp.gmail.com with ESMTPSA id 21sm13521088pfy.92.2021.06.14.10.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:36:00 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arm64: meson: remove COMMON_CLK
In-Reply-To: <20210609202009.1424879-1-jbrunet@baylibre.com>
References: <20210609202009.1424879-1-jbrunet@baylibre.com>
Date:   Mon, 14 Jun 2021 10:36:00 -0700
Message-ID: <7him2gxsan.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This reverts commit aea7a80ad5effd48f44a7a08c3903168be038a43.
> Selecting COMMON_CLK is not necessary, it is already selected by
> CONFIG_ARM64
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
