Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA71366FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244216AbhDUQEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbhDUQEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:04:39 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D18DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:04:06 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZFKc-0074PF-0u; Wed, 21 Apr 2021 16:04:02 +0000
Date:   Wed, 21 Apr 2021 16:04:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH 053/190] Revert "ecryptfs: replace BUG_ON with error
 handling code"
Message-ID: <YIBM8hiBLFO+JJr/@zeniv-ca.linux.org.uk>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-54-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-54-gregkh@linuxfoundation.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:48PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 2c2a7552dd6465e8fde6bc9cccf8d66ed1c1eb72.
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

FWIW, commit message on the original (
ecryptfs: replace BUG_ON with error handling code

In crypt_scatterlist, if the crypt_stat argument is not set up
correctly, the kernel crashes. Instead, by returning an error code
upstream, the error is handled safely.

The issue is detected via a static analysis tool written by us.

Fixes: 237fead619984 (ecryptfs: fs/Makefile and fs/Kconfig)
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Tyler Hicks <code@tyhicks.com>
)
really stinks.  First, the analysis: condition being tested is
(!crypt_stat || !crypt_stat->tfm
               || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED))
and their patch replaces BUG_ON() with return of -EINVAL.  So the
only thing their tool had detected the presence of BUG_ON().
Was it grep, by any chance?  

IOW, the commit message is "we'd found BUG_ON(); let's replace it
with returning some error value and hope everything works.  Whaddya
mean, how do we know?  Our tool [git grep BUG_ON, that is] says
it's there and look, it *is* there, so if it's ever reached there'll
be trouble.  What, assertion that returning an error will be handled
safely?   'Cuz we saiz so, that's why"


It *is* functionally harmless, AFAICS, but only because the condition
is really impossible.  However,
	* it refers to vague (s)tool they'd produced, nevermind that
all they really do is "find BUG_ON(), replace with returning an error".
	* unlike BUG_ON(), the replacement does *NOT* document the
fact that condition should be impossible.
IMO either should be sufficient for rejecting the patch.
