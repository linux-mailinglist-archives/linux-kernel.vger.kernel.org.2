Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16EA3839CF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344292AbhEQQ3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344056AbhEQQ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:29:40 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A15C06F8CA
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:11:24 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z24so6149957ioi.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pRAUC9+v8Sk7C/Q47QOkwMnbAOUM4aEvDCG5vpHsgkY=;
        b=HCxWhnJ9ud2KBmbrMOkNzjZG0sJg0mOQ2jQ+rCqiEOBP1st3vQ+EMlf+dDVgb5uvC3
         lqMP4gf1pb0tPwgGS2QnXf4155czubLcO2MNaXyWctIl+mV1ObziIEhJ82Lr2r/3qO4C
         JkPZJxbr7cLXeYrKtazPL0PdZCouhfuA2zFKJn9dF1txDtbsyJuekgaHGwsPrGngA64/
         GNc67pEXc0QPhWWR2UquS5xrJI2wsE33QhhwzFCwsMmECUbVjyiGE1FoIrMt2Gu7qohE
         V6jeTX9YrsS5uJGSDKbcTSQHPbRxF4XHC6CWdhM+EGdzBNQLiriuK4FJC7FcLpTnXlXK
         jFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pRAUC9+v8Sk7C/Q47QOkwMnbAOUM4aEvDCG5vpHsgkY=;
        b=rTgFPpx83dDNzQk/BkSfn9x1rjxerL6kF/hoMCYqBOdnTOJeizXAjQNHE4XdnU7X1l
         /YcIIXRFL/l4ARkMaB76GHgRUnG4/nZy4+k6AqprTsKQqLAjy8rrI1CM0oNyp4HCFIWz
         zd9fa7r7TGclnOWkf3EdAr7Zge33wsB0daUpjPdvpUUoRAmRwooHkXqRiVSjYJBP/cjp
         McCeLY0C+WPTyYEea65vpEd4BlIe1X0LTtkdXfOONvtDJFk6ane1BofrxtLNwcdxpHZN
         Sk8xUcIhgGT5oE94/IITBswLdZeuk3W6avUtYeGMTeVQZvMXVn9sJ3oEMezV+rS0t3lr
         8UmQ==
X-Gm-Message-State: AOAM532dyYoeWhnVBNRVhD3W80Ah5VFcRXD0DizBCNaicWc3w/EoCNKP
        6LtyE2j+bkxRfWtpi1lPbiZVzS6oBk0Cyw==
X-Google-Smtp-Source: ABdhPJw7UfVtSZD3LtGR1uZsCCQkhkJidWk6T7HZibxYOhhEOufvtrVP08oorLUpFso4Z4YiRjSZPg==
X-Received: by 2002:a05:6602:70d:: with SMTP id f13mr433102iox.16.1621264283368;
        Mon, 17 May 2021 08:11:23 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s14sm8357313ilj.14.2021.05.17.08.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 08:11:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] ata: Replace inclusion of kernel.h by bits.h in
 the header
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210409153456.87798-1-andriy.shevchenko@linux.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b450b216-256b-a327-e363-93ec67da4b37@kernel.dk>
Date:   Mon, 17 May 2021 09:11:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210409153456.87798-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/21 9:34 AM, Andy Shevchenko wrote:
> ata.h uses BIT() macro, hence bits.h must be included. Otherwise
> there is no need to have kernel.h included, I do not see any
> direct users of it in ata.h. Hence replace inclusion of kernel.h.

Applied, thanks.

-- 
Jens Axboe

