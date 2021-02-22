Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C32532204C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhBVTiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbhBVTiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:38:50 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FFCC06178A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 11:38:09 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id o1so4996555ila.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 11:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lCpqEV3eW8CcyGSmXvovayWJLt4fKp6FGKh4rVVK4UQ=;
        b=0s6MksYdEfGF0ZiiNsEafPdAgPr0ygnxD+aBaBry+AlmjnJwzoKo5loodzunHaCYBd
         pOa0yzaJk/zc85HljsBFIx/kKQW7Bwwtz1Dq70hY8wJ0nMtqmqgXm1o3YsmEHRD99sxC
         +wT576ok11KhJEINoGZYaoB59TweOua7g86d+Nz8ChFxPSws8qQ55ymOVf66M/D2rr6J
         fYyWTz3cPluKLhlJLgNjHmxr6a52Yp4aAtT4/1wN5Eih/xPknK8OYXmlC4Fax8lkRVzY
         sYiDb93Y7ErLN9EblEcuiHW8qyBXiElBCA6+PHd/Tuz5r0gY5rFdbn0lL4KhyUEV6dvG
         7Geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lCpqEV3eW8CcyGSmXvovayWJLt4fKp6FGKh4rVVK4UQ=;
        b=XpxxJYL/teixHSXV4ovu0JyYLYBfwmE8D+IidtVFjTkozTZxJt/JHl2XwiIkJ8FaLj
         4GOi1YJ9OMCZ4bNrwUHMA78e/Q35LfZws/fcNVtSZIIErlQj3BWIbyHnMcpaOZ/nBwLz
         e/BOvl6hiJd7FplWe+MUcuXzQ8249KZoD1OUVobIBCbHSTUB452D4Jbe317kVfv1WGGJ
         XDpxV6WeGIbWx8Az7Qke8KeANrk808pjVloE0k3jTdTkUUz94NEKpDFIKl5vHVjYkuTD
         qcS81/h5g4BN1Iw0zD1D7gRLKbUmz12/bLut8uIV+8dVP5B+Wf0Dq7zCYD/GKIQGNk3P
         95kQ==
X-Gm-Message-State: AOAM530jqmqW3BZyN4KFMILtr/1qxCQPLKXWJuoPewPAvZuIg5580d85
        6hY8Imspzv3hFYTZRja4HL9pOw==
X-Google-Smtp-Source: ABdhPJzhF7sCROPKsaZ5xG0H1UsTGfn1Cgg6gr+MFUVNyhC49BkqhWuGUImqQ0L8J9LD1DcIPcxYiQ==
X-Received: by 2002:a05:6e02:586:: with SMTP id c6mr9184545ils.106.1614022688906;
        Mon, 22 Feb 2021 11:38:08 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j1sm11850949ilu.78.2021.02.22.11.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 11:38:08 -0800 (PST)
Subject: Re: [PATCH v2] kyber: introduce kyber_depth_updated()
To:     Yang Yang <yang.yang@vivo.com>,
        Omar Sandoval <osandov@osandov.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     onlyfever@icloud.com
References: <20210205091311.129498-1-yang.yang@vivo.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f94990f-2732-547a-09f4-42d5a6ab77d7@kernel.dk>
Date:   Mon, 22 Feb 2021 12:38:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205091311.129498-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/21 2:13 AM, Yang Yang wrote:
> Hang occurs when user changes the scheduler queue depth, by writing to
> the 'nr_requests' sysfs file of that device.
> 
> The details of the environment that we found the problem are as follows:
>   an eMMC block device
>   total driver tags: 16
>   default queue_depth: 32
>   kqd->async_depth initialized in kyber_init_sched() with queue_depth=32
> 
> Then we change queue_depth to 256, by writing to the 'nr_requests' sysfs
> file. But kqd->async_depth don't be updated after queue_depth changes.
> Now the value of async depth is too small for queue_depth=256, this may
> cause hang.
> 
> This patch introduces kyber_depth_updated(), so that kyber can update
> async depth when queue depth changes.

Applied, thanks.

-- 
Jens Axboe

