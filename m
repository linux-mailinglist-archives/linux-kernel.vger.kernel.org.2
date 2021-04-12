Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5557335B9C5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 07:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhDLFPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 01:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhDLFPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 01:15:05 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76869C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 22:14:48 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so11700329otb.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 22:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kyfCrPJsGOPHeYAHRBpmqkFCyszA/k+gL/paXOUfjJ8=;
        b=AQK3qXaFsnZNNx3qX4YDIFdybx8KeeBYrj4thSnuoAJxk+MHQDuNJBHZr6saGRYOOK
         j68tce7vfVDhqJuNCqliJdnS9YydL5R0uCZ8HT/+u4A/HPaGrFaQBUFOo8FUECRZBHD7
         NW2fBUAJ0bXMfurdZGnEuRcyejA/hcSLGob/aqUhYpGg/kIYOqBw7tPDvZfK/qiNKNC8
         QxRZPfEEnCGmEssFZ1Fd1y+5o4zhj3A0Yu/wZc43wO/7FmObOHUBakRHfIw3KrOhiM41
         aLs3yxSUV6iFIxLW80WCBxHz5hOkdM7Asf6HjPSobs1XZQiD4ZMl42bvVtCqhUzi4hSE
         8WgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kyfCrPJsGOPHeYAHRBpmqkFCyszA/k+gL/paXOUfjJ8=;
        b=d1MS6lXQ7dBeog35EoS+KdUTqIPPL/LQgAgLi9HQKW22EQNndDNcyk6qEIPl+1JuPg
         it7UerAcUbVgs/egzy25wLj9M+KLW9skGjnEkctn5kbVRYDqnt3m+d1LhxunXF4XLpox
         +2TaoszF880PJuOCTE9RbfaYlPtWXtyH2W4CnCvRRZSgeUJTlqWJtoE3S/6NN/UWn1tW
         5zM8qt0LmO8l50kotoXPNJtU4/HclGWlj8SLeVklTverMYrIl1oZeP+rVGP8jBiN0Ubh
         Tf+RvCVWuuR2Uv0DuE+tSnduOc8KF54PqXiB9fSzK3OUjT9joaUsBRQlvB4yps0sM6Za
         faMQ==
X-Gm-Message-State: AOAM532EIZHc3d9iW1w3PZmnLGB136cRiU7PivKC6erYpQ4NTEbzQ61H
        UTp2VWh5ZOQooYnF6Uj7Syc=
X-Google-Smtp-Source: ABdhPJy5RRYsCiinsxKkjKqUAJvixU69jANHNRbuHmdHfxL8qAD45p8qqZLdQCbtuVrNdY6VHnEIHA==
X-Received: by 2002:a9d:7d91:: with SMTP id j17mr14518754otn.135.1618204487907;
        Sun, 11 Apr 2021 22:14:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w1sm1819302otq.75.2021.04.11.22.14.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Apr 2021 22:14:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 11 Apr 2021 22:14:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: Linux 5.12-rc7
Message-ID: <20210412051445.GA47322@roeck-us.net>
References: <CAHk-=wiHGchP=V=a4DbDN+imjGEc=2nvuLQVoeNXNxjpU1T8pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiHGchP=V=a4DbDN+imjGEc=2nvuLQVoeNXNxjpU1T8pg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 03:41:18PM -0700, Linus Torvalds wrote:
> Oh well. rc5 was big. rc6 was small. And now rc7 is big again. In
> fact, it's the biggest rc7 (at least in number of commits) we've had
> in the 5.x series.
> 
> It's mostly due to networking fixes (of which rc6 had none), and none
> of them should be all that scary, but it's never great when we have
> such a big rc. It's particularly annoying at the end of the release
> window like this.
> 
> End result: I'm still waffling about the final 5.12 release.  The fact
> that we have a big rc7 does make me think that I'll probably do an rc8
> this time around. But it ends up depending a bit on how the upcoming
> week goes, and if things are deathly quiet, I may end up deciding that
> an rc8 doesn't really make sense.
> 
> So we'll see.
> 
> Anyway, networking (both core and drivers) is over half of the rc7
> patch, with the rest being a fairly random collection of fixes all
> over. We've got other driver updates (sound, rdma, scsi, usb..) some
> fs fixes (io_uring, umount, btrfs, cifs, ocfs), minor arch fixes (arc,
> arm, parisc, powerpc, s390, x86), and other misc fixes.
> 
> The shortlog is appended, although it's obviously not as nice and
> small and readable as I'd have liked at this point in the release..
> 
> Please do test,
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 460 pass: 459 fail: 1
Failed tests:
	sh:rts7751r2dplus_defconfig:ata:net,virtio-net:rootfs

The failure bisects to commit 0f6925b3e8da ("virtio_net: Do not pull payload in
skb->head"). It is a spurious problem - the test passes roughly every other
time. When the failure is seen, udhcpc fails to get an IP address and aborts
with SIGTERM. So far I have only seen this with the "sh" architecture.

Guenter
