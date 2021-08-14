Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACEF3EC5DC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 00:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhHNWxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 18:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhHNWxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 18:53:16 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13BEC061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 15:52:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id c12so8265404ljr.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 15:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gkJO73YRk3QGSnXa3a/jzv/FQTbPeEQgelsyLZQoqKU=;
        b=r82EXC6mAkPDrvFMZW4X8doFflMMnxOdP8em34Yi13pMRUhr3qtpGvibRm6l25ch4Y
         Gh1r3xhgfphKRiIWrg+NZiWHpfKHDDPCrr4LT1d842XokIlbTGGJ/iUM1bBGvKIzrzKK
         VL/jEsDymKxkS8ntVfNfmFNiSnYtAhT0IRPuSCqyTHYmtsTtFx1IUO9JwBYe31PSgtN4
         lJL2pjHRUT8EbCnhfh8Px8KX7Gg3fifHVSKMYYWobB+Ae/XApS7IU40UhC1Go206g25G
         yg91wBgwB1L9cDSJG+T1R2ZadavjrMSGOTp5VtJfNnEiYubBpyP8MFA/UTwSTZc2beak
         LAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gkJO73YRk3QGSnXa3a/jzv/FQTbPeEQgelsyLZQoqKU=;
        b=c4eX3LNA8tXolbLEDbnau2cmKEsu1tdqIKrNyYMvpiBaUgWNh97Gu4RWKjN7l1Z8NR
         BQSFjwWPbNWiKqCKV4jbznpY8l+jNxJ+8AOuSia7wIsLGKsyDoROduhyuW/tNkB+D6ni
         VCeaqWSt3fgBgZHP8l0okP84kCcsGdpJ0HyHMLdSu8Sd9Ib1Vb2pxYgpmB1KeCNE7v7q
         CQNvbnv7SFTlBd/vTFKUnBxyxHO5/+iEZ3Sc4OUQZYXtkGoI/qRNexoktC9zHF0Uc9gg
         62ZL00Kh8F3mNqlpTEp0le8dQQVizZENc5HSXOuHBVBx9Un6vKI4xf2u96jtQWQKsNVk
         eEsg==
X-Gm-Message-State: AOAM5311xKGqehEJHw7lpFpTtgZVviOohEqAxbNjyR3J5NsVfne3sY1/
        SFZz7gbVOXNQ1atoGlRhenDCH7MTcuk=
X-Google-Smtp-Source: ABdhPJyz9JyeCQK+xFsUbdk6/HOJTWQ9sQsEnfN1pJQW0W4Mz2PmGn0r8KOfWglt6OIof0/FTMmOPQ==
X-Received: by 2002:a2e:a784:: with SMTP id c4mr6968438ljf.479.1628981565946;
        Sat, 14 Aug 2021 15:52:45 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id y6sm516221lfa.122.2021.08.14.15.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 15:52:45 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 17EMqhbc008737;
        Sun, 15 Aug 2021 01:52:44 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 17EMqgX4008736;
        Sun, 15 Aug 2021 01:52:42 +0300
Date:   Sun, 15 Aug 2021 01:52:42 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc: pch-rtc: add RTC driver for Intel Series PCH
Message-ID: <20210814225242.GY15173@home.paul.comp>
References: <20210810154436.125678-1-i.mikhaylov@yadro.com>
 <20210810154436.125678-2-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210810154436.125678-2-i.mikhaylov@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 06:44:35PM +0300, Ivan Mikhaylov wrote:
> +config RTC_DRV_PCH
> +	tristate "PCH RTC driver"
> +	help
> +	  If you say yes here you get support for the Intel Series PCH

I'm afraid this is really lacking some specification of devices that
are supported. Is it really everything that Intel currently calls PCH?

> +static int pch_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct pch *pch = i2c_get_clientdata(client);
> +	unsigned char rtc_data[NUM_TIME_REGS] = {0};
> +	int rc;
> +
> +	rc = regmap_bulk_read(pch->regmap, PCH_REG_SC, rtc_data, NUM_TIME_REGS);
> +	if (rc < 0) {
> +		dev_err(dev, "fail to read time reg(%d)\n", rc);
> +		return rc;
> +	}

Citing 26.7.2.3 from C620 (Lewisburg/Purley) datasheet:

"The PCH SMBus slave interface only supports Byte Read operation. The
external SMBus master will read the RTC time bytes one after
another. It is software’s responsibility to check and manage the
possible time rollover when subsequent time bytes are read.

For example, assuming the RTC time is 11 hours: 59 minutes: 59
seconds. When the external SMBus master reads the hour as 11, then
proceeds to read the minute, it is possible that the rollover happens
between the reads and the minute is read as 0. This results in 11
hours: 0 minutes instead of the correct time of 12 hours: 0 minutes.
Unless it is certain that rollover will not occur, software is
required to detect the possible time rollover by reading multiple
times such that the read time bytes can be adjusted accordingly if
needed."

Should this be taken additional care of somehow?

> +static ssize_t force_off_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct pch *pch = i2c_get_clientdata(client);
> +	unsigned long val;
> +	int rc;
> +
> +	if (kstrtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	if (val) {
> +		/* 0x02 host force off */

I wonder why you write "host force off" while the C620 datasheet calls
it "Unconditional Power Down", does your PCH manual use different
naming?

In any case this doesn't belong to an RTC driver, as previously noted.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
