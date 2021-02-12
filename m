Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D053531A670
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhBLVBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:01:17 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:35613 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhBLU7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:59:10 -0500
Received: by mail-pf1-f181.google.com with SMTP id x136so273816pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OOP85J78eURVeajRWrWSkTfxx+e6ApRWxBqBF8ABPdM=;
        b=jKbOze65g47PdPRRZSgoPtmCkInH6E27ghOXJnf5Ctyl3d/ifVH6e4QX6C3yi4gZqz
         hcZSE7CVx+DHahBG7DigyqDwiUYbrvr6SoGIrCOU/3KMvloWp4dfE/0STe2F74VNvCLX
         KJE2GouW39pTip2dk2Y09hT+hSou9RO+8uHlxpbyfESJ4n9+i+pwT/qt9xntG4OpU1UH
         boBjD0ck4LBflKtqK7y1rmDcD1+IK91q/8aPptta9uiOpzfxGAxQ8Eh0cKDNiCR1c6k9
         /9HjgmYn9+y1MkKm+ZtQxbHyTF/9l9LZpv+jVVLZQhpvT62f2DiLuCcF2hgOrGkrStkK
         WX1g==
X-Gm-Message-State: AOAM532Xv0oTMXx6xd5hwunqmlhKPH8LX8v9gk6zxPGfnoEr8Ib5ZgmK
        x27+dtS2VT8h7780sk2PWMo=
X-Google-Smtp-Source: ABdhPJy60UkNzLFCj6yFQkfBtOU88xBKIi0CchABJltdveTzvfTmlEU5zN4nhzO1XP9gPw1SGhrr7Q==
X-Received: by 2002:aa7:93ad:0:b029:1d5:d9c5:cc08 with SMTP id x13-20020aa793ad0000b02901d5d9c5cc08mr4609553pff.37.1613163509931;
        Fri, 12 Feb 2021 12:58:29 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:65a3:c687:b052:ed7b? ([2601:647:4802:9070:65a3:c687:b052:ed7b])
        by smtp.gmail.com with ESMTPSA id w4sm9897356pfn.45.2021.02.12.12.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 12:58:29 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20210212181738.79274-1-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
Date:   Fri, 12 Feb 2021 12:58:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210212181738.79274-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> blk_mq_tag_to_rq() will always return a request if the command_id is
> in the valid range. Check if the request has been started. If we
> blindly process the request we might double complete a request which
> can be fatal.

How did you get to this one? did the controller send a completion for
a completed/bogus request?
