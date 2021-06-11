Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849F63A3EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhFKJKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231310AbhFKJKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:10:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9749613CC;
        Fri, 11 Jun 2021 09:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623402489;
        bh=LboOCET7vFoqgTpIykFFsCX2GIUMRzzzRzzXLTISN0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M60Oqv7YT7PkeALBe9QXE30xVbLJIOQb4D/LZx7oUfzw5rWiRqxH6CRbbq2+3M2c0
         sCbZnOOmw9VSjETjxAeigyAsutaq/7x7ODZfA9NTh5uh8JDFUGI50Scq4wbwJpkVSF
         DlRxUjely6zIfi2zKJmoaPVNI3RNcBs0kvz+shFc=
Date:   Fri, 11 Jun 2021 11:08:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?SmnFmcOt?= Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 1/5] nvmem: prepare basics for FRAM support
Message-ID: <YMMn9oqUj2SFI9NC@kroah.com>
References: <20210611052652.7894-1-jiri.prchal@aksignal.cz>
 <20210611052652.7894-2-jiri.prchal@aksignal.cz>
 <YMMjbCFzsfiT8dMA@kroah.com>
 <3c2beca6-8ef5-834d-a37a-5aea53bc1305@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c2beca6-8ef5-834d-a37a-5aea53bc1305@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 10:59:07AM +0200, Jiří Prchal wrote:
> 
> 
> On 11. 06. 21 10:48, Greg Kroah-Hartman wrote:
> > On Fri, Jun 11, 2021 at 07:26:48AM +0200, Jiri Prchal wrote:
> > > Added enum and string for FRAM to expose it as "fram".
> > 
> > I have no idea what "FRAM" is, nor what "fram" is.
> > 
> > And why do you not add the documentation update here in this same
> > commit?  This is where you are adding it, trying to dig later in the
> > series to notice that you really did provide this is a pain, and is
> > harder to track.
> > 
> > Please provide more information here in the changelog and move the
> > Documentation addition here into this patch.
> 
> Should I also join #1 and 2 together?

I do not remember what patch 2 is now, sorry.  All you really need is
the documentation update merged in here, I don't recall patch 2 being an
issue.

thanks,

greg k-h
