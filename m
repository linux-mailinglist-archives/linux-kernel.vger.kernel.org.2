Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BDA4213B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 18:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbhJDQMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 12:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbhJDQMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:12:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59A8C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 09:10:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j8so1307178wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OtQuuX2brA5ZuBP583Q78Xbi4yhNeFENTEHNrqdTOBE=;
        b=DP7u/QxlDl1spshoDmovH2MF4/zibEvWOMOsIEunFjZw3dOYafLTF299WsXQP1jsRa
         TbucAY7TeQE8PlGyMRHMfv3/daOY6696DwBdU5KUTGLH1MvNO/84PCWWCStnAFtj7+Wi
         eIHUD4cgY4MITOoTvn9s/7a80Y2Yf5IWQwCFa1kIwbi77vmf9cwu2pQgQzcpzB0tqBQp
         S9CTTqFS4D72sJ7yKiNdV6mlcOeRRkDrEziWFqf+QGFh69m/Ei0HKc+XnXe856mw7dJ+
         1Eg8RA4y3lO/tcAzjBPD6Z+FqRAXzfWUw56G9mM1Bt8crayp1Fj+fyIwwvBSNvMwlvEv
         eHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OtQuuX2brA5ZuBP583Q78Xbi4yhNeFENTEHNrqdTOBE=;
        b=YA/3gJFflAZ21gzYOZpazk4At+WE8LIDoDBtt5GfLfag5DKJsPnhXNvmXXGJPKcnYT
         dmrgmFwR20zKbBDQBxC88W4afGyxi3U3+QTHjCwsZ9lb6C6XWhdYQg1yZ78biP7XkWcQ
         ot8GqKC1DTco3B+7e0kFYbxEL6wFAQRUhrS7xpy8Z0S/sjR02oAUVN6ZOX0UzWE5tlEq
         BOZUfIoiMrNyQ97MRp/43FCL48dMw20L7so8lwzm056GvbPuzzmWMMIu1GClV0/+xFc/
         GNcgi+CPce/MwEWF9anm5/5jmbLKXSRAE/ksOeXbKP+kKjnDkbAn9sq9L5rPHRa9nvno
         MjRA==
X-Gm-Message-State: AOAM531RQM++6bmFPOfOd9+2l6mM0uKGM/AK2QEz2+jTzqWqnMasro6q
        PKEMp/BZ3QKmvQpUZrRI4sAl1w==
X-Google-Smtp-Source: ABdhPJz6OpGeL9GMpI27OU8V37E913SUaJl1BIluDq9g14WL6M81bM/Hth2fX4+FBfrBS1ABZHkeWQ==
X-Received: by 2002:a5d:59a4:: with SMTP id p4mr14906542wrr.332.1633363830548;
        Mon, 04 Oct 2021 09:10:30 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id r18sm8905395wrs.47.2021.10.04.09.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:10:30 -0700 (PDT)
Date:   Mon, 4 Oct 2021 17:10:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Orlando Chamberlain <redecorating@protonmail.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4] mfd: intel-lpss: Add support for MacBookPro16,2 ICL-N
 UART
Message-ID: <YVsndMqaeJigZ9hV@google.com>
References: <20211001084905.4133-1-redecorating@protonmail.com>
 <20211002111449.12674-1-redecorating@protonmail.com>
 <YVqqllKyNF4A424K@google.com>
 <F169C53D-C688-4F1C-B361-86885FD11F21@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F169C53D-C688-4F1C-B361-86885FD11F21@live.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Oct 2021, Aditya Garg wrote:

> Hi Lee
> 
> I request you to Backport this to 5.10 as well

Please read:

  Documentation/process/stable-kernel-rules.rst

If you think this patches meets the criteria you can submit it for
inclusion to the Stable kernel yourself using one of the documented
'Options'.

> > On 04-Oct-2021, at 12:47 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > 
> > On Sat, 02 Oct 2021, Orlando Chamberlain wrote:
> > 
> >> Added 8086:38a8 to the intel_lpss_pci driver. It is an Intel Ice Lake
> >> PCH-N UART controler present on the MacBookPro16,2.
> >> 
> >> Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> ---
> >> v3->v4: reviewed-by line
> >> drivers/mfd/intel-lpss-pci.c | 2 ++
> >> 1 file changed, 2 insertions(+)
> > 
> > Applied, thanks.
> > 
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
