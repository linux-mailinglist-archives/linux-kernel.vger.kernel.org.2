Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAE63A71BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 00:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFNWHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 18:07:45 -0400
Received: from ms.lwn.net ([45.79.88.28]:50566 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhFNWHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 18:07:43 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A580777F;
        Mon, 14 Jun 2021 22:05:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A580777F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1623708339; bh=JXKxgVtyfym5ejRYyvNFxzLZwmC//wkp7N7U5xwVYYU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hOH0CGMtVkvSvFBvGZ8et5SCljtcnZQid985rqxNAqQE4DAr1e5GMOedUIhjwKPou
         n0urV4TG0vf8frq3KIvRk3USk/o3eLd1sIZxnJGcMsvB6cF5Qwu24KH/gLd4l3P9Xn
         kvdpoSoh+Xb4UTgjmqx/h1jnBhktPIJRgMgHl0lAJOgcgeJmgkXPMXH1BMxKWMuVVC
         wXlCMGnB9L5ABBz0RUZ+DK85rtEYT2jbzOPamTvQ0V3JZaExqwSiakzXBtEU5S/oA+
         51Jz4v+Ltqlospj/EVCeNxFWyBXISrDsRYSYdcH/faSNyUvFLKzo1LW2MqofheeEKZ
         uUb5Oydmbz1NQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Barry Song <song.bao.hua@hisilicon.com>, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        Tian Tao <tiantao6@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] docs: cputopology: move the sysfs ABI description to
 right place
In-Reply-To: <20210611052249.25776-1-song.bao.hua@hisilicon.com>
References: <20210611052249.25776-1-song.bao.hua@hisilicon.com>
Date:   Mon, 14 Jun 2021 16:05:39 -0600
Message-ID: <87a6ns14r0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Barry Song <song.bao.hua@hisilicon.com> writes:

> From: Tian Tao <tiantao6@hisilicon.com>
>
> Documentation/admin-guide/cputopology.rst is the wrong place to describe
> sysfs ABI. So move the cputopology ABI things to
> Documentation/ABI/stable/sysfs-devices-system-cpu and add a reference to
> ABI doc in Documentation/admin-guide/cputopology.rst.
>
> Link: https://lkml.kernel.org/r/20210319041618.14316-1-song.bao.hua@hisilicon.com
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Applied, thanks.

jon
