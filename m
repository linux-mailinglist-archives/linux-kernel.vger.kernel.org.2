Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7B63057F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbhA0KLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S314386AbhAZXG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 18:06:29 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B0DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 15:05:48 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id c6so98414ede.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 15:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6PiQYbYgUgTg0RMiFPjSBqako1R+SS8HmoxwDpu6YM=;
        b=a1cJwRUP95yDGlr3Lm7sNBrmZ+1ADmZ83+DpLSm77nn0Q9ztJ7PYwjroxx9LXX3TDy
         6TJwG13aY1eI5fsFmSDk5mSnrDnDqx5G3O12R7tVx1JdCd2gHcoB4oFQ4K6T0l0jt4zc
         E15K2WBeEsOXqAYoAd3IszXyafT5noum13Nb4zIFmLkjvbvFYyWtQhDKnFndWvnFfZLS
         i8f53JbKqWF1yiSNynPfkKs34CNpy4DPmN6IKFHD2j2hQv1IFGs6BydVRg3c0ps0D1AO
         +cKOADBE/uSmhTSwqDGFwZ2Sju6GJgwxfBTu3Y5IqNa9BGiJq5Zy10RlkNAaTwxOox8w
         8A4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6PiQYbYgUgTg0RMiFPjSBqako1R+SS8HmoxwDpu6YM=;
        b=cAM/vGfM3U1enCp4RNnmBz8+3u7syzp0vBqPZfhkEqtOOv0qN/Ca2HPcPQuDJvaNL+
         b83Gx+CNNRrIpx76HSxh1oxJ/+4nBSso5R/aLiSIzVjcKHHm5ogxeegz5MXmSbkZVwEW
         S3GowRKCB8DFRELiNR97ygYqAPinchBC1L7OOzOmLdqv+uydBlAyXTphl9HQS2BvFpBH
         IzATTlqYnAiwv/99mR7g3pmVH7gRIak2Jv5wv8jp9In/Bgtsr+Dkdeb1go+7qe57Wj1/
         QlcyP9jq1D5+RDlyPwImdnZWMLzcdnZl4a/pVjoqeTF94puey2kR4oO7XLfEWiPXXrwn
         6mOQ==
X-Gm-Message-State: AOAM532++JFgfvWNO1iaq8o7fAG+7zOztIdpxSgLxMZpQ33AZgHzaPsS
        Gz2+wXECAKd/GhB0CRFf9tDQvJwNypLYm4D57ChIig==
X-Google-Smtp-Source: ABdhPJyyaKUPO37QQcOBQNjTQEC0lZWIs2+YKkOXmPd8SE+2f31KBPS2GjTxfqGKaQtjyHNRLmEuNFQBVwhoQAqPLv8=
X-Received: by 2002:a50:934a:: with SMTP id n10mr6290752eda.26.1611702346626;
 Tue, 26 Jan 2021 15:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com> <20210126225847.GC30941@willie-the-truck>
In-Reply-To: <20210126225847.GC30941@willie-the-truck>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 26 Jan 2021 18:05:10 -0500
Message-ID: <CA+CK2bBT6OZwh_zSbhRDVAEptVMQGywV_E42iXS4YywGkqJQaQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/18] arm64: MMU enabled kexec relocation
To:     Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 5:58 PM Will Deacon <will@kernel.org> wrote:
>
> Hi Pavel,
>
> On Mon, Jan 25, 2021 at 02:19:05PM -0500, Pavel Tatashin wrote:
> > Changelog:
> > v10:
> >       - Addressed a lot of comments form James Morse and from  Marc Zyngier
> >       - Added review-by's
> >       - Synchronized with mainline
>
> This series has been doing the rounds for a while, but still isn't fully
> reviewed. Would it help if I merged, e.g. the first 12 patches to reduce the
> amount you have to repost?

Hi Will,

Yes, it would. The first 10 patches of this series were already merged
sometime ago:

a2c2e67923ec arm64: hibernate: add trans_pgd public functions
7ea4088938b7 arm64: hibernate: add PUD_SECT_RDONLY
13373f0e6580 arm64: hibernate: rename dst to page in create_safe_exec_page
a89d7ff933b0 arm64: hibernate: remove gotos as they are not needed
051a7a94aaa9 arm64: hibernate: use get_safe_page directly
d234332c2815 arm64: hibernate: pass the allocated pgdp to ttbr0
621516789ee6 arm64: kexec: make dtb_mem always enabled
3b54b743397e arm64: kexec: remove unnecessary debug prints
de68e4daea90 kexec: add machine_kexec_post_load()
d42cc530b18d kexec: quiet down kexec reboot

So, merging another ~12, would substantially help with getting
everything reviewed and merged.

Thank you,
Pavel

>
> Will
