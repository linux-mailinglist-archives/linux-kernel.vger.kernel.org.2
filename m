Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7E636C6A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbhD0NFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235426AbhD0NFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:05:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BB6261164;
        Tue, 27 Apr 2021 13:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619528658;
        bh=tlheHvM//3dXredeBdTckKtkZE7FU+y90X93KD4Z160=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyJRYX60lhAIW+h8cY2Zcecha2sbNSwmFXauc2Pn0JNk9bw4tEtO6uADwLZfR0fA+
         DXzpcOO96eG9r8QOT18pSTVpf8QqRdsz5b0AUMyzV9ukzwa/MMdnf+ZMcSUAdOpbcc
         So+sm5K0aLdWFVRBZKo4KWIvYt0fQ0Epn65QS0uo=
Date:   Tue, 27 Apr 2021 15:04:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 010/190] Revert "media: camss: Fix a reference count
 leak."
Message-ID: <YIgLz1AX+0+CSDYU@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-11-gregkh@linuxfoundation.org>
 <CAG3jFytfaOoJihOyxjMjzRqUOCR+fKhO_nPxVnO62Up0gvoGWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG3jFytfaOoJihOyxjMjzRqUOCR+fKhO_nPxVnO62Up0gvoGWg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 05:43:45PM +0200, Robert Foss wrote:
> Hi Greg,
> 
> Thanks for taking for preventing this type of abuse.
> 
> On Wed, 21 Apr 2021 at 15:03, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This reverts commit d0675b67b42eb4f1a840d1513b5b00f78312f833.
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
> > Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> 
> I think this patch is good, NAK.

I'll drop this from the series, thank you for the review.

greg k-h
