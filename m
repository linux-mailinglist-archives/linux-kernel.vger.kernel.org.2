Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44D4344BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhCVQkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhCVQjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:39:45 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3CAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:39:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o10so22281335lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZzcFovQFUWf8zncHThUZCkO1QDFqyA6DDea/YNXflao=;
        b=Tp3QV2kr2MR7w9ii+u0SfbD0VIglO/QpUYJBX+V0fT86PKXsYm8UUEVo4krj+Ga44o
         8p3FRJFvxvKtodJ0Bl5UCll3x6NLfddH8lDyxncsy3hhUdU7XX7x1tXhLYvHxtZ1DYYO
         VMiwcmJVRhsvIW8ylMCAz+mj7i7UQqzUDAp/5PZT7H/q+ogpOvodQTCazFnK9JKWBRVp
         cX6mQYHi8aUzsoJFNDyJPEn7orEpT2XB9YC+9pWWHvC9UAwBtc641NwiCCKHlLIZoJoP
         CHscHDfcasFop847B1MXRoUcw/0kvjES+XFm1WkFGGRg9Bl4i7L0rN2n2H4EVGLKGdSt
         cnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZzcFovQFUWf8zncHThUZCkO1QDFqyA6DDea/YNXflao=;
        b=DE+LkcGXxuAwjzyoXFYfG4mln1WGelkmSuo/cyabtkl6Z+qjy47ec5oeuLayJjQ5rg
         2F8Ak9w76jl7/bkKVdEZ+ffphFQa/w9SyauOzcJd5qNvKaWneex9N+xR6+D4lnsuMpfd
         eofQ4d/uCf+dNpgvn6O3eft66UNKDatyBPu8DixgKFDf2zoR3GMKFbQYAIBs7/tMx9XM
         7NqgGFyoOc/lRxMNIaDhdcRvqIQmTKoWD4lYQAJOwXOMhlWbIwt3o0PkhB64Kilk9wn3
         QCQ9ZkNLiuMvbgsUYLGDOtWm8Fpav4OJ+ZmPfOMrDaEPk6FtkBcC2V1O7JotjKYyxu11
         l5jQ==
X-Gm-Message-State: AOAM533lKYd5AvD+vAmJjCiCuDXY7Q5DN7XtIzw6pJGw8g5eYwND4f96
        aPBPA5DIRxklWePVZs9jFSs=
X-Google-Smtp-Source: ABdhPJziISTWFT6m9AbP1Gaqpws7biEh8BclHlJNzJWUN2x6CSo2Up9+3ch8AvLyynk54fQeKzO1Zw==
X-Received: by 2002:a05:6512:1026:: with SMTP id r6mr145690lfr.598.1616431183883;
        Mon, 22 Mar 2021 09:39:43 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id q14sm1988348ljj.132.2021.03.22.09.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 09:39:43 -0700 (PDT)
Subject: Re: [PATCH] mtd: require write permissions for locking and badblock
 ioctls
To:     Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210303155735.25887-1-michael@walle.cc>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <9fb7a635-75ed-2840-b751-3ab8764f0890@gmail.com>
Date:   Mon, 22 Mar 2021 17:39:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210303155735.25887-1-michael@walle.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.03.2021 16:57, Michael Walle wrote:
> MEMLOCK, MEMUNLOCK and OTPLOCK modify protection bits. Thus require
> write permission. Depending on the hardware MEMLOCK might even be
> write-once, e.g. for SPI-NOR flashes with their WP# tied to GND. OTPLOCK
> is always write-once.
> 
> MEMSETBADBLOCK modifies the bad block table.
> 
> Fixes: f7e6b19bc764 ("mtd: properly check all write ioctls for permissions")
> Signed-off-by: Michael Walle <michael@walle.cc>

Should be fine for OpenWrt tools to my best knowledge (and quick testing).

Acked-by: Rafał Miłecki <rafal@milecki.pl>
