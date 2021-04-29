Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5263F36EF8C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241080AbhD2Sjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241002AbhD2Sj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619721522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1FDmqgWkaEalBf06QFmezW699riW5RcrkfNE1Srusv0=;
        b=WeoRH7J16PszCdMGYY/74rRZfOMOBMZp4eTZ5Gr9nQPPNYOECD2NDFUGZJYF2y/vdXXtaZ
        DgHP80uLEWaJ5oDVpnFB8Z+tLCSCC5K27bN+Oa+SVhFm0norwAAQGchVLRdnVgx45eqBKg
        imYuC4quPvFNSsa5Sw+izVWPZ9yH8TM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-KULflg3ZMYuTjPiqnuX6dQ-1; Thu, 29 Apr 2021 14:38:37 -0400
X-MC-Unique: KULflg3ZMYuTjPiqnuX6dQ-1
Received: by mail-qt1-f200.google.com with SMTP id w10-20020ac86b0a0000b02901ba74ac38c9so15939185qts.22
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1FDmqgWkaEalBf06QFmezW699riW5RcrkfNE1Srusv0=;
        b=QSexk+suR32JnKYf7AzGTGnbljWcexrFTN+xE2s3lO9BMsQqXIWfPfzf3mnWgYKg0C
         F6l9CNo3h2Q4JoGpF+LynMXkXORzgY7uoczjVuRNWpwSPYAKA8x6+ofgHIYhyJi2Wf1i
         uEbkj9Mf/L70nGBMsuT/YWQDjOJDa6gweiMrk2+k9DZ+IUS3jBmsFUHqamEsIY4MKYzh
         S9f1siRDnGWo5rWTqlTw8meLkh5O+JA4AMVt0XKDVWNFTf9U2JGxMn1QFexSMH3pJbR9
         djuM75JFR8yDLG0bFdljPR58GAuq1GMyyhERN3fRyOzn08EO7NQcWki96O+tSd/9gy7+
         Bulg==
X-Gm-Message-State: AOAM533Ej/pqsJWnzSNXg1RmME88sOIT7yOPElqcJO9lgWW+f90I8Npc
        vkSe2uRVIu7QyDzZch8FixU/p1ULS2y9umdDYRPAVsOq0C/oWJzVb/OiRBlarZDQSqu6p4+I/Uc
        edrRlRc4x/Utaq31CEOhl4+of
X-Received: by 2002:a37:8703:: with SMTP id j3mr1126456qkd.308.1619721517488;
        Thu, 29 Apr 2021 11:38:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+QbuHIrkUNjZjHOfaVvF6309qJU1ww9koDsWD1bCSocJXPnBrvZ/keB1z4Aghlq84eZOD3w==
X-Received: by 2002:a37:8703:: with SMTP id j3mr1126442qkd.308.1619721517267;
        Thu, 29 Apr 2021 11:38:37 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v6sm1869037qkg.94.2021.04.29.11.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 11:38:36 -0700 (PDT)
Date:   Thu, 29 Apr 2021 14:38:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Simon Ser <contact@emersion.fr>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: Sealed memfd & no-fault mmap
Message-ID: <20210429183836.GF8339@xz-x1>
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr>
 <CAHk-=wgmGv2EGscKSi8SrQWtEVpEQyk-ZN1Xj4EoAB87Dmx1gA@mail.gmail.com>
 <20210429154807.hptls4vnmq2svuea@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210429154807.hptls4vnmq2svuea@box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 06:48:07PM +0300, Kirill A. Shutemov wrote:
> > Side note: this will only ever work for non-shared mappings.
> 
> I think it's show-stopper for the use-case, no? IIUC, the mappings is used
> for communication between a compositor and a client and has to be shared.

Yes I had the same doubt..  Besides, we probably don't want to convert all
VM_FAULT_SIGBUS to fallback to anonymous pages, as I see that vmf_error()
converts mostly everything besides -ENOMEM to VM_FAULT_SIGBUS.  Thanks,

-- 
Peter Xu

