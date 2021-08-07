Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0264D3E33B2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 08:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhHGGFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 02:05:31 -0400
Received: from shark4.inbox.lv ([194.152.32.84]:46894 "EHLO shark4.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhHGGFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 02:05:30 -0400
Received: from shark4.inbox.lv (localhost [127.0.0.1])
        by shark4-out.inbox.lv (Postfix) with ESMTP id 4A6CFC0110;
        Sat,  7 Aug 2021 09:05:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1628316312; bh=f2S77ZFHb3S8Vew7HR0sDAmkk5yqjYwL3+vHUusmMds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=MJw3Skp958h14uCP9uJ7TtVt69a0MmDsZn5q48v6SWwRbDTaqnFnujY3ieLt/7hb3
         hafsYSRYTtWktJoRUycgNAB1uJmhaIZEKZSqVyb4KpG24YCkcrhWVhb2q25/WxI/fr
         Pp5wpUg8UJ89m/hQEH/YyzqgsOIG9kJ/HGXz62BQ=
Received: from localhost (localhost [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 3DFA0C010F;
        Sat,  7 Aug 2021 09:05:12 +0300 (EEST)
Received: from shark4.inbox.lv ([127.0.0.1])
        by localhost (shark4.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 21cr4x_lvjEZ; Sat,  7 Aug 2021 09:05:12 +0300 (EEST)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 11B9AC010B;
        Sat,  7 Aug 2021 09:05:12 +0300 (EEST)
Received: from mail.inbox.lv (unknown [79.105.9.99])
        (Authenticated sender: hakavlad@inbox.lv)
        by mail.inbox.lv (Postfix) with ESMTPA id 0013E3E600B5;
        Sat,  7 Aug 2021 09:05:10 +0300 (EEST)
Date:   Sat, 7 Aug 2021 15:04:59 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] Multigenerational LRU Framework
Message-ID: <20210807150459.294f8c03@mail.inbox.lv>
In-Reply-To: <20210728015926.1553-1-hdanton@sina.com>
References: <20210520065355.2736558-1-yuzhao@google.com>
        <20210728015926.1553-1-hdanton@sina.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: EZqEIBwB4BlLv8mgKoRp+er6z9+vJSQu/Xi60t9D5HZF1MfMsth0c2aSE4LsHB4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Given no reply within two months

We are discussing mgLRU outside the mailing lists.
Some issues have been found, some have been resolved[1], some are still pending[2].

[1] https://github.com/zen-kernel/zen-kernel/issues/216
[2] https://github.com/zen-kernel/zen-kernel/issues/223
