Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE4139F19C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhFHJFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230316AbhFHJFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:05:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1480D61184;
        Tue,  8 Jun 2021 09:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623143024;
        bh=34F4j83N92HJUb1uPY07okOxL+Wyd2j3QkyZ8WfYdt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlB/IC9nU51Zs8ZqeAwRcPWLYWDYthgz4u6RmN1yCdzEbZdZaGwNKW3kZ2/+F1M3C
         CH4ZSUT5UGp2W9/nG0l0imy5xbtWT2KGFHY9HBUNJ0i0Ap//3MPWD7RUQm4E6SEOEM
         Aw+PbriDg/S9+oNRvj3HDZ1Ve8aYVsc242dz3KvM=
Date:   Tue, 8 Jun 2021 11:03:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?SmnFmcOt?= Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 4/5] nvmem: eeprom: at25: export FRAM serial num
Message-ID: <YL8ybqOfgOqjlpoX@kroah.com>
References: <20210607122640.143582-1-jiri.prchal@aksignal.cz>
 <20210607122640.143582-5-jiri.prchal@aksignal.cz>
 <YL4S2/hlfRwRM+Ug@kroah.com>
 <56f088fe-8db2-54d4-bef3-72e5f893a414@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56f088fe-8db2-54d4-bef3-72e5f893a414@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 04:47:44PM +0200, Jiří Prchal wrote:
> 
> 
> On 07. 06. 21 14:36, Greg Kroah-Hartman wrote:
> > On Mon, Jun 07, 2021 at 02:26:39PM +0200, Jiri Prchal wrote:
> > > +	return sysfs_emit(buf, "%016llx\n", *(unsigned long long *)at25->sernum);
> > 
> > That's a horrid hack, why not use the %*phN modifier?
> 
> Prints as little endian, is that OK?

You tell me!  What tool is going to be reading this?  What do they
expect it to look like?

And it's a byte array, why would there be endian issues?

thanks,

greg k-h
