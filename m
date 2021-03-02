Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C8732A1A9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347828AbhCBGor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 01:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344172AbhCBFQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 00:16:51 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F2DC0617A7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 21:16:10 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id e3so9082784pfj.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 21:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4mH1U5hmRiBJDETEHndXgS3KJ6e28Mw9ydwzu03eWw4=;
        b=nwpCyK0iP5UVbEhsxmHF1eDSoFkSf6v31SprFws8MBXvfV8kZk0zOn9HdkuQTj5VFl
         DHXkAHSBJ7hKXzdctcfji4rwEWPFY1eRR/XUjaOrv4AGhRIoIcKd3XeHgtjz5GCCFyfF
         hga6flGcmQ35V1mAULa7VobjHGx0SRkHtgO1QwYtjwu39EVmk/25Wqi9lm4TunasxKc2
         ioAym6abRRu8XJFyvaqrKJx1HyG58pNVBL4wRpuGDa1kpMdvk9n0t3WelIePZ51QNcM0
         CF+8uRJOMKH8j5yE9y6Muu2+0RnwBfp4fy2m3vP/T7kg7f5niGvAyXF+UCj+DLEdeEvl
         UZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4mH1U5hmRiBJDETEHndXgS3KJ6e28Mw9ydwzu03eWw4=;
        b=t6USwDJetjwU6vTG1viGXsXhRLy1hQ/zmlxD21fzXSIll346+KZGA58rPadUd9oypg
         0wch/2oQO0+v8ehN0zZ+XoQj5E8FiL0V0gc43YchIGRBGvy7XzIbOK3xyHB5U5lh7bsi
         u5XHS81u8vQnW970OkFLh5bPeNYGO41BklXboPcKuYoER24UOEAcZJl4smSGO02VQvuz
         2QgmrukNOAts9R6NdxLRNk8WlEu2wp/DIwa2jwXZp7oE9f0O5YJIn6fLh844bBAI+kmg
         jEMFN/airehnmK0jyQ+OsMw2GjrBcXgxmtaIBO6I9heDz2X3EN/RnufIXSAijF5lhci1
         mpWA==
X-Gm-Message-State: AOAM532zol5FHFwHLyfqMgAGTJx8FalzkerCQ33cBRpPLlbPATXPc7G5
        urWrOH5m0AtbjxVAg/87wpblhQ==
X-Google-Smtp-Source: ABdhPJzmiA6hD+GzKRZZid3z0wFpBgbppacW3gsHNUoN4y6JRvnPgz6fC463RGmEkEMHORl0u2ACew==
X-Received: by 2002:a63:f202:: with SMTP id v2mr16507126pgh.24.1614662170327;
        Mon, 01 Mar 2021 21:16:10 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id s12sm1726674pgj.70.2021.03.01.21.16.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 21:16:09 -0800 (PST)
Date:   Tue, 2 Mar 2021 10:46:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jie Deng <jie.deng@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        conghui.chen@intel.com, kblaiech@mellanox.com,
        jarkko.nikula@linux.intel.com,
        Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
        Mike Rapoport <rppt@kernel.org>, loic.poulain@linaro.org,
        Tali Perry <tali.perry1@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        yu1.wang@intel.com, shuo.a.liu@intel.com,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210302051607.gul2w66xpsffzpnm@vireshk-i7>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <CAK8P3a1ZXbodV07TTErnQunCLWOBnzRiVdLCxBD743fn-6FbXg@mail.gmail.com>
 <20210302040114.rg6bb32g2bsivsgf@vireshk-i7>
 <20210302042233.7ppagwjk3rah3uh3@vireshk-i7>
 <5e66fc1b-81d3-341e-4864-adb021e9ce1e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e66fc1b-81d3-341e-4864-adb021e9ce1e@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-03-21, 13:06, Jie Deng wrote:
> Yeah. Actually, the backend only needs "struct virtio_i2c_out_hdr out_hdr"
> and "struct virtio_i2c_in_hdr in_hdr" for communication. So we only need to
> keep
> the first two in uapi and move "struct virtio_i2c_req" into the driver.
> 
> But Jason wanted to include "struct virtio_i2c_req" in uapi. He explained in
> this link
> https://lists.linuxfoundation.org/pipermail/virtualization/2020-October/050222.html.
> Do you agree with that explanation ?

I am not sure I understood his reasoning well, but it doesn't make any
sense to keep this in uapi header if this is never going to get
transferred over the wire.

Moreover, the struct virtio_i2c_req in spec is misleading to me and
rather creates unnecessary confusion. There is no structure like this
which ever get passed here, but rather there are multiple vq
transactions which take place, one with just the out header, then one
with buffer and finally one with in header.

I am not sure what's the right way of documenting it or if this is a
standard virtio world follows.

-- 
viresh
