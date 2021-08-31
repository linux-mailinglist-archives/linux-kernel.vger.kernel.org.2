Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0423FCD5E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 21:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbhHaTCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 15:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbhHaTCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 15:02:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E302C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 12:01:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q14so718665wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GaO4Y8XjQpzWxvDdexo754mM2cY3NapS9Dixf6RCivI=;
        b=YUG3gg4HztKsujLCsWJkVM63g5Ld67nElGVgmaaKpnO00peskYekUXADHXQacrLLGZ
         o4kXYmPzBOKFaZilUon4gZHiF50Ky/lT2mqJjuPaMZ+J8UbDEvFQz6btJTc7yvwOjRm2
         MsPulb8kG37VQyBoPlAQ93dGI1slLOtc4kRiF7UBlHF8R4bsNs2nMQ/vG2vU4YOWWNPf
         aHuHQqGdNBST9fzF0d4kW3VGCet8xSyjzRnp5/WwZlcEmkIMlcudjGv2ljcmAfGiLiFz
         DsbIDLvg6yBpIL6zjIqn+Yxlo2uiGL8StBibDApyH4aHAgaaYWn6iEKqIBmQxbjM94Mi
         uXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GaO4Y8XjQpzWxvDdexo754mM2cY3NapS9Dixf6RCivI=;
        b=CJJm1cKefxDixkfEaKKdAPgf6btprxcifaHwrh+xI8zDcxRVAFkQ5i+4h4i6DX2Zy4
         QpN5+Lta6TsHKLAUqbW0FF6K2wXGj7ShiXHU8F7jJ9evwtO5cHM8joWJRqMB1+JohwVI
         ZpLo1K+kbWOj0c/wr3PCxa5YqqAESo7gqWj6zaRTOXVvNTCjV6DvR1X8qb01hIXR985p
         MqLEBSvF+MkSUxKuEvq4wSLIy0jQC8pddloF0gCg1VNnFf7r6UjCBFIb6okLXB81HPEh
         qMBDwPZnp11gTqYYG8lsDo59A1lYCKvlRP2eJnWAZx/nyP9jhyz+PabK5hyIAIZDmqiH
         700w==
X-Gm-Message-State: AOAM530QtGwCuavQNQFN0jAgV+gxhpoOKLfjSInums8z9s3rcw7CHK4J
        VqWkd/j5vZXEJ67Sq0LZo4U=
X-Google-Smtp-Source: ABdhPJxOmIjlk4xNGEooBmwcvg3/uM6eZEOaaAuISu6L6yMnHMyNxJUsSeX6S3KIALWZ26cW9yF9cQ==
X-Received: by 2002:a5d:6e91:: with SMTP id k17mr33391524wrz.77.1630436464829;
        Tue, 31 Aug 2021 12:01:04 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id j17sm18906057wrh.67.2021.08.31.12.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 12:01:04 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     caihuoqing@baidu.com, Cai Huoqing <caihuoqing@baidu.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: Make use of the helper function devm_platform_ioremap_resource()
Date:   Tue, 31 Aug 2021 21:01:03 +0200
Message-ID: <3342147.tElmWuj8HH@kista>
In-Reply-To: <20210831135740.4826-1-caihuoqing@baidu.com>
References: <20210831135740.4826-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne torek, 31. avgust 2021 ob 15:57:39 CEST je Cai Huoqing napisal(a):
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


