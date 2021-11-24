Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A745CDB0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 21:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbhKXUPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 15:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhKXUPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:15:51 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E52C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:12:41 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id u22so7858309lju.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7soODcy9g9USyAcnsCV+bLWbMatBSsTCHZqUXUXsSj4=;
        b=Yms4+zGyu39UCWV++S7CaSRQGeVCEmSMEz3gocFHBCOuDmBYty1vgMvqYewwqeLCZD
         ZHm7NWjxJdoJbRuweJb9vapELXAsEGKkoWn1aDgKBAJeGd2m78XKk0S/SM3kBunfcD1m
         VtKJpqOzOBLaIdndK9yi/b3IJuNSIWngX/Sy3hMrAf45dXw2U3t5jVMOL2DWILFp35z5
         7ylFYlqWT4QPlJPjfwBcHkMA05BXDtRzaBXL2dGolvos7e6IS9ElM5A2tdISbioMLqZ2
         S5ZcC/YKBthw2T3/qGwtjNIorvEXWqbSPNOvluDKt34zOzfdJnSfsEoCr0KaXYruj3x0
         UoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7soODcy9g9USyAcnsCV+bLWbMatBSsTCHZqUXUXsSj4=;
        b=wXZoi00G24CqVU5YQ7bl344nwnpOUrAjl23UwkOr3zkr5cjkDi2WYr7+qHRrnhOjxq
         9XbcNQb2f63nv/jjkZP9K96ag//+agKkFjfowYplAjpKCBkPVKT6HWUf1up3QS3SHhDA
         1vq1TEVMs+aiIRh1XvyaXBCDkYtKA8F6V3+DWYajiBPqMu7DKj1/OTQQDlLPeXuwnNR5
         OusMEDpiy88CFS/gLTeUIaCG2ChY/AUqHsk6540+Q2ux6DGV8h4wP6EBpN7uXMottSq4
         X/S9zVLyYmsrtL6CnaLYZJX9OKwhs8VTVVkQCVWaoW0xscvAxAEmkhIEU7oegqXT+Dk1
         X1NA==
X-Gm-Message-State: AOAM532YQr1Q54sKrSQTD9XlYDcLL3iajaOkPbNgU3mEgdkd0r9WVKeo
        AbRQuXDSNsZKGK34183qZUriwQ==
X-Google-Smtp-Source: ABdhPJzgCSYUjymEFFnyubOSAooaM8Jh3QpVKGVONm86IcfnDTxWfeicEF/z4JhlZpaT4d0FbGn+qg==
X-Received: by 2002:a2e:97c7:: with SMTP id m7mr19495389ljj.134.1637784759805;
        Wed, 24 Nov 2021 12:12:39 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y11sm87202ljh.54.2021.11.24.12.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 12:12:39 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id D0083103635; Wed, 24 Nov 2021 23:12:38 +0300 (+03)
Date:   Wed, 24 Nov 2021 23:12:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: thp: update split_queue_len correctly
Message-ID: <20211124201238.3xzpy2b5zcv7j23s@box.shutemov.name>
References: <20211123190916.1738458-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123190916.1738458-1-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 11:09:16AM -0800, Shakeel Butt wrote:
> The deferred THPs are split on memory pressure through shrinker
> callback and splitting of THP during reclaim can fail for several
> reasons like unable to lock the THP, under writeback or unexpected
> number of pins on the THP. Such pages are put back on the deferred split
> list for consideration later. However kernel does not update the
> deferred queue size on putting back the pages whose split was failed.
> This patch fixes that.

Hm. No. split_huge_page_to_list() updates the queue size on split success.

NAK.

-- 
 Kirill A. Shutemov
