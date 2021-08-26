Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829703F8AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242891AbhHZPEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhHZPEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:04:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3F6C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:03:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r19so5070017eds.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OwtqZp7lWqd2vwEBK7L5PvPKeHrWj5OjXlmVatWvPOM=;
        b=cNWIagbUZDoFGnXK7TtDjGs9zO7JRumnGFIPd880wcM4Lvs6RPsj+bHXbynR2FLa0X
         x1bL5HtOTYZijAnIH/6ywH6XCLZIYuVHiVKHgL8uV7hixXMhPx2MbkHIqso152OXUN3Q
         6Zh+PEZ1u0JcITJTyu4hlhzcRIhBxcMsAmksU28urSX1hsx15rMzK3U5oS0FHco+hgR5
         cX4Pm8kPJuEnSC8lm3T3kI/JCaUsxRSv0aQzAZHsmowT3BW4TJQdb8HY7Otasb9x74HZ
         PRSGndcCY/06Q5YOLjXHBErcF5iJgtKDtEDDNRc181FuDX8WyOYU5Zn2xRnahg2B5p3A
         bsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwtqZp7lWqd2vwEBK7L5PvPKeHrWj5OjXlmVatWvPOM=;
        b=IG4iR0GZZc9m+pbURqk5bcEvTAirxKh6dv37IJmUattI2oUrMvWDTrqjffi6mBDZ+O
         qdbFjsNXGPsgB4p5hRGiFEceg1eLo1wfJhjNL+oVVzQxRssMoA8cvhfdeeal7P2Sp15z
         rIyeu6N07UfqPYmq6bODaXlggzwmmopPOt+fpVIEOzPeVJa4t/nRXppXcF7cqaHx3CHL
         lNPe+d4HQ14iFx+aL+dTCyXiDOwfEF2/x8TuZgdp8IeCQA2EcC0We59hHrQqar/2BohR
         4pS5Pnrj5ZK2SuNrpE19RWQIHFrtGi/vMcl08FJhiZUFpH1EyxWgMbh/8h8nUXmCx4Cz
         oZYg==
X-Gm-Message-State: AOAM5327W2gjJkywnX9PiyeO7lQ22E6n2LqXcoIUt8adP+/rHcPrmCl3
        WmnT3h4RIEsTbXDM9OLCdS+Cfi2RkzKr1aOtijLGDw==
X-Google-Smtp-Source: ABdhPJxANtB4gX1t0qr2yCN+wvu9UWxcg8PM/6H9AVoTinfsvI1BNU9GqgvyCPlc5cLOm7EqXa/VMVpYynzX1MANJSI=
X-Received: by 2002:a05:6402:34d5:: with SMTP id w21mr4858514edc.210.1629990238081;
 Thu, 26 Aug 2021 08:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210802215408.804942-1-pasha.tatashin@soleen.com> <20210824180555.GD623@arm.com>
In-Reply-To: <20210824180555.GD623@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 26 Aug 2021 11:03:21 -0400
Message-ID: <CA+CK2bCakwsqS1RqXPJr+ewe=gsO98cOxhXye8-AcRLwtqhZ+g@mail.gmail.com>
Subject: Re: [PATCH v16 00/15] arm64: MMU enabled kexec relocation
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 2:06 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Pavel,
>
> This series is still missing reviews from those who understand kexec
> better than me.

Hi Catalin,

Yes, I am looking for reviewers.

>
> On Mon, Aug 02, 2021 at 05:53:53PM -0400, Pavel Tatashin wrote:
> > Enable MMU during kexec relocation in order to improve reboot performance.
> >
> > If kexec functionality is used for a fast system update, with a minimal
> > downtime, the relocation of kernel + initramfs takes a significant portion
> > of reboot.
> >
> > The reason for slow relocation is because it is done without MMU, and thus
> > not benefiting from D-Cache.
>
> The performance improvements are indeed significant on some platforms
> (going from 7s to ~40ms), so I think the merging the series is worth it.
> Some general questions so I better understand the impact:
>
> - Is the kdump path affected in any way? IIUC that doesn't need any
>   relocation but we should also make sure we don't create the additional
>   page table unnecessarily (should keep as much memory intact as
>   possible). Maybe that's already handled.

Because kdump does not need relocation, we do not reserve pages for
the page table in the kdump reboot case. In fact, with this series,
kdump reboot becomes more straightforward as we skip the relocation
function entirely, and jump directly into the crash kernel (or
purgatory if kexec tools loaded them).

>
> - What happens if trans_pgd_create_copy() fails to allocate memory. Does
>   it fall back to an MMU-off relocation?

In case we are so low on memory that trans_pgd_create_copy() fails to
allocate the linear map that uses the large pages (the size of the
page table is tiny) the kexec fails during kexec load time (not during
reboot time), as out of memory. The MMU enabled kexec reboot is always
on, and we should not have several ways to do kexec reboot as it makes
the kexec reboot unpredictable in terms of performance, and also prone
to bugs by having a common MMU enabled path and less common path when
we are low on memory which is never tested.

>
> And I presume this series does not introduce any changes to the kexec
> tools ABI.

Correct.

Thanks for taking a look at this series.

Pasha
