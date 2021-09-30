Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B813941D21C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 06:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347960AbhI3EPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 00:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhI3EPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 00:15:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFA1C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 21:13:55 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g41so19641025lfv.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 21:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCgslGyMD4vV8m1wBT7SBnXJPk5xuhMWOzMpEIG+lrg=;
        b=JTwwbKKwPzFtHcO7quLBBhd7MU6gYxijUVtYyKPmkElLA80SuYqQit8fUtGTGsqWi1
         3nsqgLgei1KvFpWQvMlQhFAtiFzC1970PY9TthivXK6bHqVm+364XlLeJYV/sjK+JZwY
         AHXm8l7huKOgUgGJ4bDzkyEsgXQnMZHfMujfUMMIdy39p38lECrM9amJ0TdJvChgn/Y0
         6K1F+Gq96J1GHD9XvLNWwsMswIKK2/R0NHPu1Z4l405wfAvJK0/Tq+tupHQKUcbs1g77
         0953rzK2jUzUgr8lcXcQvioSBknUA4bfhkPnFnQz5svZ3MZu5myNRS8ys7Lr4A9XlDRW
         MDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCgslGyMD4vV8m1wBT7SBnXJPk5xuhMWOzMpEIG+lrg=;
        b=uwoHgsNS0zDyzjEcUGgC9YmHf5teVErpTBITQCztlP5Rw007IzHr0bOAvSu2N5GlAB
         +F4rOrNJ3aGT2QzB1+wG9NISxi9++nRCXFUH7fEK61E80nTQexZiNpvg/g1oaLEoo69d
         TFKm+MmK1Ms5grs/CqXH9giftazrQXxWXDbdFcvzvCi07K8r3PVjoJtV/6GjOfU402/2
         FgKlvFXekIvWtqr7V3c4sg3SH+OFUtlHaNqY+UX5AfEh8Br/2EHjb2OQ+iLaNn9Vh19Q
         k1HRRbV45AxRJaYcun06Kdp2BKgbbevTrJSpYWlzqE/zHwd/uXgikuHxqK+YNaQZDlCm
         v/9A==
X-Gm-Message-State: AOAM530K66f2QA1+omWDjY2080R7AzR0BNjbz8OWHCf9FkShhAkMPqFo
        Q/B0Wk4StERrhBHH2tLc7dehlIWfCb/F10Dfk7o+nw==
X-Google-Smtp-Source: ABdhPJzPNRlMJh16SzeBirF+lYxLI8X9nC5aPcFS8cLF0HRRQ+Qp0jqryEmEG4Y11utcllwBA4STBRTcsrhegZQwLOU=
X-Received: by 2002:a05:6512:2206:: with SMTP id h6mr3511444lfu.475.1632975234168;
 Wed, 29 Sep 2021 21:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210916231325.125533-1-pasha.tatashin@soleen.com> <20210929124900.GE21631@willie-the-truck>
In-Reply-To: <20210929124900.GE21631@willie-the-truck>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 30 Sep 2021 00:13:17 -0400
Message-ID: <CA+CK2bB+9LWNKYoFWpSTuJLEtf6Hcp7cBu95eLRAw3quoCucXw@mail.gmail.com>
Subject: Re: [PATCH v17 00/15] arm64: MMU enabled kexec relocation
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
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        madvenka@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 8:49 AM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Sep 16, 2021 at 07:13:10PM -0400, Pasha Tatashin wrote:
> > Changelog:
> > v17:
> >       - Merged with 5.15-rc1 as requested by Catalin Marinas
> >       - Added Tested-by: Pingfan Liu <piliu@redhat.com>
>
> This looks pretty good to me. I've left some minor comments on a few of the
> patches, but other than those I'd like to try getting these queued for
> 5.16.

Thanks Will, I will send the updated series tomorrow.

Pasha
