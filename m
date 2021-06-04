Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9528239BBC3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhFDP0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:26:46 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:47071 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFDP0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:26:45 -0400
Received: by mail-lf1-f45.google.com with SMTP id i9so14612236lfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ij2m//i2vBsvWVnhGZ0XX68OI3bOnqi+sqV2qYh6ilE=;
        b=0a0ckhenY104NwViOzux/nsF7MNxKyTmqDt4G3pYeg6N05gBAHLJ1e167QtHn+tanr
         l8jqrm/IaCj4GSXMxQ7nHM6w0q/WNVAK8h4GtYe7z8y2idNAJ6tXLaOFhy/DulQj2QRp
         DC2B8mE+JPu3LcDhNvivHczs3p0QQc3uTbyom6kOciHY5sRoMwEdQabF5td7wcD9qonk
         Xj5j+SAtQaGJsFdIzhQWJuD4sPLe0Fh8ecxyF70FaMeIkknYs4EkZr8M6uaUrwZ/UbIW
         pVwjp69OKq4ls0OmKT4wBQzA3BoUyebi02nVubEAtu2tBtr7NWntpSkAdXhkBDt62mVS
         WO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ij2m//i2vBsvWVnhGZ0XX68OI3bOnqi+sqV2qYh6ilE=;
        b=rLsgayhRu7RjyAzIFv64CTPlzMDmczf5t7oQ8m9ac+ZptDyzgxsBostryGBy6FdBDb
         TI+KJp5fKGVEKC+MYJ39jIUr2Wt/dVp9RHNYR9E9ZU5raCW4T7Mh7eEf3VTaRU8TqxZc
         Y+XEgZuqZAvGQVbn9hG5UP6GXlNXIctZwG63aH5xneddN98X5alWzL0TlPIY6AABo8Er
         KGBj3plUbqbXqt1OuNgGsBNjT4pCLoMDC/2IYkp79jSppKZ1I2WFs6eoml04Dj7cfFLd
         AdcFbGNep9WhEVF2ng4igh7UHAlXO9NqiblQucicUVDZB74UMHDFmmpvPlS3Ed5auvTX
         nw3w==
X-Gm-Message-State: AOAM531cD9RhDCKpHPZhQMDdZTmL/ma1XWT5N45b1gNJMLa948Kkl6/M
        0lCjWSit6GVGZf/Le60viebalA==
X-Google-Smtp-Source: ABdhPJy+REWo212Wm8EnBabZxH14h5sBHwmDpzuQ7H2pjbEiesqoXy6o5AY9mSz57y/2j7sa5NNzFg==
X-Received: by 2002:ac2:4899:: with SMTP id x25mr2636953lfc.372.1622820236389;
        Fri, 04 Jun 2021 08:23:56 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l15sm496245ljc.35.2021.06.04.08.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:23:55 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D566B1027A9; Fri,  4 Jun 2021 18:24:07 +0300 (+03)
Date:   Fri, 4 Jun 2021 18:24:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ming Lin <mlin@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Simon Ser <contact@emersion.fr>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: adds NOSIGBUS extension to mmap()
Message-ID: <20210604152407.ouchyfuxjvchfroe@box>
References: <1622792602-40459-1-git-send-email-mlin@kernel.org>
 <1622792602-40459-3-git-send-email-mlin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622792602-40459-3-git-send-email-mlin@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 12:43:22AM -0700, Ming Lin wrote:
> Adds new flag MAP_NOSIGBUS of mmap() to specify the behavior of
> "don't SIGBUS on fault". Right now, this flag is only allowed
> for private mapping.

That's not what your use case asks for.

SIGBUS can be generated for a number of reasons, not only on fault beyond
end-of-file. vmf_error() would convert any errno, except ENOMEM to
VM_FAULT_SIGBUS.

Do you want to ignore -EIO or -ENOSPC? I don't think so.

> For MAP_NOSIGBUS mapping, map in the zero page on read fault
> or fill a freshly allocated page with zeroes on write fault.

I don't like the resulting semantics: if you had a read fault beyond EOF
and got zero page, you will still see zero page even if the file grows.
Yes, it's allowed by POSIX for MAP_PRIVATE to get out-of-sync with the
file, but it's not what users used to.

It might be enough for the use case, but I would rather avoid one-user
features.

-- 
 Kirill A. Shutemov
