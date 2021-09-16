Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBBA40D372
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhIPGxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhIPGxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:53:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC014C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:51:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n10so12666995eda.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dg+kf/9nEkO+NwYmoQ+q7KEG9AVdNOlmSwjtW+/Hqvw=;
        b=NxN9+H9IkH/IFdV5hNdAWWXNWPwTJUNfZ6kAjewcspMk/d/C3rpvp1PszKC39DXjXO
         jmTjS9O8/IkQmS317MUZkW01wtU/k7UwjSB2RAjNkZCsefiYzEyfFxeST1WCJ90w2xP9
         5k4qm2iOu/7rzTjnpAdWFxP6slalu52oRVFKz3+qZRpcHrsYQkwzS2vyV15YWlL9hVGk
         oGLDar+yDaWFV6VjQIgBNUrdUWkU1gqWEOGz3CO8COvW1PWUl7A4nCG/9XCmmz3Nna+R
         wHPCXy4cFxHXNcIp+0cReJtvSYzJWsil1NEfwKh/MwuFVPbqUZPWFypO+thmNKg3R7RY
         SQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dg+kf/9nEkO+NwYmoQ+q7KEG9AVdNOlmSwjtW+/Hqvw=;
        b=uYdh2r5jA7jWqPadIxZvFPLqhuxIUSIDCU+Cnzpdr+DPGuMjJwDGWLnvDN1aZ8//yp
         zwfzfcK7oGgFij+88M1L0/f6nAlhqntljdLDj9rvc3xqBygiOCQRi3ybZ1nV5p8LReMA
         yxJqiqIcZldCiYRZKyf5hBXfPAcnoMYUXXeXowXVsKY2Nq+Nxzd5CybDMEQLsDDKYMXE
         hqlifyp8oBUolhzI1d+AO/odfxi8sD642cltWxeYbKFX5B2T67HpSQ0psgUW6+7N5v69
         Scw09cPmGYVhALZCkRBvhWme4Wlm6AKsyqlXfyYuRC9gY2VzV6zjKktqO+dBX8EwOmye
         KaDg==
X-Gm-Message-State: AOAM531fzPBz/6Rz0qU8XcJYBmqT/tDRI7iQIBYaglpNGCpXQAz5+yUA
        9SGtlsmZoK7yjkavKr+mktH4ypTWON0=
X-Google-Smtp-Source: ABdhPJxTag1dKpKpC6gtZ6qPh9GoA9G/g+iGApT75JegmUSYPigjP2GTo2zn11qAPOFi3u1HWIfApQ==
X-Received: by 2002:a05:6402:5163:: with SMTP id d3mr4828567ede.220.1631775104449;
        Wed, 15 Sep 2021 23:51:44 -0700 (PDT)
Received: from agape.jhs ([5.171.81.56])
        by smtp.gmail.com with ESMTPSA id by26sm933725edb.69.2021.09.15.23.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 23:51:44 -0700 (PDT)
Date:   Thu, 16 Sep 2021 08:51:42 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] extcon: extcon-axp288: use low level P-Unit semaphore
 lock for axp288 register accesses
Message-ID: <20210916065140.GA1365@agape.jhs>
References: <20210910073440.2190-1-fabioaiuto83@gmail.com>
 <db4648a4-291c-2941-8f76-29a328eaf25e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db4648a4-291c-2941-8f76-29a328eaf25e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chanwoo,

On Thu, Sep 16, 2021 at 02:12:26AM +0900, Chanwoo Choi wrote:
> Hi,
> 
> On 21. 9. 10. 오후 4:34, Fabio Aiuto wrote:
> > use low level P-Unit semaphore lock for axp288 register
> > accesses directly and for more than one access a time,
> > to reduce the number of times this semaphore is locked
> > and released which is an expensive operation.
> > 
> > i2c-bus to the XPower is shared between the kernel and the
> > SoCs P-Unit. The P-Unit has a semaphore wich the kernel must
> > lock for axp288 register accesses. When the P-Unit semaphore
> > is locked CPU and GPU power states cannot change or the system
> > will freeze.
> > 
> > The P-Unit semaphore lock is already managed inside the regmap
> > access logic, but for each access the semaphore is locked and
> > released. So use directly iosf_mbi_(un)block_punit_i2c_access(),
> > we are safe in doing so because nested calls to the same
> > semaphore are turned to nops.
> > 
> > Suggested-by: Hans de Goede <hdegoede@redhat.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> > Changes in v2:
> > 	- add a new depends on in Kconfig
> > 	- add Tested-by Reviewed-by tags
> >   drivers/extcon/Kconfig         |  2 +-
> >   drivers/extcon/extcon-axp288.c | 14 ++++++++++++++
> >   2 files changed, 15 insertions(+), 1 deletion(-)

<snip>

> >   #define PS_STAT_VBUS_TRIGGER		BIT(0)
> > @@ -215,6 +216,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
> >   	unsigned int cable = info->previous_cable;
> >   	bool vbus_attach = false;
> > +	iosf_mbi_block_punit_i2c_access();
> 
> You have to check the return value of iosf_mbi_block_punit_i2c_access()

ok will send a v2, with all the fixes you pointed out.

<snip>

> 
> -- 
> Best Regards,
> Samsung Electronics
> Chanwoo Choi

thank you,

fabio
