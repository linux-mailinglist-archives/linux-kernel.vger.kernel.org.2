Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5864413EE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 07:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhKAG5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 02:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229938AbhKAG5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 02:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635749690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NhXyRApgs2cJlmSVsNQs3Vi5TjevtHCjRWBXl4hPKh0=;
        b=g+Vx+IxDmTtl0iIIikCmGsBhkJBuARFcehuepVXZDiLs1VlfiLlT3gpJuU7cTaDc14oEfz
        jifBp9GDBcDLrrVi0jZj24t883wiXA/z74Ekyh5ojV5Kl2yb+axSw7gGWcsGsG+m2pXcDv
        kEgwhmyUi5gV/TQrDtsU5553IrIHJDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-25ZQ8Jg9ONedDt86TfWf1g-1; Mon, 01 Nov 2021 02:54:49 -0400
X-MC-Unique: 25ZQ8Jg9ONedDt86TfWf1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B2791006AA3;
        Mon,  1 Nov 2021 06:54:48 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-86.pek2.redhat.com [10.72.13.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F6C260C0F;
        Mon,  1 Nov 2021 06:54:45 +0000 (UTC)
Date:   Mon, 1 Nov 2021 14:54:42 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 0/3] x86/kexec: fix memory leak of elf header buffer
Message-ID: <YX+PMtj0gN458gTQ@dhcp-128-65.nay.redhat.com>
References: <20211029072424.9109-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029072424.9109-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

On 10/29/21 at 03:24pm, Baoquan He wrote:
> The memory leak is reported by kmemleak detector, has been existing
> for very long time. It could casue much memory loss on large machine
> with huge memory hotplug which will trigger kdump kernel reloading
> many times, with kexec_file_load interface.
> 
> And in patch 2, 3, clean up is done to remove unnecessary elf header
> buffer freeing and unneeded arch_kexec_kernel_image_load().
> 
> Baoquan He (3):
>   x86/kexec: fix memory leak of elf header buffer
>   x86/kexec: remove incorrect elf header buffer freeing
>   kexec_file: clean up arch_kexec_kernel_image_load
> 
>  arch/x86/kernel/machine_kexec_64.c | 23 +++++++++--------------
>  include/linux/kexec.h              |  1 -
>  kernel/kexec_file.c                |  9 ++-------
>  3 files changed, 11 insertions(+), 22 deletions(-)
> 
> -- 
> 2.17.2
> 

Acked-by: Dave Young <dyoung@redhat.com>

nitpick: the first two patches can be merged togeter, but I'm also fine if
they are in two patches.

Thanks
Dave

