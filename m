Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2BA3765CE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 15:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbhEGNM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 09:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhEGNM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 09:12:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 621456145D;
        Fri,  7 May 2021 13:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620393087;
        bh=VfeTFWw7uZ8S4bmM3XXEsiPGWbAXgMYpwIb2sL8BkEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AKKCCt9c0NLZf7sExnj7tzZj4smPLHDpPyKLcrbztii2u+lNzGln0AnSM/JmvjYm+
         JHKpN7B/LKX08QmBBnGV9VKUlkwH5+jipa84JafAehvccMXDyuP4S8KWfvnlDg2Wyd
         kVDLZAzjutHIgSNV7O1qJHEDbTwPk0T4qqVi8ZH48+DdCONgMq4uM3IG/zVhLHCD7+
         OLp+OL6qSnDwib2nahWdAVw0B9Gz0MCuSLPyeC/RIQePrJjnUhr/4LckauK+c3suWD
         4ZRtiL87gJUpjirmtHGmy6+sXUKMfnyiZeZ1VpUhStWQ84+5s/WU3j2Jcu1IVSTYhs
         LHjID8+FQWp5Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lf0GW-0004qE-CC; Fri, 07 May 2021 15:11:37 +0200
Date:   Fri, 7 May 2021 15:11:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluetooth: fix potential gfp
Message-ID: <YJU8iP+O9aSYwYp/@hovoldconsulting.com>
References: <20210501150445.4055-1-paskripkin@gmail.com>
 <9A08CBDA-3501-48F6-9F7A-60958C5CF888@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9A08CBDA-3501-48F6-9F7A-60958C5CF888@holtmann.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 10:27:39AM +0200, Marcel Holtmann wrote:
> Hi Pavel,
> 
> > In qca_power_shutdown() qcadev local variable is
> > initialized by hu->serdev.dev private data, but
> > hu->serdev can be NULL and there is a check for it.
> > 
> > Since, qcadev is not used before
> > 
> > 	if (!hu->serdev)
> > 		return;
> > 
> > we can move its initialization after this "if" to
> > prevent gfp.
> > 
> > Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> > ---
> > drivers/bluetooth/hci_qca.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> patch has been applied to bluetooth-next tree.

Why did you pick the v1 when it is clear from thread that a v2 has been
posted?

Johan
