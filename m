Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576B24412BD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 05:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhKAEd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 00:33:57 -0400
Received: from smtprelay0248.hostedemail.com ([216.40.44.248]:40528 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229457AbhKAEd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 00:33:56 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E181C100E5214;
        Mon,  1 Nov 2021 04:31:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 5F65BD1514;
        Mon,  1 Nov 2021 04:31:21 +0000 (UTC)
Message-ID: <df0f1d2a911acce47eb4525ff4791c751b72821a.camel@perches.com>
Subject: Re: [PATCH] staging: r8188eu: os_dep: remove the goto statement
From:   Joe Perches <joe@perches.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Date:   Sun, 31 Oct 2021 21:31:20 -0700
In-Reply-To: <7f406b96-fbfd-bd3e-182b-3ca8b3056635@gmail.com>
References: <YX7cCtVss2RWOJ/a@Sauravs-MacBook-Air.local>
         <f26b4aec-c0a1-8c93-b34e-8b1a36ac81b3@gmail.com>
         <bc976b72692512f33ae90183f588af38a06a2aa1.camel@perches.com>
         <7f406b96-fbfd-bd3e-182b-3ca8b3056635@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.38
X-Stat-Signature: f1rap3rt6r4iick1wtz1o3nh4ehw4rnd
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 5F65BD1514
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+jEJ6gS/hjU1Ex8EJKzyQu6Ji0Itq6+hk=
X-HE-Tag: 1635741081-964563
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-01 at 09:58 +0530, Saurav Girepunje wrote:
> On 01/11/21 12:47 am, Joe Perches wrote:
> > On Sun, 2021-10-31 at 21:43 +0300, Pavel Skripkin wrote:
> > > On 10/31/21 21:10, Saurav Girepunje wrote:
> > > > Remove the goto statement from rtw_init_drv_sw(). In this function goto
> > > > can be replace by return statement. As on goto label exit, function
> > > > only return it is not performing any cleanup. Avoiding goto will
> > > > improve the function readability.
[]
> > > And just `return _SUCCESS;` here.
> > 
> > And maybe one day s/_SUCCESS/true/ and s/_FAIL/false/
> > with appropriate conversions to bool
> 
> Yes this is another improvement possible on this function.

Not just this function, globally in the driver.

