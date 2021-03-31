Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5AF34F5F0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhCaBLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:11:08 -0400
Received: from ozlabs.org ([203.11.71.1]:42923 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233294AbhCaBKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:42 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97Xw5YgKz9svs; Wed, 31 Mar 2021 12:10:38 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
        jniethe5@gmail.com, benh@kernel.crashing.org,
        alistair@popple.id.au, linux-kernel@vger.kernel.org,
        paulus@samba.org
Cc:     rdunlap@infradead.org
In-Reply-To: <20210317090413.120891-1-unixbhaskar@gmail.com>
References: <20210317090413.120891-1-unixbhaskar@gmail.com>
Subject: Re: [PATCH] powerpc: kernel: Trivial typo fix in the file kgdb.c
Message-Id: <161715297909.226945.16053131712102580026.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:39 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 14:34:13 +0530, Bhaskar Chowdhury wrote:
> s/procesing/processing/

Applied to powerpc/next.

[1/1] powerpc: kernel: Trivial typo fix in the file kgdb.c
      https://git.kernel.org/powerpc/c/89f7d2927ae16ea470d29234447763826e40c6cf

cheers
