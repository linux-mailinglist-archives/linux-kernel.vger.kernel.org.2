Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A045C347922
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhCXM6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbhCXM6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:58:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E46C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:58:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j25so17256043pfe.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7nSXLa0g4vdV8/W+gRepcbbFbJlq08ZTsV+Xug3aA4s=;
        b=aw6tknWNgO6BmFU7+3w3hHNXz/DW4bxRF9dkU8+QTFcwB/We2rUb4EAflmRJQMof5b
         dPM18ozI0XDuj7jTSu2dHCVjTHHkJsDqpNrUiC6zwCmWje/xd1FyqGHjDopeUffKHR+s
         jrWeGw3u4CEpIJirg+PCyfJ1bI1KcJvcW85/VulPCemLZsULXWvJfFc9D/MHCCAwhz/j
         imN7X5xfhaWuUnsQkrMaFSyLXZst8eYTgxxZ7yrt/JfNQKGfhzdtG1j8iDpUdH0C4OGC
         qH8ATONV75P15OldfTAuLUp0vQhab8Xtz9R65DkH+no6kGtiv19cw9DmGwgM2Z6iAxv2
         /hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7nSXLa0g4vdV8/W+gRepcbbFbJlq08ZTsV+Xug3aA4s=;
        b=k3K6u+pc4iXGG6bqwg3VM42jIAPUGyYKZ5cPs23lOFRRYu7lCjTh2sWygYYKtZCF9W
         5UPvAcDMtCFgLF1WCmID56S66+iG3lq4DcsbQSZVeyftZPwWjMn9h9VSwgbRZD/tn6Il
         6rD8MiVYQKux+r3FVyNl1su31nEJwut7+r6rAtPJ2Rbg7ZT3bVxoRRWKFcSmgChW/puY
         tmVD/+aSRVDw77+v9O2h8CxvvoPJxmidlqS8IqAzXtPyzLNdslurS7iqgKgcZXs/E8tb
         TOiexodmDpvgMCbmT31SH2cM7/bxjSXhFIIr0Xa4JszsTSO4RduuI1AajYloDLmS6lJU
         i3/g==
X-Gm-Message-State: AOAM533h9ukqqRjx4KTCaJIfP8Uvm5WTSOPNtNpb7DaJLqoNhWjklAkI
        olXe9k/7C4sihuE35piDIvo6Ssr42ckXDg==
X-Google-Smtp-Source: ABdhPJwpGeN2T5LtbiDg8g8v70tn9qDxiWZvdMTlcMYpWXGZfHom+RikYLm7E0qSV24l5h7cMsVkYg==
X-Received: by 2002:aa7:96f0:0:b029:1f3:97a4:19d2 with SMTP id i16-20020aa796f00000b02901f397a419d2mr2808767pfq.73.1616590687184;
        Wed, 24 Mar 2021 05:58:07 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 27sm2505726pgq.51.2021.03.24.05.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 05:58:06 -0700 (PDT)
Subject: Re: [PATCH] drivers/block: Goodbye BLK_DEV_UMEM
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dbueso@suse.de, hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <0d26434e-36e2-58f2-16b4-ef0fa4292c6e@kernel.dk>
 <20210323190710.101888-1-dave@stgolabs.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f6626a2-863c-06d9-836f-2c837494c2ce@kernel.dk>
Date:   Wed, 24 Mar 2021 06:58:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323190710.101888-1-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 1:07 PM, Davidlohr Bueso wrote:
> This removes the driver on the premise that it has been unused for a long
> time. This is a better approach compared to changing untestable code nobody
> cares about in the first place. Similarly, the umem.com website now shows a
> mere Godaddy parking add.

Applied, thanks.

-- 
Jens Axboe

