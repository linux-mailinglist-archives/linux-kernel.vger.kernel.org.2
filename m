Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059BF347041
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhCXDwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbhCXDwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:52:32 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB55C0613D9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 20:52:32 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f10so6674119pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 20:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3j5OyUrftEzcDXX4MpjT7fR+wbe3Yv5y5R6X/vBZjJQ=;
        b=SLpHyYmHPpBuZfgEnc7aIx8GyYHbTlCdViwxtR0TEFAqoH6Co57I5/GH6Ghv7gYREK
         YoZDyi6GiHTtQirA7XKDDFL6oucRys/mzhTATHl/jQnCC/9Z59VS64azThymSHNOyOAP
         uk2USEmA7qpWhxfDT7ZVH/cevwiBf6lKq1YXy+yqSZKaJuaZi35Gh0IInr5qiVUrru9a
         LIOLJpqdf9SembDFDJhCW4jZJYj0Jtz4bBpv77+ypTAQlRTOv/ALj+tE1y+ghdzk9nRB
         t5Y7kdYGbTGolx/nZa15DGpe1a4G7dg9FQyIKVRC4elRXJCdoMr5EuY3ennhf90B5fVr
         010w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3j5OyUrftEzcDXX4MpjT7fR+wbe3Yv5y5R6X/vBZjJQ=;
        b=Cb1uZ16NJAnKDXmz0WMYSs+Iqx4w8yJEgHonFNAy0mTQtW+N3B0vvTOGXwKcnazaDd
         FnXkCG+16uvMZXj+cLIsRuc0ui8q0fk8FoM8O5hYN+oha+Q/2jZyS62tdrgEJ0xEYSMq
         5wSP7rocxYQ57KaJAMF8daLOaAShh2ZTNYSuuIaF13JNWZGeFliriRPZWy6eFc0gyOqp
         eR8/CL7b2nS/FeKL4FVQCvIqkr8o+2mJdy5o6RqJRU+JXK1Gtb3GH1MaD/lXXKhcPF21
         lDZTNGbYJtr/rbD+kgsvaMPPFXQMnYLF1VAPb58t89dfBGpWVpq+zZFuqvyo/siRhoU1
         JdMA==
X-Gm-Message-State: AOAM530RtzLWVmUauZFksWWgX6PnGyyKaq169kVBW+vka3je5yC3i4Pq
        xTd7oI/ve4PliWo8G7FtxiX7qg==
X-Google-Smtp-Source: ABdhPJwS7CzKG1KeSya4Uww0J2B7VcOU1nBY8jh4mVwy8qnnMCjeW6O7tPjhMNgQ2e7moAaEbcW9CA==
X-Received: by 2002:a62:3503:0:b029:1aa:6f15:b9fe with SMTP id c3-20020a6235030000b02901aa6f15b9femr1061153pfa.65.1616557951696;
        Tue, 23 Mar 2021 20:52:31 -0700 (PDT)
Received: from localhost ([122.172.6.13])
        by smtp.gmail.com with ESMTPSA id m5sm623171pfd.96.2021.03.23.20.52.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Mar 2021 20:52:28 -0700 (PDT)
Date:   Wed, 24 Mar 2021 09:22:25 +0530
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
Message-ID: <20210324035225.skkllxexjl65gs6x@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <20210323090108.ygx76exdgzudeeqi@vireshk-i7>
 <20210323093839.n7cq7f5poebqdwit@vireshk-i7>
 <5a415dbe-8e3b-2731-cc52-19aeadda1a17@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a415dbe-8e3b-2731-cc52-19aeadda1a17@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-03-21, 08:53, Jie Deng wrote:
> 
> On 2021/3/23 17:38, Viresh Kumar wrote:
> > On 23-03-21, 14:31, Viresh Kumar wrote:
> > > On 23-03-21, 22:19, Jie Deng wrote:
> > > > +static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> > > > +{
> > > > +	struct virtio_i2c *vi = i2c_get_adapdata(adap);
> > > > +	struct virtqueue *vq = vi->vq;
> > > > +	struct virtio_i2c_req *reqs;
> > > > +	unsigned long time_left;
> > > > +	int ret, nr;
> > > > +
> > > > +	reqs = kcalloc(num, sizeof(*reqs), GFP_KERNEL);
> > > > +	if (!reqs)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	mutex_lock(&vi->lock);
> > > > +
> > > > +	ret = virtio_i2c_send_reqs(vq, reqs, msgs, num);
> > > > +	if (ret == 0)
> > > > +		goto err_unlock_free;
> > > > +
> > > > +	nr = ret;
> > > > +	reinit_completion(&vi->completion);
> > > I think I may have found a possible bug here. This reinit_completion() must
> > > happen before we call virtio_i2c_send_reqs(). It is certainly possible (surely
> > > in corner cases) that virtio_i2c_msg_done() may get called right after
> > > virtio_i2c_send_reqs() and before we were able to call reinit_completion(). And
> > > in that case we will never see the completion happen at all.
> > > 
> > > > +	virtqueue_kick(vq);
> > I may have misread this. Can the actually start before virtqueue_kick() is
> > called ?

I didn't write it properly here. I wanted to say,

"Can the _transfer_ actually start before virtqueue_kick() is called ?"
 
> No. It starts when wait_for_completion_timeout is called.

No, the transfer doesn't have anything to do with wait_for_completion_timeout().
And if complete() gets called before wait_for_completion_timeout() is called,
then wait_for_completion_timeout() will simply return back.

> So it should be fine here.
> 
> 
> >   If not, then completion may be fine where it is.
> > 

-- 
viresh
