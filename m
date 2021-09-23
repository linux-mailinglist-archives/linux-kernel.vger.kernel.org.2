Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A42E415F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbhIWNP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234515AbhIWNP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:15:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E34A61164;
        Thu, 23 Sep 2021 13:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632402836;
        bh=b7ciuEU81I/+7+Kcf5GtQcPnxHNd6AApdTsqk+hICIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b6dQij5uc96X0dTcnPcoUuxkPTLbF2fN2/4Y5WaYYhXJ6M2KOCv5+18SPDtUxEOMv
         JhsZevCeAarVQfrdBBLKmDTCCmizljQrOD2L/1iNv8E+2eF4KifI/fsdwvO+G0uLoF
         PgeaGsco1S9SgPDGj0lg6aesyAuewN/oXBER2PLk=
Date:   Thu, 23 Sep 2021 15:13:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     nsaenz@kernel.org, peterz@infradead.org, maz@kernel.org,
        bsegall@google.com, rdunlap@infradead.org, airlied@redhat.com,
        kan liang <kan.liang@linux.intel.com>, odin@uged.al,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: vchip_arm: Fix misuse of %x
Message-ID: <YUx9kdY5+Le+i29z@kroah.com>
References: <20210923035554.669434-1-qtxuning1999@sjtu.edu.cn>
 <YUwOZjr06RV2BUi6@kroah.com>
 <590112814.393656.1632401860257.JavaMail.zimbra@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <590112814.393656.1632401860257.JavaMail.zimbra@sjtu.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?


http://daringfireball.net/2007/07/on_top

On Thu, Sep 23, 2021 at 08:57:40PM +0800, Guo Zhi wrote:
> We should restrict kernel pointer leakage issue by using kptr_restrict. 
> Therefore kernel pointers should be specified by %pK rather than %lx.

I totally agree.

What I am asking about is why is this message needed at all?  Why not
just remove the whole thing?  Who uses it?

thanks,

greg k-h
