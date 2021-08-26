Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CC53F90CA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 01:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243811AbhHZWoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 18:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhHZWoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 18:44:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B56C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 15:43:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630017806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zaxcLlJLTr76GS5oDmYB3m7tyL/z5KXErs/mVy30kmE=;
        b=io3QHODxF6R9uE6erVuKO5rNU4WeiLEyYwygckrQxRMU9JaFmjjjkKQW+WWyXE81LYbHf3
        pE8JZ1U3MW8MFqyFyozx3zHizH5lgzty62OaviBuOkuBwHbrx+BYxvQg3JcZHf/HyHcQhf
        OOzQeQMzHRy9s3uga/YGSoh/MJ/lxsx2xrlH5K4AbmoM2YShuIItW3zfDh84egpXEuaIkc
        N/xXYnf71qJuEPuhFjg+qfFG181Zkp746Nmu2ce6MscxPDjKwE6VC+4FIzRoR0PrPSQrgx
        ckUVopCwbZKssmQSyDPlSfDaldsNqhzMQDztUEXPMWFWl9y7DEm8YOEQoTi4pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630017806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zaxcLlJLTr76GS5oDmYB3m7tyL/z5KXErs/mVy30kmE=;
        b=hMKiaGiBMFJ73bCiN7A53Z54rcwVzwEDMTH8yme7fWN3ZpUSObgyES6XodxdckRnYs0lQA
        DgB8dbGJ1wtaWtCw==
To:     CGEL <cgel.zte@gmail.com>, Steve Wahl <steve.wahl@hpe.com>
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] x86:uv: fix boolreturn.cocci warnings
In-Reply-To: <20210824072124.61750-1-deng.changcheng@zte.com.cn>
References: <20210824072124.61750-1-deng.changcheng@zte.com.cn>
Date:   Fri, 27 Aug 2021 00:43:26 +0200
Message-ID: <87bl5j3jzl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24 2021 at 00:21, CGEL wrote:

This mail originates from: CGEL <cgel.zte@gmail.com>

which is not related to:

> From: Jing Yangyang <jing.yangyang@zte.com.cn>

Please ensure that the chain of origin is intact. See Documentation/process/*

Thanks

        tglx
