Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA7C3459FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 09:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhCWIoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 04:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCWIoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:44:07 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33B8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 01:44:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id w3so25715003ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CA2HZYCAYEZ2FQmqritjssLiySaAB6hp+s1n0HMOzrM=;
        b=mXsIAOkGezeWC53T0nh3D1JBDoJ4z5/OTcthjLlPayIzf4BV/jnKTl26vlpiXk0kwA
         +2FeUBtGby6BLKHHX+ERL/w2K78vRPvhGW9ymAhwzJdlqIGq7fmHx4f8KH9P9WkAftQ+
         +2O7oaWJUczuKjvUYsJTh6rD2TfjgP/zuB+mLTtpvgIH54OCAYO+cOeH635SzrmRtM2m
         h0Q22/SzDXh5kyycPLfZRulpXkL9P+/bk7w6wGB+GRtrRQdp3YkY0iqVf2q5cr8e/7mG
         heOe7dDwSq0YFujk4oThOjuymsWCnxVhWQiRK6ULZBCJfX0JnPNHgMiXnrE/n2c+6zco
         O/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CA2HZYCAYEZ2FQmqritjssLiySaAB6hp+s1n0HMOzrM=;
        b=QjD8+qkqQWnkEFfKtxqShgdnKhMRMGddcDDByaOvHdQTB9Z0zkBq2G8zSokaCG8bZD
         J2MC2qn6qayBLXfhrLBU/nKtj7rjn+h5pqVXfkibhLKUaPDFXkepQ253lxTBcBd6vbzj
         x/TDYo7SAr4wbseqd5Gk0TeHRsUXDcBkQOxaSZ5Z81GOesnuhqFGZQNP9cbIR5XXNI0d
         aGnQd/2ck73w8CNp6pHMInDzd20e5oSeMemM1C/pIqjTzRZb3uxmyOPQeoNHjooFXsyv
         SBi/cSwZcANZXYD/cPsjchPIBtCnWXk81jn0O29n/ktjMWryr7OtgabU8ierWejfl0se
         Xk4A==
X-Gm-Message-State: AOAM532ptyP+b/qurXqBIdrcIlsgJsRZV99iZsjPTVoPJd3N4HalbFmd
        igaT0T8Lu3q+FUeyoYUb63wWyQ==
X-Google-Smtp-Source: ABdhPJx9f42ahaRhGy9fzg+cOl9fMRYRkTUnFmGO+1xdqw33EBaNEa/TmFK5DHuUkPMIJUjZhzIdiQ==
X-Received: by 2002:a17:906:1b54:: with SMTP id p20mr3758551ejg.307.1616489045510;
        Tue, 23 Mar 2021 01:44:05 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id qo25sm10738421ejb.93.2021.03.23.01.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 01:44:05 -0700 (PDT)
Date:   Tue, 23 Mar 2021 08:44:03 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <20210323084403.GG2916463@dell>
References: <1616254985-28920-1-git-send-email-min.li.xe@renesas.com>
 <20210322150319.GZ2916463@dell>
 <OSBPR01MB4773618A38B6797EDDE2E5B9BA659@OSBPR01MB4773.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSBPR01MB4773618A38B6797EDDE2E5B9BA659@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021, Min Li wrote:

> > 
> > I'm pretty confused.  This has been sent ~6 times already.  What is the v1 of?
> > Is this a different driver?  If so, why does it have the same $SUBJECT line?
> > 
> > If this is not actually v1.  Please provide a change-log.
> > 
> 
> 
> Hi Lee
> 
> Sorry for confusion. This is no version before v1. The reason you saw it multiple times is because 
> I was basing the change in the wrong tree and I now I switched it to
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/
> 
> I am wondering if this is the correct tree to submit the patch for MFD?
> 
> So to sum it up, the latest patch is my first version to this tree.

Either MFD or -next is fine for MFD-only patches.

Has the code changed at all in any of the patches?

If so, please provide a change-log, so we can keep up.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
