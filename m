Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2283B6387
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 16:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhF1O5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 10:57:34 -0400
Received: from kanga.kvack.org ([205.233.56.17]:58349 "EHLO kanga.kvack.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234382AbhF1OnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:43:18 -0400
Received: by kanga.kvack.org (Postfix, from userid 63042)
        id C8C298D0016; Mon, 28 Jun 2021 10:40:51 -0400 (EDT)
Date:   Mon, 28 Jun 2021 10:40:51 -0400
From:   Benjamin LaHaise <ben@communityfibre.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: linux-mm@kvack.org - limping on a backup
Message-ID: <20210628144051.GM4058@kvack.org>
References: <20210622145954.GA4058@kvack.org> <214c41fae1f1b148e5b04a58c1b018fb091d7e83.camel@HansenPartnership.com> <20210625171259.GG4058@kvack.org> <6f309c63f5b7be968ae679e81ab959db05681e8a.camel@HansenPartnership.com> <20210625192607.GH4058@kvack.org> <20210628134607.GA4604@ziepe.ca> <20210628135352.GL4058@kvack.org> <20210628142659.GB4604@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628142659.GB4604@ziepe.ca>
User-Agent: Mutt/1.4.2.2i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 11:26:59AM -0300, Jason Gunthorpe wrote:
> Isn't a 7-bit conversion what I pointed at last time we talked about
> this?

I changed several options in postfix last time this was raised, but as
nobody ever provided a test case, I had no way of knowing if it worked or
not.  Personally, I think DKIM provides very little value considering that
a good chunk of the spam that goes by has valid DKIM signatures, not to
mention that it doesn't help with modern phishing attempts much either.

> DKIM assumes a "modern" mail system, there should not be 7bit
> conversions in the mail pipeline. Anyone sending DKIM needs to be 8
> bit clean.

"Be strict in what you send, and be liberal in what you receive."  DKIM
makes assumptions about the mail transport layer that are not true.  If
the signatures had been applied on content *after* the quoted printable
conversion, this would never have been an issue.  DKIM is a poorly done
spec that ignores decades of that philosophy at the IETF.  And even if a
DKIM signature passes, that's still not enough to trust the resulting
email.  All it does is ensure that a small subset of valid emails get
dropped on the floor.  This doesn't seem like an overall win.

		-ben
-- 
"Thought is the essence of where you are now."
