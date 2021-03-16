Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8351833CF97
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhCPIT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbhCPISx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:18:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27FDC061762
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 01:18:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p7so59313362eju.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 01:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OmmE3ufEAvDgtjy9vpprocD5iN2+Uqu85g8HBGh8RxU=;
        b=LHEgSMvc3cWqM90kZ4gvD6TaEqf3+6Z+QFwyFujTOXKuj8vhH9mBpNX24ZIrVsOI02
         U0la/1WtXHDdzlaSo720o1SWFpzEDdwIH9xsmFuVg2t6SfJcr8NK3Jkd0yX8Dq+NDWOJ
         KChtHzbHPP17LCyJCpNdZf10gUXrkW2ch4mGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OmmE3ufEAvDgtjy9vpprocD5iN2+Uqu85g8HBGh8RxU=;
        b=I61vrseugf0aA5vpx3jnVBwYTDXrqAFz0vZ3/BSTUKhqBYqx98smI6nwvfCCvYvlTf
         4J9BV/p+UOQvJPCCOQEDYaMt/pqK8u10dHkZ3IHyX/qFS3ZKtWLdXbI9AHVQurzPBBOW
         8TK5XIrvA+tPYkF/MRLC0s28e0s5XGPBXVJgjmH3CnNlQJU3JVYBvA6AKdnNdyWb426/
         gQbvjFpyMY/szKwsgViU2WQI87JrHeBtPaZbM6mr0MRGPIzdWaPfXsPO2CyVDaQizQjI
         366yJBvMZKJpZg7JJXJhUrTCCpGyZr8/QpsaSJhPMq2YKCNh3P+3nRwX7ia0QSez6s29
         s6sA==
X-Gm-Message-State: AOAM530uhgYS2tl+zc0rnpTOSGl8IEniEMWDpaHlF2HV7e/xbJHzCpvI
        ZS7nG4y0bbzTUpKltfOSk9I1Sg==
X-Google-Smtp-Source: ABdhPJwKtInEZcyt1fXWt+TUJ77BSu39uwuRxne2DMvOwoF0XUOOeiBRKdKwwpuOnjLLSOFZ1bvRaA==
X-Received: by 2002:a17:906:a248:: with SMTP id bi8mr28148535ejb.260.1615882731772;
        Tue, 16 Mar 2021 01:18:51 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id u24sm5149640edt.85.2021.03.16.01.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 01:18:51 -0700 (PDT)
Subject: Re: [PATCH 02/13] tools: bitmap: sync function declarations with the
 kernel
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org,
        linux-sh@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
 <20210316015424.1999082-3-yury.norov@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4d1a1616-1e6d-fcef-82ab-38083a2430b8@rasmusvillemoes.dk>
Date:   Tue, 16 Mar 2021 09:18:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210316015424.1999082-3-yury.norov@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2021 02.54, Yury Norov wrote:
> Some functions in tools/include/linux/bitmap.h declare nbits as int. In the
> kernel nbits is declared as unsigned int.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
