Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116A4402EFB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344964AbhIGTbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbhIGTbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:31:45 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0932C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:30:38 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id s16so193953ilo.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 12:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v0NXlxBTeEi3do2hDI3EUhz1rB97bKcDUu5e3uBm2y4=;
        b=CnN0grQMu2KtAdQbiFJTNYhIJ+Ziwuj3At2l8swhKX5m486ypX6krJngp/DyJcJ4Mq
         tSI/oCUhkRH0imlZqZ85/uQjS5zYVDO9b1hF6A0L2kUoMOyUzu5zB+6ttwQgszU95HuB
         2isjazjLBht+UNImG/0JdH2z/tVd/wttyKJOW3M3ulCWlTZ1oAeHk6SYUds0Zu17rbqi
         qV/wQ70K7Qqw5hJZWVZ0vwSrtG9hwfArhhzDBhBhU2eWu2nenTiVHPjD/99HK1IJaRAv
         tyAlo6FPwzxNwbMK0Mx6jLBc4jNm926+isFNTn7+5xfWFwyObMtiHJQFMiUO5HVM5QwF
         GKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v0NXlxBTeEi3do2hDI3EUhz1rB97bKcDUu5e3uBm2y4=;
        b=fJX0e2NyPcZZwAZK7TZJMutWy10Vl3JQxNjOthTnrWO3ldPnWYlefCAAqHRAkoSu3E
         MbKkvVI6AMieinJoN9GyQfl1amU1NEpM0Nkrl8jM87+5H2oT1+4JKk6cDBMc99ZnCW1Y
         5nJMkjU2182WxaGcggGMe10rqWG8ylijwyb8qAEb2VBjJjXRzdCHMNl8QaodYsmVbIXm
         PVMopCawxTye6SmijXvzp0fHC42OTYzn+KmAlGEB0u1s28mFGv+Q+n9ZyUCL2z9qx4KH
         lmMvDg3b67xiyorF21DB4LhpEgQJLaiyr+sKTtaxTNKaaRcSAzHw9FMru3h2kaOT45f7
         9UBw==
X-Gm-Message-State: AOAM5335Er27Juu3KWdkt5s3DGJlXICqcKcEfMYZsKRo0MeOHFbbFWLX
        hV8xlDJbXEvmkBvPh7lAmKT63jMBkd5Yfw==
X-Google-Smtp-Source: ABdhPJzbZ3DLMj14zw45tQBSXU9Qh7mT+TBcc4oI/+U2vT+tNOF2giUK60tTjS8fJRB0skLQSgy/0Q==
X-Received: by 2002:a92:d3cf:: with SMTP id c15mr13493524ilh.131.1631043037904;
        Tue, 07 Sep 2021 12:30:37 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r18sm6260ilo.38.2021.09.07.12.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 12:30:37 -0700 (PDT)
Subject: Re: INFO: task hung in io_uring_cancel_generic
To:     Hao Sun <sunhao.th@gmail.com>, io-uring@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org
References: <CACkBjsbs2tahJMC_TBZhQUBQiFYhLo-CW+kyzNxyUqgs5NCaXA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <df072429-3f45-4d9d-c81d-73174aaf2e7d@kernel.dk>
Date:   Tue, 7 Sep 2021 13:30:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACkBjsbs2tahJMC_TBZhQUBQiFYhLo-CW+kyzNxyUqgs5NCaXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 5:50 AM, Hao Sun wrote:
> Hello,
> 
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
> 
> HEAD commit: 7d2a07b76933 Linux 5.14
> git tree: upstream
> console output:
> https://drive.google.com/file/d/1c8uRooM0TwJiTIwEviOCB4RC-hhOgGHR/view?usp=sharing
> kernel config: https://drive.google.com/file/d/1XD9WYDViQLSXN7RGwH8AGGDvP9JvOghx/view?usp=sharing
> Similar report:
> https://groups.google.com/u/1/g/syzkaller-bugs/c/FvdcTiJIGtY/m/PcXkoenUAAAJ
> 
> Sorry, I don't have a reproducer for this crash, hope the symbolized
> report can help.
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>

Would be great with a reproducer for this one, though...

-- 
Jens Axboe

