Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7D2366FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbhDUQTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbhDUQTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:19:30 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F342C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:18:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s15so50081772edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylabI7yel8trfiw05+8kfE4gsMq9DsV89TTz7H0mBd4=;
        b=SwLJaGpPLtubReINVzZzoWVROzzwBu7D3g0d7StyTVDnq3cS/jTgMrZklC1rtnAfIJ
         I1NtrQwMsXKsB7O6l0w6BobwTe+J6V2eALIjXVy+DBpFRzVJBNkwYZZrhHIjKL8/0WFL
         Xg7jgr0yS8iCGqxANmUPLzPwRLaORmZOEmoUr1VDcTHIz/cK+rF4MGWq7WDqvPgbYEJS
         ci15cpv8c6UrFqFq8CS5BkvPNYL54rGjZoBDVeTeBc1i3b1lwj23nZMN6CthAlVaUn8+
         bQzZSld8I8O7N560e6m9J1V5SxaSwzKEnXkiQhjTy6Fq2F2ZTyQycEXiZ8aIaz6lYOcx
         9gGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylabI7yel8trfiw05+8kfE4gsMq9DsV89TTz7H0mBd4=;
        b=ErRX+hNdPS8bc23hQdLfsrwgaTJVN6XnT7d/OTtXKY1mI77/ovvs+YueIHqKDxUh3D
         vpFqsHmxOhLA3FWfAbdVMtZ/1AAn8irvLhL9hXGIX4fpgPJCIOnq1WsHhUpMsOm9qMUH
         XOhxRntruo65t/YYA4NJNtTVcgO5nfjl6Odo5J34vKu2jt+UN/QUESGNYKvPQ5OAIija
         arQr8I+GoZ/DBJKKb7t3tHizostupajKPGOi72CNxozQy9zSR7DBv1/bG30dh7zgcBMV
         l239KOu9ESvpewqhPzdxcb5Yc1ZXQhcqfKi9m/QOQ7IR4KeaRlMFhMw/hYw5JJUN0q5N
         X4iA==
X-Gm-Message-State: AOAM530qWxHlf25oz+JUcJmILnyo8nBWG/nQX1WJXvT9mpWlpaCmFE1k
        FVhOod11J5vE1Iq2oTxMnM4JFPJv2fp7QoaYCQlu
X-Google-Smtp-Source: ABdhPJwe2K3xdo/wYDUajrSKOQC+ZfSGOOTnvAWJ3Q4TE+mRT3v4LP5OjTWk8dOB6gRk7KryePjRjm28w5JAaJLwAvE=
X-Received: by 2002:a05:6402:199:: with SMTP id r25mr31401269edv.128.1619021935361;
 Wed, 21 Apr 2021 09:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <20210421130105.1226686-86-gregkh@linuxfoundation.org>
In-Reply-To: <20210421130105.1226686-86-gregkh@linuxfoundation.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 21 Apr 2021 12:18:44 -0400
Message-ID: <CAHC9VhTvKeNFPsJadVK_i1+qaQBRSVfdWd+HC_EsgZx3coM8oA@mail.gmail.com>
Subject: Re: [PATCH 085/190] Revert "audit: fix a memory leak bug"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 9:04 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This reverts commit 70c4cf17e445264453bc5323db3e50aa0ac9e81f.
>
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
>
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
>
> Cc: Wenwen Wang <wang6495@umn.edu>
> Cc: Richard Guy Briggs <rgb@redhat.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  kernel/auditfilter.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

NACK on this revert.  I've looked at the original patch again this
morning, and the original patch still looks correct and doesn't appear
to introduce any new faults to the best of my understanding.

> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 333b3bcfc545..19f908b96000 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1125,24 +1125,22 @@ int audit_rule_change(int type, int seq, void *data, size_t datasz)
>         int err = 0;
>         struct audit_entry *entry;
>
> +       entry = audit_data_to_entry(data, datasz);
> +       if (IS_ERR(entry))
> +               return PTR_ERR(entry);
> +
>         switch (type) {
>         case AUDIT_ADD_RULE:
> -               entry = audit_data_to_entry(data, datasz);
> -               if (IS_ERR(entry))
> -                       return PTR_ERR(entry);
>                 err = audit_add_rule(entry);
>                 audit_log_rule_change("add_rule", &entry->rule, !err);
>                 break;
>         case AUDIT_DEL_RULE:
> -               entry = audit_data_to_entry(data, datasz);
> -               if (IS_ERR(entry))
> -                       return PTR_ERR(entry);
>                 err = audit_del_rule(entry);
>                 audit_log_rule_change("remove_rule", &entry->rule, !err);
>                 break;
>         default:
> +               err = -EINVAL;
>                 WARN_ON(1);
> -               return -EINVAL;
>         }
>
>         if (err || type == AUDIT_DEL_RULE) {
> --
> 2.31.1

-- 
paul moore
www.paul-moore.com
