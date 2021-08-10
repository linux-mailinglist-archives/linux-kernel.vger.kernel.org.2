Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CE13E7DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 18:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhHJQu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 12:50:56 -0400
Received: from verein.lst.de ([213.95.11.211]:37064 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhHJQuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:50:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3938568B05; Tue, 10 Aug 2021 18:50:30 +0200 (CEST)
Date:   Tue, 10 Aug 2021 18:50:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Joel Becker <jlbec@evilplan.org>,
        linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Yanko Kaneti <yaneti@declera.com>
Subject: Re: [PATCH v4 3/3] configfs: Add unit tests
Message-ID: <20210810165029.GA20722@lst.de>
References: <20210805043503.20252-1-bvanassche@acm.org> <20210805043503.20252-4-bvanassche@acm.org> <20210809145953.GB21234@lst.de> <bcf5fd83-b30a-8887-361e-603821562d9a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcf5fd83-b30a-8887-361e-603821562d9a@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 11:31:23AM -0700, Bart Van Assche wrote:
> I can store this documentation in a new README, but isn't this something
> that has already been explained in
> Documentation/dev-tools/kunit/kunit-tool.rst?

So reference that.

> 
> >> +config CONFIGFS_KUNIT_TEST
> >> +	bool "Configfs Kunit test" if !KUNIT_ALL_TESTS
> >> +	depends on CONFIGFS_FS && KUNIT=y
> >> +	default KUNIT_ALL_TESTS
> > 
> > Why does it depend on KUNIT=y?  What is the issue with a modular KUNIT
> > build?
> 
> The unit tests calls do_mount(). do_mount() has not been exported and
> hence is not available to kernel modules. Hence the exclusion of KUNIT=m.

You should probably document that.  But then again this is another
big red flag that this code should live in userspace.

> > To me this sounds like userspace would be a better place for these
> > kinds of tests.
> 
> Splitting the code that can only be run from inside the kernel (creation
> of configfs attributes) and the code that can be run from user space and
> making sure that the two run in a coordinated fashion would involve a
> significant amount of work. I prefer to keep the current approach.

But userspace is the right place to do this kind of pathname
based file system I/O.

So for the current in-kernel approach:

Nacked-by: Christoph Hellwig <hch@lst.de>
