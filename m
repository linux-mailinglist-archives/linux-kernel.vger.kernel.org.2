Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866CD41B278
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbhI1PBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241265AbhI1PBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:01:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C250FC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:59:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b20so94477308lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fInY95no8O0JEStBsdbpcymzt287B66Fcqaxhkug+c=;
        b=FfNByYfUegGHsII+I3f5TVFbSZkKQ34sMp4OH9feQ01FDoaO1JVJtg1jZ8hbAyyE3h
         +o/QtI4Gycrr4pn0Wb6Q9HuBgnVKu37zPHCYNw6PKfpAmVP4trKhCICqVexk61OjymcM
         ajE+rrWyYiEaYRePBmCieqMzw5ekh1Vxny2gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fInY95no8O0JEStBsdbpcymzt287B66Fcqaxhkug+c=;
        b=6lguyc1340/Pei7eE2J98NfSAPdXuulloFAxBtRIJeLRHNtnzym2Fm6Jp92RAbuvyb
         Vnxfq27PK80BkCcEE9ajwbQkTmdjEFN5qkWoS3JQuRYZpekvNCV8XxnfVC2NtdKVNTfs
         kJwyulQL42Am0gpfSajopZSsNvEhq2nQNlQoPTuq1NXSDn7gYyKbnqi8folWB/W2lX6j
         9llBi1XCFSMpv27Y8mqxKbqWcUaFiPnUHvfvBP1RyWljtH29+AZ6i/ty6VA5s3Tq0z6V
         vaS1d9RRMm0a090SRDh0WexkdVvjBHNtad5yA0rXYoDI5tADlgmKbLx/ohNx8v6huHvf
         ceoA==
X-Gm-Message-State: AOAM533aQd5shj0Rn0hwnnAAQuHfaKpW+cCPXiNCUwF5u/taUUUMzpkJ
        SyeJ0kZLTTSKBnCq62E6VZeU9J993c6TVDR1
X-Google-Smtp-Source: ABdhPJwZde0A/aOr+HLj9+ewPPeU09SRJnDaI3qCYzpG4iCWS90c1FNQBXEz5arePw+Y+V+jTqsZ/A==
X-Received: by 2002:a2e:5348:: with SMTP id t8mr416170ljd.310.1632841190793;
        Tue, 28 Sep 2021 07:59:50 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id p16sm2403729lji.75.2021.09.28.07.59.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 07:59:50 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id g41so93594040lfv.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:59:50 -0700 (PDT)
X-Received: by 2002:a2e:3309:: with SMTP id d9mr387530ljc.249.1632841188299;
 Tue, 28 Sep 2021 07:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <YVK0jzJ/lt97xowQ@sol.localdomain>
In-Reply-To: <YVK0jzJ/lt97xowQ@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Sep 2021 07:59:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibMN-Bixbu8zttUoV1ixoVRNk+jyAPEmsVdBe1GFoB5Q@mail.gmail.com>
Message-ID: <CAHk-=wibMN-Bixbu8zttUoV1ixoVRNk+jyAPEmsVdBe1GFoB5Q@mail.gmail.com>
Subject: Re: [GIT PULL] fsverity fix for 5.15-rc4
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Burkov <boris@bur.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 11:22 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Fix an integer overflow when computing the Merkle tree layout of
> extremely large files, exposed by btrfs adding support for fs-verity.

I wonder if 'i_size' should be u64. I'm not convinced people think
about 'loff_t' being signed - but while that's required for negative
lseek() offsets, I'm not sure it makes tons of sense for an inode
size.

Same goes for f_pos, for that matter.

But who knows what games people have played with magic numbers (ie
"-1") internally, or where they _want_ signed compares. So it's
certainly not some obvious trivial fix.

Pulled.

            Linus
