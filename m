Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1D23A3EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhFKJJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231610AbhFKJJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:09:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFD61613CB;
        Fri, 11 Jun 2021 09:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623402464;
        bh=oZQq14a+O40QmlhynUdjD/cHg4xX9Rp58E9Popy32Zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vPxAqfov093XvXL0f0hQf9wSdL3jQawcEWvWFjNVYxzsY7N7MF9xfkONnFDQUAmZR
         fVs6LQonoOlDhyvW2fIaUS3Ud4F5TzUROkGO76/W4QVHG/s7emU3ej1z+lOeJUbNNa
         okEs/TSTOteh/GP9uowBDu5VOxDv0Yz2HCsRNnrQ=
Date:   Fri, 11 Jun 2021 11:07:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?SmnFmcOt?= Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 5/5] nvmem: eeprom: add documentation of sysfs fram
 and sernum file
Message-ID: <YMMn3T/cz2FxEt8X@kroah.com>
References: <20210611052652.7894-1-jiri.prchal@aksignal.cz>
 <20210611052652.7894-6-jiri.prchal@aksignal.cz>
 <YMMkgfRBKpwCo3PE@kroah.com>
 <8ff601c4-776b-3973-2855-eb2013e72200@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ff601c4-776b-3973-2855-eb2013e72200@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 11:01:57AM +0200, Jiří Prchal wrote:
> 
> 
> On 11. 06. 21 10:53, Greg Kroah-Hartman wrote:
> > On Fri, Jun 11, 2021 at 07:26:52AM +0200, Jiri Prchal wrote:
> > > +Description:
> > > +	Contains the FRAM binary data. Same as EEPROM, just another file
> > > +	name to indicate that it employs ferroelectric process.
> > > +	It performs write operations at bus speed - no write delays, capable
> > > +	of 10^14 read/write cycles and 151 years data retention.
> > 
> > Are you sure of these statistics?  Don't promise something here that
> > might not be true, this is not a marketing document :)
> 
> Just copied from datasheet. Is write at bus speed OK? And about others: much
> more then EEPROM would be OK? Or don't write about it?

I would not even mention it :)
