Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF1E376869
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbhEGQHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230154AbhEGQHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620403562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=exDzI0toEQnrKxpSqqM96ynL1UUkfrMPGn4b5uDRQHM=;
        b=H+PcirWP3Nr4PmoHcGzAdw8AFnclazWS5VHwUBCNZ8BfmeZCLad2ZAPCYiuojncxbMLFq3
        KdavJmh+L5EnbhijTNWsxj8xSG996cy8kc0MwW0q08bhKwwGBFjKCpAxhxapOyAhprgq1w
        67mm8pG0IQvTI+UT5wmwKKjz1B4XbuY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-4uDbRw_0O4CpBGhwufc1Mw-1; Fri, 07 May 2021 12:05:55 -0400
X-MC-Unique: 4uDbRw_0O4CpBGhwufc1Mw-1
Received: by mail-qt1-f199.google.com with SMTP id s4-20020ac85cc40000b02901b59d9c0986so6017757qta.19
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 09:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=exDzI0toEQnrKxpSqqM96ynL1UUkfrMPGn4b5uDRQHM=;
        b=e/zVlObAIsvh+BvnDIlCSleQdXMRvwg2VQn3Qdi0WBdRR9Tskwa8fXH8IITPhgMWrf
         Ix/hW6z0OgLaEvyesE9db1INRAP4JUloBsIyequUOG9RwLZ2nypjWAIvznEBDTfd33VY
         T8/h5VqjGN10jkYTNVTQUVzIR1nr5o/Pul0Rgnc6zpjardFRhjB08RDPM07J6tx6UiR+
         aVgUrzu1nGV0quJe7Hnb2DcawiCwvAaFh4o+MMgeK+HzUd/e0XoYB4h8XfsAA5YXqGQQ
         YrF8/TyjnF9aAf7nw1vj5KOehZrnJP1b+x2IDMWNA7DVnbwcsYiaTwz8ya/qbY5Irl26
         NC2A==
X-Gm-Message-State: AOAM533uJfE051ySTEyaUAYUq6VZi4HMgByF9WUNHp9bIUQHHhcjkdpi
        If2NOZcPVxS4ZYxf9ftYVVz4lMQsT7QLgb4gXZsWC9qosPoXNu2WRaWQo8rPU/D5rf5AmB0rmyh
        EnaZfj1OVHm5G3spnMyYTQszp
X-Received: by 2002:a05:620a:1098:: with SMTP id g24mr10313570qkk.234.1620403555533;
        Fri, 07 May 2021 09:05:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcnKXIHzwtnLu4ZyXIgG4I3Y8pAeYDcvHgnZEeseskf/oFJ6/9IEEF74oZcJrtpEwmiLmkUw==
X-Received: by 2002:a05:620a:1098:: with SMTP id g24mr10313532qkk.234.1620403555312;
        Fri, 07 May 2021 09:05:55 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id u190sm5250159qkc.18.2021.05.07.09.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:05:54 -0700 (PDT)
Date:   Fri, 7 May 2021 12:05:53 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 0/6] mm/uffd: Misc fix for uffd-wp and one more test
Message-ID: <YJVlYSnm7JRePaZ+@t490s>
References: <20210428225030.9708-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210428225030.9708-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 06:50:24PM -0400, Peter Xu wrote:
> This series is based on (mostly) v5.12-rc8-mmots-2021-04-21-23-08.  It tries to
> fix some corner case bugs for uffd-wp on either thp or fork().  Then it
> introduced a new test with pagemap/pageout.

Sorry I forgot to mention this series is also based on the other selftest
cleanup series applied upon the rc8 tag:

https://lore.kernel.org/patchwork/cover/1412450/

-- 
Peter Xu

