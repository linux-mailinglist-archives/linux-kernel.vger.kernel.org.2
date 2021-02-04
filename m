Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AA830F426
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbhBDNsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbhBDNqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:46:52 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18EDC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:46:09 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u14so3586712wri.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 05:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Dc2qXVoLurmP1y6qGwsvfYp52EWzBpvbfbLeLIxscWo=;
        b=vcX10tK1JXGeAOOqnN5qkSnrM0WTN2R/PdrCmgvbefToo/2uSgDcfLT6Xd8NM/mKEl
         xMfRDm0yVYJQX8w/QhvLlCks+9AJgUiQlDMqupirjP9dAV0pn+XAbUpv9gpNFwEGNg22
         q7fBzmF0ensUbqLyzqCPm+6i+m+rvJlO3fHrtyCKdwTStk1H03Adc9d3bxeuqJ5zRd4L
         3vtLRDddOqVlUf9sVnHZ9h+8USZ3ZMEykRzMLAAoi6qeQWO328wvXjZNDf+2HmShrvoP
         hRkKEUGLbrHEPnVLdHJ+K7BUj3rgzVaPyFWh11Q0ZFB93DpTM7LsdzjIbKazFBKf0Q8A
         9l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Dc2qXVoLurmP1y6qGwsvfYp52EWzBpvbfbLeLIxscWo=;
        b=DqKPEDgRVoslrC9IQWf86Q4W3/ifZg4qrciOVsowdCtTmxfp1mk+Ua5tkpvsRj19Kj
         cSUYf6Z6Foq8USvxpWAOa9sYy9EkoXi10U2FgQI5Rj1K/NZtej976T1LBJ8gztuF9tiR
         6lVPm2rtCL3ZETkDOy5owrZcxVM0V1yIEdT25v5WUR+L0wIOI/dJc6LoKXAdH48NJrfy
         sgf/BhDewY4OrB5FOwr2ApXF6gK14uZy1JnqmjGb0VobnT+pZ/aU1yA2OBG14OG7TWlL
         NUnT4WNpSYnnG63mMLIjKFvAbaURp9JV25SDV08Rghsk55eCdLtSDjUWZzxof9l8b9eo
         FdjA==
X-Gm-Message-State: AOAM530p+OeNmnX9B8BGImAWXYO7RxeeE2MElSNaQw5SDDig/veDjIMi
        Th6+8BhAmlgHIifSCmUQtLyedQ==
X-Google-Smtp-Source: ABdhPJydeDZ+8e1+KMnG8GflcBvfY2Mg3GWNDaEqkj0KlgohdEXPBXZQ8GD5ktuU19qx3aBMThKUPA==
X-Received: by 2002:adf:81e4:: with SMTP id 91mr9635163wra.161.1612446368624;
        Thu, 04 Feb 2021 05:46:08 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id b4sm7912769wrn.12.2021.02.04.05.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 05:46:08 -0800 (PST)
Date:   Thu, 4 Feb 2021 13:46:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail boards
 with WM5102 codec
Message-ID: <20210204134606.GH2789116@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <249f1a7c-048e-d255-d860-68a97a0092c8@redhat.com>
 <20210204105748.GD2789116@dell>
 <7f53dede-946e-c38e-e871-3df1119f1faf@redhat.com>
 <20210204124335.GA4288@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210204124335.GA4288@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Feb 2021, Mark Brown wrote:

> On Thu, Feb 04, 2021 at 12:07:49PM +0100, Hans de Goede wrote:
> > On 2/4/21 11:57 AM, Lee Jones wrote:
> > > On Thu, 04 Feb 2021, Hans de Goede wrote:
> 
> > >> series are both ready for merging. All patches have Reviewed-by and/or
> > >> Acked-by tags now.
> 
> > > I don't think they do.  You're missing ASoC and Extcon Acks.
> 
> > Right, what I meant is that the patches have been reviewed by other
> > stake-holders, including the follow-up series being tested by the cirrus
> > codec folks (thank you Charles).
> 
> > But yes the actual subsys maintainers have not acked these yet;
> > and I'm aware that you will need those for merging this through
> > the MFD tree.
> 
> The usual pattern here is that the MFD patches get merged and then I
> pull a shared branch in for any dependencies - at this point the series
> is now on the backlog of serieses where I'm waiting for the MFD to sort
> itself out before I really look at it again.

I tend to push patches awaiting Acks to the back of the queue.

Stalemate.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
