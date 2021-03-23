Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF61345A40
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhCWJBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhCWJBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:01:15 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B87CC061756
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:01:15 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v3so11018388pgq.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fyArqXnJjHDh28MyaKADOf6onNt6E9lEvyDzFgvh3mY=;
        b=huB/b9BShjggioTljIzh59gfKp/8aJQJxPGUojT0HTsyTXHD4/2zPb6jG2p6/XQfpQ
         43R74G1FVSkxGlwyk1k//zo1aiDC85P3oFg3K/dmzef79XiRlMofXaMbvDiNNOtt+avy
         2p/Oczokg/XjDUidP/Uiz473H1LfIaItA976tNqlkkvmF6R0lbMh5z7iJDoaDrL8Sm10
         E9onDo2jidUJ/7fLthi7uJQHwBS22wNPSqthqENXfLJLYnlHCdiyCUMhxB3rDvX/DFyA
         yWaAKFjAkZS5WZA/ClDehCG8cOAy+CFc7j0Xo8Qt7IRFw9fUmz3rDDP47QEBIM101jYu
         3I8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fyArqXnJjHDh28MyaKADOf6onNt6E9lEvyDzFgvh3mY=;
        b=rH8/Ve5Tu9seADCwIWtx/UH93JSbH12mcrt4CpUyvU7hRlJ5Ojn930QnpkymgxVSra
         cL9QBsdXF0/wLSHKm36G9X3m5FBnNFW9WGIgXB5DnlBL2uVHHiXPdyrQbykGT396TOJD
         OHIsl22/D1xv29ttDD+2enpVXkvhCysabfeOCpMVFoZ5eB8xNmLxxqIoXgDcBFPPjPKj
         u5v9PV8FEFy/oKw/YoIHQ4eZLWkNttYaKeqkWyEPlAD1f2rTHipVwHgBgX8eogif3v0y
         pS4iMNxkDcn6oEIY2QSMFoZM1PRYhmEkCe3Z2RnDEB4l4+936/5/1NcwZ66EV70tsmzb
         jyvQ==
X-Gm-Message-State: AOAM532esu2/C0+DbEXeutTMZn8s5CE1JICn/sUIM/WnhsGh7qVXgKtW
        tthXuOqtM/SsM3kUHajhpRW08A==
X-Google-Smtp-Source: ABdhPJyM+E6Cf275JkaW7D3hyXAsFBC0en8IOE/onyVB70+iS/E90QG4BL5MINbOcxlEnrYjtXSS4Q==
X-Received: by 2002:a63:5807:: with SMTP id m7mr3131870pgb.73.1616490074526;
        Tue, 23 Mar 2021 02:01:14 -0700 (PDT)
Received: from localhost ([122.172.6.13])
        by smtp.gmail.com with ESMTPSA id gt22sm1966188pjb.35.2021.03.23.02.01.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Mar 2021 02:01:10 -0700 (PDT)
Date:   Tue, 23 Mar 2021 14:31:08 +0530
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
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210323090108.ygx76exdgzudeeqi@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-21, 22:19, Jie Deng wrote:
> +static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> +{
> +	struct virtio_i2c *vi = i2c_get_adapdata(adap);
> +	struct virtqueue *vq = vi->vq;
> +	struct virtio_i2c_req *reqs;
> +	unsigned long time_left;
> +	int ret, nr;
> +
> +	reqs = kcalloc(num, sizeof(*reqs), GFP_KERNEL);
> +	if (!reqs)
> +		return -ENOMEM;
> +
> +	mutex_lock(&vi->lock);
> +
> +	ret = virtio_i2c_send_reqs(vq, reqs, msgs, num);
> +	if (ret == 0)
> +		goto err_unlock_free;
> +
> +	nr = ret;
> +	reinit_completion(&vi->completion);

I think I may have found a possible bug here. This reinit_completion() must
happen before we call virtio_i2c_send_reqs(). It is certainly possible (surely
in corner cases) that virtio_i2c_msg_done() may get called right after
virtio_i2c_send_reqs() and before we were able to call reinit_completion(). And
in that case we will never see the completion happen at all.

> +	virtqueue_kick(vq);

-- 
viresh
