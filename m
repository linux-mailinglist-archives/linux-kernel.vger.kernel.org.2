Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D046836463F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbhDSOg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:36:26 -0400
Received: from mout01.posteo.de ([185.67.36.65]:37135 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239842AbhDSOgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:36:24 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id AC653240029
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 16:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1618842952; bh=Q4FpEAfTUHaz0QL2Th9Hes8LqYTrL/RKsTEwI7exR10=;
        h=From:To:Cc:Cc:Subject:Date:From;
        b=Zulet0XVS9yE24s/RDNr/DTF4oUHAtBiGq1V3xO6h/1sw9nboeZFNRyMvkYhKQwXe
         Vb2Kb1A6Vw3GXSig+vB2RxpCx1d399FbBBPInDi4IvybHzvZaGqtXn4O7h38aXWRqF
         5/yyiBIvcKlTavX52bKcIJ6QrnZmUFjnZpGAGmpNV3SHHeoyBjfdTuD+8YhG2fSnUU
         5YNMaXbkLUB5sTLIXI5qr1epDUm7mvRZcZeuGJfxwIIV3GvIB5C7BDEq9Zmm4e3kcK
         Z8U3KeIvTSudlD9Mjt2kfxpdvVeQ+z9K1wXc1gRg75D/PuIP7p0k42C/WhKz3wrQ7J
         cMElHc70BRR9g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FP8WC51R4z6tmZ;
        Mon, 19 Apr 2021 16:35:51 +0200 (CEST)
From:   Alexander Egorenkov <egorenar@posteo.net>
To:     Christoph Hellwig <hch@infradead.org>,
        Alexander Egorenkov <egorenar-dev@posteo.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] lib: scatterlist: Fix SGL length in sg_split() if
 !CONFIG_NEED_SG_DMA_LENGTH
In-Reply-To: <20210419092325.GA3215674@infradead.org>
References: <20210418081441.5040-1-egorenar-dev@posteo.net>
 <20210419092325.GA3215674@infradead.org>
Date:   Mon, 19 Apr 2021 14:35:50 +0000
Message-ID: <87y2de4a0p.fsf@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Sun, Apr 18, 2021 at 08:14:41AM +0000, Alexander Egorenkov wrote:
>> If CONFIG_NEED_SG_DMA_LENGTH is NOT enabled then sg_dma_len() is an alias
>> for the length field in a SGL. In that case sg_split() wrongly resets
>> the length of split SGLs to zero after it was set correctly before.
>
> Why is this routine messing with sg_dma_address and
> sg_dma_lensg_dma_lensg_dma_len at all?  This whole sg_spli() routine
> seems rather dangerous because ownership and state of the DMA mapping is
> entirely unclear.

If i understood it correctly, then sg_split_phys() creates a new SGL
from the given one, so it makes sense to initialize DMA fields of the
new SGL. sg_split() allows one to split the given SGL into multiple ones
and the original one doesn't have to be dma-mapped which is indicated by the
parameter in_mapped_nents > 0.

Regards
Alex
