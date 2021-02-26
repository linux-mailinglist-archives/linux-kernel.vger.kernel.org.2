Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155613268BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 21:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhBZU2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 15:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhBZUSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:18:36 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8419C0611C2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:17:31 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c23so6041629edr.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=y9tnX4xQQ5Op8Hxcrn5nj7mki8AFmTwG2wBetASTk5U=;
        b=guDAnlYANU+HERicwhxAFjdQDQ9JEaPbygYx1saC9hXfoR22j+QWWhhY3uKP8X4IDl
         Zesdhs3qiiL5P8OtOOhS0+Qndf9//6NBdHToDCPmxvCAijBl/OKhmGg1gmhpsJX/JQId
         AuSXowhjlDjm4rTzBDacNiAmDcl3/JWuvc8MttWPrXvjA6UTJ4m8VYoktfRzCTSDI9Zn
         z21h5ScqRrQ4hTG7hlckLqpExHYaxKPNSwdyRBB5dLvInfHPojX93z78IUNQOZK8dXp/
         UQzQttdZqg/O8fXppOGsZ+PGss8+77zsjZYqvmZx6VBr/Wb1SlUhm48vlZe7rzMNiQJ+
         eQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=y9tnX4xQQ5Op8Hxcrn5nj7mki8AFmTwG2wBetASTk5U=;
        b=tJpclSEqvKgDvigRCcWRc5Yl/egmejWBTyqJP8hTWhnZbTIqESx6TvMPwJ9xbLo7jd
         jzeEX0xfBul+fipbySpy6wyn40PsC3nlbv9J+smp2xA3kdAboJ0smuCc5OtB79PDu2JV
         vB/07e2pQtSqfnI3fX37MPHSQCOGrxF6XxCAHnj4otWyatM0wG2kRfamuoM0bjvqx1zg
         O4Zn5ITyYdX/OUEVv6PQ3c6joqUdJ/QWjL53bm1PXCUupm4LwFQWa6W+aDztL4TAp/E9
         +zwXaZ9JbIDSwC7LJvksCurLX2LmZpOdyEDwfdj7qGq33hsADGEvuFmmpLrasBTKvDDl
         U8ow==
X-Gm-Message-State: AOAM531PkLjs0gSXFxZ9vrn1O0WsZVnzQ6/6p/4zdLr9RfxM/lbUxuoq
        AjL/Plw9nHFmZ39xBgyk0dDVOWS+aQ==
X-Google-Smtp-Source: ABdhPJzIH5PRON6qqB3jZqJGxwI2Nsdr0YO4G7CHsq3OmL3zXh8DqSy3QgRX5FeUd0hjRK4qkilFaQ==
X-Received: by 2002:a05:6402:1c86:: with SMTP id cy6mr4129060edb.276.1614370650511;
        Fri, 26 Feb 2021 12:17:30 -0800 (PST)
Received: from localhost.localdomain ([46.53.253.104])
        by smtp.gmail.com with ESMTPSA id fw3sm1792731ejb.82.2021.02.26.12.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 12:17:30 -0800 (PST)
Date:   Fri, 26 Feb 2021 23:17:28 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: #pragma once (was Re: incoming)
Message-ID: <YDlXWHkYntoO4fk0@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:

> I'm hoping to just do -rc1 this weekend after all - despite my late
> start due to loss of power for several days.
> 
> I'll allow late stragglers with good reason through, but the fewer of
> those there are, the better, of course.

I want to sent treewide "#pragma once" conversion:

	18092 files changed, 18883 insertions(+), 99841 deletions(-)

ideally it is done as 1 commit avoiding my death by thousand cuts of
going through all of maintainers.

There may be a compile failure or two but the list of exceptions is
stable.

Opinions? :-)
