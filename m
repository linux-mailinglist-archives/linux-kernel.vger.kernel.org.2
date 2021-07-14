Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF593C941D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbhGNW7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237252AbhGNW7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626303388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p53AiDq4RRf5s7Uh7mGyD6/R6lQu0pl6+URNGF7eeJg=;
        b=XL2mBR+3yVDMmwBxEAC2hCfs5f1q08TtP++VAZxkLV0an87ImUf0IT6rZdkb564Of1dzca
        nRNFVz7JBTJm5X7MZ1WCzzpIYMYyWUZ6znhZ0DfT0D3FI2LSRU9IQaRoEplL+6Pivcg3Hc
        aee8Xktnm9xrdKsWygaV1ich8l5s4yY=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-I1FCiPKFPLmDWmb2TzdSng-1; Wed, 14 Jul 2021 18:56:27 -0400
X-MC-Unique: I1FCiPKFPLmDWmb2TzdSng-1
Received: by mail-oi1-f199.google.com with SMTP id u30-20020a056808151eb029025a08429ca1so2197442oiw.23
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p53AiDq4RRf5s7Uh7mGyD6/R6lQu0pl6+URNGF7eeJg=;
        b=YjhB1RzOKEIoZ7INXqS5lTo6STyoFynQNW1WyiBNIYeAwZ5GSeglJBgSbUaGbM5ngi
         IjvkhgCavcJ+/pKqr1BfNyRia2aDZQ3yHScAFynO3YPHpQhhe7LhXad33v8ADG8d+wTv
         Wcv3WdrlOPrl9wP031y4bzKy6ZQhcJtAKEECiwy1EjtQ+7Bdwct9nfnzR02aLoy+B1GT
         aJjzXWC8aWAULJQXhX5wqPPSf24Zi9KCoBwE4kQd/f8MRcTXWm2qEGA2hr4G+/Vy30zL
         phmmOkpUaOYPctWQ0tZQdNA+L2NIDvZ/QkRm0tmIrLtxuYkYYISmIqHSYa/3Exq+nkqc
         p1uQ==
X-Gm-Message-State: AOAM533vKFW39KzRmJO9fy1X8C+0XHu0l9StJX/FjJBCJ6g/LDqajqOe
        AEAfsWt41qR8I4/H514c63puZZfYe9mzqXyRQVgapviOH+J4PN2ypTgaBvmr7DsJvTKlc2O8Y3r
        clcWbLAZBG1YFGvxmCnOxRktS
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr419769oti.75.1626303386330;
        Wed, 14 Jul 2021 15:56:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFKmf1VsQgh+UBBi+EvUXyhVVpNx63nHwBogYk7AYyZyKjx3X4wwKOQ8itqMq1hX+iXCyWMQ==
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr419761oti.75.1626303386189;
        Wed, 14 Jul 2021 15:56:26 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id x29sm665755ooj.10.2021.07.14.15.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:56:25 -0700 (PDT)
Date:   Wed, 14 Jul 2021 16:56:24 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Shanker R Donthineni <sdonthineni@nvidia.com>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 7/8] PCI: Add support for ACPI _RST reset method
Message-ID: <20210714165624.47272c2d.alex.williamson@redhat.com>
In-Reply-To: <e8f0b236-dfb3-c9cf-4683-c43e8bc0c0b4@nvidia.com>
References: <20210709123813.8700-1-ameynarkhede03@gmail.com>
        <20210709123813.8700-8-ameynarkhede03@gmail.com>
        <20210712170920.2a0868ac.alex.williamson@redhat.com>
        <e8f0b236-dfb3-c9cf-4683-c43e8bc0c0b4@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2021 19:51:41 -0500
Shanker R Donthineni <sdonthineni@nvidia.com> wrote:

> Hi Alex,
> 
> On 7/12/21 6:09 PM, Alex Williamson wrote:
> >> +/**
> >> + * pci_dev_acpi_reset - do a function level reset using _RST method
> >> + * @dev: device to reset
> >> + * @probe: check if _RST method is included in the acpi_device context.
> >> + */
> >> +int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
> >> +{
> >> +     acpi_handle handle = ACPI_HANDLE(&dev->dev);
> >> +
> >> +     if (!handle || !acpi_has_method(handle, "_RST"))
> >> +             return -ENOTTY;
> >> +
> >> +     if (probe)
> >> +             return 0;
> >> +
> >> +     if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
> >> +             pci_warn(dev, "ACPI _RST failed\n");
> >> +             return -EINVAL;  
> > Should we return -ENOTTY here instead to give a possible secondary
> > reset method a chance?  Thanks,  
> Thanks for reviewing patches.
> 
> ACPI/AML _RST method type is VOID. The only possibility of failure would be
> either system is running out of memory or bugs in ACPICA. There is no strong
> reason not to return -NOTTY.
> 
> I'll fix in the next version. Is there opportunity to include reset feature in v5.14-rc2?

Sounds good, it's a corner case but since we've got a series of methods
we can try and part of the point of Amey's series is giving the user
control of the order and methods to try, we might as well make use of
it.  I think there's also some precedence in the quirks that they can
fail and fall through to standard resets.

I'll leave any upstream timing questions to Bjorn, but we've passed the
v5.14 merge window when new functionality is generally accepted.

> Can I add your reviewed-by since no other comments to this patch?

Yeah, s/-EINVAL/-ENOTTY/

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

Thanks!

