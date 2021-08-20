Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965013F2C33
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbhHTMf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbhHTMfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:35:11 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017DDC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:34:34 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h9so17050830ljq.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOmWkoC+gAVe/BeQYe8N8pWzsizYYXPCg0Wr0Rqh/4w=;
        b=gHp+PZxn5XsxisB5D4g0NSllOyywYlWQ6elppwcsdObIoKEvQd0DS4YsG7Uc/MwKBj
         CV5k5vbaI5Lp37IOekiYHNyRxLD66ehDmbqoIdYC4j6mlVvVKydGrRR54O2gvi04WTDN
         hLOp3j6A7zZjJFixW/KbhICDc8ZnYc0H+J/K+hBOqQ0nk+icYclPVLT4q54PJhkqh732
         k3V+omgH7reaKFCEuONKRSd/9I3fZeTgUTApN9kqq056n+c1wtlLCSkHpw1aH83//rJT
         nmu6ONGhVtiV2UphmgQ+wNhqHftwUkQOADTDi5OCHZAUvow+41RCSTW879VjYDSuk3Xj
         eMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOmWkoC+gAVe/BeQYe8N8pWzsizYYXPCg0Wr0Rqh/4w=;
        b=bpDlltfmPRNYJnM0o4LJp5HFAE//gb0mMUnycM1UmNhFxN3NUHYpdi72jyu3Hc96MM
         G6C6Du+RvmEOLHB5K9q9d0MhmVfgH6xz7SwMF6fvUKX1VeoaAGz7LOi7mQNC0O2FB0Yx
         c0d5BhMAnme+giu4Fdh9xQF/SxxAkdlzy0d+irM5wWk9R0ycP4KXQmYe+JUt8w+WNXqD
         P//7FnOOPYGAz/2n85T/aPN+z8zlemWqdL4YN+X8EXECT3vwoufDrlhbg4kdC/FlcJ/z
         b8+RUM80jiUhr/r3whxZH+BJYb34Pd59kPpP5IzRgO1P6ADoOwlpkx32CNFDrvAXkBgB
         0bpg==
X-Gm-Message-State: AOAM5333UgjF8psFbdFcqo4F6FZ/eqmTWTPGmEtJ3H7KhD6tU4kgkzSP
        Tf9q2M4DvQ91JsfxVOIotu4=
X-Google-Smtp-Source: ABdhPJzG6lqXuj0LLqVAK//R94kjPZHgS8vSVZ0e4cz5cfyiye6YExcU6LdypXVaYg3neGOnHgKAfA==
X-Received: by 2002:a05:651c:1190:: with SMTP id w16mr15793493ljo.327.1629462872397;
        Fri, 20 Aug 2021 05:34:32 -0700 (PDT)
Received: from localhost.localdomain ([87.249.198.171])
        by smtp.gmail.com with ESMTPSA id u18sm680722lfo.280.2021.08.20.05.34.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Aug 2021 05:34:31 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     fercerpav@gmail.com
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        i.mikhaylov@yadro.com, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH 1/2] rtc: pch-rtc: add RTC driver for Intel Series PCH
Date:   Fri, 20 Aug 2021 15:34:10 +0300
Message-Id: <20210820123410.46539-1-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20210814225242.GY15173@home.paul.comp>
References: <20210814225242.GY15173@home.paul.comp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2021 at 01:52:42PM +0300, Paul Fertser wrote:
> On Tue, Aug 10, 2021 at 06:44:35PM +0300, Ivan Mikhaylov wrote:
> > +config RTC_DRV_PCH
> > +	tristate "PCH RTC driver"
> > +	help
> > +	  If you say yes here you get support for the Intel Series PCH
>
> I'm afraid this is really lacking some specification of devices that
> are supported. Is it really everything that Intel currently calls PCH?

Yes, from infromation that I know.

> > +static int pch_rtc_read_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct pch *pch = i2c_get_clientdata(client);
> > +	unsigned char rtc_data[NUM_TIME_REGS] = {0};
> > +	int rc;
> > +
> > +	rc = regmap_bulk_read(pch->regmap, PCH_REG_SC, rtc_data, NUM_TIME_REGS);
> > +	if (rc < 0) {
> > +		dev_err(dev, "fail to read time reg(%d)\n", rc);
> > +		return rc;
> > +	}
>
> Citing 26.7.2.3 from C620 (Lewisburg/Purley) datasheet:
> 
> "The PCH SMBus slave interface only supports Byte Read operation. The
> external SMBus master will read the RTC time bytes one after
> another. It is software’s responsibility to check and manage the
> possible time rollover when subsequent time bytes are read.
> 
> For example, assuming the RTC time is 11 hours: 59 minutes: 59
> seconds. When the external SMBus master reads the hour as 11, then
> proceeds to read the minute, it is possible that the rollover happens
> between the reads and the minute is read as 0. This results in 11
> hours: 0 minutes instead of the correct time of 12 hours: 0 minutes.
> Unless it is certain that rollover will not occur, software is
> required to detect the possible time rollover by reading multiple
> times such that the read time bytes can be adjusted accordingly if
> needed."
> 
> Should this be taken additional care of somehow?

1. .use_single_read in regmap_config.
2. Maybe that is the right place for rollover check.

> > +static ssize_t force_off_store(struct device *dev,
> > +			       struct device_attribute *attr,
> > +			       const char *buf, size_t count)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct pch *pch = i2c_get_clientdata(client);
> > +	unsigned long val;
> > +	int rc;
> > +
> > +	if (kstrtoul(buf, 10, &val))
> > +		return -EINVAL;
> > +
> > +	if (val) {
> > +		/* 0x02 host force off */
> 
> I wonder why you write "host force off" while the C620 datasheet calls
> it "Unconditional Power Down", does your PCH manual use different
> naming?

It just a synonym, does the same. I can change it but first it's need to
be decided if attribute would go or not.

Thanks.
