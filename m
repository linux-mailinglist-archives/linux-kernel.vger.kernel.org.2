Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CD035AA52
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 04:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhDJCcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 22:32:11 -0400
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:44586 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229665AbhDJCcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 22:32:10 -0400
Received: from omf03.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 396D718150A50;
        Sat, 10 Apr 2021 02:31:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 3314B13D94;
        Sat, 10 Apr 2021 02:31:55 +0000 (UTC)
Message-ID: <04fcc5ac37f750e335447aee57da5aad072e321d.camel@perches.com>
Subject: Re: [PATCH 4/6] staging: rtl8192e: matched alignment with open
 parenthesis
From:   Joe Perches <joe@perches.com>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        mitali_s@me.iitr.ac.in
Date:   Fri, 09 Apr 2021 19:31:53 -0700
In-Reply-To: <YHEMrQdEFpXgmMh/@kali>
References: <YHEA2Te3Hik5J39t@kali>
         <f5fe04d62b22eb5e09c299e769d9b9d8917f119c.camel@perches.com>
         <YHEMrQdEFpXgmMh/@kali>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.10
X-Stat-Signature: qyweys8gmc393ikshcq9nfi1t1idfwm4
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 3314B13D94
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/jsGVRnYflYxVFQhm6ZrKMmWNfkAc0CcM=
X-HE-Tag: 1618021915-880427
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-04-10 at 07:55 +0530, Mitali Borkar wrote:
> On Fri, Apr 09, 2021 at 07:07:09PM -0700, Joe Perches wrote:
> > On Sat, 2021-04-10 at 07:05 +0530, Mitali Borkar wrote:
> > > Matched the alignment with open parenthesis to meet linux kernel coding
> > > style.
> > > Reported by checkpatch.
> > []
> > > diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > []
> > > @@ -154,7 +154,7 @@ bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
> > >  	    (net->ralink_cap_exist))
> > >  		retValue = true;
> > >  	else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
> > > -		!memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
> > > +		 !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
> > >  		!memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ||
> > >  		(net->broadcom_cap_exist))
> > 
> > checkpatch is a stupid script.
> > Look further at the code not just at what checkpatch reports.
> > Align all the contination lines, not just the first one.
> > 
> Sir, I have aligned them in last patch of this patchset.

This sort of change should not require an additional patch.


