Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B893E0F6D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbhHEHkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 03:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhHEHkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 03:40:23 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D7FC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 00:40:08 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a192-20020a1c7fc90000b0290253b32e8796so5024406wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 00:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uXMFE+x+HBk40J/+blV0JV/UHz61yssYSvQ4knaVK2g=;
        b=PFfP7KuH7Ir7atvYwV57prUlPGPij4lo7aJaDURFOi5zzVKFgi+ZobyR1mQYQgRwqk
         5D4M2MjghImr2du1bwnrpt9zr/FwYJB7JzNJlvMmEn0rEMziNvN8UZmyn18PILufPAvj
         W+vNOiKFgNmZ9pgUFT0IjZguKYTS8j9uc5wrlI6DB7OwZMVt5NdgjvlGTsyY0cf2gifk
         g1Xc89uTN604lbbwREKwCATP2JPRCeSk0wd4ziotsy5L3fe2wdQO5GnqXjKbopAWaWF3
         AKfARyTuzG4XtbFI+9u8cySxbbZSiVg5g+iSgxond4Z63IqwcO62p+rp0Lzw/1T+jcPW
         zW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uXMFE+x+HBk40J/+blV0JV/UHz61yssYSvQ4knaVK2g=;
        b=VI33vEl2j3OTvwFTeLUs1Zpgp/9cBKUaGQdMw/F4Ngn4gFDp6Il9TOJ4rS/x8pSg+3
         oDCbSPp3CvcFmNtbW/YvROunR+gL7Y7Gf8oMhAHF+d+YnDGyRsXWrSrdIpHcZNwNKFs6
         9aHqXirh6KjyCp4vzgjlbiC9+MrL7e8MvBPtYAlBApH4garNpTu+cH2iH6e9um/rFOmP
         xcNQBYZJKcb1H2A390SEZ0rvpMPNaMxsj2x+719M8REQk/KRcSvwqm/ST0ABQahW502N
         b+NuNx0ssJMmvYNb8dltm5T84V0j/yhjLBTEQO/5WDnTcMnpQcx/uuBU46Zpmo9f3F5C
         fRLg==
X-Gm-Message-State: AOAM532zM8SDai0CKaN49+PC/AUAfTWRYPWa8w7p8a7um13oGrf6cp0G
        a+mMcQeKAOVQ/6pN6egvxCPY8w==
X-Google-Smtp-Source: ABdhPJx9QpR1i7rTCVl9lmFeZhDDcReBbxopKH+ZiiA5j//M0m/b8UaOuMkaymP8xdsIHTczgyYCBw==
X-Received: by 2002:a1c:452:: with SMTP id 79mr13476817wme.125.1628149207386;
        Thu, 05 Aug 2021 00:40:07 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id c204sm8122404wme.15.2021.08.05.00.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 00:40:06 -0700 (PDT)
Date:   Thu, 5 Aug 2021 08:40:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] mfd: simple-mfd-i2c: Add support for registering
 devices via MFD cells
Message-ID: <YQuV1bhnv5QHGqNR@google.com>
References: <20210804143744.689238-1-lee.jones@linaro.org>
 <328e69d4d6d57b101af1ab1346b0809f@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <328e69d4d6d57b101af1ab1346b0809f@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2021, Michael Walle wrote:

> Hi Lee,
> 
> Am 2021-08-04 16:37, schrieb Lee Jones:
> > More devices are cropping up requiring only Regmap initialisation and
> > child registration functionality.  We currently only support that if
> > all required devices are represented by their own Device Tree nodes
> > complete with compatible strings.
> > 
> > However, not everyone is happy with adding empty nodes that provide no
> > additional device information into the Device Tree.
> > 
> > Rather than have a plethora of mostly empty, function-less drivers in
> > MFD, we'll support those simple cases in here instead via MFD cells.
> > 
> > Cc: Michael Walle <michael@walle.cc>
> > Cc: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > 
> > Michael, could you please test this on your platform to ensure I
> >          didn't break anything please?
> > 
> 
> I'm getting a null pointer dereference.

Perfect.  Will fix.

Thanks for testing.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
