Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3AF3678CF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 06:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhDVEoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 00:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231442AbhDVEoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 00:44:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78E4161430;
        Thu, 22 Apr 2021 04:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619066612;
        bh=xrFLSgN/hEMTADzzrOny6qI7RFQr1Z8JPO+U3E7f2Jg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bdF6j9/oR1P54eoaXetC/4kKR4q5gS4G9Htd7nugaDrZMzNzqyN0gMpAPafGyzqtY
         qt60i/jZCF0O5MdeMUmt1yy2B8h4gPILp4u1EACiJz5d/oBJuMIX1oqnPt2tvNeEMJ
         BuDrdsWz6jQ4hr/+0Qm/FHLDsDYfLEP6QNE2UPI2hxC3JFK72bIImyGX1PlVhnPNb9
         nF8tu8i58m9gS4w56vt72HkcXOwZsp6WT/JZ9lBqhp5S6KQoE9CGpGyDxGHMRlrV2W
         wTob3FYqT6VjFdYvktceKRgv0SBKYbxKN5G+6r6l90/NX0hbPl7zl6HcHYZ07sUVXR
         VtNarwvVGgQsQ==
Date:   Wed, 21 Apr 2021 23:43:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Jubin Zhong <zhongjubin@huawei.com>
Subject: Re: [PATCH 020/190] Revert "PCI: Fix pci_create_slot() reference
 count leak"
Message-ID: <20210422044331.GA2907704@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-21-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Jiri, Jubin (author of 4684709bf81a)]

On Wed, Apr 21, 2021 at 02:58:15PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 8a94644b440eef5a7b9c104ac8aa7a7f413e35e5.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: https
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Please do not apply this revert.

Prior to 8a94644b440e ("PCI: Fix pci_create_slot() reference count
leak"), we essentially had this:

  err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, ...);
  if (err)
    kfree(slot);
    return ERR_PTR(err);

  INIT_LIST_HEAD(&slot->list);
  list_add(&slot->list, &parent->slots);

That was incorrect because if kobject_init_and_add() fails,
kobject_put() must be called to clean up the object (per the function
comment).  For pci_slot_ktype, the release function is
pci_slot_release():

  pci_slot_release
    list_del(&slot->list);
    kfree(slot);

After 8a94644b440e, we had:

  err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, ...);
  if (err)
    kobject_put(&slot->kobj);
    return ERR_PTR(err);

  INIT_LIST_HEAD(&slot->list);
  list_add(&slot->list, &parent->slots);

This fixed one bug but exposed another: we correctly clean up the
object by calling kobject_put() which calls pci_slot_release(), but 
that dereferences slot->list, which hasn't been initialized yet.

But 4684709bf81a ("PCI: Fix pci_slot_release() NULL pointer
dereference") fixed that problem by making it this:

  INIT_LIST_HEAD(&slot->list);
  list_add(&slot->list, &parent->slots);
  err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, ...);
  if (err)
    kobject_put(&slot->kobj);
    return ERR_PTR(err);

This correctly initializes slot->list and cleans up if
kobject_init_and_add() fails.

But if we apply this revert, we'll have this:

  INIT_LIST_HEAD(&slot->list);
  list_add(&slot->list, &parent->slots);
  err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, ...);
  if (err)
    kfree(slot);
    return ERR_PTR(err);

Now we kfree(slot), but we don't call kobject_put(), so we don't
remove it from the list, so the list is now corrupted because one of
its entries has been deallocated.

Bjorn

> ---
>  drivers/pci/slot.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index d627dd9179b4..c190e09af356 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -268,7 +268,6 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  	slot_name = make_slot_name(name);
>  	if (!slot_name) {
>  		err = -ENOMEM;
> -		kfree(slot);
>  		goto err;
>  	}
>  
> @@ -277,10 +276,8 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  
>  	err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, NULL,
>  				   "%s", slot_name);
> -	if (err) {
> -		kobject_put(&slot->kobj);
> +	if (err)
>  		goto err;
> -	}
>  
>  	down_read(&pci_bus_sem);
>  	list_for_each_entry(dev, &parent->devices, bus_list)
> @@ -296,6 +293,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  	mutex_unlock(&pci_slot_mutex);
>  	return slot;
>  err:
> +	kfree(slot);
>  	slot = ERR_PTR(err);
>  	goto out;
>  }
> -- 
> 2.31.1
> 
