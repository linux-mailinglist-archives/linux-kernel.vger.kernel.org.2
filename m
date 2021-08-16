Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E473EDF44
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 23:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhHPVUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 17:20:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42370 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhHPVUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:20:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 725931FEF1;
        Mon, 16 Aug 2021 21:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629148805;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6G0aVCgmVmUP8HSXqqU/Wq0OX2gySeKiq/rD3SU+Os=;
        b=LsQwxfBZD9aHcCxyocnUUsx60iCfWshRWodRUvRhDEuYaX3ju+6Nr2ol+wgskJ41Y7tt8a
        /lefMRXI2LP2wWCTnyiSdOndSSssqbajxzrixiWVOhXd/CjGQWRDoQIMDBBJjTM5Oe67kl
        7V5BSomrX7msG3nAiAiJMpaMMDdqZl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629148805;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6G0aVCgmVmUP8HSXqqU/Wq0OX2gySeKiq/rD3SU+Os=;
        b=TcFVAitslLHp6XAuUXDCjuMNP+uWKIi8Mof1m6B3Tqf+uye5KiR8BJOOYaUs1OtZMDPzxz
        O85c4feIp6fjRSBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5DC08A3B87;
        Mon, 16 Aug 2021 21:20:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2E314DA72C; Mon, 16 Aug 2021 23:17:08 +0200 (CEST)
Date:   Mon, 16 Aug 2021 23:17:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        terrelln@fb.com
Subject: Re: [PATCH] lib/zstd: Fix bitwise vs logical operators
Message-ID: <20210816211708.GJ5047@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        terrelln@fb.com
References: <20210815004154.1781834-1-nathan@kernel.org>
 <20210816151450.GF5047@twin.jikos.cz>
 <bbb0a92c-4237-c651-3b8b-84dfaa2a2096@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbb0a92c-4237-c651-3b8b-84dfaa2a2096@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 09:53:53AM -0700, Nathan Chancellor wrote:
> On 8/16/2021 8:14 AM, David Sterba wrote:
> > You should CC Nick Terell for ZSTD patches, added.
> 
> Thanks for the info and adding him, I did not see an entry for lib/zstd/ 
> in MAINTAINERS and there is no consistent person picking up patches 
> according to git.

It's in an intermediate state [1], so far the compression algorithms
have been under the crypto subsystem because it's part of the API, but
regarding ZSTD, it's a bigger beast IMHO deserving an independent git
and merge flow, so I just noticed.

[1] https://lwn.net/ml/linux-kernel/20210430013157.747152-1-nickrterrell@gmail.com/
