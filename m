Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0857B41AC8C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbhI1KDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240132AbhI1KDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:03:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E87C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:01:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x20so12332467wrg.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9N75ALQ7O2eKF/FpfirT0cQdewLqNWnt7aR+SpKIxa0=;
        b=TtBtsjySnx0FZjuvSiHDkKbC2nBaNMwyQJBIX/FHIgbyZoova7EZgVq3BOAUxIjQgu
         aZsptMvs13uiEpnJWZjuQahNVrv3FCJToDr7VnTodP4Nl7kRE3JuEbo5LbJiV2pzAquz
         op+lc/k0C6xzDBkhauBARZ7afI4MKjfZh/l1SjdKaep+0dHCs3n/nFuxsSesECaINfPm
         guNA8brs0FihWH/rpSZNnPkpMzDWUYqjQ+CHBxJabGVNUvTQxDiytEM4l+F7704EZrq1
         TuK56EEUqLJQ5MDcSzXZiZ2Tx46kwsEJ7FMIypOfvTu14RhPmMnpJtiQJ0pHonyeBfxS
         04zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9N75ALQ7O2eKF/FpfirT0cQdewLqNWnt7aR+SpKIxa0=;
        b=y2xQtu/TSybdk4HWD728+uAvy6mVMAh7o6IIRIZap+YbPK1DZmWW6z4dQBxctIh7jD
         9ElahDIE+XE93YAg8tts7U4qQjcMVLzLGYdbe9DEx4iUu1tSYXunCqUdhgY+sX9iMRg7
         WKzH46+UIFoXBTKXM7dm6rSE3z0Wdb8P8vVu4UtU0IBGQgfxyvqN9YcXZq19SLF8tub+
         l5BZ+U3h4EfZdG7ZZ975UKQuPIhoOwKVys/zeiUTym5pcjervEog2GR51RvjmjBTNOjJ
         41fiuOIqUw/lnfvw56zV1OEA1Sp+pG4b+/ScWQZKSTdZA+MWIZL1tNqItDS0AqXr8C/U
         BgbQ==
X-Gm-Message-State: AOAM533hfikMIAzo77JT8mzJCAXT3kpWpXa56HoN+vnh7NkqF+3syov2
        3AueWLlP+ctcqwtg/VyzzSylFw==
X-Google-Smtp-Source: ABdhPJw7HYTCW5F1Ulo0gW48fVTc6g7CkwSmUs0wihejjGi9KfkpUft46wtv6QYWYkTrxczPyZFujA==
X-Received: by 2002:a5d:4ac4:: with SMTP id y4mr5251107wrs.190.1632823288655;
        Tue, 28 Sep 2021 03:01:28 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id o1sm19349780wru.91.2021.09.28.03.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 03:01:28 -0700 (PDT)
Date:   Tue, 28 Sep 2021 11:01:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v1 2/4] mfd: arizona: Add missing entries SPI to device
 ID table
Message-ID: <YVLn9si4h0jFqkQV@google.com>
References: <20210923194645.53046-1-broonie@kernel.org>
 <20210923194645.53046-3-broonie@kernel.org>
 <538c0c79-d568-be03-e524-01f5c6429554@opensource.cirrus.com>
 <20210924112000.GB4840@sirena.org.uk>
 <20210927102754.GE9223@ediswmail.ad.cirrus.com>
 <20210927105528.GA4199@sirena.org.uk>
 <YVLM0VxNGdH8AxQO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVLM0VxNGdH8AxQO@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021, Lee Jones wrote:

> On Mon, 27 Sep 2021, Mark Brown wrote:
> 
> > On Mon, Sep 27, 2021 at 10:27:54AM +0000, Charles Keepax wrote:
> > 
> > > Yeah we should really be having different lists for SPI and I2C
> > > here I guess. I am happy to have a quick look at doing a patch
> > > for that, unless you particularly want to fix it up?
> > 
> > I dropped the patch so please feel free to go ahead.
> 
> Just this one, or should I drop the set?

Never mind.  I see the new set.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
