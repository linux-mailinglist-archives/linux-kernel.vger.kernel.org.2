Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869773616BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 02:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhDPAWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 20:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbhDPAWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 20:22:32 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1406C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 17:22:08 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXCF6-005dLJ-Fl; Fri, 16 Apr 2021 00:21:52 +0000
Date:   Fri, 16 Apr 2021 00:21:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        jcmvbkbc@gmail.com, gerg@linux-m68k.org,
        Anup Patel <Anup.Patel@wdc.com>, uclinux-dev@uclinux.org
Subject: Re: [PATCH v2 0/2] Fix binfmt_flat loader for RISC-V
Message-ID: <YHjYoDA2JPxSYVu0@zeniv-ca.linux.org.uk>
References: <BL0PR04MB65148D80C819A7E3B8365242E74D9@BL0PR04MB6514.namprd04.prod.outlook.com>
 <mhng-61cff5f4-32a0-417d-9a2f-eb6d052cf802@palmerdabbelt-glaptop>
 <20210415055605.GB8947@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415055605.GB8947@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 07:56:05AM +0200, Christoph Hellwig wrote:
> binfmt_flat tends to go through Greg's uclinux tree, adding him and
> the list.

	FWIW, my involvement with binfmt_flat had been pretty much nil -
the least trivial had been "binfmt_flat: flat_{get,put}_addr_from_rp()
should be able to fail" about 4 years ago and that fell out of hunting
for places where __get_user() had been used without checking error values.

	It's in fs/*, but I've no way to test it and I have pretty much
zero familiarity with the guts of that one, so I can't give any useful
feedback on that series.  So consider the Christoph's comment seconded -
you want it reviewed by gerg et.al., and it probably ought to go via
gerg/uclinux.git tree.

	I'm reasonably familiar with binfmt_{elf,misc,script}; anything
else gets touched as part of larger series and only with sanity checks
from other folks, if the changes are not entirely trivial.
