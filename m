Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C41443407
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbhKBQ4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbhKBQzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:55:20 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A76C0432DC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:50:48 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id f9so26172426ioo.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=+dbQrmv/b1RygKbYKHH/vVKFe1UJLRUyNsf2ThtHMLg=;
        b=yYUlBfR+AahwtMsc9t/bT1wxlAjiqYn6KCVtPJwRowvsrx3AKmWyImkeE9GwPnjJ/g
         9r8CWW3DzzktOW7KdJ+OlIqgqGDN1GfijyeI05jbdMtmJF193edHIUXQLSK9qrKKIyXc
         T3JJONJyx5Ui4jL4+9JYAlXgszMrv5YS53243mpOSaHZW+vpWNY/DKFeFrNLfikhUSAs
         TqLnNYfmmG1kaL5GvME/9tzK12cAe65XdZwEZwJPsuySH6PEDukX5HldaRI3zrpv09JU
         MVKABNXst6dfW9eTPFe4MtfuaE+J6UIZH1IgVyzy7sBLEs2j6IvB4JJcqYqTePNI7bKG
         7Sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=+dbQrmv/b1RygKbYKHH/vVKFe1UJLRUyNsf2ThtHMLg=;
        b=ZDOWNEIIpj4voBRgWolfGueVNJVEpeihOeTwyDDU6MpMZ6bCjhIXCVroS7RxyTenhT
         hAve/kn1L5UcHRdB+BYyDUYl28m/JntNTmZa1XsqAvdnw6bcs7/dP3aGq+SmdfOLoh7i
         E76D5zw6eSGUPHBhAtOIM7xr80hPmTXBLsuanD4P+rtq4pq3PNZKEWqxFdgsbYvzyUVx
         EIHLENgXyc3UQwzx7+6Dfi7cxJ40Jfm5VEwEKsbmNBepOIiu3/jAqJyyr2qbvX/sc96G
         5p2n6rGeS4PFcQj689DX31436n5DB6WNwmcX6L25IgK1rld1qwOvsSMWoJMEAsv6OQQ8
         y/vA==
X-Gm-Message-State: AOAM533yC2AnoM/g9eLx33ZZCKIJpLhvY6AO1eMFaAcrKkcvig9rpLiw
        Dj/QXVPrYwDfV/EQSso4b5B5Gg==
X-Google-Smtp-Source: ABdhPJx6UgcW+UNHqi1soE/BIyhBzdbWrSlvz2f+AJjxo6tGbxRgXfr43Pew7zrdEGjiWWyR9zQoKw==
X-Received: by 2002:a05:6638:a2d:: with SMTP id 13mr28494972jao.12.1635871847575;
        Tue, 02 Nov 2021 09:50:47 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g17sm4870213iow.20.2021.11.02.09.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:50:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     nbd@other.debian.org, linux-block@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>, josef@toxicpanda.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20211102015237.2309763-1-yebin10@huawei.com>
References: <20211102015237.2309763-1-yebin10@huawei.com>
Subject: Re: [PATCH -next v4 0/4] Fix hungtask when nbd_config_put and sanity check for first_minor
Message-Id: <163587184699.364332.2099486260392695081.b4-ty@kernel.dk>
Date:   Tue, 02 Nov 2021 10:50:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2021 09:52:33 +0800, Ye Bin wrote:
> This patchset include two patchsets as follows:
> 1. Fix hungtask when nbd_config_put
> https://patchwork.kernel.org/project/linux-block/list/?series=573381
> 2. nbd: fix sanity check for first_minor
> https://lore.kernel.org/linux-block/20211021122936.758221-1-yukuai3@huawei.com/
> 
> I have consulted with Yu Kuai, and his modification has also been confirmed by him.
> 
> [...]

Applied, thanks!

[1/4] nbd: fix max value for 'first_minor'
      commit: e4c4871a73944353ea23e319de27ef73ce546623
[2/4] nbd: fix possible overflow for 'first_minor' in nbd_dev_add()
      commit: 940c264984fd1457918393c49674f6b39ee16506
[3/4] nbd: Fix incorrect error handle when first_minor is illegal in nbd_dev_add
      commit: 69beb62ff0d1723a750eebe1c4d01da573d7cd19
[4/4] nbd: Fix hungtask when nbd_config_put
      commit: e2daec488c57069a4a431d5b752f50294c4bf273

Best regards,
-- 
Jens Axboe


