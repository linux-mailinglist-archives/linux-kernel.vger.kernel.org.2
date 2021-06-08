Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E7639F2F2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhFHJzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231181AbhFHJzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:55:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31B2E61008;
        Tue,  8 Jun 2021 09:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623146038;
        bh=VYaAViHh1Py6v8pf+R+jIxsvaqWuJjCa07F+MAIE8WU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNp23tvGHNeTqJa2VK3DVBNpBXaUiicbZVCcHkUSmamieuUG41mrYpxYe5iNu+87L
         Z8O+7vVHDMd8HJyskHqvprv4spkQz0MT6Y+ieeHTnAFDCbrHc8/XnFlL+ezljn081V
         Z8LIGvrbt93hNub/Ee1UfGHPlpG3wIYnKU06KUOY=
Date:   Tue, 8 Jun 2021 11:53:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?SmnFmcOt?= Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 4/5] nvmem: eeprom: at25: export FRAM serial num
Message-ID: <YL8+NOdz+ue3MTGg@kroah.com>
References: <20210607122640.143582-1-jiri.prchal@aksignal.cz>
 <20210607122640.143582-5-jiri.prchal@aksignal.cz>
 <YL4S2/hlfRwRM+Ug@kroah.com>
 <56f088fe-8db2-54d4-bef3-72e5f893a414@aksignal.cz>
 <YL8ybqOfgOqjlpoX@kroah.com>
 <b1c0eab3-8d07-5c52-300e-45974f7fea9c@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1c0eab3-8d07-5c52-300e-45974f7fea9c@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 11:45:56AM +0200, Jiří Prchal wrote:
> 
> 
> On 08. 06. 21 11:03, Greg Kroah-Hartman wrote:
> > On Mon, Jun 07, 2021 at 04:47:44PM +0200, Jiří Prchal wrote:
> > > 
> > > 
> > > On 07. 06. 21 14:36, Greg Kroah-Hartman wrote:
> > > > On Mon, Jun 07, 2021 at 02:26:39PM +0200, Jiri Prchal wrote:
> > > > > +	return sysfs_emit(buf, "%016llx\n", *(unsigned long long *)at25->sernum);
> > > > 
> > > > That's a horrid hack, why not use the %*phN modifier?
> > > 
> > > Prints as little endian, is that OK?
> > 
> > You tell me!  What tool is going to be reading this?  What do they
> > expect it to look like?
> 
> sh, php in my usecase as unique id.

I am sorry, I do not understand.

> So endianess does not matter to me too much. The question is what is usual
> (like mac address, uuid...?).

What does the device export?  Why not just export it as:
	0123456789ABCDEF
if it is 8 bytes long?

> > And it's a byte array, why would there be endian issues?
> 
> Now is printed as one big number. Not real issue. Just human readability?
> Should I turn back it to space separated bytes?

It's up to you, what do you want to do with it and what does a tool want
it to look like?

thanks,

greg k-h
