Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2065845D01C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 23:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345242AbhKXWhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 17:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345074AbhKXWhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 17:37:15 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6E9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 14:34:04 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b12so7177261wrh.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 14:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t4Q2WMbwFeQlxE5UxwxCmdsVHaD6RTJAuT746XcgHHM=;
        b=MUG0/Jr37M49Ed9L1GWkptdvArVfAt2F4zRNyDNatp3LEqXgx2dzFxWfhSvuizU4ri
         PILlvSgtDqXocdyOZYAbxwy/CEos7FkxGPJUbUF1GlPiFvkEkPXN76E3zNXYatF6f6d+
         s1o7cPCaBC7wZcLgwLl4Go2vTFH5Sn9yoqnQ5QQY6Gd0p642vWpxEFib61HvFFadVUTh
         izCX5kjmMNW/b8eTAdcOu752J77M+L/pzm3Bb3402JY14dwioOPiKiZ4iYGDXXcZU4iX
         AJhvPQGinMzs33sf+aVa96fOJqNtkiWW0d1C7nJ6TWr+m9u2rF33Rab6FNhzhOD/WjKm
         pqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4Q2WMbwFeQlxE5UxwxCmdsVHaD6RTJAuT746XcgHHM=;
        b=EHMlGThiNHcXnRaitYJ0c+jwfhkgr2283j3c7lwJmm7DS1tNfb3ZxajiHFhWaw5oP9
         2fhMY/dvJ1xeAbl7x/ByPXlW3mgcr+Py8iULjUIZHiS9jNSYWbiUHDiEJsnlpZ/3UaHq
         Ygq8EU3uxz5BgQskhivNYAPKi2ALwd1GuARWfS6p4/9DYx5bWHyQ7v4dsgIpH+P4yyif
         +TN8eVoQ/CeHU7cFE5HMY/zHlhttMyw6tK8hgFALf4z/a3Ajuu3wvlrUOJ4O9OyX+0h8
         j5zaMDk22aj1ATFQoYoqryNaJ2O/K3YNoJum2rnei08qGT5tIHaX2jp10nvyUWa19u4H
         U1QQ==
X-Gm-Message-State: AOAM533FUsppibJD90Iva98Ee6keBUc+/VfSOo9kTThzbuDgTY/UDxni
        GG3fk7Bk71nD9UPSiV6tqEY=
X-Google-Smtp-Source: ABdhPJwzobNWdnlIEAjGt1nVfaCJcA9nbLer42dE1RjxTnPTuFWGOIoMp8BrVDZpiWCxc6iCF8PxaQ==
X-Received: by 2002:a5d:4ccc:: with SMTP id c12mr701595wrt.453.1637793243432;
        Wed, 24 Nov 2021 14:34:03 -0800 (PST)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id h22sm1214466wmq.14.2021.11.24.14.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 14:34:02 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: rockchip: i2s_tdm: Dup static DAI template
Date:   Wed, 24 Nov 2021 23:34:01 +0100
Message-ID: <8149774.Fl3yekHNAf@archbook>
In-Reply-To: <20211124212146.289133-1-frattaroli.nicolas@gmail.com>
References: <20211124212146.289133-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 24. November 2021 22:21:45 CET Nicolas Frattaroli wrote:
> Previously, the DAI template was used directly, which lead to
> fun bugs such as "why is my channels_max changing?" when one
> instantiated more than one i2s_tdm IP block in a device tree.
> 
> This change makes it so that we instead duplicate the template
> struct, and then use that.
> 
> Fixes: 081068fd6414 ("ASoC: rockchip: add support for i2s-tdm controller")
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

Disregard that, this patch is broken too because I still use i2s_tdm_dai
elsewhere in the code. I'll respin it in a v3 when I've actually slept
enough to not make these mistakes.

Sorry for the needless e-mail noise.

Regards,
Nicolas Frattaroli




