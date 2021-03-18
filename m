Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E029F340EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhCRUMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhCRUMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:12:13 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D6DC061760
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:12:12 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b10so3655399iot.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fE3QA5oVISAeniCnc22I06REx88dvUk/H2NhLG/WPYo=;
        b=wULFbTjKPWg+ouVh7oEGiL4gc4ocuk2ih3Of1Twrp/HfdqdikFV9eMhCQ41D/DIPIN
         UUgWZxBPZl5QZrBKvJCB42RpsfSao/OD5syRUWEvqWOPNxBOW7oEmbdbmENHbPwdH01/
         T/b9pUYv+Kdgz7YbrsnM6fQy9kjOypiw1decRFdA/oFGaA2Y2by5QzhS2HueBguixCWn
         uSI2CiFYE+fsV5WnnN9iKf7V3vo/WdPVQ7rEdhoL0jVUvi7MGcn3D4+WV8x4XE5bfYEI
         VM2ulO8gK2DsZUeTaEGjIXaDiVzlefBAhMgG65/s5yymMBsEdplA7Tbrzg+kmWW8RSeq
         DmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fE3QA5oVISAeniCnc22I06REx88dvUk/H2NhLG/WPYo=;
        b=gQqdAwjCBaZv/NDyOd7zC/0GNDYCezwgyHWYbmEK6yJHPBhGnd1DploHNGMf7d9Bk+
         FwWZ7ndg6w+ahk4vXUhMZpqkQM3BvGXOT0u6A6CAv14lWjWooGhpD8SjMqyHLh9uQD4A
         cLHwWv9npZ6CGeJE+ypweF55un3mJo/C7JrWH4y5ohnYbdG49uaG5UahI07dZhMs0tlT
         1XXO+QxYtaxqvdBfY+dFRs31seFkZUmDE5sdje3pZfFIY8t5XqhqRLdc1WPQuCt8NIm7
         K0/QhXPLlvDw0GiUrmOyydftxrYn7mUKs/emRfrym/pYPBg06+HDqQMiiNozifZbrnqJ
         UvpQ==
X-Gm-Message-State: AOAM530S+Xu/MSSz9wOxHwPHUU+YiXE8R2EOkYbPHfIPFdhVrzj09tjJ
        LVmZemULlj3cdYkxIv29IiGHp7JQ5+8Hbw==
X-Google-Smtp-Source: ABdhPJyZGUS1QzyLSU5oGUZFvE13ExXRv25cksaZq2RdSXMBwp4hgAYBpiZvjWMNRU0K6YCiiXA1gA==
X-Received: by 2002:a05:6638:3399:: with SMTP id h25mr8490761jav.15.1616098331905;
        Thu, 18 Mar 2021 13:12:11 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c9sm1580785ili.34.2021.03.18.13.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 13:12:11 -0700 (PDT)
Subject: Re: [PATCH][next] loop: Fix missing max_active argument in
 alloc_workqueue call
To:     Colin King <colin.king@canonical.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210318151626.17442-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <13a1d187-4d6d-9e06-b94a-553d872de756@kernel.dk>
Date:   Thu, 18 Mar 2021 14:12:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210318151626.17442-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/21 9:16 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The 3rd argument to alloc_workqueue should be the max_active count,
> however currently it is the lo->lo_number that is intended for the
> loop%d number. Fix this by adding in the missing max_active count.

Dan, please fold this (or something similar) in when you're redoing the
series.

-- 
Jens Axboe

