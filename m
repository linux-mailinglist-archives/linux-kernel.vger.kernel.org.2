Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5255A459F95
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbhKWJ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 04:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbhKWJ5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:57:39 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC96C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 01:54:31 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so1678619pja.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 01:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QSCZCVIM5tro7T7torOdfwmS3vTxofOoggZZ/saqbOU=;
        b=dv4lkXZuDXaNbEHrE2JqIa+zynhkxLOVE+c2MdRNeWLH/gsLT1pUoR6aZMXcChVTbB
         Gi2MEo9otlCa9TI1uVIvKEV8rAv3d5Ge/qKl9s6pXRkchmosDcXHg7ZEjqF+rOGz9AOS
         68gMFp1eXrcx6zTfrZP7V+LFKIAZ0jz6ctV6AgCvrZcrjUtQbDSW0a0MHptEeqNZPyhd
         lAdRajDBuGmdwJCgjwtzVEEjqVMHDWm6+yfUCfcUrYSHtd2vo7VU6HxPPYMtozcSGvFJ
         JWZbJWbGIIeiPDj+SdlxcmCqvFVAKJJDz4csPvZWli5j2UH3qDCqji26dlM1XaBL/5NC
         hYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QSCZCVIM5tro7T7torOdfwmS3vTxofOoggZZ/saqbOU=;
        b=MNm2hErp+F+xIMCnKZE9CiaGFYdaDIoCyqsUc/AzSooGvvNe7bROczkhG8iu0ADqso
         R1D+CZornkCNdQM414DOZF5w1+YPSSGUKTDUK/rJKrcCdvFaqzL7ZOaDkvuGxURTo0s4
         JnHG4FkWVU+SY5lFDDfDUCUmMJJ0dNJUdm8LHswD1w6eZuLwdmw902hIFGiWrrZqFeMB
         OV1I706ahHCT+vuWb1xCReNcX5kfHXeZQmIAmjDy75hjD7zd6xExsj6+OO4mdp8Bv3Kx
         f9UNbQ+ThFJvR/q0tDI6IS9gxL6gc8v5mCYT1CcsC1tgQ3izvVMBTOMuR0qlfJ6I9Txr
         KsHQ==
X-Gm-Message-State: AOAM532YI52Um0AUhVoDpEL2HrnYm2F6VTwBg2hFT+/BaNbRkSmXl+Zo
        W2uX90/+0836S1n7WQF5RZwMqg==
X-Google-Smtp-Source: ABdhPJwdbNswCrtvOdTklSGcl6W911admnD+WhCQoNtyWIgfzuZqHJUqyKRHgoe7ig4Trjt4mbT0eg==
X-Received: by 2002:a17:902:a40f:b0:143:d470:d66d with SMTP id p15-20020a170902a40f00b00143d470d66dmr5481723plq.52.1637661271149;
        Tue, 23 Nov 2021 01:54:31 -0800 (PST)
Received: from localhost ([122.181.57.99])
        by smtp.gmail.com with ESMTPSA id h6sm13770515pfh.82.2021.11.23.01.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 01:54:30 -0800 (PST)
Date:   Tue, 23 Nov 2021 15:24:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wolfram Sang <wsa@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        jie.deng@intel.com, conghui.chen@intel.com, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH v2 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211123095428.ke63esylaldgrfus@vireshk-i7>
References: <20211111160412.11980-1-vincent.whitchurch@axis.com>
 <20211111160412.11980-2-vincent.whitchurch@axis.com>
 <YZy5xVU4XHEaz+EL@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZy5xVU4XHEaz+EL@kunai>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-21, 10:52, Wolfram Sang wrote:
> On Thu, Nov 11, 2021 at 05:04:11PM +0100, Vincent Whitchurch wrote:
> > If a timeout is hit, it can result is incorrect data on the I2C bus
> > and/or memory corruptions in the guest since the device can still be
> > operating on the buffers it was given while the guest has freed them.
> > 
> > Here is, for example, the start of a slub_debug splat which was
> > triggered on the next transfer after one transfer was forced to timeout
> > by setting a breakpoint in the backend (rust-vmm/vhost-device):
> > 
> >  BUG kmalloc-1k (Not tainted): Poison overwritten
> >  First byte 0x1 instead of 0x6b
> >  Allocated in virtio_i2c_xfer+0x65/0x35c age=350 cpu=0 pid=29
> >  	__kmalloc+0xc2/0x1c9
> >  	virtio_i2c_xfer+0x65/0x35c
> >  	__i2c_transfer+0x429/0x57d
> >  	i2c_transfer+0x115/0x134
> >  	i2cdev_ioctl_rdwr+0x16a/0x1de
> >  	i2cdev_ioctl+0x247/0x2ed
> >  	vfs_ioctl+0x21/0x30
> >  	sys_ioctl+0xb18/0xb41
> >  Freed in virtio_i2c_xfer+0x32e/0x35c age=244 cpu=0 pid=29
> >  	kfree+0x1bd/0x1cc
> >  	virtio_i2c_xfer+0x32e/0x35c
> >  	__i2c_transfer+0x429/0x57d
> >  	i2c_transfer+0x115/0x134
> >  	i2cdev_ioctl_rdwr+0x16a/0x1de
> >  	i2cdev_ioctl+0x247/0x2ed
> >  	vfs_ioctl+0x21/0x30
> >  	sys_ioctl+0xb18/0xb41
> > 
> > There is no simple fix for this (the driver would have to always create
> > bounce buffers and hold on to them until the device eventually returns
> > the buffers), so just disable the timeout support for now.
> > 
> > Fixes: 3cfc88380413d20f ("i2c: virtio: add a virtio i2c frontend driver")
> > Acked-by: Jie Deng <jie.deng@intel.com>
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> 
> Applied to for-current, thanks!
> 

Thanks, I completely forgot replying to the last email from Vincent.

FWIW,

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
