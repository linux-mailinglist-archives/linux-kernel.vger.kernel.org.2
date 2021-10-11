Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09F64292A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244051AbhJKOzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244233AbhJKOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633963972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=89zmHIrU5FNV2xiprQFh1fRhF37l31tX1FhfGy5HLqE=;
        b=cCKrVsTxMGoz1E3ZnLStiEtq0jHQXfkgsnYVJ3kAOza2KFwA9Bjnplk/wSN+RPFZRG9I8k
        DlLQkwRd1my4U/TtGTN8YzyC4WMIWLM4kB0pCuxp7n2YjOEVC3XDeOTikXxWRG1Q5r42J7
        rmr2rU6Of5JXZdVKL7/iiePMKElL+Jg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-nYHgrtcuM5COQvtstOltpg-1; Mon, 11 Oct 2021 10:52:51 -0400
X-MC-Unique: nYHgrtcuM5COQvtstOltpg-1
Received: by mail-oo1-f72.google.com with SMTP id 68-20020a4a0d47000000b0028fe7302d04so10198407oob.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89zmHIrU5FNV2xiprQFh1fRhF37l31tX1FhfGy5HLqE=;
        b=h36PcovUppAb2/khsBWTEfaUBKBMnkmGNEFAPs6/DklLrn+dh7FDaLnFCtJmoimBxA
         JiHscv2r1sO3HDQ94ACxGwzNPJjDPW1dQRYNeUZ+NRaW5gpt1T7bXu8LJe9ZI/3pgm0m
         C5EU/HEm2WejOXVkzGxCAxnD6q3WbtZw2c0BZ4yMtassYd8PZX1MajeEvc9NLvMHNvtC
         prgh8rVmD4zMBPix9dyPzJiBr5hAxnhKm/gLPv7vXDIYNxeEaAzRf450YyoER9ZRFLz4
         7W+lJEyRP9efYQ5SksN7/EAivQo08JNkbdutgc2+ejmv0gLsboigPMtA0D6+9Jleeo63
         k79w==
X-Gm-Message-State: AOAM533HKQxaT4KJgpWZ9AAxXhKVYHAeJFhdi0NCmONwP1yl/cmFKdgr
        ZNx/JejbMyX/T92cDujDCjUJgC7yzMNhyn+7Lw4Qsaz7hTrPReC7X3Hy2qiw4E9fTs0zAIz+5Ev
        +9HXeObMTW/0SMbRYyWcw8VWK
X-Received: by 2002:a4a:9541:: with SMTP id n1mr14720674ooi.62.1633963970705;
        Mon, 11 Oct 2021 07:52:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9v/DeW+zwCiT+kQifox09JmpwS7WRLrIq2+cIai843pldXiRD31wdX0Bt0DnZuoCVFoc0oQ==
X-Received: by 2002:a4a:9541:: with SMTP id n1mr14720661ooi.62.1633963970465;
        Mon, 11 Oct 2021 07:52:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d18sm976983ook.14.2021.10.11.07.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 07:52:50 -0700 (PDT)
Date:   Mon, 11 Oct 2021 08:52:47 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] iommu: intel: remove flooding of non-error logs, when
 new-DMA-PTE is the same as old-DMA-PTE.
Message-ID: <20211011085247.7f887b12.alex.williamson@redhat.com>
In-Reply-To: <CAHP4M8VPem7xEtx3vQPm3bzCQif7JZFiXgiUGZVErTt5vhOF8A@mail.gmail.com>
References: <20211002124012.18186-1-ajaygargnsit@gmail.com>
        <b9afdade-b121-cc9e-ce85-6e4ff3724ed9@linux.intel.com>
        <CAHP4M8Us753hAeoXL7E-4d29rD9+FzUwAqU6gKNmgd8G0CaQQw@mail.gmail.com>
        <20211004163146.6b34936b.alex.williamson@redhat.com>
        <CAHP4M8UeGRSqHBV+wDPZ=TMYzio0wYzHPzq2Y+JCY0uzZgBkmA@mail.gmail.com>
        <CAHP4M8UD-k76cg0JmeZAwaWh1deSP82RCE=VC1zHQEYQmX6N9A@mail.gmail.com>
        <CAHP4M8VPem7xEtx3vQPm3bzCQif7JZFiXgiUGZVErTt5vhOF8A@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 11:49:33 +0530
Ajay Garg <ajaygargnsit@gmail.com> wrote:

> The flooding was seen today again, after I booted the host-machine in
> the morning.
> Need to look what the heck is going on ...
> 
> On Sun, Oct 10, 2021 at 11:45 AM Ajay Garg <ajaygargnsit@gmail.com> wrote:
> >  
> > > I'll try and backtrack to the userspace process that is sending these ioctls.
> > >  
> >
> > The userspace process is qemu.
> >
> > I compiled qemu from latest source, installed via "sudo make install"
> > on host-machine, rebooted the host-machine, and booted up the
> > guest-machine on the host-machine. Now, no kernel-flooding is seen on
> > the host-machine.
> >
> > For me, the issue is thus closed-invalid; admins may take the
> > necessary action to officially mark ;)

Even this QEMU explanation doesn't make a lot of sense, vfio tracks
userspace mappings and will return an -EEXIST error for duplicate or
overlapping IOVA entries.  We expect to have an entirely empty IOMMU
domain when a device is assigned, but it seems the only way userspace
can trigger duplicate PTEs would be if mappings already exist, or we
have a bug somewhere.

If the most recent instance is purely on bare metal, then it seems the
host itself has conflicting mappings.  I can only speculate with the
limited data presented, but I'm suspicious there's something happening
with RMRRs here (but that should also entirely preclude assignment).
dmesg, lspci -vvv, and VM configuration would be useful.  Thanks,

Alex

