Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B8C312E8E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhBHKHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:07:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232160AbhBHJ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 04:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612778248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RvZB2MDYfZF1qZTLhRJJTQFx3HJrD/c9ga0gap1r0Iw=;
        b=SY4IsF6SbgAXHXwZXWd/uot+WYhV2HiugtUpgGTcGriZF3p8N89XasnQEsYrcLIyRt1WA/
        RMwqzBbegV3EHaJKHmPYoVW7I3FO/WTf67Rt5WGbL+8r26TJH/Q7T4yL6Ar+/wP16NwmUj
        9Td+r8CmfXgwIiXyMdeDSNlUD+cjxfc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-TcL9EBgFMX678JzZKcQE0w-1; Mon, 08 Feb 2021 04:57:25 -0500
X-MC-Unique: TcL9EBgFMX678JzZKcQE0w-1
Received: by mail-ej1-f69.google.com with SMTP id gv53so3959367ejc.19
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 01:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RvZB2MDYfZF1qZTLhRJJTQFx3HJrD/c9ga0gap1r0Iw=;
        b=PI0guts7hQ7BhiI+78ZmyjZ53nIrZDwt5Lf0xCFJAEuY6T1KyTwdgaw51yKPSmaiG0
         7SUC+9rOF58P/YNlu9vziYOQmoxNwq3UV8gdr/dTJN4yrTHq4nJO2CTna78wRUi/V3r1
         avsQ+sjezLxNrYZBmePTZDW7fDGcbitIU7Swy85tDG4JJMyNyi1hdGtD0xCgmFxtwU0p
         jWwB8/YkbOS5Qg5wVlnRmT8oPlbG+93pRtTD1fEYktoRx0ClJRx1Ywro4pg7dIKCadeG
         2KN8CjYkIUTtI8s6AzcTm6z7Fa/EydfP/8n/rnGkZLkXO5s9R5gckB9kakGv1/w0WCt1
         Xt3w==
X-Gm-Message-State: AOAM533nmsvtk28PlHC2XOZKjLzxcz5jOkLUqxvhyZuM7caBxTExsHVY
        BxWXr9TjcSE5flDx6BOdDj1GiEHgPkoBpNFW473KFkc7Xrbd/GRoxe1lfqQWGyA8T/m9tPRPvjP
        h/GtJ+IpH5hliS6sCl0/Y/9/7
X-Received: by 2002:a17:906:69c2:: with SMTP id g2mr15591526ejs.249.1612778244679;
        Mon, 08 Feb 2021 01:57:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuMkDMU86Gua486YyYkyE3So25auj8KdRwJTxDrTGf27Ev7G+jbzxJNKOribW4cbFKzGSizw==
X-Received: by 2002:a17:906:69c2:: with SMTP id g2mr15591508ejs.249.1612778244420;
        Mon, 08 Feb 2021 01:57:24 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id mh4sm5533387ejb.122.2021.02.08.01.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 01:57:23 -0800 (PST)
Date:   Mon, 8 Feb 2021 04:57:20 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Dongli Zhang <dongli.zhang@oracle.com>,
        Eli Cohen <elic@nvidia.com>, Jason Wang <jasowang@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org, pbonzini@redhat.com,
        stefanha@redhat.com, joe.jin@oracle.com,
        aruna.ramakrishna@oracle.com, parav@nvidia.com
Subject: Re: [vdpa_sim_net] 79991caf52:
 net/ipv4/ipmr.c:#RCU-list_traversed_in_non-reader_section
Message-ID: <20210208045641-mutt-send-email-mst@kernel.org>
References: <20210123080853.4214-1-dongli.zhang@oracle.com>
 <20210207030330.GB17282@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207030330.GB17282@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 11:03:30AM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 79991caf5202c7989928be534727805f8f68bb8d ("vdpa_sim_net: Add support for user supported devices")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git Dongli-Zhang/vhost-scsi-alloc-vhost_scsi-with-kvzalloc-to-avoid-delay/20210129-191605
> 
> 
> in testcase: trinity
> version: trinity-static-x86_64-x86_64-f93256fb_2019-08-28
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 

Parav want to take a look?

-- 
MST

