Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40817366EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243942AbhDUPV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239766AbhDUPVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:21:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6703061426;
        Wed, 21 Apr 2021 15:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619018448;
        bh=lmwNdiS/RRJHFrxHsWmhI37tDRzpyWtMo3iU0MPxU18=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nfcISJrLXxjXXJKbNj54Jb3UdlquJLKT0x0L2DH+fcgNb061sF5n/7DfW8B0SVWaf
         JkYXVk92tpdfR3M75XSiwpROsqVezjskYglIDjRuOUduPGUJMqwLwk+B0EwnsBarWr
         B03r6tbJ2eXmF14pqGDyBZ3/arjc68y8enr9lZ4bw8fTkrybU8MWlBZGUhK/oUBnDh
         v5e3Gi/K4THuFA+MGqiXrVsNyxlBJvrABHMA3NS/3H+PuXpVBXHI93pCqwyotaWO5V
         k/iXjFzGR7RPozHRB2pj9+esi3diAB92RoM/PBpDm9Ew8V7ryRNqkZ7xAiZIisvAE9
         AQ/rUDehJjQig==
Date:   Wed, 21 Apr 2021 17:20:45 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 122/190] Revert "HID: logitech: check the return value
 of create_singlethread_workqueue"
In-Reply-To: <20210421130105.1226686-123-gregkh@linuxfoundation.org>
Message-ID: <nycvar.YFH.7.76.2104211719330.18270@cbobk.fhfr.pm>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <20210421130105.1226686-123-gregkh@linuxfoundation.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021, Greg Kroah-Hartman wrote:

> This reverts commit 6c44b15e1c9076d925d5236ddadf1318b0a25ce2.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This particular one doesn't have to be reverted, I have reviewed it again 
and it does fix an actual bug.

Thanks,

-- 
Jiri Kosina
SUSE Labs

