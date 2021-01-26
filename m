Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBF3305597
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhA0IZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 03:25:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S316953AbhAZXMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 18:12:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 820182065C;
        Tue, 26 Jan 2021 23:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611702724;
        bh=rzeLAib+ucsQgm3JMS7ISQFoDi1VrBk0iP8v3x+v4bA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qedVMlQr7vt85JG4A2fw9jFiBIEmgMbckHyvDGYXTcNu6/bLHlvo1crV8muT4pJuy
         X48Acf1v4NsR5AqoWDyJFYVKnEeoWJBGjfGsWaEcLa4NyaWbPGtYAzD31usF9LqaXZ
         oZGgceH+GY65suYaGHKQxl2cpU/Fy08UIWX2dSl4Z+N7k1cZGwJfU3QurzLcwwpSN5
         XI21smmUE+0x754VG9BjViEVakV0AmLJPCPoPFYR7kQAyYcb3WN4NIHS1ly/o23oiB
         9XWolCB+SKcUvDHzkXBw0S99KzuGr1SO0GvaH4nD90oB/sSKj4Wanbke8hqTDx+qMN
         qMLLuWwYNEAUA==
Date:   Tue, 26 Jan 2021 23:11:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v10 00/18] arm64: MMU enabled kexec relocation
Message-ID: <20210126231157.GF30941@willie-the-truck>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
 <20210126225847.GC30941@willie-the-truck>
 <CA+CK2bBT6OZwh_zSbhRDVAEptVMQGywV_E42iXS4YywGkqJQaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBT6OZwh_zSbhRDVAEptVMQGywV_E42iXS4YywGkqJQaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 06:05:10PM -0500, Pavel Tatashin wrote:
> On Tue, Jan 26, 2021 at 5:58 PM Will Deacon <will@kernel.org> wrote:
> >
> > Hi Pavel,
> >
> > On Mon, Jan 25, 2021 at 02:19:05PM -0500, Pavel Tatashin wrote:
> > > Changelog:
> > > v10:
> > >       - Addressed a lot of comments form James Morse and from  Marc Zyngier
> > >       - Added review-by's
> > >       - Synchronized with mainline
> >
> > This series has been doing the rounds for a while, but still isn't fully
> > reviewed. Would it help if I merged, e.g. the first 12 patches to reduce the
> > amount you have to repost?
> 
> Hi Will,
> 
> Yes, it would. The first 10 patches of this series were already merged
> sometime ago:
> 
> a2c2e67923ec arm64: hibernate: add trans_pgd public functions
> 7ea4088938b7 arm64: hibernate: add PUD_SECT_RDONLY
> 13373f0e6580 arm64: hibernate: rename dst to page in create_safe_exec_page
> a89d7ff933b0 arm64: hibernate: remove gotos as they are not needed
> 051a7a94aaa9 arm64: hibernate: use get_safe_page directly
> d234332c2815 arm64: hibernate: pass the allocated pgdp to ttbr0
> 621516789ee6 arm64: kexec: make dtb_mem always enabled
> 3b54b743397e arm64: kexec: remove unnecessary debug prints
> de68e4daea90 kexec: add machine_kexec_post_load()
> d42cc530b18d kexec: quiet down kexec reboot
> 
> So, merging another ~12, would substantially help with getting
> everything reviewed and merged.

Ok, great; I'll have a crack at that tomorrow, and thanks for persevering.

Will
