Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAF4367118
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244659AbhDURPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242773AbhDURPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:15:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3FFC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:14:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cq11so6619946edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i2gnFyBa30zVwz1K/L6S0r8solVsMJjfsMacMOrQKsU=;
        b=Ox+u8ztgX4f0xss71LqTRBYCI7/8RjrQJ/yjc9wkfY7wNCHyf23bwpjhlZT6iXcDXt
         HoqdyKMRyN0isaGQkW0HwC/rIXsMxw/pcLEX9PYAM0dMxEy1wGD/2n8j4jVXpkeTS6f8
         LO5oL8Ei5UDyNihL30C2zLpzTMz8/DHMaw29Xj6JKTBeTcwgqn3/RKEN0hj/akx4Su6t
         zWGxYHJtHSNYA4q05RLc/J4jJHtnT7dmKkKoZYdsplJPqyPGXtH6AoI9JaFjB4CCVLeO
         /wnHA2dQ8KNV4YPrau/DBrfXQckEFQdVmOwXCxgTazQWrV+LUIJi4d+0q8RcoyNfOhfn
         Hx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2gnFyBa30zVwz1K/L6S0r8solVsMJjfsMacMOrQKsU=;
        b=Ojpd+jgaAbSBpFYWoZxKFAVq9b4iBYv09K2f3It7alC1kPj0gCND110jYIM34234Zl
         TFYnKw/ei4tz/XZRKDzpYoK/UtHKpHuy3UrJcPPiZmyR1MwZ5Wt3QLYL0rtxxapVRLvk
         nHRyEWUaxyvhYsHe62gkksuK4kyvU0gqZf5rZUtbOTQBOj4DmoyWn5UZHqerc6n2zy9G
         1c9sIlzEuV9eGgXpQ2AICJMSEcPzXks7nVrSQLayYknbtDinTUlX59e4A6H9+Mi5XDC/
         HYRtvGvGPuXj6hfTZMjA+1kY9Uac1HW/BPDqEY9DrE9rXhSekeDMA0RhUyYCqJQGvEqw
         keIw==
X-Gm-Message-State: AOAM533aQw9G4w3Yv6UEwTCOEGWK6IPhWCPhL1LWDCnVESEfSOxG/0eu
        yxC+TJTgID1obGWAck6BLxZTSbPwhK/VfNLvxxWm
X-Google-Smtp-Source: ABdhPJyWgCO2IVv8Y/TetSy2LghoVNXm9TSh5duqoaz1Pvk67SkbzTNOEoTTLUGtfbGRE0pHTgch5D6kq/bKjkV/UyE=
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr38445644edb.135.1619025295842;
 Wed, 21 Apr 2021 10:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-86-gregkh@linuxfoundation.org> <CAHC9VhTvKeNFPsJadVK_i1+qaQBRSVfdWd+HC_EsgZx3coM8oA@mail.gmail.com>
 <20210421170257.GJ3141668@madcap2.tricolour.ca>
In-Reply-To: <20210421170257.GJ3141668@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 21 Apr 2021 13:14:44 -0400
Message-ID: <CAHC9VhRFtRSV4MudvOP+Hba0SbJxvk0Lt9rJJk-GvnRnjPDxOA@mail.gmail.com>
Subject: Re: [PATCH 085/190] Revert "audit: fix a memory leak bug"
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 1:03 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2021-04-21 12:18, Paul Moore wrote:
> > On Wed, Apr 21, 2021 at 9:04 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This reverts commit 70c4cf17e445264453bc5323db3e50aa0ac9e81f.
> > >
> > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > faith" to try to test the kernel community's ability to review "known
> > > malicious" changes.  The result of these submissions can be found in a
> > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > >
> > > Because of this, all submissions from this group must be reverted from
> > > the kernel tree and will need to be re-reviewed again to determine if
> > > they actually are a valid fix.  Until that work is complete, remove this
> > > change to ensure that no problems are being introduced into the
> > > codebase.
> > >
> > > Cc: Wenwen Wang <wang6495@umn.edu>
> > > Cc: Richard Guy Briggs <rgb@redhat.com>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  kernel/auditfilter.c | 12 +++++-------
> > >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > NACK on this revert.  I've looked at the original patch again this
> > morning, and the original patch still looks correct and doesn't appear
> > to introduce any new faults to the best of my understanding.
>
> Agreed.  Though on review, a much simpler fix to my original patch that
> caused this problem requiring this fix
>         e85322d21cfebeac64f58a204e9adc0bc5c1e46f rgb 2014-10-02 ("audit: cull redundancy in audit_rule_change")
> would have been the two-liner in the error path similar to the pattern
> in audit_data_to_entry() error path would have been:
>
>         if (entry->rule.tree)
>                 audit_put_tree(entry->rule.tree); /* that's the temporary one */

Given the situation this morning I think it is best to limit
discussion on this thread to just the safety of the patches in
question and the necessity of the reverts Greg is proposing here.  If
you have suggestions about how to clean-up or otherwise improve the
code relating to these patches I think it is better to have that
discussion in the appropriate subsystem list/forum/etc (as one would
do normally).

-- 
paul moore
www.paul-moore.com
