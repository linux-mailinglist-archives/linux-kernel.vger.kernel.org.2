Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223E5397AA3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhFATWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbhFATWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:22:40 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06255C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 12:20:58 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id n12so142073pgs.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 12:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m15CB+ejyy1cEkOR8H2bWbxrq91PVD9VpCzkcmHk69k=;
        b=MOHL6Rg4BBPH5wiP7w1yra4HQYcxXWk5JaXhb8kOdJlrkaBNrVv7mmwsmtvCStcM1A
         OhKOQmGxSkEQcMAOjxfYcUHNTyz+O+AwoIjUhtVBIWwrbKhgzUiaGszsQnOPvxlZMj9S
         029lEjbq00R7EtmOTsV6VUMYldCmtYhQvZud8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m15CB+ejyy1cEkOR8H2bWbxrq91PVD9VpCzkcmHk69k=;
        b=Hy/z5LRpzk92JnRbMj08PwkY2gIAijTj8sbqjiDwzP/W2z5S4kwyR6kfew6KlorNr4
         F7YwmHJxQg6iVS6synwllo+XwzD5wnqcu92k1u+CJct1GtefbWBnQj2A8K7UpAWLDnRp
         kEn/o6gMlDUS/5gALiU/4FQ0HOC8hECO4eg4n1b74xXjZ4mPtD39PmPshNSWvB/rAz+b
         i6zzRk4C1LOFlmn1r80FOdwS5e7xwDjGgSm39kZh/6Y9gT7b2WrKujw+89FjI5hdrsAN
         8vuV1R+lU6/G7v7WZbLgJ5IXsUZ0vyaduIMp+fTp4Ccd0CVEFuATRFLGStKlqxsWZ5oj
         4aKQ==
X-Gm-Message-State: AOAM531VSp6YaLSCP1zlGBBT5jruc0u2IDS7lrzZ/J6O0Ov9qIZr8P4W
        1g7I2bptHDSrpvRUj8PMe1is+bPlY++OGg==
X-Google-Smtp-Source: ABdhPJynQ1oAhjuOu6Yt5pPtGgDrZIwV5A6brhRT0bSHWLsB1ZGgvxq1cMuCHenAxXt3FQZ4B20oLg==
X-Received: by 2002:a65:4d03:: with SMTP id i3mr29670528pgt.422.1622575257623;
        Tue, 01 Jun 2021 12:20:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p26sm2507483pfw.178.2021.06.01.12.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:20:56 -0700 (PDT)
Date:   Tue, 1 Jun 2021 12:20:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: ti: davinci-mcasp: Fix fall-through warning
 for Clang
Message-ID: <202106011220.82270074FC@keescook>
References: <20210528202047.GA39602@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528202047.GA39602@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 03:20:47PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a goto statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
