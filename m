Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F464126A2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 21:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346506AbhITTLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 15:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344983AbhITTJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 15:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632164861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L5eNIsZ6KwBeoWOsBqwSADzC++5/odqrtaTxVloBqSU=;
        b=K2MHHcgpn6Mbnz6ibmG2BskuyeP+T2gGBVN05AxgsOHuUbVSzDz15fk+jZ8yLoR7G8MMBn
        VPNbstL3QZkqZwA8D0XGZFynYRXoCNKuzwL58W0AX2eO+qYdp0rtbsLl5aZd3OmwpDzWSx
        OSU76jYF7cLcvYcybCHUPHXh0gNRk/k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-zFmK0n92N5-js4EZw1IPMA-1; Mon, 20 Sep 2021 15:07:39 -0400
X-MC-Unique: zFmK0n92N5-js4EZw1IPMA-1
Received: by mail-qk1-f197.google.com with SMTP id h10-20020a05620a284a00b003d30e8c8cb5so143833181qkp.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L5eNIsZ6KwBeoWOsBqwSADzC++5/odqrtaTxVloBqSU=;
        b=jQnAXs0U0Tu7uTedaSJBv0o1OzjRiyK6Ysf2l/N4fqCAqEsMsIpaITbDcqXzKFrnT6
         V0SXyx52N3wTCtgo+vu4WRBMktI2FO2djLS5SJzvEG/Xd+U4e0dmCPZsikd2yg5B0AwO
         f0eM8Ha/FJj2G6t7rZs3RxdK5KDaKbb+QiRWBB85VxhbIKvTHZH2rXPbFXVlKgEP38m0
         pkVpXRjyy6jWO9yvegkS6scubSo4O66rAf03RfBllVQ9O8fOJbCykT0NMyqlDYuK7n5C
         rgSyO2vCJ4X7GaZK/U9DlaZs+vn+zYNSOu0Fl6wCjJUS47caXPmUeCnq2pOnQg3wUzEV
         LRKQ==
X-Gm-Message-State: AOAM533EgGB1zryaewteHgoi3U5ZqDkv97aLz87LrTmycfjTMuUTnV4I
        ZThRwerHx9/SwzYJu7WTabmUZgWw2ZdQWgRW1F+1MXcdSyWyR0X7vwMSNf3XHoxTWWyIhZLqXaA
        MJpvqVWXzuScfdSXaqFmyiCOm
X-Received: by 2002:a0c:8e05:: with SMTP id v5mr26551516qvb.4.1632164858623;
        Mon, 20 Sep 2021 12:07:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUlhdb4yrs33oVaLc7KkLYEJohXWSRUXFQ1m3xANX2pAOEfK2wxqguR0SBw9ODXLL6u6zTSA==
X-Received: by 2002:a0c:8e05:: with SMTP id v5mr26551482qvb.4.1632164858305;
        Mon, 20 Sep 2021 12:07:38 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id s10sm11731979qko.134.2021.09.20.12.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:07:37 -0700 (PDT)
Date:   Mon, 20 Sep 2021 15:07:35 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ivan.teterevkov@nutanix.com,
        florian.schmidt@nutanix.com, carl.waldspurger@nutanix.com,
        jonathan.davies@nutanix.com
Subject: Re: [PATCH v2 1/1] Documentation: update pagemap with shmem
 exceptions
Message-ID: <YUjb91tWhd/YAgQW@t490s>
References: <20210920164931.175411-1-tiberiu.georgescu@nutanix.com>
 <20210920164931.175411-2-tiberiu.georgescu@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210920164931.175411-2-tiberiu.georgescu@nutanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiberiu,

Thanks for the patch!  Yes it would still be nice to comment on this behavior,
some trivial nitpicks below.

On Mon, Sep 20, 2021 at 04:49:31PM +0000, Tiberiu A Georgescu wrote:
> +In user space, whether the page is swapped or none can be deduced with the
> +lseek system call. For a single page, the algorithm is:
> +
> +0. If the pagemap entry of the page has bit 63 (page present) set, the page
> +   is present.
> +1. Otherwise, get an fd to the file where the page is backed. For anonymous
> +   shared pages, the file can be found in ``/proc/pid/map_files/``.
> +2. Call lseek with LSEEK_DATA flag and seek to the virtual address of the page

s/LSEEK_DATA/SEEK_DATA/

> +   you wish to inspect. If it overshoots the PAGE_SIZE, the page is NONE.
> +3. Otherwise, the page is in swap.

It could also not be in swap, right?

Example 1: this process mmap()ed an existing shmem file with data filled in,
but without accessing it yet.  Then the page cache exists, not in swap, but
pgtables will be empty.

Example 2: this process has mapped this shmem with 2M thp, all data filled in,
then due to some reason thp splits, then the pgtable can also be none but lseek
will succeed, I think.

So to further identify whether that's in swap, we need a step 5 with mincore()
system call, perhaps?

-- 
Peter Xu

