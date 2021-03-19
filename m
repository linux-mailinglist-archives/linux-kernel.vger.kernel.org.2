Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026A0341B3D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCSLPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhCSLPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:15:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E69C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:15:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t20so2800197plr.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bwrlumaJfTIwiW9TsH42Slpib5efojbyqoLfejKmUsg=;
        b=RW3DC0JK8dt4n8Mec4ZO6rbevL0xnbgPQf4VJ6c2GlfA+oJW3yZ1Ram5Lk42m0ORcL
         ogAMeBDbJ705SnUaAqGGHfBKtA6+zMm4781tPf6aRBfczw96SGYapYgfj1TavXPIU+nM
         Ap16lE6GZ66pW0oBvHivgpBG8KdUoXPegEMTgJJWKyDCPGHK3iInlmRVGvsEtkq4kVeh
         XFprTcnGDUbGQ8dR2mSqx8qAq3H+9/H0y/d3MJJgP+OFbfXkV4i0kPXSgMhVCdqsZnaM
         2AfJokSevp7dbw4zKbHFuI+1bTg7b4XSmbarDwS5LkL7XA14YhMVvLrAITYRUOawsdbh
         H1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bwrlumaJfTIwiW9TsH42Slpib5efojbyqoLfejKmUsg=;
        b=S9HodlJTFx2pP0cNOUsfoy7Zwa/kkIOQu0BQNe082/jQ84iLDggS9QhVVA/Db9eAwb
         m4bBT/SGW6BQYmHW5B+xGi/bvUbScQ+hmkAOQirqlIrkU/Mv3Msg8PZlS6ZoL8nYJ6Zc
         GKyHdusfl+/iJHV1M9MOBFTBkUO0itYI+RvmacsIjJzmx9dFCxQRzqg/BF6AWgxZe5yH
         MD0uTJyTp5+OBwFJp7nGPO0i+RCpOqCLX+YTr1CLdAWlA/zimZErPaH9LwAhsqtVtGtP
         c57uZ5L/zoKVh41Q7U/yZqzDDVkns8aHHHGnJv/MjFEWCi2Sfgq39FDigJN3JHbUCNmA
         BLbg==
X-Gm-Message-State: AOAM530u9esAfnnUv35LE9ym1q9N5MYmVVW/7yK1QMJJ3FygOaWz0wzC
        Hoz5vte6uRMvD3TtVXkV7EFzfYF1LEZrDcsEgTk=
X-Google-Smtp-Source: ABdhPJz28IpzLUtsVZsvEFGrybW4a1eKPH6bIbFWLbsgbvcCHbTcMFwIn+WonkzFeV/a2KKLLcqSlhX7p0/l5vNSNLw=
X-Received: by 2002:a17:902:ee02:b029:e6:5397:d79c with SMTP id
 z2-20020a170902ee02b02900e65397d79cmr9374494plb.21.1616152516853; Fri, 19 Mar
 2021 04:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210319110459.19966-1-a.fatoum@pengutronix.de> <20210319110459.19966-2-a.fatoum@pengutronix.de>
In-Reply-To: <20210319110459.19966-2-a.fatoum@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Mar 2021 13:15:01 +0200
Message-ID: <CAHp75VfMAaGTSvPC+_wvDcQFNwqvQwuf8erCPMteWyDpUOwcwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] driver core: add helper for deferred probe reason setting
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 1:05 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> We now have three places within the same file doing the same operation
> of freeing this pointer and setting it anew. A helper make this
> arguably easier to read, so add one.

> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

One thing: Suggested-by?

-- 
With Best Regards,
Andy Shevchenko
