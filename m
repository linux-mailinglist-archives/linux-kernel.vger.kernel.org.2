Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E85740D65A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbhIPJjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235524AbhIPJjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:39:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 334ED60F4A;
        Thu, 16 Sep 2021 09:37:43 +0000 (UTC)
Date:   Thu, 16 Sep 2021 10:37:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        madvenka@linux.microsoft.com
Subject: Re: [PATCH v16 00/15] arm64: MMU enabled kexec relocation
Message-ID: <YUMQZGLQl+82fL6G@arm.com>
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
 <20210824180555.GD623@arm.com>
 <CA+CK2bCakwsqS1RqXPJr+ewe=gsO98cOxhXye8-AcRLwtqhZ+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCakwsqS1RqXPJr+ewe=gsO98cOxhXye8-AcRLwtqhZ+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 11:03:21AM -0400, Pavel Tatashin wrote:
> On Tue, Aug 24, 2021 at 2:06 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > Enable MMU during kexec relocation in order to improve reboot performance.
> > >
> > > If kexec functionality is used for a fast system update, with a minimal
> > > downtime, the relocation of kernel + initramfs takes a significant portion
> > > of reboot.
> > >
> > > The reason for slow relocation is because it is done without MMU, and thus
> > > not benefiting from D-Cache.
> >
> > The performance improvements are indeed significant on some platforms
> > (going from 7s to ~40ms), so I think the merging the series is worth it.
> > Some general questions so I better understand the impact:
> >
> > - Is the kdump path affected in any way? IIUC that doesn't need any
> >   relocation but we should also make sure we don't create the additional
> >   page table unnecessarily (should keep as much memory intact as
> >   possible). Maybe that's already handled.
> 
> Because kdump does not need relocation, we do not reserve pages for
> the page table in the kdump reboot case. In fact, with this series,
> kdump reboot becomes more straightforward as we skip the relocation
> function entirely, and jump directly into the crash kernel (or
> purgatory if kexec tools loaded them).
> 
> > - What happens if trans_pgd_create_copy() fails to allocate memory. Does
> >   it fall back to an MMU-off relocation?
> 
> In case we are so low on memory that trans_pgd_create_copy() fails to
> allocate the linear map that uses the large pages (the size of the
> page table is tiny) the kexec fails during kexec load time (not during
> reboot time), as out of memory. The MMU enabled kexec reboot is always
> on, and we should not have several ways to do kexec reboot as it makes
> the kexec reboot unpredictable in terms of performance, and also prone
> to bugs by having a common MMU enabled path and less common path when
> we are low on memory which is never tested.

I think this makes sense, especially since it will fail during the kexec
load time rather than reboot.

I'm ok in principle with this series but I'd need to convince James
Morse to have a another look since he followed it more closely than me.
Could you please rebase it against 5.15-rc1?

Thanks.

-- 
Catalin
