Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39CA37194E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 18:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhECQcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 12:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231223AbhECQcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:32:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43E1861166;
        Mon,  3 May 2021 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620059482;
        bh=1fPJCR4+ZH8ePNHERcYZgNQvKEqZ1nRY9pSzh2KTnJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qbe8Am5l+ixtc+C3MF1ygCkEZ5ujn4HLGP0thqb9VBFrt7qkymu4N6zPSSzBc1Zr2
         M0ZvpzSgGhbE9HLIZtmUNkjHwNe7dj8qXXWfyZNklaWKcXvPNWzBF/7ICbOerAMn9q
         bqJ3iDMsZ+G61sGihrKeqsUMNUzWVne5B/2NEgwc=
Date:   Mon, 3 May 2021 18:31:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        David Kershner <david.kershner@unisys.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [Outreachy kernel] [PATCH v5] staging: unisys: visorhba: Convert
 module from IDR to XArray
Message-ID: <YJAlWJXDnK9KLg2H@kroah.com>
References: <20210427150719.30841-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427150719.30841-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 05:07:19PM +0200, Fabio M. De Francesco wrote:
> Converted visorhba from IDR to XArray. The abstract data type XArray is
> more memory-efficient, parallelisable and cache friendly. It takes
> advantage of RCU to perform lookups without locking.

And does any of that affect the runtime of this driver?

I would need this to be tested by the maintainer before I could do
anything, and a review from willy@ would be also appreciated as I'm
guessing he asked you to do this?

thanks,

greg k-h
