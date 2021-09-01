Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA863FD115
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 04:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241465AbhIACJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 22:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhIACJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 22:09:55 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930BDC061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 19:08:59 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id j18so2098295ioj.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 19:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DqeBoaQQIFct7aXruk86G14fVVoUpCqFzdFy9Fwtbxo=;
        b=Ln8KBFTKu/EwP60d9NwTTLlmc00MdEHhCPT1G1xuuXYF5BA2N623plmgTdPOPmKn2g
         m/+EUuiSLohILFAGSWkXvTF3ZAESvwZblI5RmrEHR4vBFGLU3iwrPjbgP6RC8oClAGCH
         r47//zH/EFXjuAOrCJMPPijMq94tiJ+RtVtdAy4KiFjYiUqiOrF8ZHgCQ8hJwxUZbKUi
         nHfFnUca0YHMPum2KUSQLtVgamfgxzgHUAxuhlfU9emHUzWG/8RMH7FfKLx9FbreRSsL
         FUkdus4WyJQDQgK+5ZQIuAZw0oeOZOAHQIA6ibxwgM7PzH0p2U+TsT5pfXNHFW501VFv
         1AUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DqeBoaQQIFct7aXruk86G14fVVoUpCqFzdFy9Fwtbxo=;
        b=LgqivHnECseoWq09GzM+IPdnTt1Av9BftNJdW4btVAZnqr4DNAwmBbUrGr1VhS1Ktm
         rn3eyCDKZqzux8/DLlvLaVpyBPhCvhY7sCbbEX76cGBqY2ZSbL5Ij555O3BT5TuplF+0
         QXZFfx8Vs4WU3iKmPN12JSsdvnbHhG33171I14ZUPBOLOneqU8WNEIiEwsO/P5nDw4eY
         yahf94J7UNekr99MlaVCw+jJQWhxxdJdVFGSegK7cwlSgaH6JiWA6MdWfrA1wK5L69o4
         F+Vz6ddKhEmkkpmiYylz68emIHA4LX7UEIaTnhIgEVgqHXRhAmMzdz64CmQHXWRWrOBh
         x4Lg==
X-Gm-Message-State: AOAM530E6VxA/h3shlJI5ADiYyrivqDUOlfmDz/SNgqSHfELwjRjVx3k
        oL5LkHmC2pfcZjuLeV6KDnFgZoUq6fD5EQ==
X-Google-Smtp-Source: ABdhPJwxhRlKF+u8FjsMGNAIDMscjy1XsjogD3fS1Uy2gpoWEZhImf7652ITaiNZLotesVyJFqiqgw==
X-Received: by 2002:a6b:5819:: with SMTP id m25mr25003181iob.105.1630462138956;
        Tue, 31 Aug 2021 19:08:58 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id p12sm11045963ilp.87.2021.08.31.19.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 19:08:58 -0700 (PDT)
Subject: Re: [syzbot] general protection fault in __io_file_supports_nowait
To:     syzbot <syzbot+e51249708aaa9b0e4d2c@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000f1f81105cae56d48@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b4305afc-ff25-8388-1ba2-e761129a509a@kernel.dk>
Date:   Tue, 31 Aug 2021 20:08:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000f1f81105cae56d48@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/21 8:00 PM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    b91db6a0b52e Merge tag 'for-5.15/io_uring-vfs-2021-08-30' ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12718683300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=210537ff2ddcc232
> dashboard link: https://syzkaller.appspot.com/bug?extid=e51249708aaa9b0e4d2c
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12615c35300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c57845300000

#syz test git://git.kernel.dk/linux-block for-5.15/io_uring

-- 
Jens Axboe

