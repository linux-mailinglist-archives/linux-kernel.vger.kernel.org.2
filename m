Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA143771AF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 14:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhEHM1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 08:27:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55470 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhEHM1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 08:27:38 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620476795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kx3itcBh5bmvjR+cUMbnARdy9x4AqAuYlijs5gThVpY=;
        b=CP8vQBTgguVuYcT9FMUlZt5qmDQ8uiRkoEn04X5N8+V6EnC/cBJuVW9MFB/t9TZ0pj3e0y
        7dx9Kaxm++dX+OshSenWsL9nyfJAK4XtfyU2J1oWBKP6Pe930MgavDm5KvMCRYzU6u8iye
        a93uNft0TmKo/j3CC0WwJVGTPngaVLPdcM+nDQEUlvu8y/PvmO8YlylHnM8lWOe8SfkL+G
        zwSE9buEzpB2rucQzcQNcz5qSjQPBGhXIy5am2qGBI5eWfZM5EVAyLRn1pTQqPCpFSqWtJ
        7QAhUm0QnwDs2ApMF70PVfzkrmuW1KfsUZUkMx2TU5liw18zAgysAHxWEI00ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620476795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kx3itcBh5bmvjR+cUMbnARdy9x4AqAuYlijs5gThVpY=;
        b=JeexpvwmSNy08L3nUg6D4BMN9tCEhZZ7o1YbMgFtelRUsgx2XNW+fPJDONXgqvIVvcH6RJ
        VNrlaoQd6Ec3+rDQ==
To:     xuyihang <xuyihang@huawei.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, minlei@redhat.com,
        liaochang1@huawei.com
Subject: Re: Virtio-scsi multiqueue irq affinity
In-Reply-To: <0f6c8a5f-ad33-1199-f313-53fe9187a672@huawei.com>
References: <20190318062150.GC6654@xz-x1> <alpine.DEB.2.21.1903231805310.1798@nanos.tec.linutronix.de> <20190325050213.GH9149@xz-x1> <20190325070616.GA9642@ming.t460p> <alpine.DEB.2.21.1903250948490.1798@nanos.tec.linutronix.de> <20190325095011.GA23225@ming.t460p> <0f6c8a5f-ad33-1199-f313-53fe9187a672@huawei.com>
Date:   Sat, 08 May 2021 14:26:35 +0200
Message-ID: <87zgx5l8ck.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yihang,

On Sat, May 08 2021 at 15:52, xuyihang wrote:
>
> We are dealing with a scenario which may need to assign a default 
> irqaffinity for managed IRQ.
> 
> Assume we have a full CPU usage RT thread running binded to a specific
> CPU.
>
> In the mean while, interrupt handler registered by a device which is
> ksoftirqd may never have a chance to run. (And we don't want to use
> isolate CPU)

A device cannot register and interrupt handler in ksoftirqd.

> There could be a couple way to deal with this problem:
>
> 1. Adjust priority of ksoftirqd or RT thread, so the interrupt handler 
> could preempt
>
> RT thread. However, I am not sure whether it could have some side 
> effects or not.
>
> 2. Adjust interrupt CPU affinity or RT thread affinity. But managed IRQ 
> seems design to forbid user from manipulating interrupt affinity.
>
> It seems managed IRQ is coupled with user side application to me.
>
> Would you share your thoughts about this issue please?

Can you please provide a more detailed description of your system?

    - Number of CPUs

    - Kernel version
    - Is NOHZ full enabled?
    - Any isolation mechanisms enabled, and if so how are they
      configured (e.g. on the kernel command line)?

    - Number of queues in the multiqueue device
          
    - Is the RT thread issuing I/O to the multiqueue device?

Thanks,

        tglx
