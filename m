Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEF83A4FBC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 18:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhFLQSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 12:18:50 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:40745 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhFLQSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 12:18:48 -0400
Received: by mail-pg1-f176.google.com with SMTP id j12so5051792pgh.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 09:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FIBH+1ri25R4Uf47pQvWLvTfi6oNPVbawYQKpiQ2b/A=;
        b=DeqTqzAAowohCmPiS8IGsqYIV4fl3weH6H3Aayb3mamD2WfIZaDoxzlkxl6BnIupGP
         z0EZpCZUdfXVaQu5C6ETuuG0g4Dyu1s59QURB10k1Qv410KqruM/aQQs7f3cv6iAtpP+
         O0XtfhZilEZMJ7DsoNIcJseodaozutKRR6n+kGLAxqatqJSgNj16hUSQ9PtjcA71Cra1
         apI09KFnEvciYpNuCM46vWeU5WBnfVk9zJZSroChKcWmD0hZACW6IddqOUck2k+9d3VV
         ebj9sjebAXjm1wTR4cai2uqtMyzZlRaBzEV5UcjplqKaSh/u9lGRRGGX8w486jXKarWC
         ToDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FIBH+1ri25R4Uf47pQvWLvTfi6oNPVbawYQKpiQ2b/A=;
        b=Tp6MdVAxhIgGMQrkXJYEvd7DncKRrwHjgCNjcNkndSlmlK5ZkXXI9xBS/Ak7OsNl1k
         47J0QuypwH9oRAjhIfyhP2D11IwvcVIhvtnIzt66mVx9FVfFBX6MboJM+zKcBNh/EU7m
         Ieqq6JGyQ8X6gkwmfjeyzIzXOLaTw+hbgSI0KA8LfRgulgL8ghSiRQUANoiqCdXV1oxB
         qBTEB7OVhuaNUHug2C5zgjU169mxJkwMg0dER5Lq7qr3QvIQSNA1KAToWjDyX2UG+ira
         Kx/5xELBEPfBxqs8GwFQciaJe95ymMRF6+uB5AHnPY9Pov6wLxcXLqa/D+KmAjQolR1e
         jLww==
X-Gm-Message-State: AOAM530TYVSZQFcLKmHgbT8Q5IgBrnpS/NZO6vFPTDsGWxZ+0Q6u8tPU
        hahV/oysTA3JqIzxTwv9uGoa0Q==
X-Google-Smtp-Source: ABdhPJyiBAGmfnUsIsMJ4Tosdz2bsA2gkBH/70GI6i/lfX2OyIy9PEWu7tVreMYcTWxjUnP/a7hjFQ==
X-Received: by 2002:a05:6a00:1629:b029:2ef:f4de:244f with SMTP id e9-20020a056a001629b02902eff4de244fmr13756636pfc.6.1623514548939;
        Sat, 12 Jun 2021 09:15:48 -0700 (PDT)
Received: from localhost (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id z6sm8706626pfr.99.2021.06.12.09.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 09:15:47 -0700 (PDT)
Date:   Sat, 12 Jun 2021 08:59:53 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        SoC Team <soc@kernel.org>,
        Romain Perier <romain.perier@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mohammed Billoo <mohammed.billoo@gmail.com>
Subject: Re: [GIT PULL] ARM: mstar for v5.14
Message-ID: <20210612155953.GA11724@lx2k>
References: <CAFr9PXkMSDvks+DeCNJ6iKf6zDH0VaOL6msirR3g2K7BNL8YkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXkMSDvks+DeCNJ6iKf6zDH0VaOL6msirR3g2K7BNL8YkQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jun 12, 2021 at 12:09:56PM +0900, Daniel Palmer wrote:
> Hi Arnd, Olof,
> 
> This is my first time doing this so apologies in advance if I've messed this up.
> Anyhow, we have two very small patches for 5.14.

Overall this is the right way to do it, but my tooling spotted a miss: You
didn't sign off on at least one of the patches you applied (the UART one). Make
sure you do 'git am -s' or similar so you have a S-o-b entry when you're the
one applying the patch.

Mind respinning the pull request with that corrected, so we avoid getting an
email from Stephen Rothwell about it too? :)

Beyond that, keeping an eye on how you sort patches when you have more
material: In particular we keep DT, soc, drivers and defconfig updates in
separate branches as much as we can -- sometimes dt-bindings need to be in both
DT and driver branches, for example. That doesn't apply to this pull request,
since the MAINTAINERS entry and the other one fix are fine to bundle (they
would end up in the 'soc' branch at our end).

We can tweak that over time as you get more familiar with how we separate
the streams of patches.


-Olof

