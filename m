Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA60731E8EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhBRLC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhBRJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:55:24 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAD4C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 01:54:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i7so2412385wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 01:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bqxu1XNH6N6vuKS5hpG5rhVx5OT5TN5etW+zkbE577c=;
        b=c24nw6svUt67ibKOBRx130BhyE/mvqJnist90Pe3MFW7E59e+HHjKIKmepIPZW0+mj
         zm2cWAWc2KIb+b8uQGgVx+Oyw8K2ie4XIZ8KsUWrY/XexM+iv3JMVXeOJWPqxs9IssJX
         t1A+/knmVCgw8/RdfOAk1JdqrbZ7Gr2BO8nGUfALfX3Sg0nTypWzTcBv8u2l3t6/iAho
         5iiIkoHtGsWHjG1sXyA5lLwc1ylUoI5Slo8JSYuGTUJcBoNkIKYpo/nF0o1lo8KQhu5p
         9YJ2Bbz7uLpsODwueUgNXV3HbsLQLiz03gLQ2N4MMRTyZ6nwPvGr8BxvFTooaCnsQquY
         UdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bqxu1XNH6N6vuKS5hpG5rhVx5OT5TN5etW+zkbE577c=;
        b=MVdm4stp1fptLLa7zfl9LmYwE+CCPHoDUMDUVAjtXbDKWO5lrZ5bNLj6xJ+KHV3L9m
         xvpsVaRHh9z1ONmvfaqX26HK4Yl2VNlbzYC8WYVVSfHohEqRDusFysmUl+7hWdmuc453
         vvMH16PD0mTEoDi/2d3Z3ERrvznmtRQEn4lADr9PwzyaNfRyYcOMunPM6colRvrddbWj
         cD1dTyg2KWwsyGTqYX9ZIldZ2lkooB5uUb0o/wlj5OJN6jTv7Shk899fxn0xcvIvdgRl
         PpMNbG1cgzE2q93+unWR3SEyv0ev/43qbL7GTI1gIBJJvo6b06njsDr0iPPPk6efiAOX
         dvOw==
X-Gm-Message-State: AOAM532d5hYsYJNGX3F7R+aFCVtLAxXDB39SHUpV8Gmqy598mLOgXzI4
        wawfgNoBSaYwMRKDNGJVZQ8=
X-Google-Smtp-Source: ABdhPJx41OKWXgwkk3BavqYAWr6n7NoZrAqe/3s1e7Hxtll99p2ItdqNrH2WmBL2GAy5BlLT34WDlA==
X-Received: by 2002:a05:600c:2904:: with SMTP id i4mr2807906wmd.138.1613642074863;
        Thu, 18 Feb 2021 01:54:34 -0800 (PST)
Received: from LEGION ([27.255.58.138])
        by smtp.gmail.com with ESMTPSA id m24sm8347545wml.36.2021.02.18.01.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 01:54:34 -0800 (PST)
Message-ID: <f44c413467df665de9bd1ecbee6d76222518c0c7.camel@gmail.com>
Subject: Re: [PATCH] staging: wimax/i2400m: don't change the endianness of
 one byte variable
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lee.jones@linaro.org, johannes@sipsolutions.net, arnd@arndb.de,
        kuba@kernel.org, gustavoars@kernel.org, wanghai38@huawei.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        musamaanjum@gmail.com
Date:   Thu, 18 Feb 2021 14:54:28 +0500
In-Reply-To: <YC42ECUUtX1Ah90v@kroah.com>
References: <20210218092154.GA46388@LEGION> <YC42ECUUtX1Ah90v@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-02-18 at 10:40 +0100, Greg KH wrote:
> On Thu, Feb 18, 2021 at 02:21:54PM +0500, Muhammad Usama Anjum wrote:
> > It is wrong to change the endianness of a variable which has just one
> > byte size.
> > 
> > Sparse warnings fixed:
> > drivers/staging//wimax/i2400m/control.c:452:17: warning: cast to restricted __le32
> > drivers/staging//wimax/i2400m/control.c:452:17: warning: cast to restricted __le32
> > drivers/staging//wimax/i2400m/op-rfkill.c:159:14: warning: cast to restricted __le32
> > drivers/staging//wimax/i2400m/op-rfkill.c:160:14: warning: cast to restricted __le32
> > 
> > Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> > ---
> >  drivers/staging/wimax/i2400m/control.c   | 4 ++--
> >  drivers/staging/wimax/i2400m/op-rfkill.c | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/wimax/i2400m/control.c b/drivers/staging/wimax/i2400m/control.c
> > index 1e270b2101e8..b6b2788af162 100644
> > --- a/drivers/staging/wimax/i2400m/control.c
> > +++ b/drivers/staging/wimax/i2400m/control.c
> > @@ -452,8 +452,8 @@ void i2400m_report_state_parse_tlv(struct i2400m *i2400m,
> >  		d_printf(2, dev, "%s: RF status TLV "
> >  			 "found (0x%04x), sw 0x%02x hw 0x%02x\n",
> >  			 tag, I2400M_TLV_RF_STATUS,
> > -			 le32_to_cpu(rfss->sw_rf_switch),
> > -			 le32_to_cpu(rfss->hw_rf_switch));
> > +			 rfss->sw_rf_switch,
> > +			 rfss->hw_rf_switch);
> 
> What do you mean by "one byte"?  This is a le32 sized variable, right?
> If not, why isn't the le32_to_cpu() call complaining?

These two variables are of type _u8, one byte. 
	__u8 sw_rf_switch;
	__u8 hw_rf_switch;
They aren't of type __le32. le32_to_cpu() macro should have
complained. But it isn't complaining. It seems like whatever we pass
to this macro, it casts it to __le32 forcefully (it seems like wrong).
So we'll never get any complain from this macro directly. But we are
getting complain from the sparse.

For big endian:
#define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
For little endian:
#define __le32_to_cpu(x) ((__force __u32)(__le32)(x))

> >  		i2400m_report_tlv_rf_switches_status(i2400m, rfss);
> >  	}
> >  	if (0 == i2400m_tlv_match(tlv, I2400M_TLV_MEDIA_STATUS, sizeof(*ms))) {
> > diff --git a/drivers/staging/wimax/i2400m/op-rfkill.c b/drivers/staging/wimax/i2400m/op-rfkill.c
> > index fbddf2e18c14..a159808f0ec2 100644
> > --- a/drivers/staging/wimax/i2400m/op-rfkill.c
> > +++ b/drivers/staging/wimax/i2400m/op-rfkill.c
> > @@ -156,8 +156,8 @@ void i2400m_report_tlv_rf_switches_status(
> >  	enum i2400m_rf_switch_status hw, sw;
> >  	enum wimax_st wimax_state;
> >  
> > -	sw = le32_to_cpu(rfss->sw_rf_switch);
> > -	hw = le32_to_cpu(rfss->hw_rf_switch);
> > +	sw = rfss->sw_rf_switch;
> > +	hw = rfss->hw_rf_switch;
> 
> Same here.

Same here.

> thanks,
> 
> greg k-h

