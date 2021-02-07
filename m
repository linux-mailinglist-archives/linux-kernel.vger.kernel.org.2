Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB40312499
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhBGOMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhBGOLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:11:47 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7A0C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:11:06 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id a8so18086051lfi.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s4WZ+XQ2gzSoSrd61MbApkvoEwH993k7eH2ccgmvEBs=;
        b=SLwO39e/colkQuF4viAXoO72fETD80UbjCemU3uAyTFLCuY5B58Ub6jSr745S6xJbG
         xR3t7kO9c/H/SeeGLjP23z4MFz+RML2B/VzhUijlLtuuK3gZ1cJyzW3Hc77lxpjedJNv
         Q0a2HfmY74qW7tOS+4VGQRYxR/rHCeCKQ3i/M5FnLh5Eh6pBOQ5JbMcPOoYuvFVFiK4O
         Zuh7eDnvUF70o/0lm0S/NUNKJv6LshS4prPO6f4+jy0scJUnXc4PRNSFYDNMeFndM5SG
         JUELsxUujdJeLQEEq90/KCAMsrMcc0XHHGBsq+FLRAIkU/8yCjUUDS4x+shNJnC3h5AZ
         ZMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s4WZ+XQ2gzSoSrd61MbApkvoEwH993k7eH2ccgmvEBs=;
        b=ss+VO9pzOTT+JIn5k+pJ5zCKy7OhHqJ713TwyhoMaYtJgNetx3UXUV8p7rVsL0b2mn
         o/O991U/WR1oavZHguUxSrXnMd2O+uJQ3echTqvhBFnGjNAuuz3xsH3M1HKxq9RKfUN+
         KhwoiWTucTlCKj/c5Rw9NjImJH5Hk3g001LxTmz/AEZ6nYrEPSsABdjQRnL48El0zoZ0
         JcddMCjYKQNzJu8y2xgYOdidtsw2Eg143ysbtF5VQ3ideVrDyJ96AQxP7kKISi74bc5h
         qYGIZc8mO39KWgc0mVlC9U8KDFEEIGWLN6e/7OPJeGWrOCWJIGrKWpdBYyoj0umAxSGc
         DdWg==
X-Gm-Message-State: AOAM533jQq5v3+068cLrF2wc1OS0XoB4RvKeItgTnNC20FQ5f4HCpM6I
        brz9J/rJAfjlXbjIGJ0RHj2Y2g==
X-Google-Smtp-Source: ABdhPJwMXw8/BIi1fzug5jfv2ICrED3bATc7yibBV1zlVwBkrGNJLHWYg9k/vE/YoMlg/YELc/CK3g==
X-Received: by 2002:ac2:4d45:: with SMTP id 5mr7950633lfp.135.1612707065193;
        Sun, 07 Feb 2021 06:11:05 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g17sm1741914lfb.30.2021.02.07.06.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:11:04 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6F8C7102656; Sun,  7 Feb 2021 17:11:04 +0300 (+03)
Date:   Sun, 7 Feb 2021 17:11:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/9] Linear Address Masking enabling
Message-ID: <20210207141104.ikxbdxhoisgqaoio@box>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
 <CACT4Y+bh1yaGLs5H3YTM6YLLtyWELvjWR7HcEk0pd9Nod9u4ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bh1yaGLs5H3YTM6YLLtyWELvjWR7HcEk0pd9Nod9u4ZQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 09:24:23AM +0100, Dmitry Vyukov wrote:
> On Fri, Feb 5, 2021 at 4:16 PM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > Linear Address Masking[1] (LAM) modifies the checking that is applied to
> > 64-bit linear addresses, allowing software to use of the untranslated
> > address bits for metadata.
> >
> > The patchset brings support for LAM for userspace addresses.
> >
> > The most sensitive part of enabling is change in tlb.c, where CR3 flags
> > get set. Please take a look that what I'm doing makes sense.
> >
> > The patchset is RFC quality and the code requires more testing before it
> > can be applied.
> >
> > The userspace API is not finalized yet. The patchset extends API used by
> > ARM64: PR_GET/SET_TAGGED_ADDR_CTRL. The API is adjusted to not imply ARM
> > TBI: it now allows to request a number of bits of metadata needed and
> > report where these bits are located in the address.
> >
> > There's an alternative proposal[2] for the API based on Intel CET
> > interface. Please let us know if you prefer one over another.
> >
> > The feature competes for bits with 5-level paging: LAM_U48 makes it
> > impossible to map anything about 47-bits. The patchset made these
> > capability mutually exclusive: whatever used first wins. LAM_U57 can be
> > combined with mappings above 47-bits.
> >
> > I include QEMU patch in case if somebody wants to play with the feature.
> 
> Exciting! Do you plan to send the QEMU patch to QEMU?

Sure. After more testing, once I'm sure it's conforming to the hardware.

-- 
 Kirill A. Shutemov
