Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A133B3084DF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 06:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhA2FLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 00:11:00 -0500
Received: from verein.lst.de ([213.95.11.211]:59972 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231287AbhA2FK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 00:10:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9FA1568AFE; Fri, 29 Jan 2021 06:10:12 +0100 (CET)
Date:   Fri, 29 Jan 2021 06:10:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jessica Yu <jeyu@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        live-patching@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 04/13] module: use RCU to synchronize find_module
Message-ID: <20210129051012.GA2053@lst.de>
References: <20210128181421.2279-1-hch@lst.de> <20210128181421.2279-5-hch@lst.de> <874kj023bj.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kj023bj.fsf@manicouagan.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 05:50:56PM -0300, Thiago Jung Bauermann wrote:
> >  struct module *find_module(const char *name)
> >  {
> > -	module_assert_mutex();
> 
> Does it make sense to replace the assert above with the warn below (untested)?
> 
>      RCU_LOCKDEP_WARN(rcu_read_lock_sched_held());

One caller actually holds module_mutex still.  And find_module_all,
which implements the actual logic already asserts that either
module_mutex is held or rcu_read_lock, so I don't tink we need an
extra one here.
