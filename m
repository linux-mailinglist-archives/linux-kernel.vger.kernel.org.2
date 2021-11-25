Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E637A45DEA6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbhKYQi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:38:27 -0500
Received: from smtprelay0231.hostedemail.com ([216.40.44.231]:60660 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231462AbhKYQg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:36:26 -0500
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B0AC7184A82D7;
        Thu, 25 Nov 2021 16:33:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id D9D16C00026E;
        Thu, 25 Nov 2021 16:33:12 +0000 (UTC)
Message-ID: <43a6728ed1c584d9037abf8ef631342a941f132d.camel@perches.com>
Subject: Re: [PATCH 2/2] get_maintainer: ignore "my" e-mail address
From:   Joe Perches <joe@perches.com>
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 25 Nov 2021 08:33:12 -0800
In-Reply-To: <dleftjpmqob4c0.fsf%l.stelmach@samsung.com>
References: <a0bd71ce82c7c7b9cb72972b091f9f1054b6595c.camel@perches.com>
         <CGME20211125161420eucas1p2b3dbac252dab05d0a5406d0fca8ab945@eucas1p2.samsung.com>
         <dleftjpmqob4c0.fsf%l.stelmach@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: haarb4tnwqhprahn84pb8soxz4c9r8qz
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: D9D16C00026E
X-Spam-Status: No, score=-4.45
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19Aor5k0IK75zzgsxBED/4GTBg2PoQJ0RM=
X-HE-Tag: 1637857992-314205
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-11-25 at 17:14 +0100, Lukasz Stelmach wrote:
> It was <2021-11-16 wto 15:14>, when Joe Perches wrote:
> > On Tue, 2021-11-16 at 22:34 +0100, Łukasz Stelmach wrote:
> > > Ignore one's own e-mail address given as a parameter to --ignore-me
> > > or in the EMAIL environment variable.
> > 
> > Why is this useful?
> > 
> > git send-email already supports this.
> > 
> >        --suppress-cc=<category>
> >            Specify an additional category of recipients to suppress
> >            the auto-cc of:
> > 
> >            •   author will avoid including the patch author
> > 
> >            •   self will avoid including the sender
> > 
> >       --[no-]suppress-from
> >            If this is set, do not add the From: address to the cc:
> >            list. Default is the value of sendemail.suppressFrom
> >            configuration value; if that is unspecified, default to
> >            --no-suppress-from.
> > 
> 
> Not really, git send-email does not support --suppress-to, and with
> get_maintainers.pl coupled with git send-email as follows
> 
> --8<---------------cut here---------------start------------->8---
> [sendemail]
>         tocmd = "`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nol --"
>         cccmd = "`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nom --nor --nofixes --"
> --8<---------------cut here---------------end--------------->8---
> 
> my address is added to To: if I am a maintainer of the patched files.
> To avoid this the --ignore-me options can be added to tocmd.
> 


