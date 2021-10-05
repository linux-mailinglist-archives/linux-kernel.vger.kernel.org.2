Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF874422D97
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhJEQQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhJEQQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:16:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B24A61354;
        Tue,  5 Oct 2021 16:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633450449;
        bh=MBB+CD222y/glG9TAbC0mn/d0jqKuUWaZk+3cqS82/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCT3la+/KGHpyGvYsOcS2OKn11G0aoTtGqGwcKb8IEQw6kPbs/scerm25rLjMGsbJ
         NnqhzJEVP4zC2y6SeOe6XCkFMhUkM20pyfff3hD5WcbOv9FVx60rsKqnRA3cLzwDPL
         5i3mi6zIF5zItB+BIXhzVjx5BTShUKyISPovGXIGaiMuJHMwv+0Z6qH3YT75Q3YZBg
         5F4NuUMkM0uR5Hk8eJGESaukj9jFWSinClDqjDgw+JzZYNCQpkz8PpPYwjWaOxNcsm
         Jp5EjnJviczn7UnPnctSEoZVTGtc3NTz2WmXbhVV3+NWWk2B30V1gGMfqeyMV66i5p
         y1hC9fBGi3n1w==
Date:   Tue, 5 Oct 2021 11:18:12 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ftrace: Fix -Wcast-function-type warnings on
 powerpc64
Message-ID: <20211005161812.GA768055@embeddedor>
References: <20211005053922.GA702049@embeddedor>
 <20211005111714.18ebea2b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005111714.18ebea2b@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 11:17:14AM -0400, Steven Rostedt wrote:
> On Tue, 5 Oct 2021 00:39:22 -0500
> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
> > In order to make sure new function cast mismatches are not introduced
> > in the kernel (to avoid tripping CFI checking), the kernel should be
> > globally built with -Wcast-function-type.
> > 
> > So, fix the following -Wcast-function-type warnings on powerpc64
> > (ppc64_defconfig):
> 
> I think I'll go back and add my linker magic.
> 
>   https://lore.kernel.org/all/20200617165616.52241bde@oasis.local.home/
> 
> I'll clean it up a bit too. I'll have a patch in a bit.

Awesome. :)

Thanks
--
Gustavo
