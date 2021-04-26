Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1CD36B789
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhDZRGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235079AbhDZRGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:06:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FB1261026;
        Mon, 26 Apr 2021 17:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456748;
        bh=D36H//TAB02VktKEaoh4tKmvan9tPn6r7pdbQfpUrm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LgEJr4Ew7kpTXELanpa6X550y3BJ6xqPCv6fogOlO3WLoiKINPRp/pdTiHxn3+vad
         6EAtygNE89NOWRhopyAguQW3Pus5j9g+jhbNnzy7/birFl6h43brCBRxfi2Hvg8Sik
         Ipg1RFZIvYalaa8tGvCjDnYwAE/l5NadXLUgIlj0=
Date:   Mon, 26 Apr 2021 19:05:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Jubin Zhong <zhongjubin@huawei.com>
Subject: Re: [PATCH 020/190] Revert "PCI: Fix pci_create_slot() reference
 count leak"
Message-ID: <YIby6bWKOz88N3Oy@kroah.com>
References: <20210421130105.1226686-21-gregkh@linuxfoundation.org>
 <20210422044331.GA2907704@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422044331.GA2907704@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:43:31PM -0500, Bjorn Helgaas wrote:
> [+cc Jiri, Jubin (author of 4684709bf81a)]
> 
> On Wed, Apr 21, 2021 at 02:58:15PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 8a94644b440eef5a7b9c104ac8aa7a7f413e35e5.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: https
> > Cc: Qiushi Wu <wu000273@umn.edu>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Please do not apply this revert.
> 
> Prior to 8a94644b440e ("PCI: Fix pci_create_slot() reference count
> leak"), we essentially had this:
> 
>   err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, ...);
>   if (err)
>     kfree(slot);
>     return ERR_PTR(err);
> 
>   INIT_LIST_HEAD(&slot->list);
>   list_add(&slot->list, &parent->slots);
> 
> That was incorrect because if kobject_init_and_add() fails,
> kobject_put() must be called to clean up the object (per the function
> comment).  For pci_slot_ktype, the release function is
> pci_slot_release():
> 
>   pci_slot_release
>     list_del(&slot->list);
>     kfree(slot);
> 
> After 8a94644b440e, we had:
> 
>   err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, ...);
>   if (err)
>     kobject_put(&slot->kobj);
>     return ERR_PTR(err);
> 
>   INIT_LIST_HEAD(&slot->list);
>   list_add(&slot->list, &parent->slots);
> 
> This fixed one bug but exposed another: we correctly clean up the
> object by calling kobject_put() which calls pci_slot_release(), but 
> that dereferences slot->list, which hasn't been initialized yet.
> 
> But 4684709bf81a ("PCI: Fix pci_slot_release() NULL pointer
> dereference") fixed that problem by making it this:
> 
>   INIT_LIST_HEAD(&slot->list);
>   list_add(&slot->list, &parent->slots);
>   err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, ...);
>   if (err)
>     kobject_put(&slot->kobj);
>     return ERR_PTR(err);
> 
> This correctly initializes slot->list and cleans up if
> kobject_init_and_add() fails.
> 
> But if we apply this revert, we'll have this:
> 
>   INIT_LIST_HEAD(&slot->list);
>   list_add(&slot->list, &parent->slots);
>   err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, ...);
>   if (err)
>     kfree(slot);
>     return ERR_PTR(err);
> 
> Now we kfree(slot), but we don't call kobject_put(), so we don't
> remove it from the list, so the list is now corrupted because one of
> its entries has been deallocated.

Thanks for the review, I have now dropped this revert.

greg k-h
