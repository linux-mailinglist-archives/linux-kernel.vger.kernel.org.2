Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0321336C73F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbhD0NtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:49:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238228AbhD0NtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:49:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B67B6101C;
        Tue, 27 Apr 2021 13:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619531304;
        bh=b2MVfgdzEpTCMzLImz6LBQpSQbFIRH6rKQPB/5aCYig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WYVL/eNW7+/nioxJ5ZduHlgHzm4ZwVET3zYC4pPzth3Oi8XWWTX6AAqlYZhiLn/zk
         v+pV6m1f9GMNo9UXKW5TMkvT0X/UbGmzjvoXJjsmMxUvC8oYC1crSX3g0jRAE2XKGz
         T3PsD63simAZdvkGEpYCdwfc7gGIVNa95ZsRzT4A=
Date:   Tue, 27 Apr 2021 15:48:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH 047/190] Revert "rxrpc: Fix a memory leak in
 rxkad_verify_response()"
Message-ID: <YIgWJeSWjG0oe8H6@kroah.com>
References: <20210421130105.1226686-48-gregkh@linuxfoundation.org>
 <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <2189111.1619022623@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2189111.1619022623@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 05:30:23PM +0100, David Howells wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > This reverts commit f45d01f4f30b53c3a0a1c6c1c154acb7ff74ab9f.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Qiushi Wu <wu000273@umn.edu>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Markus Elfring <Markus.Elfring@web.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This is actually a good patch, so please don't revert it.

Now dropped from my series, thanks!

greg k-h
