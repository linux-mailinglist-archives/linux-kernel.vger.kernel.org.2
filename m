Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A662F3AD158
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 19:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhFRRls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 13:41:48 -0400
Received: from ms.lwn.net ([45.79.88.28]:46132 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231685AbhFRRlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:41:46 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DB69B740;
        Fri, 18 Jun 2021 17:39:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DB69B740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1624037971; bh=gsnYTTUNPq7lcsD/q70c06KXBhxh/NRTapjcVEE1M1Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SNRXGDBlEkKhChKV6q+keZ+5aN9HGHyi6ZKJplg7dqjm17XyugB2/4HiJXdrLjqpi
         BloPIlpoIIFG41flgCdqbZtU0l8SJR/0YvFbsYfNZjsKM2LatBvfJkCiDTuTRRPyjw
         g5xvXVqiZFWnZUgsa9uek+ydp36gG2HLKIgJUKsZLFzi/Q4Aw6vExB4Y7Z3K6/PDiu
         5lkOTfWAd8zGVChD7So1LJFTKvOo1EDMaeRIWWnNriyXbajEJTPpNffECDycsfcjyu
         FebPIx+P5xv1C769HmNM1luFmlXXV1bZqg8B1dclQBr+ci7NAsJh2d5j+yPAIiQUaf
         qoFXy2zfUmh/A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Fox Chen <foxhlchen@gmail.com>, neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, vegard.nossum@oracle.com,
        viro@zeniv.linux.org.uk, rdunlap@infradead.org,
        grandmaster@al2klimov.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 00/13] docs: path-lookup: Update pathlookup docs
In-Reply-To: <20210527091618.287093-1-foxhlchen@gmail.com>
References: <20210527091618.287093-1-foxhlchen@gmail.com>
Date:   Fri, 18 Jun 2021 11:39:30 -0600
Message-ID: <87sg1fqdgt.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fox Chen <foxhlchen@gmail.com> writes:

> The Path lookup is a very complex subject in VFS. The path-lookup
> document provides a very detailed guidance to help people understand
> how path lookup works in the kernel. This document was originally
> written based on three lwn articles five years ago. As times goes by,
> some of the content is outdated. This patchset is intended to update
> the document to make it more relevant to current codebase.

OK, I have applied this set.  I took the liberty of making the changes
suggested by Neil to patch 10.

Thanks for doing this work, and thanks to Neil for reviewing it!

jon
