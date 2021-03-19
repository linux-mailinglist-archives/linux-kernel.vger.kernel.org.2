Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0153427E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCSVfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 17:35:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39770 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhCSVfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:35:47 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616189746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QwnwHShx2tUOjr98w82303iAsDkm4t4httyL6BTIGxI=;
        b=4NukqIPVGdxKwBmvWAjZ3/NRjNkG0SVBbBvfgwR00O8OchU5X2seJTIKqUSGBmi/Be9L4A
        dq8TRADfLQFa9AzZJZh0VGmftNk7z9PqN31wI7Od3ElmO5kIgd/NtDzXUqIYOZi97a5Maz
        mENk5jjC2QVmetz4jfjwlpaMs0n38OpN9GX7ZPJiyYGJkD+X0fA4c4OWTyhSAqTMhCgDI/
        vjfuHfaILXdcwXJbQhQAfMxLYeK8CxuPN7iY+v83EeR4kVns3LP2WbYjwGeflGVoBvpSXX
        QuQFYJbW+antd/QzV4/a7oE5GIZJ/x7rx2CGgMakVJAZUvtkhH6bO/BXw3BUhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616189746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QwnwHShx2tUOjr98w82303iAsDkm4t4httyL6BTIGxI=;
        b=w36eQstPZiJwQRwdBxbPgmKP8ijo9QKUntyzDUVEvm3foGRZl7maQqik5Nw4OAMHbXrvv+
        qwX3Q8JhlMbYw9Cw==
To:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v5 3/3] Documentation/admin-guide: Change doc for split_lock_detect parameter
In-Reply-To: <20210313054910.2503968-4-fenghua.yu@intel.com>
References: <20210313054910.2503968-1-fenghua.yu@intel.com> <20210313054910.2503968-4-fenghua.yu@intel.com>
Date:   Fri, 19 Mar 2021 22:35:46 +0100
Message-ID: <87y2ei4yj1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13 2021 at 05:49, Fenghua Yu wrote:
> +			ratelimit:N -
> +				  Set rate limit to N bus locks per second
> +				  for bus lock detection. 0 < N.
> +				  Only applied to non-root users.

Of course this does not mention that the limit is per UID and it neither
tells what the action is to rate limit the bus lock attempts. The rate
limit saturation which is induced by msleep() is not mentioned either.

Really useful for administrators.

Thanks,

        tglx
