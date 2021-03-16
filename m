Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7756433CEE9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 08:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhCPHyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 03:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbhCPHxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 03:53:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7449CC061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 00:53:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id a8so10040052plp.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oqKYtA+kp5icsOtqbHlnK/kSHBj/+oyYeKvAk2jPsoA=;
        b=E9EtFvZNPriX/pMcFmLJxX2wIDBXCFantcdiaAOk9RsAAMLFvBDCpTyIABXYDmDDPe
         RqcNiz/5aVb6TSrfxLc77IYsIeTJV2Z8VEF2igmWnT/tMx72jrOZcFBwnne/DB2jTo1B
         9OSnhnOFTK3zta8hEtOI/dwRKSHFXKbZ/gI+8Bh+RMgoR5ERhy4onvxTyM/8dFSkhW74
         UKF5ewCrU7ELDsLMJH3U5CJguyHiP9nBGyNKBWgRgCAt+hoRS1iHIzo5euru2zM8MRni
         tSbfR8SLQGoOCZcN5/LCcMXpYckkcD1sWG5tquY5xxpQxA0Gj5/bBy+vMGqZtAEtvsuy
         5BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oqKYtA+kp5icsOtqbHlnK/kSHBj/+oyYeKvAk2jPsoA=;
        b=ub+4YsllYr7xZqJnNHwjly485rZRoTtYnrM1LYmmurpw7voiGgJW9fYQfrQ+ZL7VW/
         NN07QwGSbQGqEKGnTwlsrkc0iQ3QRe5qCsMAT83j5cgMDPvO7TCzEhi81K35Dk8q6J6Z
         R0W/ihTbLGv8QWyO0lCOGUXDClBfJUfwmAiFEIsixXiiehaz2InE/bAeIiXHdavmPCxa
         kpv/5kCTZjneOvN0Wru8g6TvPjDAOz41otfypgwLRnUVL9ZJuC98pfIbYD7aRq3Pbqqq
         snc4diWMREwTk/P55E8NmJNZAIldymT4iXQ2n/Ceeid3PMBTKjiBj4MPc5KZLE4JISDI
         WomA==
X-Gm-Message-State: AOAM531T0Ga6w4bnF5m+PalXcTiiZe1/MiJQjBdAixSlCuycZC7xFuSe
        F+GJ1744NTJSm4nAbGzvSIhUAVxgll6Dow==
X-Google-Smtp-Source: ABdhPJwx8gyMOW3Y9RvDaRKKaSCnmAmUVuQo7dlEldeBkO85oTCtuy41CKcBxVD26kx56hU+LKxKTQ==
X-Received: by 2002:a17:90a:ab91:: with SMTP id n17mr3684396pjq.4.1615881225974;
        Tue, 16 Mar 2021 00:53:45 -0700 (PDT)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id z4sm15392406pgv.73.2021.03.16.00.53.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Mar 2021 00:53:45 -0700 (PDT)
Date:   Tue, 16 Mar 2021 13:23:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jie Deng <jie.deng@intel.com>
Cc:     linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, wsa@kernel.org,
        jasowang@redhat.com, wsa+renesas@sang-engineering.com,
        andriy.shevchenko@linux.intel.com, conghui.chen@intel.com,
        arnd@arndb.de, kblaiech@mellanox.com,
        jarkko.nikula@linux.intel.com, Sergey.Semin@baikalelectronics.ru,
        rppt@kernel.org, loic.poulain@linaro.org, tali.perry1@gmail.com,
        u.kleine-koenig@pengutronix.de, bjorn.andersson@linaro.org,
        yu1.wang@intel.com, shuo.a.liu@intel.com, stefanha@redhat.com,
        pbonzini@redhat.com
Subject: Re: [PATCH v8] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210316075343.zi5rtrfdjsohhu4t@vireshk-i7>
References: <c193b92d8d22ba439bb1b260d26d4b76f57d4840.1615889867.git.jie.deng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c193b92d8d22ba439bb1b260d26d4b76f57d4840.1615889867.git.jie.deng@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-21, 18:35, Jie Deng wrote:
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> +struct virtio_i2c {
> +	struct virtio_device *vdev;
> +	struct completion completion;
> +	struct i2c_adapter *adap;
> +	struct mutex lock;
> +	struct virtqueue *vq;
> +};

> +static struct i2c_adapter virtio_adapter = {
> +	.owner = THIS_MODULE,
> +	.name = "Virtio I2C Adapter",
> +	.class = I2C_CLASS_DEPRECATED,
> +	.algo = &virtio_algorithm,
> +};

And FWIW, I still have my concerns about mutex-lock and
I2C_CLASS_DEPRECATED, but yeah we need Wolfram to confirm on them.

LGTM otherwise.

-- 
viresh
