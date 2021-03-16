Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5B233CC34
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhCPDkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233627AbhCPDka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:40:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53A2665032;
        Tue, 16 Mar 2021 03:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615866030;
        bh=pretoMF6po1nk+NT7gyGXA9S55q+uku6w7yTwK1xf/Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NZFnMQVNMSSz4RpJGtu9JUW2ZFeOXIMcZQ98XCWklJ2eQ/694pFYwTFNMJPA/gYjW
         jbHWX4gvnpG5K8ws46OobpFAj/C/rm2KpNsol2xGW2fU2gjooZrJ888EgpoxLm4MVF
         7iby38hREiCId8Hhr19WHWO+aEONv/lf6nz/Yoq0=
Date:   Mon, 15 Mar 2021 20:40:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yixun Lan <yixun.lan@gmail.com>
Cc:     Jiuyang Liu <liu@jiuyang.me>,
        Andrew Waterman <waterman@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Bug Fix for last patch
Message-Id: <20210315204028.95e8879c70581a3a7bee6a5d@linux-foundation.org>
In-Reply-To: <CALecT5iDxuzRPvPg8w=WmLT9XtWxOieDN=iRoY0nAdyhdLV+SQ@mail.gmail.com>
References: <20210310062250.74583-1-liu@jiuyang.me>
        <20210316015328.13516-1-liu@jiuyang.me>
        <CALecT5iDxuzRPvPg8w=WmLT9XtWxOieDN=iRoY0nAdyhdLV+SQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 03:15:05 +0000 Yixun Lan <yixun.lan@gmail.com> wrote:

> This patch title is  too obscure to parse, it should clearly reflect
> what's the changes doing here

Yes please ;)  Otherwise Andrew has to madly grep around to try to figure out
what was Jiuyang Liu's "last patch"!

