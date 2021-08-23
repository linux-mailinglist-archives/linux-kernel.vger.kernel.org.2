Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5FB3F48C2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbhHWKgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:36:35 -0400
Received: from smtprelay0216.hostedemail.com ([216.40.44.216]:42184 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234457AbhHWKge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:36:34 -0400
Received: from omf12.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B55E9181D303C;
        Mon, 23 Aug 2021 10:35:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id B05F5240236;
        Mon, 23 Aug 2021 10:35:50 +0000 (UTC)
Message-ID: <79330fbb1ac84c8c489c8495b4ff34cc5b446c0c.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Improve GIT_COMMIT_ID test
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org
Date:   Mon, 23 Aug 2021 03:35:48 -0700
In-Reply-To: <20210822150354.3c0dcb7d7e8fefaa856383e5@linux-foundation.org>
References: <976c6cdd680db4b55ae31b5fc2d1779da5c0dc66.camel@perches.com>
         <20210822150354.3c0dcb7d7e8fefaa856383e5@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: B05F5240236
X-Spam-Status: No, score=1.59
X-Stat-Signature: hy3xswbcspexwypsop7p5tdc4gi53f4i
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+Y50qveyWsyKLkH9KfzT5LaPtuz4EwODQ=
X-HE-Tag: 1629714950-901393
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-08-22 at 15:03 -0700, Andrew Morton wrote:
> On Fri, 20 Aug 2021 14:46:51 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > +		if ($perl_version_ok
> > +		    $in_commit_log && !$commit_log_possible_stack_dump &&
> 
> Needs &&.   Was the correct version sent?

Yes, but I stuffed up the && around the perl_version_ok test
I added at the last minute.

oops.


