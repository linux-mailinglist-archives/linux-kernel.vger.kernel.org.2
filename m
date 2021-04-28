Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E268C36CFD4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 02:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbhD1AD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 20:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbhD1AD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 20:03:28 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA44C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 17:02:43 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 5-20020a9d09050000b029029432d8d8c5so30966168otp.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 17:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6p+JC3rKVjYrYlLA8QianvKVOFGkYhcWLY47LZagLL0=;
        b=QG2EIYp+HC97NQun7wDIY0YwlOSn1mnmnxpu3OvXDOY3mR4wRvei0y53o8fYQr5kTV
         8oDkBNSoqmkyXMHAwBO0cmXYQgr5+9vGeBJ/0riXwQt8lIi7PmcgOAJ52+kiL4jLit1L
         iOGMBNecyxBH0usH0DNCUpLcwyQbR1kz6FnIaEXAYwcxtDyt9i5EDkI0LmU3ZIod5MDv
         gA6TozSWFZVS0SXEnj1kfysquTzkeq9DfWE+8JAZIZ8kkrGTq3IYs1sSJElWSQA3MnPr
         JLEx6WZ4dcSnczVjd1SgNKsmoUO5ngTfmw34QUGn9VvgnfOwgMEhsBUt/ioMW4IINC4j
         Mmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6p+JC3rKVjYrYlLA8QianvKVOFGkYhcWLY47LZagLL0=;
        b=UUJUUSrom8wuVD1tpAlE7i3nmN1TeUn4jfT5YnsbOSmzpP1EMXhnyiWrcl2OE3wWgD
         kVNxq81F5M04+bOPj/ZF+lUUPWKuHw42fv9DZqH+Py3Fmqn6XeTSNzoAKc+82241aYjH
         +Dwx0+G3k2F84lOKqyy0+okZuzA5fR5d414YqpGrTD35kS3EnK4a1Ede0FINS9buMx+i
         YzczDe8OTrWthXU9YWMDB4OCov3zKwBgiFBWoWkJzGN2jhq9c+4MkMTjpyiH3djmxmz2
         U3/PPQJC8j50jqav/dF2MTSwQ/jW4oyszi22nYjOB54oLRn9QR1H5WT0Yq5SEjBiBVWX
         Tsdg==
X-Gm-Message-State: AOAM531fepHUoYrC9o27jPDjrP2sZLUj4odNq6EcI7ic4kP8UsZk7Z35
        Lx5QaFOVrgcbhWpZ8+TP7VEYpQ==
X-Google-Smtp-Source: ABdhPJwX+Lblum7o2eVDbKoe89/QxHjJmiEd80w3XLF7Lh4KSMp8fjmUEoWUdcfv02tMyqPsSx7AAA==
X-Received: by 2002:a05:6830:2418:: with SMTP id j24mr1782028ots.87.1619568162507;
        Tue, 27 Apr 2021 17:02:42 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a21sm981529oop.20.2021.04.27.17.02.40
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 27 Apr 2021 17:02:42 -0700 (PDT)
Date:   Tue, 27 Apr 2021 17:02:25 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5 03/10] userfaultfd/shmem: support minor fault registration
 for shmem
In-Reply-To: <20210427225244.4326-4-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2104271701500.7111@eggly.anvils>
References: <20210427225244.4326-1-axelrasmussen@google.com> <20210427225244.4326-4-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2021, Axel Rasmussen wrote:

> This patch allows shmem-backed VMAs to be registered for minor faults.
> Minor faults are appropriately relayed to userspace in the fault path,
> for VMAs with the relevant flag.
> 
> This commit doesn't hook up the UFFDIO_CONTINUE ioctl for shmem-backed
> minor faults, though, so userspace doesn't yet have a way to resolve
> such faults.
> 
> Because of this, we also don't yet advertise this as a supported
> feature. That will be done in a separate commit when the feature is
> fully implemented.
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  fs/userfaultfd.c |  3 +--
>  mm/memory.c      |  8 +++++---
>  mm/shmem.c       | 12 +++++++++++-
>  3 files changed, 17 insertions(+), 6 deletions(-)
