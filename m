Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551303ADC84
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 06:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhFTESg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 00:18:36 -0400
Received: from nautica.notk.org ([91.121.71.147]:40565 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhFTESe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 00:18:34 -0400
Received: by nautica.notk.org (Postfix, from userid 108)
        id A7740C01D; Sun, 20 Jun 2021 06:16:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1624162581; bh=wUAkVBtqwfhJ7JoQkwq9bvrQXDVb65OWrBZQsHRhhGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rw/Bq/90XsaB85pNFF1RD9+J7un4DGc7XizbsZd3aBHggPwXHshcIZWzugNdAKylH
         Tr+EyWKWltslAGOurmYpNJ7Igielcp4xVj1aIGxCG9lp52WRZX5WzacKICABnQ0tX1
         rPs+Tvu/CHR+1E1syZyn2ewaMjBJ3/2id9OFQFOSEHf7mct9MkPbVDDlAx2rU9iT2f
         OPGFd5VQTspFNOeft9kvS/3T6nZMGUuzcKLD14AmJh3H2JYaLqCQHoZGb7qShNl+MD
         mGAdag9jDPmKbZEHxtE7ttT2+5BoN19HiG8BKtpIlnYFBuq2kLvKyu5u47L1KaBBPv
         VZp/ysmXm2LWw==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 2B37CC009;
        Sun, 20 Jun 2021 06:16:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1624162581; bh=wUAkVBtqwfhJ7JoQkwq9bvrQXDVb65OWrBZQsHRhhGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rw/Bq/90XsaB85pNFF1RD9+J7un4DGc7XizbsZd3aBHggPwXHshcIZWzugNdAKylH
         Tr+EyWKWltslAGOurmYpNJ7Igielcp4xVj1aIGxCG9lp52WRZX5WzacKICABnQ0tX1
         rPs+Tvu/CHR+1E1syZyn2ewaMjBJ3/2id9OFQFOSEHf7mct9MkPbVDDlAx2rU9iT2f
         OPGFd5VQTspFNOeft9kvS/3T6nZMGUuzcKLD14AmJh3H2JYaLqCQHoZGb7qShNl+MD
         mGAdag9jDPmKbZEHxtE7ttT2+5BoN19HiG8BKtpIlnYFBuq2kLvKyu5u47L1KaBBPv
         VZp/ysmXm2LWw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id ed6bbf56;
        Sun, 20 Jun 2021 04:16:15 +0000 (UTC)
Date:   Sun, 20 Jun 2021 13:16:00 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v3 0/3] 9p: add support for root file systems
Message-ID: <YM7BAM5lK7NRVZ7n@codewreck.org>
References: <20210606230922.77268-1-changbin.du@gmail.com>
 <YMcaEq95T+1GxZz2@localhost>
 <YMca+N0UiGNZ1lSm@codewreck.org>
 <YMcfKqbCq7ZWAyaO@localhost>
 <20210620033659.s7rohai7dzwpgjur@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210620033659.s7rohai7dzwpgjur@mail.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changbin Du wrote on Sun, Jun 20, 2021 at 11:36:59AM +0800:
> The main problem is we lack a generic handing for non-block rootdev. I think
> maybe we can unify all of above.

We're already going in that direction, please have a look at the threads
on fsdevel:
(new patch by Christoph)
https://lore.kernel.org/linux-fsdevel/20210617153649.1886693-1-hch@lst.de/

(older threads I linked earlier)
https://lore.kernel.org/linux-fsdevel/20210608153524.GB504497@redhat.com/


I think it's getting there, Christoph should send a v2 addressing Vivek
remarks that will likely get picked up.
-- 
Dominique
