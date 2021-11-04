Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E412445563
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhKDOg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:36:26 -0400
Received: from smtprelay0167.hostedemail.com ([216.40.44.167]:57600 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230420AbhKDOgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:36:19 -0400
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 012C2180CE8B1;
        Thu,  4 Nov 2021 14:33:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 2F3521A29FB;
        Thu,  4 Nov 2021 14:33:39 +0000 (UTC)
Message-ID: <2dd81d1a081562dc38bf9d8c6c73b432c5c5f496.camel@perches.com>
Subject: Re: [PATCH v2 1/8] staging: vt6655: Introduce `idx` temporary
 variable
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Nov 2021 07:33:36 -0700
In-Reply-To: <20211104120906.GZ2794@kadam>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
         <34bd0e8f42597edf006a950d420345befc4e0bc2.1635773680.git.karolinadrobnik@gmail.com>
         <20211104120906.GZ2794@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 2F3521A29FB
X-Spam-Status: No, score=-4.03
X-Stat-Signature: ym7brcnsortog1j73xkg4kdzqxc7tnr5
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18uR0zxuo0tNhsoMrtOh3B2gvog+OSoLGg=
X-HE-Tag: 1636036419-603949
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-11-04 at 15:09 +0300, Dan Carpenter wrote:
> On Mon, Nov 01, 2021 at 02:31:59PM +0000, Karolina Drobnik wrote:
> > Add a local variable to store `MISCFIFO_SYNDATA_IDX` offset.
> > This change helps in shortening the lines in `rf.c` that
> > are deemed too long by checkpatch.pl.
> > 
> 
> I started reviewing the v1 patch but I should have been reviewing this
> patchset.  Please don't do this.  Leave the constant as a constant so
> we don't have to look it up.

It's just an intermediate step to use idx++.
Personally, I'd combine patches to add and use idx++ directly.


