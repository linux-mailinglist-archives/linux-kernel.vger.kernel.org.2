Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCF433D5CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbhCPOcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236543AbhCPObx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:31:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8063865077;
        Tue, 16 Mar 2021 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615905113;
        bh=Pj8EjsyV6nSEyT3De+w9NtMPdcR5eySCMvHgLVhHRD0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=R391KVMhxdaMz5l2+yy0eSzumYwYV0CPLB9AM3f+GLvqBLLW14orflxpVMn/U9Js5
         8OOPNe6KDPeeBJ0XjBfJmN1ZvRanOaq4E770Qlp3BRcxzF69Lco1kNwggaA64RP4jV
         3ycMyMg5E7MquAyeap0cUw7ZN4Zz30xfc4VNBunbtYgYmomiiFlbctKnTk4x8aE9vP
         lJCpKuvmwP10XQPPQVnxsViRtFj1mJQHWhPNHwPipwOgffsE1EkVmF7LvZCpGVZaYM
         Zy0bZPD0vJeYy+0fHilN8le81Qf3AeT2Ixk/WXi+2pn89/ARwDa59cJLK+zOdQo1ya
         k1opd4zBTVCEA==
Date:   Tue, 16 Mar 2021 15:31:50 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: avoid deadlock between hci_dev->lock and
 socket lock
In-Reply-To: <657367AC-ACB8-441D-83E0-2BA1DFCD6B41@holtmann.org>
Message-ID: <nycvar.YFH.7.76.2103161531220.12405@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2103041405420.12405@cbobk.fhfr.pm> <nycvar.YFH.7.76.2103161125530.12405@cbobk.fhfr.pm> <nycvar.YFH.7.76.2103161507280.12405@cbobk.fhfr.pm> <657367AC-ACB8-441D-83E0-2BA1DFCD6B41@holtmann.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021, Marcel Holtmann wrote:

> > Fixes: eab2404ba798 ("Bluetooth: Add BT_PHY socket option")
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> > ---
> > net/bluetooth/hci_conn.c | 4 ----
> > 1 file changed, 4 deletions(-)
> 
> patch has been applied to bluetooth-next tree.

Thanks; could it be pushed for 5.12-rc still though? It fixes an actual 
possibility of deadlock.

-- 
Jiri Kosina
SUSE Labs

