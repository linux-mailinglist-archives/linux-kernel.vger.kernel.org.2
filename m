Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001AD388D62
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353007AbhESMCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbhESMCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:02:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46059C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:01:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v12so13735010wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FgJXe092fVJTVH6ejwO4wfc5Nc9nKe3wdraEnWWFM7M=;
        b=I5W8vvf031eATZORnhplLR5Z5aIn8yRnsj1y68iM6X1GLxuS7ROEvPVbg05UzCKw6t
         9A/y/d4++M/llKhrgs529Pj1AMxR2356tsl4ryWPROx/1BN3U13xGG4rGVd4js6UMTIu
         PWZNAqeWzyV+Fnz0Z0eqRaS3JJVPV4osHfCU5lifDlNUJ1tH8cHSMMCPY62Iy2ZP5wV+
         cEMUo99AzpyYZSw9LfLZeUxWOEjfaN3JIKho4nNfqz72Lwp/rs9eb6cW37Feu/ZaVX42
         Kl2WpYi7NnLzrOm5l1mS3RuUenpKgwz6t2q57XIdsCgyfokMEzUqPJn4HTuQn/72e/xO
         JCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FgJXe092fVJTVH6ejwO4wfc5Nc9nKe3wdraEnWWFM7M=;
        b=KUIn80Jg9sXFb3OtaDdiJfOsHYXbwXwdDTIdExcxTnDQAhQ495jswESl1NcxIqsyXi
         GyCD9j/+Lir1MZM6qTOYUvyptAh8LmpesHNZuinqyVQec0gOTBAp6fQSx6H7Kh4XjAoM
         1S6Mn9CUx4Jp3E36TcMyIEgZICTJOSB0VtMpoz/bRw3Ey3NhtzkCK7YhZ8wgP+wITEZM
         ATibdIN+1bH256hzvRSoZOtdVsEJL3bM4qBF6A+mny8UDmTA9SS0kaPSkFT18uDOWPGE
         O2JqL25H7glBiDCX3NszpGaHWbaQ+RIAnrJd0xoCddfagEQlivkSxbyrQon5vrsibd8R
         YBsg==
X-Gm-Message-State: AOAM533zv+YsX8HN1g+DorqI/2GqhdlMAOmO4K7x5xi7Dakf2RozhJg1
        WudkvPsj0rmdAgJUDll+sCK9twbNz/KcLg==
X-Google-Smtp-Source: ABdhPJzZzi7cj4Z2N2iWHqnB6LB9e4qpIW3MroeSPIqDPZBR4QgtKyHCG66gmBBu17f7DS63HZkfqA==
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr13669264wrs.276.1621425670866;
        Wed, 19 May 2021 05:01:10 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id y14sm5509366wmj.37.2021.05.19.05.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 05:01:10 -0700 (PDT)
Date:   Wed, 19 May 2021 13:01:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] mfd: wcd934x: add macro for adding new interrupts
Message-ID: <20210519120108.GF2403908@dell>
References: <20210510091239.2442-1-srinivas.kandagatla@linaro.org>
 <20210510091239.2442-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210510091239.2442-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021, Srinivas Kandagatla wrote:

> Currently only two interrupts supported is added in wcd934x interrupt controller,
> however if we are adding more interrupts the file will become too much unreadable.
> 
> So add a macro to make adding new interrupts easy and also convert existing
> slim and soundwire interrupts to use it.
> This is in preparation to enable Multi Button Headset Control support on this
> codec.
> 
> WCD934x supports Multi Button Headset control which enable headset detection
> along with headset button detection.
> 
> This patch adds interrupts required for MBHC functionality.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/mfd/wcd934x.c | 43 +++++++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 26 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
