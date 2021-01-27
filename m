Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31A8306598
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhA0VDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhA0VDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:03:49 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C10C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:03:08 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id v126so3198538qkd.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NHnDaep4soLIUVFgcK1vP1PkeHLaSM4DDjEPfhi0vRo=;
        b=U0jlcow9OnWiQY4OJN0AVr7YhWpMtEtAkm3oUoC3kkSyPAl7bRLUPfNgYqhQICnuT4
         abOxe8xPAYoqFVfUUFZ8oOmWS5B5QNbJN1DvQYmOanCy7Q6CB2KQZPk+HM8EDLCA/CEA
         9QSbQCPLv7N17px5rsIYlPPHK64ESeBbXWo6DNzK2F0eIc80O0UQJSkTKf4RhMdpZixD
         WeVEQEMMUtp2+BrXe7id+CN2K3GQyksPPXoS6nF+sDfwbNIAibeqAwitn6eUwz8aNC+9
         3JQUmXXSoAAgzqDfjw1Ho53YxR1tOfLL7TYLvJsUHVufJm5DrKGxRWu30HK23PEKOdtU
         g4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NHnDaep4soLIUVFgcK1vP1PkeHLaSM4DDjEPfhi0vRo=;
        b=iBtDWxdJPBNAMeUky2A3+R6PADkSg7JSrYqZ+uo27h/JUNViOron+WraU59bj2Td2d
         51e71gsWKVGJCj/xt8p/HL5mCQrvk2MvwLGJeLCj2TlIaaFQ1tBTXoHug7dMw+svUMNO
         3DyjgaZAZEzbCjyS1GvLwJLxOn7nu7DqYi/IucUADHiuRiEgRxNK/DBn8xANnG8JTiaA
         gx8uMcHpZh2UpeEmfsIp2oGSZ+1CtDM4cTBiDfkYtk9b1HKbqo+1OzyPHerbTfNNN7lW
         pGEpZshHWz/LqhL6MaTJPC4R6Tjfqkh2OrYogjRy6tgQxO8JmmFIO5iBOoFmarAYiumy
         fiJg==
X-Gm-Message-State: AOAM531L8Il4O0ogWjvF4Q84Anccl9Fn7hawuRL5sdOiM3ZJ/16rBsUW
        Ffeb4BpuMCNYfO1FQH/XYHo=
X-Google-Smtp-Source: ABdhPJzu8GZ2Nc/IjQCOZSLAZ2iFopGsFW71/YA/MB0aK21vNpz2IaXZ8Z32VXZ+idK/VNLchg+ilQ==
X-Received: by 2002:a05:620a:2f7:: with SMTP id a23mr12514148qko.256.1611781387947;
        Wed, 27 Jan 2021 13:03:07 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id v12sm1983818qkg.63.2021.01.27.13.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 13:03:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Jan 2021 16:03:05 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Saravanan D <saravanand@fb.com>
Cc:     x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH V2] x86/mm: Tracking linear mapping split events
Message-ID: <YBHVCZscdVsxbFUk@slm.duckdns.org>
References: <bd157a11-8e6b-5f44-4d91-d99adb9f8686@intel.com>
 <20210127175124.3289879-1-saravanand@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127175124.3289879-1-saravanand@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jan 27, 2021 at 09:51:24AM -0800, Saravanan D wrote:
> Numerous hugepage splits in the linear mapping would give
> admins the signal to narrow down the sluggishness caused by TLB
> miss/reload.
> 
> To help with debugging, we introduce monotonic lifetime  hugepage
> split event counts since SYSTEM_RUNNING to be displayed as part of
> /proc/vmstat in x86 servers
> 
> The lifetime split event information will be displayed at the bottom of
> /proc/vmstat
> ....
> swap_ra 0
> swap_ra_hit 0
> direct_map_2M_splits 139
> direct_map_4M_splits 0
> direct_map_1G_splits 7
> nr_unstable 0
> ....

This looks great to me.

> 
> Ancillary debugfs split event counts exported to userspace via read-write
> endpoints : /sys/kernel/debug/x86/direct_map_[2M|4M|1G]_split
> 
> dmesg log when user resets the debugfs split event count for
> debugging
> ....
> [  232.470531] debugfs 2M Pages split event count(128) reset to 0
> ....

I'm not convinced this part is necessary or even beneficial.

> One of the many lasting (as we don't coalesce back) sources for huge page
> splits is tracing as the granular page attribute/permission changes would
> force the kernel to split code segments mapped to huge pages to smaller
> ones thereby increasing the probability of TLB miss/reload even after
> tracing has been stopped.
> 
> Signed-off-by: Saravanan D <saravanand@fb.com>
> ---
>  arch/x86/mm/pat/set_memory.c  | 117 ++++++++++++++++++++++++++++++++++
>  include/linux/vm_event_item.h |   8 +++
>  mm/vmstat.c                   |   8 +++
>  3 files changed, 133 insertions(+)

So, now the majority of the added code is to add debugfs knobs which don't
provide anything that userland can't already do by simply reading the
monotonic counters.

Dave, are you still set on the resettable counters?

Thanks.

-- 
tejun
