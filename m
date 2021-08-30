Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16993FBABD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbhH3RSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhH3RSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:18:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45608C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:18:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i6so22780683edu.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yq2NnWfX/L3UZWtDRa/mVDtutr6f9mOQULo0tH+HK5k=;
        b=SVnTMPhQavPzBT2AT7KLbcqxIsDg9bR5wwVJinRRrrO0bWldnmNsPlsRAAVOJI29IC
         j8jEi/MnBie9p+wmFJMQOv9Jtixt1EuumPqPoaIg5oHlg/PUKfZ8dh+TzHH9esKZnFZ4
         yC7dZHxV0QXsVF2svAgMo183j9e6AODNOxf50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yq2NnWfX/L3UZWtDRa/mVDtutr6f9mOQULo0tH+HK5k=;
        b=P6aqqSsNmGL/vDouXzk12dsyX1jZ8H7i7U6Chb4bVMAl7Zl4y3EFRu8iR4gIP8seZC
         G8Vg/Z4klRd8dVQmvHZbGlc2INorwk7ntZdQ35lcP18+1ONU3cjk5mtxuyyzP3AF8VU9
         DTr3AEkM8KM4lque+EbGF0sVfrT6ppzThYX0jLf13mdVJaw2q5MvlDByGYSonlopxBEe
         +N13PXQQIVniewae4OorAxb/2LM7RjnZW2dSjoEwzwiXjUDjUtOpyOo9/eac28CHwazP
         f3LJjgVR9zWjvsRpDVIBrcL1dk8xfQjW5jKIg/D6N5FBmRRgin4zkX5/sq0pOh0tKBmQ
         RT7g==
X-Gm-Message-State: AOAM533yaNCmnBSUxmVe8U85GwLvXS3Ro/QyAFy41b7huKMpEqy0OwEk
        ZEsMpXO3/+fj1EDwPbMns194FzHFcfJPpB8QwJ5fvl0qbipTlz+U
X-Google-Smtp-Source: ABdhPJyRVA6rVtbmIwBJ5KFt3z5h6+fx02ZkEN/jkGLBtNoRIhvRQKkPhoyR4ra3cK/9hhaHmOvYDNUqRTkqMmPIggg=
X-Received: by 2002:aa7:d947:: with SMTP id l7mr24995190eds.105.1630343878834;
 Mon, 30 Aug 2021 10:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210830125048.919B3D1B482@fitzroy.sirena.org.uk>
In-Reply-To: <20210830125048.919B3D1B482@fitzroy.sirena.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Aug 2021 10:17:48 -0700
Message-ID: <CAADWXX-FV-mkXfydPXZQ_h62sDD6-NKqcfkKNamWcNBP6qiJVA@mail.gmail.com>
Subject: Re: [GIT PULL] regmap updates for v5.15
To:     Mark Brown <broonie@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. Gmail has once again started hating you, Mark.

I think it's something personal. What have you done to piss off Google lately?

But more realistically, I think it's because of the DMARC failure:

        dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org

because your actual DKIM header says

  DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
d=sirena.org.uk; s=20170815-heliosphere; h=[...]

but then your From: line is

  From: Mark Brown <broonie@kernel.org>

so your 'd=sirena.org.uk' thing doesn't actually match the host that
will be tested (kernel.org).

Oh well.

I caught your pull requests in my spam-box this time, but..

              Linus

On Mon, Aug 30, 2021 at 5:50 AM Mark Brown <broonie@kernel.org> wrote:
>
> The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:
>
>   Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.15
