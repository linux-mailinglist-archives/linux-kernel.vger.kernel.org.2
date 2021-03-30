Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A775D34E802
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhC3Myb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhC3Mx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:53:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71E4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 05:53:56 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617108833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HovNnXOvf87YphAb7PaCuGrmHgtJNPK/NE/NvcrUXDU=;
        b=KIZj2rlKNd53apa/ZP5xacUIkard0Mkfe8WaQI5bypzZwD22IE+HJFk+IFJuo3tWQYJKs/
        J0LUSQt3mnFgYaAbN3Ul2bNY8yeaQlSk8xe9vfv3a+LKCWco2A+fYpXtdxXhl4GpcCphMd
        5bZa3sswCBAroane+VlWZ7be2LQ/IBlN9P8G2iJJ6MkHTXT85r5IrLMyn0TlfBrRYCyHfM
        6wx5ldkpdsSiii3nL2uUwUAJ61IC5tUX5HYYOscJX3jBvGeENAREg+ebhF0G10122QstRL
        b/Mw4ro9NUxYZFsft1fnlbd9sVrLGv1GNBehCXelH+i0Br1cch1E7OL0VPLVHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617108833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HovNnXOvf87YphAb7PaCuGrmHgtJNPK/NE/NvcrUXDU=;
        b=KI4JzJmghy3mC3rZcwjsM5uhEENWs1XYpnmxo5/WYG0B/8+MRLbWe3xfxdXmpu5WhloLzH
        oGXQ+58XhvYUmTDg==
To:     Petr Mladek <pmladek@suse.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] kernel/printk.c: Fixed mundane typos
In-Reply-To: <YGMevQvltf/LnJP1@alley>
References: <20210328043932.8310-1-unixbhaskar@gmail.com> <YGMevQvltf/LnJP1@alley>
Date:   Tue, 30 Mar 2021 14:53:52 +0200
Message-ID: <87mtuk4xb3.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-30, Petr Mladek <pmladek@suse.com> wrote:
> On Sun 2021-03-28 10:09:32, Bhaskar Chowdhury wrote:
>> 
>> s/sempahore/semaphore/
>> s/exacly/exactly/
>> s/unregistred/unregistered/
>> s/interation/iteration/
>> 
>> 
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> John,
>
> it conflicts with the patchset removing printk safe buffers[1].
> Would you prefer to queue this into the patchset?
> Or should I push it into printk/linux.git, printk-rework and you would
> base v2 on top of it?

Go ahead and push it to printk-rework. I'll base v2 on top of it.

Thanks.

John
