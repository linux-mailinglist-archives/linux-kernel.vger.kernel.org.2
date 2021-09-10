Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A87B406DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 17:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhIJPLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 11:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhIJPLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 11:11:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 589B360C40;
        Fri, 10 Sep 2021 15:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631286631;
        bh=f+/FG+oSPHyyXSwi/t4XQBHLkQUXECvUNJ5cLLKhzCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A5U0zWc9L9S5BXoBEBG6HJCY6UkC7MODlRz3a+5O36FbTAYJE8jEnaAt2M5xh1C6+
         ZdDpb1SsLumXkwTTgwKD8OlBS8Fjt+g/bX+Y+nKNr3L9wz+mQ0GaXbxl5VfsiUEmBl
         EZWFYusqEDcaBedcdTj7MZh3niU16+Bz2Uj2oWQ8=
Date:   Fri, 10 Sep 2021 17:10:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lkdtm: Use init_uts_ns.name instead of macros
Message-ID: <YTt1ZRXNzZsUEHt3@kroah.com>
References: <20210901233406.2571643-1-keescook@chromium.org>
 <202109090848.129A49E8BD@keescook>
 <YTowAX7szcAP7ItU@kroah.com>
 <20210909160859.GE5176@sirena.org.uk>
 <202109091025.A70080F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109091025.A70080F@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 10:26:18AM -0700, Kees Cook wrote:
> On Thu, Sep 09, 2021 at 05:08:59PM +0100, Mark Brown wrote:
> > On Thu, Sep 09, 2021 at 06:02:09PM +0200, Greg Kroah-Hartman wrote:
> > 
> > > I can't see a rebuild locally here without this patch attached, so how
> > > much of a problem is it right now?
> > 
> > It's triggering for me all the time here FWIW.
> 
> Right, if you have CONFIG_LKDTM!=n it'll show up (e.g. with an
> all*config build).
> 
> > > And isn't -rc2 ok?
> > 
> > Lots of trees base off -rc1 so unless people change their workflow to
> > merge up -rc2 it'll impact submitters.
> 
> Right, that's why I was suggesting it.

Ok, let me run it through 0-day right now and see if anything blows
up...
