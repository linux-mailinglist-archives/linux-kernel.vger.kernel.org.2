Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5AA31FF45
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 20:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhBSTPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 14:15:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhBSTPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 14:15:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D86DB64EB7;
        Fri, 19 Feb 2021 19:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613762082;
        bh=dpcbT77jfkOzIwpOHnf9SwWfg9htEnnplr/Lo9Hn0/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SoYwTAoOjSi/D9d1kM1mT4gSyO9zcBmJM2KLzNaXr1eOH/vPiu8dgC8i2FScqSTEW
         ssUoJzKmSeSvHoThhdICz1UA0Aoo7KYeVkfRNs+etaHnn7wUMSGKYhq7two3o4CW6/
         8xS+Pz44JRZ+hvzhPDFIEjF7rvGzsrGNaZT2pbGxtUz+0xfESHGomNgR6wKa4Vu/Su
         KMA95kSyKjAHPUDftHUh/dn5Le/QCvP5k7VpfgHU/NOWuvwxb0JKo7sAdfC7wDk68B
         s8Fyn3k8kzLnjNpdyXd9RjXf2ZFM/bUSz3uQkJuyEp4azaV7xH/hNuQK4jJ+BDrj7e
         W+4Yn3xP994iA==
Date:   Fri, 19 Feb 2021 19:14:37 +0000
From:   Will Deacon <will@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morse <james.morse@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>
Subject: Re: [PATCH 1/1] kexec: move machine_kexec_post_load() to public
 interface
Message-ID: <20210219191436.GA6683@willie-the-truck>
References: <20210215185908.257724-1-pasha.tatashin@soleen.com>
 <20210215185908.257724-2-pasha.tatashin@soleen.com>
 <20210219175341.GC6352@willie-the-truck>
 <CA+CK2bBpXyobT=rjVtY_pFhug4RcveGk_XB4zDBTX=vZBOkaLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBpXyobT=rjVtY_pFhug4RcveGk_XB4zDBTX=vZBOkaLw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 02:06:31PM -0500, Pavel Tatashin wrote:
> On Fri, Feb 19, 2021 at 12:53 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Mon, Feb 15, 2021 at 01:59:08PM -0500, Pavel Tatashin wrote:
> > > machine_kexec_post_load() is called after kexec load is finished. It must
> > > be declared in public header not in kexec_internal.h
> >
> > Could you provide a log of what goes wrong without this patch, please?
> >
> > > Reported-by: kernel test robot <lkp@intel.com>
> >
> > Do you have a link to the report, or did it not go to the list?
> 
> Hi Will,
> 
> https://lore.kernel.org/linux-arm-kernel/202102030727.gqTokACH-lkp@intel.com/
> 
> It is also linked in the cover letter.

Ah, great. Please add that as a Link: tag in the patch, and in-line the
compiler warning.

Will
