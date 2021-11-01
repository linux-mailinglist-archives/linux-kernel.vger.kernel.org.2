Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F02441EBF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhKAQpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:45:24 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:34142 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231303AbhKAQpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:45:22 -0400
Received: from omf12.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 4D16F100E28CD;
        Mon,  1 Nov 2021 16:42:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 406F9240238;
        Mon,  1 Nov 2021 16:42:47 +0000 (UTC)
Message-ID: <dc4c54b79fb350c9c682ec9bca27562dc32c63e5.camel@perches.com>
Subject: Re: [PATCH v2] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in
 atomic context
From:   Joe Perches <joe@perches.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Date:   Mon, 01 Nov 2021 09:42:46 -0700
In-Reply-To: <11283844.I1tDBM3C2B@localhost.localdomain>
References: <20211101142732.5638-1-fmdefrancesco@gmail.com>
         <d1a8eb91-adb9-2163-dc3d-9f86ebdc45e3@lwfinger.net>
         <11283844.I1tDBM3C2B@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.75
X-Stat-Signature: 1pjiayp4ndtd8irm3pjd7jxa7cc44m54
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 406F9240238
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1886r81CKQZejC6cJRLm96f4oyoY+7QmQA=
X-HE-Tag: 1635784967-872930
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-01 at 17:30 +0100, Fabio M. De Francesco wrote:
> On Monday, November 1, 2021 4:11:26 PM CET Larry Finger wrote:
> > Incidentally, I disagree with checkpatch in that I think that 
> > sizeof(struct foo) is more descriptive than sizeof(*bar). 
> I agree with you in full

It's not checkpatch in particular, it's from coding-style

The preferred form for passing a size of a struct is the following:

.. code-block:: c

	p = kmalloc(sizeof(*p), ...);


