Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07080352B7E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 16:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbhDBOeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 10:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhDBOeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 10:34:06 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E56C061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 07:34:05 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id y17so4806004ila.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AjhyAVgGqryXaOV6wEyhg6s+f795iKTiiY0ZANnHEuI=;
        b=0+aP60MmXh/lyIkFPbC/qBTX2//RFk6NSzglhgEuuIW0z+OUXTJk+J8Qq0BSoTmZ8w
         9VDBHN/Jww8Ws9B7ocx072oB3refdGHZgHjXXfOpncXsqM0tdQBteyVeHdUo1bKuuyPU
         CxGmY38EsQ5xms7JuxpJhI3/4TQdBCFATKWE2nE68vSZmwTBRtO1Yb1Zq3uoBZ95D+Wt
         NIJAPl+NCUs7Qw191UACDqQ2zGmGOOT+6r3Pp20Oyh9EFQPcKpl3dzZlpfQry6sdlC5Y
         RSv36MfBmzRwXaFb55xTQPpXe8tTBR/msIR7/Od3WEgR7De9Us2f65Mj1d47ASe4OlmS
         WN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AjhyAVgGqryXaOV6wEyhg6s+f795iKTiiY0ZANnHEuI=;
        b=AGdVDJrkOCigH3Zmdbh495ELNArtZxWv0LumBo6W0xTHR+iA8ktNb5YQZV0OydnaKz
         BTkcGMVOwobxl1ckMzbnKpq6FWbuIP3vqbXGr7smTiAIz2IQRDQ5HGY8okx+RUFr34nr
         Ozt1wZdVcX1ehDbOAxZeXEAkf+285hFItnbCAQE9/HgyN3AipxHlx88UUc/LU4HCsBwF
         OdId0jrEIxEpw97UdBqu8sqtvSIle+jBX8ASEtU6BUcKdCLQpgRT72BPj2qaY+ZY/6Uh
         N2PpmxeN/Jp0pWWrx0A2L2rc/wWtUncacN9WSvhkTGcIwvHbeLK30V0JisndxcFU0xLL
         5fIQ==
X-Gm-Message-State: AOAM533Kfxp95DInhQaVGQq6/k5INdBeqFcGcuTV+NwIvXIIbHSTWTpa
        XK9pp9kfbEg3qVUtCHPf+ckQdSJ5/uZp/g==
X-Google-Smtp-Source: ABdhPJzNU0PkHrmtkKATLk7AzsZsYJSh7nSsorriwppzp/uRJhf4RxRg+sizqjI3CL575b056Nvd+Q==
X-Received: by 2002:a05:6e02:1522:: with SMTP id i2mr11132952ilu.252.1617374044096;
        Fri, 02 Apr 2021 07:34:04 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b9sm4586573iob.4.2021.04.02.07.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 07:34:03 -0700 (PDT)
Subject: Re: [PATCH] block: don't ignore REQ_NOWAIT for direct IO
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <546c66d26ae71abc151aa2074c3dd75ff5efb529.1605892141.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <76ea3635-f750-4628-cfa0-1659a3a9376b@kernel.dk>
Date:   Fri, 2 Apr 2021 08:34:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <546c66d26ae71abc151aa2074c3dd75ff5efb529.1605892141.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 10:10 AM, Pavel Begunkov wrote:
> io_uring's direct nowait requests end up waiting on io_schedule() in
> sbitmap, that's seems to be so because blkdev_direct_IO() fails to
> propagate IOCB_NOWAIT to a bio and hence to blk-mq.

Thanks, applied. This slipped through the cracks, and I didn't notice
until I went and directly tested some of this...

iomap suffers from the same issue, fwiw.

-- 
Jens Axboe

