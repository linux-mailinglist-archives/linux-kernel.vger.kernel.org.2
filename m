Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE3535F007
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347070AbhDNIpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbhDNIpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:45:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B91C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:44:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z1so22698607edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Jls0NQzwXe8JWYctGmBXJ4kVhaPy5Pxe1sqn9Fl2xFw=;
        b=AhqwAKShTFOnsgY3NaRkaeaLpfg7gE/1DU13IE76vxS0ZKH3moS7r/ZL34JY8yalQy
         RAGb8R1tb/hRc4FwFmPDM0qYqzk4c9csKC8b5sa0oiawRIcaiOC7bQn9v/JMCdni18zg
         X0bXSt/P6Bxf8JIT+Ig6/v4M5lzjbS9Vvx2UaVxF9MGU9Tc1zAVZgWfqAsfqxUIOlo0+
         kFAJpMEhh7C/cjy5DyXi22CpjGIHRKt3T0El7D6UtDTX6UJQTXaJiN3Pi6MqSw1zQjAZ
         npW4A19Fsjewe9nP3B8AQLuSbeA1ZMRklcUUjT0GWMS6lph2H8ibx3yohfJqazaG6Q/H
         x50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Jls0NQzwXe8JWYctGmBXJ4kVhaPy5Pxe1sqn9Fl2xFw=;
        b=IXynT3zuUIZcmDHBgmIiAaVQmLUbvfLMoWGNALePxkXe7FMVL4/+VDsh4QL7k856ww
         6JWw9d/3mj2mQMOhquI/5trNDffD9LZimhPkfKvg+dF4CPGKuFyCm61niQyLu5AqAG6W
         pI/cMSEw29EfYRCPf7YvhudYk2lCKNWr7FQUobixsGoKOnByKaDVSEeFd2nTpwStxo+t
         xHVaC2jeU4OXG2/XLVVq3WJ3io8cdCzuSSsUbqQ0RxkJNugsUGA3Pp/MGo8vHLplDWt3
         v6Drml/KFA2sz3ZEuz8G7ELtCRQ5EgUzFwAWUIahw8F5HBqXhVwHnkwvRkydHpsTt+5X
         yI4Q==
X-Gm-Message-State: AOAM531xTck7Oc6dhcQnH/iklOBHRPBo1XopPUhFFuR7LwOB0jJohxu3
        yLzGa9plsw8maUN8nA9O2jtPFg==
X-Google-Smtp-Source: ABdhPJxwEOXoP9DPLTcbNjyzl9KUYLQDFs4PTLT/h7VduBCgEaMnbTy5FSbQiad9o2Njn8wFdOY3bA==
X-Received: by 2002:aa7:db9a:: with SMTP id u26mr39316235edt.292.1618389896356;
        Wed, 14 Apr 2021 01:44:56 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id b13sm11294441edw.45.2021.04.14.01.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 01:44:55 -0700 (PDT)
Date:   Wed, 14 Apr 2021 09:44:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mfd: twl: Remove unused inline function
 twl4030charger_usb_en()
Message-ID: <20210414084454.GJ4869@dell>
References: <20210401141840.25996-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401141840.25996-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Apr 2021, YueHaibing wrote:

> There is no caller in tree, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/mfd/twl.h | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
