Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653493B1D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 17:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhFWPUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 11:20:07 -0400
Received: from verein.lst.de ([213.95.11.211]:51205 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhFWPUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:20:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5790067373; Wed, 23 Jun 2021 17:17:46 +0200 (CEST)
Date:   Wed, 23 Jun 2021 17:17:46 +0200
From:   'Christoph Hellwig' <hch@lst.de>
To:     Brian Cain <bcain@codeaurora.org>
Cc:     'Arnd Bergmann' <arnd@arndb.de>, 'Christoph Hellwig' <hch@lst.de>,
        'Sid Manning' <sidneym@codeaurora.org>,
        "'open list:QUALCOMM HEXAGON...'" <linux-hexagon@vger.kernel.org>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
Subject: Re: how can we test the hexagon port in mainline
Message-ID: <20210623151746.GA4247@lst.de>
References: <20210623141854.GA32155@lst.de> <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org> <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com> <08e101d76842$94f78a60$bee69f20$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08e101d76842$94f78a60$bee69f20$@codeaurora.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seem like it still isn't complete enought for a kernel build, though:

$ export CROSS_COMPILE=/opt/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/hexagon-unknown-linux-musl- 
$ make ARCH=hexagon LLVM=1 oldconfig
...
scripts/Kconfig.include:40: linker 'ld.lld' not found
make[1]: *** [scripts/kconfig/Makefile:77: oldconfig] Error 1
make: *** [Makefile:614: oldconfig] Error 2

