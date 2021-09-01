Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB783FD4AF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbhIAHoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:44:17 -0400
Received: from verein.lst.de ([213.95.11.211]:46566 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242708AbhIAHoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:44:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 83F0968D06; Wed,  1 Sep 2021 09:43:00 +0200 (CEST)
Date:   Wed, 1 Sep 2021 09:42:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Christoph Hellwig <hch@lst.de>, torvalds@linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: make setup.c build again
Message-ID: <20210901074259.GA18673@lst.de>
References: <20210901071232.1258388-1-hch@lst.de> <YS8stOCBCdfZ+J0Y@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS8stOCBCdfZ+J0Y@zn.tnic>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 09:33:08AM +0200, Borislav Petkov wrote:
> There's an identical fix
> 
> https://lkml.kernel.org/r/20210901021510.1561219-1-nathan@kernel.org
> 
> which explains why it happens but I'm fine with whichever one Linus
> picks up.

Yeahm the changelog from Nathan looks better.  I'm fine as long as we
get this fixed ASAP.
