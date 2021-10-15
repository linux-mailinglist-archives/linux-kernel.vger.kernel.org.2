Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4AF42E52B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhJOAUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhJOAUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:20:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C825C6108E;
        Fri, 15 Oct 2021 00:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634257115;
        bh=Z3UOu6jr8cU0ilKr740bQYqd9+n2GwanZcjiupK2hcw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TIVeO1aC2FcrKNIr/3WL8ZR085bRXEFNNCodVeZm3H47FdkJCsjdBpv3dDXnjZ9Wv
         Z3ByY6m1HSgPc3NTszZ7nLLI3eeRlWvQcX8irs5hb3xzRTk20rvAlu0YwE8MzmFcJm
         yeFFAbJrwVP4tGHVjya0ykDVYMnl/RuYu7cPtiyi87YVr82eQhDk1sv6qQKiFrDrFY
         dRz8o5RsERQS3ZHt66YbYRwS/nDBhA3wChRnDnijVMgdnxzbqsOWoO0HnkJ4JFgqWs
         xpQFMwkd36g+M75Z/VTkWrFt2b+XJFOMZbnTSb4dX97kqSTNMDN4eQm1iOz9cdKrly
         +DbcA9Gl2A0vw==
Date:   Fri, 15 Oct 2021 09:18:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/8] ARM: clang: Do not relay on lr register for
 stacktrace
Message-Id: <20211015091832.3e114751496041931f214bab@kernel.org>
In-Reply-To: <YWhghNxpJD51ZDgD@shell.armlinux.org.uk>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
        <163369614818.636038.5019945597127474028.stgit@devnote2>
        <YWhghNxpJD51ZDgD@shell.armlinux.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 17:53:24 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Fri, Oct 08, 2021 at 09:29:08PM +0900, Masami Hiramatsu wrote:
> > Currently the stacktrace on clang compiled arm kernel uses the 'lr'
> > register to find the first frame address from pt_regs. However, that
> > is wrong after calling another function, because the 'lr' register
> > is used by 'bl' instruction and never be recovered.
> > 
> > As same as gcc arm kernel, directly use the frame pointer (x11) of
> > the pt_regs to find the first frame address.
> 
> Can I ask that the subject line is corrected. It's "rely" not "relay".

Oops, yes, that's my typo. Thanks for correcting!

> 
> Also, the frame pointer is called "r11" not "x11" if you want to use
> the numerical register reference for 32-bit ARM registers.

Oh, I mixed up the register name between arm64 and ARM...

Thank you,

> 
> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
