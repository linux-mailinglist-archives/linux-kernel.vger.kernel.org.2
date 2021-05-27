Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3C8392972
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhE0IYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235386AbhE0IX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:23:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C5C661248;
        Thu, 27 May 2021 08:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622103745;
        bh=SmqcZoGjvVySNErmmqJr2WJO0gKoHt1cpbNrwjdeUPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeGVgZ/TP3UIwcE3Ee0BwO/v82DYIKHouAMlpiIGCG0qiQ/FKADUtJlHCy3KPwCvx
         VZCtxDL9Ymp/Q/BDF1Z7p9juFmPLUQrA8W/7+i1/bnv2ddsYAz6CH4g6Og4geNAVEJ
         ZdhZwx3A2EK6/DtoLnN745z5IB9xl7U/VbxPgameMikESl0wj9uTAPlVTmLoCDzxbO
         TA9R8Jx+gP7zSonSItR9f5Kdx4dCSW4xRfyXq6iSW2m3TQHEo5oultMkJo+Zg28QXZ
         ekZ1gMQ6RZsLDKYnBozB1ou19J1Cq3NF8gagSTIy7sgsHkjjzJX+DZVl4p0BIDSRda
         knzcsWUT0dIFw==
Date:   Thu, 27 May 2021 09:22:20 +0100
From:   Will Deacon <will@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     fweisbec@gmail.com, john.stultz@linaro.org,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lorenzo@google.com, maz@kernel.org,
        mika.penttila@nextfour.com, sboyd@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 2/5] tick/broadcast: Split
 __tick_broadcast_oneshot_control() into a helper
Message-ID: <20210527082219.GA21311@willie-the-truck>
References: <20210524221818.15850-3-will@kernel.org>
 <c3573cd8-a4c8-43c2-be66-8b74d688a406@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3573cd8-a4c8-43c2-be66-8b74d688a406@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 03:23:06PM +0800, Xin Hao wrote:
>      I  had backport you  tick/broadcast: Prefer per-cpu relatives patches,
> 
> but i did not get the true result,  the Wakeup Devices are all null, why?

Probably because you don't have any suitable per-cpu timers to act as a
wakeup. Do you have a per-cpu timer registered with CLOCK_EVT_FEAT_PERCPU
and CLOCK_EVT_FEAT_ONESHOT but not CLOCK_EVT_FEAT_C3STOP?

Will
