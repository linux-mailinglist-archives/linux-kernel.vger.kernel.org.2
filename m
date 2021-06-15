Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3732B3A868B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFOQe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:34:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36911 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229734AbhFOQey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:34:54 -0400
X-UUID: 7af019e29ada4594b051c74a4168e1bd-20210616
X-UUID: 7af019e29ada4594b051c74a4168e1bd-20210616
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1676544734; Wed, 16 Jun 2021 00:32:46 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 00:32:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 00:32:45 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <rostedt@goodmis.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <mhelsley@vmware.com>,
        <peterz@infradead.org>, <samitolvanen@google.com>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2] recordmcount: Correct st_shndx handling
Date:   Wed, 16 Jun 2021 00:32:45 +0800
Message-ID: <20210615163245.26164-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210615114229.3b1f2c5f@oasis.local.home>
References: <20210615114229.3b1f2c5f@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 15 Jun 2021 14:47:20 +0800
> Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
> 
> > One should only use st_shndx when >SHN_UNDEF and <SHN_LORESERVE. When
> > SHN_XINDEX, then use .symtab_shndx. Otherwise use 0.
> > 
> > This handles the case: st_shndx >= SHN_LORESERVE && st_shndx != SHN_XINDEX.
> > 
> > Reported-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> 
> Please explain the two signed-off-by's above. If you are just tweaking
> Peter's original patch, please add at the start:
> 
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> And then just above your signed off by, add what you changed:
> 
> Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> [ Changed something ]
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> 
> But state what you changed.
> 
> Thanks!
> 
> -- Steve

Sorry for messing up.
I've fixed it in v3.

Thanks for your comment.

