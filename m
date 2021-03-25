Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB2B3498C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhCYRzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhCYRzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:55:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D88BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 10:55:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x21so3428475eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SszvQ531+uD2WOPYhtL5YAjrwhpYcvb3yQNRuA0Ywb4=;
        b=wCDP/7yBK/xsqLRNiA6sjvp/w29nQg8GjGHwVNWvweNm2OhAfv0a0QwBLsD3iKvzEr
         dthbWbt/HigLvZh1banr11COMFI78WekR8WecCF4ej7H6qTNGvyd0gTknsC97wwVaRnK
         L2KfXQu83W5Qcy+rGuNS9Qn2n4zUbk4+B/z7/ZfFSo9tF/0BYB+YYsOpDbUC70VS3lb/
         V11GPWgpdpit39VgtQtDpOsufIexJkJDdN/bjMZxB7b+UUYyz93Or5zYV3WDVi9MQ1cx
         6jXrVtQEm6ffX2El4VBBW/orm6YEUaLl8Z/H8q1GskouILXcDmNddFvuDDrgqmoiQGTT
         /cLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SszvQ531+uD2WOPYhtL5YAjrwhpYcvb3yQNRuA0Ywb4=;
        b=T+ucQY8rGqGTsYrBvgYZO+ShTISNg3cwMJ9xJ9X7R318hDwnDuFCuFkMKV844l3PzV
         nExt4tU0ri4ht+3lzOe45hHaZlUlksitbQmDJf8d3bjQab3w2NmgHdEyQyD0EAix5UvN
         vOuXiBVaLMla31PpM/9K+H+Ut21VuUeGTitXE1irQDd8Tk1gF3E1emm9z8iQSJpsa+LB
         enIIKJgZ1Jl9Pb77Oettp9EcHy+ZhdzCO/8ahLjT6EffVGYLWEzezRKk+F+YhHYgRavi
         AX6dM/TLi1e4Y49axAk7OPEE6O/qH3FAr8lH+PNxjQ7BxEYz/qLAEGxqrAt+xSEBLvzw
         v0pw==
X-Gm-Message-State: AOAM531Bc2nVTojdsDud/5tSo7Es0G4Lcl0Y2DceW5yjTarsfEq9e+ep
        kVkETsXnxCF6KRI6JOpndEYL3PvA/MEcqVtgM2/qNg==
X-Google-Smtp-Source: ABdhPJynBnTvFsp7tfzUUv7Xah9IQACdloEpM+nVs5kOVFQwq+UENbVfzQevNPp4DLGAoArONj+G19xwFunzI02W6nI=
X-Received: by 2002:aa7:cd0e:: with SMTP id b14mr10724876edw.354.1616694912172;
 Thu, 25 Mar 2021 10:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YFwzw3VK0okr+taA@kroah.com> <20210325082904.GA2988566@infradead.org>
In-Reply-To: <20210325082904.GA2988566@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 25 Mar 2021 10:55:01 -0700
Message-ID: <CAPcyv4jfq7pqvdKinYJ2wSLSNEa0fmOgCGWjTCpwhgTTpGyY=Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: Allow drivers to claim exclusive access to config regions
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 1:29 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Mar 25, 2021 at 07:54:59AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Mar 24, 2021 at 06:23:54PM -0700, Dan Williams wrote:
> > > The PCIE Data Object Exchange (DOE) mailbox is a protocol run over
> > > configuration cycles. It assumes one initiator at a time is
> > > reading/writing the data registers.
> >
> > That sounds like a horrible protocol for a multi-processor system.
> > Where is it described and who can we go complain to for creating such a
> > mess?
>
> Indeed.  Dan, is there a way to stilk kill this protocol off before it
> leaks into the wild?

Unfortunately I think that opportunity was more than a year ago, and
there's been a proliferation of derivative protocols building on it
since.
