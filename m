Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE723C7357
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbhGMPhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:37:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236932AbhGMPhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626190480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kFYNaWd22O3nnowmgoN34X1ibVU9X6CFHq3W7KqdyiU=;
        b=eRCOFox0UqAWB2DXioSKbBjyJk4uwDi6THb7N3gGKpa8mSvhK7zxT3qDkS+aqFefTBWKb0
        1GxEkPW/3L7SzZ/oyJcLf/09iFyHeJyRaJBAMUblZoGWYoY3ZIP4WVRhKmY7ka/A95YO96
        XZWzW9kZci/BrZGYy7iFeJIV67I0V5g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-36J-3PO_M9WKBAwW6w0-1A-1; Tue, 13 Jul 2021 11:34:39 -0400
X-MC-Unique: 36J-3PO_M9WKBAwW6w0-1A-1
Received: by mail-wm1-f71.google.com with SMTP id l33-20020a05600c1d21b029021c6168367bso2058420wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kFYNaWd22O3nnowmgoN34X1ibVU9X6CFHq3W7KqdyiU=;
        b=T1YZcdr660rhrFUHCM7FOnfujk7G4VHycG56d81pSoMOMIyLQ1aB61YPNOB+SeuZOb
         hXMX+wrwHAN7j/DEiFUcfdsrMplQI4MPn/KIu/V1ZoEsjB+NtumYod3MqoPiHvNrbM1d
         dtqgNt1Cdb9mc7C0xxRO97ZlzJazkCOrIwyN6yEzqdyCqiWyDdFm4CAdz54LurX+hh7W
         GDj8iVjJMa+pYwOKhuh+7dgdEN24LC8AQNxTJzWbWA6AsGahYnomxf5pmnWK7jdZ83SP
         Jzwvi4RVXnp3LzyyzVH6D4e6yeoH3znTkhelxzwfvgifHw64+YeQ0TxkwtdDn18ETZDC
         U1Xg==
X-Gm-Message-State: AOAM532DZqiX3BijsM/RTNAz1y27deTac64kvnGEmKf36sFVjEeIIt9K
        Jxj5ijgF4ro+bjWWZnilHUJjIfz6bNtjsu77Mj3tFOhlUo86DPv1NEWerJS2RfQF2RgELc1KVWD
        Lx2VB3ZipgDyFpfCCz+72QYNU
X-Received: by 2002:adf:f70a:: with SMTP id r10mr6491810wrp.401.1626190478028;
        Tue, 13 Jul 2021 08:34:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpNgNztgrVD7gZKhL/9YqYdmghKsV+iIed8iTwwM6ybZEIl/XhMX0wzXR0E5UDOq8x56dagA==
X-Received: by 2002:adf:f70a:: with SMTP id r10mr6491786wrp.401.1626190477886;
        Tue, 13 Jul 2021 08:34:37 -0700 (PDT)
Received: from redhat.com ([2.55.15.23])
        by smtp.gmail.com with ESMTPSA id d8sm6178278wrv.20.2021.07.13.08.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 08:34:36 -0700 (PDT)
Date:   Tue, 13 Jul 2021 11:34:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jie Deng <jie.deng@intel.com>, linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wsa@kernel.org,
        wsa+renesas@sang-engineering.com, arnd@arndb.de,
        jasowang@redhat.com, andriy.shevchenko@linux.intel.com,
        yu1.wang@intel.com, shuo.a.liu@intel.com, conghui.chen@intel.com,
        stefanha@redhat.com, gregkh@linuxfoundation.org,
        vincent.guittot@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v14] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210713113301-mutt-send-email-mst@kernel.org>
References: <984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com>
 <20210709034407.xmglkgzubrztnxsg@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709034407.xmglkgzubrztnxsg@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 09:14:07AM +0530, Viresh Kumar wrote:
> On 09-07-21, 10:25, Jie Deng wrote:
> > Add an I2C bus driver for virtio para-virtualization.
> > 
> > The controller can be emulated by the backend driver in
> > any device model software by following the virtio protocol.
> > 
> > The device specification can be found on
> > https://lists.oasis-open.org/archives/virtio-comment/202101/msg00008.html.
> > 
> > By following the specification, people may implement different
> > backend drivers to emulate different controllers according to
> > their needs.
> > 
> > Co-developed-by: Conghui Chen <conghui.chen@intel.com>
> > Signed-off-by: Conghui Chen <conghui.chen@intel.com>
> > Signed-off-by: Jie Deng <jie.deng@intel.com>
> > ---
> > Changes v13 -> v14
> > 	- Put the headers in virtio_i2c.h in alphabetical order.
> > 	- Dropped I2C_FUNC_SMBUS_QUICK support.
> > 	- Dropped few unnecessary variables and checks.
> > 	- Use "num" everywhere instead of num or nr, to be consistent.
> > 	- Added few comments which make the design more clear. 
> 
> Thanks a lot for following this up so far :)
> 
> > +static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
> > +				   struct virtio_i2c_req *reqs,
> > +				   struct i2c_msg *msgs, int num)
> > +{
> > +	struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
> > +	int i;
> > +
> > +	for (i = 0; i < num; i++) {
> > +		int outcnt = 0, incnt = 0;
> > +
> > +		/*
> > +		 * We don't support 0 length messages and so masked out
> > +		 * I2C_FUNC_SMBUS_QUICK in virtio_i2c_func().
> > +		 */
> > +		if (!msgs[i].len)
> > +			break;
> > +
> > +		/*
> > +		 * Only 7-bit mode supported for this moment. For the address
> > +		 * format, Please check the Virtio I2C Specification.
> > +		 */
> > +		reqs[i].out_hdr.addr = cpu_to_le16(msgs[i].addr << 1);
> > +
> > +		if (i != num - 1)
> > +			reqs[i].out_hdr.flags = cpu_to_le32(VIRTIO_I2C_FLAGS_FAIL_NEXT);
> > +
> > +		sg_init_one(&out_hdr, &reqs[i].out_hdr, sizeof(reqs[i].out_hdr));
> > +		sgs[outcnt++] = &out_hdr;
> > +
> > +		reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
> > +		if (!reqs[i].buf)
> > +			break;
> > +
> > +		sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
> > +
> > +		if (msgs[i].flags & I2C_M_RD)
> > +			sgs[outcnt + incnt++] = &msg_buf;
> > +		else
> > +			sgs[outcnt++] = &msg_buf;
> > +
> > +		sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in_hdr));
> > +		sgs[outcnt + incnt++] = &in_hdr;
> > +
> > +		if (virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL)) {
> > +			i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], false);
> > +			break;
> > +		}
> > +	}
> > +
> > +	return i;
> > +}
> 
> Wolfram, in case you wonder why we don't error out early as discussed earlier,
> then ...
> 
> > +static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> > +			   int num)
> > +{
> 
> ...
> 
> > +	/*
> > +	 * For the case where count < num, i.e. we weren't able to queue all the
> > +	 * msgs, ideally we should abort right away and return early, but some
> > +	 * of the messages are already sent to the remote I2C controller and the
> > +	 * virtqueue will be left in undefined state in that case. We kick the
> > +	 * remote here to clear the virtqueue, so we can try another set of
> > +	 * messages later on.
> > +	 */
> 
> ... here is the reasoning for that.
> 
> Please see if you can still get it merged into 5.14-rc1/2. Thanks.
> 
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Tested-by: Viresh Kumar <viresh.kumar@linaro.org>

Well a new driver so maybe rc2 is still ok ...

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> -- 
> viresh

