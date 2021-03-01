Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DA9327D9E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhCALv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbhCALvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:51:24 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC37C061794
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 03:50:02 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id d3so24961327lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 03:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3+UEhAxrb3pdEALJdsSgG5yRtHrbuB7y+oF/2tb+rtA=;
        b=O4xa6E4uEEU9hIiBa38slwGEphrxXrvJN4nNP7qNQl9R+N5t/ni0WCPfg9KGgv/PJS
         J4yoMROyYQjzho9NPt5Z875ScmJX4eIkCFOn+jGCOAAUpdSQ0gN9h79CHOsn8692dysT
         lVoes2J+BR3uVXXaJbapMzFRGpgZew7Je2hIRAEg0yK0NKBp0HxwcJb3BoSyUk1TLTOG
         yQHQZ0wqXVFRCdyjz3Dn8y0POBHrE8IWDFE0W3HtbLNj90D0m0vk+BfVQSeUl3SpBK3A
         tvG0P8V2cFA5/rFkEEgnC8Vu+6EFsaxuLn5Ynr88x7VC9BoPMrDoyzTn2rvNDQeIi8Zg
         s8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3+UEhAxrb3pdEALJdsSgG5yRtHrbuB7y+oF/2tb+rtA=;
        b=Lj5LvfeK7kgJNNuHjsWyk4cyGV60/OYpCgq+utT3PVl1T5IS0jPXNNiHQxYhYNHLNi
         wJx5/WjiXKNoHo2CrYYWcfehrHq85UiRLaySlfeLRdpI3krq6PmD82vegcTbKEQndpO4
         P4cY2n/ZzrslIKj+BqnGrgcePFEWx85Ra7G4yOLV57zrEfq8oLg9fWTXUNV2fDN5TwzF
         McphYVgBwBxSiz0KYL3jW0fkuos3S0BpcygV8mJX4E51q0+Ay3Hi7vedPaWsR7nbLjqi
         N4n7eqr2lcpdKL1uZ7LJceJSEzlU10EZyhjESxxFURBGU610IIcm0QmetTY/95LAiZ2U
         HR2g==
X-Gm-Message-State: AOAM533gSO0BzEGoTVXkToUPpkLbn8XPcenhtfJwO91zzwR9gpUecDp4
        fa46uccPR4S+bz03sbaWKWX8Jg==
X-Google-Smtp-Source: ABdhPJwh6c5qWPWg0F37ArphLQNHvLT3R9XMEvHVo+ZAItUpRqW7U1KzTIwnIJVSqj/jCJoTgiIE7A==
X-Received: by 2002:ac2:42cc:: with SMTP id n12mr8975485lfl.560.1614599400869;
        Mon, 01 Mar 2021 03:50:00 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z28sm1541471ljn.117.2021.03.01.03.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 03:50:00 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3DC06102557; Mon,  1 Mar 2021 14:50:07 +0300 (+03)
Date:   Mon, 1 Mar 2021 14:50:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yu Zhao <yuzhao@google.com>, akpm@linux-foundation.org,
        alex.shi@linux.alibaba.com, vbabka@suse.cz, guro@fb.com,
        hannes@cmpxchg.org, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH v2 3/3] mm: use PF_ONLY_HEAD for PG_active and
 PG_unevictable
Message-ID: <20210301115007.mgw5vthgjoibnjf4@box>
References: <20210224084807.2179942-1-yuzhao@google.com>
 <20210226091718.2927291-1-yuzhao@google.com>
 <20210226091718.2927291-4-yuzhao@google.com>
 <20210226121314.GB2723601@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226121314.GB2723601@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:13:14PM +0000, Matthew Wilcox wrote:
> On Fri, Feb 26, 2021 at 02:17:18AM -0700, Yu Zhao wrote:
> > All places but one test, set or clear PG_active and PG_unevictable on
> > small or head pages. Use compound_head() explicitly for that singleton
> > so the rest can rid of redundant compound_head().
> 
> How do you know it's only one place?  I really wish you'd work with me
> on folios.  They make the compiler prove that it's not a tail page.

+1 to this.

The problem with compound_head() is systemic and ad-hoc solution to few
page flags will only complicate the picture.

-- 
 Kirill A. Shutemov
