Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B164110C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhITIRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbhITIQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:16:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3611AC061760
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 01:15:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q11so27308898wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 01:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+rAC+Q6AqzJzfyLVXoyYFqfJ8hUxXts9NbI3n+0AxLg=;
        b=PftVprmG/wF26COcGMgafDTUlF0lTwAFcgK53eT5HSwwzguizH78HblG+t6wzmFAD5
         1QC7swOOdkbtPW8s4yPgOQYvfCE4oLQz9DxMe2RxkdweZyQPRAN+HUJ+4/TUaXYuhUJU
         mo1BqF/Wv+YeSkQ/3b0vlimXPxlKZcZyTxdSXY4woMRtwHdRdEkEkJdKmeEFoR1Gd5KI
         teHYOHAQrnrtBvmuvsW5ncxudDVA/emvBF41OZlHET/Fn2C9sjTQ+YtvIioeUj3652vb
         hcSDwFJPmKX+M1bLpU0Uap/tyejzvN/973/1wP8dZgGwcpgLpdFTEc/YY7FkzQ3HAW3r
         BijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+rAC+Q6AqzJzfyLVXoyYFqfJ8hUxXts9NbI3n+0AxLg=;
        b=bAIE7tVOjITYErARFgZbDnXTKWG9VqFeGv7fDOyIsRNHKqa1M+wxDKnGrNw+u3KIhw
         G6Fb1b6o1IAVA9gQ8tgD2Lnm3XF6ysn5rCjhnR1TD4gQD7HERzUIgUi/AfUuqhFL0RhR
         7c4KspfJQd+HS6NRybWEZDRGoYRqXxU4fxtwzHPPweOwUOthz/EGESIN8SIEBp0g3+ih
         0Db54mT4ivqDHe1+bIQReolOkCWB18HUwdWvp4yOrXVzqfmv1SYwAgWEn2dyboaXP2uc
         8GMvwwkagwV9ESgpEmAGUSZDDS8E/o1iICFSFgPSeA8rnhrJ/xp45UZWKV2Gi3athDme
         wEJw==
X-Gm-Message-State: AOAM533C/iQxPIPY9xEatVxzeMi4x2IsZ0EI0Foc7nXbLyHsnxGdZd5h
        SJ1jOxJCH0fVsKRylGlmHUlq9Q==
X-Google-Smtp-Source: ABdhPJy2MkCojZZSfE9HDYc63mIYBG1xGuZpS2i3+76mq/r4UpGSWQbYvDYkwkxd182m22VaoDHRkA==
X-Received: by 2002:a05:6000:1809:: with SMTP id m9mr27685091wrh.396.1632125727748;
        Mon, 20 Sep 2021 01:15:27 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id f1sm6086140wrc.66.2021.09.20.01.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 01:15:27 -0700 (PDT)
Date:   Mon, 20 Sep 2021 09:15:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     min.li.xe@renesas.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH misc v2 1/2] mfd: rsmu: Resolve naming conflict between
 idt8a340_reg.h and idt82p33_reg.h
Message-ID: <YUhDH7ci8jjT2tob@google.com>
References: <1631808697-25229-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1631808697-25229-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021, min.li.xe@renesas.com wrote:

> From: Min Li <min.li.xe@renesas.com>

Why have you sent at least 3 v2 submissions?

> Resolve name conflicts so that rsmu misc driver can be simplified to
> one c file suggested by Greg KH

That is not a correctly formatted Suggested-by tag.

> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> Change log
> -resolve name conflicts so that rsmu misc driver can be in one c file suggested by Greg

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
