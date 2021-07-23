Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C694B3D31D0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 04:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhGWBsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 21:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhGWBsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 21:48:05 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB611C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 19:28:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so1868495pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 19:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tAw85E8NXV/d5HgkTo259jtbI4ouhmcg6pjHUDSWPjc=;
        b=Q7CIwrCSaunZRhC18Xlo4DvY8+aN4ehQ8+o9kvikwLv3PHHcQ4BFGQhX9vu8e28p3/
         vuFeJmrPpxB4Ach1ym4qW9yJPyYnTIdLn4z3y/8Ihhe+s61EFqv8PjfvgMRR3rOXoUP6
         nLDsUlogdx/HTaxNHdkBk0SzAQKwDkCxTN4Oqz8nvr2FEtbdXnFJt5R4W4Zyb2+qRanh
         SiXn7ka7sLQPZSEj2AlCDkJF+v6Bf0C9cTO4QlY6svJJUVm5F07h6D/Zu4FYwIDkTdlN
         vRLbZA4Lxz5Wp3xNxNCxmu8OO3+cRKITygD40IWp+Q7X5t0CFpEdR9FGfbmsJD6CmHgQ
         g0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tAw85E8NXV/d5HgkTo259jtbI4ouhmcg6pjHUDSWPjc=;
        b=RE+qfX5a8DK6s+KWx+aNmGcSWzz6cT9IIHkEVjxD2rqmaibHc5cm9Ad1aoob1TTVk/
         /8HVOi6vdcPhh0UMkUyWrdbfdukgCPCrHtP716/Tne0ZGlLNZAZhcUae91RrYFoCH13K
         14lhClXeYcMqIeXdPn9XuWq+p2HanMivw3YrQiwZ/XrrbZ9qAesukzqVhgJxXV3LHsvF
         5Fy/gC+VA6PqTVtPwz+DKyM23OcsAf0JV4Ia3JNNUXkjGBF7FmEz4o72qPsHtr8mB41p
         YoL9E8Cdz0hIUDoAkkgd7tcYAgZEjwxA+vEllRtnTfFxuAmRZsGm7aY6hFCp1J27j2vy
         iiZQ==
X-Gm-Message-State: AOAM531lNUusza8J2lnWtz88aU9WYPx7dKS3Tmh12LWdtLywtio9cHKQ
        JwpgMza1SRYQSsaETsA02EEqMA==
X-Google-Smtp-Source: ABdhPJxSWSpC//R2a9331w7aLWF4tUcZt/V6puU33PGp87Oq9CNUj0lUb/eotMn0lPyFT2oVs4VjiQ==
X-Received: by 2002:aa7:93ac:0:b029:32e:4fce:bde1 with SMTP id x12-20020aa793ac0000b029032e4fcebde1mr2586387pff.54.1627007318309;
        Thu, 22 Jul 2021 19:28:38 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id y15sm32865753pfn.63.2021.07.22.19.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 19:28:37 -0700 (PDT)
Date:   Fri, 23 Jul 2021 07:58:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wolfram Sang <wsa@kernel.org>, Jie Deng <jie.deng@intel.com>,
        linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        andriy.shevchenko@linux.intel.com, conghui.chen@intel.com,
        arnd@arndb.de, kblaiech@mellanox.com,
        jarkko.nikula@linux.intel.com, Sergey.Semin@baikalelectronics.ru,
        rppt@kernel.org, loic.poulain@linaro.org, tali.perry1@gmail.com,
        u.kleine-koenig@pengutronix.de, bjorn.andersson@linaro.org,
        yu1.wang@intel.com, shuo.a.liu@intel.com, stefanha@redhat.com,
        pbonzini@redhat.com
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210723022836.ews7bshlwcsaktud@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNrw4rxihFLuqLtY@ninjato>
 <20210629101627.kwc2rszborc3kvjs@vireshk-i7>
 <YNr0uDx1fv+Gjd7m@ninjato>
 <20210629103014.nlk3mpetydc4mi6l@vireshk-i7>
 <YNr5Jf3WDTH7U5b7@ninjato>
 <YNr5ZRhT3qn+e9/m@ninjato>
 <20210705121832.fmye5xnlbydoc5ir@vireshk-i7>
 <YPmLoeLSPS1tfYUK@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPmLoeLSPS1tfYUK@ninjato>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On 22-07-21, 17:15, Wolfram Sang wrote:
> Nope, I think you misinterpreted that. SMBUS_QUICK will not send any
> byte. After the address phase (with the RW bit as data), a STOP will
> immediately follow. len = 0 will ensure that.
> 
> msgbuf0[0] is set to 'command' because every mode except SMBUS_QUICK
> will need that. So, it is convenient to always do it. For SMBUS_QUICK
> it is superfluous but does not hurt.

Yeah, I think I was confused by this stuff.

> > If so, it would be difficult to implement this with the current i2c virtio
> > specification, as the msg.len isn't really passed from guest to host, rather it
> > is inferred using the length of the buffer itself. And so we can't really pass a
> > buffer if length is 0.
> 
> And you can't leave out the buffer and assume len = 0 then?

Would need a spec update, which I am going to send.

We would also need another update to spec to make the Quick thing
working. Lemme do it separately and we merge the latest version of the
driver for linux-next until then.

I checked the code with i2cdetect -q and it worked fine, I was
required to do some changes to the backend (and spec) to make it work.
I will propose the changes to the spec first for the same.

-- 
viresh
