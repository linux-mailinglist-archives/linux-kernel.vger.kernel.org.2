Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA363BB53C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 04:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhGECqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 22:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGECqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 22:46:20 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461B4C061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 19:43:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o18so16321340pgu.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 19:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xuSwe/RfSoZsmqWmRxSCKHgdBKSJxFIJ1HP2k67JkNE=;
        b=TLV4gOuFn+VPLM41B7YR5L1wKfxLzcF6bpswN35lacqXklwXMThcUo1B9UxFGWGPbc
         6PBWQHbzjUGYKZ4JQhq1j45l5gCQTgzTlmgp5zMxaCGufDbwT4VFfkCk5bl+oqhW97Ta
         HRAnqvXotEJYQ7QiirWsTDMvf6wLaXM0XnMGWZcVZcUj6S8YkdKEuKBzvpucQF5ZHLJ4
         ZnDjDJKLK8jD2lgAz9H92+hFKOWObUF09q/ReTqmmbwTHHaaKBkkBPlY40wMnTHYpETJ
         m24o5HYwIKUPJz0kfdBUvF1aeIizRv8nbCZMwoJmD4y8bZAbDrmSb/tvRuiNfpb0wX3I
         V0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xuSwe/RfSoZsmqWmRxSCKHgdBKSJxFIJ1HP2k67JkNE=;
        b=PHtiCeqPIbFZxhqNjPiIbZJpBK3+sEP+hPcxJbG9kti7zP4pgl1DAwT8cSfjBDlOLU
         2xFeu3RroL6AGvUGRN7hFj1hvNEshTRYQJHOPNfbPIvyg/1KdyNAaHUlSgmLb9uJPP3T
         0dItWDTRhb0JIhouRjksOvjcQBJqR6bhUkASOrO1udoIe/oVyHOvAK7Ge18F1FsfWpYS
         kXR1UucmnD8mbv+8Q/apThUcfNE1BvQt5w71MXhYbdqFMay3RXVh2JLOBTzRuwal4CQZ
         IRhvttDlowQ8bSf63bvF5rAnrtdS2PgLy5VMpznSHQgt8slXn91s/767tWo8SYSp6TrJ
         qpwQ==
X-Gm-Message-State: AOAM530IMIRDf+yswhwfnFuSbslKtulc9zFMfbbSkvJtIXJ7Ywsqq3cw
        c3wHijM02+RWd/M/AIt35BUMTg==
X-Google-Smtp-Source: ABdhPJwmAJLOYAES7tvc7lRmiTWlLmQtQ+z3LyBxTrAkUo6791EZO4D8kVO6bvovxidDnExrClJHKA==
X-Received: by 2002:a63:284:: with SMTP id 126mr13154170pgc.347.1625453022687;
        Sun, 04 Jul 2021 19:43:42 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id y127sm5987540pfg.96.2021.07.04.19.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 19:43:42 -0700 (PDT)
Date:   Mon, 5 Jul 2021 08:13:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jie Deng <jie.deng@intel.com>, linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wsa@kernel.org,
        wsa+renesas@sang-engineering.com, mst@redhat.com, arnd@arndb.de,
        jasowang@redhat.com, yu1.wang@intel.com, shuo.a.liu@intel.com,
        conghui.chen@intel.com, stefanha@redhat.com
Subject: Re: [PATCH v12] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210705024340.mb5sv5epxbdatgsg@vireshk-i7>
References: <f229cd761048bc143f88f33a3437bdbf891c39fd.1625214435.git.jie.deng@intel.com>
 <YN7jOm68fUL4UA2Q@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN7jOm68fUL4UA2Q@smile.fi.intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-07-21, 12:58, Andy Shevchenko wrote:
> On Fri, Jul 02, 2021 at 04:46:47PM +0800, Jie Deng wrote:
> > +static int virtio_i2c_complete_reqs(struct virtqueue *vq,
> > +				    struct virtio_i2c_req *reqs,
> > +				    struct i2c_msg *msgs, int nr,
> > +				    bool fail)
> > +{
> > +	struct virtio_i2c_req *req;
> > +	bool failed = fail;

Jie, you can actually get rid of this variable too. Jut rename fail to failed
and everything shall work as you want.

> > +	unsigned int len;
> > +	int i, j = 0;
> > +
> > +	for (i = 0; i < nr; i++) {
> > +		/* Detach the ith request from the vq */
> > +		req = virtqueue_get_buf(vq, &len);
> > +
> > +		/*
> > +		 * Condition (req && req == &reqs[i]) should always meet since
> > +		 * we have total nr requests in the vq.
> > +		 */
> > +		if (!failed && (WARN_ON(!(req && req == &reqs[i])) ||
> > +		    (req->in_hdr.status != VIRTIO_I2C_MSG_OK)))
> > +			failed = true;
> 
> ...and after failed is true, we are continuing the loop, why?

Actually this function can be called with fail set to true. We proceed as we
need to call i2c_put_dma_safe_msg_buf() for all buffers we allocated earlier.

> > +		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
> > +		if (!failed)
> 
> > +			++j;
> 
> Besides better to read j++ the j itself can be renamed to something more
> verbose.
> 
> > +	}
> 
> > +	return (fail ? -ETIMEDOUT : j);
> 
> Redundant parentheses.
> 
> > +}

-- 
viresh
