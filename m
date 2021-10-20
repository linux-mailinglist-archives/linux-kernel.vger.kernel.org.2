Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A614349A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhJTLFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhJTLFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:05:33 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3242C061746
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:03:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id t184so2680260pfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8A9C5E8tdK3Q1/o4m/27R2aNTTSBIWA+hDzCu4axFW0=;
        b=XL2jKHlr/fyCAFaxWGlvHVmU8AtpFp0D/QTIzup/lf4toTqvizjmReZiGgUfASJQWz
         qhRSldMBBAPK0WZr9mOTUoRTtp+gFoRbGHhjo24DFksiOmhma/THWyHmPIDYjci7mXV/
         DGDi02PbSGfW4iux8MsflOkpO0GFekIfyoAMA4RJ2ESOJx+4zFjK+YU9XPxXUcrYJ1T2
         iu+aFFLvfhgwoz3Bmp3qz+84Hzjf5H/QcPceMTHaaAlRUxG0WxaEjgG4W/i25u8mgNTn
         IfIzOGQv0Ka4lvz4qFlc+1IrL+y2DsNn11SBk8YfQEKaxbSyNVuh0x948ZwqCCLTVt64
         LSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8A9C5E8tdK3Q1/o4m/27R2aNTTSBIWA+hDzCu4axFW0=;
        b=rfdfK6Y4If65BWAMicq4nThQdF6Wnyj21Gle3JE3BE26wWiKT7WPf4hjnqdRdebBp5
         rzRRDUUMKNIn5inj0Zk/VLSqnwIkLZSyJGy005Ws4P7nw7M1e5hpzbEl+G54V/QkXa1E
         P7fb6BsmHsSy+9y0SqO6RrDqgVGayEFRLsUOA92d2fbi8wEHpcVfy2gl0wURXAYB24jB
         Xu6ioCWSRq4ocW0EO/ajMVrKGWZ1u7mb5VcIMMGbb356F0j/cp/IyS5ZB5l8mgGounSN
         tGJ3u4vgU29yQW9n6mvjZDO/BBSbFLMHtiNMITsAvfDJcdA8DEj4/C8s0ArZX+QiW4jk
         34uQ==
X-Gm-Message-State: AOAM530k8IiDOJO9hdyUwDBu8H3FrzK3aV8+ImD0MDk8V2IaWvZh8MrV
        VAbu0tD3/nAMBY0pD8PZCeT9aA==
X-Google-Smtp-Source: ABdhPJyWkuXXFp3ZxNT7p7PUzM9PhzJYLXZlo4BivbFG7A9jO5Flh1SqidEe2k3WzY/nScRxzTDanw==
X-Received: by 2002:a63:6b82:: with SMTP id g124mr732952pgc.20.1634727799170;
        Wed, 20 Oct 2021 04:03:19 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id ob5sm6296790pjb.2.2021.10.20.04.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 04:03:18 -0700 (PDT)
Date:   Wed, 20 Oct 2021 16:33:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Jie Deng <jie.deng@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211020110316.4x7tnxonswjuuoiw@vireshk-i7>
References: <20211019094203.3kjzch7ipbdv7peg@vireshk-i7>
 <YW6pHkXOPvtidtwS@kroah.com>
 <20211019143748.wrpqopj2hmpvblh4@vireshk-i7>
 <YW8LFTcBuN1bB3PD@ninjato>
 <94aa39ab-4ed6-daee-0402-f58bfed0cadd@intel.com>
 <YW+q1yQ8MuhHINAs@kroah.com>
 <8e182ea8-5016-fa78-3d77-eefba7d58612@intel.com>
 <20211020064128.y2bjsbdmpojn7pjo@vireshk-i7>
 <01d9c992-28cc-6644-1e82-929fc46f91b4@intel.com>
 <20211020105554.GB9985@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020105554.GB9985@axis.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-21, 12:55, Vincent Whitchurch wrote:
> If the timeout cannot be disabled, then the driver should be fixed to
> always copy buffers and hold on to them to avoid memory corruption in
> the case of timeout, as I mentioned in my commit message.  That would be
> quite a substantial change to the driver so it's not something I'm
> personally comfortable with doing, especially not this late in the -rc
> cycle, so I'd leave that to others.

Or we can avoid clearing up and freeing the buffers here until the
point where the buffers are returned by the host. Until that happens,
we can avoid taking new requests but return to the earlier caller with
timeout failure. That would avoid corruption, by freeing buffers
sooner, and not hanging of the kernel.

-- 
viresh
