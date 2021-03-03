Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C10632C216
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351311AbhCCTdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350609AbhCCTGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:06:34 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9213AC061763
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 10:56:28 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id n14so26917436iog.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 10:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ds8+wlVYW22u+FvDveNLC8T5YKYXydqAheuVMnQ2glo=;
        b=1N9kJmXlRVXKr1ssqHsLMfnQdUJsvft54ke5srmBSqvNkm7t62BWRhmTPkG9imXBo5
         Eh1sptAsffoVVKtOfN5TTCK2uWCJELt2JG3zkhjaPEYvyle8XiZPqNppQP5UcFhEIfFX
         QM9OXOEBjiLqp19Rss6PbJ65sQFDfzoXup+7sBKGYo0lqt5EJJz5sh5+aTZRlPLdHnFe
         RXCAa/d/GrLFRmV2FIhvL2lZZFXJAKAE1HkmKfrzeO1dSA7K+H5Fxx7BC03As9jk4FxX
         awGs5Q9YyBrQpisbyeJtO/xDviWr6JFigstVXA1FeJ4Kbf1aeIik6eG5Gp500s10p0gb
         +UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ds8+wlVYW22u+FvDveNLC8T5YKYXydqAheuVMnQ2glo=;
        b=CgbyJZy7JrYzMj8AaXb40im/nEyawTlte7JWPU1AGOxem7ZAr5UxwfzFZqxnzI1rLN
         2JZnTudU5x4cTH6YOnFe2jUIN4nTYvf8kk485HwUZHqwfqoRDiZ/YenwUOoEwgMgapc3
         o2oKB/XDWMfwVH3jWKB6Ry26jrGfosULCZ5CQ4f9Frfz3HUV9QvBS3xw6qelzAahyqM5
         650PD89K6vlJ+SjEnUl4fxw/1mpdUt/XVIcCVg4swZo6l//PtTmKypUXVdRCN/4vy7xI
         nG1PAsW51jaZnjN78HlryDlBMyugFuUuHA3UJ2if7QXPN8xWFG0+GbwjXsfMk3xR3qWS
         liYA==
X-Gm-Message-State: AOAM532GXRBSmclkCgG+6Bf+bKSqN3dp/9VHUkb5LspwuRyjUgIprBiC
        UVESCBqUuKVPc52tDcMZpuuqWA==
X-Google-Smtp-Source: ABdhPJxxd75Cn/jNciHpoDvcyoOEh07vk6AJrir6Eim4ZxpBT1WAjS2mE5/iJiWvH6d7SIjQqH8tzg==
X-Received: by 2002:a5e:aa04:: with SMTP id s4mr540979ioe.30.1614797788029;
        Wed, 03 Mar 2021 10:56:28 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y3sm3943224iot.15.2021.03.03.10.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 10:56:27 -0800 (PST)
Subject: Re: memory leak in io_submit_sqes (2)
To:     syzbot <syzbot+91b4b56ead187d35c9d3@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000005d1fe305bca62b07@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <af143fa7-cff3-48eb-5abc-94e3685d0955@kernel.dk>
Date:   Wed, 3 Mar 2021 11:56:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0000000000005d1fe305bca62b07@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/21 11:39 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:

#syz test: git://git.kernel.dk/linux-block io_uring-5.12

-- 
Jens Axboe

