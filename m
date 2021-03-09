Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4D933320B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 00:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhCIXpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 18:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhCIXpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 18:45:07 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E1DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 15:45:06 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id l7so10812214pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 15:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MIMPh+SXeRfQ61lkDNTW++4hYt6RRQoL+XmybnY7RLs=;
        b=I+YpJYhj2EeUSjKGcgIJVq8/oUTSiAwvwpzZ6eKYyX100iHQrRlylnHdPqLCigRZ2b
         0IrBclRUcKp55ul/SBpHyHl/X9j4NWK2EdbbcL/igCx8+i60ZywQsUXBlodPBHEAKRfT
         8s9q0SDHKU7rAzlXFRYeIZCAP+8QryVFdLZjvMAENZjn57OeksCoUuHYvDDnEWKommIt
         7x8qKCF+BGiWbuSVEbyAZwi9BIT+LuGY3S8rcWcUsU79kej9oVDsBkWlb7ZezIz8VaMN
         Mf0s3X574Viwzi7/v4lNDF3icsJJlvLxVVApUMyfppG181yVsPqPCYn93UekMMirCGeY
         d/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MIMPh+SXeRfQ61lkDNTW++4hYt6RRQoL+XmybnY7RLs=;
        b=K7VjjFU5f2tMKfmHsJvb+FPSl6LjnQAfhtlv3VDUGcgCOolk83u9MNuMl578UYH9m2
         Fs6UUn+Fn5ilJ4m3ScbgLaF6f15QSGJDN/mlCLz9fz4wMfxpsAofu9BU+9upUhtok3ia
         V6Ge1iMDwxg/RiNg7o4GCsaH0ItsfWJ/Kh4HfYO1dS8AIVdXuJq1Ra3TwK6gHaQzMQf+
         SU9pVbq5HTZP337H8H4bEUA+20fCy6EPSZugFeOHh5nH76Y4t1o4/7eVCKMW310Hm6p6
         rOXiiFrJxXu20V8Pmyr1LxI151U13dk5xgoN7dAZcPCsNPSdmAp6E/vlu0UjQekxQyO6
         xKoQ==
X-Gm-Message-State: AOAM531vfRzUQCkTtQbaEqJ8UccmtNPQoWJAryGd3gOvmk5Swd47VNmU
        jkOnOePjvyGx/h5JAe6ub7occg==
X-Google-Smtp-Source: ABdhPJy9cVefkbidAY/7W1zyfzpv/TtxvoNhA7a4MjDNqx1uxbugQv26rNzUtMCMHzXPxLggLpuolw==
X-Received: by 2002:a62:1d06:0:b029:1fb:94fb:4940 with SMTP id d6-20020a621d060000b02901fb94fb4940mr564306pfd.6.1615333506387;
        Tue, 09 Mar 2021 15:45:06 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id js16sm3880010pjb.21.2021.03.09.15.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 15:45:05 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] possible deadlock in io_sq_thread_finish
To:     syzbot <syzbot+ac39856cb1b332dbbdda@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000023b36405bd221483@google.com>
Message-ID: <7dff5f11-817d-228a-5623-1df17b05402b@kernel.dk>
Date:   Tue, 9 Mar 2021 16:45:04 -0700
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

