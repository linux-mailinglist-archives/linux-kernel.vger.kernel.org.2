Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A7334F5D9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhCaBKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhCaBKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:21 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB22C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 18:10:21 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97XW0qCZz9sXV; Wed, 31 Mar 2021 12:10:18 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     dingsenjie@163.com, mpe@ellerman.id.au, paulus@samba.org,
        benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dingsenjie <dingsenjie@yulong.com>
In-Reply-To: <20210326115356.12444-1-dingsenjie@163.com>
References: <20210326115356.12444-1-dingsenjie@163.com>
Subject: Re: [PATCH] powerpc: powernv: Remove unneeded variable: "rc"
Message-Id: <161715298149.226945.16845685799658420054.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:41 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021 19:53:56 +0800, dingsenjie@163.com wrote:
> Remove unneeded variable: "rc".

Applied to powerpc/next.

[1/1] powerpc: powernv: Remove unneeded variable: "rc"
      https://git.kernel.org/powerpc/c/69931cc387cca289e0415c79ce5389119670066d

cheers
