Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C471324E99
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 11:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhBYKw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 05:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbhBYKsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 05:48:31 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7ACC06178A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 02:47:47 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m1so4411507wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 02:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ntcKBESxFVyduoAY/dPjBxtnQO9pteJ/Wd6m2/ACihc=;
        b=CZf/YGKddhGVVe1DMJkkY2i0ywBaQyh9j5Ps+4eoOK4pyx73889nYyXjQ2j5o4kYOD
         6yc+KTpkfDaMzXLWM1EIxoD+uuNoDy79QIvWV0wg+gzpNENJycAQA8trhJNb9lzoTKhH
         1RVdxC1FCEbP0NEUp6BAR5SouVnBDQBHjXoe1zRaynZFDAh5LNlH01Hq1C3ermFExGBF
         cSBDesOdk0Roo/EgATMQkFSgqr40AlfDuHaL9fIVfgQSUFOkpKVIbwBj2coe9TFZmiaq
         EvME94oOIm//YmFOXhkH3PA5UzH+K1Bf643S3j/5JAzM7YoDys1kIaSnOrDzPnlqgg39
         2z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ntcKBESxFVyduoAY/dPjBxtnQO9pteJ/Wd6m2/ACihc=;
        b=f/WAPgFkOXZzwtTnmjbW1Gg+e2nWvGSqgBeZcaLqtDrOTH0PK8joy3QGkTV3+jU2Xo
         yndZXCNHJpFfbkmdDlTThWVGth2hRfchcclc+ltDRTwNghsjJbzjzIc5Lkf7EqrX174K
         G2ForwNakNnGfONercConXYPNuyFfJstKYGN6XOJJQp726BE6YfLj7gmB/3kzcQlihvu
         yrD6aFNUGW48AtJOw0cU4tQs5qvuAKws3ZkMyNSTSYxJacRMgYuqnkCmL0gp13iZPkye
         rU7mXElYncJqDAw/buPeNJKSi2FsBhELAdV/Om8yWh3AFa8n74+e9Hovxu+HDGBYnSz7
         lWGA==
X-Gm-Message-State: AOAM531oRoNXxa/ipFTzyn7C5DlY7/X+YtpzNUgZDkQai42FB6PzUO9Y
        wBmTsvZygxccXcTQ7ZYYd0Z3SLra7K7EYw==
X-Google-Smtp-Source: ABdhPJydhYQjpuk8jx4V1ehMhP9g4MgIJuBp/VmDpGOyeOXqMKpjjqh9XwwYrZZKTeBhxE9UwIe2Yw==
X-Received: by 2002:a05:600c:3588:: with SMTP id p8mr2602481wmq.71.1614250066000;
        Thu, 25 Feb 2021 02:47:46 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id l4sm7927850wrt.42.2021.02.25.02.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 02:47:45 -0800 (PST)
Date:   Thu, 25 Feb 2021 11:47:43 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the sparc tree
Message-ID: <YDeAT33QxlCuzLz+@Red>
References: <20210222190928.4f093646@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210222190928.4f093646@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Feb 22, 2021 at 07:09:28PM +1100, Stephen Rothwell a écrit :
> Hi all,
> 
> After merging the sparc tree, today's linux-next build (sparc64 defconfig)
> produced these warnings:
> 
> arch/sparc/configs/sparc64_defconfig:237:warning: override: reassigning to symbol ATA
> arch/sparc/configs/sparc64_defconfig:239:warning: override: reassigning to symbol HAPPYMEAL
> 
> Presumably introduced by commit
> 
>   520615e1f5b2 ("sparc64: switch defconfig from the legacy ide driver to libata")
> 
> or commit
> 
>   a57cdeb369ef ("sparc: sparc64_defconfig: add necessary configs for qemu")
> 
> -- 
> Cheers,
> Stephen Rothwell

Hello

Sorry, that's my fault for both warnings.
I send a patch fixing that.

Thanks for the report
Regards
