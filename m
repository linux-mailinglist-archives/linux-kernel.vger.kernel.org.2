Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA733332DFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 19:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhCISP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 13:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhCISP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 13:15:27 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0A2C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 10:15:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d15so17580296wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 10:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=51ug9yCfEW2iToskwVk6YubZKZ0QECVbKdgFfhYEwAc=;
        b=UL7lLjMQtWS6CTubyMlNqo3BCqKKFapthcAP3YheZuVUb8Y+Xo08eGViv9s+ddGagF
         f0KWKzhWDm9z0qwBXvDk4iEOtoUrxCDfjCTLihCCEdRZBOa/nz+XQCbvTWXYYInrtVYt
         yHjV8MOWXDvld96yfk1c2C/Niswul15VNr/EPfjpCpgdgUyefHes7DIKphoznCjCWJnb
         m3oYxE06q/7NdSg0NK6Iv/zTPA9fxL9QGRfV3gpiusoInq0x2D62Phakb6CzA8a366gv
         HzXAPm5+mOEgEvFVY/w0sPeQUyYKB0OKI3Uo5ZTJ/iqvYvT5xylJ/nbmqst+xl8+Tkhw
         k3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=51ug9yCfEW2iToskwVk6YubZKZ0QECVbKdgFfhYEwAc=;
        b=bRnhpDQrCjFBP08lBymWhTcXAQNDrQyuCArbENzxiyhcdJMX8X7BTkyQMGRjETvxCb
         9JXfpv5h3VAqAyaPDhbcynOdFLZKCbhbx1wZ9NDyn80vMwAF8mK3h+cryCpGiTsNc1h8
         xQvLdqanIm8wKn7HD0FTlV6aOvdUPl5ElFg+dW3Bg5HyuViQN/n6mAbL7LZ/1G1v6gkM
         zlrCc3s9ExmoMN87gadgvYRzjoJ3mB+O7HUlztMyPR3m2mp3xl3LOiNF/v1PUmq2EGwg
         BI1fApzWeC3AH9cxUFszcFk+6TEHDaCSxP30LP+BVu//bKprHNwcIpKlOtdiZJDMx30U
         u5XA==
X-Gm-Message-State: AOAM533LntgmYah3w1rLU8oZ9sqBOzFm9Zs1mzQqvVmK3ukzD3EDjXDA
        aqu8I2kYOnqbeKIW8Qc2WXllEJcKkaPKog==
X-Google-Smtp-Source: ABdhPJzwqZIR9jHWPC1AvOpVLZMQU63gHSH0II7AIS/9ku2uG5yADNnTf4tRWfPGFDGPoK7ODLrZ6w==
X-Received: by 2002:adf:a2d3:: with SMTP id t19mr29530630wra.299.1615313726136;
        Tue, 09 Mar 2021 10:15:26 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id v5sm5474666wmh.2.2021.03.09.10.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 10:15:25 -0800 (PST)
Date:   Tue, 9 Mar 2021 18:15:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Li, Meng" <Meng.Li@windriver.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Hao, Kexin" <Kexin.Hao@windriver.com>
Subject: Re: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name for
 regmap_config"
Message-ID: <20210309181524.GW4931@dell>
References: <20210115015050.26657-1-meng.li@windriver.com>
 <CO1PR11MB48497CB7B11EDA65A3941FDCF1819@CO1PR11MB4849.namprd11.prod.outlook.com>
 <36cc2d810d90237947ad953ebd6b9fb7@kernel.org>
 <20210222092114.GE376568@dell>
 <CO1PR11MB48499549EB56C7EE119E175DF1819@CO1PR11MB4849.namprd11.prod.outlook.com>
 <20210309094310.GO4931@dell>
 <PH0PR11MB5191EA634E57B8A5FF0DE991F1929@PH0PR11MB5191.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB5191EA634E57B8A5FF0DE991F1929@PH0PR11MB5191.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Mar 2021, Li, Meng wrote:

> 
> 
> > -----Original Message-----
> > From: Lee Jones <lee.jones@linaro.org>
> > Sent: Tuesday, March 9, 2021 5:43 PM
> > To: Li, Meng <Meng.Li@windriver.com>
> > Cc: Marc Zyngier <maz@kernel.org>; linux-kernel@vger.kernel.org;
> > arnd@arndb.de; Hao, Kexin <Kexin.Hao@windriver.com>
> > Subject: Re: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name for
> > regmap_config"
> > 
> > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > 
> > On Mon, 22 Feb 2021, Li, Meng wrote:
> > > > -----Original Message-----
> > > > From: Lee Jones <lee.jones@linaro.org>
> > > > Sent: Monday, February 22, 2021 5:21 PM
> > > > To: Marc Zyngier <maz@kernel.org>
> > > > Cc: Li, Meng <Meng.Li@windriver.com>; linux-kernel@vger.kernel.org;
> > > > arnd@arndb.de; Hao, Kexin <Kexin.Hao@windriver.com>
> > > > Subject: Re: [v2][PATCH] Revert "mfd: syscon: Don't free allocated
> > > > name for regmap_config"
> > > >
> > > > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > > >
> > > > On Mon, 22 Feb 2021, Marc Zyngier wrote:
> > > >
> > > > > Hi Limeng,
> > > > >
> > > > > On 2021-02-22 03:45, Li, Meng wrote:
> > > > > > Hi Marc&Lee,
> > > > > >
> > > > > > Is there any comment on this patch?
> > > > > > Could you please help to review this patch so that I can improve
> > > > > > it if it still has weakness?
> > > > >
> > > > > If you are confident that the root issue has been fixed, no
> > > > > objection from me, but I'm not in a position to test it at the
> > > > > moment (the board I found the problem on is in a bit of a state).
> > > >
> > > > I'm not keen on flip-flopping this patch in and out of the kernel.
> > > > Someone really needs to spend some time to map out the full
> > > > life-cycle and propose a (possibly cross-subsystem) solution.
> > > >
> > > Thanks for all of your comments.
> > 
> > Have you looked into this further at all?
> > 
> 
> No.
> Maintainer expects better solution to solve this issue from frame level, and consider cross-subsystem.

Yes, I do.  Does that mean you're going to drop it?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
