Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EBC3BA301
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 18:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhGBQDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 12:03:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59862 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229807AbhGBQDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 12:03:50 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 162G1BDU028133
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jul 2021 12:01:12 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 66F6E15C3CE4; Fri,  2 Jul 2021 12:01:11 -0400 (EDT)
Date:   Fri, 2 Jul 2021 12:01:11 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     linux-kernel@vger.kernel.org, leah.rumancik@gmail.com
Subject: Re: [PATCH v4] ext4: wipe ext4_dir_entry2 upon file deletion
Message-ID: <YN84R5GJrv5pvDuj@mit.edu>
References: <b99d8632-6e3d-b557-0ca4-7416a9d818d5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b99d8632-6e3d-b557-0ca4-7416a9d818d5@gmx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 01:29:52PM +0000, Artem S. Tashkinov wrote:
> Hi,
> 
> I'm curious about the nature of this feature. Does it make restoring
> accidentally deleted files more difficult or even impossible? OK, data
> remains but the patch description makes it sound like all the metadata
> is being wiped completely.

It doesn't make any worse, but that's because ever since ext3 (e.g.,
since 2001), when we unlink a file, we endup zeroing i_blocks[] as
well as the indirect or extent tree blocks.  We *could* have fixed
this by special casing the path where the entire unlink fits inside
the current transaction, instead of always allowing for the
transaction to split across more than one transaction.

No one complained about the fact we were zero'ing the logical ->
physical block maps for two decades, by which I think we can assume
almost no one has tried used the "lsdel" + "link" hack in debugfs for
years and years.

> If it's the case, is it possible to make this new security feature user
> configurable? I'm OK with it being on by default but I'd be glad if
> there were a mount option to disable it.

We considered this, but given that all this would do is allow people
to recover the timestamps, user/group ownerships, etc., but not the
data blocks, it was deemed not to be worth the extra complexity.

If someone really wanted to allow undelete support, they could use the
various userspace solutions, or we *could* have an optional feature
which moves inodes whose link couint is about to go to zero into a
magic "trash can" directory, with some kind of automated auto-delete
mechanism when free blocks or free inodes all below some threshold, or
when free space falls below some threshold.  The trash can directory
would have to be readable only by root, in order to preserve security
when users delete files in a mode 0700 directory.  I'm not really
convinced it's worth it to implement such a thing, though....

	       	     	   	     	  - Ted
