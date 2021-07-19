Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153263CF201
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 04:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhGTBlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443892AbhGSXFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 19:05:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D01EC0613DC;
        Mon, 19 Jul 2021 16:45:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id me13-20020a17090b17cdb0290173bac8b9c9so841454pjb.3;
        Mon, 19 Jul 2021 16:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kgz2eeVTrVAZCaEOYMJ8unFPgBOAegGaTDFor4hhW4k=;
        b=N8skB0g0RIgY1yzrP9QUxgAtO1Ujzw0uwpwRfp4/+YEbM5V5uGIU/pIhNhUjEvJXuU
         GZdN0luA9lLUWDP2TvHLvThvWgL4qXFSOxnd4PbS55epYSTa/2X6bk+KbiLWQA4OIGaA
         RrjA+ulBZktLrY3cXH/NWSNzOz/4GRz8KREvkkA5YgyRmta5voc8JkyOIoz6hpejThNj
         hp01K2lhc/A1IpgDQY9bNwxt/O71v7J1QeJocywcRyArUVuNkjtEOuxs4Z9VZpy44DUh
         OKT+Upu+XAFsYv+50Yl5Kplm/QQmadSkMIhwhmVIIvc3SEagVGEKlFpKFspprauzLFmU
         jczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kgz2eeVTrVAZCaEOYMJ8unFPgBOAegGaTDFor4hhW4k=;
        b=Tr0O3EA6nnCLq5MGuQD5Zd6Hcg51LT7zNchgrazVck4Rk2MpGME/WVyowtBMJVrXx2
         QAkZ4RUpvAk9L0aZfi8nweKSmAW8fZybZcaQE+PnFpRdlyLULMwZdRvUaXedXxdYx0oq
         vOzPlS8ck8pJdZDcD1HUDhfoYVQXWVkpMNB3vMqImz+Ep/SYa5/d3CgritT5/Z7GOcGi
         HotiZmbCcJLIq5VmpGhLxydY7H/Xqluv3GR7GpasrGtnuHBajX+p7lSDvg47NSBMTmvR
         zd0loLtXXMxyd8uXqDXbl1bkhfWBHx0ahOKcaBekROvDla6OKg2GpT0LKf+QcdVDsdII
         0Bww==
X-Gm-Message-State: AOAM531jFiiUE2YMl2ASdmmEAeI34gSRdN4t6RVtBlFN3hyj0c+21bGo
        uEm5B/oxhsRQ/Ax4qKHl5sCGAE+UMLG0OQ==
X-Google-Smtp-Source: ABdhPJznQaIL8aTRdjnJbwpMIkbHjt56z2F9GQB00BrJMdFii30BhscOIYnTKHlP7+Vap9p2z57r4w==
X-Received: by 2002:a17:902:6904:b029:fb:42b6:e952 with SMTP id j4-20020a1709026904b02900fb42b6e952mr21325342plk.16.1626738348512;
        Mon, 19 Jul 2021 16:45:48 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x189sm2335158pfx.99.2021.07.19.16.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 16:45:47 -0700 (PDT)
Subject: Re: [PATCH] serial: 8250_bcm7271: use NULL to initialized a null
 pointer
To:     Colin King <colin.king@canonical.com>,
        Al Cooper <alcooperx@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210719095533.14017-1-colin.king@canonical.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e926854a-39ca-262e-0fb4-eaf96ab0063a@gmail.com>
Date:   Mon, 19 Jul 2021 16:45:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719095533.14017-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 2:55 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer membase is currently being in initialized with zero rather
> than NULL. Fix this.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
