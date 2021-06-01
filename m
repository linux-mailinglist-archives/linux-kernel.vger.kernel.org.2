Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D376B397575
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhFAOdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbhFAOdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:33:13 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59A5C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 07:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gEtXdDu9+lsKZpSpI0/uAo+3rlyBLyfsQkhGtLtsn78=; b=IFamQIF3iLk8EIixhE2reGtgZ
        z9q2OS6QUH8dvO+XprikEl92iTvBIjJNNcA1tsARxVbrPE7q6EYZ5UOFdcXq6M8+iB2HKDa9SGFsb
        CoOSnpCPPfwjUsIk/+9awLO0rKoTX72q7iwxAer5vWowFOoQtkchKn4/CUyyPS6JN5DgHl0hKeSSw
        r7Yu9jbnNJyLFqvLQvOdFDyiSOED4j7DGgnn5YeHwIaKpqw8QVRvq+gLBMCD+J2uQZsTHL67e3L5r
        ZsJDy+yKmDH5yotV+/LtXDZMAS71Wjap3l2BIzy0khU5XsXbaYDX4GaMcPgUCdzj1Oz1O3qRwrtqI
        DzVF/8zUQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44582)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lo5QV-0004DG-2d; Tue, 01 Jun 2021 15:31:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lo5QU-0000CY-34; Tue, 01 Jun 2021 15:31:26 +0100
Date:   Tue, 1 Jun 2021 15:31:26 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>
Subject: Re: [PATCH 1/2] ARM: mm: Refactor __do_page_fault()
Message-ID: <20210601143125.GB30436@shell.armlinux.org.uk>
References: <20210529034138.83384-1-wangkefeng.wang@huawei.com>
 <20210529034138.83384-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210529034138.83384-2-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 11:41:37AM +0800, Kefeng Wang wrote:
> 1. cleanup access_error(), make vma flags set and check into
>    __do_page_fault() and do_page_fault() directly.
> 
> 2. drop fsr and task argument, instead, using vm_flags in
>    __do_page_fault().
> 
> 3. cleans up the multiple goto statements in __do_page_fault().
> 
> 4. use current->mm directly in do_page_fault().
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

This patch is a really good example of something that is very difficult
to review and see that there are no unintended changes.

Many people have complained about my patches, where I create a series of
many patches where each patch does exactly _one_ simple transformation to
the code. This is a good example _why_ I do that - a step by step single
transformation approach is way easier to review.

Sorry, but I'm not able to sensibly review this patch, and therefore
I won't apply it. Please split it into smaller changes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
