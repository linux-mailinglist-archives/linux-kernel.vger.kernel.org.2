Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A19F38CEE0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 22:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhEUUVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 16:21:11 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:41595 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhEUUUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 16:20:54 -0400
Received: by mail-wr1-f48.google.com with SMTP id d11so22166174wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MOQFZcI+55Epu5CwRZbaQFCfIMzQkAmI2YuOFxHRHWY=;
        b=sgorPtSkvrsAydZE2cZhaafGuJ5f8lKVZ8Eu25VL2bGUseeE5jpgyXZYhth8Ed/HJh
         xgREQaFf0O0szUBA+W/gOL2p2yUTC3rWM1WS1LVAJdh+cltrzNCP0gQQ54hjFNaxI5xf
         An6bc7+torHQywBFsiuYBrZGrSNG1ffi5MHAfY1BMjLw6rg5+TqgqXIyGPxMHC9PcGBy
         ZnTBPCiw71bDG6p4Y+YZTempG4rypQOlIqsbTfSL8poNmk+PAXoEjp/orW7JH+ZQVq/d
         j++tYMhJ6XNnBIy49SYvlphEHOuH3zSAW8D2Qu/XfjvKJhhJTtydtWPN46VO3rV/Ksos
         xUxw==
X-Gm-Message-State: AOAM530gccZO/N9FMd0CEre7oY0jgLwJ7D1n0/77UWg5GtRZM1vwQHHe
        8g97j2c77fo6kE9RzJnlWsQ=
X-Google-Smtp-Source: ABdhPJw3bqMk0JtrIdEyRpkFaLXGZ0x4srfJ3bzWVQ1HPHOK4rh2SFkXELrqJ5w5TSTAepr+oW5WvQ==
X-Received: by 2002:a5d:6445:: with SMTP id d5mr11548210wrw.235.1621628369631;
        Fri, 21 May 2021 13:19:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:66b2:1988:438b:4253? ([2601:647:4802:9070:66b2:1988:438b:4253])
        by smtp.gmail.com with ESMTPSA id i11sm3221728wrq.26.2021.05.21.13.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 13:19:29 -0700 (PDT)
Subject: Re: [PATCH] nvme: Use NN for max_namespaces if MNAN is zero
To:     Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <20210521144734.90044-1-dwagner@suse.de>
 <20210521145306.ld7jc6alchimyzny@beryllium.lan>
 <20210521152702.GB29013@redsun51.ssa.fujisawa.hgst.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f89bf79e-937c-96ba-4622-4a29fce00b0e@grimberg.me>
Date:   Fri, 21 May 2021 13:19:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521152702.GB29013@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Forgot to mention: During testing dynamically adding namespaces it was
>> possible to trigger the WARNINGs in the nvme_parse_ana_log(). Initially
>> the subsystem started with 8 namespaces and during runtime another 8
>> namespaces was added.
> 
> The controller is required to have a non-zero MNAN value if it supports
> ANA:
> 
>    If the controller supports Asymmetric Namespace Access Reporting, then
>    this field shall be set to a non-zero value that is less than or equal
>    to the NN value.

That was my thought exactly
