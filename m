Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB5D31F76A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhBSKio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:38:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhBSKib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:38:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D0E464E43;
        Fri, 19 Feb 2021 10:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613731068;
        bh=qcd9CRIEH3/I8yMd16IdmXQbaIW/4WArTLgFGOJFUKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O2JMJyxZUSFv+DoHqoykV3BDG/65tyiHMHHTKq89JOqB9WzY8+zXlowBq0HV7T0Lp
         gTNhl0b5A1I3SP+0aGR9PSTeKzdniPylFQGLrqcMT2VT4VzuinXPtGtt8Z5ZYsUsAG
         Ct93PbNCu8ME2UikpRJ6Y+tWpTUuC4JKPTCjcJAA=
Date:   Fri, 19 Feb 2021 11:37:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jari Ruusu <jariruusu@protonmail.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        Jari Ruusu <jariruusu@users.sourceforge.net>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YC+U+beaI91aXh5z@kroah.com>
References: <YA/E1bHRmZb50MlS@kroah.com>
 <YC4atKmK7ZqlOGER@kroah.com>
 <20210218113107.GA12547@1wt.eu>
 <602E766F.758C74D8@users.sourceforge.net>
 <20210218143341.GB13671@1wt.eu>
 <dbLhDu5W6LMrWDRrgzNQJGLZPMWGkRtOcxFUbghT-Uuc8zmQObV5KjhYqVBo2U6k7r2rNVtVEaMjev_lyz8eNQGvksSTjVrHd8LaPrO_6Qs=@protonmail.com>
 <YC6nZH/4CkLLsxxB@kroah.com>
 <sjYC-8XCIa2KTTlzjXs95LPnYQJvJe3Lrz4tR9NZTLLIfQpWLquW6W2siZAP7wtgHXOsK5bSxo8JqJp7iPLQ_NtDhh8GbES8J3dUlB5sqYs=@protonmail.com>
 <YC91OWVGAfyorRbc@kroah.com>
 <QYs3MUT8alABsssQUgn1j3b7BF6zgqqiBq0-76Rqcpo6lPFnKyfd8iAagAfotVhDzKP6FFRIjlRVVoIaRtCAEaNT3P-4gyF43rTEPEsvqEA=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QYs3MUT8alABsssQUgn1j3b7BF6zgqqiBq0-76Rqcpo6lPFnKyfd8iAagAfotVhDzKP6FFRIjlRVVoIaRtCAEaNT3P-4gyF43rTEPEsvqEA=@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 10:31:49AM +0000, Jari Ruusu wrote:
> On Friday, February 19, 2021 10:22 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > That's not the goal of stable kernel releases/trees. If the driver
> > version that is in 4.19.y does not work for you on release 4.19.0, odds
> > of that "changing" in later stable releases is slim to none.
> 
> But in-tree iwlwifi worked fine on 4.9.y and 4.14.y , and then got broken
> in later 4.14.y versions.

Did you report that breakage to us and the developers of the driver?
Sounds like a regression that people would love to hear about and get
fixed.

> I tried later versions of 4.19.y in an attempt to
> fix the breakage. Basically you are are saying that I should have NOT
> attempted to upgrage 4.9.y -> 4.14.y -> 4.19.y

Without anyone reporting a problem, how can anyone know to fix it?

thanks,

greg k-h
