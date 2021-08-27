Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539293FA008
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 21:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhH0TeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 15:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhH0TeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:34:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76CDC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 12:33:21 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j4so16511537lfg.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 12:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=noHCPSrtAkyzCrVsyQD6F8PSfdWl+QDD2xq/GV377n4=;
        b=OubElFYVmhZbc+A4cMbmNe0TfihA1IDFIUGNFFLF4+YO14gBPAxD7udrxkX02hDHv8
         AfKEsOmsIOPceXNppuc1+woLySYPcxqVPmdyCnzYp/DWgTgYZru2vKMDv0QdVLj5OUdo
         9eyfmRKJeFyRGIgCMVyovNvNTjyCKilmw7e2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noHCPSrtAkyzCrVsyQD6F8PSfdWl+QDD2xq/GV377n4=;
        b=FbjlqHy89JW9mR/B/V8ra6clBOiweJli5zVc7bk/+HvJNm1q+v1Ln47d7SNumaJSst
         18GQ4jnmwm6PhzJQgka8CAcpTH8Y5Jn9cHTmESfrxTDAXUOC6209JfqlKKVcdEw7RWbm
         vM+fl9ZnrnEqS2Uz3SY7YqdYLzKS1DwEBpaxkHcSa7R7JPAlnykMeEkJfSiaHJGDRIdN
         CNnbItrYYJhPp5+qDVSHVEjE9iDrCFmj/yiFekKYSXF3plaER6VHuD5bR0i6whvRTTsI
         Yg4HqSNSkwLhCEFV5Enq9Gy4pIfk7M4nmau5q30bLCKmzFbbL4CdGfMRMC0CaSqLG5ir
         X49Q==
X-Gm-Message-State: AOAM530qBv0ryYpj6fVni5dTZk2f5naVFoAGNOJulGb3hj6GndBwssch
        25YaBnsx8qEkgjnlFQeklsjaBHV7y04egGAQ
X-Google-Smtp-Source: ABdhPJzLhLWaS/O4EdUbVN1LctU5pnba+9PSqfUhIzPgwvbc+hY1oXqK/zmRXevzvWUWh73DePVYBA==
X-Received: by 2002:ac2:4e0a:: with SMTP id e10mr8167198lfr.66.1630092799565;
        Fri, 27 Aug 2021 12:33:19 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id u20sm782068ljl.76.2021.08.27.12.33.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 12:33:17 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id m4so13248354ljq.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 12:33:17 -0700 (PDT)
X-Received: by 2002:a05:651c:908:: with SMTP id e8mr8956231ljq.507.1630092796791;
 Fri, 27 Aug 2021 12:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-6-agruenba@redhat.com>
 <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk> <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
In-Reply-To: <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Aug 2021 12:33:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
Message-ID: <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
Subject: Re: [PATCH v7 05/19] iov_iter: Introduce fault_in_iov_iter_writeable
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 12:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Could you show the cases where "partial copy, so it's OK" behaviour would
> break anything?

Absolutely.

For example, i t would cause an infinite loop in
restore_fpregs_from_user() if the "buf" argument is a situation where
the first page is fine, but the next page is not.

Why? Because __restore_fpregs_from_user() would take a fault, but then
fault_in_pages_readable() (renamed) would succeed, so you'd just do
that "retry" forever and ever.

Probably there are a number of other places too. That was literally
the *first* place I looked at.

Seriously. The current semantics are "check the whole area".

THOSE MUST NOT CHANGE.

              Linus
