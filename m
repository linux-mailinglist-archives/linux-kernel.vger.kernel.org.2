Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDBA39B4B2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFDIRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhFDIRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:17:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA7BE613FA;
        Fri,  4 Jun 2021 08:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622794566;
        bh=2hOw1XAYei+OhB7X4/AjYg4Szyy3kfzl3pmaxMHOlaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CXXXJV4wmpvQBukzdAxg20z5rB9AX69Mjsia5uYLWYPR1W5P0Idn1qFg37Qp9btWj
         geKpmiQHmuL3sowd5UBxYzOeuK+GNoDV1i1ibNa3zQlNYryJ2FivIcn5NkpNiKaZgL
         MtmPKcIdBD6lZmB9jX6upTAw832tfGzSBlWzWgpg=
Date:   Fri, 4 Jun 2021 10:16:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 0/4] add support for FRAM
Message-ID: <YLnhQ6kdY6yC53ja@kroah.com>
References: <20210520160127.51394-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520160127.51394-1-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 06:01:22PM +0200, Jiri Prchal wrote:
> Adds support for Cypress FRAMs.
> 
> Jiri Prchal (5):
>   nvmem: eeprom: at25: add support for FRAM
>   nvmem: eeprom: at25: add support for FRAM

You have 2 commits here with identical subject lines, yet they do
different things :(

Please fix up and make them properly unique.

thanks,

greg k-h
