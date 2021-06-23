Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE16D3B1C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 16:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhFWOVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 10:21:17 -0400
Received: from verein.lst.de ([213.95.11.211]:51050 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230061AbhFWOVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:21:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 387BB67373; Wed, 23 Jun 2021 16:18:55 +0200 (CEST)
Date:   Wed, 23 Jun 2021 16:18:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Brian Cain <bcain@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sid Manning <sidneym@codeaurora.org>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: how can we test the hexagon port in mainline
Message-ID: <20210623141854.GA32155@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the oldest supported gcc version in mainline is gcc 4.9.  But the only
hexagon crosscompiler I can find is the one Arnds website points to here:

https://mirrors.edge.kernel.org/pub/tools/crosstool/

which is a non-upstream gcc 4.6.1 port.  How are we supposed to even
build test hexagon code?
