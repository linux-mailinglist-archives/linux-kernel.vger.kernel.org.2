Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BBB39BCF0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhFDQWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:22:55 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:36561 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhFDQWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:22:54 -0400
Received: by mail-pj1-f52.google.com with SMTP id d5-20020a17090ab305b02901675357c371so7392975pjr.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Vpl5DauNuxvsmRJdt4Nmv/jEj0SVLIWOqqaV6/2qVpQ=;
        b=HnbVBjstJoz3eByCKCPqD4s0v8IhJIP8k1pUQUL7KMGCKEiZpxR+dTkW2WYx8ewSrj
         T2N4eojiD2eu4qtY4ey65CZ/gDkGC5oF6+AciY9ZfeRI1ywVDiWiHaN0gK9W5v1ry1Ba
         tdg/Hz0mE4HIc8DpmXru9EWnjKABqWdXiBu5y2j/NGEHgGd3pwPU/ofrFbzpxxjB+Buo
         FdARHl6ijmur1G/4g96uwwcBgyqFckAnnCAUXZyvm2BHD8AzFyIFMGFhDeoN5mh9Emch
         63x5/yI9qOtdCG/DQ4nS51Trp1/iyqI3ekrQbnbRYNeYWOugKc67l7rGyE03TDpeE+ZS
         EaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Vpl5DauNuxvsmRJdt4Nmv/jEj0SVLIWOqqaV6/2qVpQ=;
        b=nOFdjlkzJ2E3JdB4E58IwF+6S4//SsX2+RF2/RrQYwRnK0FCe15qunDJMU62mFTcoN
         oStd815mGGd8qyBSen15bQrnYgB8WbH96AoboM5vhUsrAwlcXHIkPEG/7wT1xm9n5E8a
         a/jr88EQXGlZuQ8GtXjfuqeUvPvrqg2yYc85fzyxBBw8nyYmaAqfHxOJW21LOU12rLLJ
         Et88K/FL9juI/3abOrUNJpGMWeF49A3bdUxk07COp6NyXj4dswX+XuLJbmIM9SVe8Ngg
         PHyr9EDfGGnYknbVA4NK+QCEs0Se9Xe22HtT8r1kG1opoB17DmO+mGplfK+qLEXiuP4X
         9Sog==
X-Gm-Message-State: AOAM533+yKHU8odT+RDmft9aHmgUAgoWodnrSOYfXViVZQ8yQWTe68XM
        Wuv/39zfaZU3Knj5HFruSFupvA==
X-Google-Smtp-Source: ABdhPJyco87jjGkn4Aw8Z4TnYyem/s1TOCbVFW3+1vHXJGxD3HCn7nhj6G2/0wKOHKzRmJicdJvcVA==
X-Received: by 2002:a17:902:d50f:b029:10c:85d:6ae8 with SMTP id b15-20020a170902d50fb029010c085d6ae8mr4942836plg.56.1622823594171;
        Fri, 04 Jun 2021 09:19:54 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g22sm2071496pfv.123.2021.06.04.09.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 09:19:53 -0700 (PDT)
Date:   Fri, 04 Jun 2021 09:19:53 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Jun 2021 09:19:51 PDT (-0700)
Subject:     Re: [PATCH 0/1] riscv: better network performance with memcpy, uaccess
In-Reply-To: <CACuRN0NjftJDUAsF2pkXbx0jnJ=bba9+j-hJA8Mjj0r4RVicLA@mail.gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        gary@garyguo.net, nickhu@andestech.com, nylon7@andestech.com,
        akira.tsukamoto@gmail.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     akira.tsukamoto@gmail.com
Message-ID: <mhng-a3a53753-73e5-4676-93d3-33c4b8760283@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jun 2021 02:53:33 PDT (-0700), akira.tsukamoto@gmail.com wrote:
> I am adding a cover letter to explain the history and details since
> improvement is a combination with Gary's memcpy patch [1].
>
> Comparison of iperf3 benchmark results by applying Gary's memcpy patch and
> my uaccess optimization patch. All results are from the same base kernel,
> same rootfs and save BeagleV beta board.
>
> First left column : beaglev 5.13.rc4 kernel [2]
> Second column     : Added Palmer's memcpy in C + my uaccess patch [3]
> Third column      : Added Gary's memcpy + my uaccess patch [4]
>
> --- TCP recv ---
> 686 Mbits/sec  |  700 Mbits/sec  |  904 Mbits/sec
> 683 Mbits/sec  |  701 Mbits/sec  |  898 Mbits/sec
> 695 Mbits/sec  |  702 Mbits/sec  |  905 Mbits/sec
>
> --- TCP send ---
> 383 Mbits/sec  |  390 Mbits/sec  |  393 Mbits/sec
> 384 Mbits/sec  |  393 Mbits/sec  |  392 Mbits/sec
>
> --- UDP send ---
> 307 Mbits/sec  |  358 Mbits/sec  |  402 Mbits/sec
> 307 Mbits/sec  |  359 Mbits/sec  |  402 Mbits/sec
>
> --- UDP recv ---
> 630 Mbits/sec  |  799 Mbits/sec  |  875 Mbits/sec
> 730 Mbits/sec  |  796 Mbits/sec  |  873 Mbits/sec
>
>
> The uaccess patch is reducing pipeline stall of read after write (RAW)
> by unroling load and store.
> The main reason for using assembler inside uaccess.S is because the
> __asm_to/copy_from_user() handling page fault must be done manually inside
> the functions.
>
> The above result is combination from Gary $B!G (Bs memcpy speeding up
> by reducing
> the S-mode and M-mode switching and my uaccess reducing pipeline stall for
> user space uses syscall with large data.
>
> We had a discussion of improving network performance on the BeagleV beta
> board with Palmer.
>
> Palmer suggested to use C-based string routines, which checks the unaligned
> address and use 8 bytes aligned copy if the both src and dest are aligned
> and if not use the current copy function.
>
> The Gary's assembly version of memcpy is improving by not using unaligned
> access in 64 bit boundary, uses shifting it after reading with offset of
> aligned access, because every misaligned access is trapped and switches to
> opensbi in M-mode. The main speed up is coming from avoiding S-mode (kernel)
> and M-mode (opensbi) switching.
>
> Processing network packets require a lot of unaligned access for the packet
> header, which is not able to change the design of the header format to be
> aligned.
> And user applications pass large packet data with send/recf() and sendto/
> recvfrom() to repeat less function calls for reading and writing data for the
> optimization.

Makes sense.  I'm still not opposed to moving to a C version, but it'd 
need to be a fairly complicated one.  I think having a fast C memcpy 
would likely benefit a handful of architectures, as everything we're 
talking about is an algorithmic improvement that can be expressed in C.

Given that the simple memcpy doesn't perform well for your workload, I'm 
fine taking the assembly version.

Thanks!

>
> Akira
>
> [1] https://lkml.org/lkml/2021/2/16/778
> [2] https://github.com/mcd500/linux-jh7100/tree/starlight-sdimproved
> [3] https://github.com/mcd500/linux-jh7100/tree/starlight-sd-palmer-string
> [4] https://github.com/mcd500/linux-jh7100/tree/starlight-sd-gary
>
> Akira Tsukamoto (1):
>   riscv: prevent pipeline stall in __asm_to/copy_from_user
>
>  arch/riscv/lib/uaccess.S | 106 +++++++++++++++++++++++++++------------
>  1 file changed, 73 insertions(+), 33 deletions(-)
