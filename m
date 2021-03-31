Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF12634F5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhCaBLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbhCaBKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:45 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CAFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 18:10:45 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97Xv1V4Fz9t14; Wed, 31 Mar 2021 12:10:35 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>, mikey@neuling.org,
        mpe@ellerman.id.au, jniethe5@gmail.com,
        christophe.leroy@csgroup.eu, benh@kernel.crashing.org,
        alistair@popple.id.au, linux-kernel@vger.kernel.org,
        paulus@samba.org
Cc:     rdunlap@infradead.org
In-Reply-To: <20210224075547.763063-1-unixbhaskar@gmail.com>
References: <20210224075547.763063-1-unixbhaskar@gmail.com>
Subject: Re: [PATCH] arch: powerpc: kernel: Change droping to dropping in the file traps.c
Message-Id: <161715296517.226945.7681284090188409225.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:25 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 13:25:47 +0530, Bhaskar Chowdhury wrote:
> s/droping/dropping/

Applied to powerpc/next.

[1/1] arch: powerpc: kernel: Change droping to dropping in the file traps.c
      https://git.kernel.org/powerpc/c/5c4a4802b9ac8c1acdf2250fad3f8f2d6254f9c7

cheers
