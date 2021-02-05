Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C99C31198C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhBFDLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhBFCiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:38:25 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6FEC0698C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:22:04 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id o12so8360980ote.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 14:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7+LsQN+DZU7iaItTdPpaGXfVMqU1+ZGF7ata7+D446k=;
        b=aEITx9s+GN2rbIdwwFbs+hxDrFe0qhiTxg5DQZDQXsOSyKHogVOEB9Pd9C3SgwOdJc
         FY1DXrTm/JB+iFyvd6TZ+wRCpv/WBYyN5yOLKMI4xKoPpGAwl7a9gidYgiYUUZdCAjeS
         dw8djYItdQYN8VaC7vSaVqS5DpN37JhtAxB1p6UIWW4PRPdPuPT0bmO/W/66466JN7kR
         gtoYC2VFyRTFjQCvc20DeSqP0gzk8hjoan9dOEbyktIQE5LhjX1je+6359k9aU5kobeQ
         6Fz/9Su93yrp3jGHhgpP8mLXVrFNeQOb+/x7H9iM9/ho+SvmTNeKMBiaKC3mREPZFBL2
         e0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7+LsQN+DZU7iaItTdPpaGXfVMqU1+ZGF7ata7+D446k=;
        b=CBHeByYpMZ6lLx93TJMiRvYGym6uICcdIk77T/VutTTCxOBoqrWe2F8+IKGdZfjGlb
         Al9PfavQ13alEQpOvxzdkOhmWgrpWzqm349QVZ0jCaek6G5hwaWbfwHBDz0gyJdnHgMG
         +LPb9k6WkAzKssppM+/xsWxNvm3lv5VhohstGPpLk5+Fr0r17EHNiaDDt8JnV9FseTz9
         ExIk/CHhCU4lAgRLLhfmGzqKSe+8UvOIMz43jMkqS5HHkIvJlXcYYpuR+LtWoEWFz6RY
         VnT2Un8ObfaN6np+JVHqJS/I9DDFaTWLKn6j4TH7wVpkCQ1np2HOBI3EdQWFaYbnTDeJ
         ZdJw==
X-Gm-Message-State: AOAM532G28zl2dokOsOX6igtWAneXB5lk6kvDNqhimJu1ToaaK9qArST
        gf6E1dzLzMSJOt7dNJsYcCzSyQ==
X-Google-Smtp-Source: ABdhPJzLu3Pb1TQiUwd7eoE8RgpDWe5b6n4IVlIEjT114cuL+mR5Zb2TmEPQeY5neGluqAXw/ZJa2w==
X-Received: by 2002:a9d:10c:: with SMTP id 12mr4895355otu.153.1612563722059;
        Fri, 05 Feb 2021 14:22:02 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p23sm2139182otk.51.2021.02.05.14.22.00
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 05 Feb 2021 14:22:01 -0800 (PST)
Date:   Fri, 5 Feb 2021 14:21:47 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH RFC 00/30] userfaultfd-wp: Support shmem and hugetlbfs
In-Reply-To: <20210129224938.GC260413@xz-x1>
Message-ID: <alpine.LSU.2.11.2102051411200.5769@eggly.anvils>
References: <20210115170907.24498-1-peterx@redhat.com> <20210129224938.GC260413@xz-x1>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021, Peter Xu wrote:
> 
> Huge & Mike,
> 
> Would any of you have comment/concerns on the high-level design of this series?
> 
> It would be great to know it, especially major objection, before move on to an
> non-rfc version.

Seeing Mike's update prompts me to speak up: I have been looking, and
will continue to look through it - will report when done; but find I've
been making very little forward progress from one day to the next.

It is very confusing, inevitably; but you have done an *outstanding*
job on acknowledging the confusion, and commenting it in great detail.

Hugh
