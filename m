Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63DB3E5E69
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 16:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241995AbhHJOxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 10:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234881AbhHJOxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628607178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekEuvzfZnyXdDySvWdnVn2xizC3vsgCvucSk9Xy3aGE=;
        b=gEXAaZt5jH9f5sKMw6TsASOKZQMvEdudvh4TWFDj4zxNPfndNPTQ/fVKDIlesosYQLaCkm
        +hY8t3lwcYDj2NA+a3N70Zf7JTnOMHvt2oZ9K9cSCw38WlFqUQrGD4C95DRXl7Qtzc0QNu
        caHIXUfmKNR7laLmrw8UGORHs4UXQ5U=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-4vbAfb0JPbaQs-B2KO4yqQ-1; Tue, 10 Aug 2021 10:52:57 -0400
X-MC-Unique: 4vbAfb0JPbaQs-B2KO4yqQ-1
Received: by mail-oi1-f197.google.com with SMTP id bf27-20020a056808191bb029026778435932so4040861oib.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 07:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ekEuvzfZnyXdDySvWdnVn2xizC3vsgCvucSk9Xy3aGE=;
        b=kqBe1aQfOMyU0irTM5yQGCoL2fuNweYtNStvYvRjfNqUQn/HEDhn+kXGSF5V0tUmKd
         3NINHg8S3NWk9wLOMma31cNr6ut/LYvIQROW+zcddKoyh3iyzWlMKBikZQzBLT6FfHFL
         rwg3cDBatAkNEkhma+k6kSIQVnBDVEyPIBuf+2MU5iltZH8IWtMcqrPyvw5g7OfeNBHE
         GNjypTFKHykuE1fd7DQDS2h8EOzkYaXXo6tORVBUWnPjW5BmdaAbo6Lw1WW0s895mG87
         ATIxVvHkpMbmN4j3uvR9hnhFthlZqglT5GMuMsNqH0DSBaSiRwtduzcozblfkJ0M+F/a
         9B2g==
X-Gm-Message-State: AOAM532mFCXvyrDLvJckyZALA2DgXbrUsCoZ5O5gMJ4jvzSW51eQl8+y
        MNUs/RCmZve+Exy5HfA7ZtGo/tyeSuyBIjy9M+TSQ2ulvzzSv0/77cYU+lKHTz7Mg3WCh0T4eB7
        s8Zkkjrs4qcJDLmemIXnbaPQC
X-Received: by 2002:a9d:65d9:: with SMTP id z25mr10321642oth.200.1628607176522;
        Tue, 10 Aug 2021 07:52:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5U3PkziXWQue+MNkIOceNv+9XivDBQIBIxcuIGM5MTxDrOa75HV/5J98PWs4/7O8GRuxFoQ==
X-Received: by 2002:a9d:65d9:: with SMTP id z25mr10321623oth.200.1628607176318;
        Tue, 10 Aug 2021 07:52:56 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id 89sm3864023ott.19.2021.08.10.07.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 07:52:55 -0700 (PDT)
Date:   Tue, 10 Aug 2021 08:52:54 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, peterx@redhat.com
Subject: Re: [PATCH 1/7] vfio: Create vfio_fs_type with inode per device
Message-ID: <20210810085254.51da01d6.alex.williamson@redhat.com>
In-Reply-To: <YRI8Mev5yfeAXsrj@infradead.org>
References: <162818167535.1511194.6614962507750594786.stgit@omen>
        <162818322947.1511194.6035266132085405252.stgit@omen>
        <YRI8Mev5yfeAXsrj@infradead.org>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 10:43:29 +0200
Christoph Hellwig <hch@infradead.org> wrote:

> > + * XXX Adopt the following when available:
> > + * https://lore.kernel.org/lkml/20210309155348.974875-1-hch@lst.de/  
> 
> No need for this link.

Is that effort dead?  I've used the link several times myself to search
for progress, so it's been useful to me.  Thanks,

Alex

