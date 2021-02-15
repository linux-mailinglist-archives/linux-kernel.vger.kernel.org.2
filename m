Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446DA31C279
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBOTbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhBOTbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:31:31 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D644C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:30:51 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id jj19so13117272ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxiR1WoWj9GLqb+ePEA+WtEnFI2j4eHKFsXpipKpgxM=;
        b=JQ1hu1pDBShq9ZJiN4qvnQMFVY+EZcb/Uyc3r0pIKJdLe+Es6BFcZvO+kQ88XfZcIO
         0vMejIWduLsOH4CyVxjG1/uB/5b+zV/id11vujkfp8afDTJCMucuJA4hmTgPqqEU3XLH
         xnml37igKv6E+M5bm1CJB4dC5x0cxXaE3j6mYOynmdzBXgp5n2KeXT4V20DE/qovu5bk
         KCrCWUoYBbbwt6hVNuD08PNrYC8iTjDyqoUdZf3eLs3y9NuDX6bdp5dAfDExVPj7GWuN
         /lpsT+Ma1l45fyzEDihaAImboBQeBobEkPtNiWGttTafajhigvUceqscEFGJjdYY1RgR
         DLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxiR1WoWj9GLqb+ePEA+WtEnFI2j4eHKFsXpipKpgxM=;
        b=aHRRmdcK/Hi/tPiEIJ91c0KKeDREod7T3FQWxvcxXXan0UJaNDoWwfjN/az7tXGt6w
         awniGL/GT5E2IgX6H4xaDJj7DPZgOsTgfC4UdtwLfW5d4Bc6fUJtFbx1AJLtU5wyW1Ix
         Egm//4pDqjkkCFC010SbIjRYh/6zeJbRbzDNJkfdfMTfP6nTlYwNTdKm6NkzbBsxqgqX
         6CfmEl1FUM0Wiiw01CZnwukwfY6jVe35EAaHKgPkuMmgmCTjLOne1/7l1Fhbt6Am5HVR
         AbrlaViWvghgNF5XyJRfmA4gD2ev9IpCaTMhnyOgjzqkcXkUcfDx3lq+PiM8+vDHrAv8
         ppRQ==
X-Gm-Message-State: AOAM530HYIl7rPXmUq0bjVdz7A3pfp9emw1BuKpZV0nSLKTjz0fHnaij
        7QUIwo+KGnxrIJR603Dr9yvnj6wQ7rTP3iVeyeDFJQ==
X-Google-Smtp-Source: ABdhPJyPCL6TJC2gNc7DODe1EIjIDra2NShX7mUuisIJb/VCfbgQL6ETyHhzUNp0n7JS/DZgRLAM+HV7IKzVVKiS/EU=
X-Received: by 2002:a17:906:43d7:: with SMTP id j23mr17038690ejn.519.1613417450162;
 Mon, 15 Feb 2021 11:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20210215192237.362706-1-pasha.tatashin@soleen.com>
 <20210215192237.362706-2-pasha.tatashin@soleen.com> <CAMj1kXGxyV0=s6jVZ674O_2amkYSnwSnubnozbzD6g6GOMJE-A@mail.gmail.com>
In-Reply-To: <CAMj1kXGxyV0=s6jVZ674O_2amkYSnwSnubnozbzD6g6GOMJE-A@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 15 Feb 2021 14:30:14 -0500
Message-ID: <CA+CK2bA7Xz0Zg5phsQi3mhnp+_PHLAAGRLgFTQNw1FjBHaXsHA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: mm: correct the inside linear map
 boundaries during hotplug check
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can't we simply use signed arithmetic here? This expression works fine
> if the quantities are all interpreted as s64 instead of u64

I was thinking about that, but I do not like the idea of using sign
arithmetics for physical addresses. Also, I am worried that someone in
the future will unknowingly change it to unsigns or to phys_addr_t. It
is safer to have start explicitly set to 0 in case of wrap.
