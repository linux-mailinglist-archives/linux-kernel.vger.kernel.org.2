Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC323359F8C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhDINJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhDINJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:09:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56563610FB;
        Fri,  9 Apr 2021 13:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617973734;
        bh=nsBejBrFyBwV9jcEMxFU4mpMrBIx3bxEkyn8uVSUlT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QnavmgnzbtRuG5l8XeBHl8EuAhwFbEPeCINFU7dICW3PkB/paLc/fv1JQMRm45tcg
         TorJtp7pytekpGuMRUU8sadgnUcR/vgdKPZr+lB7HONo9/pzRx/Hx9XsP2cQpAB7Th
         fP6wuPxBGRI0EV/m2z/SB7+CM79B06FpBOD16iis=
Date:   Fri, 9 Apr 2021 15:08:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] MAINTAINERS: add regressions mailing list
Message-ID: <YHBR4xBO2ejkEnfI@kroah.com>
References: <cover.1617967127.git.linux@leemhuis.info>
 <ecf1f0125399c5242ff213b827eacc6f93af3172.1617967127.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecf1f0125399c5242ff213b827eacc6f93af3172.1617967127.git.linux@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 01:47:23PM +0200, Thorsten Leemhuis wrote:
> Add the newly created regression mailing list finally created after it
> already had been agreed on during the maintainers summit 2017 (see
> https://lwn.net/Articles/738216/ ). The topic was recently discussed
> again, where an idea to create a broader list for all issues was
> discussed, but Linus preferred a more targeted list:
> https://lkml.kernel.org/r/CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com/
> 
> Hence, the creation for that list was asked for and granted:
> https://bugzilla.kernel.org/show_bug.cgi?id=212557
> 
> In the end it became regressions@lists.linux.dev instead of
> linux-regressions@lists.linux.dev as 'Linux' would have been redundant
> in the latter case.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
