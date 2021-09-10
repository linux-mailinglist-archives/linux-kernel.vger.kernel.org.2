Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583D3406A24
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhIJK3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 06:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhIJK33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 06:29:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA5EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 03:28:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631269697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VR6zh69FzEs75hbhDL45DDq7fQKJVjKaaM1XnceJubI=;
        b=vDDd2TVhCE/KEOplPzNZXjPgvqO7GyemDGQrztsNDCwrt7dlUPUrrDpuQpB+Ae2WB/Hz1H
        y6+x2WFX0tbsatTqAv9wjP5V9j36l6lf9FhwlaISfgtkyIOl8jyouU7oJJoK58wGh96koW
        x4szNN7Rt2Ym6HXciOBnqOtuAXIkY+CnocLHvx4N2jeEs09QTSrM0nFsO+SF8ILsBBgYjj
        9TtIE8MvPq/R+8DI1TUh9iSbzEfZ4W4YjTaPGl05GfWFxf5guTuivYtgaSInp6fX4l1Ynl
        rw4t1WmCkDaedgUKcobWgwhbY54PcqUZWkb14oAxWUVkUhIrGnx5g/1MTP21bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631269697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VR6zh69FzEs75hbhDL45DDq7fQKJVjKaaM1XnceJubI=;
        b=GO6bVNBWTA1IbOWx9QazCQUKN1TO0GwPc4ZkDoJRyy98tB8nQGTYiMVLA8Pm3aQ18PTFVX
        p3nSfL+PS8JnXYAg==
To:     Jiang Jiasheng <jiasheng@iscas.ac.cn>
Cc:     linux-kernel@vger.kernel.org, Jiang Jiasheng <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH 6/6] irq: Potentially 'offset out of size' bug
In-Reply-To: <1631244372-1817960-1-git-send-email-jiasheng@iscas.ac.cn>
References: <1631244372-1817960-1-git-send-email-jiasheng@iscas.ac.cn>
Date:   Fri, 10 Sep 2021 12:28:16 +0200
Message-ID: <87tuisd8sf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10 2021 at 03:26, Jiang Jiasheng wrote:
> The find_next_bit() use nr_irqs as size, and using it without
> any check might cause its returned value out of the size

Why exactly is this a problem? The return value has to be checked at the
call site anyway.

Thanks,

        tglx
