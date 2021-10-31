Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D133A441068
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 20:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhJaTTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 15:19:39 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:37290 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230258AbhJaTTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 15:19:38 -0400
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 7B68E837F24C;
        Sun, 31 Oct 2021 19:17:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id F0C5027DD24;
        Sun, 31 Oct 2021 19:17:03 +0000 (UTC)
Message-ID: <bc976b72692512f33ae90183f588af38a06a2aa1.camel@perches.com>
Subject: Re: [PATCH] staging: r8188eu: os_dep: remove the goto statement
From:   Joe Perches <joe@perches.com>
To:     Pavel Skripkin <paskripkin@gmail.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Date:   Sun, 31 Oct 2021 12:17:02 -0700
In-Reply-To: <f26b4aec-c0a1-8c93-b34e-8b1a36ac81b3@gmail.com>
References: <YX7cCtVss2RWOJ/a@Sauravs-MacBook-Air.local>
         <f26b4aec-c0a1-8c93-b34e-8b1a36ac81b3@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.18
X-Stat-Signature: 91dfg1car3izkut5rpz38cw7z71wr4of
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: F0C5027DD24
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+FHsRn2z//vwNKrAnQnhwFkNT+3kR5ra4=
X-HE-Tag: 1635707823-672371
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-10-31 at 21:43 +0300, Pavel Skripkin wrote:
> On 10/31/21 21:10, Saurav Girepunje wrote:
> > Remove the goto statement from rtw_init_drv_sw(). In this function goto
> > can be replace by return statement. As on goto label exit, function
> > only return it is not performing any cleanup. Avoiding goto will
> > improve the function readability.
[]
> > diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
[]
> > @@ -480,48 +480,34 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
> >   {
> >   	u8	ret8 = _SUCCESS;
> 
> Btw, this variable can be removed completely then. It's used only for:
> 
> ret8 = rtw_init_default_value(padapter);
> 
> with your patch applied, but rtw_init_default_value() always returns 
> _SUCCESS.
> 
> > -exit:
> >  	return ret8;
> >  }
> 
> And just `return _SUCCESS;` here.

And maybe one day s/_SUCCESS/true/ and s/_FAIL/false/
with appropriate conversions to bool


