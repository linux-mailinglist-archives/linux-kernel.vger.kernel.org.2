Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA553ABAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhFQRyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231249AbhFQRyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:54:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D08B613CB;
        Thu, 17 Jun 2021 17:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623952336;
        bh=4IX1e5vIdk5jwOpCXbPzGqSlbvv8WHJXrcPwl/Cstyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gb9Jq4uTBja3jdpcJXl5FC7w7GgbxiRKthiWD8XiTytdCYvCEK1X/f+M1Yb2KGdWa
         UCkNbgprmLLtNuK/MYvmUhamlnwxkYtZNy0aF94mFcx7chVnek85R49kh+FcLfJqSc
         AZRLS4/8bvRYFzJXH2VueT594nvegHBqRbPPWRnfTOXQFrAbU7H2Gv3RZKWn0CzN37
         euVhP3B4iHWFXCAQeGiYFUANk8xnLxDuKmSAHFD83nncKIsXJMP1pC7w1M1O43z2Wd
         TqJ/3HacfpUV4MgByZl2s6g+p5fs5TatKDrhvCtp9M7evCL/vl03LduY8bbRkrN7P5
         N0zZwcIJ8c2aA==
Date:   Thu, 17 Jun 2021 18:52:11 +0100
From:   Will Deacon <will@kernel.org>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     catalin.marinas@arm.com, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, pasha.tatashin@soleen.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com, zwang@amperecomputing.com
Subject: Re: [PATCH] arm64: kexec: flush log to console in nmi_panic()
Message-ID: <20210617175211.GE24813@willie-the-truck>
References: <20210617125023.7288-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617125023.7288-1-shijie@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 12:50:23PM +0000, Huang Shijie wrote:
> If kdump is configured, nmi_panic() may run to machine_kexec().
> 
> But in NMI context, the log is put in PER-CPU nmi_print_seq.
> So we can not see any log on the console since we entered the NMI context,
> such as the "Bye!" in previous line.
> 
> This patch fixes this issue by two steps:
> 	1) Uses printk_safe_flush_on_panic() to flush the log from
>              nmi_print_seq to global printk ring buffer,
>         2) Then uses console_flush_on_panic() to flush to console.
> 
> After this patch, we can see the "Bye!" log in the panic console.

Does it matter? I'd be more inclined to remove the print altogether...

Will
