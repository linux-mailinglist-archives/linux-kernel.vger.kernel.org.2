Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5C43D855F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 03:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhG1Bak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 21:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhG1Baj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 21:30:39 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737F5C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 18:30:38 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c16so731739plh.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 18:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NEon500ynSMY4Nx1JkJ0WhIvnHZ2zrzoczFG2c6TlkE=;
        b=L1pTZHLWV9EUK/WKK2vzd1LrKbA0rKMC8b6f5MFCh/bnMJGMtfvMUJaLcwWWInVnK3
         5wyVMCQ97HCSv2rT4LfnbLrwDQciKneOVVWmgtZfh0KYG4WE+7hnUrHPMy8jGptHPl3t
         SwHM34ecuaBTo+1iymtZex9mDYZP46z51cyN0t+PSKpXDMWSY+VlIiVEWWTjAI32IOwX
         Z1cc4WxG4Pc+MhRzPo4jN2z9tEspHjhZ/R8fE+fi3ZZMVCJIgUVjajESOBxJrsp62Rf1
         nOflJAFb1gKHRJieBmNUznM5z5kXaYOvGzHaaOxEWN2p00c9UK0fFr9ZeP6YRGzVLdyv
         Ddmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NEon500ynSMY4Nx1JkJ0WhIvnHZ2zrzoczFG2c6TlkE=;
        b=dYI5Q+vYYwXE0YEEfcYLFxdE4Cv5LY0Xtb+t0r4p3ysBBZRBny6i8/tC9lhUfjh+5t
         hgoeKrnpeiBh0U6Zg1vLC4Vl0IkDT7FxitrwqF8SbgEpEbCV8q+hS99fDoMuv0HoKdIy
         NH90NRj/+vrs1Ol651P/WfeL4wjHchiXF6DcPVJJIfKEtPGRVqmpwPZ81QMoSNsQwpqb
         1E68CRM0NK2uJE2cng/hZcDE+FNmJ9d4+aw2OpJDPwdY6k7yhE96bBeGpd+lCMUmlAYx
         RuckyHVCpTEnE2Z9uz567ECqwuHrkDq+y4MLBuJUG8kZ7GsLLuPv/TNQXaJU6vF4XY7C
         j/Wg==
X-Gm-Message-State: AOAM532rWS9rciO1qbmvfFPk/6AiLD+OZKPPpak93i6o5vLEks3M3Kci
        8DNQpaMQYn+e8Y+mLBkz01kFxxSUjl2c6uLM
X-Google-Smtp-Source: ABdhPJyvMaCZv/e6Vz7urn/jIG/vOGcKtAoA+VK/OTA4np90BOzzU6+y9N4p8I0FLN2QoWpWq0AVdg==
X-Received: by 2002:a63:1621:: with SMTP id w33mr26091053pgl.291.1627435837707;
        Tue, 27 Jul 2021 18:30:37 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id s7sm4926070pfk.12.2021.07.27.18.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 18:30:37 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] ata: sata_dwc_460ex: No need to call phy_exit()
 befre phy_init()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210727125130.19977-1-andriy.shevchenko@linux.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a16f1ce1-243b-e12b-3d48-01c2695234cf@kernel.dk>
Date:   Tue, 27 Jul 2021 19:30:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210727125130.19977-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/21 6:51 AM, Andy Shevchenko wrote:
> Last change to device managed APIs cleaned up error path to simple phy_exit()
> call, which in some cases has been executed with NULL parameter. This per se
> is not a problem, but rather logical misconception: no need to free resource
> when it's for sure has not been allocated yet. Fix the driver accordingly.

Applied for 5.15, thanks.

-- 
Jens Axboe

