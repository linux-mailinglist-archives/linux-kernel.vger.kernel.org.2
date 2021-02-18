Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955EE31F287
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhBRWut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:50:49 -0500
Received: from hosting.gsystem.sk ([212.5.213.30]:54544 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBRWuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:50:46 -0500
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Feb 2021 17:50:45 EST
Received: from [192.168.0.2] (188-167-68-178.dynamic.chello.sk [188.167.68.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id E95547A0088;
        Thu, 18 Feb 2021 23:43:38 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Pavel Machek <pavel@ucw.cz>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Date:   Thu, 18 Feb 2021 23:43:35 +0100
User-Agent: KMail/1.9.10
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jari Ruusu <jariruusu@users.sourceforge.net>,
        Willy Tarreau <w@1wt.eu>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com> <YC55t1vkRuC9uXcx@kroah.com> <20210218205534.GA10201@duo.ucw.cz>
In-Reply-To: <20210218205534.GA10201@duo.ucw.cz>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202102182343.36276.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 February 2021 21:55:34 Pavel Machek wrote:
> Hi!
> 
> > > For me
> > > only way to get properly working WiFi on my laptop computer is to
> > > compile that Intel out-of-tree version. Sad, but true.
> > 
> > Why use 4.19.y on a laptop in the firstplace?  That feels very wrong and
> > is not the recommended thing to use the LTS kernels for.
> 
> Well, that's actually what distributions are doing, for example Debian
> 10.8 is on 4.19...

There's 5.10 in buster-backports. That's probably the easiest way to get support for new HW.
 
> I expect -stable is what most users are running on their notebooks.
> 
> Best regards,
> 									Pavel


-- 
Ondrej Zary
