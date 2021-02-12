Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E443231A714
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhBLVuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:50:18 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:42639 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBLVuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:50:15 -0500
Received: by mail-pl1-f171.google.com with SMTP id s15so522712plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jdhUE6AJwckEzLe2vZNYXa3k2eiehtjxGthdtA7Iw8M=;
        b=BbBJ4uGMles1k69TbeZwJ+qcz8ApFfrgN+0Fr72bstiFlmNevVMKUq/ijgpPbOQ4ck
         vEJ7IBB+43FgA/+QEZF6DtbCtuJt23Sp/hoX+UXVFd0iTX3GefAHQxRVUxqYEbKkWi9M
         7xovmIzukQ0sk4BUI0K3P3+sJKpwPyuHKm9LXPJHN+R/TZDpVNta2zKqCycdcebbjtPy
         zGy22n4ItnYQQYUZ0Ln9PbNuRqI2S15aYdDf8iPaABUNfNSY9yZiW7P+jbn81cPxIRoF
         kIjiK8yZJ1qDCRnFQQSAjIGZ75bu/uTsIGdXf91A9JDcg/pGEyPGcvoUetKSlou5TmQY
         /S9g==
X-Gm-Message-State: AOAM531ubuRKzksCj4xWh2U5ogUe1YKE/03lfmN3GV3ddJ6rjgjcYSP5
        3MLpa+ym3lwjNPOCwmst05s=
X-Google-Smtp-Source: ABdhPJzfOgkCemMLAmE6h3yy00IMHAt7MkNxbH8p24zFjAg+5sJ+TeEmKeS39ij6skGH4l4XzFK9Pg==
X-Received: by 2002:a17:90a:fc4:: with SMTP id 62mr4443004pjz.181.1613166574378;
        Fri, 12 Feb 2021 13:49:34 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:65a3:c687:b052:ed7b? ([2601:647:4802:9070:65a3:c687:b052:ed7b])
        by smtp.gmail.com with ESMTPSA id h11sm6879975pjc.27.2021.02.12.13.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 13:49:33 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To:     Keith Busch <kbusch@kernel.org>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
Date:   Fri, 12 Feb 2021 13:49:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> blk_mq_tag_to_rq() will always return a request if the command_id is
>>> in the valid range. Check if the request has been started. If we
>>> blindly process the request we might double complete a request which
>>> can be fatal.
>>
>> How did you get to this one? did the controller send a completion for
>> a completed/bogus request?
> 
> If that is the case, then that must mean it's possible the driver could
> have started the command id just before the bogus completion check. Data
> iorruption, right?

Yes, which is why I don't think this check is very useful..
