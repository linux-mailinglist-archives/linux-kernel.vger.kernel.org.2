Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A158417BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 21:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348208AbhIXTum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 15:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhIXTul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 15:50:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E17C061571;
        Fri, 24 Sep 2021 12:49:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g8so40203412edt.7;
        Fri, 24 Sep 2021 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QW92Qv4SFz+xJLwMpitNeGeXSEO3iCzliN7CNcfcGjQ=;
        b=kW5TWvYFOIDlox9qryStTHaG6TKCh1jV7oeBP7mFypDNlqoXoZZ5YNPWK/7WB8MjNO
         kedSkgmIGfnPOH8P1zcoMBkjZBQEU2qlDcHnDujwPGu5VEWQsOoxNbWZAB3Z4R4H8yV6
         JwXTBr1zcML/Guk7pJFDMwDGG/TrUTrDy7YeKvjaun8j1Pc2YZ7oTTo5xDTikU2+R6ra
         nTFtjQQpqajFIxcHgBY1IS/Lnd0qdJm08bqKScONTo/gHSaBMj0G0P2ShJePmwMOvWS0
         C2hmDkHQXT+6hULa4FRf3xTnrxYjMMnWlIfbWqKqYV5AAsjkC3k8mHSrzS6+s49UaEnC
         qfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QW92Qv4SFz+xJLwMpitNeGeXSEO3iCzliN7CNcfcGjQ=;
        b=yUjbs2idJMaV/vO4i5BrMvI5kylvt65XlGyITVDFRu9quPJ8T05PawTtUdJMj1vI/P
         2AEJ6tcIw4iPoyc/i+gMr958IgSONWXLBQzC2UtSa5k4ZIJgMEJWm8oL36OwQUJbsIf2
         lszQo5pMocX2erQYsqRJBqZtQAltDTqcgmEwYddfoKxc0uejvuoHFEbsmdajPMMh/g35
         VBEO8veJ2z/IyZKEPTwp38uqaayxZKiVJWNz6Icgt2bU/MHV5ic1ofqXFnIFNzzLrCUG
         gGuqtTSlK/WSEcJeC8npNIv33jG58muC75CfcVPXBKa+oJcI8sQ8o3ydAKCh+b0xT6Vh
         HdCg==
X-Gm-Message-State: AOAM533vffFdXuycYRvhZRBirL2rxoZNGEFuy+MLDMvxavTh0F+ydk3W
        1gun41PErr0HDTSXdVEIKK8=
X-Google-Smtp-Source: ABdhPJzYofOMU3LuxBg3WTEPoVXRm3su2KB2lGTTymDEMccd1unXUv1Mx+hLdCM2QYORTyM7LmzQcA==
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr13301176ejb.108.1632512946568;
        Fri, 24 Sep 2021 12:49:06 -0700 (PDT)
Received: from tom-desktop (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id r23sm5885384edw.39.2021.09.24.12.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 12:49:06 -0700 (PDT)
Date:   Fri, 24 Sep 2021 21:49:03 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix: PCI reg address is not
 configuration space
Message-ID: <20210924194903.GA4836@tom-desktop>
References: <20210918164153.207146-1-tomm.merciai@gmail.com>
 <163214478702.1547258.5943542169692932677.b4-ty@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163214478702.1547258.5943542169692932677.b4-ty@sntech.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 04:28:48PM +0200, Heiko Stuebner wrote:
> On Sat, 18 Sep 2021 18:41:51 +0200, Tommaso Merciai wrote:
> > Warning (pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not configuration space
> 
> Applied, thanks!

  Hi Heiko,
  It's a pleasure. If you need an help on other stuff let me know.
  
  Regards.
  Tommaso Merciai
> 
> [1/1] arm64: dts: rockchip: fix: PCI reg address is not configuration space
>       commit: d146198a858ac54653be6d90e3282a7f788c1960
> 
> Best regards,
> -- 
> Heiko Stuebner <heiko@sntech.de>
