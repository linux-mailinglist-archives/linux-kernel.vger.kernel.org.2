Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38FF3C66CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 01:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhGLXM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 19:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231953AbhGLXM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 19:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626131377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ncUzG7oD+cRuBPSNikH54792RGrvr4Fe/3Hos8E3uks=;
        b=T9MbOaMrqioeCIHaPOkM8huVydSrj35IMGIsqlromCU0R26vxO3Pj+Zgtya+m+rLGCg5dK
        Dm2DpaTOAdxV93+nBWPUDBGZjY8quEl4ZM8Xno6Ek8+wVNhx0vfUgXUq7P1tQyB1GKjm0j
        1Q56vTrCKaG6aAn7EUI/EejZV+UBN7s=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-8hX3-pz5PKyUvV90FwmKkg-1; Mon, 12 Jul 2021 19:09:36 -0400
X-MC-Unique: 8hX3-pz5PKyUvV90FwmKkg-1
Received: by mail-oi1-f200.google.com with SMTP id w2-20020aca62020000b029024073490067so14067053oib.21
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 16:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ncUzG7oD+cRuBPSNikH54792RGrvr4Fe/3Hos8E3uks=;
        b=U9YNytHMMbpbBeZK/y8vNhbMmC8lTzuC7uul3Tokhd4N6tnlirbilx7byBm7oFHqT+
         q8DovIu37Wf5bGhBzR+HeJl5CLm+WQeo+CO8WRg75deE1s723biMuqDaNFvjDo4pbHr1
         eXXtII/9jNl1zrbHb8l2gqoSBkQ7A6D5/xgH4DeeLK/FkyePmlvLesz8KZTiACr5r+EH
         /hhpfnbaSwKfIS8c0Im5f3rTu80KqdzFEK+JNnTj1gyu3OGBWCTmSfswPECADkukTNzu
         xYiZV5vmDChZvB6CV1iEkwlDjilf0M4XDm9SUgYLMk0owehjMxSns1OZTGg8AXTdBN4D
         dMlA==
X-Gm-Message-State: AOAM5329VSN+c6oRDeBPHczqDip13xUZJ62n9bs9iK4j0bF9AfA8V45i
        Wv/sPBQuSz4kaU45mO02enCnO1x+TQYhdOeyB7+wxZTrvbGVJ6UwZJv6BdPC9DZNFX7vewYw/7p
        e13fExz/ZzkFXjPAVTn323QmK
X-Received: by 2002:a54:438f:: with SMTP id u15mr12421722oiv.107.1626131375430;
        Mon, 12 Jul 2021 16:09:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf9OMLGHwJk5r+6cOuZb4j5x61M5JyJUaq4Ttbl9dxhduUH51eWgeVjM/8TiHf0dlltpaqyg==
X-Received: by 2002:a54:438f:: with SMTP id u15mr12421718oiv.107.1626131375310;
        Mon, 12 Jul 2021 16:09:35 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id r24sm1026885otg.14.2021.07.12.16.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:09:35 -0700 (PDT)
Date:   Mon, 12 Jul 2021 17:09:34 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 6/8] PCI: Setup ACPI fwnode early and at the same
 time with OF
Message-ID: <20210712170934.34666a1f.alex.williamson@redhat.com>
In-Reply-To: <20210709123813.8700-7-ameynarkhede03@gmail.com>
References: <20210709123813.8700-1-ameynarkhede03@gmail.com>
        <20210709123813.8700-7-ameynarkhede03@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Jul 2021 18:08:11 +0530
Amey Narkhede <ameynarkhede03@gmail.com> wrote:

> From: Shanker Donthineni <sdonthineni@nvidia.com>
> 
> The pci_dev objects are created through two mechanisms 1) during PCI
> bus scan and 2) from I/O Virtualization. The fwnode in pci_dev object
> is being set at different places depends on the type of firmware used,
> device creation mechanism, and acpi_pci_bridge_d3() WAR.
> 
> The software features which have a dependency on ACPI fwnode properties
> and need to be handled before device_add() will not work. One use case,
> the software has to check the existence of _RST method to support ACPI
> based reset method.
> 
> This patch does the two changes in order to provide fwnode consistently.
>  - Set ACPI and OF fwnodes from pci_setup_device().
>  - Remove pci_set_acpi_fwnode() in acpi_pci_bridge_d3().
> 
> After this patch, ACPI/OF firmware properties are visible at the same
> time during the early stage of pci_dev setup. And also call sites should
> be able to use firmware agnostic functions device_property_xxx() for the
> early PCI quirks in the future.
> 
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> ---
>  drivers/pci/pci-acpi.c | 1 -
>  drivers/pci/probe.c    | 7 ++++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Looks ok to me.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

