Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F6E332961
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhCIO57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhCIO5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:57:45 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64607C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:57:45 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n14so14230681iog.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=K7+iO48PWOP9c51Z9qgh5xFNA9ow1h0cDCkNzxCzG0o=;
        b=NHs5vSl3YWLN821O6OO5C7BadTSOQw9OUgvViXPiNqrQelVGJhrsxbxc2UiRDWwyq8
         ND07ZR7Fd5z1nnf2CCHhmcdDMLqIzZHrPIDZYA9Vc/8gtSMgL+HCAWWEen1ye6+CtVSx
         pDTiSaWGut2OggyVjvs1ETnDYoFUkE7YrTwl4JoJFRHhqoUHHgjoMbc+yr0f8m4aW2Ly
         L0r0wHt59dN3MhTdPrwlp890GHQhYtJBOXRH9RxHeUaFi6njLdoTTxQe0Y8tyiI3JEcj
         lX6ZUSnhfNWniqXpBeWp6yqcqrlkxoE20pQuXIIBuDQd2DlJbzozW5hoPUJT8/D7zoGt
         Tl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K7+iO48PWOP9c51Z9qgh5xFNA9ow1h0cDCkNzxCzG0o=;
        b=hVlTmtyMF8IGJFR+1fPGpliYWfZNZ3Up77tPJmv5a1s9/9k37vNHbnpeQzcH0ZVcGT
         VF2sjImr00CIFWJhSGeeaCnAjvE1+XlHkS4XSf1s/3VGzQj2OpOnUIwQ8GisjqhV5+cV
         VU4NV/H7W0FLzrCJjkfI/BDryo7CU/cBYueQz2v1dtAtDPQXubiSIkmgmSI8m18kfD8z
         +hd9W+LJ9UPlDnUyV75D2N5qqsckU3SKn+LSKmCqpFszYfpCXyB2dc6joEDizoMsuqi3
         DPIuf+nP3q9ci/rhljTbZEZ2mXj96Ho2KwyM6ZO1SHQkfwdqV2FEQy6ugkLkx9NjRZ4g
         TOSw==
X-Gm-Message-State: AOAM531eNsiMdNm/F6hvr/pvoRwsTUdofp3jRvWsaRLO0ZwcBqdRyho6
        FZ8gEF2XiMxkuFwKR9cQ3+XlVg==
X-Google-Smtp-Source: ABdhPJyAB+1dwZZI/BMn10m+Lu82RyrFzMdTZ9bbt1b6Nj7mBhJ4IH+XLO0GUwuQeuUA78hdQGsXOQ==
X-Received: by 2002:a05:6638:1390:: with SMTP id w16mr29062380jad.83.1615301864809;
        Tue, 09 Mar 2021 06:57:44 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s8sm7496397ilv.76.2021.03.09.06.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 06:57:44 -0800 (PST)
Subject: Re: [syzbot] possible deadlock in io_sq_thread_finish
To:     syzbot <syzbot+ac39856cb1b332dbbdda@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000b71e9605bd1b064f@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5112d102-d849-c640-868f-ee820163d02e@kernel.dk>
Date:   Tue, 9 Mar 2021 07:57:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000b71e9605bd1b064f@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 7:04 AM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    144c79ef Merge tag 'perf-tools-fixes-for-v5.12-2020-03-07'..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=129addbcd00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=db9c6adb4986f2f2
> dashboard link: https://syzkaller.appspot.com/bug?extid=ac39856cb1b332dbbdda
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167574dad00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c8f566d00000

#syz test: git://git.kernel.dk/linux-block io_uring-5.12

-- 
Jens Axboe

