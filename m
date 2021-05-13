Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CA137FBF4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 18:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhEMRAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhEMRAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:00:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 997F76121E;
        Thu, 13 May 2021 16:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620925173;
        bh=TXYX/OBtl5cMNDBowQtxBzLpmaMgEzMaBstYgYav7Xo=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=nRIzw0KHOUfhboS0pnLaZLT2dPOSQRcQAdf02HDJsTo1fevxER1VR2inVSdw5ufrQ
         KfRk3RUqHD5wF7ocolHB+mGjya0FI3lLcm4DWjTr4BB4zmaHGu4akBMBpXFc5wWOXR
         dGMDBqD9qXDzcHkOa96ssxUEtjtS3h+CWBNqxNso=
Date:   Thu, 13 May 2021 18:59:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/69] "Revert and fix properly" patch series based on
 umn.edu re-review
Message-ID: <YJ1a8qo4xfi8Bpcz@kroah.com>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 01:56:27PM +0200, Greg Kroah-Hartman wrote:
> Hi all,
> 
> [individuals put on bcc: due to quantity would have been rejected by vger]
> 
> Here is the "final" set of reverts and fixes based on the re-review of
> all accepted umn.edu commits.  It consists of 7 "clean" reverts that do
> not need to be fixed up again for various reasons (see the commit
> messages for reasoning), and then 31 sets of "revert & fix" commits that
> consist of reverting the offending commit and then fixing it up
> properly.
> 
> Where these patches were accepted into stable kernels, I've properly
> tagged them for reverting in the stable kernels automatically as well.
> 
> I'll be taking these through one of my trees, so there's no need for any
> maintainer to have to worry about these needing to go through theirs.

These are now merged (minus the ones people asked me to drop) to my
char-misc tree.

thanks,

greg k-h
