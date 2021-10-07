Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E33A424E28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 09:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhJGHjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 03:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240311AbhJGHjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:39:23 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7CCC061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 00:37:29 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BD00322234;
        Thu,  7 Oct 2021 09:37:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1633592248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XjCSY4XhccjbtaclWk/3U2lD3pRMWvVvTqTn+9l+6po=;
        b=WXlwBRgzZcy5UO+kZECN816WJnCfTYuwc9asjo694LCh6Y5thB033LNI+dj7v87/02kc5Z
        9/UBScEaIiDw4K9KkHP1HJ4BNniIdeS4Urb3DZ20uqPA0qZhRuZQcAJWlUPR0xAwEg2qaa
        6nsflXPbPtGQeElflFOwUeUMU441QIU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Oct 2021 09:37:27 +0200
From:   Michael Walle <michael@walle.cc>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (EXT) Re: (EXT) Re: [PATCH 1/2] mtd: spi-nor: micron-st: sync
 flags of mt25ql02g and mt25qu02g with other mt25q
In-Reply-To: <0e2ad27b00d85c1dfa489d91b54d2a3af41f5edb.camel@ew.tq-group.com>
References: <c7b6c666aef9a8a2195acabe9954a417f04b6582.1627039534.git.matthias.schiffer@ew.tq-group.com>
 <f3dbab898e9f1946129e5733095bdf3c@walle.cc>
 <3258026683c916a3a42e98ba76628228cddacb23.camel@ew.tq-group.com>
 <969e9169b77bb314aaa2e97789c76c00@walle.cc>
 <0e2ad27b00d85c1dfa489d91b54d2a3af41f5edb.camel@ew.tq-group.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <6ea1852ddc390cf18db0ae927b88b2b9@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-10-07 09:18, schrieb Matthias Schiffer:
> On Thu, 2021-10-07 at 09:08 +0200, Michael Walle wrote:
>> Am 2021-10-06 14:32, schrieb Matthias Schiffer:
>> > On Tue, 2021-07-27 at 09:09 +0200, Michael Walle wrote:
>> > > Am 2021-07-23 13:27, schrieb Matthias Schiffer:
>> > > > All mt25q variants have the same features.
>> > > >
>> > > > Unlike the smaller variants, no n25q with 2G exists, so we don't need
>> > > > to
>> > > > match on the extended ID to distinguish n25q and mt25q series for these
>> > > > models.
>> > >
>> > > But why shouldn't we? What if there will be another flash with
>> > > the same first three id bytes?
>> >
>> > How do you suggest we proceed here? At the moment there are entries
>> > matching on 0x20b[ab]22 (ignoring the extended ID) with the name
>> > mt25q[lu]02g.
>> >
>> > Should I change these entries to match on on the extended ID
>> > 0x20b[ab]22 / 0x104400 instead when I add the bits for the features
>> > specific to the variant, removing support for other 0x20b[ab]22
>> > variants that may or may not actually exist? Keeping both entries (with
>> > and without extended ID match) would preserve compatiblity with such
>> > variants, but this approach seems problematic to me as well, as I can't
>> > even give a name to the more generic entries (and there is no natural
>> > extension of the n25q naming scheme to a 2G variant).
>> 
>> Mh, what do you think of adding three entries and make the last one,
>> the one with the short id, as a fallback so to speak. This should
>> retrain backwards compatibility, right? It should probably have a
>> comment because the order will matter then.
>> 
>> -michael
> 
> Is it okay for multiple entries to use the same value for the "name"
> field? In the existing definitions I couldn't find any example of
> different ID matches mapping to the same name.

You're right, thats probably not good. Ok, if there is no objection
from Tudor, I'd say we change the entry of the mt25 variant to the
longer one. If there is a flash chip out there which matched the
shorter one, but not the longer one, thats probably not a mt25 anyway.

-michael
