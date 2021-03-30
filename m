Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F8234EB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhC3OwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232085AbhC3Ov7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:51:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DB9D619CD;
        Tue, 30 Mar 2021 14:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617115918;
        bh=QRCxLkm1xfgmDEANzJ0hjYvujYLz7NRAUc6d4FczU74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vd02VnQGGZCXzoCM38zuhUtu3mQj8bH6yXivtrMbswqyaNPuyQX0O3mggp0txXvL2
         j4H2z/o8MvZfbLwFEEz6llm/obH67O2GexJ1sggxMaoHTK5KZIpOASpHouKAO7vUEq
         HPrbw6p5dyp29QuPWYZcv9gbQDeMr2OGSgdq7n4Y=
Date:   Tue, 30 Mar 2021 16:51:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH v1 1/4] docs: make reporting-issues.rst official and
 delete reporting-bugs.rst
Message-ID: <YGM7DIbkEUvHkMfr@kroah.com>
References: <cover.1617113469.git.linux@leemhuis.info>
 <49c674c2d304d87e6259063580fda05267e8c348.1617113469.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49c674c2d304d87e6259063580fda05267e8c348.1617113469.git.linux@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 04:13:04PM +0200, Thorsten Leemhuis wrote:
> Remove the WIP and two FIXME notes in the text to make it official, as
> it's now considered fully ready for consumption. To make sure this
> step is okay for people the intent of this change and the latest version
> of the text were posted to ksummit-discuss; nobody complained, thus
> lets move ahead.
> 
> Add a footer to point out people can contact Thorsten directly in case
> they find something to improve in the text.
> 
> Dear reporting-bugs.rst, I'm sorry to tell you, but that makes you fully
> obsolete and we thus have to let you go now. Thank you very much for
> your service, you in one form or another have been around for a long
> time. I'm sure over the years you got read a lot and helped quite a few
> people. But it's time to retire now. Rest in peace.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> CC: Harry Wei <harryxiyou@gmail.com>
> CC: Alex Shi <alex.shi@linux.alibaba.com>
> CC: Federico Vaga <federico.vaga@vaga.pv.it>
> CC: Greg KH <gregkh@linuxfoundation.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
