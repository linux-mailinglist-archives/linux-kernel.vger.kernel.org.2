Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CF644266A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 05:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhKBEfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 00:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhKBEfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 00:35:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8D2C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 21:32:40 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r28so19124454pga.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 21:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lBdFLUAdGQcZpaP3XreKK6gk0Uyq547fw5ShqeoqV9s=;
        b=vH3Gibd1V+TOGpERdFzacQ0OtrsTCQ6h4W9sZMgBW/bjrtM6vDhswoZeGqHKmUGlc7
         FsN74pqxt6eLbskqWYocjIlQjpAkDaEvh9LvcqIX5N9zwbHTn+com8lunmYYnlmPQNg4
         7kUhXpD0nbLOi0PcrZBw2DDuAzwWaJgULggsoM3hYypIZcI2O0iycs0y9NYSxTAh3+fN
         Bc8WrJ/YgM2FoYEcFbNgXNrT9F0T80GaThILppaN//bsPb3Tfs0luNAgS2XOy3b1GUDH
         KHUdr1POq6jMuyx2oShQA61rVD/UEB4Lww5VaFZcutFlCnw6l/H4MAxTn10GeByV6WSs
         dAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lBdFLUAdGQcZpaP3XreKK6gk0Uyq547fw5ShqeoqV9s=;
        b=WuQWvez76bfTmV78/8GGr7CPxbaQ3EYyMkA9rGw4FMcDWalu8H617VZInA9MRQS9kP
         GdO5DAD+O6IqPe2r6hvjusUkgjmwp5UK/RFAJ7U9beQGpnfo/9ZwFwGsEpOXIK8rcLaf
         wLLCqsyymDmad4k4HqAs6nk0ifDqN78ug7CYOOis8rOtx/XoRhm7r6oTf/Oov53oZz/v
         7UBqmkAz0+NI/jARVvhn+U7H+8rhw/2+HPEgX72k4TK1dPryDbHh5wap7AGyTpNBWVCj
         52yJVSVl0UY45r0G0PFWbpwVT0McEoBBQBUbFtWxIPDpdIMOBn1+tY+U3RJwHNBznhBH
         Ekrg==
X-Gm-Message-State: AOAM531GEvqMkT0WpQxGAa0Y8gkfRb5gqdrvXGlODB5byCk3KV6DWeQa
        7uxSvvZCwhZo4kMasquTDy8zEA==
X-Google-Smtp-Source: ABdhPJyu8mpUiJ+98wGmV5t0oBFG/t+vKOHPikcPoxUoKtE0rIqGYOlWuqj/t1v3sT/9biqwO5AwXQ==
X-Received: by 2002:aa7:8b0d:0:b0:44c:89ca:7844 with SMTP id f13-20020aa78b0d000000b0044c89ca7844mr33802758pfd.19.1635827559852;
        Mon, 01 Nov 2021 21:32:39 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id kx3sm949628pjb.5.2021.11.01.21.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 21:32:39 -0700 (PDT)
Date:   Tue, 2 Nov 2021 10:02:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     wsa@kernel.org, jie.deng@intel.com,
        virtualization@lists.linux-foundation.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH 2/2] i2c: virtio: fix completion handling
Message-ID: <20211102043237.nhzspynla2a37pok@vireshk-i7>
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-3-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019074647.19061-3-vincent.whitchurch@axis.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-21, 09:46, Vincent Whitchurch wrote:
> The driver currently assumes that the notify callback is only received
> when the device is done with all the queued buffers.
> 
> However, this is not true, since the notify callback could be called
> without any of the queued buffers being completed (for example, with
> virtio-pci and shared interrupts) or with only some of the buffers being
> completed (since the driver makes them available to the device in
> multiple separate virtqueue_add_sgs() calls).
> 
> This can lead to incorrect data on the I2C bus or memory corruption in
> the guest if the device operates on buffers which are have been freed by
> the driver.  (The WARN_ON in the driver is also triggered.)
> 
>  BUG kmalloc-128 (Tainted: G        W        ): Poison overwritten
>  First byte 0x0 instead of 0x6b
>  Allocated in i2cdev_ioctl_rdwr+0x9d/0x1de age=243 cpu=0 pid=28
>  	memdup_user+0x2e/0xbd
>  	i2cdev_ioctl_rdwr+0x9d/0x1de
>  	i2cdev_ioctl+0x247/0x2ed
>  	vfs_ioctl+0x21/0x30
>  	sys_ioctl+0xb18/0xb41
>  Freed in i2cdev_ioctl_rdwr+0x1bb/0x1de age=68 cpu=0 pid=28
>  	kfree+0x1bd/0x1cc
>  	i2cdev_ioctl_rdwr+0x1bb/0x1de
>  	i2cdev_ioctl+0x247/0x2ed
>  	vfs_ioctl+0x21/0x30
>  	sys_ioctl+0xb18/0xb41
> 
> Fix this by calling virtio_get_buf() from the notify handler like other
> virtio drivers and by actually waiting for all the buffers to be
> completed.
> 

Add a fixes tag here please, so it can get picked to the buggy kernel
version as well.

> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
