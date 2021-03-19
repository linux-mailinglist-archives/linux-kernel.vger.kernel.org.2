Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A0934128E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhCSB6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhCSB62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:58:28 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B73C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:58:28 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 30so4267613qva.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JiVqDCFQoleLcPQiijGmNpe+GDIBYP9KaktrAuD4UeY=;
        b=cO4PvwPZhiVCZOO4Js5LQU0t1J6I3JMpIhjSa3v6KeWVX0N9Izb3Uaa/eNRzjBejAQ
         CwhTjbcdbJILCsEXAeNH42ehWKmLUTkUoygEsZMz505VcW28OuzdB6qsqecnHk09Gyk9
         n+fI627jA2k5LPfSahTJ7iCKBmyf7oKOfCmOURgm/QGUUyKdpXDS8cWF/4kNobXdha9C
         SBuPLQ/4d1uS8Md3wIH6qKhBCxw7yCKB4uSP4JfCXG1X4vLD9m2D1bRWVFc38Pre3Kmw
         A3ahxOj2z/+ZkvcCXFCejzpuAH9UK+gIY/xh1cXlkj2MLeZ/1tNc6pJRMK7z6wBkCuT6
         vWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JiVqDCFQoleLcPQiijGmNpe+GDIBYP9KaktrAuD4UeY=;
        b=rhmPZS3cRXedTOTESf7yUD0BoaAdPOIzjkhzdvwUHumGwcNT46RcyB3488M6d4snIV
         rdf1M6f44l5BYxBixpm48tZDsWveJlfSI5jihUttQTdDiyR9XBkR9cwjfxAb6f4g34UM
         qS8D0futd1jYJM0TBvlks/5nLCAb6zpQx3N3Wlb2VQtCTGOCnvHZDlTzXti/m7NCfdsa
         /V588swDRRqfzoidBe0uKbnv3AgsQQqIIwwuEKd9wMUFmGHYFwnoWM1LMpIQTGoZfaS7
         bEaaW4z0bxI2U9ioIDCCXcngUK2hMtlj4z/L5XwdrjKrUDXKXEQV8zYO63jSAsBG0rNj
         DJYg==
X-Gm-Message-State: AOAM533CwS9ivzjT/1DI7XZaBgJON+9smFN+kp8D4WOPFpgZsxpOYv8S
        QY6Mo9sEBsWr3YU/YXUCwYmuJQ==
X-Google-Smtp-Source: ABdhPJwlcAocbwXbejNeQSSFfnPBhhYBU6u5C6+yT1lL+Fw+uGkbTnq8GUvnMW21Yldql/4+R6gHBw==
X-Received: by 2002:a05:6214:268c:: with SMTP id gm12mr7129538qvb.36.1616119106845;
        Thu, 18 Mar 2021 18:58:26 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f27sm3177041qkh.118.2021.03.18.18.58.24
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 18 Mar 2021 18:58:26 -0700 (PDT)
Date:   Thu, 18 Mar 2021 18:58:23 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     Hugh Dickins <hughd@google.com>, Brian Geffon <bgeffon@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dmitry Safonov <dima@arista.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Subject: Re: [PATCH] mm: Allow shmem mappings with MREMAP_DONTUNMAP
In-Reply-To: <20210316201732.GD395976@xz-x1>
Message-ID: <alpine.LSU.2.11.2103181828300.3440@eggly.anvils>
References: <20210303175235.3308220-1-bgeffon@google.com> <alpine.LSU.2.11.2103131934290.18112@eggly.anvils> <20210316201732.GD395976@xz-x1>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021, Peter Xu wrote:
> 
> I'm curious whether it's okay to expand MREMAP_DONTUNMAP to PFNMAP too..
> E.g. vfio maps device MMIO regions with both VM_DONTEXPAND|VM_PFNMAP, to me it
> makes sense to allow the userspace to get such MMIO region remapped/duplicated
> somewhere else as long as the size won't change.  With the strict check as
> above we kill all those possibilities.
> 
> Though in that case we'll still need commits like cd544fd1dc92 to protect any
> customized ->mremap() when they're not supported.

It would take me many hours to arrive at a conclusion on that:
I'm going to spend the time differently, and let whoever ends up
wanting MREMAP_DONTUNMAP on a VM_PFNMAP area research the safety
of that for existing users.

I did look to see what added VM_PFNMAP to the original VM_DONTEXPAND:

v2.6.15
commit 4d7672b46244abffea1953e55688c0ea143dd617
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Fri Dec 16 10:21:23 2005 -0800

Make sure we copy pages inserted with "vm_insert_page()" on fork

The logic that decides that a fork() might be able to avoid copying a VM
area when it can be re-created by page faults didn't know about the new
vm_insert_page() case.

Also make some things a bit more anal wrt VM_PFNMAP.

Pointed out by Hugh Dickins <hugh@veritas.com>

Signed-off-by: Linus Torvalds <torvalds@osdl.org>

So apparently I do bear some anal responsibility.  My concern seems
to have been that in those days an unexpected page fault in a special
driver area would end up allocating an anonymous page, which would
never get freed later.  Nowadays it looks like there's a SIGBUS for
the equivalent situation.

So probably VM_DONTEXPAND is less important than it was, and the
additional VM_PFNMAP safety net no longer necessary, and you could
strip it out of the old size check and Brian's new dontunmap check.

But I give no guarantee: I don't know VM_PFNMAP users at all well.

Hugh
