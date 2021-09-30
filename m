Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D4441D310
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 08:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348235AbhI3GLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 02:11:24 -0400
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:37400 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1348185AbhI3GLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 02:11:22 -0400
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A9DEA18295456;
        Thu, 30 Sep 2021 06:09:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id A1EDD20D756;
        Thu, 30 Sep 2021 06:09:38 +0000 (UTC)
Message-ID: <18946cc7c531670d5dcf2961d613e3a171603123.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8712: Statements should start on a tabstop
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dawid Esterhuizen <desterhuizen@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Wed, 29 Sep 2021 23:09:37 -0700
In-Reply-To: <YVVSYVpUPekkUsLy@kroah.com>
References: <YVTN5i8qwjlGwOPp@kkobus.whirley.local>
         <YVVSYVpUPekkUsLy@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: A1EDD20D756
X-Spam-Status: No, score=1.59
X-Stat-Signature: k91whbj3ts8w1je1op558thr1e8m9p5f
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/Kx4o3nCUJHOvGGanFgH/0dYwUWzXiUcw=
X-HE-Tag: 1632982178-490766
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-09-30 at 08:00 +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 29, 2021 at 10:34:46PM +0200, Dawid Esterhuizen wrote:
> > This path fixes four checkpatch.pl warnings:
> > 
> > Statements should start on a tabstop
[]
> > diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8712/rtl871x_xmit.h
[]
> > @@ -182,11 +182,11 @@ struct sta_xmit_priv {
> >  };
> >  
> > 
> >  struct	hw_txqueue {
> > -	/*volatile*/ sint	head;
> > -	/*volatile*/ sint	tail;
> > -	/*volatile*/ sint	free_sz;	/*in units of 64 bytes*/
> > -	/*volatile*/ sint      free_cmdsz;
> > -	/*volatile*/ sint	 txsz[8];
> > +  /*volatile*/ sint head;
> > +  /*volatile*/ sint tail;
> > +  /*volatile*/ sint free_sz;	/*in units of 64 bytes*/
> > +  /*volatile*/ sint free_cmdsz;
> > +  /*volatile*/ sint txsz[8];
> 
> I think you now have added a new checkpatch warning, right?
> 
> This is not the correct indentation anymore, why not work to see if you
> can remove the volatile comment instead?

And maybe one day do

$ sed -i -e 's/\bsint\b/int/' drivers/staging/rtl8712/*.[ch]
$ sed -i 19d drivers/staging/rtl8712/basic_types.h


