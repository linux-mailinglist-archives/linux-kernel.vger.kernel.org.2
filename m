Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98553570A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbhDGPmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhDGPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:42:54 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA96C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 08:42:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ep1-20020a17090ae641b029014d48811e37so1527333pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sT8AkdrBBL3YKvJU3fz3EtmsSiuHjn1hvxcUtZSjTJY=;
        b=wB3SEgQ9G1vOUGBjoretSKVRkZ7dYZ/hrWRXP79u5w+2SM6hK1pCkk43wDs0Zemtzg
         AcRZDUTMIro0fLswe2qrzMMhgq0Y9szQT24OcYc6uGVzDR9sIO79NAe80ZqpdhFk2H+x
         JwCFJI3lw4aKmzYEX74erpJYtYyAR/sKAeVNvUl+NOOw4RgzoEoeM1LkUaM3VQWwHN9r
         x6mUwGHiHB4BUTId9oy/vuP7OflE1Mzm2U5Wv6Yq2MW+MolX5u5vKNJQryR8VqfvEsfO
         h8ucHCUdmFI2hmkLWE5h/OWUew7xuzc45YHmjPXafmeTknykMLPJS6X4zWa80ptUFpjM
         H/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sT8AkdrBBL3YKvJU3fz3EtmsSiuHjn1hvxcUtZSjTJY=;
        b=AI2+Q0q9aBlabyu3XA3w903zlWLzoMIzvFypupM5q1jX5js20eXq8OVmz828O5PPKQ
         6WcF+kWB0DHkHPhIGMo8d6drUdYWVje4p1d+reGtOr285apL8sFeOQBvirh/dfdBgfqq
         SL7udyoDHcd8wHOTF6Ouw95x5xVDN1NpDRKQKhGBRMeMTreCnt/V8SnVPQrRlNrR0T+b
         1yOwUUmnyuddV9F6mrbPeA1Z6kR8KSWxcDSzft+fvU86InfLmOa6gfzHuKQM6N0C99Be
         P5NEoKoMPQE1E0adBBdL5aqo+5R0h2DQjLolWoTtE+h/F8H1jS09W1rxGnkLLafeoNgF
         Q8NQ==
X-Gm-Message-State: AOAM530exZJIAE1OzlTWet/qLO0zg7YmckWWlzecxYmacaoTgUyTdGjj
        ql1VXYP9GIGfjg0dZL/h0HP3i1jFEg3VLg==
X-Google-Smtp-Source: ABdhPJyhuMuW5sXWyB8gxG9izmfPwY64ukKz7MYoMuXgygt4AxfMqJoNs3toOIL2AkDwWW+6I2GvXw==
X-Received: by 2002:a17:902:a513:b029:e5:d91c:2ede with SMTP id s19-20020a170902a513b02900e5d91c2edemr3586490plq.65.1617810162901;
        Wed, 07 Apr 2021 08:42:42 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id em16sm5865370pjb.43.2021.04.07.08.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 08:42:42 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] ata: Drop unneeded inclusion of kernel.h in the
 header
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210407134706.81383-1-andriy.shevchenko@linux.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <49f72504-2a25-fc11-cb0c-6bf726773cc2@kernel.dk>
Date:   Wed, 7 Apr 2021 09:42:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210407134706.81383-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 7:47 AM, Andy Shevchenko wrote:
> There is no need to have kernel.h included, I do not see any
> direct users of it in ata.h. Drop unneeded inclusion of kernel.h.

Applied, thanks.

-- 
Jens Axboe

