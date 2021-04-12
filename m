Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C2135C2CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbhDLJuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241124AbhDLJhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:37:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C72896120F;
        Mon, 12 Apr 2021 09:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618220198;
        bh=sGwqaz3CpeSUy1C5Wd/vFz8NkdWN9zpzlYSkj0cshD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xH7N4h6qhQJc8GnunUJp/WVObp/Xynp1va/lJ0USlrm2gFzU8lauLpv7qqY0lOOuD
         UfxQzBbRY0WKUFdB1odnq65aJ1tUdArq3xI98iVJrglsmQe0VjavLCT0oOd9Ep6eOl
         vGL+ylJd1f0a/vceA0Ia6TE8FDmYQODzfK6ekKKM=
Date:   Mon, 12 Apr 2021 11:36:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH v4 0/3] staging: rtl8192e: modified log message
Message-ID: <YHQUoz/eQ+By5Bd1@kroah.com>
References: <cover.1618139271.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618139271.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 05:04:46PM +0530, Mitali Borkar wrote:
> This patch fixes style issues
> Changes from v3:-
> [PATCH v3 1/3]:- Modified log message.
> [PATCH V3 2/3]:- No changes.
> [PATCH v3 3/3]:- No changes

Your subject line here is odd :(

Please fix up.

thanks,

greg k-h
