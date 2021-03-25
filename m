Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36919349358
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhCYNw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:52:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhCYNwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:52:17 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616680336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zdZuv5qViJW6TxpdwVe1meCCykhxshraNSFiUmJNMFo=;
        b=RFBnytgDMaeLc68XaRZma8Y2H0vlt+5RRHVJh+rdkJe6ypx1GgjWdPxHK80j3YPxNHSOdz
        z5smaBxvfpVUkBff2z/b8/0K8VDHNDs5VmzFFrpF3gIBAuN3IIA4h5UXrgylxSi09RUP5b
        DTSW78BAO++LCpeTzYZJ96HtU6kSDIq93wlvxL9Jfd+LTBAv+nMeL0bJtdvC8VSmr2rM5K
        GuxUX2NMVM1TykCLvkieNPpFVQdIhNSEEqqwwQHd8UEDKEZkIzfoBLhXx0I7/GpoNebPJd
        lZEjWMlLrPJVtv2I1B+lEY7SYB2qr+nBs6T6lNQrqNOW4vCcfiMFAfZ2HuzHNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616680336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zdZuv5qViJW6TxpdwVe1meCCykhxshraNSFiUmJNMFo=;
        b=CrSGauAmfnpk6Pnz0PQNYOVRhYeW8VLivbNZTV06PsSz3zcmN+i+qn8Rfmjxa/aHrap7Jb
        EwCam3yFz084A9BQ==
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH] genirq: Add missing IRQF_ONESHOT
In-Reply-To: <1616492321-72383-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1616492321-72383-1-git-send-email-yang.lee@linux.alibaba.com>
Date:   Thu, 25 Mar 2021 14:52:15 +0100
Message-ID: <87zgyrwdbk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23 2021 at 17:38, Yang Li wrote:
> fixed the following coccicheck:
> ./kernel/irq/manage.c:2193:8-28: ERROR: Threaded IRQ with no primary
> handler requested without IRQF_ONESHOT

This fixes nothing because it's for a nested thread and not relevant to
that check at all.

Thanks,

        tglx
