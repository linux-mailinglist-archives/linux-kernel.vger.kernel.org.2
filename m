Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988F93B1B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhFWNeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:34:31 -0400
Received: from verein.lst.de ([213.95.11.211]:50914 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhFWNe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:34:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 95D9567373; Wed, 23 Jun 2021 15:32:06 +0200 (CEST)
Date:   Wed, 23 Jun 2021 15:32:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: dma_declare_coherent_memory and SuperH
Message-ID: <20210623133205.GA28589@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SuperH maintainers,

I have a vague recollection that you were planning on dropping support
for non-devicetree platforms, is that still the case?

The reason I'm asking is because all but one users of
dma_declare_coherent_memory are in the sh platform setup code, and
I'd really like to move towards killing this function off.
