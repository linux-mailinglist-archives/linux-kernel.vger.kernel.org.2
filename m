Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F239367429
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 22:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245642AbhDUUav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 16:30:51 -0400
Received: from namei.org ([65.99.196.166]:48318 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240021AbhDUUat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 16:30:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id C698416D4;
        Wed, 21 Apr 2021 20:26:23 +0000 (UTC)
Date:   Thu, 22 Apr 2021 06:26:23 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 116/190] Revert "thunderbolt: property: Fix a NULL pointer
 dereference"
In-Reply-To: <20210421130105.1226686-117-gregkh@linuxfoundation.org>
Message-ID: <3821882d-22c4-5dc5-2df9-ae2d5e8fc2a@namei.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <20210421130105.1226686-117-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021, Greg Kroah-Hartman wrote:

> This reverts commit 106204b56f60abf1bead7dceb88f2be3e34433da.
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
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/thunderbolt/property.c | 5 -----
>  1 file changed, 5 deletions(-)

The original patch looks correct.


Reviewed-by: James Morris <jamorris@linux.microsoft.com>

> 
> diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
> index ee76449524a3..b2f0d6386cee 100644
> --- a/drivers/thunderbolt/property.c
> +++ b/drivers/thunderbolt/property.c
> @@ -548,11 +548,6 @@ int tb_property_add_data(struct tb_property_dir *parent, const char *key,
>  
>  	property->length = size / 4;
>  	property->value.data = kzalloc(size, GFP_KERNEL);
> -	if (!property->value.data) {
> -		kfree(property);
> -		return -ENOMEM;
> -	}
> -
>  	memcpy(property->value.data, buf, buflen);
>  
>  	list_add_tail(&property->list, &parent->properties);
> -- 
> 2.31.1
> 

-- 
James Morris
<jmorris@namei.org>

