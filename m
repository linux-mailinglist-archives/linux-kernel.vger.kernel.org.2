Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC98314A69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 09:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBIIg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:36:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbhBIIfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:35:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17D6F64EBE;
        Tue,  9 Feb 2021 08:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612859699;
        bh=XlD+GcdC1ChYZK93TH6EIuF637ygLsXA27BEe2jjLFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lxIgp5tKvZOQcYyhTLKgRITGDeMdzEu2jovF5rZA06oSsr+MPKesAoFOvS95TKM4e
         4wAwJPmR+hO1+zBfdPosox8YzuMQvYybWjcz8igp++jUP9BTBZNtS/nB+bqKaAOAKN
         8DLy9d6I5/1Y9TNZJDpljNJNKXwhfnNNPGp2tYDE=
Date:   Tue, 9 Feb 2021 09:33:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: Re: [GIT PULL] phy: second round of fixes for v5.11
Message-ID: <YCJI45rXLMpHRY1v@kroah.com>
References: <20210205115618.GG2656@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205115618.GG2656@vkoul-mobl.Dlink>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 05:26:18PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive few phy driver fixes for v5.11.
> Apologies for sending them bit late.
> 
> The following changes since commit d092bd9110494de3372722b317510b3692f1b2fe:
> 
>   phy: mediatek: allow compile-testing the dsi phy (2021-01-04 13:00:54 +0530)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes2-5.11

It's too late for this for my tree, sorry.  Can you send these as
patches and add a cc: stable on them to make sure they get into 5.11.y
properly (and further back if they are needed)?

thanks,

greg k-h
