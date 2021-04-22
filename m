Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76AD3676B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 03:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbhDVBR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 21:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234970AbhDVBR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 21:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619054214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XFnN2bqFK9UPgJTphfDgcHT3qr8qmbD8e/7QuCKFZRE=;
        b=MeYN+0g+7TceWsVVFkglApTZJZpLVKP/c7jgbrMgigFvQWqGLgCSnN5iUKXgh9iqYWPak4
        97A40VulXDKdKygQnW81n8w+DX2tWwVFvlbHJvJi3+Ii4sXo5VXrh2GEFkVSOX2WUV1zlx
        dlSh0WC0RjtBrMUwQMjmNVkxhCmaaeg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-mQGnjFGFN1qn0z6xgy883A-1; Wed, 21 Apr 2021 21:16:52 -0400
X-MC-Unique: mQGnjFGFN1qn0z6xgy883A-1
Received: by mail-qk1-f197.google.com with SMTP id r129-20020a375d870000b029029db870f0easo10895893qkb.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 18:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XFnN2bqFK9UPgJTphfDgcHT3qr8qmbD8e/7QuCKFZRE=;
        b=NUyJyfk/K7o6/Y/GvxTzAov6WGNV0hsr4Wy5e+IPD4ghkz/7iYBf30W1C9Qxp8GUO5
         meyee7OywBjKtuha8sBxrudFIu2sYcrsGDzx9vJQUmrgZnc2CT71byPQIJjFSWYU+xCO
         KSetJ3FkRW5Q/4WZBkuJ83p6Z/hTEoTVPzE4iSTDhMNSOGmyLYVf2jrDpfj33sQc9ocE
         Kjq1sEilYDLxdOudrjR7EQVW1VRyhc6jSBX6LK0mKRz9trpazgCTeXAHb+uq3xTFHih2
         3u+Ve5bsyScL8Il79lQCNd6acXU4HuPFA3rjhlobY0CYKv9SM1KWNLmLxGOnQU1d43QJ
         uh3Q==
X-Gm-Message-State: AOAM532gZZQLyTzXrV7QmL3E3+N/dY6WVrH61K/Y2pFBzEwCHf4ZO4md
        JJsun0O5oujzpINXei8qgnwLoh4LqtD9Df2zntuCQMfQG9UdRaIok6YEQ58nsHaGZAj+/6iO/Be
        sAnOHS4HkRlueegnk5WsdlD9t
X-Received: by 2002:a37:8744:: with SMTP id j65mr1180684qkd.304.1619054212097;
        Wed, 21 Apr 2021 18:16:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFgO+vn1DxvxP6Cy9Getpc/El869jXk+gall8+vOS1iR3TOOVL3Cg0Yrodm7EDBFytZ5fJfg==
X-Received: by 2002:a37:8744:: with SMTP id j65mr1180669qkd.304.1619054211912;
        Wed, 21 Apr 2021 18:16:51 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id j9sm1142078qkm.10.2021.04.21.18.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 18:16:51 -0700 (PDT)
Date:   Wed, 21 Apr 2021 21:16:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/23] userfaultfd-wp: Support shmem and hugetlbfs
Message-ID: <20210422011650.GC6404@xz-x1>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210421160352.GJ4440@xz-x1>
 <e75874bf-188b-0aeb-c548-01fc3e33bad4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e75874bf-188b-0aeb-c548-01fc3e33bad4@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:39:38PM -0700, Mike Kravetz wrote:
> Sorry Peter, always get preempted with something else.

No worry.

> 
> I'll start looking at the hugetlb specific changes and back my way into
> swap special pte support.  I feel qualified to review the hugetlb stuff
> and hope others will join in on the common infrastructure changes.

That'll be great; thanks Mike!

-- 
Peter Xu

