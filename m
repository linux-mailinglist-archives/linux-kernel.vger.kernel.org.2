Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB7319ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 08:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhBLHoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 02:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhBLHn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 02:43:26 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8A1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 23:42:42 -0800 (PST)
Received: from localhost (kaktus.kanapka.ml [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 9209B98B165;
        Fri, 12 Feb 2021 08:42:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1613115754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bMTrgXz+EclRf8Nzne07lJpNQPGCITvy7cG07cDm6qc=;
        b=BXerbnRxtvZrdlHUNJn4gj2zuwSw1hEzSudfnsN6iGhsXVE/RMBpeVOIvrGmq5ZWGpvRwZ
        k36df/+K8+/CyJ5omMcHyjNep3pP2/J59guJ5ckyfeg3uniMjgh9M7KlOD51ibdor8B24/
        QmVrHu872QxzaJF6xeTwgjUW298Kmas=
Date:   Fri, 12 Feb 2021 08:42:34 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        "sjenning@linux.vnet.ibm.com" <sjenning@linux.vnet.ibm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: kernel BUG at mm/zswap.c:1275! (rc6 - git 61556703b610)
Message-ID: <20210212074234.vumx4odistyhbu4m@spock.localdomain>
References: <CABXGCsNEUpv9x93UeCa-wOjE0LgUdTCY2FTABJeFL=gGq4SX_g@mail.gmail.com>
 <2538f4c21dd2405aac2abb776047a0fa@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2538f4c21dd2405aac2abb776047a0fa@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Thu, Feb 11, 2021 at 10:43:18AM +0000, Song Bao Hua (Barry Song) wrote:
> Are you using zsmalloc? There is a known bug on the combination
> of zsmalloc and zswap, fixed by patches of tiantao:
> 
> mm: set the sleep_mapped to true for zbud and z3fold
> mm/zswap: fix variable 'entry' is uninitialized when used
> mm/zswap: fix potential memory leak
> mm/zswap: add the flag can_sleep_mapped
> 
> at Linux-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?qt=author&q=tiantao6%40hisilicon.com

Is this a future stable-5.11 material (and/or, potentially, older stable branches
as well)?

-- 
  Oleksandr Natalenko (post-factum)
