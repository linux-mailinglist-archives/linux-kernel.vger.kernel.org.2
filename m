Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5889B3A2F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhFJPR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhFJPRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:17:55 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B930FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:15:59 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b14so12370990iow.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CoLn4qViOeYGj00Cr57KHBOqwdLExPB58jgkoo3+kw4=;
        b=Om2bUvQgE2Xgs9cDoQxX/2kBFI2K66NFIlU9JDmEIPGlMCHD0ieH6TlNQnXGQz3B07
         M2bCCqT3HjMFO1o8A7QhWEK3x00FJzwQZAIWMPYfx29Kgnl791SPIi9sUkPq/4TDbIix
         MsvhgDVntFLr8RjuuittAj8mZltWU2WKZ9hV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CoLn4qViOeYGj00Cr57KHBOqwdLExPB58jgkoo3+kw4=;
        b=bMYmj2FQhO85oxacQfFqO+p2tqUkd7PSHUoXCDFuO2aXVhQrNYp+YiJgF0/osl0B2P
         vuZqS50XtN9tcmiJtJ/lDiI2NIy0quGOAIpVLQgGM9NkUzglB14XeGToD1Gws6jXzl3J
         BIPoj4O4VeFf2zn94wrfGBj7vI9PwzhjKoA3UtGoX2n3kRm28Ex4mpaVQ2cofNpLewX9
         01CCjchggu1U+M0CJ1swmNp0ZrCgllV8WHpuDEU1Nuyzzi7z4ROL2D44JCdMJWKs9kAM
         5bNXMKABZNFZUQJ0pmBD8imAruXsRpLM2Mv6lkdiUEpGcGfAvbgRUXNsTlSYRmZde55X
         edXA==
X-Gm-Message-State: AOAM533Zf0u7nCuf4kgpKV/KJdHc6rPandj+FoxiNLnkdH2qHuiCJJ8p
        eQ/jxDFFK9QJ328CbOBu16lFIw==
X-Google-Smtp-Source: ABdhPJzrK+ymUDdzzgUR5JsVtJu/hPBNk+7tFS5Ro4H8pl6LapGKsn8k4Sq+vVh6f6Sbxu1L7cxBtQ==
X-Received: by 2002:a05:6638:1202:: with SMTP id n2mr5200296jas.57.1623338159216;
        Thu, 10 Jun 2021 08:15:59 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id g14sm1671700ioo.19.2021.06.10.08.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 08:15:57 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] tty: make use of tty_get_{char,frame}_size
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, David Lin <dtwlin@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Oliver Neukum <oneukum@suse.com>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <20210610090247.2593-1-jslaby@suse.cz> <20210610090247.2593-4-jslaby@suse.cz>
From:   Alex Elder <elder@ieee.org>
Message-ID: <0f61ae31-cfad-cd78-b976-c05f56c89d4c@ieee.org>
Date:   Thu, 10 Jun 2021 10:15:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210610090247.2593-4-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/21 4:02 AM, Jiri Slaby wrote:
> In the previous patch, we introduced tty_get_char_size() and
> tty_get_frame_size() for computing character and frame sizes,
> respectively. Here, we make use of them in various tty drivers where
> applicable.
> 
> The stats look nice: 12 insertions, 169 deletions.

Agreed.  Looks good to me (for drivers/staging/greybus/uart.c).

Acked-by: Alex Elder <elder@kernel.org>

> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Lin <dtwlin@gmail.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Oliver Neukum <oneukum@suse.com>
