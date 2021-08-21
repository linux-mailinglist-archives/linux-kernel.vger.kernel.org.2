Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06D53F3A8F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 14:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhHUMSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 08:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhHUMSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 08:18:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741E0C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 05:17:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bq25so25738513ejb.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 05:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hoslJBGY7Wq9eGv0P0Mpj18WdRS2dVibv0AROTPUnAQ=;
        b=ba+v2lWmAj5GG75JfqVyf4abFtHoJ0k0nzGOoXQGdQO0D6uHEEYYn/R6CF4zkoyqb5
         IVhWAd+8UqhOPksFmO9M587ChnFiemI5P4VV3YInL0svOnhxaScIIGBErhOzsOPbgkxC
         RB5jxZGnV3fGPhg5wX20xRu/qQlYOwkPuqzhuCMIBdj8Gj5lVZwKmd+fSrIPBX9DClUk
         H/tpCUkf/5NNrp7IeNcqx1TFtTKkLM0TscNweb8NXi4hkWrt2KPDalIp6I+u9jV3/SK8
         wCqf17Ehuo+YZsOwmv9r9SBlRFu4MJOa3bc1YtCueVNAaMMVQaJRWOAaOg9rP/sb887J
         DymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hoslJBGY7Wq9eGv0P0Mpj18WdRS2dVibv0AROTPUnAQ=;
        b=oolUMOSxNJRNIuVnOFEHbLwxncn/AxfK+QJPnvYuMbunKfUR9Vz9rzJhez8zgbtAle
         m9+r4KJIMW75SeC7BWVMiF8MTfevBKjWn7EWZFlUbCoNJkT0xxptCYBkWX2pQYPKeOnT
         kbSUX8kCW+sDlD9JmNY1Xweh67ekuk8NyFdm4xSYQYHN5seZ1A+rXWayeSwqEAMD6xf8
         oaeOCDr1O1m/0AzL5nXxFkDsy7ykcmfCi9dvKUK+Q8hF4R6a071UAuLAdey1TwNN6kJW
         GoDMItwnMiIqxjw54Kh9yWptd9O0QpVfzvFjAO9pGejF15/qDALZ4jG3CtHHdZAq3s38
         HJng==
X-Gm-Message-State: AOAM533/MtjeFXNDGkvmdRPz04T73ezR2FEZifxAEE7Wd9/+pft1W/gu
        cSvx6lmrA9WrcJXA+U1pKqw=
X-Google-Smtp-Source: ABdhPJwaBp8nr1weuUv0dEOI478tNSvI8O54QglZET8VkqZqz6svchdCyCy+ZpojaUEowNk2d17SlA==
X-Received: by 2002:a17:906:3486:: with SMTP id g6mr26577524ejb.71.1629548244068;
        Sat, 21 Aug 2021 05:17:24 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id r6sm5324255edq.20.2021.08.21.05.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 05:17:23 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: Re: [PATCH v2] staging: r8188eu: change declaration of Efuse_Read1ByteFromFakeContent
Date:   Sat, 21 Aug 2021 14:17:22 +0200
Message-ID: <2360857.63PHMDANz2@localhost.localdomain>
In-Reply-To: <20210821105615.6307-1-phil@philpotter.co.uk>
References: <20210821105615.6307-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 21, 2021 12:56:15 PM CEST Phillip Potter wrote:
> Remove forward declaration of Efuse_Read1ByteFromFakeContent function
> from core/rtw_efuse.c, as the function is defined in full directly
> after this and therefore this forward declaration is redundant.
> 
> In addition, convert the storage class of the function to static, as the
> function is only used with rtw_efuse.c, and tidy up the signature
> alignment.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
> 
> V1: Removed forward declaration.
> V2: Takes account of feedback from Michael Straube and Fabio M. De
>     Francesco to make storage class of the function static.

Thanks!

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Cheers,

Fabio


