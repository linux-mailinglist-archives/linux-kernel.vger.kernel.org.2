Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423A932F821
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 04:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhCFDbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 22:31:52 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:43044 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhCFDbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 22:31:43 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1lINf8-009U2y-4q; Sat, 06 Mar 2021 04:31:30 +0100
Date:   Sat, 6 Mar 2021 04:31:30 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Don Bollinger <don@thebollingers.org>
Cc:     'Jakub Kicinski' <kuba@kernel.org>, arndb@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        brandon_chuang@edge-core.com, wally_wang@accton.com,
        aken_liu@edge-core.com, gulv@microsoft.com, jolevequ@microsoft.com,
        xinxliu@microsoft.com, 'netdev' <netdev@vger.kernel.org>,
        'Moshe Shemesh' <moshe@nvidia.com>
Subject: Re: [PATCH v2] eeprom/optoe: driver to read/write SFP/QSFP/CMIS
 EEPROMS
Message-ID: <YEL3ksdKIW7cVRh5@lunn.ch>
References: <20210215193821.3345-1-don@thebollingers.org>
 <YDl3f8MNWdZWeOBh@lunn.ch>
 <000901d70cb2$b2848420$178d8c60$@thebollingers.org>
 <004f01d70ed5$8bb64480$a322cd80$@thebollingers.org>
 <YD1ScQ+w8+1H//Y+@lunn.ch>
 <003901d711f2$be2f55d0$3a8e0170$@thebollingers.org>
 <20210305145518.57a765bc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <005e01d71230$ad203be0$0760b3a0$@thebollingers.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005e01d71230$ad203be0$0760b3a0$@thebollingers.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I am proposing acceptance of a commonly used implementation for accessing
> SFPs because the one used by the netdev/netlink community does not fit the
> architecture of the white box NOS/switch community.

Please could you expand on this. I've given suggests as to how the new
netlink KAPI could be used for this use case, without being attached
to a netdev. And you have said nothing about why it cannot be made to
work. You cannot argue the architecture does not fit without actually
saying why it does not fit.

   Andrew
