Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B5F436402
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhJUOYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJUOYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:24:16 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F791C0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:22:00 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id t4so1054685oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=pwU45kqabGOIjTCLFTiuvnWVscRTVq0V1Wg7F0FQWnM=;
        b=m1DSHkBkyUSgDKySogEvw+YytcjK9ePNfALveLH480YxprvTUn561zQPcVWTdXZ43C
         aOW9u2N6kxwvcBCSPrvEkLoCyjn0JWlSYiBXeM6ciNAgshZEvRwP2LaDQ1jCyVluvtRr
         DDOGShBfvr1fBwNgXu3lEqi7qDOgo0izVQOiaU9XUHZRQGooSxNbMz5qdgkRfZNNwVpX
         cWN2ikXLZp5gWvJEtfIkieFeO5YhAY9SwXOvFzxhfoBlXwUNmvZTdETRMHGPDyO06JVr
         NvVRM7HYSip6VlXExetUcBtZcOz/ESLYA9zWPHzNmcbEC9nb1DeltJNKValWimMrK2LL
         3STA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=pwU45kqabGOIjTCLFTiuvnWVscRTVq0V1Wg7F0FQWnM=;
        b=FI0BzT/dh7Bzgar4+Tzkzd4hLAUNAysb9BYEhwiU7FMpE5pzK1OHHlXjgUtmggIQSm
         BZJ5qsjj9aC6nA9kJg1nNEUrA6CazZ+1FgH7jz7JCIyuBBQQvI2fU7BuuJDTCkW8dQR1
         WP7muIGh2gNxpXjG9Y5+QcG+It9Zgw4/EMQT9UuL+1wF/dQ5iFt9+cvwnlbngDSUMH5d
         VBJKkOgDTkHUCzaU80u/ABB+ldALIV8gYBO0BYYI1afRy+l0XP15n+A/Zv1D+jLz9zGH
         OXt6RG3Ddz8AVD7Uy8YGzSLrxt/yoqrHkcieCfT37vSu/T+OARDD7z3B3gmHP3mjnMJQ
         yLhg==
X-Gm-Message-State: AOAM5311a/xDAUZ2c+nfyGBlss82JEg7NeMKhThWHn8yTp9JE8eDb3WU
        maUZO58u75HHVia4O3Ca38Bfvg==
X-Google-Smtp-Source: ABdhPJxMonhDxnh1DsuGFr+RKw9Ii+GujTV3nMHKAOveBQ7hDy+tCxtaPkG2CMQ4uym5tIf1Wegscw==
X-Received: by 2002:aca:1712:: with SMTP id j18mr4532065oii.33.1634826119457;
        Thu, 21 Oct 2021 07:21:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id z8sm915785oof.47.2021.10.21.07.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:21:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kashyap.desai@broadcom.com, hare@suse.de, ming.lei@redhat.com
In-Reply-To: <1634550083-202815-1-git-send-email-john.garry@huawei.com>
References: <1634550083-202815-1-git-send-email-john.garry@huawei.com>
Subject: Re: [PATCH v2] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
Message-Id: <163482611742.37241.15630114014516067630.b4-ty@kernel.dk>
Date:   Thu, 21 Oct 2021 08:21:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 17:41:23 +0800, John Garry wrote:
> Since it is now possible for a tagset to share a single set of tags, the
> iter function should not re-iter the tags for the count of #hw queues in
> that case. Rather it should just iter once.
> 
> 

Applied, thanks!

[1/1] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
      commit: 0994c64eb4159ba019e7fedc7ba0dd6a69235b40

Best regards,
-- 
Jens Axboe


