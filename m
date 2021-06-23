Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC8A3B2020
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 20:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhFWSTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 14:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFWSTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624472224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zsnnWPBw158ioKHOEvs2KKkgeu539ulBwP58qKPdjxw=;
        b=ZXLaZ5Fsmga8OximBd+2rCCTqY/6vcsJ4hqegM4Fna1X3tYB1goe+zrA4OP9xhlLqahvZC
        +x/VGFlId7tBr8dSLmlJHBZb1J3nZvRiylBh+k7bomidXRSmUzqHrZwMlGd9nalz1aKopv
        DrG+qXJFiT3legUgmzfczbmyF8QML/0=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-OwC0maTIOvm2aheo29OiNg-1; Wed, 23 Jun 2021 14:17:03 -0400
X-MC-Unique: OwC0maTIOvm2aheo29OiNg-1
Received: by mail-ot1-f72.google.com with SMTP id y21-20020a0568301d95b029044f7b7f3047so1803752oti.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zsnnWPBw158ioKHOEvs2KKkgeu539ulBwP58qKPdjxw=;
        b=uDfUvvktYR6kfjvdo5egQ8CqM+B87BGo+N/z9IJbjEtRkEQk2lvLE6O/kb9uH4+HnK
         0roHx3iWrPuPT3x9CONX7bjrordmoKEegL1Tv/Ku7L1or8MpV6YTRtdKsmymy+ye/2jZ
         WgITvWL6nR1H8IEibRlSAexrey6Q1cVL/9a4WRz16JQFmZ5Nqo9ehN+CBwvGIp/55SeJ
         0o10MfNuB8RRPnJ2bR0DnbQfpAfWzI9OXZvwXmWt6zngQivDRLu2Okgh0+KJtY1fxSSU
         WP8bZt/NucbW3Y+RFE8HaS6mLJXVo1RZIUFnc215MpdgUBWHcvQFrNsvz0/HFjKubWFk
         6D5A==
X-Gm-Message-State: AOAM530zuP53V0vey3oWwBAGS58cIfqoizxi9OflWiWypBiSoonmeNpq
        TDYZZsmFlKYWxTW3uFOLQji44x7BD6M/YaLAxz9hEDY/2zU++D5jWItiZ7vExkbTOxWeP0bw3Ba
        Tv97S+gK0Wrnzs1UI6abvMok6
X-Received: by 2002:a54:4706:: with SMTP id k6mr888669oik.61.1624472222518;
        Wed, 23 Jun 2021 11:17:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL0YKbaTtBpyfI6uxPnb987mGgVkN6qd0BiEd/xyLXC74Z3rr1q+2jYxVhnQLadq7/gCiFPw==
X-Received: by 2002:a54:4706:: with SMTP id k6mr888659oik.61.1624472222401;
        Wed, 23 Jun 2021 11:17:02 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id e5sm102607oou.27.2021.06.23.11.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:17:02 -0700 (PDT)
Date:   Wed, 23 Jun 2021 12:17:00 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, bhelgaas@google.com
Cc:     cohuck@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
        eric.auger@redhat.com, giovanni.cabiddu@intel.com,
        mjrosato@linux.ibm.com, jannh@google.com, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, schnelle@linux.ibm.com,
        minchan@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] vfio: export and make use of pci_dev_trylock()
Message-ID: <20210623121700.4725e22f.alex.williamson@redhat.com>
In-Reply-To: <20210623022824.308041-1-mcgrof@kernel.org>
References: <20210623022824.308041-1-mcgrof@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021 19:28:22 -0700
Luis Chamberlain <mcgrof@kernel.org> wrote:

> This v2 series addreses the changes requested by Bjorn, namely:
> 
>   - moved the new forward declarations next to pci_cfg_access_lock()
>     as requested
>   - modify the subject patch for the first PCI patch

Looks ok to me and I assume by Bjorn's Ack that he's expecting it to go
through my tree.  I'll give a bit of time to note otherwise if that's
not the case.  Thanks,

Alex

> Luis Chamberlain (2):
>   PCI: Export pci_dev_trylock() and pci_dev_unlock()
>   vfio: use the new pci_dev_trylock() helper to simplify try lock
> 
>  drivers/pci/pci.c           |  6 ++++--
>  drivers/vfio/pci/vfio_pci.c | 11 ++++-------
>  include/linux/pci.h         |  3 +++
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 

