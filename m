Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6372935EF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349647AbhDNIUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231825AbhDNIUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:20:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0554613B1;
        Wed, 14 Apr 2021 08:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618388425;
        bh=riGWsoIxXItIjhgKXrwEti07y5iF8ReFcCz2X1qZ3ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+/pjhnt6FIJpq30LX7bTmVUzxMzX2Wn7Zez1wT0be/z7F54s+qLO7yGdSVi2J7cS
         F+cJqyozSEMfdzIhqWtMbjWpW16LoSE5lBpbAay2pzKw3LieYieO1rtY+BoYcjwqBn
         65hbgzNjjEACe5nNh+wK5XLvvYi2WfqtNWj+oTPg=
Date:   Wed, 14 Apr 2021 10:20:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: Subject: [PATCH v2 0/5] staging: rtl8192e: CLeanup patchset for
 style issues in rtl819x_Y.c files
Message-ID: <YHalxnhnf0ZcVafz@kroah.com>
References: <cover.1618380932.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618380932.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 12:24:44PM +0530, Mitali Borkar wrote:
> Changes from v1:- Dropped 6/6 from and made this as a patchset of 5 as
> alignment of code is done in following patches.

Why is "Subject:" listed in your subject line?  Do not manually add it
after git format-patch has created it...

thanks,

greg k-h
