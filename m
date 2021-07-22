Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351053D2AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhGVQUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:20:54 -0400
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:41190 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236331AbhGVQU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:20:29 -0400
Received: from omf06.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1007A182CF671;
        Thu, 22 Jul 2021 17:01:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 216432448BE;
        Thu, 22 Jul 2021 17:01:03 +0000 (UTC)
Message-ID: <78784bd6436e7010914cde474d07e63ab073205c.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add grammatical judgement for total output
From:   Joe Perches <joe@perches.com>
To:     Hu Haowen <src.res@email.cn>, apw@canonical.com
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 22 Jul 2021 10:01:01 -0700
In-Reply-To: <1e0a9acb-e973-7371-8425-05e066db0827@email.cn>
References: <20210721151416.30530-1-src.res@email.cn>
         <68b4f05607e9e44559e174d9b50e435fb58ef5aa.camel@perches.com>
         <1e0a9acb-e973-7371-8425-05e066db0827@email.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 216432448BE
X-Spam-Status: No, score=0.84
X-Stat-Signature: kop164xq5wc44f7utfjiktkh8et16o5y
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18hEutqydLxO0aX2p8sLjuI1FNtG+pAz6k=
X-HE-Tag: 1626973262-863112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-07-22 at 18:04 +0800, Hu Haowen wrote:
> On 2021/7/22 上午12:03, Joe Perches wrote:
> > On Wed, 2021-07-21 at 23:14 +0800, Hu Haowen wrote:
> > > There lacked a English grammatical identification within the final
> > > output of checkpatch.pl such as the following:
> > > 
> > >     total: 1 errors, 11 warnings, 4094 lines checked
> > >                   ^
> > > 
> > > Which violated the rule about the usage of the singular form and the
> > > plural form. Hence fix the issue up and make it output the proper
> > > sentence.
> > NAK
> > 
> > I appreciate the desire for precision but I don't want to require
> > any automated downstream user of checkpatch to be changed.
> > 
> > I think users understand the output even though it may not be
> > grammatically correct in some cases.
> 
> 
> How about another modification, which turns "errors" into "error(s)"?
> In this case not only did the meaning convey but automated users won't
> be confused toward their automatic programs.

I still think this doesn't need to be changed.

