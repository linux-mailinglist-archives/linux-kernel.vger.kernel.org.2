Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB5835F138
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348921AbhDNKE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346631AbhDNKEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:04:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C45C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 03:04:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r12so30533520ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 03:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2OpST8LZI3on8yL2X/9Onf1MCgH2abOvm7orSC5DgBk=;
        b=lt8+i8lovz9jfZGaOrASIPMN/fDFTBck9Fq0nTM7pv1znMsXju14rrSC+rEONzv9ar
         u8P/Ee2s4Az7i0+dfG7w0hGm4uxOQxlg9BBeUdtQ66hdIlFpTie0XO4AFDHqK41jtekf
         PxP3cAUwvl9veQ5sUPSixbmg830+ZVLq2TlR+1K/ceAAc9pFHvIYXLFyyk1xXmwEm6Zm
         itFdzMrXqMv0FpCEDFEwPrcaS3ZlYZqrTliSbNIjY2ewsuRbOQRNjohDB3Wgm47jwWDf
         CKXzTRgoug31mdPXDoaSeNa0hJL56biyPxQz/vvKy43gXYgE5SpOc+1jKG/iszmaaDNr
         CFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2OpST8LZI3on8yL2X/9Onf1MCgH2abOvm7orSC5DgBk=;
        b=IfBlrrOfR0BdzftJgbtIl2VLp++VGuLhxpACaAFz3rwMGXEGSkLRRllQCwvyKu6Rc3
         00xmrZ6mDVgxRoUQh3G4eZVZWPTbzteq2taWRgjzMHF2nl9xK1liEogg2DXhdvR43Npc
         5hI3Oog/P8KMuzTrlF3EmuQj88w2xVhlV+4MF6Vlc2s8pFwBVB8NDKxwYCpZocZAGPeA
         xr6gr+wxuHyFEw/KJi5uOI0aJE33DcnbXLQnuX0Pehl0IPEqYoCDKpO6b76PLo7QhgO3
         ghFekrE1oulsUZeLRyPEWRNSD0DtE2fthNPvJazkTvPR5Z/cXyO81F7ejvlIHdhq8kQO
         dFzQ==
X-Gm-Message-State: AOAM533petbR+6REE1o3iifmgqAWb2TMZaSSeEFBvoeUq24VSBqZhR2Z
        5uIBVG7b2Cj5wYXSvrnFHx3ITWxx2cHeyA==
X-Google-Smtp-Source: ABdhPJz91W52QEgwyT/N/q7ZpiRgN8LqDMeAi7/HCXCRFRkriz17el2EnLVeJBWrE/CdPAzD1GN89A==
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr37360252ejc.292.1618394640619;
        Wed, 14 Apr 2021 03:04:00 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id d18sm1809230edv.1.2021.04.14.03.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 03:04:00 -0700 (PDT)
Date:   Wed, 14 Apr 2021 11:03:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: Re: [PATCH v2 2/4] mfd: simple-mfd-i2c: Adds Ampere's Altra SMpro
 support
Message-ID: <20210414100358.GL4869@dell>
References: <20210329015238.19474-1-quan@os.amperecomputing.com>
 <20210329015238.19474-3-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210329015238.19474-3-quan@os.amperecomputing.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021, Quan Nguyen wrote:

> Adds an MFD driver for SMpro found on the Mt.Jade hardware reference
> platform with Ampere's Altra processor family.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
>  drivers/mfd/Kconfig          | 10 ++++++++++
>  drivers/mfd/simple-mfd-i2c.c |  6 ++++++
>  2 files changed, 16 insertions(+)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
