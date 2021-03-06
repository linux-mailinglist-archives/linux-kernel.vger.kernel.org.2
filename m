Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF50E32FD29
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 21:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhCFUg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 15:36:28 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:36544 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhCFUgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 15:36:24 -0500
Received: by mail-pj1-f49.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so957583pjh.1;
        Sat, 06 Mar 2021 12:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kxst1hG7ALyCmuPlQ7JFD7SMZloRyR6/yTfXMK8W7T0=;
        b=hF159ji8oR92LgUpHS4NKAf0lpQwhTmVLmn4LNokqwj9gXSjedaXnDxYuYlxPhdVEZ
         GaBerzJYExH2Ad41sPwa1e+Hwi/mVuOPL8jC1zpTSbg7Ayd67+HUQtvzZSbPondtJOlF
         NqiTWVJkfrJLnEcOAqEn/QCLBTnoPgwRA16YPgZbZFQpiEmLnXIreeIumzYGD99BU8yT
         NUPIcUD1RoIabQSMnrZN+QLyFB+d8OpgKT8cDMEuopo2RKmIS9EazDh1YPOWAfu5T9ka
         mGyXbcLc1FaX7EfSIhYjTn4S4cliTBVjD7Gj2kl2WAdfPGYbNfr4gsqUiyg/gyicYrPQ
         pPKg==
X-Gm-Message-State: AOAM531Y4BRjSUqPq+/oiWJcZPXKCnyVu9mfVQhYwTzoSNQKzGlXCr+H
        7t+n06r5dyJ/kY4MgJV09A==
X-Google-Smtp-Source: ABdhPJz0P+6rkvVUSXxTrcwxqhCKO6b8X5k2tVKedc0iXxGFF8nD+HcxsXL0EuR95YHQZyqlJKMczg==
X-Received: by 2002:a17:90b:809:: with SMTP id bk9mr16677761pjb.83.1615062983602;
        Sat, 06 Mar 2021 12:36:23 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.27.98])
        by smtp.gmail.com with ESMTPSA id t22sm6300886pjw.54.2021.03.06.12.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 12:36:22 -0800 (PST)
Received: (nullmailer pid 1172590 invoked by uid 1000);
        Sat, 06 Mar 2021 20:36:17 -0000
Date:   Sat, 6 Mar 2021 13:36:17 -0700
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/7] ASoC: dt-bindings: imx-rpmsg: Add binding doc for
 rpmsg machine driver
Message-ID: <20210306203617.GA1164939@robh.at.kernel.org>
References: <1614221563-26822-1-git-send-email-shengjiu.wang@nxp.com>
 <1614221563-26822-8-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614221563-26822-8-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 10:52:43AM +0800, Shengjiu Wang wrote:
> Imx-rpmsg is a new added machine driver for supporting audio on Cortex-M
> core. The Cortex-M core will control the audio interface, DMA and audio
> codec, setup the pipeline, the audio driver on Cortex-A core side is just
> to communitcate with M core, it is a virtual sound card and don't touch
> the hardware.

This sounds like 1 h/w block (the interface to the cortex-M), your DT 
should be 1 node. If you need 2 drivers to satisfy the needs of the OS, 
then instantiate one device from the other device's driver.

Rob
