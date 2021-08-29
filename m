Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC0D3FAD75
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 19:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhH2Rfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 13:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhH2Rfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 13:35:44 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA2BC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 10:34:52 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id m4so21601683ljq.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 10:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+tyqDIpy9lHRPLEmWy2u7JRjZCjvRQis9Naz0mJ7yyE=;
        b=oySpogacRpk+LnLteHTL+o2IoGe71EsG5C/4mD9Ax0r26rFKnrzw9z2VMz7rcjWYdc
         fw15ujivpp8Md4Kz+u3+j5zTzZXJiQewWAE4GSmX9MTAvudRvByxHXJXNQdGFllvo7sQ
         UpzpElBsMS+G0kQ8F1v9FWXYIqJrnhEeHHG0whVXni+ClRcl/iR82bXJwuhzKEthXthJ
         ORUXsDpKMu73UHfW5j9naMJXJmM8qQFP6v/Ip8EsTMGtY3IatnNlmQYXvFgQIPS4W4AC
         mbTaJKjGXFD+yXlIHk3PXnXm4FqfLSp8OfbI2W2nH/bGqDrhsDDYoKIx17rBFZ4FBat4
         x2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+tyqDIpy9lHRPLEmWy2u7JRjZCjvRQis9Naz0mJ7yyE=;
        b=fvvsZQl+CDWPBA/3W+3QLO5Jfn8Jli3U1ugZNrUi36HB3VuOQ4sRJKP9Uzq2JHeY3d
         SH+8hnHK4XeNVyDKlteADyeIMkVQWI/bE7k7Vx4ejx1125L4Y9As4Vt4oufQtLaXQgvJ
         MsH5wg1V8BjUMuc7GBZg/WabraSgzrhLSKF+zg5czv9scZLQmNWPOrqem+zf2H6jNakn
         /f71IOSJTbR9FNIwTHoJCYKq1Xiyi3GTqkdEUdIRCMJI21zX0WPJNUmRnU8IlyhaBWsg
         qdhRxXGnkSvfFZW2Avk6HNknv4kT0V8/cZx1IyPpp/isBJPPajOEFknzXROEq9S598x9
         ckQw==
X-Gm-Message-State: AOAM530Dh6yDzU19tXUEVgryiOnen6RRzb1ZpKSynYwsoEz9gpfD5ZfX
        MVjjwyCNMeEisDTM/ys5bjs1/LLKLCGWfw==
X-Google-Smtp-Source: ABdhPJxNAUdpNwROozWgJHg/GNiHjvth3ssRdC8Jhxxk0/TA5hltCIGQaZPDWWSVf9B733nuKb+aAA==
X-Received: by 2002:a2e:8610:: with SMTP id a16mr17648219lji.66.1630258490789;
        Sun, 29 Aug 2021 10:34:50 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id r23sm1508814ljd.86.2021.08.29.10.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 10:34:50 -0700 (PDT)
Date:   Sun, 29 Aug 2021 20:34:48 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Skyler =?utf-8?Q?M=C3=A4ntysaari?= <lists@samip.fi>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: [drm/amdgpu] Driver crashes on 5.13.9 kernel
Message-ID: <20210829173448.3cwk4rz6wfxfxdpj@kari-VirtualBox>
References: <4ada1100-fbce-44e4-b69d-0f5196f86bcb@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ada1100-fbce-44e4-b69d-0f5196f86bcb@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 06:38:39PM +0300, Skyler Mäntysaari wrote:
> Hello everyone on the list,

This is universal kernel list and it is not read by many. I have added
hopefully right list (amd-gfx@lists.freedesktop.org).

> Subject: Re: [drm/amdgpu] Driver crashes on 5.13.9 kernel

I have no influence or knowledge about this driver, but I still try to
help because it seems good bug report. Have you test with 5.13.13 or
5.14-rc7. Does this work with some other kernel? If needed can you git
bisect if needed? You will probably get some support for it if needed.

	Argillander

> I thought that this should probably be discussed here,  so I came
> across weird issue to me which is driver crashing while trying to get
> one of my monitors working on Gentoo.  I would like to ask here how
> that would happen that the Display appears to jump from DisplayPort-6
> (physical port) to DisplayPort-7 (which doesn't exist physically)? Has
> anyone else experienced this?
> 
> It seems that the driver sees a rather large amount of inputs for the
> GPU, even though I only have 4, 3 of which are DisplayPort, and the
> issue monitor is also on DisplayPort. 
> 
> Hardware:
> CPU: AMD Ryzen 5800X
> GPU: AMD Radeon RX 6800
> System Memory: 32GB of DDR4 3200Mhz
> Display(s): BenQ Zowie XL2430 (1080p), DELL U2414H (1080p), DELL U2415 (1920x1200)
> Type of Diplay Connection: All are connected via Display-Port
> 
> Related DRM issue:
> https://gitlab.freedesktop.org/drm/amd/-/issues/1621 which includes
> logs too.
> 
> 
> Best regards,
> Skyler Mäntysaari
