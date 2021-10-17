Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F06430947
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 15:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343682AbhJQNLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 09:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343671AbhJQNLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 09:11:31 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7EEC061768
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 06:09:22 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id y17so12134686ilb.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E9Jyn0+UnK3sc3mmvA7he3hRp8rjj2TT3D6AT72yd4M=;
        b=ASbJHIes5zFbIZLmT5kVad1Gphz/29iN5mRZeqZ3tlpfB2PUdfQDCYxs075KhC+NRv
         +usb2/LkAXg0fIeSB6mt8w9pH+E6c/OzEkv6tDGKbfXIFAQ8t5oyEn+o8Dm+lUJUNx5+
         Ul8uzxE52kgKEL4dvh9ifK8Bs7hDbeWzFDtGBQT9pQvuXKgTknQxbbEBf0BO1vBzF4qy
         L/DyRrQaJNeIc5GfM9JkFYQXD4eGf7eTOnQDguECYJz6ORTo/TEr2I9lvVJ6/rauXUJO
         VfwfWz2j/mdzCKbXt9/EaZfgdFsXIAT6UuwcRy3z9fFP2sHhYSEzdGkFLIglkDES37rW
         UmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9Jyn0+UnK3sc3mmvA7he3hRp8rjj2TT3D6AT72yd4M=;
        b=8GlMbyOUnYgXgR4Fw3sZleWXGcJAffou0w0brWt0t7pjaNq58DDwqMXXip0Ec87U+o
         /ErZUwx+mHXfsKAvdroBtP9fjmo5U3tIvnFnE707yjbPA/s1shR7KxwpmyDnF811zQEl
         oyezqobhVAZh1klxnICVv3YfMQyg85lwvcwVFYtX+7Lu0ZDGvrOJPFnepdr+X083VZIZ
         wfftNoSW4MJAjXd1EX1ivXF6tIafIEcxqzSiJk3UCfCjMFxJPTiqBwSKmXw28VI1ZsVM
         S1V3iiahipN8CvX41bgjNC7l6E8FfSd7WUFtnkOLlqwWnDum/06LSMzpTRMVMYt42q6T
         bEiQ==
X-Gm-Message-State: AOAM533zf5jIgmlflvdmV2/DOeY+Jj2QnHrH14XYg+49Mkm93PzIM3Pe
        OpBnKQsy4ZazJG2wQ9LCN7xDsw==
X-Google-Smtp-Source: ABdhPJyBQfKmB09Bzd5teZfNePKIxWO5jVUrQL469Ya6l1IO9E9yjwNbDWiexPCRyhhuJXu+WSpsNw==
X-Received: by 2002:a92:c244:: with SMTP id k4mr11177912ilo.3.1634476161731;
        Sun, 17 Oct 2021 06:09:21 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id h5sm2543282ili.12.2021.10.17.06.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 06:09:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yu Kuai <yukuai3@huawei.com>, ming.lei@redhat.com,
        josef@toxicpanda.com
Cc:     Jens Axboe <axboe@kernel.dk>, nbd@other.debian.org,
        yi.zhang@huawei.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v9] nbd: fix uaf in nbd_handle_reply()
Date:   Sun, 17 Oct 2021 07:09:16 -0600
Message-Id: <163447615283.94076.11299323774180750344.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20210916141810.2325276-1-yukuai3@huawei.com>
References: <20210916093350.1410403-8-yukuai3@huawei.com> <20210916141810.2325276-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 22:18:10 +0800, Yu Kuai wrote:
> There is a problem that nbd_handle_reply() might access freed request:
> 
> 1) At first, a normal io is submitted and completed with scheduler:
> 
> internel_tag = blk_mq_get_tag -> get tag from sched_tags
>  blk_mq_rq_ctx_init
>   sched_tags->rq[internel_tag] = sched_tag->static_rq[internel_tag]
> ...
> blk_mq_get_driver_tag
>  __blk_mq_get_driver_tag -> get tag from tags
>  tags->rq[tag] = sched_tag->static_rq[internel_tag]
> 
> [...]

Applied, thanks!

[1/1] nbd: fix uaf in nbd_handle_reply()
      commit: 52c90e0184f67eecb00b53b79bfdf75e0274f8fd

Best regards,
-- 
Jens Axboe


