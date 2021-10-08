Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F1D426F0A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhJHQe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhJHQez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:34:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B5FC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 09:32:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id oa6-20020a17090b1bc600b0019ffc4b9c51so9722376pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=j/UInhLXe5mlM7rteqwC/6s2Q/4eFtXSAyDdkf0O+60=;
        b=LKcuYNXPdyw5ZE+YG4PyBWP0yMUlcInPZsgVGrp1+nAV1bnF9nYJIySBE40kMOQXCk
         96b8IPDhKw3VZXqQIXIGIxSP+iFS2yamQa/nEhlYWz8nbvaMUI8zDh+D/tqn+ArBS6VF
         eGYboqEF82M2BsV1yJab8yOoQ7IS8d15NPpQk26LGRJeMwbb90u60KEbtXsX9YkeSIr5
         xUYFARBO8KghAkky0RR/jUjwSF1SKh4v3msD2vYJnjewS6u5PGTVsFPCzfvPXxdzTYZV
         q/yz/2pN1f7tJBJI6Ig+tFmR+FQy94maCnxU1+emwDVwpXCaBK/zcNp0VoIu374OcteH
         3oSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=j/UInhLXe5mlM7rteqwC/6s2Q/4eFtXSAyDdkf0O+60=;
        b=mH39y6aJDuxIVlsmNp5H9nvBuUcNKBbi/LBoEbYeeuB/coVswhw/D8zkANQXwMuAKZ
         ncyvFb1BF5//RPi/YkLTRrgIThLGlAURoTRefOlyWnRqRuGK6T297LKHEuP5nnDKkGHB
         mzhvLPqVWhDcyjWvsNAUL8UJHzU18TE618p3cYe3TghorYqyqwXp2Ou7qWMuRjDx27bX
         ZWDf3Nqvi5U/AXQVED+zfleQFtxQYqIWuhj9LOo5/kXm9MUf/BeY1tP8XORXSj4h1PsC
         alsF0RGwxQxLPf8/h9ptkqhR5yOsILwQnrOkM93XdkamPgkQy/Kbz0ZASG/ry5RvJ1Bd
         wECg==
X-Gm-Message-State: AOAM530zixB467a/y1qBdQVwJLNrtkF0sy+NV1k1T4AweH3HOtrPUslL
        r2ksi9qi5ntk1gvwIMIxUX/eMg==
X-Google-Smtp-Source: ABdhPJxQDmvqcyL8uSDKq9Bj5xVKERTGbteUzbcVv5ha6IQ4H4v8O5xyKkLKpbl3mjTFmp/AeEwYtA==
X-Received: by 2002:a17:90b:1642:: with SMTP id il2mr12733836pjb.167.1633710779148;
        Fri, 08 Oct 2021 09:32:59 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x35sm3841084pfh.52.2021.10.08.09.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 09:32:58 -0700 (PDT)
Date:   Fri, 08 Oct 2021 09:32:58 -0700 (PDT)
X-Google-Original-Date: Fri, 08 Oct 2021 09:32:55 PDT (-0700)
Subject:     Re: [PATCH] tools/memory-model: Provide extra ordering for unlock+lock pair on the same CPU
In-Reply-To: <YV/rH0TeokccdbMD@boqun-archlinux>
CC:     mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, Daniel Lustig <dlustig@nvidia.com>,
        will@kernel.org, peterz@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        parri.andrea@gmail.com, mingo@kernel.org, vincent.weaver@maine.edu,
        tglx@linutronix.de, jolsa@redhat.com, acme@redhat.com,
        eranian@google.com, Paul Walmsley <paul.walmsley@sifive.com>,
        stern@rowland.harvard.edu, linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     boqun.feng@gmail.com
Message-ID: <mhng-9504267b-2dee-4c16-b7a5-4c4360066b5e@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Oct 2021 23:54:23 PDT (-0700), boqun.feng@gmail.com wrote:
> On Fri, Oct 08, 2021 at 04:30:37PM +1100, Michael Ellerman wrote:
>> Boqun Feng <boqun.feng@gmail.com> writes:
>> > (Add linux-arch in Cc list)
>> >
>> > Architecture maintainers, this patch is about strengthening our memory
>> > model a little bit, your inputs (confirmation, ack/nack, etc.) are
>> > appreciated.
>>
>> Hi Boqun,
>>
>> I don't feel like I'm really qualified to give an ack here, you and the
>> other memory model folk know this stuff much better than me.
>>
>> But I have reviewed it and it matches my understanding of how our
>> barriers work, so it looks OK to me.
>>
>> Reviewed-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

I'm basically in the same spot.  I think I said something to that effect 
somewhere in the thread, but I'm not sure if it got picked up so

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com> (RISC-V)

(I don't feel comfortable reviewing it so I'm acking it, not sure if I'm 
just backwards about what all this means though ;)).

IIUC this change will mean the RISC-V port is broken, but I'm happy to 
fix it.  Were you guys trying to target this for 5.16?
