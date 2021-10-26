Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF3643BCC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 00:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbhJZWDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 18:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbhJZWDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 18:03:21 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A780C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 15:00:57 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id j10so851009ilu.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 15:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=yaCb0u7kHGCkaTa52y1zZ37iQuNRyZWxVB8xcOMfBL0=;
        b=znQj4CxLFrfRLotnrL7NrFjxFc5hIT+jpYYUUKtsxtUv8ndD8HI7UlgkpUpwOmGMo8
         leg9M4M742eCheZiZbLnFQlThSOgBU5ZUordW6tLqRYHy3f2dPGb7nRkvme4ML29wC/k
         Plvhi7nAYunGGqHWnAw7LClZbTirOL8gtXehQQQ6bQopja4wwkd9Tqmdc3gByWdI6XqR
         FQpfa8MoW9NFW0RqwAyYT98p7oYcWUPbMSAMrkQis/8n4YLbM9uyjzoLTP/ShsZydmMx
         OgKIj8zxGm2u5cdaFmEbcBUvRAFbT4TkIC+CvUhViTmoZrdcaSvdUkXnAp149MlD/Zn/
         4LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=yaCb0u7kHGCkaTa52y1zZ37iQuNRyZWxVB8xcOMfBL0=;
        b=m1yiI45rAIJQOVb4AtASSDNRjkTDuciSGkX6AE54knkS5eBwFpCcqXqUjEFqZmUu+Z
         ztji5XBsohNrgjTNZMOZQGfk8LhSReBnsJyy9p6eis3HPe3FOlQ28hbJ+S4iRtxb0Q4B
         EbuoDzGjnj61JOu8Oq1+MGyJpvt8plwL+Iim2mlcibEYCMb47ZSOpc86V6WIliEWgftp
         FGz1O5rCNv/IolTd7o4HhGtpuB4h/sEI4tjUOSIgwlArXAVVHgE0uBOJLSEPcKgcMj0v
         wbXdT/Ya8xAzMwhXzugl3BmopOKKn4faGKOSHZb+O3ahl7glS3GRc2iMLddD3Bqn8D4u
         5mTw==
X-Gm-Message-State: AOAM531ixk5zeOz2G5+KAnsEEot9M+w9TawqUyAc6l1rmWfpalEwLgsG
        ObC5QqmE+TEX1Vx7doAyz/n4ZbRC0JylCQ==
X-Google-Smtp-Source: ABdhPJygmCTN0DIW6AoMGzHLBKa0OoR3NljfrKfxn31V1ZWufs7FbfUO9CwVl7o2VLvUPwx3C6NCnQ==
X-Received: by 2002:a05:6e02:188e:: with SMTP id o14mr10658855ilu.114.1635285656867;
        Tue, 26 Oct 2021 15:00:56 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id d10sm2191871iog.25.2021.10.26.15.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 15:00:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
In-Reply-To: <20211026165127.4151055-1-naohiro.aota@wdc.com>
References: <20211026165127.4151055-1-naohiro.aota@wdc.com>
Subject: Re: [PATCH v2] block: schedule queue restart after BLK_STS_ZONE_RESOURCE
Message-Id: <163528565626.259196.4840508461738349119.b4-ty@kernel.dk>
Date:   Tue, 26 Oct 2021 16:00:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 01:51:27 +0900, Naohiro Aota wrote:
> When dispatching a zone append write request to a SCSI zoned block device,
> if the target zone of the request is already locked, the device driver will
> return BLK_STS_ZONE_RESOURCE and the request will be pushed back to the
> hctx dipatch queue. The queue will be marked as RESTART in
> dd_finish_request() and restarted in __blk_mq_free_request(). However, this
> restart applies to the hctx of the completed request. If the requeued
> request is on a different hctx, dispatch will no be retried until another
> request is submitted or the next periodic queue run triggers, leading to up
> to 30 seconds latency for the requeued request.
> 
> [...]

Applied, thanks!

[1/1] block: schedule queue restart after BLK_STS_ZONE_RESOURCE
      commit: 9586e67b911c95ba158fcc247b230e9c2d718623

Best regards,
-- 
Jens Axboe


