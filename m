Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52205420680
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 09:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJDHSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 03:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhJDHSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 03:18:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA8DC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 00:16:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t2so5444167wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 00:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7ziIY+I1UGpL7s+A4zzNN+/vTN0B2cBJFbwJfYdVsQQ=;
        b=UiZbTAR6mfTYvD24K/2hZXYKyX5LNqVQAu+h7hljbY9C3cyHkJLvmqZn3+jSFK4Ufs
         3r/WfblnIMQIBmQT2U1U3KJirWYtdLJg7TFPuoZfycOETg9Um3wgGKUxQNqzqFm0amMi
         8cn+6i9aPdCH9JzRtA39bAgKwbTny2j/RFD+wz5pg6mT+aWI9b18yVnVHNMuuM6FPdsO
         ldz+Gk8Mluguffa7k5os8M1N5ddsQyCQyHEkbtUd2bNCPZ2l3mritbZEnbNAuDgqqgn6
         fw9yLWsKAgczavUGIhniSFpAZHrrOg6UfTtgj5AQwzS6zIhaCxeulcLtElQ3PPRKfKSk
         IAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7ziIY+I1UGpL7s+A4zzNN+/vTN0B2cBJFbwJfYdVsQQ=;
        b=hUnDo0gcl6vCogHN0Cu7fleYwTDafeQdZfNfnzlPG3DZeQZQCI0jMeOvjr/WqIfkYt
         qmyIdaGOJrSEKzLlXFuFLr4t8mmspD/7iliBzVfg5dmERltHFiWJudyPJkZS/quVmUK0
         oCH4D2YPxk+POsNhssAn2J6O+xttOguAlJi9TvMU6LnJsDQtDZZ2F3pMFO3v6YdCjSFq
         4BS/HaRmU1EUce6555F5sW0O7+0RZXEdXn5zIGnhsR/oPO96dmtr4xkTmR4lggaefgTI
         1GBkWY84f5z19RGwSSJugyn2vw+Af2rbx477wmYWpv2IVIa0xJsFApBbGtX9SyixqdxH
         srUA==
X-Gm-Message-State: AOAM532RgI+Bh3m+iuNcccInkhAt9RZ+R5krRYldyDhwEzm2oMJ4E6hd
        L/4g0VVjpppVJ01TGd3OU/ZQuhhVIZzjdA==
X-Google-Smtp-Source: ABdhPJyrDvy9YW+j85swV6LkTbmBQzb1RWXpFGKc/GwZTGFDOGGtqfAeh+EcMMWltvBjJwncH2KB0Q==
X-Received: by 2002:adf:a294:: with SMTP id s20mr7060203wra.34.1633331800961;
        Mon, 04 Oct 2021 00:16:40 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id f9sm16178166wmf.3.2021.10.04.00.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 00:16:40 -0700 (PDT)
Date:   Mon, 4 Oct 2021 08:16:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Orlando Chamberlain <redecorating@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: Add support for MacBookPro16,2 UART
Message-ID: <YVqqV2xIybMCVbmR@google.com>
References: <20211001084905.4133-1-redecorating@protonmail.com>
 <YVbf9J3jgAmBY+ch@smile.fi.intel.com>
 <YVdP9PwNrjmKxKac@google.com>
 <YVdR4bdpr9/E+GNf@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVdR4bdpr9/E+GNf@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Oct 2021, Andy Shevchenko wrote:

> On Fri, Oct 01, 2021 at 07:14:12PM +0100, Lee Jones wrote:
> > On Fri, 01 Oct 2021, Andy Shevchenko wrote:
> > > On Fri, Oct 01, 2021 at 08:51:46AM +0000, Orlando Chamberlain wrote:
> 
> ...
> 
> > > > +	/* MacBookPro16,2 */
> > > 
> > > Use
> > > 
> > > 	/* ICL-N */
> > > 
> > > here.
> > 
> > Why is that?
> 
> It's a standard way of representing PCH/SoC in the comments in this driver:
> - MacBookPro16,2 is not a name of the PCH/SoC
> - MacBookPro16,2 is possible not the solely hardware of this chip

Okay, that's fine.

> Why not to mention this name in the commit message?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
