Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3600A404289
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 03:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348782AbhIIBEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 21:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbhIIBEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 21:04:00 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42400C061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 18:02:52 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id q14so205848ils.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 18:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=joAYCX1s0NcXY5IBS4ka+uai7RV9dQVlQDCWgG50rTE=;
        b=jQ7eYXh1KKYMdtHX5nf+QWn0WGDG4Z68F36Q1ttYyl/Ookoqhnu6CZC4qdDnhbhKxR
         dDFCuxIABcSgK9MMzK+ioIKmmfL3YQt+HwNvfyeAq2d+2JkommTpMzaL/D87q/p9nnO3
         8HHlmLlUS+wkVDsMicsmgq9YBlx3J/orMUjtdb/tFi+Y8Qr2yQ7BjaM2m21ZmbdSyn9x
         Drn8I/FTBgVdU4Z5AO9jXgjRjBA8LOxq7147pjteW6gISOt+k0A14MgswF0zMlEg0Vxg
         ZO5eojgJAgMNJBCdTBLNxHVaR+8c9vxXn4DL0jtWfY1vAFlogf76Dq+iJtAuYqe2KjaJ
         4I7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=joAYCX1s0NcXY5IBS4ka+uai7RV9dQVlQDCWgG50rTE=;
        b=2RZmbENhbxHV+IQJz0ffoXhs2ir+2YP59ETdk+1OY9BKzdLXrWRGd/O01xGb6QgnIa
         iCvGof2cqkNmuJ0HWqh/xGe+Jwkt8E4Bz3w8X1xZDKBlatzTkyWaMttcuqTUUoUn5sAS
         WXqtQ5vxYym00wyuy1WupWm5hqcAisLjFNf+thYCrtsXZtDJ0hgJcYK7m9rd1J0yWX0z
         SVTJEaHqg+IJwsfzAJJR8hP/gZpvOIPG2fc5DP3QiHD49YbwNtGZ+olyYaFkwbRsmnuC
         mZhItTygPAmSplJ2mRY8OW+ql2d1eD9UCBl6TgLuWHlZsxJ+59RiCPXA8ViJ2qfuSa/h
         9Yaw==
X-Gm-Message-State: AOAM5328ApvtLxt6XdvXh1q1TErAhxFxFX2JwKyi1FzKpf/0KSfq4mo1
        1XH1zM/viayAF0thm6zDNUcd1w==
X-Google-Smtp-Source: ABdhPJzuT2OZan5656ISxnout+pffgegRJGaOlg40LZM3WBdTwu12LFimXp8kZdbJRtJZ6owe08g6g==
X-Received: by 2002:a92:1952:: with SMTP id e18mr225353ilm.291.1631149371425;
        Wed, 08 Sep 2021 18:02:51 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s7sm149077ioe.11.2021.09.08.18.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 18:02:50 -0700 (PDT)
Subject: Re: [syzbot] possible deadlock in io_sq_thread
To:     syzbot <syzbot+c9e7f2674197989e8afb@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000898c7405cb84d309@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <83d92328-0367-0115-7b17-deabcd3fddda@kernel.dk>
Date:   Wed, 8 Sep 2021 19:02:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000898c7405cb84d309@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/21 6:10 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a2b28235335f Merge branch 'dmi-for-linus' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=175ec47d300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f5102874b5591af7
> dashboard link: https://syzkaller.appspot.com/bug?extid=c9e7f2674197989e8afb
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

#syz dup: [syzbot] possible deadlock in io_uring_register

-- 
Jens Axboe

