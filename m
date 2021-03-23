Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961223458AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCWH13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhCWH1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:27:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDCBC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:27:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso9729744pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gGeRB88m4LbylepUsHVs5jG9RdzxbouIyHF+uNiepy8=;
        b=WSsIdZwW2T1Bl6+f6YiJK1Eay8sgmO/duoU6AoDQ+twPvTQU/65ZMqoBMobOEGEhet
         iRvsambSYsM3TcAxntGgVVL9SBNGh2wmBlPk4IcRpSiZuks6vbCmbFMHM6wuvVijMGf6
         wCB/FjI5+s/5QZa//5YylYEP9soMPXCLmNHcy31Zk3aFJP97UPGU5yENyb6N7BLBZzut
         /TVnjfuPG5T9g0ipl5hzbm8cvrQZTV/CRdcXEApWhgCaDBA6ulIZualtBLlo64brNcGf
         hpnEb0TXLWXI4olJ2yBILJuuZb7ZIlspzoSH48PdzK5MVjnK63bOmH7IK/+pYdIg9PNi
         Sbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gGeRB88m4LbylepUsHVs5jG9RdzxbouIyHF+uNiepy8=;
        b=bOdF9YMs1ybqZQKFNKwbEgmRpn58SpcjWXRhjwu2BYoKe0EZ8KM6OdMznZrWFJlEfs
         zI4UoIYfr/Uln/SDY5kb71m/CkRo1YYIvwlcPAV3fk7qxzrbqfqQjQf/JfoXRUx5eWm0
         E9t4z/P4XaF9Rnpjuy2kLiHd8L+i/V+3MSCW7b/4dJymGikz+VQ6r5ayMJygvFy1o0oC
         Gs6UteUKeX6nz3CsxurrtWZrQIAMUafZDIdL1edDVJ+D73b23K/uoFctQArJCq7YpNws
         AymtKZkmXkBXCCojXiDgRS8glmIJgM65m2tYtXPZG5mK+yAJkuYUhdu33r8+wpwTB1YK
         x3Hw==
X-Gm-Message-State: AOAM533xhMH0kazwNk+Iq7pAKb0+ZMNP8NR2sbyKcjbF9s+M3GbY9QeN
        CtEuUIiDZEmhryXp/X4WaCjBxgGftC28QA==
X-Google-Smtp-Source: ABdhPJxyYqSqOFtHL+tSjcc4n3I0HoyLGBEUDj9eSPe8qLlbrvqf4PuNl4by9WSYS9NQ8PbCLqr+Rw==
X-Received: by 2002:a17:90b:4d0c:: with SMTP id mw12mr3327864pjb.216.1616484427374;
        Tue, 23 Mar 2021 00:27:07 -0700 (PDT)
Received: from localhost ([122.172.6.13])
        by smtp.gmail.com with ESMTPSA id cv3sm1621893pjb.9.2021.03.23.00.27.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Mar 2021 00:27:06 -0700 (PDT)
Date:   Tue, 23 Mar 2021 12:57:04 +0530
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
Message-ID: <20210323072704.rgoelmq62fl2wjjf@vireshk-i7>
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
> +static int __maybe_unused virtio_i2c_freeze(struct virtio_device *vdev)
> +{
> +	virtio_i2c_del_vqs(vdev);
> +	return 0;
> +}
> +
> +static int __maybe_unused virtio_i2c_restore(struct virtio_device *vdev)
> +{
> +	return virtio_i2c_setup_vqs(vdev->priv);
> +}

Sorry for not looking at this earlier, but shouldn't we enclose the above two
within #ifdef CONFIG_PM_SLEEP instead and drop the __maybe_unused ?

> +
> +static struct virtio_driver virtio_i2c_driver = {
> +	.id_table	= id_table,
> +	.probe		= virtio_i2c_probe,
> +	.remove		= virtio_i2c_remove,
> +	.driver	= {
> +		.name	= "i2c_virtio",
> +	},
> +#ifdef CONFIG_PM_SLEEP
> +	.freeze = virtio_i2c_freeze,
> +	.restore = virtio_i2c_restore,
> +#endif
> +};

-- 
viresh
