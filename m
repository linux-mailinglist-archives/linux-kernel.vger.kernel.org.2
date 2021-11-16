Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C97453637
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbhKPPqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238378AbhKPPpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:45:47 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF12C061766
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:42:41 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id z18so2482802iof.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qZTHx1FvTHabhubW5uLJTFw9g14LfOUphosZneheXs4=;
        b=w3QG6GtaZbgUU/+dtPJdAPWmz2QGCSQsvGWcNOjVgJzNUtppuN3BuL6C793MwPsZco
         vmpfKXeKJF5z9hGpGvKNH8qXEqsKBJa//YA7/NsmjWcI7ePjzc707vdTSfxUa5RRaze5
         3toFmyOzFAODOhoRXNXy8XE81gD/Au+qO9TNc22HyPGVBXVWCATQQdOuwc6p5jiP16Is
         FP5Ce9W3ANlg3rjI9JLET3UWo2rETlyvy6UcENgodYMRaZHNJWlwtdwsfmXl3uDpZN13
         8Ed7vKFVvUydjzwgPptOkIz5BNiPjJ1+CwafmBa/wPySHb5HrIHRnpnmEkmI0ZDscVCv
         lU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qZTHx1FvTHabhubW5uLJTFw9g14LfOUphosZneheXs4=;
        b=SLbYWqbAwDbttXqjieeVgJQ4AP9+mu6ETC+yH9xis13iFar5DdnxVkDaWk4ITN8NCr
         xODBE6xaAayBuHpLUI4fL5T5DlppDE2b5r4avvhBrp6kiCC5jzXp0QrEGdnJjvfRwTQX
         tPpJLiy60IUvAgmT3wa86aBkrsgjWsqWkWu8QHR2rwX1WygxE7zikr4ZrbpccHkyB+Gu
         U42qEsvHW/gf5XWSJPGxZhTaLvnZ8aAwTqAYRhzQWyOEU10+WjSm2Wu4ENq3p/R0oMUz
         uHx902ohExow5vzJf7FX5zNayXsZIjpjJyM+8GsC8Iup86KdhQLtoAbQw9z4+eOd9+8T
         WNxw==
X-Gm-Message-State: AOAM530iVJJXBKsusU+gEDwVtRp9aiAoORrM6+8RweQD8I5ThH5Fmetq
        lj8HKbbRjMAYdKiv1fgitDl9FA==
X-Google-Smtp-Source: ABdhPJyrpIfc2UW9Rx72NBiL5cdgp4TrZ59GyNqn8h8b6TcBQy++Dv52FlJE6Vv7QfaAlwnjezgwfQ==
X-Received: by 2002:a02:a601:: with SMTP id c1mr6313123jam.114.1637077361081;
        Tue, 16 Nov 2021 07:42:41 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o10sm9609624ioa.26.2021.11.16.07.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 07:42:40 -0800 (PST)
Subject: Re: [syzbot] INFO: rcu detected stall in __hrtimer_run_queues
To:     syzbot <syzbot+de9526ade17c659d8336@syzkaller.appspotmail.com>,
        fweisbec@gmail.com, hch@lst.de, hdanton@sina.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, paulmck@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
References: <0000000000007ee63e05d0e9c172@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <097631ea-d781-c4e1-aa0e-d921a7a2e69e@kernel.dk>
Date:   Tue, 16 Nov 2021 08:42:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0000000000007ee63e05d0e9c172@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/21 8:41 AM, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit b60876296847e6cd7f1da4b8b7f0f31399d59aa1
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Fri Oct 15 21:03:52 2021 +0000
> 
>     block: improve layout of struct request

No functional changes in that patch, so looks like a fluky bisection.

-- 
Jens Axboe

