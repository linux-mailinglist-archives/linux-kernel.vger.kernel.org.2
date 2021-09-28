Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726AE41AA6C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbhI1IHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbhI1IHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:07:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DE5C061604
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:05:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d6so56268446wrc.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yK4+pJccx+L287LRxGHzTccwnqeDUuV1kwFuIH5wuVw=;
        b=iAVLDREMsjNYoZqnBt/mr0bb5N77eb2MByH+vDh3phYyZ84A2vxq3mu5hX00fpU8aJ
         WHR6cToDFFDfaPvtWju8g34JT4RdmalPYl0QeN2XhW9iPxpG2L7C9aSN9wyJsIUybzQX
         9ziSJ4xZZ5y2jSk/YrBmNh3MCHZvDcrqNNomTMtvf+97pnP0FxsyhiY0RAz0V7PvIrH7
         1BIkMysEEMZNcaklpc+Lf1OAM8g+hS6HKlz1XZvv1ArzvGmZx7GZJ4J+hhLVOMkbu08o
         c5uLFO/4uKXwDXTJ+/M4+sbN2Tiy1pJzxz+Ec2M+vX+5UFM4lGnaV99zK8ueUCfDTorR
         dX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yK4+pJccx+L287LRxGHzTccwnqeDUuV1kwFuIH5wuVw=;
        b=5KMcOn9re7Hbv4SLbUb04EwSPnEOVjVIVhaW0vhkT+D7W4N5enJJBUUDI/wvgxPJvk
         2BC32BPTH9NjSDX91tZGcrj6jF3nEy8kSlBeW5YXSmKRWbCBpxoE0v1SK31mIkqFheVa
         EKeUURYvtXk40FMf9TYujob1EjJJum6D3t1gc51GLpyZja2rjyRCpdRzOhmhFd0xFvUX
         GerbFrdgz3AobduH5iZ/KMPn6on31oTo5ZQvmPcdr55OXMGcNpD3yXGbU1pGkZHykmKw
         BZWRLYg09eHvznLrm9791jH+ze8tktAau5m1hI1+jyg1Omi1xWutzRuMclzB5EZBrZY7
         XnjA==
X-Gm-Message-State: AOAM530gpQARJtouIpRKnMZXZUorcjV8hEhsLv1eLbh7mIfTSJiwMn+D
        C0rBS4ztLsdwy2li/8Nd8ipozTV1PtLLew==
X-Google-Smtp-Source: ABdhPJw0ihAuouAtL7667xaUqI13cOXkzgsMzFFzcWGbXnJNyqSsW5UvGDnlI71/IIjeBeAISjCy/w==
X-Received: by 2002:adf:cf04:: with SMTP id o4mr4653696wrj.352.1632816339914;
        Tue, 28 Sep 2021 01:05:39 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id c9sm1928057wmb.41.2021.09.28.01.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 01:05:39 -0700 (PDT)
Date:   Tue, 28 Sep 2021 09:05:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v1 2/4] mfd: arizona: Add missing entries SPI to device
 ID table
Message-ID: <YVLM0VxNGdH8AxQO@google.com>
References: <20210923194645.53046-1-broonie@kernel.org>
 <20210923194645.53046-3-broonie@kernel.org>
 <538c0c79-d568-be03-e524-01f5c6429554@opensource.cirrus.com>
 <20210924112000.GB4840@sirena.org.uk>
 <20210927102754.GE9223@ediswmail.ad.cirrus.com>
 <20210927105528.GA4199@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210927105528.GA4199@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021, Mark Brown wrote:

> On Mon, Sep 27, 2021 at 10:27:54AM +0000, Charles Keepax wrote:
> 
> > Yeah we should really be having different lists for SPI and I2C
> > here I guess. I am happy to have a quick look at doing a patch
> > for that, unless you particularly want to fix it up?
> 
> I dropped the patch so please feel free to go ahead.

Just this one, or should I drop the set?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
