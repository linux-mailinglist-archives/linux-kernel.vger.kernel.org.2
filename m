Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755F345D25A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 02:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347319AbhKYBOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 20:14:52 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:60177 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345567AbhKYBMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 20:12:51 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D4AB53201CD3;
        Wed, 24 Nov 2021 20:09:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 24 Nov 2021 20:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jGPihi
        4ljyAa/Ki0//eZ9S9R+JlJhSZ+gF/GSVZZuwo=; b=LSFA+/iTR3YjMYtA2BbTtS
        PRkSEWiB2o8sIWdBIsWaL7mYe/haIP3RhfAiOlIduPefbZNvTpkbm5PgKzF9Wpdm
        sN/dL//sGiYv99ByoZb+a5oBQKiMvG71C0lR22Jf6ykMn7g+aCKRh6GF60myooh8
        9Aq0y+GMvq4Dovr+0AH21Cmw754JvUgsxhZoNSZxspmOwTKabqxkysifVyC2cDdM
        x6Ar7ajCRpZN3QiQZMTbh6q+UOzzEDM9WfhhqjMjs1RRqwc7/i40a53h0t96CNWk
        N+BU2bL4y3ErYJ+X9xSVaPHfK9oX6ijx+dSp5/I8cB9WSndsmWga2U0reu+xe9Hg
        ==
X-ME-Sender: <xms:UuKeYbSMWWWl99KWp_cBRE5jxsK-pspVktNAJcjV2nOu4Jbt9BLLZg>
    <xme:UuKeYcy8cLHGH0z3czcn8l-CfScXf933z5u7INVeoIfAWomUgKldDgzrmz29dCHoF
    snrT_wm0guNSdGmYzU>
X-ME-Received: <xmr:UuKeYQ0DEMIWIjHnK9suC8IB1YyYYa2xKWJiNLY0r1QzbZ2b92yf2EdpOiSBJdxrT_6fsWk3VYMaFkNyYpCac2gLIk2eiOOkpng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeelgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeffudfhgeefvdeitedugfelueegheekkeefveffhfeiveetledvhfdtveffteeu
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:UuKeYbBmbl5cCspS_mrtdXVGipYJTQGV8m0Fe5_UsRfiJZlG8yG62A>
    <xmx:UuKeYUidx-sqYLC_xXWcZ2whoBrR0BoWVBK8kYkgvnx0xUuCfvNO_Q>
    <xmx:UuKeYfpDk6p8spn5tAZX4vzhwHV4DMoaf6e-I7-ZX4bEiH5G_e0lag>
    <xmx:U-KeYdtu_nLCW5CrNfkNSg5NEewHa8YQ85c045MDUaIZyZ6jLouRkg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Nov 2021 20:09:37 -0500 (EST)
Date:   Thu, 25 Nov 2021 12:09:41 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pata_falcon: Add missing __iomem annotations
In-Reply-To: <f420bff8-855a-aabe-924c-6d1b74f11001@gmail.com>
Message-ID: <682664c-836e-ae61-6844-207a980f9cd@linux-m68k.org>
References: <44e0213a681f3c8ee4c6ab2ef9d61ce3ac00e368.1637727935.git.fthain@linux-m68k.org> <f420bff8-855a-aabe-924c-6d1b74f11001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021, Michael Schmitz wrote:

> On 24/11/21 17:25, Finn Thain wrote:
> > The zero day bot reported some sparse complaints in pata_falcon.c. E.g.
> >
> > drivers/ata/pata_falcon.c:58:41: warning: cast removes address space
> > '__iomem' of expression
> > drivers/ata/pata_falcon.c:58:41: warning: incorrect type in argument 1
> > (different address spaces)
> > drivers/ata/pata_falcon.c:58:41:    expected unsigned short volatile
> > [noderef] [usertype] __iomem *port
> > drivers/ata/pata_falcon.c:58:41:    got unsigned short [usertype] *
> >
> > The same thing shows up in 8 places, all told. Avoid this by use of
> > __iomem type casts.
> 
> Seeing as data_addr was explicitly typed as __iomem, your fix is clearly
> correct. Bit embarrassing to have missed that (I remember adding __iomem
> annotations elsewhere at some stage).
> 
> If you think there's any need to test this change, say so.
> 

There's no change in pata_falcon.o.

> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
> 

Thanks.
