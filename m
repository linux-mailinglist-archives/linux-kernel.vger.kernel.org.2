Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4ED3F00DE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 11:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhHRJrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 05:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhHRJq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:46:58 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3BDC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 02:46:23 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4GqNMJ55L2zQk22;
        Wed, 18 Aug 2021 11:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:references:in-reply-to:message-id:from:from
        :date:date:received; s=mail20150812; t=1629279977; bh=y3cjBUivdB
        fl9Pwe7V7YDMMVAUHcTvLrWxhro0jESfc=; b=en0cAe/sUWJP58yslhwsNjJv7B
        Q2xdC72ps9Ti3ZEGDDf3Poa1DmzqkRQdFabT7XjLYVcb6Fu+IVf/eBXZNc4zyHPy
        tdvGUZeV3FJ8KVyLHMRm/4n1T9oiXBRGyDJXHKOaTVQrrBW3uL67FKjiQoy1V4EJ
        A+yzafiAxBLr7sHUgSeogpcvVO9O/REtreGRHNZ+xIdFcrGEcln7qcdOdWt/2Oyd
        gpar6lkg9wPl/hJ+kf0rZ0W0wCP/u4Yw548nPUYOdn0jMUtVYLxojwMkZxL0uQEI
        nR9ebBHHInf6GAzLBv8CP841k7w1nR+YLEulapIbzklEzkBBwLRzIJcPiN/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1629279978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pviwso17BFYUnD+xCSJlBHvvPfWSkT6kvM+T5S69UjQ=;
        b=xd1vsz8300/+7RWfYIubCh1OEtS5ePeRO3XDyMEedHQk+q3LegC5vABTCc6QeskHJ9EA3V
        QmF37ZZ2TmjzUt5kzTf0B+7iV3++i/Tecve2NyA07lUgpRcX+U3HpE3vKjW8BiYACrwwAS
        F/uf82fwABK7ro6IDTx9gJqmvbrfLW+o5fT1CfK3DhGJ0/1fyBlnsJELlaAka/KxDPAkO4
        nD2ksfRlFRGkzhhSrdEKzlTisHmi/pK62Jm9N+4IJNotLJtlDIgJvOqWgUqLDzzFk+jbPK
        ak4pH5mYY5tA+0Tjm6G2iWPykoy3FTm7/Gwhb1iSZQuvviDSDvK4NaSAOkRGAA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id dTcPzxAH41-V; Wed, 18 Aug 2021 11:46:17 +0200 (CEST)
Date:   Wed, 18 Aug 2021 11:46:16 +0200 (CEST)
From:   torvic9@mailbox.org
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Message-ID: <385024923.121081.1629279976794@office.mailbox.org>
In-Reply-To: <YRyyicOaNu/HDgJR@infradead.org>
References: <269701460.117528.1629210189833@office.mailbox.org>
 <YRyyicOaNu/HDgJR@infradead.org>
Subject: Re: [PATCH 1/2] x86, Makefile: Move the CPU-specific 64-bit tuning
 settings to arch/x86/Makefile.cpu
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: C994D18CE
X-Rspamd-UID: b2b398
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Christoph Hellwig <hch@infradead.org> hat am 18.08.2021 09:11 geschrieben:
> 
>  
> On Tue, Aug 17, 2021 at 04:23:09PM +0200, torvic9@mailbox.org wrote:
> > +# SPDX-License-Identifier: GPL-2.0
> > +# CPU tuning section (64-bit) - shared with UML.
> > +# Must change only cflags-y (or [yn]), not CFLAGS! That makes a difference for UML.
> 
> Plase avoid the overly long line.  Also having an empty line between the
> SPDX tag and the actual top of the file comment really helps readability.

It's a copy-paste from the existing Makefile_32.cpu, so I guess it has to
be changed there as well?
