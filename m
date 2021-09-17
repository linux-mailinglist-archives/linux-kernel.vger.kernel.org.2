Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E6340F917
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 15:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244491AbhIQN2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 09:28:14 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:45678 "EHLO mail.acc.umu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244777AbhIQN2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:28:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by amavisd-new (Postfix) with ESMTP id 587D044B92;
        Fri, 17 Sep 2021 15:26:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=acc.umu.se; s=mail1;
        t=1631885209; bh=vIBXtYbunMJ2qy2dnJIXaGromudxlF91jRJyR2yXAeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AXo+a397b8JpATuAsbvVGMvzJNXOf/SDogUq8rMEkBOq0ss+CFEiG1h2p7uQKKMMS
         tmPQP3k+tmuNcNVKhT9hDHkYXkY36dzlw9oz9aEq3lbWxI/Fe7YIkQtPyilMVGT2A0
         DUc7PKalLCl8QjQM5sXZ5G9s7DNDtZinyUE2Psc34Vpgm0tGxB6+KU/Gu708xOOOjK
         IBh4XcIaOO56EZWBBbLIJQtKgvtCdvladkCj5yVciZzX21dvXfTlBhPNYqBIwgg22M
         xJL4Ph9SAWG1PfUC7VMCnlQri82vFV8FmZseprkXr/C1dmQmtiZXvOHAlrVQLlVkuo
         n8uj5NGpLcKMg==
Received: by mail.acc.umu.se (Postfix, from userid 24471)
        id E99CF44B93; Fri, 17 Sep 2021 15:26:48 +0200 (CEST)
Date:   Fri, 17 Sep 2021 15:26:48 +0200
From:   Anton Lundin <glance@acc.umu.se>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Openipmi-developer] Issue with panic handling and ipmi
Message-ID: <20210917132648.GG108031@montezuma.acc.umu.se>
References: <20210916145300.GD108031@montezuma.acc.umu.se>
 <20210916163945.GY545073@minyard.net>
 <20210917101419.GE108031@montezuma.acc.umu.se>
 <20210917120758.GA545073@minyard.net>
 <20210917125525.GF108031@montezuma.acc.umu.se>
 <20210917131916.GB545073@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210917131916.GB545073@minyard.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 September, 2021 - Corey Minyard wrote:

> On Fri, Sep 17, 2021 at 02:55:25PM +0200, Anton Lundin wrote:
> > On 17 September, 2021 - Corey Minyard wrote:
> > 
> > > On Fri, Sep 17, 2021 at 12:14:19PM +0200, Anton Lundin wrote:
> > > > On 16 September, 2021 - Corey Minyard wrote:
> > > > 
> > > > > On Thu, Sep 16, 2021 at 04:53:00PM +0200, Anton Lundin wrote:
> > > > > > Hi.
> > > > > > 
> > > > > > I've just done a upgrade of the kernel we're using in a product from
> > > > > > 4.19 to 5.10 and I noted a issue.
> > > > > > 
> > > > > > It started that with that we didn't get panic and oops dumps in our erst
> > > > > > backed pstore, and when debugging that I noted that the reboot on panic
> > > > > > timer didn't work either.
> > > > > > 
> > > > > > I've bisected it down to 2033f6858970 ("ipmi: Free receive messages when
> > > > > > in an oops").
> > > > > 
> > > > > Hmm.  Unfortunately removing that will break other things.  Can you try
> > > > > the following patch?  It's a good idea, in general, to do as little as
> > > > > possible in the panic path, this should cover a multitude of issues.
> > > > > 
> > > > > Thanks for the report.
> > > > > 
> > > > 
> > > > I'm sorry to report that the patch didn't solve the issue, and the
> > > > machine locked up in the panic path as before.
> > > 
> > > I missed something.  Can you try the following?  If this doesn't work,
> > > I'm going to have to figure out how to reproduce this.
> > > 
> > 
> > Sorry, still no joy.
> > 
> > My guess is that there is something locking up due to these Supermicro
> > machines have their ERST memory backed by the BMC, and the same BMC is
> > is the other end of all the ipmi communications.
> > 
> > I've reproduced this on Server/X11SCZ-F and Server/H11SSL-i but I'm
> > guessing it can be reproduced on most, if not all, of their hardware
> > with the same setup.
> > 
> > We're using the ERST backend for pstore, because we're still
> > bios-booting them and don't have efi services available to use as pstore
> > backend.
> > 
> > 
> > I've tested to just yank out the ipmi modules from the kernel and that
> > fixes the panic timer and we get crash dumps to pstore.
> 
> Dang.  I'm going to have to look deeper at what that could change to
> cause an issue like this.  Are you using the IPMI watchdog?  Do you have
> CONFIG_IPMI_PANIC_EVENT=y set in the config?

# CONFIG_IPMI_PANIC_EVENT is not set

We're using the IPMI watchdog.

//Anton
