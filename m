Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953D9323BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 13:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhBXMdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 07:33:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:56916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231569AbhBXMdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 07:33:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9814AADDD;
        Wed, 24 Feb 2021 12:32:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B654CDA7B0; Wed, 24 Feb 2021 13:30:49 +0100 (CET)
Date:   Wed, 24 Feb 2021 13:30:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>,
        David Sterba <dsterba@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [GIT PULL] Kmap conversions for 5.12
Message-ID: <20210224123049.GX1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ira Weiny <ira.weiny@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <cover.1614090658.git.dsterba@suse.com>
 <CAHk-=wijdojzo56FzYqE5TOYw2Vws7ik3LEMGj9SPQaJJ+Z73Q@mail.gmail.com>
 <20210223192506.GY3014244@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223192506.GY3014244@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 11:25:06AM -0800, Ira Weiny wrote:
> On Tue, Feb 23, 2021 at 09:13:42AM -0800, Linus Torvalds wrote:
> > On Tue, Feb 23, 2021 at 7:03 AM David Sterba <dsterba@suse.com> wrote:
[...]

> Sorry.  I will change it.

Let me know how you want to proceed with the patchset/pull request. I
can play the messenger again but now it seems a round of review is
needed and with some testing it'll be possible in some -rc. At that
point you may take the patches via the mm tree, unless Linus is ok with
a late pull.
