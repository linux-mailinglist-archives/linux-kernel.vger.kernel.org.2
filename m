Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B9A3557AE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbhDFPZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345616AbhDFPZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:25:26 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54C8C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:25:14 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p10so2565265pld.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 08:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eAGmN/IP1sbbvp9GcvrDEjCal2kH3z1B8m1lH1SKGHQ=;
        b=KXPvmU31dtnRnJHnw0lFVAf/R1G+7kBjCZQ+LxBmomBYnx1AkcTO/bx0DwiUH+eyde
         ghbElRjaPwXnZSHMJKLhOweclkqVQFmEvIS1aY1mhTv8iguO5kNaSqpXXvuuQP4XOLs1
         dl9fwfrBuqZbBN+9U/twVDw7PbQWc4C1KfAUV+zxPx5aE4CI6bYmBFKZ4lsbarugd3am
         +fg6iA2Tl20BFTzLv1Uidau4yizxj2XWLIgMgVHJFm2lCG5+GYKUaC7j4WmG/tcSpfuY
         GVaTUqmkNkPK2QugcYELYMj3pmOyCab+2Umxan8an8D9NZ1RBVLVAVskWRNp78sagStv
         LzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eAGmN/IP1sbbvp9GcvrDEjCal2kH3z1B8m1lH1SKGHQ=;
        b=YTgxN625jbYoLT+nKuhB1SN93cr3WbrwSin0JGY0x0NBzFfB4HaQWlCEbzmttwaCpE
         ByozpVTn1xRSgx6wIDL7rMPN+M9j4iNod/ZWDreCTcCdsZjP5MQ0zOIn0TwoO9VWry83
         BsbTgo5M06hJziUF8IInTBTy/K/97ENQNIxJRidZlBDnRor8/8nOVxlmR2Yl82WKU7XV
         0+oTK5ixUhP3bR3PPJKmJDp1YkeAmRbJgcYcZn7xJr8Ed0ZAhqiVvJJE2G+UZVfbEAzS
         FZyJ6gB9hu/bz2a13Z1CXe159uKiNDyJKpygf6Tcb/JOEVhZU6BpfjCPCDXBXwl9JGBG
         M+CQ==
X-Gm-Message-State: AOAM530SKioSXKhmmO3LJ2TPPgdvJYoadhPH3Fg89TYSpendQgRGcQro
        SFmFNssolgSt33TBEcp0UNVyMQ==
X-Google-Smtp-Source: ABdhPJxGY52WpxrenfGYJu+3epgVuioinc7x0bsvZEgfwshCOF0GFITdIvHt6zJyQ8WUYUj72kBF1Q==
X-Received: by 2002:a17:90a:5d10:: with SMTP id s16mr4784671pji.204.1617722714358;
        Tue, 06 Apr 2021 08:25:14 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id w26sm18345866pfn.33.2021.04.06.08.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:25:13 -0700 (PDT)
Subject: Re: [PATCH V2] ata: ahci: ceva: Updated code by using dev_err_probe()
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, sgoud@xilinx.com, michal.simek@xilinx.com
References: <20210305091029.23378-1-piyush.mehta@xilinx.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f52a947e-75d3-2d88-6ef6-4d2d08bbba7a@kernel.dk>
Date:   Tue, 6 Apr 2021 09:25:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210305091029.23378-1-piyush.mehta@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/21 2:10 AM, Piyush Mehta wrote:
> Updated code with already prepared dev_err_probe(). It reduces code size
> and simplifies EPROBE_DEFER handling.

Applied, thanks.

-- 
Jens Axboe

