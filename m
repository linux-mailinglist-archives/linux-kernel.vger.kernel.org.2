Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04383161E6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhBJJQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:16:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhBJJNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:13:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30E2C64E2E;
        Wed, 10 Feb 2021 09:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612948374;
        bh=ZzXwNZshz/suBQt+KD38yWvaC+oOE3v3RhMrAFO+bac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBjVGf7A0cd5V2YkbYVlpOeRjMz0jikVKcE360qTu53FAKTEeezSS3syIOsgTk9b8
         tob9fAw2G5LZyVxr/3/rQGXQjhx69zkEIgmkeJWGoJLYIZfEgRSzrsso1nq5o5G5e3
         l4b9vBfgHXJpFvKgeK/DCtBpOlvFYzeVfOVWrDen+CO1bLvwe8jGJ8KKQPOVQdjIHs
         i0pfPKRxwXdyLa+0NEMT5WkRas1T08CILnx7gAS2jH5LaR+0JY7T1NgPIcrKtH39R6
         d8dadFcJWcuhD2Owffx5S43nkjNo2XJdCsp4NyWKCyAxdHApnVmzgTOxLXYDjWXtCv
         d477kyr81miPg==
Date:   Wed, 10 Feb 2021 14:42:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: Re: [GIT PULL] phy: second round of fixes for v5.11
Message-ID: <20210210091249.GC2774@vkoul-mobl.Dlink>
References: <20210205115618.GG2656@vkoul-mobl.Dlink>
 <YCJI45rXLMpHRY1v@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCJI45rXLMpHRY1v@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-02-21, 09:33, Greg KH wrote:
> On Fri, Feb 05, 2021 at 05:26:18PM +0530, Vinod Koul wrote:
> > Hello Greg,
> > 
> > Please pull to receive few phy driver fixes for v5.11.
> > Apologies for sending them bit late.
> > 
> > The following changes since commit d092bd9110494de3372722b317510b3692f1b2fe:
> > 
> >   phy: mediatek: allow compile-testing the dsi phy (2021-01-04 13:00:54 +0530)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes2-5.11
> 
> It's too late for this for my tree, sorry.  Can you send these as
> patches and add a cc: stable on them to make sure they get into 5.11.y
> properly (and further back if they are needed)?

Ok I understand. But would it be okay to merge the fixes. Some folks
already use the tree and have requested the commits to be preserved.

I tested and it merges fine. I shall submit all these patches to stable
for 5.11 or earlier as applicable once they hit Linus's tree

Thanks
-- 
~Vinod
