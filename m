Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394EC3ACDFE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhFROzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbhFROzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:55:07 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF414C061768
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 07:52:57 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u11so10827674oiv.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lfcsRgFy2xq8rFyaA8Nz5ZAiMzCPmlUUdOOARhZaZCQ=;
        b=gsoQ9aEfUO7Xvs0FyVDIHEU7u9CS+WcWA/IyOVjbcfTH6pgLtYG8n2K/qgdFFkFmRf
         CXTr/rOKIp7UANm9ovr65iZDf2vHLmZXO0NOcG2mXmkgoSworF25MLAOtYU6BaU6Ichi
         GOlS7y1zLqEGJ9rFASZT+JtZpp7+ECxoZiEAIP1DCUfxe7nPbSyGxqSvowpB/q6Yvykp
         9TLWjo5CE+48kh9XOMzUniF9/K92pN4OF45voWnFAQ28XOrkbcz1cWim2QhVcOj65y0G
         pnGfcfxt92pZ42v4BaXBzEZCgklA785C01Zo5obJPxYqQCFfnBYPpNC0uBD8JWsZEFc+
         ybWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lfcsRgFy2xq8rFyaA8Nz5ZAiMzCPmlUUdOOARhZaZCQ=;
        b=KSk6kooqFJt2hukJ5JPIwD8Smvwr84VgCWkdv9xNYv4BWa5GBTzyLHtZSETXZRTyFL
         +gdr0uduW7R5HTulLY152PSfC+yuXvHFR1seZ0TlSberHO+sQ22T76TZ13QKN0G8uW5K
         KK2e6s8i8CxnTJRIBmK9O9GIPrlHx/AHuPYDdsOGn4Anw8tg82zk+PAUPFpkVGr7sPuf
         ZslbP7aPpJRrQYkqmBlM2jtBiky9BXT2UFtoSQuX2idjOfBbux1L9SUNlZJzPKzfNOc5
         WXoBBLMDQE+1LaFLpdEi3wxW2pPKwQGkesECXZBQ1ZhoovpVKY0tFLHLKXKNPS7/p0Xb
         pYYQ==
X-Gm-Message-State: AOAM530hXesv63e9J8346bgkwHlUWd6OCP6MMIFy0kmw8mcX0fajt3G5
        s+zLD7JPnf08Mq/CSnniU4Mbi+Q37Dwrjg==
X-Google-Smtp-Source: ABdhPJye1eow3zDlcW8WFc5WqtQz3JnuGxiQji+GYWeMI7kL1izOVo3QAosH6I6TqQTmqa+mXYdt2A==
X-Received: by 2002:aca:4fcc:: with SMTP id d195mr14553893oib.88.1624027976941;
        Fri, 18 Jun 2021 07:52:56 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id 3sm1856148oob.1.2021.06.18.07.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 07:52:56 -0700 (PDT)
Subject: Re: [PATCH v2] loop: Fix missing discard support when using
 LOOP_CONFIGURE
To:     Kristian Klausen <kristian@klausen.dk>, linux-block@vger.kernel.org
Cc:     stable@vger.kernel.org, Martijn Coenen <maco@android.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210618115157.31452-1-kristian@klausen.dk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <64494b7d-01b3-8da3-e10c-d346746758ea@kernel.dk>
Date:   Fri, 18 Jun 2021 08:52:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210618115157.31452-1-kristian@klausen.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/21 5:51 AM, Kristian Klausen wrote:
> Without calling loop_config_discard() the discard flag and parameters
> aren't set/updated for the loop device and worst-case they could
> indicate discard support when it isn't the case (ex: if the
> LOOP_SET_STATUS ioctl was used with a different file prior to
> LOOP_CONFIGURE).

Applied, thanks.

-- 
Jens Axboe

