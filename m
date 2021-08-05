Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C093E1AED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbhHESEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:04:35 -0400
Received: from smtprelay0012.hostedemail.com ([216.40.44.12]:60950 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231372AbhHESEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:04:33 -0400
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 7511F180CE6B7;
        Thu,  5 Aug 2021 18:04:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 3A1692EBF91;
        Thu,  5 Aug 2021 18:04:17 +0000 (UTC)
Message-ID: <e07845c0348f389756b76e34b4728a95aa48038a.camel@perches.com>
Subject: Re: [PATCH] checkpatch: prefer = {} initializations to = {0}
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Whitcroft <apw@canonical.com>,
        cocci <cocci@systeme.lip6.fr>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Thu, 05 Aug 2021 11:04:15 -0700
In-Reply-To: <117021b44dc9ba570a0f48736d14a267a8701d0a.camel@perches.com>
References: <20210805104353.GD26417@kili>
         <117021b44dc9ba570a0f48736d14a267a8701d0a.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 3A1692EBF91
X-Spam-Status: No, score=1.60
X-Stat-Signature: uuzrtmw455mqebh8n9s3w4pphs8ayi33
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+EbY700CWuSN6m4MPwodG2UK3X8b9qYnI=
X-HE-Tag: 1628186657-39462
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-08-05 at 05:27 -0700, Joe Perches wrote:
> On Thu, 2021-08-05 at 13:43 +0300, Dan Carpenter wrote:
> > The "= {};" style empty struct initializer is preferred over = {0}.
> > It avoids the situation where the first struct member is a pointer and
> > that generates a Sparse warning about assigning using zero instead of
> > NULL.  Also it's just nicer to look at.

Perhaps a cocci script like the below could help too:

$ cat zero_init_struct.cocci
@@
identifier name;
identifier t;
@@

	struct name t = {
-	       0
	};

@@
identifier name;
identifier t;
identifier member;
@@

	struct name t = {
	       ...,
		.member = {
-		0
		},
		...,
	};


