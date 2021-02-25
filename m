Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C723247D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 01:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbhBYAYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 19:24:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236268AbhBYAYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 19:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614212592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nlfx0m5rFM5WgVSG9Q1ZGCqTh86/2WQ73ulkFBzW4yA=;
        b=HuWyonXlMzdAbwt5iuGSaFa8lQTg7YNTB6O9FoTlACO1E9pzpEQchxB/qMCFrHYYBqWtok
        NUDeK4AU5mCjCLlqjhK3WChnFkQ8f11kML9IBoiVTsTjKEFsugbS4/58rzFSFofoa7aO61
        ChbynK+JX7JXb1amJ4+OJ7jp9t9brac=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-F6u0ZA5qMH288o9ORuU-Cg-1; Wed, 24 Feb 2021 19:23:10 -0500
X-MC-Unique: F6u0ZA5qMH288o9ORuU-Cg-1
Received: by mail-pf1-f199.google.com with SMTP id i133so1693161pfe.19
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 16:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nlfx0m5rFM5WgVSG9Q1ZGCqTh86/2WQ73ulkFBzW4yA=;
        b=XwyowncibLge9npHA7wsaslOPQ0j1Ibwq5DwL37HGiNJLIR0CUirGsrFhxFzGvmjq5
         j7nJl9SXXqs9LVjRwmGt+eaTWDlavQfrbRUHpdGdRtjL8oP+XVFz5UeT0SScGv2jZ4hE
         7Ttku8S+pUg4X2901WtuuH5T/US9imL9TB6NrGqnr6RyrtuHBZY5MHUM9h4esR7Ob+vC
         kP3eBxhRdUUeVexOlPHL+eooN6MYYnT2nmA09yZctTsEEEkKtluAfVFI6NgO8oaPp4W3
         8psGUAruo7zEwb0sPK+Q6+9ryf5rpP4VlznpHXoaq1MZxjDq+dHCtzCUe6f+Qbx9pX9d
         AIwQ==
X-Gm-Message-State: AOAM532L50Bww+6K001W8IKEkdheZ2M0iCOi+mzj70cqjQ3SjHxotWLK
        IQ3w4ICXVdoryIMwhIybpR1r3VY/MADkKPd6BMrO/nWWvImroUxibFcHt9IdjKsPGm9PfZDoBBW
        cxluFlLWqilwl0cgmx6ErVKCX
X-Received: by 2002:a63:505d:: with SMTP id q29mr491807pgl.218.1614212589260;
        Wed, 24 Feb 2021 16:23:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7LlUqC5xsHipm3PaWqEcn1NiBEW73IT1af1+fd2VqIOGg8iehmhU7p2EfqiZeIpVsWrH2cg==
X-Received: by 2002:a63:505d:: with SMTP id q29mr491779pgl.218.1614212588805;
        Wed, 24 Feb 2021 16:23:08 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w25sm4052439pfn.106.2021.02.24.16.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 16:23:08 -0800 (PST)
Date:   Thu, 25 Feb 2021 08:21:01 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, kexec@lists.infradead.org,
        intel-wired-lan@lists.osuosl.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/4] i40e: don't open i40iw client for kdump
Message-ID: <20210225002101.hvbpq7f6zbvylqy4@Rk>
References: <20210222070701.16416-1-coxu@redhat.com>
 <20210222070701.16416-5-coxu@redhat.com>
 <20210223122207.08835e0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210224114141.ziywca4dvn5fs6js@Rk>
 <20210224084841.50620776@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210224084841.50620776@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 08:48:41AM -0800, Jakub Kicinski wrote:
>On Wed, 24 Feb 2021 19:41:41 +0800 Coiby Xu wrote:
>> On Tue, Feb 23, 2021 at 12:22:07PM -0800, Jakub Kicinski wrote:
>> >On Mon, 22 Feb 2021 15:07:01 +0800 Coiby Xu wrote:
>> >> i40iw consumes huge amounts of memory. For example, on a x86_64 machine,
>> >> i40iw consumed 1.5GB for Intel Corporation Ethernet Connection X722 for
>> >> for 1GbE while "craskernel=auto" only reserved 160M. With the module
>> >> parameter "resource_profile=2", we can reduce the memory usage of i40iw
>> >> to ~300M which is still too much for kdump.
>> >>
>> >> Disabling the client registration would spare us the client interface
>> >> operation open , i.e., i40iw_open for iwarp/uda device. Thus memory is
>> >> saved for kdump.
>> >>
>> >> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> >
>> >Is i40iw or whatever the client is not itself under a CONFIG which
>> >kdump() kernels could be reasonably expected to disable?
>> >
>>
>> I'm not sure if I understand you correctly. Do you mean we shouldn't
>> disable i40iw for kdump?
>
>Forgive my ignorance - are the kdump kernels separate builds?
>

AFAIK we don't build a kernel exclusively for kdump. 

>If they are it'd be better to leave the choice of enabling RDMA
>to the user - through appropriate Kconfig options.
>

i40iw is usually built as a loadable module. So if we want to leave the
choce of enabling RDMA to the user, we could exclude this driver when
building the initramfs for kdump, for example, dracut provides the 
omit_drivers option for this purpose. 

On the other hand, the users expect "crashkernel=auto" to work out of
the box. So i40iw defeats this purpose. 

I'll discuss with my Red Hat team and the Intel team about whether RDMA
is needed for kdump. Thanks for bringing up this issue!

-- 
Best regards,
Coiby

