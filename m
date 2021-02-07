Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C952B3124D4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBGOtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhBGOtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:49:14 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48F8C061786
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:48:33 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id f19so13591508ljn.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qKrGjMsJ2R/wga9q4+pn/NmKvq5OElvJA2x+qTmkZTI=;
        b=uFaCoiDYN20xnwCUk4f532jwqC6NHEeSj3iq2X42NqbkSxSXgF4UNpAw/eTTnAKsmG
         3cSu3B5lQ5kV5Lv1zUCUqh4C4kdIXfIfqvscuf6wtuYRodzJYlE+bhucTCg9RScJX4Yv
         iR6yH5ifqPbeZKw2PqdtiINb33yYrnIq1/cEN9vhPjMiL0LkpL/dy1swGhS9RVrZYaPn
         skbZDQM0LsbP90lwZgZDjO+3ppk2WGN81f7AKv7P/hhZs9zClMc9I89QjwcJ9ACC+QWR
         dyLqBtjMf1EC3eYvl/zfcvQde2FIUscN8ZxCP25D+0umqiW4lmSn/fah7mV41rBrGS8d
         Zu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qKrGjMsJ2R/wga9q4+pn/NmKvq5OElvJA2x+qTmkZTI=;
        b=oytmFMts7d9lXghonSHD+m85btVdpi/5btIbK+iRI5Emk0MjauOH+RcbMgjbrrLVl2
         NiX2DU/QX626udXbybeN936PeDGpD52gV7pHBundN5wjDSkuDOZHw/GDJ36oW6LeJOzJ
         kLA3Yrhf15yGrkN43Cf7itNC4VkaQPgIYzEHMVf23eCNFIHs42sKvPOIXkFwCK63SImW
         y8civ8x7ibT2gKM4iBXrFpowTky1AxK7+r02g+wRnvV1XpxJrgyV3UY0VDimfGW63LUv
         EKlPUfA2Xm5NhYxHQ0G0u/4GggIZfi3cmCKxYKX23poaI5gBblszWc8xVlJXQuKOv7mg
         0zmg==
X-Gm-Message-State: AOAM531e+OBJAtCxTufAcaSB9taJOYbKhyHdj4563FTXoyZsl3JD7DNV
        W0ASjXoj+DfHr6aSfYhCTMMoRw==
X-Google-Smtp-Source: ABdhPJyCtIXWoN14cTukcsDy1HFKEGeNL4JqO5A+rU9fFhRMnBE6xpJR7Dxy2sxYNAq1EtXCwIuDqA==
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr8376986ljp.187.1612709312222;
        Sun, 07 Feb 2021 06:48:32 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i14sm1718244lfo.189.2021.02.07.06.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:48:31 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 370C2101B7A; Sun,  7 Feb 2021 17:48:31 +0300 (+03)
Date:   Sun, 7 Feb 2021 17:48:31 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Chris Down <chris@chrisdown.name>,
        Amir Goldstein <amir73il@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: Disallow CONFIG_TMPFS_INODE64 on s390
Message-ID: <20210207144831.lsrm74ypbz7i37uz@box>
References: <20210205230620.518245-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205230620.518245-1-seth.forshee@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 05:06:20PM -0600, Seth Forshee wrote:
> This feature requires ino_t be 64-bits, which is true for every
> 64-bit architecture but s390, so prevent this option from being
> selected there.

Quick grep suggests the same for alpha. Am I wrong?

-- 
 Kirill A. Shutemov
