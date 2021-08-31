Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0831B3FC958
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhHaOHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:07:21 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:48195 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhHaOHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:07:18 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4BB6D22234;
        Tue, 31 Aug 2021 16:06:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1630418781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1nEe0ivvaarnt1Bv0vjqFAVdslIHyZCpsCJJodQOhY=;
        b=h5VrNT1X86XklWXK5jSmQSxw+6vGr4Q29w3t0xfc7iz6Drh6/Au9xZz+JolXptC86rTHSY
        CbxRtyUl1PssY4RNMIzFC1NHpDJ+51mJenA/ZPH27HZDaXVjA9TPuBnfVwqDIuN9dIWClO
        qLvWArXSKaeZfPnJQSDAFDQ5CjwGxqE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Aug 2021 16:06:21 +0200
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 7/7] arm64: dts: ls1028a: use phy-mode instead of
 phy-connection-type
In-Reply-To: <20210831135916.ccvyc5intxs7rlal@skbuf>
References: <20210831134013.1625527-1-michael@walle.cc>
 <20210831134013.1625527-8-michael@walle.cc>
 <20210831135916.ccvyc5intxs7rlal@skbuf>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <c352291c7a88af21b766e33d244b835d@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-08-31 15:59, schrieb Vladimir Oltean:
> On Tue, Aug 31, 2021 at 03:40:13PM +0200, Michael Walle wrote:
>> In linux both are identical, phy-mode is used more often, though. Also
>> for the ls1028a both phy-connection-type and phy-mode was used, one 
>> for
>> the enetc nodes and the other for the switch nodes. Unify them. But 
>> the
>> main reason for this is that the device tree files can be shared with
>> the u-boot ones; there the enetc driver only supports the "phy-mode"
>> property.
>> 
>> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
> 
> Actually that is not really a valid reason in itself for this change.
> The enetc U-Boot driver is perhaps a bit silly in that it calls
> ofnode_read_string(dev_ofnode(dev), "phy-mode") manually, especially
> since right below, it uses dm_eth_phy_connect() which searches for 
> both.
> 
> So we are artificially restricting what we support. It would be fine to
> do the dm_eth_phy_connect first, then use phy->interface for 
> enetc_start_pcs().

You mean in u-boot. I had a patch for it, but because you suggested
to convert it to the new property name, it isn't really needed anyway.
u-boot is just using the device trees within its source tree, so I
didn't care anymore ;)

> Anyway, I do not mind the patch at all.
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Thanks!

-michael
