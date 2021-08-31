Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F31A3FC3EC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 10:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240011AbhHaHop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 03:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239908AbhHaHon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 03:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630395827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=15PBX2yOi5tPLhGBJ3hiEPEVIZyqqoOP2n8un1ckZwc=;
        b=UtyUrT5DSWZ7jZLIU6idTvi5SH1qcWew0PypakgMsKGJ0Bser3ZX5sVDeFfzpkpA/FLVlb
        XjZ2d/nQ3hH+GNo7ZZK0A2AoIXgSadQCX6XxOmo7xvBbLt2zZ7z/g9zC3dX0nj6qIRF3B0
        HNNy3l5OM4Kcerke+jRlrJ3t6JKPzGU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-EStIT3HTM76-AhuLhYY-Hg-1; Tue, 31 Aug 2021 03:43:45 -0400
X-MC-Unique: EStIT3HTM76-AhuLhYY-Hg-1
Received: by mail-ej1-f72.google.com with SMTP id ga42-20020a1709070c2a00b005dc8c1cc3a1so2215878ejc.17
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 00:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=15PBX2yOi5tPLhGBJ3hiEPEVIZyqqoOP2n8un1ckZwc=;
        b=HA76YA5VOaFZ1eDW6QPJPjnxuO3ivQcYzI3YVSWg1vREC33xLFJaEo9ZPMtbG9UTwt
         9Dct8cMC3gAf+Uez1ECxdGkPEU4EbklZEca8rZQJ2Dr1zh8tlgZCfUtu9E58S+iSpVJe
         QA1haGuQXcjWfSRlz2Xdlzb3luTxnZu1kvZebewoiCudaAWgODYda58OTsfQbIcMKIF1
         7X7NPe2mvv4/A8xHOktH4cmAO8k7BUSDJgPrl1YySxgYaIj2wFJ00LIjja56m4r2ADPT
         xXhoTrb48BC/oC+LTfhwBzZ2p5X0cRV7samjgeWxdhYRbJALUFeDKPrXJFV70dsw24sF
         15zg==
X-Gm-Message-State: AOAM532Nz5ibcQTbY0GIqNPs2aaZUqrO5qgzj3IplLSMQZi4bNEUZVKl
        c7DQgbgwNHjkn1xXz2BFFPYCjfKabt4bBH+fIjiOTZdQOr/+Y4JGNV0slqpZMYJX06V3+uKy23s
        mjdyBLK1OzEzPHd/vJstmyzAG
X-Received: by 2002:a17:906:a01:: with SMTP id w1mr29482766ejf.117.1630395824702;
        Tue, 31 Aug 2021 00:43:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7MtdjI8o1VZXCbnzLBNcGiS8PwS9GtflTAom1HaHa12cMI48iDS7D5rGq8eKSV0deHgXKoQ==
X-Received: by 2002:a17:906:a01:: with SMTP id w1mr29482749ejf.117.1630395824465;
        Tue, 31 Aug 2021 00:43:44 -0700 (PDT)
Received: from steredhat (host-79-51-186-21.retail.telecomitalia.it. [79.51.186.21])
        by smtp.gmail.com with ESMTPSA id u4sm3176037ejc.19.2021.08.31.00.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 00:43:44 -0700 (PDT)
Date:   Tue, 31 Aug 2021 09:43:41 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Andra Paraschiv <andraprs@amazon.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Alexandru Ciobotaru <alcioa@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kamal Mostafa <kamal@canonical.com>,
        Alexandru Vasile <lexnv@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm <kvm@vger.kernel.org>,
        ne-devel-upstream <ne-devel-upstream@amazon.com>
Subject: Re: [PATCH v3 2/7] nitro_enclaves: Update documentation for Arm64
 support
Message-ID: <20210831074341.e74quljmvp36gy5a@steredhat>
References: <20210827154930.40608-1-andraprs@amazon.com>
 <20210827154930.40608-3-andraprs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210827154930.40608-3-andraprs@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:49:25PM +0300, Andra Paraschiv wrote:
>Add references for hugepages and booting steps for Arm64.
>
>Include info about the current supported architectures for the
>NE kernel driver.
>
>Signed-off-by: Andra Paraschiv <andraprs@amazon.com>
>---
>Changelog
>
>v1 -> v2
>
>* Add information about supported architectures for the NE kernel
>driver.
>
>v2 -> v3
>
>* Move changelog after the "---" line.
>---
> Documentation/virt/ne_overview.rst | 21 +++++++++++++--------
> 1 file changed, 13 insertions(+), 8 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

