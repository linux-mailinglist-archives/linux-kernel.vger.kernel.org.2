Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223E63D3506
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbhGWGZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:25:08 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:33318
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234254AbhGWGY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:24:58 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id D4B493F345
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 07:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627023926;
        bh=nfkPx7NC5zaeXceVlyVGlTHRL5ArI5NO9jvFKmnisTY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=uvrH6AvZOq1wRvT1Bd8/SfOxzDlUfB1BHR1wawlqi/NdJeikPUd7XLty6QwnQUU/Q
         KmPDnkxPkGWG8o7m7YVSZ9yov8oVMmMbaMxqMDdPRtUxWxHler3Dg0QtiyFPZs9t2I
         KYDfwoC/KWiYJBeTQEqPndVz1lU3p8GiHIOFquUtupJn6wznZccBqT3HenWSRlEtb+
         uG2Mq+Sm4zb+GHhs+XCC+p9gqWZywaj9V2jL3uhGvvTtNCA/XnMQRlw7XifC4NwTb0
         bcVXU4j//wcTgoOMtvRwINl1NGUaKvUxSWvfdaGDmyI7pPaa/5jMgcklFVGrmjTIcQ
         HQZzr8iCv7dWw==
Received: by mail-ed1-f72.google.com with SMTP id eg50-20020a05640228b2b02903a2e0d2acb7so232858edb.16
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfkPx7NC5zaeXceVlyVGlTHRL5ArI5NO9jvFKmnisTY=;
        b=V+RPkMJHw+Pt+7lBHchxkOhQLcfBLtz1uNu0dT3/wXW8rBGyS5GmWUnMrlJEMHsHG7
         SX4AE8kZ8It5P21rIthFRobDv3l/7Q2tJwM0jAfpqlV4E5UAxBmWCWgM+QfCCkiXYhbm
         9NrsQ4Ca/38DyXYU2Z/S+CkIwub3PTpTwEMopopBfTfyaOFrcIbKVK40Y5KuGhuQoNjj
         C5VoJbuGyw3jXlYsq9JJDoo6PiCf2mySEbJdY+QY/lZy9G+z7wL/Otr51lEQAxxBmReb
         n1U79V8sFXCizUYvjjtOaX+xwDXPxeY2zaK4i0JhZA5CJAA5HEavuGeZgKS1Gs2vLPeD
         Z15g==
X-Gm-Message-State: AOAM530Zup1t0exwRwIMGrgaJOnejnOVExt00Gjj9BByVmmR1YnJRPZQ
        1Ce3a0K8S7G6oRH+BHaGtc0EcSeJXFirroBHRgf9KJberhP+2DLOFu2Z5ofoFFx/Hm4QFmGikjM
        GwYba4mfnUo09Tu+VOByozffFkfRoohcArdIpG2Xy8vJfHLXm2ND6n/e/XQ==
X-Received: by 2002:a17:906:f0d8:: with SMTP id dk24mr3430030ejb.432.1627023926312;
        Fri, 23 Jul 2021 00:05:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnwrE3fibwAyd5puLQhhkBI3cJ/iZwBYnuPqRykg2M2+jR/0WQUB0/5z1/f5dPMa0hH/lPTm/THgVMa/6SzKQ=
X-Received: by 2002:a17:906:f0d8:: with SMTP id dk24mr3430007ejb.432.1627023926038;
 Fri, 23 Jul 2021 00:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p6VN0ejKHcTRgj8mZ_iApR=KogpVZ-HkvdoZbJ=Yue98g@mail.gmail.com>
 <20210722222351.GA354095@bjorn-Precision-5520> <YPpShrTa448OpGjA@infradead.org>
In-Reply-To: <YPpShrTa448OpGjA@infradead.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 23 Jul 2021 15:05:12 +0800
Message-ID: <CAAd53p75d=ibfFRCLmYOMvfrn7XbDajby1shKdWQWW=DOrX3uw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI/AER: Disable AER interrupt during suspend
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "open list:PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 1:24 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Jul 22, 2021 at 05:23:51PM -0500, Bjorn Helgaas wrote:
> > Marking both of these as "not applicable" for now because I don't
> > think we really understand what's going on.
> >
> > Apparently a DMA occurs during suspend or resume and triggers an ACS
> > violation.  I don't think think such a DMA should occur in the first
> > place.
> >
> > Or maybe, since you say the problem happens right after ACS is enabled
> > during resume, we're doing the ACS enable incorrectly?  Although I
> > would think we should not be doing DMA at the same time we're enabling
> > ACS, either.
> >
> > If this really is a system firmware issue, both HP and Dell should
> > have the knowledge and equipment to figure out what's going on.
>
> DMA on resume sounds really odd.  OTOH the below mentioned case of
> a DMA during suspend seems very like in some setup.  NVMe has the
> concept of a host memory buffer (HMB) that allows the PCIe device
> to use arbitrary host memory for internal purposes.  Combine this
> with the "Storage D3" misfeature in modern x86 platforms that force
> a slot into d3cold without consulting the driver first and you'd see
> symptoms like this.  Another case would be the NVMe equivalent of the
> AER which could lead to a completion without host activity.

The issue can also be observed on non-HMB NVMe.

>
> We now have quirks in the ACPI layer and NVMe to fully shut down the
> NVMe controllers on these messed up systems with the "Storage D3"
> misfeature which should avoid such "spurious" DMAs at the cost of
> wearning out the device much faster.

Since the issue is on S3, I think the NVMe always fully shuts down.

Kai-Heng
