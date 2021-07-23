Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769C73D3D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhGWPtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhGWPtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:49:12 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3100AC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:29:46 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so1223971otu.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8rBL90M5hYVaYFxbwTr6am4zA6NsYnm1G1zAGhOeDjk=;
        b=HgvPO3mAYqNYzr4LaDFGBrMZd6ilYO5nP6zUy7BaVrCiZ2JuWxU0zakcpLQZId2caX
         A78zuffdKzV/qy98X5DQ6SnkDm7oShPllxcUwowbRe5zHq0yuU7Zc4iUEgfVhdcHTA4q
         2BT7eqw7VoH13qbMoNdR/Vv0T5oSU7I0MWDfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8rBL90M5hYVaYFxbwTr6am4zA6NsYnm1G1zAGhOeDjk=;
        b=SDdSXrsoKE9T3QSmg4FHrvE5H0VPoePeXHIuBzEIIFl3s6mwheeKDdy2ww92U/i1Ul
         W3y4IR4l+cA/GeH6Ve6sLMptwfQ+a8yIyyjWngra0drR6IBh49VDwR43uEtdG1xT7G7W
         5nlGhSNgPRI5JSVhNYB+BiRq9Zxm05RzmHXpdasxMlv22crT2nv/i3d2P+wx4R+pJQgc
         mSlyNDJy7cIHCvhm1UPWr9mkfSVUsmCFFgDQ4ja7Lw2HTbqRyKUBXIaBnRbuAQW0//91
         btDKjSbC9RecQaWXidbrSgjeZyYigmpRT3v7zoQOH9oCPFbGxOwx43/FU3VX5HWEL27I
         Ljuw==
X-Gm-Message-State: AOAM531x4qPNaVZgeEihUWa22hFoKcGODR8DG/RTHX4/QGrbycyvq5mh
        c2CmfcmpsShNA4tRz5nEouPvqw==
X-Google-Smtp-Source: ABdhPJzc9fiP7N0If6VhsoL/ftQTc6YzKU1t6uYtq/38oXN1crdLWO5GMXyX/UhDFGei87414EW/BA==
X-Received: by 2002:a05:6830:19fa:: with SMTP id t26mr3707955ott.58.1627057785605;
        Fri, 23 Jul 2021 09:29:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n202sm2560832oig.10.2021.07.23.09.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 09:29:45 -0700 (PDT)
Subject: Re: [PATCH v2] vhci_hcd: USB port can get stuck in the disabled state
To:     Michael <msbroadf@gmail.com>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210721235526.10588-1-msbroadf@gmail.com>
 <7b02cb66-d672-ae95-01ea-c6015725e1ac@linuxfoundation.org>
 <CALdjXpA4_eXen6RjhsEBYt8CQs-2gzwYs9h9q0Z2LKZ=rXVp+Q@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ad07410b-05d6-6a12-13df-14e31cbf50ff@linuxfoundation.org>
Date:   Fri, 23 Jul 2021 10:29:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CALdjXpA4_eXen6RjhsEBYt8CQs-2gzwYs9h9q0Z2LKZ=rXVp+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 8:27 PM, Michael wrote:
> You can pass through any bluetooth dongle (or xbox wireless dongle) through usbip and it will cause this issue.
> 
> For example, here is one of my customers https://www.virtualhere.com/comment/9432#comment-9432 <https://www.virtualhere.com/comment/9432#comment-9432> with the issue.
> 
> The device is in the VDEV_ST_USED state when a reset occurs and so its never re-enabled
> 
> Furthermore there is a bug in the line pr_err("vhci_device speed not set\n");
> (L479) because resetting a full-speed device is not an error.
> 

Can you provide me the full demsg from host and client including the part
where device is attached? I assume usbip tools from Linux sources are used?

Also send me lsusb output on host and client

thanks,
-- Shuah
