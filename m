Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA1338166A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 08:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhEOG4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 02:56:53 -0400
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:44462 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229943AbhEOG4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 02:56:52 -0400
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 66D571800AC96;
        Sat, 15 May 2021 06:55:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 1A7DD2351F4;
        Sat, 15 May 2021 06:55:37 +0000 (UTC)
Message-ID: <4f757b9bab4c9575f0257db6b9ed5a75419a3420.camel@perches.com>
Subject: Re: [PATCH] staging: greybus: add declare_ to declaring macros
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Cc:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Fri, 14 May 2021 23:55:36 -0700
In-Reply-To: <YJ9dDwKMKkifeICJ@kroah.com>
References: <20210515034116.660895-1-chouhan.shreyansh630@gmail.com>
         <YJ9dDwKMKkifeICJ@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.40
X-Stat-Signature: 7auarewnqardbaqc4w55mhyxtzkjhgpj
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 1A7DD2351F4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+gFUlaiLQi2Cj5HT380ymyZQO+RTOUjn4=
X-HE-Tag: 1621061737-853347
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-05-15 at 07:33 +0200, Greg KH wrote:
> On Sat, May 15, 2021 at 09:11:16AM +0530, Shreyansh Chouhan wrote:
> > Prefixed the names of all the macros that were used for declaring things
> > with 'declare_'. This should help with clarifying about what these
> > macros do.
> 
> Thanks, but I think I will leave the code as-is.  It's a good "test" for
> people who try to modify the code without actually building it :)

This improves the code for the human reader.
I think wherever reasonable, code should be improved.

In any case, it's a test as checkpatch will emit the same message.


