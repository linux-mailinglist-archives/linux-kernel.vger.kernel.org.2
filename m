Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D536E32BC74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350400AbhCCN5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582448AbhCCKWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:09 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AFAC08EA3E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:38:39 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id a4so15912688pgc.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 01:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iUz312iac7LFNx2ya66Z5XkzPT8yJgIVgv7MyKSn4VE=;
        b=wsvDAZ+Xcf6/ydZfSDPUq/Okd3uBkptJGGE9RJHceUdEF5+vAcEJbCEi51CMol+zqq
         9rt2UAvNAxwrzFA9kfvMQ56S27ZzM9rcoelSCOVAu/ujrIml3XvOHj4Vd4GUYjhTsIll
         ySf61ycmoJLJp0Do7bDtNB8zj6/AJhwvu61ZTv6DdMN+XBga+G3UlWwmN/I3HejzcH5J
         bJa7lpigkf8L94Ca1VYtwPvTJm+BJncEcbPlpLj4M8bJTFtSzfpHn7bhCgD8s0wVPn5b
         MYA4z+MP+6rg0oub0KuLd7ZcqbmRCzFxVdjOhkhBTASf3VtoVZgMe6SWWf8DqLni274p
         PLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iUz312iac7LFNx2ya66Z5XkzPT8yJgIVgv7MyKSn4VE=;
        b=EIE26F/JqL8R0a0q9B+qt1PgyfyroUgRIGushdAHx19THTuSe4Znt44jCMJmGBogEs
         8VWJIv61XiMA8xkhqeW8ODAKu8dtO2CDgFHgXFomWdMa6ie9hergDK2LahxfLva2bB1B
         3XGfWj0tPlgm0Ay31FOaa+cKJiXc2R+4avB7AgrxfpL7MZGZBoiv0zeSyxdpDm7TjFB2
         5WpoKVPZcHepJv9FK/vD7W0QuIuqEfIqKAdPf/sZ3wBYozbPeyN5x+v9QMOdJqwal+bJ
         A/DC6QIwmSty7oYcWEeGubPDBSh4ZrW+qdSVJBeH6MqEjqSDgQW8k8EWK8f9eWacmR++
         h78w==
X-Gm-Message-State: AOAM532N8HQ3whSuuJU+Xjc49BgWAltlnyvch88qtGasi0WMssC76KUO
        DrhxhunWqcVDzm5cMx2kBv9QAw==
X-Google-Smtp-Source: ABdhPJyIymaBHw/Yi0uxQqi7IJAz4uFHceC34phcsMTa1e/8lj0QDSfk15NedkVO7Kk9PIJ9nkKTGA==
X-Received: by 2002:a63:5647:: with SMTP id g7mr21806900pgm.113.1614764319033;
        Wed, 03 Mar 2021 01:38:39 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id fr23sm5894999pjb.22.2021.03.03.01.38.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Mar 2021 01:38:38 -0800 (PST)
Date:   Wed, 3 Mar 2021 15:08:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jie Deng <jie.deng@intel.com>
Cc:     Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, wsa@kernel.org,
        jasowang@redhat.com, wsa+renesas@sang-engineering.com,
        andriy.shevchenko@linux.intel.com, conghui.chen@intel.com,
        arnd@arndb.de, kblaiech@mellanox.com,
        jarkko.nikula@linux.intel.com, Sergey.Semin@baikalelectronics.ru,
        rppt@kernel.org, loic.poulain@linaro.org, tali.perry1@gmail.com,
        u.kleine-koenig@pengutronix.de, bjorn.andersson@linaro.org,
        yu1.wang@intel.com, shuo.a.liu@intel.com,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210303093836.ftgq62yw7i6cd3q6@vireshk-i7>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <20210303075430.n7ewkots6cgbbabi@vireshk-i7>
 <876371c3-ba9a-5176-493b-5a883cba3b07@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <876371c3-ba9a-5176-493b-5a883cba3b07@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-03-21, 16:46, Jie Deng wrote:
> This is not a problem. My original proposal was to mirror the struct
> i2c_msg.
> The code you looked at was based on that.
> However, the virtio TC prefer not to mirror it. They have some concerns.
> For example, there is a bit I2C_M_RD in i2c_msg.flag which has the same
> meaning with
> the R/W in virtio descriptor. This is a repetition which may cause problems.
> So the virtio_i2c_out_hdr.flags is used to instead of i2c_msg.flags for
> extension.

So by default we don't support any of the existing flags except
I2C_M_RD?

#define I2C_M_TEN		0x0010	/* this is a ten bit chip address */
#define I2C_M_RD		0x0001	/* read data, from slave to master */
#define I2C_M_STOP		0x8000	/* if I2C_FUNC_PROTOCOL_MANGLING */
#define I2C_M_NOSTART		0x4000	/* if I2C_FUNC_NOSTART */
#define I2C_M_REV_DIR_ADDR	0x2000	/* if I2C_FUNC_PROTOCOL_MANGLING */
#define I2C_M_IGNORE_NAK	0x1000	/* if I2C_FUNC_PROTOCOL_MANGLING */
#define I2C_M_NO_RD_ACK		0x0800	/* if I2C_FUNC_PROTOCOL_MANGLING */
#define I2C_M_RECV_LEN		0x0400	/* length will be first received byte */

How do we work with clients who want to use such flags now ?

-- 
viresh
