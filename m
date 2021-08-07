Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2CD3E3486
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhHGJyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:54:21 -0400
Received: from shark4.inbox.lv ([194.152.32.84]:37146 "EHLO shark4.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231608AbhHGJyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:54:11 -0400
Received: from shark4.inbox.lv (localhost [127.0.0.1])
        by shark4-out.inbox.lv (Postfix) with ESMTP id 7BBEBC00F0;
        Sat,  7 Aug 2021 12:53:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1628330033; bh=b9QJJlLw8GvxfiU+0PElRpMDjj48HHBXRImd/4ix3b8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=qztfYEMXepjFQR2U/5D26z2LE7/hVa7LWe5dzGBoOJZ/jDYUjwkONhvEGLzBFBb8r
         m94dwc7dMcHYTjkDkf49EHfSPmZNZ5POFx7vYMsNO3Q1O5i2FnUA+/64U+EhSSDHx6
         nq+uzYL+F6iQd47bCLqWUQxibqJVdrYz4OZ1SlYw=
Received: from localhost (localhost [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 6896BC00E7;
        Sat,  7 Aug 2021 12:53:53 +0300 (EEST)
Received: from shark4.inbox.lv ([127.0.0.1])
        by localhost (shark4.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id gKlXHTHMmq24; Sat,  7 Aug 2021 12:53:53 +0300 (EEST)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 3F487C00B7;
        Sat,  7 Aug 2021 12:53:53 +0300 (EEST)
Received: from mail.inbox.lv (unknown [79.105.9.99])
        (Authenticated sender: hakavlad@inbox.lv)
        by mail.inbox.lv (Postfix) with ESMTPA id 4D6C23E600B5;
        Sat,  7 Aug 2021 12:53:51 +0300 (EEST)
Date:   Sat, 7 Aug 2021 18:53:40 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/14] Multigenerational LRU Framework
Message-ID: <20210807185340.47d9f218@mail.inbox.lv>
In-Reply-To: <20210807075118.3BA0F6B006C@kanga.kvack.org>
References: <20210520065355.2736558-1-yuzhao@google.com>
        <20210728015926.1553-1-hdanton@sina.com>
        <20210807150459.294f8c03@mail.inbox.lv>
        <20210807075118.3BA0F6B006C@kanga.kvack.org>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: EZeEAiZdhQAmtce3NYVs4v3t2N+6SjhQsCPmvc49ixdF1MfMsth0c2aSE4LsHB4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>What was preventing you from solving the issues at linux-mm?

It was just more convenient for me.
But I agree that mailing lists are a better place. 
