Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186E332F44D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCET5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:57:43 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:34856 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCET5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:57:33 -0500
Received: by mail-oi1-f170.google.com with SMTP id i21so3819115oii.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 11:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BvXqs9Un/8ft9bW8S9EkC2iye0k2IA9jrybCCvql2JM=;
        b=k9zbcL19AHObDLIbfBmeAPw+m3GwZiziFtJanF5TmspcUuz8py3t/P4eJRmAiDI64N
         b0BDNWGEq78iwsmCQrjFvMEsxgfIeN0EUPgJfiE8/Cn1Vei7+UzA0hoW4y0/hNb8opCV
         aGhBD+CWAyDJmOwW5QQbQ9naUADLgNwyym2bsis2t01tJVV7NtUuIc5YhOJOtcEveyI5
         FHFOgksl4WddMbre7XCEyHRnPR5hM3UM2IVGuwRpJk0uwX26trgydjwHvmpaZlT5RTcC
         JOofrDxoK3UMLEl2nZDv7+8bgP/cmXtYyq1jh+5WaQs719brfUvN/Lkr7x+P01gnzBJ5
         Seig==
X-Gm-Message-State: AOAM53280Hg8Gzvs0ZkZfoYIPzKxcQ25cLEpXEp3K0WKRlalPCHECWGs
        TWy2p5FO2Cdf883FYH929cw=
X-Google-Smtp-Source: ABdhPJyMwiXWbnwj6dGmjaoVUfexvraw+iQRPvDtahzZeQqf+s6eyaKCXxXZlYIep1wBZjvTiqxrEw==
X-Received: by 2002:aca:d708:: with SMTP id o8mr8354457oig.12.1614974252695;
        Fri, 05 Mar 2021 11:57:32 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9? ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
        by smtp.gmail.com with ESMTPSA id w15sm783647otp.29.2021.03.05.11.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 11:57:32 -0800 (PST)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
Date:   Fri, 5 Mar 2021 11:57:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210301175601.116405-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> blk_mq_tag_to_rq() always returns a request if the tag id is in a
> valid range [0...max_tags). If the target replies with a tag for which
> we don't have a request but it's not started, the host will likely
> corrupt data or simply crash.
> 
> Add an additional check if the a request has been started if not
> reset the connection.
> 
> This addition check will not protected against an invalid tag which
> maps to a request which has been started. There is nothing we can do
> about this. Though it will at a least protect from crashing the host,
> which generally thought to be the right thing to do.

Daniel, again, there is nothing specific about this to nvme-tcp,
this is a safeguard against a funky controller (or a different
bug that is hidden by this). The same can happen in any other
transport so I would suggest that if this is a safeguard we
want to put in place, we should make it a generic one.

i.e. nvme_tag_to_rq() that _all_ transports call consistently.
