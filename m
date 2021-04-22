Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D2C367DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbhDVJbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:31:55 -0400
Received: from foss.arm.com ([217.140.110.172]:48980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhDVJbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:31:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBDBB11D4;
        Thu, 22 Apr 2021 02:31:17 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 038373F774;
        Thu, 22 Apr 2021 02:31:16 -0700 (PDT)
Date:   Thu, 22 Apr 2021 10:31:11 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 089/190] Revert "PCI: endpoint: Fix a potential NULL
 pointer dereference"
Message-ID: <20210422093111.GA20094@lpieralisi>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-90-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-90-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:24PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 507b820009a457afa78202da337bcb56791fbb12.
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
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: commit log and code update]

Hi Greg,

first off, thank you for doing this.

This Cc should be fixed up if we go ahead with the revert (I can
take the revert via the PCI tree and fix it up myself).

I totally understand your concern (and the nuisance it is causing), the
commit we are reverting looked and looks legit - just let me know
how it is best to handle this please.

Thanks,
Lorenzo

> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index c0ac4e9cbe72..39dd394284a5 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -915,11 +915,6 @@ static int __init pci_epf_test_init(void)
>  
>  	kpcitest_workqueue = alloc_workqueue("kpcitest",
>  					     WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
> -	if (!kpcitest_workqueue) {
> -		pr_err("Failed to allocate the kpcitest work queue\n");
> -		return -ENOMEM;
> -	}
> -
>  	ret = pci_epf_register_driver(&test_driver);
>  	if (ret) {
>  		pr_err("Failed to register pci epf test driver --> %d\n", ret);
> -- 
> 2.31.1
> 
