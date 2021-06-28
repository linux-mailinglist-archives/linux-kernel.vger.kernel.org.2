Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7513B5F70
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhF1N4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:56:20 -0400
Received: from kanga.kvack.org ([205.233.56.17]:57288 "EHLO kanga.kvack.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhF1N4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:56:19 -0400
Received: by kanga.kvack.org (Postfix, from userid 63042)
        id A2FA38D0016; Mon, 28 Jun 2021 09:53:52 -0400 (EDT)
Date:   Mon, 28 Jun 2021 09:53:52 -0400
From:   Benjamin LaHaise <ben@communityfibre.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: linux-mm@kvack.org - limping on a backup
Message-ID: <20210628135352.GL4058@kvack.org>
References: <20210622145954.GA4058@kvack.org> <214c41fae1f1b148e5b04a58c1b018fb091d7e83.camel@HansenPartnership.com> <20210625171259.GG4058@kvack.org> <6f309c63f5b7be968ae679e81ab959db05681e8a.camel@HansenPartnership.com> <20210625192607.GH4058@kvack.org> <20210628134607.GA4604@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628134607.GA4604@ziepe.ca>
User-Agent: Mutt/1.4.2.2i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 10:46:07AM -0300, Jason Gunthorpe wrote:
> Well, the DKIM issue has been left unresolved for a long time.

> I saw on the bug conversation there seems to be no clear path to fix
> it?

Nobody had ever bothered to provide or figure out a test case.  We have
one now and I'm working with Tucows to try to sort out a fix.

The fact of the matter is that the DKIM spec is broken and doesn't
properly address issues relating to transport of emails containing UTF-8
content over SMTP sessions which are limited to 7 bit transport due to
backwards compatibility assumptions.

		-ben
-- 
"Thought is the essence of where you are now."
