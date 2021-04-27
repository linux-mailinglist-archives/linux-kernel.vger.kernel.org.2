Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480E036BD1C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 04:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhD0CHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 22:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhD0CHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 22:07:00 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A1EC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 19:06:17 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u16so41067905oiu.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 19:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=RjRLRjt6DksoCv/KudQEO4D/bl6V4MEpJxlivb+MQoM=;
        b=jdV/vIAUyUYepkvyJNWXc3rT8qZiyIJAwkvhMcd+315lRZ7zAiBI7zwh312YsV9EWr
         CXUhCmMf29fQrxt9oEQW12yvBYikgQKfnLYZjsmv4T3T70UD2SIFDZp6Uh9YjgSjL6iR
         BKktWs8jn3BGR8MX0WOfS8ty3VTSKAVdrLfiWt2aiA0DzKIAh198wP4KlIP9bk3MXU3z
         iJwMo0CcJSeuAn5Wss+Ccq74lMS4hQSKoRxRT5LU8/Oq36/JBdHBNdFRwWRnJ8u9kw0M
         bMjeV7ArPu4oPxPVf26HVS+tLLLMO9J8yPnkGZYKmouGME+1P7qPmik3YycN6FtwOWcY
         QIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=RjRLRjt6DksoCv/KudQEO4D/bl6V4MEpJxlivb+MQoM=;
        b=LbS4FSEJhHFKZg1hPEalMxj84LU7xsmNGPdXL/FSrBod5veFfvTMp2cLCJzPYAvwWi
         ea3hHIiAs/rSRXkjS8MoK0g4+wm8rocKUdnwt3s6BAg95xJbJC/NrtqLJPDHfIAcYjBQ
         jhDBnnjh/u+2Z2G39pddDG6+ngGyzuu/zlqYZptv8h6Zlql3or5Qph7ly7dLz+nqckk1
         sLHvsTT/XiP0JMXNN5U6giKdL8IzP5j2X7naFnA+BhzJJkeOhgcCFyr/Whq0r6tW/s63
         f6IwB1GEHGUN+W/u1sUDIYKjm0djc/v2/rHreDnCXYiN78IEQ8hFKas/icjpBZNjWaVJ
         6mlw==
X-Gm-Message-State: AOAM532vXR3htJQ8f0/SO97EUxWdfy+AKv+DCKl2OSLq1H+7g6fDvg8F
        T/gx55xCNwZJIKuKIf92tWZ73A==
X-Google-Smtp-Source: ABdhPJymXV9swDliPd/VmVska6RbWioEMytEv11iIxTdOsGriU6E6s+aROVttE2bhkJcD8ehfB9fIA==
X-Received: by 2002:aca:90b:: with SMTP id 11mr1437534oij.77.1619489176268;
        Mon, 26 Apr 2021 19:06:16 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h28sm404479oof.47.2021.04.26.19.06.14
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 26 Apr 2021 19:06:15 -0700 (PDT)
Date:   Mon, 26 Apr 2021 19:05:55 -0700 (PDT)
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
Subject: Re: [PATCH v4 01/10] userfaultfd/hugetlbfs: avoid including
 userfaultfd_k.h in hugetlb.h
In-Reply-To: <20210420220804.486803-2-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2104261858130.2998@eggly.anvils>
References: <20210420220804.486803-1-axelrasmussen@google.com> <20210420220804.486803-2-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021, Axel Rasmussen wrote:

> Minimizing header file inclusion is desirable. In this case, we can do
> so just by forward declaring the enumeration our signature relies upon.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  include/linux/hugetlb.h | 4 +++-
>  mm/hugetlb.c            | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
