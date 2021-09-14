Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEB340AAEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhINJf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhINJfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:35:55 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E104BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 02:34:38 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id b15so12819363ils.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 02:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hMAVv0XT+E1ILWD7RS17ZuL6RZs23nNagE+ZxXeUmc4=;
        b=DfhK2XQPq77fyylJZQ6SV9Tt0LGuzDR4qtbIiJf7rBrsCGFNdpeAejKoqrCDd66/lF
         pbBfFW6GAaUaEiEhXv/kxgaoTiR4gOMv5Zi+Bvh8KfbmwhkXiFKLLq5Q+Wb5gI4Go1PN
         w0phzrNI//UhNz13RTgymvcPwbJIlST/X/Y8Bqc+n7IOd1PswOjwP77lRbUKukQxiVdt
         CPu68BWokEqnslEps5io/YtGIwK6PoexZJHmUREQRXORnG/D0UKudbJ5mq/Q523Nbnrm
         MI9bgAmT6P7gA4KBOag52QslmNasWIaXxgx7ScOxXUTzJUExKPZIheLeK7NWdHFjKYam
         h0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hMAVv0XT+E1ILWD7RS17ZuL6RZs23nNagE+ZxXeUmc4=;
        b=OoCGqWv5E3yHK0FLeOdQC7HA8iu2xN1fx8h3ORlC7CQ3r2UUf/XG75QYp61OTnwbLH
         qELBzf6a33cC5sySER2NfqcaRjRr6130uf18CrdkHcD25wcxjLqg6yBhU6eAuIbnuFd7
         Zm5hGYBIVxVfaLz/IGfA3TCffDtvQdKgXUZ6EJC5Ve0hUexBqFtYBAK6JhipsDpoAN3T
         Y6yLs+a2j6fHEYnVkQOsfcW7PJ4wsXAwMA17qFnp4Cd9UBc1EsFc7qTm4/NaOVMBwgri
         /+PJWS6p3FtEKdqFTASV/L9UQagykD4AiEIo7D4BzGL8YIXa/rSucbGr+nWIyAf9pJyJ
         D/eg==
X-Gm-Message-State: AOAM530yli+4aknYMHWMEzAbDdvjt/j8bcvYKjhGEdZKQjiDzsvVxFkA
        9FZXs7ZQbQhDnBrfZE5AHuc=
X-Google-Smtp-Source: ABdhPJzppb0sDrkpuWPulnFXyKo9jXoqYBuEOHHPhdWd2MDrwBzvAePpMlWbnmEThvBt50kB2+lqJw==
X-Received: by 2002:a05:6e02:e53:: with SMTP id l19mr4706527ilk.217.1631612078377;
        Tue, 14 Sep 2021 02:34:38 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id g13sm6557821ile.68.2021.09.14.02.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:34:37 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id E839427C0054;
        Tue, 14 Sep 2021 05:34:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 14 Sep 2021 05:34:36 -0400
X-ME-Sender: <xms:qmxAYSNp3sp2vYnMjCMlWqOXAMYEmmboWeqBjRiIVVejEc0eSMOJuQ>
    <xme:qmxAYQ9SYsGOZpMCc-ot0wDxItxvXewVmRn6WjZRkm0Q5dte5fGUN7SVpMYBzMgeL
    -8KjBjv2bwScUdhRA>
X-ME-Received: <xmr:qmxAYZTCyksJuicjFZ2kb-JlaX0ruv-bW1Pb6bARrMqGB9HtUj2mnMQ_gAltFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:qmxAYSs9eW0R0T78Rs9sR_666icd-so54uoQSmReUznEKHRcZ084HA>
    <xmx:qmxAYadxe3Ozutru1w4Lp-V9M_L7t2ZOYaqrPsAWsuwiKdVlrtJQ6A>
    <xmx:qmxAYW0KhiznUMqynA0I5CIX-lKxo0UBpjSUgJ_7mlbA6UHNi8yPhg>
    <xmx:rGxAYbW7TfnOBX_dMmbtu7lAFNly2P18m5dVy6PgxDbIKeJqbSxE2Sjkx3E>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 05:34:34 -0400 (EDT)
Date:   Tue, 14 Sep 2021 17:34:31 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
Message-ID: <YUBsp7j6iHyQeMZ6@boqun-archlinux>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com>
 <875yv4f99j.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yv4f99j.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:36:24PM +0200, Thomas Gleixner wrote:
[...]
> As the device startup is not really happening often it's sensible to do
> the following
> 
>         disable_irq();
>         vp_dev->intx_soft_enabled = true;
>         enable_irq();
> 
> because:
> 
>         disable_irq()
>           synchronize_irq()
> 
> acts as a barrier for the preceeding stores:
> 
>         disable_irq()
>    	  raw_spin_lock(desc->lock);
>           __disable_irq(desc);
>    	  raw_spin_unlock(desc->lock);
> 
>           synchronize_irq()
>             do {
>    	      raw_spin_lock(desc->lock);
>               in_progress = check_inprogress(desc);
>    	      raw_spin_unlock(desc->lock);
>             } while (in_progress);     
> 
>         intx_soft_enabled = true;
> 
>         enable_irq();
> 
> In this case synchronize_irq() prevents the subsequent store to
> intx_soft_enabled to leak into the __disable_irq(desc) section which in
> turn makes it impossible for an interrupt handler to observe
> intx_soft_enabled == true before the prerequisites which preceed the
> call to disable_irq() are visible.
> 

Right. In our memory model, raw_spin_unlock(desc->lock) +
raw_spin_lock(desc->lock) provides the so-call RCtso ordering, that is
for the following code:

	A
	...
	raw_spin_unlock(desc->lock);
	...
	raw_spin_lock(desc->lock);
	...
	B

Memory accesses A and B will not be reordered unless A is a store and B
is a load. Such an ordering guarantee fulfils the requirement here.

For more information, see the LOCKING section of
tools/memory-model/Documentation/explanation.txt

Regards,
Boqun

> Of course the memory ordering wizards might disagree, but if they do,
> then we have a massive chase of ordering problems vs. similar constructs
> all over the tree ahead of us.
> 
> From the interrupt perspective the sequence:
> 
>         disable_irq();
>         vp_dev->intx_soft_enabled = true;
>         enable_irq();
> 
> is perfectly fine as well. Any interrupt arriving during the disabled
> section will be reraised on enable_irq() in hardware because it's a
> level interrupt. Any resulting failure is either a hardware or a
> hypervisor bug.
> 
> Thanks,
> 
>         tglx
