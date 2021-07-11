Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03C23C3D62
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 16:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhGKOsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 10:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbhGKOr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 10:47:59 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8199C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 07:45:12 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id b14so3298229ilf.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 07:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=btT2OBKgUJ7MEnjAq/t/i3XRaYDybmTgopqql9HRb94=;
        b=VGvFp5OrlyBdSHnj6mUQEQAkiMpDtBsm4uLkejLhHGjX8YkyFJuCpGNFSxm7Od4Zfm
         upWPGlZjxGkDy1XBwtXwBIKE0Bh3cxMIXyDqqMCUrge0oSyhoB9h4iHfs8RSC41ES5xO
         0mGfKkd+CELKVL1SMEMCFI2gajPy5d7V+I+JHOSFIzfpqrv+iq3eYsnF5ZB+KamIqDp9
         H2Yipi7M+WuI9slXPX8MgdPexz3PnXjBg8QDIirvtgkh2Xp/yUpKsuFwuwpA5Qj0R3Aq
         v5KbumGsKHZJiPMIeEJ8wzVxcl7w6hw9D1ZR4spHAXgHWzkFWh18axmnWTeaEahjEDM3
         /IzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=btT2OBKgUJ7MEnjAq/t/i3XRaYDybmTgopqql9HRb94=;
        b=lXTLUKy9TLn8vpPgJIbcgLQFiI+sWErc1nKvNV4zXgCmZt6s8GZ3Xir4fMaWcFeY5C
         MpBeDv14X+zkGfV98jGb/W7VopyYYjLO6KWlnDxRBbOYPxLFtlIe8ERRHMe/Jogt9cPi
         ZdB0ObEzO/I4hS44FhMiAGJ/XpBFWYFUYjTWgEbh4QGdbUNZGiWtDU/ln7r1WgW47YFO
         ctL5tLIQzLLjrSa+42MjqObL+KyJmryXkb0Zmro+mNP+ilUsplgZ5f0lA/+RPNzlM+WV
         Oq0rjmUIqY4jFZLrXFXfFzAVrR430HlKwKhg5J77b75IVe4ww2i+hdprcChKV9ZVGzqX
         Xxfw==
X-Gm-Message-State: AOAM533gVJqHbMDkMbnUwn+M68qx4aY9SsaWsPsqljivqOCQ4ASea9b1
        2tj2BGAeeS65fAR9qRMOFPqJNQ==
X-Google-Smtp-Source: ABdhPJwIjMRbZg4VRB12FUuEoD2sxJZyRkJuWwYmEgNtkyzxzYt1AsCOr8fZY2ofiB0cpaZDMJVqAw==
X-Received: by 2002:a05:6e02:1a0f:: with SMTP id s15mr34339365ild.58.1626014711503;
        Sun, 11 Jul 2021 07:45:11 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id s15sm6078050ioc.11.2021.07.11.07.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jul 2021 07:45:11 -0700 (PDT)
Subject: Re: [syzbot] INFO: task hung in io_uring_cancel_generic
To:     syzbot <syzbot+ba6fcd859210f4e9e109@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000aceafa05c6d9f795@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8c598db4-396c-2193-6353-9f3a6be49b5d@kernel.dk>
Date:   Sun, 11 Jul 2021 08:45:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000aceafa05c6d9f795@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/21 8:39 AM, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:

Unrelated failure, let's try the patch on the old base instead:

#syz test: git://git.kernel.dk/linux-block io_uring-5.14-test

-- 
Jens Axboe

