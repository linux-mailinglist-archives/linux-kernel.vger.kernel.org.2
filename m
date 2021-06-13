Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8123A5AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 01:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhFMXPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 19:15:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:42340 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232154AbhFMXPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 19:15:48 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 350954E5;
        Sun, 13 Jun 2021 23:13:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 350954E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1623626026; bh=4WN+9esKdpn+45t+uVbVMJCUauf+D7d+ldnHfTIx38U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CAvozJ4DFqiICnh4Ipy2Fzg/mjorMeE9jpyX4AX0wozLu5ysJ3J+8h3lH8504jgsJ
         zgq1LiPsHLRs3CRheGAb1e3uBolFz1hs3GN32TArLqOWlfMJ38GFh5dt/WO9W+oPr+
         8p5QHDvqyzsaH52SCsrN4OF3j+utA6py1/Nsx4kNpAtwyQbGcEMqOw/EDHi9txFWCI
         yraEZyxM4R+M3HmohETUnEhPIYgPHtjYHZJAhLl+FJh+ciXp9jxn/s844xpPhtseOQ
         u4rmqjaN2LIBbVajm1YKddU5jSA+nYcisUhnLnjwblIz1VccLd8WrbDNBL1RRJAs1p
         I9K6NfnBdROYg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?utf-8?Q?N=C3=ADco?= =?utf-8?Q?las_F=2E_R=2E_A=2E_Prado?= 
        <n@nfraprado.net>
Cc:     linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?And?= =?utf-8?Q?r=C3=A9?= Almeida 
        <andrealmeid@collabora.com>, ~lkcamp/patches@lists.sr.ht
Subject: Re: [RFC PATCH 1/2] docs: automarkup.py: Add literal markup of
 known constants
In-Reply-To: <20210609101102.2a97b2dd@coco.lan>
References: <20210609014308.234027-1-n@nfraprado.net>
 <20210609014308.234027-2-n@nfraprado.net>
 <20210609101102.2a97b2dd@coco.lan>
Date:   Sun, 13 Jun 2021 17:13:45 -0600
Message-ID: <874ke1bbo6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> It sounds a nightmare to maintain this by hand, as a list of used
> constants will only grow. IMO, an explicit list should be kept only to
> with the absolute minimum, e.g. for highly-used constants that aren't
> error codes nor FOO_BAR. The only case that occurs to me that fits 
> on this rule is 'NULL'.

This is my concern as well.  It seems to me like we would always have a
situation where some constants are magically marked up and others
aren't, and people will spend a lot of time trying to figure out why.

Might it not be better to just adopt the convention that these constants
don't need to be marked up at all?  NULL is entirely understandable even
when presented in a proportional font.  Seems like maybe the best of
both worlds?

Thanks,

jon
