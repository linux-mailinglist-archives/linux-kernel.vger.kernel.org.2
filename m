Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDCB3E84D2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 22:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbhHJUy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234774AbhHJUyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628628863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PquKaDcRR+YnvRs9ZlK0t/qXSTbz8AOV/mTyg3IQF/A=;
        b=Qmzhs+g9Hy8Hg0iEUVDqquZC3SLG9Mz3+6z/XzUTpp0NOOjDAEgFm2NWhtiXmHj+X/5TMq
        jNPQCPWQVke6NUGhj5NXp/Tye5VldjXKh50bavXoMtOmICA55g4iQVNgtnUyXYLw93PwEZ
        uSE5TPPG58BYtVLB9WifFRq//PB0/GI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-nRDIJ3nDNY-osH-Tv8nU7w-1; Tue, 10 Aug 2021 16:54:21 -0400
X-MC-Unique: nRDIJ3nDNY-osH-Tv8nU7w-1
Received: by mail-qt1-f197.google.com with SMTP id k18-20020ac847520000b029028bf7425a59so111622qtp.22
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 13:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PquKaDcRR+YnvRs9ZlK0t/qXSTbz8AOV/mTyg3IQF/A=;
        b=iH1/dP031iln0o0FwHrjr+8vYXGhRoJiUinpkNpRodo9w5KjETaZIOl/rM2yZIppan
         6rz48kyyO5MeXLkqhevsFVKy4XWLOqgOYxnKWDoGbmHOFx5ShmEd8Fs/7fVVsbqg8E7a
         PoyTh17dRE3zXrxVS/WK5pt2KvoWUAQC2l77aTgSowP8vTpc6JikH3hnYYWIaHEP0VP6
         vQ+Y0eAmFEfsdPiJngblGdtpwFRq33lXcbDZ0U2FgFefdCkrrtmBtevPAiFkVbJMkbOd
         EFWGLrqLZ/tk5nqvQwhzWsDVEnfLnKaQMl7PMAB5eIrWhhbC6AJMxwR9ewY/vGQI2FdY
         0BSg==
X-Gm-Message-State: AOAM532Q2z6efwTzz6cysxFvRu4zt673RosfkmlX8XirnjgfX5///3L6
        GQq9UPJXIN+JWNHnpj9Nt+oXtGsHR7aN/m6XAzaqSdohItXRHnlZFVDwqDvMEt+NwrYqNAav0e6
        EP7f1fgcmJwEGJ5i1UZ9jDL5a
X-Received: by 2002:ad4:4087:: with SMTP id l7mr19752201qvp.37.1628628861321;
        Tue, 10 Aug 2021 13:54:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlooYZ0bGnYWz+gubLVP7tQocXuPUGfuPLGffaVUsAiveZD1nvQNJY3yVfdejJ0U+6prnPBg==
X-Received: by 2002:ad4:4087:: with SMTP id l7mr19752183qvp.37.1628628861100;
        Tue, 10 Aug 2021 13:54:21 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id m197sm11541159qke.54.2021.08.10.13.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 13:54:20 -0700 (PDT)
Date:   Tue, 10 Aug 2021 16:54:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 7/7] vfio/pci: Remove map-on-fault behavior
Message-ID: <YRLne7/S1euppJQr@t490s>
References: <162818167535.1511194.6614962507750594786.stgit@omen>
 <162818330190.1511194.10498114924408843888.stgit@omen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <162818330190.1511194.10498114924408843888.stgit@omen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 11:08:21AM -0600, Alex Williamson wrote:
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index 0aa542fa1e26..9aedb78a4ae3 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -128,6 +128,7 @@ struct vfio_pci_device {
>  	bool			needs_reset;
>  	bool			nointx;
>  	bool			needs_pm_restore;
> +	bool			zapped_bars;

Would it be nicer to invert the meaning of "zapped_bars" and rename it to
"memory_enabled"?  Thanks,

-- 
Peter Xu

