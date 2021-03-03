Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBCD32C40B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381228AbhCDAKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449512AbhCCWvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 17:51:53 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BEFC061762
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 14:51:10 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id o11so19692148iob.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 14:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jkzaHDmTkBHODt1WjVbgPR48CKiEaxtUsO+VNZNhYrg=;
        b=ntt3x+/5daP2OHMLRkxesZxOn5fFMYhrAVnDEELfsLfjchH1bwaNvRb6a+5j23sPdH
         eoMwJzQa0VySN5WvrGKcunWxWJ0VlcXNpEkp14cq0IU+p/cdGEW0905qVkPLseEdeO6w
         nTig+SbDfWlJfcGlx13qtyahwexv94CMu+itWU7UBnQbgzlqKMAVBOtEEqib26qBCzjr
         R309t8UVXPOOi4S8Bu6lkDtbn0WZ1WQEOu2nyOZw9KHHTSIrxVfdFiIy5CMxgkOnwXcE
         kZyNmOeZb1BW+kFFsFUxs9TZNTeB4LFhlbmQN2uglFzmeH5oApt5uFvQot496kGoReL0
         b+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jkzaHDmTkBHODt1WjVbgPR48CKiEaxtUsO+VNZNhYrg=;
        b=gpbRP3MK+S9W9xjjAKR9XMrqZFWN+8NydliBf5mEuh6gHjSo17EV5pCOiUPRH1DMfO
         fPeRWt/4cNvCOTYV2c2LqXkGoKmcU8Qd8wPPjKcoRuqNIdONCih51Y4J+N1Z70LgTbhT
         QxvyLt17q17DN1xMp6XglRJicCTWQEPVkhsS0b8uBi/DPnylXnFdJB/xkxdPK012e9Nt
         UVe/RLJkLeICmYtcb5dhAjsUVEsyLQfgcTYgBXBnJFwyeABWK8N2ekormXhAxkq69iLL
         +HF6K3VqnhMKlh+tWU56N9LAehBtmOLNdUCyJQGz+GDGMp0yA7hvegc03PcO4B7dTGwA
         KnOA==
X-Gm-Message-State: AOAM5328+ZTDPVrybpS1wyU22c3/zi+zl4WyV9dXEO5Mpsnx40EHzUvB
        QKUqbET/xCpdDo6l2HCaPG4oVA==
X-Google-Smtp-Source: ABdhPJxcT/1+ki8D/dqM2vDVIGQ7Q7c9/G0PwbdOblR9vU7tZmdRZByv7K8+Rwqo1s7ZunQKRwELZA==
X-Received: by 2002:a02:a889:: with SMTP id l9mr1234532jam.1.1614811869882;
        Wed, 03 Mar 2021 14:51:09 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y18sm3170152ili.16.2021.03.03.14.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 14:51:09 -0800 (PST)
Subject: Re: memory leak in io_submit_sqes (2)
To:     syzbot <syzbot+91b4b56ead187d35c9d3@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000002261d05bca94f7b@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8494c673-180e-e0b9-4db7-04aed2aee791@kernel.dk>
Date:   Wed, 3 Mar 2021 15:51:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000002261d05bca94f7b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.dk/linux-block leak

-- 
Jens Axboe

