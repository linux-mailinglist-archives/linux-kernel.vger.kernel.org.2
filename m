Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7824006BD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 22:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbhICUjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 16:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhICUjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 16:39:33 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E2BC061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 13:38:32 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t1so233415pgv.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 13:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SXA74MGGnpMLJBlBLFB2fo0p77PdPKeB7j4vWOpFbgA=;
        b=nw2VJup3MuIT3HYBDrxKERcfiBaDohh+oGekw2GnKIB3/5yL7SZsrrGJ+uxDCbsprl
         yArFwNdaf5aDJuBQ/5yveze8lPGExml2Y3ATqAD4i4H4u/AXXFJMnxw4ecUWgXc4b9aS
         k/YxZZW9iVXFN3LCyJutIc1C5PZKafRX/Oj1q6/d0cFSK0F5HvSdOrPg2b9EsSU+gr40
         BzOavNjXQMy8QmLjzMG/9+EeKPOzm3IAWSdFWLY5aSCQec3tJcsJOgB+n8lizV4t+vNU
         TUdREwSHFa7EXMo+dylFlSX8KumY2JrRowHRkTfH78sEY8jS89x1jd6cvOqqfR6TVTlo
         If6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SXA74MGGnpMLJBlBLFB2fo0p77PdPKeB7j4vWOpFbgA=;
        b=J7FHgJxJIygR112CzarYhT+z5NUBllj5tgInePoR4aAXOwpvKMnqcl0R72KYVF+Vz8
         JG1I+fhcFwFBKrEtDdpXGdGc8whh9O42MnwC0FSUpsOlD03xMIchETM1mKjJpMjJYjBL
         BaqxebWHp9BpE0xsu5sfSc6AgYqwh9alHIswFl7EyUkFBtTejo0yof+FrRr8WqZ2wGR5
         1RBHB3K9UqfyQ8cMi74Pssaz5kbIYF6htvnrA64Vym9Zksz+pKyFD5CeustomIaqDWSD
         xHn0FC+Z7/ykWbXlMLmhgZM1hse9/h/Ez+V1ZyPMkG7pf5UxH0lGfkcY+x4bi/dlui6E
         AEuQ==
X-Gm-Message-State: AOAM531awgGrkfsh08NJl/Bf7FZ2PtKunvwAta8LQ2vzpQy1y2ntO69y
        J/Eu0nDV4naZF1tqT2fSdbLLhwn6qB/oVA==
X-Google-Smtp-Source: ABdhPJweoVMMzL7tuqAQdffveXdXyK8C4wFxqZl/wW2SRRGmxbgZ8vmT7er7geuhYIAzmGP+N28/MA==
X-Received: by 2002:a05:6a00:16d2:b029:300:200b:6572 with SMTP id l18-20020a056a0016d2b0290300200b6572mr703225pfc.62.1630701511522;
        Fri, 03 Sep 2021 13:38:31 -0700 (PDT)
Received: from ?IPv6:2600:380:7567:4da9:ea68:953f:1224:2896? ([2600:380:7567:4da9:ea68:953f:1224:2896])
        by smtp.gmail.com with ESMTPSA id w17sm238691pfq.111.2021.09.03.13.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 13:38:31 -0700 (PDT)
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in
 kiocb_done
To:     syzbot <syzbot+726f2ce6dbbf2ad8d133@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000000d4da305cb1d2467@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5a93ff90-98be-b5af-29e9-a2f8cca82458@kernel.dk>
Date:   Fri, 3 Sep 2021 14:38:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0000000000000d4da305cb1d2467@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/21 2:28 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4ac6d90867a4 Merge tag 'docs-5.15' of git://git.lwn.net/li..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a275f5300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3c3a5498e99259cf
> dashboard link: https://syzkaller.appspot.com/bug?extid=726f2ce6dbbf2ad8d133
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124a3b49300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142e610b300000

#syz test git://git.kernel.dk/linux-block for-5.15/io_uring

-- 
Jens Axboe

