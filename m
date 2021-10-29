Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE243FCB7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhJ2M42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhJ2M4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:56:25 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F291C061714
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 05:53:57 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id s3so10593141ild.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=LUYF+vFrMrvXEYexLl3qxY2ER/gYtePdoU9fEtmoAVw=;
        b=CVQFg0LJl9KFh+D3bOEMs0y5jpTdyDAnDYUN22GdKR28hhfGHMA8puyLuEdfJq6YiS
         /aZUHBCEUdGJRQ7p9+XFiS9aktBmxvfY//EJH+QMO1uHtzPVvGHinpNzJBkCiy4yf7Hw
         MHE3dz3gQNuMMUQBeKviLRNur3gHv/GGZKE5w/fODm0tdoYNZJ9H0Q3A2InbXh4umv4h
         IHKAaNAvKiBWXC8ByR7a8x6epU8ItR0h/wdKPCGpBmq1iEU/1hQ7vp7iFDVqelmXBc6Z
         9u+ix7ew5qCmAEiGugK1zoCPRnnmwkqWR4B0q2gpvCvZS8qjSBl0iDzyfKiSUJWktP82
         Dv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=LUYF+vFrMrvXEYexLl3qxY2ER/gYtePdoU9fEtmoAVw=;
        b=fDygn5P8on2EtRKdh+S9PJq7gjzHYB5XxB05PAVzcJGkDtsuGt27xoHsGJWfJeak9k
         IN6lFR2xiOefXtN4yMlWXGLn/hiQ7pfLRZXGu/ag7Yxh3+5vZajThF451LnzdRXEyeFO
         nK8olJ9Dy4vWdMOYXaakqnh6Rbt4mFS9ESUNbGlNu+AlDV5bw5Knu/iVvf8xOrr/tmVh
         HbhKm4G6wsmVnLIRzlpPZqppSRGmTrbJLj4cj50UFISC3kKJf544QizZKXwH3jhboEc3
         tWdMhra/ytaLoNSNA8wAuKz6shSpxee4Xu2A1nZfwyMyLMk8fKKjCjj0le1Q1F9rPz8l
         nDqQ==
X-Gm-Message-State: AOAM532Nz6LwLSKB3pNWOIpOSulzRyhPkQNgriOPutxR5NWj034oSP3L
        y2wqvWZYR0AMlPcU/jdyEudm0Z2TsVUezw==
X-Google-Smtp-Source: ABdhPJxwbEx/pAaUpOhk0Bn8Bb8J9haQWvVzgEc4yW3Iruzb/TqFVP64Y5fGvbiIaW+WJANjOiLgvQ==
X-Received: by 2002:a05:6e02:1543:: with SMTP id j3mr7490944ilu.151.1635512036584;
        Fri, 29 Oct 2021 05:53:56 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g11sm3419433ioo.3.2021.10.29.05.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 05:53:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        linux-block@vger.kernel.org
In-Reply-To: <1635496823-33515-1-git-send-email-john.garry@huawei.com>
References: <1635496823-33515-1-git-send-email-john.garry@huawei.com>
Subject: Re: [PATCH] blk-mq-debugfs: Show active requests per queue for shared tags
Message-Id: <163551203480.85142.14090478685501297058.b4-ty@kernel.dk>
Date:   Fri, 29 Oct 2021 06:53:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 16:40:23 +0800, John Garry wrote:
> Currently we show the hctx.active value for the per-hctx "active" file.
> 
> However this is not maintained for shared tags, and we instead keep a
> record of the number active requests per request queue - see commit
> f1b49fdc1c64 ("blk-mq: Record active_queues_shared_sbitmap per tag_set for
> when using shared sbitmap).
> 
> [...]

Applied, thanks!

[1/1] blk-mq-debugfs: Show active requests per queue for shared tags
      commit: 9b84c629c90374498ab5825dede74a06ea1c775b

Best regards,
-- 
Jens Axboe


