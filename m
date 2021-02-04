Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA91E30FB16
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbhBDSRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238156AbhBDSQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:16:38 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFBCC06178A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:15:56 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id w1so6966388ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sHPNpNqRTc3lgTTnJatrn/4jH2bI7C52VyBZqixyw2g=;
        b=gaN16r/UUj+zzbzPB11XW7ssMApTMkYDt3TmgYzvAeTZiRDxNHC0Oja+qS2df1AKKN
         Q690eEXFKXP3i3xfnkfddvO0fP7a0GlHaHfe0ulN9NPhKyc66AJ2/YrpGoo2SDnjaZZ8
         ew2VrJO7jdThs9mHsz16Ps4nmQRXhkyhIOts4rXol1CLRHITrd6SwbodDY9fOu8Qsr9O
         GYQk3KRh12tzFvwr1s3CPIH/TRTyLR96aG6Dw5Y9Ob4orjSSLEgQVP5yhW6Zktouw8PN
         34jMMF8VwCPzMye13PCbMbDL/0j3pbKW9rYJdVu2nEfRkDJ/L+nLuURXbAzNFk/oHTfW
         b7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sHPNpNqRTc3lgTTnJatrn/4jH2bI7C52VyBZqixyw2g=;
        b=qanCiFOMR5eODmubrMJ4Sk6tHxxfL/YuOrf6h2N312L4rDhL3Xksf5MYDUW8KxCvqO
         KReJlJWIWxuKKiN8EPN2cC3IDYLfPt2mG1rMuh++aHncTH4/N184eT++rQxFZtvvelJ5
         qfzItFXLqhHzuClmnEGn4562NT6LvdKC7S33pxywzJjG7jxNvCvOR+nedtZnA5SfFZL3
         nTTr+jko1+JL0k9u15qZaEngSg0M+8ddIAySCMnka9gvi7bzzEvTzkPTeRmp1f6nWmRl
         7j8uZFcbNx5htNg7HkGYW3DKTsYDKNamLuL8Gh/gWY4Ww6I6JEPutL1hvBtQl7eJw3Hb
         dXYA==
X-Gm-Message-State: AOAM5325nowOCLNwT5NHOhc/o1OItoehkC4+8CQVpDdT3ZSrdXDoAALI
        dLd4b2WE6ePVq1zW3yWRMDcHok/ZPuE=
X-Google-Smtp-Source: ABdhPJzt+oRbAoMs96bM72e8WIvvfb7+n4R3t18vC8R15kZ6WcsGDXWfZjToNyYr4maLekp/7eY1Qw==
X-Received: by 2002:a17:906:e15:: with SMTP id l21mr366735eji.376.1612462554565;
        Thu, 04 Feb 2021 10:15:54 -0800 (PST)
Received: from localhost (ipv6-163808adb974b8b7.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:1638:8ad:b974:b8b7])
        by smtp.gmail.com with ESMTPSA id f6sm2881926edk.13.2021.02.04.10.15.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 10:15:53 -0800 (PST)
Date:   Thu, 4 Feb 2021 19:15:41 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     thierry.reding@gmail.com, Fabio Estevam <festevam@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/panel: simple: add SGD GKTW70SDAD1SD
Message-ID: <20210204181541.GA13054@portage>
References: <1612287314-5384-1-git-send-email-oliver.graute@gmail.com>
 <20210202175910.ycnf7ehk2i4u3f5o@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202175910.ycnf7ehk2i4u3f5o@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/21, Marco Felsch wrote:
> Hi Oliver,
> 
> On 21-02-02 18:35, Oliver Graute wrote:
> > Add support for the Solomon Goldentek Display Model: GKTW70SDAD1SD
> > to panel-simple.
> > 
> > The panel spec from Variscite can be found at:
> > https://www.variscite.com/wp-content/uploads/2017/12/VLCD-CAP-GLD-RGB.pdf
> > 
> > Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
> > Cc: Marco Felsch <m.felsch@pengutronix.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > ---
> > 
> > v3:
> > 
> > - added flags
> > - added delay
> 
> Thanks, did you test the changes?
> I just picked it from the datasheet.

yes, it didn't break anything. 

Best regards,

Oliver
