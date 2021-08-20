Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DFB3F3633
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 23:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhHTV5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 17:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHTV47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 17:56:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38074C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 14:56:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r7so16229216wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gX3npG6nSHEYtTzLcQI4FxI/LHa3i3+15RcFQa4MgFg=;
        b=cO0WcSGLTozp1BsFMn671wiXsyEX7v2JxYJoO6Mw5ebYv2T0Psd3sKSyTwCrpc31ps
         55F4P5moqxxXCPgnkomOFuPQNbXboplpXEAX2EOws4fXXcTyb6IanYN0xRtbhe6OZWh/
         7zPifIfNdEHW5tQI64g2OMZZzuxB122V8z/dPwo1kt6+SNZK6iAsMlgquP7JU18YcU7y
         /bBx1qpgq5Lb+wRV8Wjv1Mcwkvm9yn7jg4eQFesEcEV35s+je1O0+o5UJjA5/zVhKU3u
         M6bjT+Bjnl4leeThkse5EpBk1h7CBJ34DPIPs5P45vtdHgh+1j+zKXysTW95AyFLhroA
         f3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gX3npG6nSHEYtTzLcQI4FxI/LHa3i3+15RcFQa4MgFg=;
        b=c6M5hCWNcsZSwwb5ZyVFiAuQC+F4S0olkxGaEVS+DcdZuzojFX7WnpJd7ewTDXFGjx
         24lpJ3ly5AN/usnSBZCMXfamZVrWClYxbd9X7aOVPWq+k4JUOtaScPmT8EWbazsuved4
         I4sFzJ1xgvhYjhYsx3NZp59kLbda1XTTi43jcLEi6rJSOnn8opbeoVRHUL7ooQzPVcT3
         9iGpqPD9M2w1cxqWxVS1Y9rfDd6mkJ9AoBvbd/6sDdQQq8iRLgih9bN/wcE+YFa5+E6/
         CzinQNLw08ax/gS5lZj5aNyELOJMwkHKwH+E2ooNhzC7W6O75AYbH5muKyoinPdlg8Ht
         jUfA==
X-Gm-Message-State: AOAM531UppUpvbxtlbdBX7XHfXvagrsNFpL8mfa+SsZCrsnBOEGPcEX0
        d0xFeb+rvvcU4q2H33qysH6qyw==
X-Google-Smtp-Source: ABdhPJzR0XNKHULJiXsLYLmAHPPLIKJ3zDCAy+W7qq4yFQQUXyFFhCryaYT4I5zCzda4nbCl5u/img==
X-Received: by 2002:adf:dc0b:: with SMTP id t11mr859514wri.259.1629496579828;
        Fri, 20 Aug 2021 14:56:19 -0700 (PDT)
Received: from ?IPv6:2001:8b0:dfde:e1a0::2? (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id c8sm7091974wrx.53.2021.08.20.14.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 14:56:19 -0700 (PDT)
Message-ID: <b18430516495e2e52fe6b0b1e1461bac640be44d.camel@philpotter.co.uk>
Subject: Re: [PATCH 6/6] staging: r8188eu: remove free_xmit_priv field from
 struct hal_ops
From:   Phillip Potter <phil@philpotter.co.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net, Greg KH <gregkh@linuxfoundation.org>
Date:   Fri, 20 Aug 2021 22:56:18 +0100
In-Reply-To: <3280989.scCUJ3VkD9@localhost.localdomain>
References: <20210818234253.208271-1-phil@philpotter.co.uk>
         <20210818234253.208271-7-phil@philpotter.co.uk>
         <3280989.scCUJ3VkD9@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-08-19 at 05:14 +0200, Fabio M. De Francesco wrote:
> On Thursday, August 19, 2021 1:42:53 AM CEST Phillip Potter wrote:
> > Remove free_xmit_priv function pointer field from struct hal_ops
> > definition
> > in include/hal_intf.h, as it is now no longer used anywhere in the
> > driver.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >  drivers/staging/r8188eu/include/hal_intf.h | 1 -
> >  1 file changed, 1 deletion(-)
> 
> This entry could have been removed in patch 4/6 or 5/6, but I guess 
> it's okay to do that here as well. Perhaps the three patches from 4/6
> to 6/6 could have been merged into one (because since 4/6 was 
> immediately clear that this operation has no use at all).
> 
> Aside from the above considerations, it looks good. So...
> 
> Acked by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> Thanks,
> 
> Fabio
> 
> 
> 
> 

Dear Fabio,

Thank you for your feedback and acknowledgements for this series, much
appreciated.

Regards,
Phil

