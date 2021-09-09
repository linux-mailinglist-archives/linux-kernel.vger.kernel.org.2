Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCAE404521
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 07:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350778AbhIIFpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 01:45:38 -0400
Received: from smtprelay0001.hostedemail.com ([216.40.44.1]:54974 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230515AbhIIFph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 01:45:37 -0400
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 10FF2181A349D;
        Thu,  9 Sep 2021 05:44:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 3667320A293;
        Thu,  9 Sep 2021 05:44:25 +0000 (UTC)
Message-ID: <685524a360bc910210cbbb7b13a46ead26ed8a22.camel@perches.com>
Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
From:   Joe Perches <joe@perches.com>
To:     "Yu, Lang" <Lang.Yu@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 08 Sep 2021 22:44:23 -0700
In-Reply-To: <DM6PR12MB425005AE652C12F04E66B5B8FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
         <04b52ef5b63abf25e6d50fd5bdfa90727e100a09.camel@perches.com>
         <DM6PR12MB425005AE652C12F04E66B5B8FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.06
X-Stat-Signature: hcx35qtikp5gm4brbzinwfoyfye55113
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 3667320A293
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+Bj3NeFOLM0Be1OIOpqw/OEwoJ3CGvOUg=
X-HE-Tag: 1631166265-415411
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-09-09 at 05:27 +0000, Yu, Lang wrote:
> [AMD Official Use Only]

this is a public list and this marker is not appropriate.


> > -----Original Message-----
> > From: Joe Perches <joe@perches.com>
> > On Wed, 2021-09-08 at 20:07 +0800, Lang Yu wrote:
> > > The key purpose of sysfs_emit and sysfs_emit_at is to ensure that no
> > > overrun is done. Make them more equivalent with scnprintf.
> > 
> > I can't think of a single reason to do this.
> > sysfs_emit and sysfs_emit_at are specific to sysfs.
> > 
> > Use of these functions outside of sysfs is not desired or supported.
> > 
> Thanks for your reply. But I'm still curious why you put such a limitation.
> As "Documentation/filesystems/sysfs.rst" described, we can just  use 
> scnprintf(buf, PAGE_SIZE, "%s\n", dev->name) in show functions without
> such a limitation.

There's nothing particularly wrong with the use of scnprintf as above.

The only real reason that sysfs_emit exists is to be able to reduce the
kernel treewide quantity of uses of the sprintf family of functions
that need to be analyzed for possible buffer overruns.

The issue there is that buf is already known to be both a PAGE_SIZE buffer
and PAGE_SIZE aligned for sysfs show functions so there's no real reason
to use scnprintf.

sysfs_emit is a shorter/smaller function and using it could avoid some
sprintf defects.

> Some guys just try to replace scnprintf with sysfs_emit() or sysfs_emit_at() per above documents.

So don't do that.

> But sprintf and sysfs_emit/sysfs_emit_at are not totally equivalent(e.g., page boundary align).
> 
> In my opinion, we add a new api and try to replace an old api. Does we need to make it more
> compatible with old api?

IMO: no.


