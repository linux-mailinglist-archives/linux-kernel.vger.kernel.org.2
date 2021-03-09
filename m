Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2763331E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 00:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhCIXeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 18:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhCIXeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 18:34:36 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38ADC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 15:34:35 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id e6so10099267pgk.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 15:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MIMPh+SXeRfQ61lkDNTW++4hYt6RRQoL+XmybnY7RLs=;
        b=jiSiFglQmxZEJ5Wo/V77lv2N41tEqlwbI7v3epkgItw5xYfXGxlauBpw9uzfeKRy9T
         UgWtMw/oXm8AuRgak2BKRl5XhK5zcUO2837WG2rF2W8MM8EvE6UpNPAWncenkj0VYlKH
         Wn+42kDb50QvRqsESQ2mom+sK8P9ZkVKhJUlfw17R8MaXfwzjUrcUKKhMatHk8l1n8z6
         HORyhRzzkFREwaIywpdXqw9NNouEzJ8obgGp95ES0SB4Z7kZ2Uf5tkrCu65jYV/wXqtc
         UCWEZCt7cJx4Cy1bJj+/BoOSmvIjqkxbeU85OG1e7JJ+tuq+pIzZNNEJVKCnsblb6lrn
         0mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MIMPh+SXeRfQ61lkDNTW++4hYt6RRQoL+XmybnY7RLs=;
        b=JTlnE8v4siCk6dFMbXBBszG1//LOSEF2/Wr3NZRE0j13qeMJHtSTNS8UUZRJiAfRnZ
         PzJd8bprdZ34/euGrXfy54oDF6w5QxCPLI81qdjPkYfu3PjbjQixI1ews1sXO5+h8IUL
         b27ECs4jI5r4/isRrWe0Bb2SbSFOPKkcZaG5iVVPd77E0kXkxPglaW6Q122CIwyvtTzX
         JavUUhH6xViGBU0cAyTaCM5piJbxLaVcVFG0UfYJjnyTjPpz0YcAWcnBrjkoqjVP8JUq
         fGtxx5RHmxT7QunV4wmIi8Ai5Fp961MR9NdejVT6xrwWQ2JBtyhHrdbLRAjJEPE/qYks
         yGKQ==
X-Gm-Message-State: AOAM532VMGj6wMNAl591M+7q0PbzorgqrmsULXQNmr/MB8c9m10HQh+n
        oWLFFrgtyjIsqzN5XTwMqRY80Q==
X-Google-Smtp-Source: ABdhPJzfKS6kURnpgZPykAhAOJiKpUELYKYWDREb1RpAet6KiUSXO4LXfgtQd3YCjbxFWOuA+4TjfA==
X-Received: by 2002:a63:1946:: with SMTP id 6mr175679pgz.359.1615332875151;
        Tue, 09 Mar 2021 15:34:35 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y68sm15546218pgy.5.2021.03.09.15.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 15:34:34 -0800 (PST)
Subject: Re: [syzbot] possible deadlock in io_sq_thread_finish
To:     syzbot <syzbot+ac39856cb1b332dbbdda@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000023b36405bd221483@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <179d05df-3c1f-1609-b941-a737f8fb13e0@kernel.dk>
Date:   Tue, 9 Mar 2021 16:34:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000023b36405bd221483@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.dk/linux-block io_uring-5.12

-- 
Jens Axboe

